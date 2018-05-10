package com.lccert.lcim.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;

/***
 * 特殊请款的action类
 * @author tangzp
 *
 */

public class SpeApplicationAction {
	private static SpeApplicationAction instance = null;

	private SpeApplicationAction() {		
	}
	
	//单例模式
	public static SpeApplicationAction getInstance() {
		if(instance == null) {
			instance = new SpeApplicationAction();
		}
		return instance;
	}
	
	/**
	 * 自动生成编号
	 * @return
	 */
	private String makeSpeAppId() {
		String sql ="select spe_app_id from t_spe_application order by spe_app_id desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer str = new StringBuffer();
		String last = "";
		str.append("LCS");
		
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		str.append(year + month);
		
		try {
			conn = DB.getConn();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String sub = rs.getString("spe_app_id");
				int code = Integer.parseInt(sub.substring(7, 11));
System.out.println("code:" + code);
				code += 1;
				last = new DecimalFormat("0000").format(code);
			} else {
				last = "0001";
			}
			
			str.append(last);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return str.toString();
	}
	
	
	public synchronized boolean addSpeApplication(SpecialApplication spa) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		spa.setSpeappid(makeSpeAppId());
		String sql = "insert into t_spe_application(spe_app_id,content,price,taxpoint," +
		"paycount,notes,adduser,addtime) values(?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, spa.getSpeappid());
			pstmt.setString(2, spa.getContent());
			pstmt.setFloat(3, spa.getPrice());
			pstmt.setFloat(4, spa.getTaxpoint());
			pstmt.setFloat(5, spa.getPaycount());
			pstmt.setString(6, spa.getNotes());
			pstmt.setString(7, spa.getAdduser());

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
	
	/**
	 * 修改特殊情况
	 * @param spa
	 * @return
	 */
	public synchronized boolean modifySpeApplication(SpecialApplication spa) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_spe_application set content=?,price=?,taxpoint=?," +
		"paycount=?,notes=? where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, spa.getContent());
			pstmt.setFloat(2, spa.getPrice());
			pstmt.setFloat(3, spa.getTaxpoint());
			pstmt.setFloat(4, spa.getPaycount());
			pstmt.setString(5, spa.getNotes());
			pstmt.setInt(6, spa.getId());

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
	
	

	/**
	 * 得到所有特殊款项申请表
	 * @return
	 */
	public List<SpecialApplication> getAllSpeApp(String rq) {
		String str = "";
		if("nopay".equals(rq)) {
			str = " and payman is null and isaudit = 'y'";
		} else if("noaudit".equals(rq)){
			str = " and isaudit = 'n'";
		} else if("hadpay".equals(rq)) {
			str = " and payman is not null";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<SpecialApplication> list = new ArrayList<SpecialApplication>();
		String sql = "select * from t_spe_application where 1 = 1" + str + " order by spe_app_id desc";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SpecialApplication spa = new SpecialApplication();
				spa.setId(rs.getInt("id"));
				spa.setSpeappid(rs.getString("spe_app_id"));
				spa.setContent(rs.getString("content"));
				spa.setPrice(rs.getFloat("price"));
				spa.setTaxpoint(rs.getFloat("taxpoint"));
				spa.setPaycount(rs.getFloat("paycount"));
				spa.setNotes(rs.getString("notes"));
				spa.setAdduser(rs.getString("adduser"));
				spa.setAddtime(rs.getTimestamp("addtime"));
				spa.setAuditman(rs.getString("auditman"));
				spa.setAudittime(rs.getTimestamp("audittime"));
				
				spa.setPayman(rs.getString("payman"));
				spa.setPaytime(rs.getTimestamp("paytime"));
				
				list.add(spa);
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
	

	/**
	 * 根据id查找特殊请款
	 * @return
	 */
	public SpecialApplication getSpeAppById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SpecialApplication spa = null;
		String sql = "select * from t_spe_application where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				spa = new SpecialApplication();
				spa.setId(rs.getInt("id"));
				spa.setSpeappid(rs.getString("spe_app_id"));
				spa.setContent(rs.getString("content"));
				spa.setPrice(rs.getFloat("price"));
				spa.setTaxpoint(rs.getFloat("taxpoint"));
				spa.setPaycount(rs.getFloat("paycount"));
				spa.setNotes(rs.getString("notes"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return spa;
	}
	
	
	/**
	 * 审核申请表
	 * @param app_id
	 * @return
	 */
	public synchronized boolean confirmSpeApplication(SpecialApplication spa) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_spe_application set auditman=?,audittime=now(),isaudit='y' where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, spa.getAuditman());
			pstmt.setInt(2, spa.getId());

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
	
	/**
	 * 支付确认
	 * @param af
	 * @return
	 */
	public synchronized boolean payConfirm(SpecialApplication spa) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_spe_application set payman=?,paytime=now() where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, spa.getPayman());
			pstmt.setInt(2, spa.getId());

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
