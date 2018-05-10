package com.lccert.crm.quotation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;
import com.lccert.crm.vo.EdmQuoitem;

public class EdmQuotationAction {
	private static EdmQuotationAction instance = null;

	private EdmQuotationAction() {

	}

	public synchronized static EdmQuotationAction getInstance() {
		if (instance == null) {
			instance = new EdmQuotationAction();
		}
		return instance;
	}

	
	/**
	 * ÃÌº””√ªß
	 * 
	 * @param user
	 * @return
	 */
	public boolean addQuotation(EdmQuoitem qi) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_edm_quoitem(vpid,userid,projectid,etype)values(?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,qi.getPid());
			pstmt.setString(2, qi.getUserid());
			pstmt.setInt(3, qi.getProjectid());
			pstmt.setString(4,qi.getType());
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
