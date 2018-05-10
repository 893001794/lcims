package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.ArticleDao;
import com.lccert.crm.vo.Article;

public class ArticleDaoImpl implements ArticleDao {
	/**
	 * 获得物品列表
	 * @return
	 */

	public Map<String, String> getAllArticle() {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			Map<String, String> map = new HashMap<String,String>();
			String sql = "select  * from t_article where parent !=0";
			try {
				conn = DB.getConn();
				pstmt = DB.prepareStatement(conn, sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("vname");
					map.put(id + "", name);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs);
				DB.close(pstmt);
				DB.close(conn);
			}
			return map;
		}

	public String getNameById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String articleName="";
		String sql = "select  * from t_article where id=?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				articleName = rs.getString("vname");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return articleName;
	}

	public boolean addArticle(Article article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "insert into t_article(vname,parent) values(?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,article.getName());
			pstmt.setInt(2,article.getParentid());
//			System.out.println(article.getName());
//			System.out.println(article.getParentid());
			pstmt.executeUpdate();
//			rs = pstmt.getGeneratedKeys();  //getGeneratedKeys自动获取主键的方法
//			rs.next();
//			key= rs.getInt(1);
//			conn.commit();
			isok = true;
		} catch (SQLException e) {
			isok = false;
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			//DB.close(rs);
			DB.close(conn);
		}
		return isok;
	}

	public Map<String, String> getAllParenArticle() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select  * from t_article where parent =0";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("vname");
				map.put(id + "", name);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
}
