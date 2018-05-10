package com.lccert.crm.chemistry.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class DynamicData {
	
	/**
	 * 取得部门信息
	 * @return
	 */
	public Map<String,String> getDept() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_dept";
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
	
	/**
	 * 取得类别
	 * @return
	 */
	public String getItem() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer str = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String sql = "select * from t_item order by id";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			str.append("({'Items':[");
			while (rs.next()) {
				int id = rs.getInt("id");
				int parentId = rs.getInt("parentid");
				String name = rs.getString("name");
				temp.append("{'name':'" + name + "','topid':'" + parentId + "','colid':'" + id + "','value':'" + id + "','fun':function(){}},");
			}
			str.append(temp.substring(0, temp.length()-1));
			str.append("]})");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return str.toString();
	}
	
	/**
	 * 取得类别
	 * @return
	 */
	public String getItemById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String str = null;
		String sql = "select * from t_item where id = " + id;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				str = rs.getString("name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return str;
	}

}
