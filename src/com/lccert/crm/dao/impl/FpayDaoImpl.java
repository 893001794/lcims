package com.lccert.crm.dao.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.FpayDao;
import com.lccert.crm.quotation.FinanceQuotationUtil;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.vo.Fpay;

public class FpayDaoImpl implements FpayDao {
	private  final String TABLE="t_fpay"; 
	private  final String FIELD="dpaytime,supplier,dept,person,chem,safe,op,emc,dr,vip,gmo,eq,finance,administration," +
			"engineering,total,account,einvtype,invoiceno,billno,remarks,onelevelsub,twolevelsub,threelevelsub,travel,summay,entertain";
	
	public int addFpay(Fpay fpay) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int key =0;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into "+TABLE+" ("+FIELD+") values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,fpay.getDpaytime());
			pstmt.setString(2,fpay.getSupplier());
			pstmt.setString(3,fpay.getDept());
			pstmt.setString(4,fpay.getPerson());
			pstmt.setDouble(5,fpay.getChem());
			pstmt.setDouble(6,fpay.getSafe());
			pstmt.setDouble(7,fpay.getOp());
			pstmt.setDouble(8,fpay.getEmc());
			pstmt.setDouble(9,fpay.getDr());
			pstmt.setDouble(10,fpay.getVip());
			pstmt.setDouble(11,fpay.getGmo());
			pstmt.setDouble(12,fpay.getEq());
			pstmt.setDouble(13,fpay.getFinance());
			pstmt.setDouble(14,fpay.getAdministration());
			pstmt.setDouble(15,fpay.getEngineering());
			pstmt.setDouble(16,fpay.getTotal());
			pstmt.setString(17,fpay.getAccount());
			pstmt.setString(18,fpay.getEinvtype());
			pstmt.setString(19,fpay.getInvoiceno());
			pstmt.setString(20,fpay.getBillno());
			pstmt.setString(21,fpay.getRemarks());
			pstmt.setString(22,fpay.getOnelevelsub());
			pstmt.setString(23,fpay.getTwolevelsub());
			pstmt.setString(24,fpay.getThreelevelsub());
			pstmt.setString(25,fpay.getTravel());
			pstmt.setString(26,fpay.getSummay());
			pstmt.setString(27,fpay.getEntertain());
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
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return key;
	}
	public int updateFpay(Fpay fpay) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int key =0;
		boolean auto = false;
		boolean isok = false;
		String sql = "update "+TABLE+"  set dpaytime=?,supplier=?,dept=?,person=?,chem=?,safe=?,op=?,emc=?,dr=?,vip=?,gmo=?,eq=?,finance=?,administration=?," +
			"engineering=?,total=?,account=?,einvtype=?,invoiceno=?,billno=?,remarks=?,onelevelsub=?,twolevelsub=?,threelevelsub=?,travel=?,summay=?,entertain=? where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,fpay.getDpaytime());
			pstmt.setString(2,fpay.getSupplier());
			pstmt.setString(3,fpay.getDept());
			pstmt.setString(4,fpay.getPerson());
			pstmt.setDouble(5,fpay.getChem());
			pstmt.setDouble(6,fpay.getSafe());
			pstmt.setDouble(7,fpay.getOp()==null?0.0:fpay.getOp());
			pstmt.setDouble(8,fpay.getEmc()==null?0.0:fpay.getEmc());
			pstmt.setDouble(9,fpay.getDr()==null?0.0:fpay.getDr());
			pstmt.setDouble(10,fpay.getVip()==null?0.0:fpay.getVip());
			pstmt.setDouble(11,fpay.getGmo()==null?0.0:fpay.getGmo());
			pstmt.setDouble(12,fpay.getEq()==null?0.0:fpay.getEq());
			pstmt.setDouble(13,fpay.getFinance()==null?0.0:fpay.getFinance());
			pstmt.setDouble(14,fpay.getAdministration()==null?0.0:fpay.getAdministration());
			pstmt.setDouble(15,fpay.getEngineering()==null?0.0:fpay.getEngineering());
			pstmt.setDouble(16,fpay.getTotal()==null?0.0:fpay.getTotal());
			pstmt.setString(17,fpay.getAccount());
			pstmt.setString(18,fpay.getEinvtype());
			pstmt.setString(19,fpay.getInvoiceno());
			pstmt.setString(20,fpay.getBillno());
			pstmt.setString(21,fpay.getRemarks());
			pstmt.setString(22,fpay.getOnelevelsub());
			pstmt.setString(23,fpay.getTwolevelsub());
			pstmt.setString(24,fpay.getThreelevelsub());
			pstmt.setString(25,fpay.getTravel());
			pstmt.setString(26,fpay.getSummay());
			pstmt.setString(27,fpay.getEntertain());
			pstmt.setInt(28, fpay.getId());
			pstmt.executeUpdate();
			key=1;
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
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return key;
	}
	
	public Fpay getFpayById(Integer id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Fpay fpay = new Fpay();
		String sql = "select * from "+TABLE+" where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				fpay.setId(rs.getInt("id"));
				fpay.setDpaytime(rs.getString("dpaytime"));
				fpay.setSupplier(rs.getString("supplier"));
				fpay.setDept(rs.getString("dept"));
				fpay.setPerson(rs.getString("person"));
				fpay.setChem(rs.getDouble("chem"));
				fpay.setSafe(rs.getDouble("safe"));
				fpay.setOp(rs.getDouble("op"));
				fpay.setEmc(rs.getDouble("emc"));
				fpay.setDr(rs.getDouble("dr"));
				fpay.setVip(rs.getDouble("vip"));
				fpay.setGmo(rs.getDouble("gmo"));
				fpay.setEq(rs.getDouble("eq"));
				fpay.setFinance(rs.getDouble("finance"));
				fpay.setAdministration(rs.getDouble("administration"));
				fpay.setEngineering(rs.getDouble("engineering"));
				fpay.setTotal(rs.getDouble("total"));
				fpay.setAccount(rs.getString("account"));
				fpay.setEinvtype(rs.getString("einvtype"));
				fpay.setInvoiceno(rs.getString("invoiceno"));
				fpay.setBillno(rs.getString("billno"));
				fpay.setRemarks(rs.getString("remarks"));
				fpay.setOnelevelsub(rs.getString("onelevelsub"));
				fpay.setTwolevelsub(rs.getString("twolevelsub"));
				fpay.setThreelevelsub(rs.getString("threelevelsub"));
				fpay.setTravel(rs.getString("travel"));
				fpay.setSummay(rs.getString("summay"));
				fpay.setEntertain(rs.getString("entertain"));
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
		return fpay;
	}
	
	public PageModel searchFpays(Fpay fpay) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Fpay> list = new ArrayList<Fpay>();
		StringBuffer str = new StringBuffer();
		String supplier=fpay.getSupplier();
		String remarks=fpay.getRemarks();
		String person=fpay.getPerson();
		String startDpaytime=fpay.getStartDpaytime();
		String endDayTiem=fpay.getEndDayTiem();
		if(supplier !=null && !"".equals(supplier)){
			str.append(" and supplier like '%"+supplier+"%' ");
		}
		if(remarks !=null && !"".equals(remarks)){
			str.append(" and remarks like '%"+remarks+"%' ");
		}
		if(person !=null && !"".equals(person)){
			str.append(" and person = '"+person+"' ");
		}
		if(startDpaytime !=null && !"".equals(startDpaytime)){
			str.append(" and dpaytime >= '"+startDpaytime+"' ");
		}
		if(endDayTiem !=null && !"".equals(endDayTiem)){
			str.append(" and dpaytime <= '"+endDayTiem+"' ");
		}
		Integer pageSize=fpay.getPageSize();
		Integer pageNo=fpay.getPageNo();
		String sql=null;
		 sql = "select * from "+TABLE+" where 1=1 "+ str.toString()+" order by id desc limit "
			+ (fpay.getPageNo() - 1) * fpay.getPageSize() + ", " + fpay.getPageSize();
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				fpay = new Fpay();
				fpay.setId(rs.getInt("id"));
				fpay.setDpaytime(rs.getString("dpaytime"));
				fpay.setSupplier(rs.getString("supplier"));
				fpay.setDept(rs.getString("dept"));
				fpay.setPerson(rs.getString("person"));
				fpay.setChem(rs.getDouble("chem"));
				fpay.setSafe(rs.getDouble("safe"));
				fpay.setOp(rs.getDouble("op"));
				fpay.setEmc(rs.getDouble("emc"));
				fpay.setDr(rs.getDouble("dr"));
				fpay.setVip(rs.getDouble("vip"));
				fpay.setGmo(rs.getDouble("gmo"));
				fpay.setEq(rs.getDouble("eq"));
				fpay.setFinance(rs.getDouble("finance"));
				fpay.setAdministration(rs.getDouble("administration"));
				fpay.setEngineering(rs.getDouble("engineering"));
				fpay.setTotal(rs.getDouble("total"));
				fpay.setAccount(rs.getString("account"));
				fpay.setEinvtype(rs.getString("einvtype"));
				fpay.setInvoiceno(rs.getString("invoiceno"));
				fpay.setBillno(rs.getString("billno"));
				fpay.setRemarks(rs.getString("remarks"));
				fpay.setOnelevelsub(rs.getString("onelevelsub"));
				fpay.setTwolevelsub(rs.getString("twolevelsub"));
				fpay.setThreelevelsub(rs.getString("threelevelsub"));
				fpay.setTravel(rs.getString("travel"));
				fpay.setSummay(rs.getString("summay"));
				fpay.setEntertain(rs.getString("entertain"));
				list.add(fpay);
			}
			String tsql= "select count(*) from "+TABLE+" where 1=1" + str.toString();
			int totalRecords = getTotalRecords(conn,tsql);
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
	/**
	 * 取得所有的记录数
	 * 
	 * @param conn
	 *            connection
	 * @param createuser
	 * @return 所有的记录数
	 */
	private int getTotalRecords(Connection conn,String sql) {
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalRecords = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
		}
		return totalRecords;
	}
	public List<Fpay> searchFpayList(Fpay fpay) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Fpay> list = new ArrayList<Fpay>();
		StringBuffer str = new StringBuffer();
		String supplier=fpay.getSupplier();
		String remarks=fpay.getRemarks();
		String person=fpay.getPerson();
		String startDpaytime=fpay.getStartDpaytime();
		String endDayTiem=fpay.getEndDayTiem();
		if(supplier !=null && !"".equals(supplier)){
			str.append(" and supplier like '%"+supplier+"%' ");
		}
		if(remarks !=null && !"".equals(remarks)){
			str.append(" and remarks like '%"+remarks+"%' ");
		}
		if(person !=null && !"".equals(person)){
			str.append(" and person = '"+person+"' ");
		}
		if(startDpaytime !=null && !"".equals(startDpaytime)){
			str.append(" and dpaytime >= '"+startDpaytime+"' ");
		}
		if(endDayTiem !=null && !"".equals(endDayTiem)){
			str.append(" and dpaytime <= '"+endDayTiem+"' ");
		}
		Integer pageSize=fpay.getPageSize();
		Integer pageNo=fpay.getPageNo();
		String sql=null;
		 sql = "select * from "+TABLE+" where 1=1 "+ str.toString()+" order by id desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				fpay = new Fpay();
				fpay.setId(rs.getInt("id"));
				fpay.setDpaytime(rs.getString("dpaytime"));
				fpay.setSupplier(rs.getString("supplier"));
				fpay.setDept(rs.getString("dept"));
				fpay.setPerson(rs.getString("person"));
				fpay.setChem(rs.getDouble("chem"));
				fpay.setSafe(rs.getDouble("safe"));
				fpay.setOp(rs.getDouble("op"));
				fpay.setEmc(rs.getDouble("emc"));
				fpay.setDr(rs.getDouble("dr"));
				fpay.setVip(rs.getDouble("vip"));
				fpay.setGmo(rs.getDouble("gmo"));
				fpay.setEq(rs.getDouble("eq"));
				fpay.setFinance(rs.getDouble("finance"));
				fpay.setAdministration(rs.getDouble("administration"));
				fpay.setEngineering(rs.getDouble("engineering"));
				fpay.setTotal(rs.getDouble("total"));
				fpay.setAccount(rs.getString("account"));
				fpay.setEinvtype(rs.getString("einvtype"));
				fpay.setInvoiceno(rs.getString("invoiceno"));
				fpay.setBillno(rs.getString("billno"));
				fpay.setRemarks(rs.getString("remarks"));
				fpay.setOnelevelsub(rs.getString("onelevelsub"));
				fpay.setTwolevelsub(rs.getString("twolevelsub"));
				fpay.setThreelevelsub(rs.getString("threelevelsub"));
				fpay.setTravel(rs.getString("travel"));
				fpay.setSummay(rs.getString("summay"));
				fpay.setEntertain(rs.getString("entertain"));
				list.add(fpay);
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
}
