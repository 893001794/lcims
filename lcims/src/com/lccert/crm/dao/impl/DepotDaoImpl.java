package com.lccert.crm.dao.impl;

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
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.DepotDao;
import com.lccert.crm.kis.Bank;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.vo.Depot;
/**
 * 添加仓库表的实现类
 * @author tangzp
 *
 */
public class DepotDaoImpl implements DepotDao {
/**
 *添加仓库信息
 */
	public int  addDepot(Depot depot,String company) {
		//获取资产编号
		String did=makeDid(company,"did");
		//获取申请表编号
		String application=makeDid("S","vapplication");
		//合同编号改为自动获取
		//String contract=makeDid("H","vcontract");
		
		String acceptance=makeDid("Y","vacceptance");
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "insert into t_depot(did,aid,vbrand,vspecification,fprice,number,unitofaccount,vclient,deptid,vusestatus,duse,vaperture,keeperid,vfundstype,dcalibration,dnextcal,vapplication,vcontract,vacceptance,vinvoicecode,vinvoiceno,vremarks,dcreatetime) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,did);
			pstmt.setInt(2, depot.getAid());
			pstmt.setString(3, depot.getBrand());
			pstmt.setString(4, depot.getSpecification());
			pstmt.setFloat(5,depot.getPrice());
			pstmt.setInt(6,depot.getNumber());
			pstmt.setString(7,depot.getUnitofaccount());
			pstmt.setString(8, depot.getClient());
			pstmt.setInt(9, depot.getDeptid());
			pstmt.setString(10, depot.getUsestatus());
			pstmt.setTimestamp(11,new Timestamp(depot.getUserdate().getTime()));
			pstmt.setString(12, depot.getAperture());
			pstmt.setInt(13,depot.getKeepid());
			pstmt.setString(14,depot.getFundstype());
			pstmt.setTimestamp(15,new Timestamp(depot.getCalibration().getTime())); 
			pstmt.setTimestamp(16,new Timestamp(depot.getNextcal().getTime())); 
			pstmt.setString(17, application);
			pstmt.setString(18, depot.getContract());
			pstmt.setString(19, acceptance);
			pstmt.setString(20, depot.getInvoicecode());
			pstmt.setString(21, depot.getInvoiceno());
			pstmt.setString(22, depot.getRemarks());
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();  //getGeneratedKeys自动获取主键的方法
			rs.next();
			key= rs.getInt(1);
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
			//DB.close(rs);
			DB.close(conn);
		}
		return key;
	}

	
	/**
	 * 生成多个编号
	 */
