package com.lccert.crm.quotation;

import java.awt.image.BufferStrategy;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.kis.Item;
import com.lccert.crm.kis.ItemAction;
import com.lccert.crm.kis.OrderAction;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;
import com.lccert.crm.vo.SalesOrderItem;
import com.lccert.oa.db.ImsDB;
import com.lccert.www.UpdateWebSite;
import com.mysql.jdbc.Statement;

/**
 * 订单管理类（包括Service层和dao层）
 * 
 * @author eason
 * 
 */
public class QuotationAction {

	private static QuotationAction instance = new QuotationAction();

	private QuotationAction() {

	}

	public static QuotationAction getInstance() {
		return instance;
	}

	
	
	/**
	 * 添加报价单
	 * 
	 * @param qt
	 * @return
	 */
	public boolean addQuotation(Quotation qt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_quotation(vpid,dcompletetime,vcompany,vsales,"
				+ "vprojectcontent,vclient,ftotalprice,vinvhead,"
				+ "eadvancetype,einvtype,finvcount,vcreateuser,vstatus,equotype,vtag,einvmethod," +
						"vinvcontent,fstandprice,fprespefund,voldpid,rpclient,greenchannel,vauditman,amstart,amend,pmstart,pmend," +
						"confirmid,product,dcollection,dtest,dreceipt,vsampling,dsampltime,dcreatetime) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, qt.getPid());
			if(qt.getCompletetime() ==null){
				pstmt.setTimestamp(2, null);
			}else{
				pstmt.setTimestamp(2, new Timestamp(qt.getCompletetime().getTime()));
			}
			pstmt.setString(3, qt.getCompany());
			pstmt.setString(4, qt.getSales());
			pstmt.setString(5, qt.getProjectcontent());
			pstmt.setString(6, qt.getClient());
			pstmt.setFloat(7, qt.getTotalprice());
			pstmt.setString(8, qt.getInvhead());
			pstmt.setString(9, qt.getAdvancetype());
			pstmt.setString(10, qt.getInvtype());
			pstmt.setFloat(11, qt.getInvcount());
			pstmt.setString(12, qt.getCreateuser());
			pstmt.setString(13, qt.getStatus());
			pstmt.setString(14, qt.getQuotype());
			pstmt.setString(15, qt.getTag());
			pstmt.setString(16, qt.getInvmethod());
			pstmt.setString(17, qt.getInvcontent());
			pstmt.setFloat(18, qt.getStandprice());
			pstmt.setFloat(19, qt.getPrespefund());
			pstmt.setString(20, qt.getOldPid());
			pstmt.setString(21, qt.getRpclient());
			pstmt.setString(22, qt.getGreenchannel());
			pstmt.setString(23, qt.getAuditman());
			pstmt.setString(24, qt.getAmstart());
			pstmt.setString(25, qt.getAmend());
			pstmt.setString(26, qt.getAmstart());
			pstmt.setString(27, qt.getAmend());
			pstmt.setInt(28, qt.getConfirmid());
			pstmt.setString(29, qt.getProduct());
			if(qt.getCollection()== null){
				pstmt.setTimestamp(30,null);
			}else{
				pstmt.setTimestamp(30,new Timestamp(qt.getCollection().getTime()));
			}
			if(qt.getTest()== null){
				pstmt.setTimestamp(31,null);
			}else{
				pstmt.setTimestamp(31,new Timestamp(qt.getTest().getTime()));
			}
			if(qt.getReceipt()== null){
				pstmt.setTimestamp(32,null);
			}else{
				pstmt.setTimestamp(32,new Timestamp(qt.getReceipt().getTime()));
			}
			pstmt.setString(33,qt.getSampling());
			if(qt.getSampltime()== null){
				pstmt.setTimestamp(34,null);
			}else{
				pstmt.setTimestamp(34,new Timestamp(qt.getSampltime().getTime()));
			}
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
			//更新网站数据
			int key = 0;
			rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				key = rs.getInt(1);
			}
			UpdateWebSite up = new UpdateWebSite();
			up.setId(key);
			up.setType("quotation");
			Thread t = new Thread(up);
			t.start();
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
	 * 修改报价单
	 * @param qt
	 * @return
	 */
	public boolean updateQuotation(Quotation qt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_quotation set vpid=?,equotype=?,dcompletetime=?,vcompany=?,vsales=?,"
				+ "vprojectcontent=?,vclient=?,ftotalprice=?,vinvhead=?,"
				+ "eadvancetype=?,einvtype=?,finvcount=?,vcreateuser=?,"
				+ "vtag=?,einvmethod=?,vinvcontent=?,fstandprice=?,fprespefund=? where vpid = ?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);

			pstmt.setString(1, qt.getPid());
			pstmt.setString(2, qt.getQuotype());
			pstmt.setTimestamp(3, new Timestamp(qt.getCompletetime().getTime()));
			pstmt.setString(4, qt.getCompany());
			pstmt.setString(5, qt.getSales());
			pstmt.setString(6, qt.getProjectcontent());
			pstmt.setString(7, qt.getClient());
			pstmt.setFloat(8, qt.getTotalprice());
			pstmt.setString(9, qt.getInvhead());
			pstmt.setString(10, qt.getAdvancetype());
			pstmt.setString(11, qt.getInvtype());
			pstmt.setFloat(12, qt.getInvcount());
			pstmt.setString(13, qt.getCreateuser());
			pstmt.setString(14, qt.getTag());
			pstmt.setString(15, qt.getInvmethod());
			pstmt.setString(16, qt.getInvcontent());
			pstmt.setFloat(17, qt.getStandprice());
			pstmt.setFloat(18, qt.getPrespefund());
			pstmt.setString(19, qt.getPid());

			pstmt.executeUpdate();
			
			conn.commit();
			isok = true;
			
			//更新网站数据
			UpdateWebSite up = new UpdateWebSite();
			up.setId(qt.getId());
			up.setType("quotation");
			Thread t = new Thread(up);
			t.start();
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
	 * 财务确认收到报价单
	 * 
	 * @param pid
	 * @return
	 */
	public boolean confirmQuotation(String strPid,String confirmuser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_quotation set econfirm='已收到',vconfirmuser=?,dconfirmtime=now() where vpid like '%"+strPid+"%'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, confirmuser);
//			pstmt.setString(2, pid);

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
	 * 客服审核报价单
	 * @param pid
	 * @return
	 */
	public boolean auditQuotation(String pid,String auditman) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_quotation set eaudit='已审核',vauditman=?,daudittime=now() where vpid = ?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, auditman);
			pstmt.setString(2, pid);

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
	 * 查找我的报价单
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getAllQuotations(int pageNo, int pageSize,
			String sales) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Quotation> list = new ArrayList<Quotation>();
		String sql = "select * from t_quotation where vsales = ? order by dcreatetime desc limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sales);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				qt.setId(rs.getInt("id"));
				qt.setPid(rs.getString("vpid"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setStandprice(rs.getFloat("fstandprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setSubcost(rs.getFloat("fsubcost"));
				qt.setInsubcost(rs.getFloat("finsubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setAgcost(rs.getFloat("fagcost"));

				list.add(qt);
			}
			int totalRecords = getSalesTotalRecords(conn, sales);
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

//	/**
//	 * 取得我的报价单记录数
//	 * 
//	 * @param conn
//	 *            connection
//	 * @param createuser
//	 * @return 我的报价单记录数
//	 */
	private int getTotalRecords(Connection conn, String createuser) {
		String sql = "select count(*) from t_quotation where vcreateuser = ?";
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, createuser);
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

	/**
	 * 查找所有的报价单
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getAllQuotations(int pageNo, int pageSize) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Quotation> list = new ArrayList<Quotation>();
		String sql = "select * from t_quotation order by dcreatetime desc limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				qt.setId(rs.getInt("id"));
				qt.setPid(rs.getString("vpid"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setStandprice(rs.getFloat("fstandprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setSubcost(rs.getFloat("fsubcost"));
				qt.setInsubcost(rs.getFloat("finsubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setAgcost(rs.getFloat("fagcost"));

				list.add(qt);
			}
			int totalRecords = getTotalRecords(conn);
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
	/**
	 * 查找财务签单的所有的报价单并分页
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getAllBills(int pageNo, int pageSize,String start,FinanceQuotationUtil fqu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Quotation> list = new ArrayList<Quotation>();
		StringBuffer str =new StringBuffer();
		if(start.equals("yesDateLCQ1")||start.equals("yesMoneyLCQ1")){
		str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQ1%'");
		}
		if(start.equals("nowDateLCQ1")||start.equals("nowMoneyLCQ1")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQ1%'");
		}
		if(start.equals("nowMonthLCQ1")||start.equals("nowMMoneyLCQ1")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQ1%'");
		}
		if(start.equals("yesDateLCQ2")||start.equals("yesMoneyLCQ2")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQ2%'");
		}
		if(start.equals("nowDateLCQ2")||start.equals("nowMoneyLCQ2")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQ2%'");
		}
		if(start.equals("nowMonthLCQ2")||start.equals("nowMMoneyLCQ2")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQ2%'");
		}
		if(start.equals("yesDateLCQD")||start.equals("yesMoneyLCQD")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQD%'");
		}
		if(start.equals("nowDateLCQD")||start.equals("nowMoneyLCQD")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQD%'");
		}
		if(start.equals("nowMonthLCQD")||start.equals("nowMMoneyLCQD")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQD%'");
		}
		if(start.equals("yesDateLCQG")||start.equals("yesMoneyLCQG")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQG%'");
		}
		if(start.equals("nowDateLCQG")||start.equals("nowMoneyLCQG")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQG%'");
		}
		if(start.equals("nowMonthLCQG")||start.equals("nowMMoneyLCQG")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQG%'");
		}
		
		if (fqu.getStart() != null && !"".equals(fqu.getStart()) && fqu.getEnd() != null
				&& !"".equals(fqu.getEnd())) {
			if (fqu.getStart().equals(fqu.getEnd())) {
				str.append(" and dcreatetime like '%" + fqu.getStart() + "%'");
			} else {
				str.append(" and dcreatetime > '" + fqu.getStart()
						+ "' and dcreatetime < '" + fqu.getEnd() + "'");
			}
		}
		String sql = "select * from t_quotation WHERE  1=1 "+str.toString()+" order by dcreatetime desc limit "
			+ (pageNo - 1) * pageSize + ", " + pageSize;
//		System.out.println(sql+"-------");
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setSales(rs.getString("vsales"));
				qt.setClient(rs.getString("vclient"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setStatus(rs.getString("vstatus"));
				list.add(qt);
			}
			int totalRecords = getTotalRecordsBills(conn,start,fqu);
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
	
	
	
	/**
	 * 查找所有的报价单
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getAllSample(int pageNo, int pageSize,String pid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList();
		
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and vpid like '%" + pid + "%'");
		}
//		if(clientid != 0) {
//			str.append(" and clientid = " + clientid);
//		}
//		if ("no".equals(parttype)) {
//			str.append(" and status = 'n'");
//		} else if("yes".equals(parttype)){
//			str.append(" and status = 'y'");
//		}
//		str.append(" order by id desc");
//		String sql = str.toString();
		
		
		String sql = "select * from view_sample where 1=1 "+str+"limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				Project p =new Project();
				ChemProject cp=new ChemProject();
				Flow f=new Flow();
				qt.setCompany(rs.getString("vcompany"));
				qt.setClient(rs.getString("vclient"));
				p.setBuildtime(rs.getTimestamp("dbuildtime"));
				cp.setSamplename(rs.getString("vsamplename"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				p.setRid(rs.getString("vrid"));
				p.setLevel(rs.getString("vlevel"));
				f.setTestcount(rs.getInt("itestcount"));
				cp.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setPid(rs.getString("vpid"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setSales(rs.getString("vsales"));
				qt.setTag(rs.getString("vtag"));
				cp.setSendtime(rs.getTimestamp("dsendtime"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				p.setObjcp(cp);
				p.setObj(qt);
				p.setObjf(f);
				list.add(p);
				

			}
			int totalRecords = getTotalRecords(conn);
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

	
	/**
	 * 查找所有的报价单
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getAllSample1(int pageNo, int pageSize) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList();
		StringBuffer str = new StringBuffer();
		String sql = "select  a.vclient,a.vcompany,a.vprojectcontent ,a.dcompletetime ,a.vpid, a.ftotalprice,a.eadvancetype,a.fpreadvance, a.dinvtime,a.vsales,a.vtag,a.dcreatetime, b.dbuildtime,b.vrid,b.vlevel ,c.vsamplename,c.dcreatetime,c.dsendtime ,d.itestcount FROM ((t_quotation a  inner join t_project b on a.vpid=b.vpid) INNER JOIN t_chem_project c ON a.vpid=c.vpid) INNER JOIN t_chem_flow d ON a.vpid=d.vpid  order by a.dcreatetime desc limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				Project p =new Project();
				ChemProject cp=new ChemProject();
				Flow f=new Flow();
				qt.setCompany(rs.getString("vcompany"));
				qt.setClient(rs.getString("vclient"));
				p.setBuildtime(rs.getTimestamp("dbuildtime"));
				cp.setSamplename(rs.getString("vsamplename"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				p.setRid(rs.getString("vrid"));
				p.setLevel(rs.getString("vlevel"));
				f.setTestcount(rs.getInt("itestcount"));
				cp.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setPid(rs.getString("vpid"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setSales(rs.getString("vsales"));
				qt.setTag(rs.getString("vtag"));
				cp.setSendtime(rs.getTimestamp("dsendtime"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				p.setObjcp(cp);
				p.setObj(qt);
				p.setObjf(f);
				list.add(p);
			}
			int totalRecords = getTotalRecords(conn);
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

	/**
	 * 取得所有的记录数
	 * 
	 * @param conn
	 *            connection
	 * @param createuser
	 * @return 所有的记录数
	 */
	private int getTotalRecords(Connection conn) {
		String sql = "select count(*) from t_quotation";
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
	
	/**
	 * 取得财务签单所有的记录数
	 * 
	 * @param conn
	 *            connection
	 * @param createuser
	 * @return 所有的记录数
	 */
	private int getTotalRecordsBills(Connection conn,String start,FinanceQuotationUtil fqu) {
	
		StringBuffer str =new StringBuffer();
		if(start.equals("yesDateLCQ1")||start.equals("yesMoneyLCQ1")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQ1%'");
			}
		if(start.equals("nowDateLCQ1")||start.equals("nowMoneyLCQ1")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQ1%'");
		}
		if(start.equals("nowMonthLCQ1")||start.equals("nowMMoneyLCQ1")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQ1%'");
		}
		if(start.equals("yesDateLCQ2")||start.equals("yesMoneyLCQ2")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQ2%'");
		}
		if(start.equals("nowDateLCQ2")||start.equals("nowMoneyLCQ2")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQ2%'");
		}
		if(start.equals("nowMonthLCQ2")||start.equals("nowMMoneyLCQ2")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQ2%'");
		}
		if(start.equals("yesDateLCQD")||start.equals("yesMoneyLCQD")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQD%'");
		}
		if(start.equals("nowDateLCQD")||start.equals("nowMoneyLCQD")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQD%'");
		}
		if(start.equals("nowMonthLCQD")||start.equals("nowMMoneyLCQD")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQD%'");
		}
		if(start.equals("yesDateLCQG")||start.equals("yesMoneyLCQG")){
			str.append(" and TO_DAYS( NOW( ) ) - TO_DAYS (dcreatetime) =1 and vpid like 'LCQG%'");
		}
		if(start.equals("nowDateLCQG")||start.equals("nowMoneyLCQG")){
			str.append(" and date(dcreatetime) =curdate() and vpid like 'LCQG%'");
		}
		if(start.equals("nowMonthLCQG")||start.equals("nowMMoneyLCQG")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m') and vpid like 'LCQG%'");
		}
		if (fqu.getStart() != null && !"".equals(fqu.getStart()) && fqu.getEnd() != null
				&& !"".equals(fqu.getEnd())) {
			if (fqu.getStart().equals(fqu.getEnd())) {
				str.append(" and dcreatetime like '%" + fqu.getStart() + "%'");
			} else {
				str.append(" and dcreatetime > '" + fqu.getStart()
						+ "' and dcreatetime < '" + fqu.getEnd() + "'");
			}
		}
		String sql = "select count(*) from t_quotation where 1=1"+str.toString();
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

	/**
	 * 根据pid查找报价单
	 * 
	 * @param pid
	 * @return
	 */
	public Quotation getQuotationByPid(String pid) {
		String sql = "select * from t_quotation where vpid like '%"+pid+"%'";
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qt = new Quotation();
				qt.setId(rs.getInt("id"));
				qt.setPid(rs.getString("vpid"));
				qt.setObject(OrderAction.getInstance().getsamplenameByPid(qt.getPid())); //获取样品名称
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setStandprice(rs.getFloat("fstandprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setPreacount(rs.getFloat("fpreacount"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setSubcost(rs.getFloat("fsubcost"));
				qt.setInsubcost(rs.getFloat("finsubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setAgcost(rs.getFloat("fagcost"));
				qt.setClientid(rs.getInt("clientid"));
				qt.setSumOtherscost(findSumOtherscost(qt.getPid()));
				qt.setCollRemarks(rs.getString("vcollremarks"));
				qt.setRpclient(rs.getString("rpclient"));
				qt.setPaystatus(rs.getString("epaystatus"));
				qt.setFinish(rs.getTimestamp("dfinish"));
				qt.setGreenchannel(rs.getString("greenchannel"));
				qt.setOthercost(rs.getFloat("fothercost"));
				qt.setLock(rs.getString("vlock"));
				qt.setBadDebt(rs.getString("badDebt"));
				//获取客户地区
				qt.setClientContact(ClientAction.getInstance().getClientByName(rs.getString("vclient")).getArea());
//				qt.setClientContact(ClientAction.getInstance().getClientById(rs.getInt("clientid")).getArea());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return qt;
	}
	
	/**
	 * 根据pid查找报价单
	 * 
	 * @param pid
	 * @return
	 */
	public String  getQuotypeByPid(String pid) {
		String sql = "select * from t_quotation where vpid ='"+pid+"'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		String qtStr="";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qtStr=rs.getString("equotype");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return qtStr;
	}
	/**
	 * 根据pid查找报价单
	 * 
	 * @param pid
	 * @return
	 */
	public Quotation getQuotationByOldPid(String oldPid) {
		String sql = "select * from t_quotation where voldpid ='"+oldPid+"'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qt = new Quotation();
				qt.setId(rs.getInt("id"));
				qt.setPid(rs.getString("vpid"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setQuotype(rs.getString("equotype"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return qt;
	}
	
	
	
	/**
	 * 根据pid查找该报价单是否已经授权了
	 * 
	 * @param pid
	 * @return
	 */
	public String getAuthorizationPid(String pid) {
		//System.out.println(pid);
		String sql = "select authorization from t_quotation where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String authorization="";

		try {
			conn = DB.getConn();
		
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				authorization=rs.getString("authorization");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return authorization;
	}
	
	
	
	/**
	 * 根据pid查找该报价单是否已经授权了
	 * 
	 * @param pid
	 * @return
	 */
	public boolean updateAuthorizationPid(String userName,String pid) {
//		System.out.println(userName+"----------"+pid);
		String sql = "update t_quotation set authorization='y',authorizer=? where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String authorization="";
		boolean isok=false;
		boolean auto = false;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, pid);
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
			
		} catch (SQLException e) {
			isok=false;
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return 	isok;
	}
	
public float findSumOtherscost(String pid){
		String sql ="select  sum(fotherscost)as otherscost  from t_project where vpid =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		ResultSet rs = null;
		float agremarks =0.0f;
		int countChilds=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				agremarks=rs.getFloat("otherscost");
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return agremarks;
	}
	/**
	 * 根据pid查找报价单
	 * 
	 * @param pid
	 * @return
	 */
	public Quotation getEngByRid(String rid) {

		String sql = "select * from t_quotation where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		try {
			conn = DB.getConn();
		
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qt = new Quotation();
				qt.setId(rs.getInt("id"));
				qt.setPid(rs.getString("vpid"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setStandprice(rs.getFloat("fstandprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setPreacount(rs.getFloat("fpreacount"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setSubcost(rs.getFloat("fsubcost"));
				qt.setInsubcost(rs.getFloat("finsubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setAgcost(rs.getFloat("fagcost"));
				qt.setOthercost(rs.getFloat("fothercost"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return qt;
	}
	
	
	
	/**
	 * 根据pid查找报价单
	 * 
	 * @param pid
	 * @return
	 */
	public Quotation getQuotationById(int id) {
		String sql = "select * from t_quotation where id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setStandprice(rs.getFloat("fstandprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setSubcost(rs.getFloat("fsubcost"));
				qt.setInsubcost(rs.getFloat("finsubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setAgcost(rs.getFloat("fagcost"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return qt;
	}

	/**
	 * 动态（ajax方式）取得项目名称
	 * @param key
	 * @return
	 */
	public List<String> getprojectByAjax(String keywords) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<String> list = new ArrayList<String>();
		String sql = "select * from t_quotation where vprojectcontent like '%" + keywords
		+ "%' order by dcreatetime desc";
		try {
			conn = DB.getConn();
			//如果连接处于自动提交模式，则所有其 SQL 语句都将被执行并作为单独的事务提交。否则，其 SQL 语句将被分组到由提交或回滚方法终止的事务中。默认情况下，新连接处于自动提交模式。
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String sales = rs.getString("vprojectcontent");
				list.add(sales);
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
	
	
	/**
	 * 查询报价单
	 * 
	 * @param keywords
	 * @param type
	 * @return 报价单列表
	 */
	public List<Quotation> searchQuotation(String keywords, String type,String start) {
		
		String sql = "";
		if(start.equals("G")){
			if ("part".equals(type)) {
				sql = "select * from t_quotation where vpid like 'LCQG%" + keywords
				+ "%' order by dcreatetime desc";
			} else if ("all".equals(type)) {
				sql = "select * from t_quotation where vpid = " + keywords
						+ "order by dcreatetime desc"; 
			}
		}else if(start.equals("2")){
			if ("part".equals(type)) {
				sql = "select * from t_quotation where vpid like 'LCQ2%' or vpid like 'LCQG%" + keywords
				+ "%' order by dcreatetime desc";
			}
		}
		
		else{
		if ("part".equals(type)) {
			sql = "select * from t_quotation where vpid like '%" + keywords
					+ "%' order by dcreatetime desc";
		} else if ("all".equals(type)) {
			sql = "select * from t_quotation where vpid = " + keywords
					+ " order by dcreatetime desc";
		}
		}
		//System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		List<Quotation> list = new ArrayList<Quotation>();

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				Quotation qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				//根据旧的报价单号查询订单信息
				if(qt.getPid() !=null&&!"".equals(qt.getPid())){
					Quotation oldQt=getQuotationByOldPid(qt.getPid());
					if(oldQt !=null&& !"".equals(oldQt)){
						qt.setFluSum(oldQt.getTotalprice());
					}
				}
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));

				list.add(qt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	
	/**
	 * 搜索报价单
	 * @param pid
	 * @param client
	 * @param parttype
	 * @return
	 */
	public void searchQuotation(String pid, String client,
			String parttype, List<Quotation> list) {
		String str = "";
		if(pid !=null && !"".equals(pid)){
			str=" and vpid like '%" + pid+"%'";
		}
		if(client !=null && !"".equals(client)){
			str=" and vclient like '%" + client+"%'";
		}
		if (parttype !=null && !"".equals(parttype)) {
			if("no".equals(parttype)){
			str = "and  eisfinish = 'n' ";
			} else if ("yes".equals(parttype)){
			str =" and eisfinish = 'y'";	
			}
		} 
		String sql="select * from t_quotation  where 1=1 "+str+" order by dcreatetime desc";
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				qt.setId(rs.getInt("id"));
				qt.setPid(rs.getString("vpid"));
				//根据旧的报价单号查询订单信息
				if(qt.getPid() !=null&&!"".equals(qt.getPid())){
					Quotation oldQt=getQuotationByOldPid(qt.getPid());
					if(oldQt !=null){
						if(oldQt.getQuotype().equals("flu")){
						qt.setFluSum(oldQt.getTotalprice());
					}
					}
				}
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setStandprice(rs.getFloat("fstandprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setSubcost(rs.getFloat("fsubcost"));
				qt.setInsubcost(rs.getFloat("finsubcost"));
				qt.setPreagcost(rs.getFloat("fpreagcost"));
				qt.setAgcost(rs.getFloat("fagcost"));
				list.add(qt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * 搜索我地报价单（分页模式）
	 * @param pageNo
	 * @param pageSize
	 * @param sales
	 * @param pid
	 * @param client
	 * @param parttype
	 * @return
	 */
	public PageModel searchMyQuotation(int pageNo,int pageSize,String sales,String pid, String client,
			String parttype) {
		String sql = "";
		String str="";
		if(pid !=null&&!"".equals(pid.trim())){
			str+=" and vpid like '%" + pid+ "%'";
		}
		if(client !=null&&!"".equals(client.trim())){
			str+=" and vclient like '%" + client+ "%'";
		}
			str+="order by dcreatetime desc  limit "+ (pageNo - 1) * pageSize + "," + pageSize;
		if ("all".equals(parttype)) {
			sql = "select * from t_quotation where vsales='" + sales + "'  " +str;
		} else if ("no".equals(parttype)) {
			sql = "select * from t_quotation where vsales='" + sales + "' and eisfinish = 'n' and ftotalprice=fpreadvance+fsepay+fbalance "+str;
		} else {
			sql = "select * from t_quotation where vsales='" + sales + "' and eisfinish = 'y' and  ftotalprice > fpreadvance+fsepay+fbalance"+str;
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		PageModel pm = new PageModel();
		List<Quotation> list = new ArrayList<Quotation>();

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setSales(rs.getString("vsales"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				list.add(qt);
			}
			
			int totalRecords = getSalesTotalRecords(conn, sales);
			pm = new PageModel();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			pm.setList(list);
			pm.setTotalRecords(totalRecords);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pm;
	}
	
	
	public List getSaleName(){
		String sql = "select name from t_user where dept like '销售%'";
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserForm user =new UserForm();
				user.setName(rs.getString("name"));
				list.add(user);
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
	
	
	public List Statistics(){
		String sql = "select * from v_finance_3";
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		com.lccert.crm.vo.Statistics st =null;
		try {
			conn = DB.getConn();
			pstmt=conn.prepareStatement(sql);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				st=new com.lccert.crm.vo.Statistics();
				st.setTWTotalpric(rs.getFloat("周订单额"));
				st.setTWHPay(rs.getFloat("周收历史款"));
				st.setTWPay(rs.getFloat("周收当月款"));
				st.setTWPresubcost(rs.getFloat("周预分包费"));
				st.setTWSubcost(rs.getFloat("周实分包费"));
				st.setTWPreagcost(rs.getFloat("周预机构费"));
				st.setTWAgcost(rs.getFloat("周实机构费"));
				st.setTMTotalpric(rs.getFloat("月订单额"));
				st.setTMHPay(rs.getFloat("月收历史款"));
				st.setTMPay(rs.getFloat("月收当月款"));
				st.setTMPresubcost(rs.getFloat("月预分包费"));
				st.setTMSubcost(rs.getFloat("月实分包费"));
				st.setTMPreagcost(rs.getFloat("月预机构费"));
				st.setTMAgcost(rs.getFloat("月实机构费"));
				st.setTMHistoryPay(rs.getFloat("未收欠款"));
				list.add(st);
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
	
	public List Statistics5(){
		String sql = "select * from v_finance_5";
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		com.lccert.crm.vo.Statistics st =null;
		try {
			conn = DB.getConn();
			pstmt=conn.prepareStatement(sql);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				st=new com.lccert.crm.vo.Statistics();
				st.setTWTotalpric(rs.getFloat("周订单额"));
				//st.setTWHPay(rs.getFloat("周收历史款"));
				st.setTWHPay(rs.getFloat("周收历史款a")+rs.getFloat("周收历史款b")+rs.getFloat("周收历史款c"));
				st.setTWPay(rs.getFloat("周收当月款a")+rs.getFloat("周收当月款b")+rs.getFloat("周收当月款c"));
				st.setTWPresubcost(rs.getFloat("周预分包费"));
				st.setTWSubcost(rs.getFloat("周实分包费a")+rs.getFloat("周实分包费b"));
				st.setTWPreagcost(rs.getFloat("周预机构费"));
				st.setTWAgcost(rs.getFloat("周实机构费"));
				st.setTMTotalpric(rs.getFloat("月订单额"));
				st.setTMSTotalpric(rs.getFloat("月收订单额"));
				st.setTMHPay(rs.getFloat("月收历史款a")+rs.getFloat("月收历史款b")+rs.getFloat("月收历史款c"));
				st.setTMPay(rs.getFloat("月收当月款a")+rs.getFloat("月收当月款b")+rs.getFloat("月收当月款c"));
				st.setTMPresubcost(rs.getFloat("月预分包费"));
				st.setTMSubcost(rs.getFloat("月实分包费a")+rs.getFloat("月实分包费b"));
				st.setTMPreagcost(rs.getFloat("月预机构费"));
				st.setTMAgcost(rs.getFloat("月实机构费"));
				st.setTMHistoryPay(rs.getFloat("未收欠款"));
				st.setTMConfirmNotPay(rs.getFloat("已签单未收款"));
				list.add(st);
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
	
	

	public static void main(String[] args) {
		List list =ItemAction.getInstance().getAllItemNumber();
		for(int i=0;i<list.size();i++){
			Item it =(Item)list.get(i);
			String month="";
			for(int j=1;j<=12;j++){
				if(j<10){
					month="0"+j;
				}else{
					month=j+"";
				}
			}
		}
	}

	
	//统计每个项目的每个月的总金额
	public float getMonTotal(String itemNumber,String dept,String year,String month,int userid ){
		StringBuffer str = new StringBuffer();
		String last = "";
		//--------------2011-04-09注释---------------
		last="LCQ";
		if("销售二部".equals(dept)) {
			last=last+"2";
//			//str.append("2");//中山销售二部
		}else if("销售一部".equals(dept)) {
			last=last+"1";
		}else if("广州".equals(dept)) {
			last=last+"G";//
	} else if("东莞".equals(dept)) {
		last=last+"D";
	} 
		//--------------2011-04-09注释---------------
		Date date = new Date();
		if(year == null && "".equals(year)){
			year = new SimpleDateFormat("yyyy").format(date);	
		}
		if(month == null && "".equals(month)){
			month = new SimpleDateFormat("MM").format(date);
		}
		//if(userid ==54 || userid == 105 || userid == 141 || userid ==106 || userid ==103 || userid ==106){
		//-------------2011-04-09更改的--------------------
		//last=last+year+month;
		str.append(" and so.vpid like '"+last+"%'");
		//-------------2011-04-09更改的--------------------
			str.append(" and year(q.Dconfirmtime) ='"+year+"' and  month(q.Dconfirmtime) ='"+month+"'");
		//}
		if(itemNumber !=null){
			str.append(" and soi.item_number like '"+itemNumber+".%' ");
		}

		
		
		String sql = "select (a.a-b.a)as '总金额报价'  from (select sum((soq.count*soq.saleprice)) as a from t_sales_order as so,t_sales_order_item as soi ,t_sales_order_quoitem as soq,t_quotation as q  where so.id =soq.orderid and soi.id =soq.itemid and soi.id>1000 and q.vpid =so.vpid  "+str+" ) as a,(select  coalesce(sum((soq.count*soq.saleprice)),0) as a from t_sales_order as so,t_sales_order_item as soi ,t_sales_order_quoitem as soq,t_quotation as q  where so.id =soq.orderid and soi.id =soq.itemid and soi.id>1000 and q.vpid =so.vpid  "+str+"  and q.equotype ='flu')as b";
		
		if(Integer.parseInt(month)==12 && itemNumber.equals("21")){
//		System.out.println(sql);
		}
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		float monTotal =0.0f;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				monTotal=rs.getFloat(("总金额报价"));
				//System.out.println(monTotal+"-------------");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return monTotal;
		
	}

	//统计每个项目的每个月信息结果
	public List  getMonTotalInfor(String itemNumber,String year,String month,String last){
		String sql = "select so.vpid,soi.item_number,(soq.count*soq.saleprice) as a,soi.name,q.equotype  from t_sales_order as so,t_sales_order_item as soi ,t_sales_order_quoitem as soq,t_quotation as q  where so.id =soq.orderid and soi.id =soq.itemid and soi.id>1000 and q.vpid =so.vpid and so.vpid like '"+last+"%'   and year(q.Dconfirmtime) ='"+year+"' and month(q.Dconfirmtime) ='"+month+"' and soi.item_number like '"+itemNumber+".%'  ";
		//System.out.println(sql+"---");
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				List temp =new ArrayList();
				temp.add(rs.getString("vpid"));
				temp.add(rs.getString("item_number"));
				temp.add(rs.getString("name"));
				temp.add(rs.getString("equotype"));
				temp.add(rs.getFloat("a"));
				list.add(temp);
				
				
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
	
	
	//统计所有项目的每个月的总金额、未收金额、利润
	public List getMonPrice(String dept,String year,String month){
		StringBuffer str = new StringBuffer();
		String last = "";
		last="LCQ";
		if("销售二部".equals(dept)) {
			last=last+"2";
//			//str.append("2");//中山销售二部
		}else if("销售一部".equals(dept)) {
			last=last+"1";
		}else if("广州".equals(dept)) {
			last=last+"G";//
	} else if("东莞".equals(dept)) {
		last=last+"D";
	} 
		Date date = new Date();
		if(year == null && "".equals(year)){
			year = new SimpleDateFormat("yyyy").format(date);	
		}
		if(month == null && "".equals(month)){
			month = new SimpleDateFormat("MM").format(date);
		}
//		last=last+year+month;
		str.append(" and so.vpid like '"+last+"%'");
		str.append(" and year(q.Dconfirmtime) ='"+year+"' and  month(q.Dconfirmtime) ='"+month+"'");
		String sql = "select sum(a.a) as '总金额',sum(a.b) as '未收金额',sum(a.c) as  '利润' from (select distinct(so.vpid) as '报价单',q.Ftotalprice as a,(q.Ftotalprice-q.Fpreadvance-q.Fsepay-Fbalance)as b,(q.Fpreadvance+q.Fsepay+q.Fbalance-q.Fspefund-q.Ftax)as c from t_sales_order as so,t_sales_order_item as soi ,t_sales_order_quoitem as soq,t_quotation as q  where so.id =soq.orderid and soi.id =soq.itemid and soi.id>1000 "+str+"   and q.vpid =so.vpid and  q.equotype !='flu'  ) as a;";
//		System.out.println(sql);
//		if(Integer.parseInt(month)==3){
//			System.out.println(sql);
//		}
//		
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		float inTotal =0.0f;
		float inunDe =0.0f;
		float profit=0.0f;
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				inTotal=rs.getFloat(("总金额"));
				inunDe=rs.getFloat("未收金额");
				profit=rs.getFloat("利润");
			list.add(inTotal);
			list.add(inunDe);
			list.add(profit);
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
	
	
//	/***
//	 * 
//	 */
//	
//	//统计所有项目的每个月的总金额、未收金额、利润
//	public float getprofit(String dept,String year,String month){
//		StringBuffer str = new StringBuffer();
//		String last = "";
//		last="LCQ";
//		if("销售二部".equals(dept)) {
//			last=last+"2";
////			//str.append("2");//中山销售二部
//		}else if("销售一部".equals(dept)) {
//			last=last+"1";
//		}else if("广州".equals(dept)) {
//			last=last+"G";//
//	} else if("东莞".equals(dept)) {
//		last=last+"D";
//	} 
//		Date date = new Date();
//		if(year == null && "".equals(year)){
//			year = new SimpleDateFormat("yyyy").format(date);	
//		}
//		if(month == null && "".equals(month)){
//			month = new SimpleDateFormat("MM").format(date);
//		}
////		last=last+year+month;
//		str.append(" and so.vpid like '"+last+"%'");
//		str.append(" and year(q.Dconfirmtime) ='"+year+"' and  month(q.Dconfirmtime) ='"+month+"'");
//		String sql = "select sum(a.c) as c  from (select distinct(so.vpid) as '报价单',(q.Fpreadvance+q.Fsepay+q.Fbalance-q.Fspefund-q.Ftax-p.Fsubcost-p.Fsubcost2-p.Fagcost)as c from t_sales_order as so,t_sales_order_item as soi ,t_sales_order_quoitem as soq,t_quotation as q ,t_project  as p  where so.id =soq.orderid and soi.id =soq.itemid and soi.id>1000 "+str+"   and q.vpid =so.vpid and  q.equotype !='flu'  ) as a;";
//		//System.out.println(sql);
////		if(Integer.parseInt(month)==3){
////			System.out.println(sql);
////		}
////		
//		String pid = null;
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		float profit=0.0f;
//		List list =new ArrayList();
//		try {
//			conn = DB.getConn();
//			pstmt = DB.prepareStatement(conn, sql);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				
//			profit=rs.getFloat("c");
//			list.add(profit);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
//		}
//		return profit;
//		
//	}
	
	
	/**
	 * 统计所有项目的每个月的总金额、未收金额、利润信息结果
	 * @param args
	 */
	public List  getMonAllItemInfor(String year,String month,String last){
		String sql = "select distinct(so.vpid) as vpid,(soq.count*soq.saleprice) as a,((soq.count*soq.saleprice)-q.Fpreadvance-q.Fsepay-Fbalance)as b,(q.Fpreadvance+q.Fsepay+q.Fbalance-q.Fspefund-q.Ftax)as c ,soi.item_number ,soi.name,q.equotype,soq.samplename from t_sales_order as so,t_sales_order_item as soi ,t_sales_order_quoitem as soq,t_quotation as q  where so.id =soq.orderid and soi.id =soq.itemid and soi.id>1000 and so.vpid like '"+last+"%' and year(q.Dconfirmtime) ='"+year+"' and month(q.Dconfirmtime) ='"+month+"'  and q.vpid =so.vpid and   q.equotype !='flu'  ";
		//System.out.println(sql);
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				List temp =new ArrayList();
				temp.add(rs.getString("vpid"));
				temp.add(rs.getString("item_number"));
				temp.add(rs.getString("name"));
				temp.add(rs.getString("equotype"));
				temp.add(rs.getFloat("a"));
				temp.add(rs.getFloat("b"));
				temp.add(rs.getFloat("c"));
				list.add(temp);
				
				
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
	 * 
	 * @param args
	 */
//	public static void main(String[] args) {
//		
//		
////		List list =QuotationAction.getInstance().getSaleName();
////		for(int i=0;i<list.size();i++){
////			UserForm user=(UserForm)list.get(i);
////			List temp =QuotationAction.getInstance().getPerAchicrements(user.getName());
////			for(int j=0;j<temp.size();j++){
////			}
////			System.out.print(user.getName());
////			System.out.println();
////			
////		}
//		float inTotal =0.0f;
//		float inunDe =0.0f;
//		float hiDe =0.0f;
//		float inHiReDe =0.0f; 
//		
//		
//		List list =UserAction.getInstance().getUserBySuperiorid(54);
//		for(int i=0;i<list.size();i++){
//			UserForm user =(UserForm)list.get(i);
//			List temp =QuotationAction.getInstance().getPerAchicrements(user.getName());
//			for(int j=0;j<temp.size();j++){
//				System.out.print(temp.get(j)+"\t");
//				if(j==1){
//					inTotal+=Float.parseFloat(temp.get(1).toString());
//				}
//					//System.out.print("-----------"+inTotal+":inTotal");
//				if(j==2){
//					inunDe=inunDe+Float.parseFloat(temp.get(2).toString());
//				}
//				if(j==3){	
//				hiDe=hiDe+Float.parseFloat(temp.get(3).toString());
//				}
//				if(j==0){
//					inHiReDe=inHiReDe+Float.parseFloat(temp.get(0).toString());
//				}
//				}
//			System.out.println();
//		}
//		System.out.println("本月总金额："+inTotal+"\t"+"本月未收金额:"+inunDe+"\t"+"历史欠款："+hiDe+"\t"+"本月收历史欠款："+inHiReDe);
//		
//	}
	
	
	public List getSuperiorAchicrements(int superiorId){
		float inTotal =0.0f;
		float inunDe =0.0f;
		float hiDe =0.0f;
		float inHiReDe =0.0f; 
		List superiorList =new ArrayList();
		List list =UserAction.getInstance().getUserBySuperiorid(superiorId);
		for(int i=0;i<list.size();i++){
			UserForm user =(UserForm)list.get(i);
			List temp =QuotationAction.getInstance().getPerAchicrements(user.getName());
			for(int j=0;j<temp.size();j++){
				if(j==1){
					inTotal+=Float.parseFloat(temp.get(1).toString());
				}
				if(j==2){
					inunDe=inunDe+Float.parseFloat(temp.get(2).toString());
				}
				if(j==3){	
				hiDe=hiDe+Float.parseFloat(temp.get(3).toString());
				}
				if(j==0){
					inHiReDe=inHiReDe+Float.parseFloat(temp.get(0).toString());
				}
				}
		}
		superiorList.add(inHiReDe);
		superiorList.add(inTotal);
		superiorList.add(inunDe);
		superiorList.add(hiDe);
		return superiorList;
		
	}
	
	/**
	 *统计销售人员的 本月已收历史欠款、本月订单总额、本月未结金额、历史欠款的总金额
	 * @param sales
	 * @return
	 */
	public List getPerAchicrements(String sales){
		String sql = "select a.aa+b.bb+c.cc as '本月已收历史欠款' ,d.totalprice  as '本月订单总额',f.q  as '本月未结金额',g.i as '历史欠款' from (select COALESCE(SUM(Fsepay),0)  as aa  from t_quotation where date_format(dcreatetime,'%Y-%m')<=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')  and date_format(Dsepaytime,'%Y-%m')=date_format(now(),'%Y-%m') and ftotalprice=(fpreadvance+fsepay+fbalance) and Fsepay>0 and vsales='"+sales+"') as a,(select COALESCE(SUM(Fbalance),0)   as  bb from t_quotation where date_format(dcreatetime,'%Y-%m')<=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')  and date_format(dbalancetime,'%Y-%m')=date_format(now(),'%Y-%m') and ftotalprice=(fpreadvance+fsepay+fbalance) and Fbalance>0 and vsales='"+sales+"') as b ,(select COALESCE(SUM(Fpreadvance),0)  as cc from t_quotation where date_format(dcreatetime,'%Y-%m')<=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')  and date_format(Dpaytime,'%Y-%m')=date_format(now(),'%Y-%m') and ftotalprice=(fpreadvance+fsepay+fbalance) and Fpreadvance>0 and vsales='"+sales+"')as c ,(select sum(ftotalprice)  as totalprice  from t_quotation where vsales='"+sales+"' and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m')) as d ,(select (sum(ftotalprice) -(sum(fpreadvance) + sum(fsepay) + sum(fbalance)))  as q from t_quotation where vsales='"+sales+"'   and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m')) as f ,(select (sum(ftotalprice) -(sum(fpreadvance) + sum(fsepay) + sum(fbalance)))as i  from t_quotation where dcreatetime<=concat(last_day(date_add(now(),interval -1 MONTH)) ,' 23:59:00') and dcreatetime>=DATE_FORMAT(concat(extract(year_month from date_add(now(),interval -3 MONTH)),'01'),'%Y-%m-%d') and vsales='"+sales+"' ) as g";
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getFloat("本月已收历史欠款"));
				list.add(rs.getFloat("本月订单总额"));
				list.add(rs.getFloat("本月未结金额"));
				list.add(rs.getFloat("历史欠款"));
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
	 *查询销售人员的 本月已收历史欠款、本月订单总额、本月未结金额、历史欠款的记录数据
	 * @param sales
	 * @return
	 */
	public List getStatisticsInfor(String sales,String status){
		StringBuffer str =new StringBuffer();
		//本月未收欠款和本月报价总金额
		if(status.equals("InTotal")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m')");
		} 
		
		//本月未收欠款和本月报价总金额
		if(status.equals("InunDe")){
			str.append(" and date_format(dcreatetime,'%Y-%m')=date_format(now(),'%Y-%m')and ftotalprice>(fpreadvance+fsepay+fbalance)");
		} 
		//本月已收历史欠款
		if(status.equals("InHiReDe")){
			str.append(" and date_format(dcreatetime,'%Y-%m')<=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m')  and ((date_format(Dpaytime,'%Y-%m')=date_format(now(),'%Y-%m')) or(date_format(dbalancetime,'%Y-%m')=date_format(now(),'%Y-%m'))  or (date_format(Dsepaytime,'%Y-%m')=date_format(now(),'%Y-%m') )) and ftotalprice=(fpreadvance+fsepay+fbalance)");
		}
		//历史欠款
		//本月未收欠款和本月报价总金额
		if(status.equals("HiDe")){
			str.append(" and dcreatetime<=concat(last_day(date_add(now(),interval -1 MONTH)) ,' 23:59:00') and dcreatetime>=DATE_FORMAT(concat(extract(year_month from date_add(now(),interval -12 MONTH)),'01'),'%Y-%m-%d') and ftotalprice>(fpreadvance+fsepay+fbalance)");
		} 
		String sql = "select *  from t_quotation where vsales=?"+str.toString();
		//System.out.println(sql+"----//"+sales);
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
	
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sales);
			
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation q =new Quotation();
				q.setPid(rs.getString("vpid"));
				q.setClient(rs.getString("vclient"));
				q.setSales(rs.getString("vsales"));
				q.setTotalprice(rs.getFloat("ftotalprice"));
				q.setPreadvance(rs.getFloat("fpreadvance"));
				q.setSepay(rs.getFloat("fsepay"));
				q.setBalance(rs.getFloat("fbalance"));
				list.add(q);
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
	 * 根据销售名称取得销售总额
	 * @param conn
	 * @param sales
	 * @return
	 */
	private int getSalesTotalRecords(Connection conn, String sales) {
		String sql = "select count(*) from t_quotation where vsales = ?";
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sales);
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
	
	/**
	 * 根据报告号rid取得报价单号pid
	 * @param rid
	 * @param client
	 * @param parttype
	 * @param list
	 */
	public void getPidByRid(String rid ,String client ,String parttype ,List<Quotation> list) {
		String sql = "select vpid from t_chem_project where vrid like '%" + rid + "%' or filingno like '%"+rid+"%'";
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				pid = rs.getString("vpid");
				searchQuotation(pid,client,parttype,list);
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
	 * 分项目财务款项登记更新
	 * 
	 * @param qt
	 * @return
	 */
	public boolean updateProject(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		//p.setPresubcost(strPresubcost);
		//p.setPresubcost2(strPresubcost2);
		//p.setPreagcost(preagcost);
		String sql = "update t_project set dsubcosttime=?,vsubcostnotes=?,vinsubtag=?,"
				+ "fagcost=?,dagtime=?,vagnotes=?,fotherscost=?,votherstag=?,finvprice=?,"
				+ "fpacount=?,fsubcost=?,fsubcost2=?,fpresubcost=?,fpresubcost2=?,fpreagcost=?,dsubcosttime2=?,"
				+ "vsubcostnotes2=?,vagremarks=?,fassist=? where vsid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setTimestamp(1, p.getSubcosttime() == null ? null
					: new Timestamp(p.getSubcosttime().getTime()));
			pstmt.setString(2, p.getSubcostnotes());
			pstmt.setString(3, p.getInsubtag());
			pstmt.setFloat(4, p.getAgcost());
			pstmt.setTimestamp(5, p.getAgtime() == null ? null
					: new Timestamp(p.getAgtime().getTime()));
			pstmt.setString(6, p.getAgnotes());
			pstmt.setFloat(7, p.getOtherscost());
			pstmt.setString(8, p.getOtherstag());
			pstmt.setFloat(9, p.getInvprice());
			pstmt.setFloat(10, p.getPacount());
			pstmt.setFloat(11, p.getSubcost());
			pstmt.setFloat(12, p.getSubcost2());
			pstmt.setString(13,p.getPresubcost());
			pstmt.setString(14, p.getPresubcost2());
			pstmt.setFloat(15, p.getPreagcost());
			pstmt.setTimestamp(16, p.getSubcosttime2() == null ? null
					: new Timestamp(p.getSubcosttime2().getTime()));
			pstmt.setString(17, p.getSubcostnotes2());
			pstmt.setString(18, p.getAgremarks());
			//System.out.println("agremarks:"+p.getAgremarks());
			pstmt.setFloat(19, p.getAssist());
			pstmt.setString(20, p.getSid());
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
	 * 根据客户名称查找订单列表
	 * @param name 客户名称
	 * @return
	 */
	public List<Quotation> getPidByClientName(String name,String year ,String month) {
		String sql = "select * from t_quotation where vclient like '%" + name + "%' and year(dcreatetime)='"+year+"'  and  month(dcreatetime)='"+month+"'";
//		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		List<Quotation> list = new ArrayList<Quotation>();

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quotation qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setClient(rs.getString("vclient"));
				list.add(qt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	
	/**
	 * 一周统计东莞的报告客户、报告迟单、报告
	 * @param status 状态
	 * @return
	 */
	public List getWeekStatistics(String status) {
		List temp =new ArrayList();
		String sql="";
		if(status.equals("report")){
			temp.add("vrid");
			temp.add("Rpclient");
			temp.add("Vservname");
			temp.add("Dcreatetime");
			sql="select vrid,Rpclient,Vservname,Dcreatetime from t_chem_project where  YEARWEEK(date_format(Dcreatetime,'%Y-%m-%d')) = YEARWEEK(now())   and vpid like 'LCQD%'";
		}else if(status.equals("late")){
			temp.add("vrid");
			temp.add("Rpclient");
			temp.add("Vservname");
			temp.add("Dcreatetime");
			temp.add("Drptime");
			temp.add("Dendtime");
			sql = "select vrid,Rpclient,Vservname,Dcreatetime,Dendtime,Drptime from t_chem_project where   YEARWEEK(date_format(Dcreatetime,'%Y-%m-%d')) = YEARWEEK(now()) and (Dendtime>Drptime or (Drptime<now() and  Dendtime is null)) and vpid like 'LCQD%' ";
		}else if(status.equals("client")){
			temp.add("Rpclient");
			sql="select  distinct(Rpclient) from t_chem_project where YEARWEEK(date_format(Dcreatetime,'%Y-%m-%d')) = YEARWEEK(now())  and vpid like 'LCQD%'";
		}else if(status.equals("createname")){
			temp.add("报告号");
			temp.add("报价单号");
			temp.add("排单人");
			temp.add("排单时间");
			temp.add("预估分包费");
			temp.add("机构费");
			temp.add("报价金额");
			temp.add("已收金额");
			sql="select distinct(cp.vrid) as '报告号',cp.vpid as '报价单号',cp.Vcreatename as '排单人',cp.Dcreatetime as '排单时间',(p.Fpresubcost+p.Fpresubcost2) as '预估分包费',p.Fpreagcost as '机构费',q.Ftotalprice as '报价金额',(q.Fpreadvance+q.Fsepay+q.Fbalance) as '已收金额' " +
					"from t_chem_project as cp,t_quotation as q,t_project as p  where q.vpid =cp.vpid and p.vpid =q.vpid and date_format(cp.Dcreatetime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') and (cp.Vcreatename='柯惠玲[Muco]' or cp.Vcreatename='吴丽萍' or cp.Vcreatename='甘敏凤[Min]' ) " +
					"order by cp.Dcreatetime desc";
		}
		
//		System.out.println(sql);
		return new ImsDB().getInfor(temp,sql);
	}
	
	/**
	 * 根据报价单号pid删除报价单
	 * @param pid
	 */
	public void delQuotationByPid(String pid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		String sql = "delete from t_quotation where vpid = ?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);

			pstmt.executeUpdate();
			
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
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	
	//统计昨天的总签单量
	public List  getBills() {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	List list =new ArrayList ();
	String sql = "select * from v_finance_1";
	try {
		conn = DB.getConn();
		pstmt = DB.prepareStatement(conn, sql);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			BillsForm  bill =new BillsForm();
			bill.setYesDateLCQ(rs.getInt("yesDateLCQ"));
			bill.setYesMoneyLCQ(rs.getInt("yesMoneyLCQ"));
			bill.setNowDateLCQ( rs.getInt("nowDateLCQ"));
			bill.setNowMoneyLCQ(rs.getInt("nowMoneyLCQ"));
			bill.setNowMonthLCQ(rs.getInt("nowMonthLCQ"));
			bill.setNowMMoneyLCQ(rs.getInt("nowMMoneyLCQ"));
			list.add(bill);
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
	//合计
	
	public List  getBillsCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList ();
		String sql = "select sum(yesDateLCQ) as sumYD ,sum(yesMoneyLCQ) as sumYM,sum(nowDateLCQ)" +
				" as sumND ,sum(nowMoneyLCQ) as sumNM,sum(nowMonthLCQ) as sumNMon,sum(nowMMoneyLCQ)" +
				"as NMM from v_finance_1";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BillsCountForm  billC =new BillsCountForm();
			
//			
				billC.setSumYD(rs.getInt("sumYD"));
				billC.setSumYM(rs.getInt("sumYM"));
				billC.setSumND(rs.getInt("sumND"));
				billC.setSumNM(rs.getInt("sumNM"));
				billC.setSumNMon(rs.getInt("sumNMon"));
				billC.setSumNMM(rs.getInt("NMM"));
				list.add(billC);
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
	 *获取createTime的上一个月的最后一张报价单
	 * @param createTime:报价单创建时间
	 * @return
	 */
	public String getPayStatusByTime(String client){
//		String sql = "select epaystatus  from t_quotation  where date_format('"+createTime+"','%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') order by dcreatetime desc limit 0,2";
		String sql ="select epaystatus  from t_quotation  where dcreatetime >=concat(date_format(LAST_DAY(now() - interval 2 month),'%Y-%m-'),'01')  and dcreatetime <= LAST_DAY(now() - interval 2 month) +1 and vclient ='"+client+"' order by dcreatetime desc limit 0,1";
//		System.out.println(sql);
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String payStatus="";
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(rs.getFloat("本月已收历史欠款"));
			rs = pstmt.executeQuery();
			if (rs.next()) {
				payStatus=rs.getString("epaystatus");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return payStatus;
		
	}
	
	/***
	 * 查询可以在以前创建的，但没有做过单的新客户
	 */
	
	public int getClientByName(String clinetName) {
		Connection conn = null;
		String sql = "select * from t_quotation where vclient = ? and dcreatetime <2011-10-07";
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, clinetName);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
		}
		return count;
	}
	
	/**
	 * 根据pid和销售名查找报价单
	 * 
	 * @param pid
	 * @return
	 */
	public boolean  getQuotypeByConditions(String pid,String sales) {
		String sql = "select * from t_quotation where vpid ='"+pid+"' and vsales like '%"+sales+"%'";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		boolean flag=false;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flag=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flag;
	}
	/**
	 * 根据报告号rid取得报价单号pid
	 * @param rid
	 * @param client
	 * @param parttype
	 * @param list
	 */
	
	public String  getPidByRid(String rid ) {
		String sql = "select vpid from t_chem_project where vrid like '%" + rid + "%' or filingno like '%"+rid+"%'";
		String pid = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				pid = rs.getString("vpid");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pid;
	}
	
	/**
	 * 根据客户获取订单取得报价单号pid
	 * @param rid
	 * @param client
	 * @param parttype
	 * @param list
	 */
	public boolean  getQuotypeByClient(String client ,String sales  ) {
		String sql = "select * from t_quotation where vclient like '%"+client+"%' and vsales like '%"+sales+"%'";
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag=false;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flag=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flag;
	}
}
