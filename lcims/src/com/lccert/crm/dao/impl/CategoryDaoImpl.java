package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.CategoryDao;
/***
 *品牌列表的现实类
 * @author tangzp
 *
 */
public class CategoryDaoImpl implements CategoryDao {

	public Map<String, String> getAllCategory(int classId) {
		/**
		 * 获得品牌列表
		 * @return
		 */
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			Map<String, String> map = new HashMap<String,String>();
			String sql = "select * from t_category where vclass = ?";
			try {
				conn = DB.getConn();
				
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, classId);
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
