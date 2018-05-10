package com.lccert.crm.dao.impl;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.FlowTestDao;
import com.lccert.crm.vo.FlowTest;

public class FlowTestDaoImpl implements FlowTestDao{
	private static final String TABLE=" vfid,vfidtestno,vfidtestname,Count ";
	public PageModel findAllInPage(String fidNo, String fidTestName,int pageNo, int pageSize) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList ();
		FlowTest flowTest = null;
		String sql ="select  id,Vfid,Vfidtestno,Vfidtestname,Count from t_flow_test where 1=1 ";
		if(fidNo !=null && !"".equals(fidNo)){
			sql+=" and vfid like '%"+fidNo+"%'";
		}
		if(fidTestName !=null && !"".equals(fidTestName)){
			sql+=" and vfidtestname like '%"+fidTestName+"%'"; 
		}
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flowTest = new FlowTest();
				flowTest.setId(rs.getInt("id"));
				flowTest.setFid(rs.getString("Vfid"));
				flowTest.setFidTestNo(rs.getString("Vfidtestno"));
				flowTest.setFidTestName(rs.getString("Vfidtestname"));
				flowTest.setCount(rs.getInt("Count"));
				list.add(flowTest);
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pm;
	}
	
	public List<FlowTest> findAll(String fidNo, String fidTestName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel pm = new PageModel();
		List<FlowTest>  list = new ArrayList<FlowTest>  ();
		FlowTest flowTest = null;
		String sql ="select  id,vfid,vfidtestno,vfidtestname,count from t_flow_test where 1=1 ";
		if(fidNo !=null && !"".equals(fidNo)){
			sql+=" and vfid='"+fidNo+"'";
		}
		if(fidTestName !=null && !"".equals(fidTestName)){
			sql+=" and vfidtestname like '%"+fidTestName+"%'"; 
		}
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flowTest = new FlowTest();
				flowTest.setId(rs.getInt("id"));
				flowTest.setFid(rs.getString("vfid"));
				flowTest.setFidTestNo(rs.getString("vfidtestno"));
				flowTest.setFidTestName(rs.getString("vfidtestname"));
				flowTest.setCount(rs.getInt("count"));
				list.add(flowTest);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list ;
	}

 
//	public void saveFlowTest(FlowTest flowTest) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		boolean auto = false;
//		boolean isok = false;
//		String sql = "insert into t_flow_test("+TABLE+") values(?,?,?,?)";
//		try {
//			conn = DB.getConn();
//			auto = conn.getAutoCommit();
//			conn.setAutoCommit(false);
//			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setString(1,flowTest.getFid());
//			pstmt.setString(2,flowTest.getFidTestNo());
//			pstmt.setString(3,flowTest.getFidTestName());
//			pstmt.setInt(4,flowTest.getCount());
//			pstmt.executeUpdate();
//			conn.commit();
//			isok = true;
//		} catch (SQLException e) {
//			isok = false;
//			try {
//				conn.rollback();
//			} catch (Exception e1) {
//				e1.printStackTrace();
//			}
//			e.printStackTrace();
//		} finally {
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//			DB.close(pstmt);
//			DB.close(conn);
//		}
//		
//	}
	
	public void updateFlowTest(FlowTest flowTest) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		
		String sql = "update  t_flow_test set count=? where id =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1,flowTest.getCount());
			pstmt.setInt(2,flowTest.getId());
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	public void deleteFlowTest(Integer id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "delete from  t_flow_test where id =? ";
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	public FlowTest findByFidNo(String fidNo) {
 		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel pm = new PageModel();
		FlowTest flowTest = new FlowTest();
		String sql ="select  id,vfid,vfidtestno,vfidtestname,count from t_flow_test where 1=1 ";
		if(fidNo !=null && !"".equals(fidNo)){
			sql+=" and Vfidtestno like '%"+fidNo+"%'";
		}
		System.out.println(sql);
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flowTest.setId(rs.getInt("id"));
				flowTest.setFid(rs.getString("vfid"));
				flowTest.setFidTestNo(rs.getString("vfidtestno"));
				flowTest.setFidTestName(rs.getString("vfidtestname"));
				flowTest.setCount(rs.getInt("count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flowTest;
	}

}