public String makeDid(String company,String field) {
	String last = "";
	StringBuffer str = new StringBuffer();
	str.append(company);
	Date date = new Date();
	String year = new SimpleDateFormat("yy").format(date);
	String month = new SimpleDateFormat("MM").format(date);
	str.append(year + month);
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean auto = false;
	String sql = "Select "+field+" from t_depot order by substring("+field+",6,8) desc";
//	System.out.println(sql+"------------------------");
	try {
		conn = DB.getConn();
		auto = conn.getAutoCommit();
		conn.setAutoCommit(false);
		pstmt = DB.prepareStatement(conn, sql);
		rs = pstmt.executeQuery();
		System.out.println(rs);
		if (rs.next()) {
			String sub = rs.getString(field);
			System.out.println(sub);
			int code = Integer.parseInt(sub.substring(5, sub.length()));
			//System.out.println(code);
			code += 1;
			last = new DecimalFormat("000").format(code);
			
			}else {
				last = "001";
			}
		System.out.println(last);
		str.append(last);
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
	return str.toString();
}


/**
 * 查询所以的仓库信息
 */
	public Depot searchDepot(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Depot depot = new Depot();
		String sql = "select * from t_depot where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				depot.setDid(rs.getString("did"));
				depot.setAid(rs.getInt("aid"));
				depot.setBrand(rs.getString("vbrand"));
				depot.setSpecification(rs.getString("vspecification"));
				depot.setPrice(rs.getFloat("fprice"));
				depot.setNumber(rs.getInt("number"));
				depot.setUnitofaccount(rs.getString("unitofaccount"));
				depot.setClient(rs.getString("vclient"));
				depot.setDeptid(rs.getInt("deptid"));
				depot.setUsestatus(rs.getString("vusestatus"));
				depot.setUserdate(rs.getDate("duse"));
				depot.setAperture(rs.getString("vaperture"));
				depot.setKeepid(rs.getInt("keeperid"));
				depot.setFundstype(rs.getString("vfundstype"));
				depot.setCalibration(rs.getDate("dcalibration"));
				depot.setNextcal(rs.getDate("dnextcal"));
				depot.setApplication(rs.getString("vapplication"));
				depot.setContract(rs.getString("vcontract"));
				depot.setAcceptance(rs.getString("vacceptance"));
				depot.setInvoicecode(rs.getString("vinvoicecode"));
				depot.setInvoiceno(rs.getString("vinvoiceno"));
				depot.setRemarks(rs.getString("vremarks"));
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
		return depot;
	
	}
	
	/**
	 * 查找所有化学项目(分页模式)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel searchAllDepot(int pageNo, int pageSize) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList ();
		Depot depot = null;
		String sql ="select  * from t_depot ";
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				depot = new Depot();
				depot.setId(rs.getInt("id"));
				depot.setDid(rs.getString("did"));
				depot.setAid(rs.getInt("aid"));
				depot.setBrand(rs.getString("vbrand"));
				depot.setSpecification(rs.getString("vspecification"));
				depot.setPrice(rs.getFloat("fprice"));
				depot.setNumber(rs.getInt("number"));
				depot.setUnitofaccount(rs.getString("unitofaccount"));
				depot.setClient(rs.getString("vclient"));
				depot.setDeptid(rs.getInt("deptid"));
				depot.setUsestatus(rs.getString("vusestatus"));
				depot.setUserdate(rs.getDate("duse"));
				depot.setAperture(rs.getString("vaperture"));
				depot.setKeepid(rs.getInt("keeperid"));
				depot.setFundstype(rs.getString("vfundstype"));
				depot.setCalibration(rs.getDate("dcalibration"));
				depot.setNextcal(rs.getDate("dnextcal"));
				depot.setApplication(rs.getString("vapplication"));
				depot.setContract(rs.getString("vcontract"));
				depot.setAcceptance(rs.getString("vacceptance"));
				depot.setInvoicecode(rs.getString("vinvoicecode"));
				depot.setInvoiceno(rs.getString("vinvoiceno"));
				depot.setRemarks(rs.getString("vremarks"));
				list.add(depot);
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


	public int updateDepot(Depot depot) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "update  t_depot set aid=?,vbrand=?,vspecification=?,fprice=?,number=?,unitofaccount=?,vclient=?,deptid=?,vusestatus=?,duse=?,vaperture=?,keeperid=?,vfundstype=?,dcalibration=?,dnextcal=?,vcontract=?,vinvoicecode=?,vinvoiceno=?,vremarks=? where id =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, depot.getAid());
			pstmt.setString(2, depot.getBrand());
			pstmt.setString(3, depot.getSpecification());
			pstmt.setFloat(4,depot.getPrice());
			pstmt.setInt(5,depot.getNumber());
			pstmt.setString(6,depot.getUnitofaccount());
			pstmt.setString(7, depot.getClient());
			pstmt.setInt(8, depot.getDeptid());
			pstmt.setString(9, depot.getUsestatus());
			pstmt.setTimestamp(10,new Timestamp(depot.getUserdate().getTime()));
			pstmt.setString(11, depot.getAperture());
			pstmt.setInt(12,depot.getKeepid());
			pstmt.setString(13,depot.getFundstype());
			pstmt.setTimestamp(14,new Timestamp(depot.getCalibration().getTime())); 
			pstmt.setTimestamp(15,new Timestamp(depot.getNextcal().getTime())); 
			pstmt.setString(16, depot.getContract());
			pstmt.setString(17, depot.getInvoicecode());
			System.out.println(depot.getInvoicecode()+"---");
			pstmt.setString(18, depot.getInvoiceno());
			pstmt.setString(19, depot.getRemarks());
			pstmt.setInt(20, depot.getId());
			pstmt.executeUpdate();
			//rs = pstmt.getGeneratedKeys();  //getGeneratedKeys自动获取主键的方法
			//rs.next();
			key=depot.getId();
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
		return key;
	}


	public int delDeport(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		ResultSet rs = null;
		int key =0;
		String sql = "delete from  t_depot where id =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			//rs = pstmt.getGeneratedKeys();  //getGeneratedKeys自动获取主键的方法
			//rs.next();
			key=1;
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
		return key;
	}


}
