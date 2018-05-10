package com.lccert.crm.report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.lccert.crm.chemistry.util.DB;

/**
 * 报告模板管理工具类
 * @author Eason
 *
 */
public class ReportAction {
	
	private static ReportAction instance = new ReportAction();

	private ReportAction() {}

	public static ReportAction getInstance() {
		return instance;
	}
	
	/**
	 * 根据报告文件夹ID查找报告word模板
	 * @param parentid
	 * @return
	 */
	public List<ReportForm> getReportListByParentid(int parentid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReportForm rf = null;
		List<ReportForm> list = new ArrayList<ReportForm>();
		String sql = "select * from t_report_moduel where fileid = ? and tag = 'y'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, parentid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rf = new ReportForm();
				rf.setId(rs.getInt("id"));
				rf.setReportid(rs.getString("reportid"));
				rf.setTestcontent(rs.getString("testcontent"));
				rf.setTestmethod(rs.getString("testmethod"));
				rf.setCategory(rs.getString("category"));
				rf.setLan(rs.getString("lan"));
				rf.setFileid(rs.getInt("fileid"));

				list.add(rf);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}

}
