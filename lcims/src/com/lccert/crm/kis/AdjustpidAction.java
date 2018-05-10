package com.lccert.crm.kis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.ProjectAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;

/**
 * 报价单管理类（包括service层和dao层）
 * @author Eason
 *
 */
public class AdjustpidAction {
	
	private static AdjustpidAction instance = null;

	private AdjustpidAction() {

	}

	public synchronized static AdjustpidAction getInstance() {
		if (instance == null) {
			instance = new AdjustpidAction();
		}
		return instance;
	}
	
	
	/**
	 * 添加报价单
	 * @param order
	 * @return
	 */
	public boolean addAdjust(Adjustpid adjust) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		int isok = 0;
		String sql = "insert into t_adjustpid(vpid,vrid,fadjustinvcount,estatus," +
				"equotype,createtime)values(?,?,?,'n',?,now())";
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, adjust.getPid());
			pstmt.setString(2,adjust.getRid());
			pstmt.setFloat(3,adjust.getFadjustinvcount());
			pstmt.setString(4, adjust.getEquotype());
			pstmt.executeUpdate();
			conn.commit();
			auto = true;
		} catch (SQLException e) {
			isok = 0;
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
		return auto;
	}
	
	
	/**
	 * 审核更改报价单金额
	 * @param order
	 * @return
	 */
	public boolean audAdjust(Adjustpid adjust) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_adjustpid set estatus = 'y' where vpid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, adjust.getPid());
			pstmt.executeUpdate();
		
			sql = "update t_quotation set fadjustinvcount = ?,equotype = ? where vpid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			//如果报价单类型为冲红，则为负数
			pstmt.setFloat(1, adjust.getFadjustinvcount());
			pstmt.setString(2,adjust.getEquotype());
			pstmt.setString(3,adjust.getPid());
			pstmt.executeUpdate();
			//如果更改报价单的类型为add的时候，修要将对应的项目的报告类型更改过来 
			if(adjust.getEquotype().equals("add")){
			//跟pid获取订单的类型
			if(!"化学测试".equals(ProjectAction.getInstance().getprojectStatus(adjust.getPid()))){
				sql = "update t_phy_project set erptype = '双语报告' where vpid = ? and vrid =?";
			}else{
			sql = "update t_chem_project set erptype = '双语报告' where vpid = ? and vrid =?";
			}
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,adjust.getPid());
			pstmt.setString(2,adjust.getRid());
			pstmt.executeUpdate();
			}
			
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	

	/**
	 * 根据测试ID取得测试具体内容
	 * @param itemid
	 * @return
	 */
	public Adjustpid getAdjustById(String pid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Adjustpid adjust = new Adjustpid();
		String sql = "select * from t_adjustpid where vpid =?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				adjust.setPid(rs.getString("vpid"));
				adjust.setRid(rs.getString("vrid"));
				adjust.setFadjustinvcount(rs.getFloat("fadjustinvcount"));
				adjust.setStatus(rs.getString("estatus"));
				adjust.setEquotype(rs.getString("equotype"));
			
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
		return adjust;
	}
	
	

}
