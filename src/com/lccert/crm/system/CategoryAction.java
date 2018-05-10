package com.lccert.crm.system;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
/***
 * 公告类的action类
 * @author tangzp
 *
 */
public class CategoryAction {
	private static CategoryAction instance = null;

	private CategoryAction() {

	}
	
	public synchronized static CategoryAction getInstance() {
		if (instance == null) {
			instance = new CategoryAction();
		}
		return instance;
	}
	
	/**
	 * 获得所有公告类别
	 * @serialData 2010-8-28
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public  List getCategory() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList ();
//		String sql = "select * from t_system where 1=1  order by createtime desc " + "limit "
//				+ (pageNo - 1) * pageSize + ", " + pageSize;
		String sql = "select * from t_system_category" ;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				 Category cate =new Category();
				 cate.setId(rs.getInt("id"));
				 cate.setName(rs.getString("name"));
				 list.add(cate);
			}
		
			conn.commit();
		} catch (SQLException e) {
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
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	
	public boolean addCategory(Category cate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_system_category(name) values(?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, cate.getName());
			pstmt.executeUpdate();

			conn.commit();
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
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
}
