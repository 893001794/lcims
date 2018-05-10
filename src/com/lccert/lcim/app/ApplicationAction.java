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
import com.lccert.crm.user.UserForm;




/***
 * 请款action类
 * @author tangzp
 *
 */
public class ApplicationAction {
	private static ApplicationAction instance = null;

	private ApplicationAction() {		
	}
	
	//单例模式
	public static ApplicationAction getInstance() {
		if(instance == null) {
			instance = new ApplicationAction();
		}
		return instance;
	}
	
	/**
	 * 自动生成编号
	 * @return
	 */
	private String makeAppId() {
		String sql ="select app_id from t_application order by app_id desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer str = new StringBuffer();
		String last = "";
		str.append("LCP");
		
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		str.append(year + month);
		
		try {
			conn = DB.getConn();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String sub = rs.getString("app_id");
				int code = Integer.parseInt(sub.substring(7, 11));
				code += 1;
				last = new DecimalFormat("0000").format(code);
			} else {
				last = "0059";
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
	
	
	public synchronized boolean addApplication(ApplicationForm af) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		af.setApp_id(makeAppId());
		String sql = "insert into t_application(app_id,inv_type,inv_head,app_user," +
		"pay_method,pay_type,prepay_time1,prepay_time2,prepay_time3," +
		"contract_content1,contract_price1,contract_code1,contract_code2,contract_content2,contract_price2," +
		"contract_code3,contract_content3,contract_price3,first_pay,second_pay,third_pay,supplierid,dept,item," +
		"tags,app_time) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		
	//	System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, af.getApp_id());
			//System.out.println("1:"+ af.getApp_id());
			pstmt.setString(2, af.getInv_type());
			//System.out.println("2:"+ af.getInv_type());
			pstmt.setString(3, af.getInv_head());
			//System.out.println("3:"+ af.getInv_head());
			pstmt.setString(4, af.getApp_user());
			//System.out.println("4:"+af.getApp_user());
			pstmt.setString(5, af.getPay_method());
			//System.out.println("5:"+af.getPay_method());
			pstmt.setString(6, af.getPay_type());
			//System.out.println("6:"+ af.getPay_type());
			pstmt.setTimestamp(7, af.getPrepay_time1()==null?null:new Timestamp(af.getPrepay_time1().getTime()));
		//	System.out.println("7:"+af.getPrepay_time1()==null?null:new Timestamp(af.getPrepay_time1().getTime()));
			pstmt.setTimestamp(8, af.getPrepay_time2()==null?null:new Timestamp(af.getPrepay_time2().getTime()));
			//System.out.println("8:"+af.getPrepay_time2()==null?null:new Timestamp(af.getPrepay_time2().getTime()));
			pstmt.setTimestamp(9, af.getPrepay_time3()==null?null:new Timestamp(af.getPrepay_time3().getTime()));
		//	System.out.println("9:"+af.getPrepay_time3()==null?null:new Timestamp(af.getPrepay_time3().getTime()));
			pstmt.setString(10, af.getContract_content1());
			//System.out.println("10:"+af.getContract_content1());
			pstmt.setFloat(11, af.getContract_price1());
			//System.out.println("11:"+af.getContract_price1());
			pstmt.setString(12, af.getContract_code1());
			//System.out.println("12:"+af.getContract_code1());
			pstmt.setString(13, af.getContract_code2());
			//System.out.println("13:"+af.getContract_code2());
			pstmt.setString(14, af.getContract_content2());
			//System.out.println("14:"+ af.getContract_content2());
			pstmt.setFloat(15, af.getContract_price2());
			//System.out.println("15:"+ af.getContract_price2());
			pstmt.setString(16, af.getContract_code3());
			//System.out.println("16:"+af.getContract_code3());
			pstmt.setString(17, af.getContract_content3());
			//System.out.println("17:"+af.getContract_content3());
			pstmt.setFloat(18, af.getContract_price3());
			//System.out.println("18:"+ af.getContract_price3());
			pstmt.setFloat(19, af.getFirst_pay());
			//System.out.println("19:"+ af.getFirst_pay());
			pstmt.setFloat(20, af.getSecond_pay());
			//System.out.println("20:"+af.getSecond_pay());
			pstmt.setFloat(21, af.getThird_pay());
			//System.out.println("21:"+ af.getThird_pay());
			pstmt.setInt(22, af.getSup().getId());
			//System.out.println("22:"+  af.getSup().getId());
			pstmt.setString(23, af.getDept());
			//System.out.println("23:"+ af.getDept());
			pstmt.setInt(24, af.getItem());
			//System.out.println("24:"+ af.getItem());
			pstmt.setString(25, af.getTags());
			//System.out.println("25:"+af.getTags());

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
	
	
	public synchronized boolean modifyApplication(ApplicationForm af) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		//af.setApp_id(makeAppId());
		String sql = "update t_application set inv_type=?,inv_head=?,app_user=?," +
		"pay_method=?,pay_type=?,prepay_time1=?,prepay_time2=?,prepay_time3=?," +
		"contract_content1=?,contract_price1=?,contract_code1=?,contract_code2=?,contract_content2=?,contract_price2=?," +
		"contract_code3=?,contract_content3=?,contract_price3=?,first_pay=?,second_pay=?,third_pay=?,supplierid=?,dept=?,item=? where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, af.getInv_type());
			pstmt.setString(2, af.getInv_head());
			pstmt.setString(3, af.getApp_user());
			pstmt.setString(4, af.getPay_method());
			pstmt.setString(5, af.getPay_type());
			pstmt.setTimestamp(6, af.getPrepay_time1()==null?null:new Timestamp(af.getPrepay_time1().getTime()));
			pstmt.setTimestamp(7, af.getPrepay_time2()==null?null:new Timestamp(af.getPrepay_time2().getTime()));
			pstmt.setTimestamp(8, af.getPrepay_time3()==null?null:new Timestamp(af.getPrepay_time3().getTime()));
			pstmt.setString(9, af.getContract_content1());
			pstmt.setFloat(10, af.getContract_price1());
			pstmt.setString(11, af.getContract_code1());
			pstmt.setString(12, af.getContract_code2());
			pstmt.setString(13, af.getContract_content2());
			pstmt.setFloat(14, af.getContract_price2());
			pstmt.setString(15, af.getContract_code3());
			pstmt.setString(16, af.getContract_content3());
			pstmt.setFloat(17, af.getContract_price3());
			pstmt.setFloat(18, af.getFirst_pay());
			pstmt.setFloat(19, af.getSecond_pay());
			pstmt.setFloat(20, af.getThird_pay());
			pstmt.setInt(21, af.getSup().getId());
			pstmt.setString(22, af.getDept());
			pstmt.setInt(23, af.getItem());
			pstmt.setInt(24, af.getId());

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
	 * 添加受款单位
	 * @param sup
	 * @return
	 */
	public synchronized boolean addSuppier(Supplier sup) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_supplier values(null,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sup.getName());
			pstmt.setString(2, sup.getBank());
			pstmt.setString(3, sup.getCreditname());
			pstmt.setString(4, sup.getCreditcard());
			
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
	 * 修改受款单位
	 * @param sup
	 * @return
	 */
	public synchronized boolean modifySuppier(Supplier sup) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_supplier set name=?,bank=?,creditname=?,creditcard=? where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sup.getName());
			pstmt.setString(2, sup.getBank());
			pstmt.setString(3, sup.getCreditname());
			pstmt.setString(4, sup.getCreditcard());
			pstmt.setInt(5, sup.getId());
			
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
	
//	/**
//	 * 得到所有款项申请表
//	 * @return
//	 */
	public List<ApplicationForm> getAllApp(String rq,UserForm user) {
		StringBuffer str = new StringBuffer();
		if("nopay".equals(rq)) {
			str.append(" and pay_man is null and isaudit = 'y'");
		} else if("noaudit".equals(rq)){
			str.append(" and isaudit = 'n'");
		} else if("noaccept".equals(rq)){
			str.append(" and inv_accept = 'n'");
		} else if("hadpay".equals(rq)) {
			str.append(" and pay_man is not null");
		}
		//2013-6-22注销
		if(user.getId()!=103) {
			str.append(" and app_user = '" + user.getName() + "'");
		}
//		if(company !=null && !"".equals(company)){
//			str.append(" and inv_head like '%"+company+"%'");
//		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ApplicationForm> list = new ArrayList<ApplicationForm>();
		String sql = "select * from t_application where 1 = 1" + str + "  order by app_id desc";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ApplicationForm af = new ApplicationForm();
				af.setId(rs.getInt("id"));
				af.setApp_id(rs.getString("app_id"));
				af.setInv_type(rs.getString("inv_type"));
				af.setInv_accept(rs.getString("inv_accept"));
				af.setInv_head(rs.getString("inv_head"));
				af.setApp_user(rs.getString("app_user"));
				af.setApp_time(rs.getTimestamp("app_time"));
				af.setPay_method(rs.getString("pay_method"));
				af.setPay_type(rs.getString("pay_type"));
				af.setPrepay_time1(rs.getTimestamp("prepay_time1"));
				af.setPrepay_time2(rs.getTimestamp("prepay_time2"));
				af.setPrepay_time3(rs.getTimestamp("prepay_time3"));
				af.setPay_time(rs.getTimestamp("pay_time"));
				af.setPay_man(rs.getString("pay_man"));
				af.setContract_code1(rs.getString("contract_code1"));
				af.setContract_code2(rs.getString("contract_code2"));
				af.setContract_code3(rs.getString("contract_code3"));
				af.setContract_content1(rs.getString("contract_content1"));
				af.setContract_content2(rs.getString("contract_content2"));
				af.setContract_content3(rs.getString("contract_content3"));
				af.setContract_price1(rs.getFloat("contract_price1"));
				af.setContract_price2(rs.getFloat("contract_price2"));
				af.setContract_price3(rs.getFloat("contract_price3"));
				af.setFirst_pay(rs.getFloat("first_pay"));
				af.setSecond_pay(rs.getFloat("second_pay"));
				af.setThird_pay(rs.getFloat("third_pay"));
				af.setAudit_time(rs.getTimestamp("audit_time"));
				af.setAuditman(rs.getString("auditman"));
				af.setIsaudit(rs.getString("isaudit"));
				af.setDept(rs.getString("dept"));
				af.setItem(rs.getInt("item"));
				af.setTags(rs.getString("tags"));
				af.setApp_user(rs.getString("app_user"));
				Supplier sup = new Supplier();
				
				getSupplier(rs.getInt("supplierid"),sup);
				af.setSup(sup);
				
				list.add(af);
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
//	
	/**
	 * 得到所有受款单位
	 * @return
	 */
	public List<Supplier> getAllSup() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Supplier> list = new ArrayList<Supplier>();
		String sql = "select * from t_supplier";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Supplier sup = new Supplier();
				sup.setId(rs.getInt("id"));
				sup.setName(rs.getString("name"));
				sup.setBank(rs.getString("bank"));
				sup.setCreditname(rs.getString("creditname"));
				sup.setCreditcard(rs.getString("creditcard"));
				
				list.add(sup);
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
	
	private void getSupplier(int id,Supplier sup) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from t_supplier where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sup.setName(rs.getString("name"));
				sup.setBank(rs.getString("bank"));
				sup.setCreditname(rs.getString("creditname"));
				sup.setCreditcard(rs.getString("creditcard"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * 根据ID得到Supplier
	 * @param id
	 * @return
	 */
	public Supplier getSupplierById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Supplier sup = new Supplier();
		String sql = "select * from t_supplier where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sup.setId(rs.getInt("id"));
				sup.setName(rs.getString("name"));
				sup.setBank(rs.getString("bank"));
				sup.setCreditname(rs.getString("creditname"));
				sup.setCreditcard(rs.getString("creditcard"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return sup;
	}
	
	public int getSupplierByName(String name) {
		int id = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from t_supplier where name = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return id;
	}

	/**
	 * 根据App_Id查找款项申请表
	 * @return
	 */
	public ApplicationForm getAppById(String app_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ApplicationForm af = null;
		String sql = "select * from t_application where app_id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, app_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				af = new ApplicationForm();
				af.setId(rs.getInt("id"));
				af.setApp_id(rs.getString("app_id"));
				af.setInv_type(rs.getString("inv_type"));
				af.setInv_accept(rs.getString("inv_accept"));
				af.setInv_head(rs.getString("inv_head"));
				af.setApp_user(rs.getString("app_user"));
				af.setApp_time(rs.getTimestamp("app_time"));
				af.setPay_method(rs.getString("pay_method"));
				af.setPay_type(rs.getString("pay_type"));
				af.setPrepay_time1(rs.getTimestamp("prepay_time1"));
				af.setPrepay_time2(rs.getTimestamp("prepay_time2"));
				af.setPrepay_time3(rs.getTimestamp("prepay_time3"));
				af.setPay_time(rs.getTimestamp("pay_time"));
				af.setPay_man(rs.getString("pay_man"));
				af.setContract_code1(rs.getString("contract_code1"));
				af.setContract_code2(rs.getString("contract_code2"));
				af.setContract_code3(rs.getString("contract_code3"));
				af.setContract_content1(rs.getString("contract_content1"));
				af.setContract_content2(rs.getString("contract_content2"));
				af.setContract_content3(rs.getString("contract_content3"));
				af.setContract_price1(rs.getFloat("contract_price1"));
				af.setContract_price2(rs.getFloat("contract_price2"));
				af.setContract_price3(rs.getFloat("contract_price3"));
				af.setFirst_pay(rs.getFloat("first_pay"));
				af.setSecond_pay(rs.getFloat("second_pay"));
				af.setThird_pay(rs.getFloat("third_pay"));
				af.setAudit_time(rs.getTimestamp("audit_time"));
				af.setAuditman(rs.getString("auditman"));
				af.setIsaudit(rs.getString("isaudit"));
				af.setDept(rs.getString("dept"));
				af.setItem(rs.getInt("item"));
				af.setTags(rs.getString("tags"));
				
				Supplier sup = new Supplier();
				
				getSupplier(rs.getInt("supplierid"),sup);
				af.setSup(sup);
				
			}

			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return af;
	}
	
	
	public ApplicationForm getApp(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ApplicationForm af = null;
		String sql = "select * from t_application where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				af = new ApplicationForm();
				af.setId(rs.getInt("id"));
				af.setApp_id(rs.getString("app_id"));
				af.setInv_type(rs.getString("inv_type"));
				af.setInv_accept(rs.getString("inv_accept"));
				af.setInv_head(rs.getString("inv_head"));
				af.setApp_user(rs.getString("app_user"));
				af.setApp_time(rs.getTimestamp("app_time"));
				af.setPay_method(rs.getString("pay_method"));
				af.setPay_type(rs.getString("pay_type"));
				af.setPrepay_time1(rs.getTimestamp("prepay_time1"));
				af.setPrepay_time2(rs.getTimestamp("prepay_time2"));
				af.setPrepay_time3(rs.getTimestamp("prepay_time3"));
				af.setPay_time(rs.getTimestamp("pay_time"));
				af.setPay_man(rs.getString("pay_man"));
				af.setContract_code1(rs.getString("contract_code1"));
				af.setContract_code2(rs.getString("contract_code2"));
				af.setContract_code3(rs.getString("contract_code3"));
				af.setContract_content1(rs.getString("contract_content1"));
				af.setContract_content2(rs.getString("contract_content2"));
				af.setContract_content3(rs.getString("contract_content3"));
				af.setContract_price1(rs.getFloat("contract_price1"));
				af.setContract_price2(rs.getFloat("contract_price2"));
				af.setContract_price3(rs.getFloat("contract_price3"));
				af.setFirst_pay(rs.getFloat("first_pay"));
				af.setSecond_pay(rs.getFloat("second_pay"));
				af.setThird_pay(rs.getFloat("third_pay"));
				af.setAudit_time(rs.getTimestamp("audit_time"));
				af.setAuditman(rs.getString("auditman"));
				af.setIsaudit(rs.getString("isaudit"));
				af.setDept(rs.getString("dept"));
				af.setItem(rs.getInt("item"));
				af.setTags(rs.getString("tags"));
				
				Supplier sup = new Supplier();
				
				getSupplier(rs.getInt("supplierid"),sup);
				af.setSup(sup);
				
			}

			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return af;
	}
	
	/**
	 * 审核申请表
	 * @param app_id
	 * @return
	 */
	public synchronized boolean confirmApplication(ApplicationForm af) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_application set auditman=?,audit_time=now(),isaudit='y' where app_id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, af.getAuditman());
			pstmt.setString(2, af.getApp_id());

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
	public synchronized boolean payConfirm(ApplicationForm af) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_application set pay_man=?,pay_time=now() where app_id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, af.getPay_man());
			pstmt.setString(2, af.getApp_id());

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
	 * 发票已收确认
	 * @param af
	 * @return
	 */
	public synchronized boolean acceptConfirm(ApplicationForm af) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_application set inv_accept='y' where app_id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, af.getApp_id());

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
	
	
	public List<Supplier> getAllSuppliers() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Supplier> list = new ArrayList<Supplier>();
		String sql = "select * from t_supplier";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Supplier sup = new Supplier();
				sup.setName(rs.getString("name"));
				sup.setBank(rs.getString("bank"));
				sup.setCreditname(rs.getString("creditname"));
				sup.setCreditcard(rs.getString("creditcard"));
				
				
				list.add(sup);
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
	
	
	public String getItemById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = "";
		String sql = "select * from t_item where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return name;
	}
	
}
