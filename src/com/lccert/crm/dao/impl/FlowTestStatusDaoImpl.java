package com.lccert.crm.dao.impl;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.FlowTestStatusDao;
import com.lccert.crm.vo.FlowTestStatus;
import com.lccert.oa.db.ImsDB;

public class FlowTestStatusDaoImpl implements FlowTestStatusDao{
	private static final String ALL_FIELD=" id,vfidtestno,tester,barcode,department,status,barcodetime";
	public PageModel findAllInPage(FlowTestStatus flowTestStatus,int pageNo, int pageSize) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList ();
		String sql ="select  id,vfidtestno,tester,barcode,department,status,barcodetime from t_flow_test_status ";
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flowTestStatus = new FlowTestStatus();
				flowTestStatus.setId(rs.getInt("id"));
				flowTestStatus.setFidTestNo(rs.getString("vfidtestno"));
				flowTestStatus.setTester(rs.getString("tester"));
				flowTestStatus.setBarCode(rs.getString("barcode"));
				flowTestStatus.setDepartment(rs.getString("barcode"));
				flowTestStatus.setDepartment(rs.getString("department"));
				flowTestStatus.setStatus(rs.getInt("status"));
				flowTestStatus.setBarCodeTime(rs.getString("barcodetime"));
				list.add(flowTestStatus);
			}
			int totalRecords =new ChemProjectDaoImplMySql().getTotalRecords(conn,sql);
			pm = new PageModel();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			pm.setList(list);
			pm.setTotalRecords(totalRecords);
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
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
			closeAll(rs,conn,pstmt);
		}
		return pm;
	}
	
	public List findAll(FlowTestStatus flowTestStatus) {
		List temp=new ArrayList();
		temp.add("vfidtestno");
		temp.add("tester");
		temp.add("barcode");
		temp.add("department");
		temp.add("status");
		temp.add("barcodetime");
		String sql ="select "+ALL_FIELD+" from t_flow_test_status";
		return new ImsDB().getInfor(temp, sql);
	}
	public boolean saveFlowTestStatus(FlowTestStatus flowTestStatus) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		int key=0;
		String sql = "insert into t_flow_test_status(vfidtestno,tester,barcode,department,status,barcodetime) values(?,?,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,flowTestStatus.getFidTestNo());
			pstmt.setString(2,flowTestStatus.getTester());
			pstmt.setString(3,flowTestStatus.getBarCode());
			pstmt.setString(4,flowTestStatus.getDepartment());
			pstmt.setInt(5,0);
			pstmt.setString(6,flowTestStatus.getBarCodeTime());
			pstmt.executeUpdate();
			conn.commit();
			rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				key = rs.getInt(1);
			}
			isok = true;
		} catch (SQLException e) {
			isok = false;
			//e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
//			DB.close(pstmt);
//			DB.close(conn);
			closeAll(rs,conn,pstmt);
		}
		return isok;
	}
	public void updateFlowTestStatus(FlowTestStatus flowTestStatus) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "update  t_flow_test_status set vfidtestno=?,tester=?,department,status,barcodetime where id =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, flowTestStatus.getFidTestNo());
			pstmt.setString(2,flowTestStatus.getTester());
			pstmt.setString(3,flowTestStatus.getBarCode());
			pstmt.setString(4,flowTestStatus.getDepartment());
			pstmt.setInt(5,flowTestStatus.getStatus());
			pstmt.setString(6,flowTestStatus.getBarCodeTime());
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
			closeAll(rs,conn,pstmt);
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
		}
	}
	
	public void deleteById(Integer id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "delete from  t_flow_test_status where id =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
		} catch (SQLException e) {
			key=0;
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
			closeAll(rs,conn,pstmt);
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
		}
	}

	public FlowTestStatus findByFlowTestNo(String fidtestno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		FlowTestStatus flowTestStatus = new FlowTestStatus();
		String sql = "select fs.vfidtestname,fss.id,fss.vfidtestno,fss.tester,fss.barcode,fss.department,fss.status,fss.barCodeTime from t_flow_test fs ,t_flow_test_status fss where fs.Vfidtestno =fss.vfidtestno and fss.vfidtestno like'%"+fidtestno+"%'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flowTestStatus.setId(rs.getInt("fss.id"));
				flowTestStatus.setFidTestNo(rs.getString("fss.vfidtestno"));
				flowTestStatus.setTester(rs.getString("fss.tester"));
				flowTestStatus.setBarCode(rs.getString("fss.barcode"));
				flowTestStatus.setDepartment(rs.getString("fss.department"));
				flowTestStatus.setStatus(rs.getInt("fss.status"));
				flowTestStatus.setBarCodeTime(rs.getString("fss.barcodetime"));
				flowTestStatus.setVfidtestname(rs.getString("fs.vfidtestname"));
			}
			conn.commit();
		} catch (Exception e) {
			return null;
		} finally {
			closeAll(rs,conn,pstmt);
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
		}
		return flowTestStatus;
	}

	public Boolean findByBarCode(String barCode, String fidtestno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select id from t_flow_test_status   where  vfidtestno like'%"+fidtestno.substring(0,fidtestno.indexOf("-")-1)+"%' and barCode like '%"+barCode+"%'";
		System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			closeAll(rs,conn,pstmt);
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
		}
		return false;
	}

	public FlowTestStatus findByBarCodeFlowNo(String barCode, String flowNo) {
		FlowTestStatus flowTestStatus = new FlowTestStatus();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select id,vfidtestno,tester,barcode,department,status,barcodetime from t_flow_test_status   where  vfidtestno like'%"+flowNo+"%' and barCode like '%"+barCode+"%'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flowTestStatus.setId(rs.getInt("id"));
				flowTestStatus.setFidTestNo(rs.getString("vfidtestno"));
				flowTestStatus.setTester(rs.getString("tester"));
				flowTestStatus.setBarCode(rs.getString("barcode"));
				flowTestStatus.setDepartment(rs.getString("barcode"));
				flowTestStatus.setDepartment(rs.getString("department"));
				flowTestStatus.setStatus(rs.getInt("status"));
				flowTestStatus.setBarCodeTime(rs.getString("barcodetime"));
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs,conn,pstmt);
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
		}
		return flowTestStatus;
	}

	
	
	// 关闭公共方法
	public void closeAll(ResultSet rs,Connection con,PreparedStatement pstmt) {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
