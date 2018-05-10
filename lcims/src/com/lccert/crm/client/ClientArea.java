package com.lccert.crm.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;

/**
 * �ͻ���������������
 * @author Eason
 *
 */
public class ClientArea {

	private static ClientArea instance = null;

	private ClientArea() {

	}

	//ʵ����һ������
	public static ClientArea getInstance() {
		if (instance == null) {
			instance = new ClientArea();
		}
		return instance;
	}

	/**
	 * ȡ�����пͻ������б�
	 * @return
	 */
	public List<AreaForm> getArea() {
		List<AreaForm> list = new ArrayList<AreaForm>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_client_area order by id";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AreaForm af = new AreaForm();
				af.setCity(rs.getString("city"));
				af.setCode(rs.getString("code"));
				list.add(af);
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}

	/**
	 * ���ݳ���ȡ������
	 * @param city
	 * @return
	 */
	public synchronized String getAreaCode(String city) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String code = "";
		String sql = "select * from t_client_area where city = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, city);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				code = rs.getString("code");
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return code;
	}

}
