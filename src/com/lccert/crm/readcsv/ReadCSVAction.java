package com.lccert.crm.readcsv;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.user.UserForm;
/***
 *  读取CSV的文件
 * @author tangzp
 *
 */
public class ReadCSVAction {
	/**
	 * 读取CSV的文件并且添加到数据中
	 * 
	 * @param user
	 * @return
	 */
	public boolean addCSV(ReadCSVForm csv) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into attend_duty(USER_ID,REGISTER_TIME) values(?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, csv.getUserId());
			pstmt.setTimestamp(2, new Timestamp(csv.getRegisterTime().getTime()));
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

	//根据用户名查询他的用户id
	public String getUserId(String name){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "select USER_ID from user where USER_NAME = ?";
		String userid ="";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userid=rs.getString("USER_ID");
			}
			conn.commit();
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
			DB.close(conn);
		}
		return userid;
	}
	
	
}
