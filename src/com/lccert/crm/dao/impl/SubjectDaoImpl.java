package com.lccert.crm.dao.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.SubjectDao;
import com.lccert.crm.vo.Subject;

public class SubjectDaoImpl implements SubjectDao {
	private  final String TABLE="t_subject"; 
	private  final String FIELD="id,name,grande,parent";
	/**
	 *  //根据三级名称查询一级和二级名称
	 */
	public Subject getSubByFirstSubName(String subjectName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Subject sub = new Subject();
		String sql = "select * from "+TABLE+" where threename =?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, subjectName);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				sub.setId(rs.getInt("id"));
				sub.setFirstname(rs.getString("firstname"));
				sub.setSecondname(rs.getString("secondname"));
				sub.setThreename(rs.getString("threename"));
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
		return sub;
	}
	

}
