package com.lccert.crm.quotation;

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
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.PhyProjectAction;
import com.lccert.crm.vo.SalesOrderItem;
import com.lccert.oa.db.ImsDB;

/**
 * 财务订单管理类
 *
 * @author eason
 *
 */
public class FinanceQuotationAction {

	private static FinanceQuotationAction instance = new FinanceQuotationAction();

	private FinanceQuotationAction() {

	}

	public static FinanceQuotationAction getInstance() {
		return instance;
	}

	/**
	 * 搜索报价单（分页模式）
	 *
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel searchQuotations(FinanceQuotationUtil fqu,String start) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Quotation> list = new ArrayList<Quotation>();
		StringBuffer str = new StringBuffer();
		String sql=null;


		if (fqu.getPid() != null && !"".equals(fqu.getPid())) {
			str.append(" and vpid like '%" + fqu.getPid() + "%'");
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
		if (fqu.getPrice() != null && !"".equals(fqu.getPrice())) {
			float totalprice = Float.parseFloat(fqu.getPrice());
			str.append(" and ftotalprice = " + totalprice);
		}

		if (fqu.getClient() != null && !"".equals(fqu.getClient())&& !"null".equals(fqu.getClient())) {
			str.append(" and vclient like '%" + fqu.getClient() + "%'");
		}

		if(fqu.getStatus() !=null && !"".equals(fqu.getStatus())){
			str.append(" and  vpid like '"+fqu.getStatus()+"%' ");
		}
		//只显示广州信息
		if(start !=null && start.equals("G") && str.length() == 0){
			sql = "select * from t_quotation where 1=1 and  vpid like '"+fqu.getStatus()+"%'   order by dcreatetime desc limit "
					+ (fqu.getPageNo() - 1) * fqu.getPageSize() + ", " + fqu.getPageSize();
		}else if(start !=null && start.equals("G")){
			sql = "select * from t_quotation where 1=1 and vpid like '"+fqu.getStatus()+"%'"  + str.toString() + " order by dcreatetime desc limit "
					+ (fqu.getPageNo() - 1) * fqu.getPageSize() + ", " + fqu.getPageSize();

		}
//		//只显示东莞信息
//		if(start !=null && start.equals("D") && str.length() == 0){
//			sql = "select * from t_quotation where 1=1 and  vpid like 'LCQD%'  order by dcreatetime desc limit "
//				+ (fqu.getPageNo() - 1) * fqu.getPageSize() + ", " + fqu.getPageSize();
//		}else if(start !=null && start.equals("D")){
//			sql = "select * from t_quotation where 1=1 and vpid like 'LCQD%' " + str.toString() + " order by dcreatetime desc limit "
//			+ (fqu.getPageNo() - 1) * fqu.getPageSize() + ", " + fqu.getPageSize();
//
//		}
		else{

			sql = "select * from t_quotation where 1=1 " + str.toString() + " order by dcreatetime desc limit "
					+ (fqu.getPageNo() - 1) * fqu.getPageSize() + ", " + fqu.getPageSize();

		}
		System.out.println(sql);
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
				qt.setOldPid(rs.getString("voldpid"));
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
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setLock(rs.getString("vlock"));
				qt.setAudittime(rs.getTimestamp("daudittime"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setInvcode(rs.getString("vinvcode"));
				list.add(qt);
			}
			String tsql=null;

			if(start !=null && start.equals("G") && str.length() == 0){
				tsql= "select count(*) from t_quotation where 1=1 and  vpid like 'LCQG%' " + str.toString();
			}else{
				tsql= "select count(*) from t_quotation where 1=1" + str.toString();
			}
			int totalRecords = getTotalRecords(conn,tsql);
			//pm = new PageModel();
			pm.setPageNo(fqu.getPageNo());
			pm.setPageSize(fqu.getPageSize());
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
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setTag(rs.getString("vtag"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setEconfrim(rs.getString("econfirm"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setAudit(rs.getString("eaudit"));
				qt.setAudittime(rs.getTimestamp("daudittime"));

				list.add(qt);
			}
			String tsql = "select count(*) from t_quotation";
			int totalRecords = getTotalRecords(conn,tsql);
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
	 * 财务款项登记更新
	 *
	 * @param qt
	 * @return
	 */
	public boolean updateQuotation(Quotation qt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_quotation set fpreadvance=?,dpaytime=?,vcreditcard=?,"
				+ "vpaynotes=?,fsepay=?,vsepayacount=?,dsepaytime=?,vsepaynotes=?,fprebalance=?,"
				+ "fbalance=?,vbalanceacount=?,dbalancetime=?,vbalancenotes=?,frefund=?,vrefunddesc=?,"
				+ "fprespefund=?,fspefund=?,vspefundtype=?,dspefundtime=?,vspefunddesc=?,vinvcode=?,"
				+ "dinvtime=?,facount=?,finvprice=?,ftax=?,vtag=?,fothercost=?,epaystatus=?,vcollremarks=?,fadvarceFactor=?,fsepayFactor=?,fbalanceFactor=?,fchannel=?,fdeductions=?,einvtype=?,badDebt=? where vpid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setFloat(1, qt.getPreadvance());
			pstmt.setTimestamp(2, qt.getPaytime() == null ? null
					: new Timestamp(qt.getPaytime().getTime()));
			pstmt.setString(3, qt.getCreditcard());
			System.out.println(qt.getPaynotes());
			pstmt.setString(4, qt.getPaynotes());
			pstmt.setFloat(5, qt.getSepay());
			pstmt.setString(6, qt.getSepayacount());
			pstmt.setTimestamp(7, qt.getSepaytime() == null ? null
					: new Timestamp(qt.getSepaytime().getTime()));
			pstmt.setString(8, qt.getSepaynotes());
			pstmt.setFloat(9, qt.getPrebalance());
			pstmt.setFloat(10, qt.getBalance());
			pstmt.setString(11, qt.getBalanceacount());
			pstmt.setTimestamp(12, qt.getBalancetime() == null ? null
					: new Timestamp(qt.getBalancetime().getTime()));
			pstmt.setString(13, qt.getBalancenotes());
			pstmt.setFloat(14, qt.getRefund());
			pstmt.setString(15, qt.getRefunddesc());
			pstmt.setFloat(16, qt.getPrespefund());
			pstmt.setFloat(17, qt.getSpefund());
			pstmt.setString(18, qt.getSpefundtype());
			pstmt.setTimestamp(19, qt.getSpefundtime() == null ? null
					: new Timestamp(qt.getSpefundtime().getTime()));
			pstmt.setString(20, qt.getSpefunddesc());
			pstmt.setString(21, qt.getInvcode());
			pstmt.setTimestamp(22, qt.getInvtime() == null ? null
					: new Timestamp(qt.getInvtime().getTime()));
			pstmt.setFloat(23, qt.getAcount());
			pstmt.setFloat(24, qt.getInvprice());
			pstmt.setFloat(25, qt.getTax());
			pstmt.setString(26, qt.getTag());
			pstmt.setFloat(27, qt.getOthercost());
			pstmt.setString(28, qt.getPaystatus());
			pstmt.setString(29, qt.getCollRemarks());
			pstmt.setFloat(30, qt.getAdvarceFactor());
			pstmt.setFloat(31, qt.getSepayFactor());
			pstmt.setFloat(32, qt.getBalanceFactor());
			pstmt.setFloat(33, qt.getChannel());
			pstmt.setFloat(34, qt.getDeductions());
			pstmt.setString(35, qt.getInvtype());
			pstmt.setString(36, qt.getBadDebt());
			pstmt.setString(37, qt.getPid());
			pstmt.executeUpdate();
			if (qt.getAcount() != 0) {
				sql = "update t_quotation set vstatus='已结算' where vpid=?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, qt.getPid());
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
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}

	/**
	 * 解锁和枷锁
	 *
	 * @param qt
	 * @return
	 */
	public boolean quotationLock(Quotation qt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_quotation set vlock=? where vpid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, qt.getLock());
			pstmt.setString(2, qt.getPid());
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
	 * 财务报价单统计
	 *
	 * @param start
	 * @param end
	 * @param type
	 * @return
	 */
	public float[] getFinanceProject(String quostart, String quoend,
									 String acceptstart, String acceptend,String paytimestart,String paytimend, String dsubcosttime,String dsubcosttime2,String dagtime,String spefundtime, String counttime,String type,
									 List<Quotation> list,String start) {
		StringBuffer str = new StringBuffer();
		float[] f = new float[2];
		float totalperformence = 0;
		float total = 0;
		String timeStr=" 00:00:00 ";acceptend+=" 23:59:59 ";
		if ("search".equals(type)) {

			//报价时间
			if (quostart != null && !"".equals(quostart)
					&& quoend != null && !"".equals(quoend)) {
				str.append(" and dcreatetime >= '" + quostart +timeStr
						+ "' and dcreatetime <= '" + quoend+timeStr + "'");
			}
			//收单时间
			if (acceptstart != null && !"".equals(acceptstart)
					&& acceptend != null && !"".equals(acceptend)) {
				str.append(" and dconfirmtime is not null and dconfirmtime >= '" + acceptstart+timeStr
						+ "' and dconfirmtime <= '" + acceptend+timeStr + "'");
			}
			//收款时间
			if (paytimestart != null && !"".equals(paytimestart)
					&& paytimend != null && !"".equals(paytimend)) {
				str.append(" and dpaytime is not null and dpaytime >= '" + paytimestart+timeStr
						+ "' and dpaytime <= '" + paytimend+timeStr + "'");
			}
			if(start !=null && !"".equals(start)){
				str.append(" and  vpid like '"+start+"%' ");
			}


		}
		//系统当天的时间
		else {
			Date date = new Date();
			str.append(" and dcreatetime > '"
					+ new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date)
					+ "' and dcreatetime < '"
					+ new SimpleDateFormat("yyyy-MM-dd 23:59:59").format(date)
					+ "'");
		}
		String sql ="";

		//支付分包费A日期
		if (dsubcosttime != null && !"".equals(dsubcosttime)) {
			sql ="select distinct(a.vpid),a.fbalance,a.fsepayFactor,a.fadvarceFactor,a.fbalanceFactor,a.Fothercost,a.dconfirmtime,a.vsales,a.vclient,a.ftotalprice,a.einvtype,a.fpreadvance,a.vcreditcard,a.dpaytime,a.fsepay,a.fprebalance,a.fpresubcost,a.fpreagcost,a.fspefund,a.ftax,a.fsubcost,a.vcollremarks,a.vprojectcontent,a.voldpid,a.equotype,p.dsubcosttime,p.dsubcosttime2,p.dagtime  from t_quotation  as a,t_project  as p  where 1=1 and p.vpid =a.vpid and  year(p.dsubcosttime)=year(now()) and month(p.dsubcosttime)='"+dsubcosttime+"' and p.dsubcosttime is not null and ((p.Fagcost > 0) or (p.Fsubcost > 0) or(p.Fsubcost2 >0) or (a.Fspefund >0))   group by a.vpid  order by a.dcreatetime desc";
		}
		//支付分包费B日期
		else if (dsubcosttime2 != null && !"".equals(dsubcosttime2)) {
			sql ="select distinct(a.vpid),a.fbalance,a.fsepayFactor,a.fadvarceFactor,a.fbalanceFactor,a.Fothercost,a.dconfirmtime,a.vsales,a.vclient,a.ftotalprice,a.einvtype,a.fpreadvance,a.vcreditcard,a.dpaytime,a.fsepay,a.fprebalance,a.fpresubcost,a.fpreagcost,a.fspefund,a.ftax,a.fsubcost,a.vcollremarks,a.vprojectcontent,a.voldpid,a.equotype,p.dsubcosttime,p.dsubcosttime2,p.dagtime  from t_quotation  as a,t_project  as p  where 1=1 and p.vpid =a.vpid and  year(p.dsubcosttime2)=year(now()) and month(p.dsubcosttime2)='"+dsubcosttime2+"' and p.dsubcosttime2 is not null and ((p.Fagcost > 0) or (p.Fsubcost > 0) or(p.Fsubcost2 >0) or (a.Fspefund >0)) group by a.vpid    order by a.dcreatetime desc";
		}
		// 机构费用支付日期
		else if (dagtime != null && !"".equals(dagtime)) {
			sql ="select distinct(a.vpid),a.fbalance,a.fsepayFactor,fsepayFactor,a.fadvarceFactor,a.fbalanceFactor,a.Fothercost,a.dconfirmtime,a.vsales,a.vclient,a.ftotalprice,a.einvtype,a.fpreadvance,a.vcreditcard,a.dpaytime,a.fsepay,a.fprebalance,a.fpresubcost,a.fpreagcost,a.fspefund,a.ftax,a.fsubcost,a.vcollremarks,a.vprojectcontent,a.voldpid,a.equotype,p.dsubcosttime,p.dsubcosttime2,p.dagtime  from t_quotation  as a,t_project  as p  where 1=1 and p.vpid =a.vpid and  year(p.dagtime)=year(now()) and month(p.dagtime)='"+dagtime+"' and p.dagtime is not null and ((p.Fagcost > 0) or (p.Fsubcost > 0) or(p.Fsubcost2 >0) or (a.Fspefund >0))  group by a.vpid   order by a.dcreatetime desc";
		}
		// 特殊接待费支付日期
		else if(spefundtime !=null && !"".equals(spefundtime)){
			sql ="select distinct(a.vpid),a.fbalance,a.fsepayFactor,a.fadvarceFactor,a.fbalanceFactor,a.Fothercost,a.dconfirmtime,a.vsales,a.vclient,a.ftotalprice,a.einvtype,a.fpreadvance,a.vcreditcard,a.dpaytime,a.fsepay,a.fprebalance,a.fpresubcost,a.fpreagcost,a.fspefund,a.ftax,a.fsubcost,a.vcollremarks,a.vprojectcontent,a.voldpid,a.equotype,p.dsubcosttime,p.dsubcosttime2,p.dagtime  from t_quotation  as a,t_project  as p  where 1=1 and p.vpid =a.vpid and  year(dspefundtime)=year(now()) and month(dspefundtime)='"+spefundtime+"' and dspefundtime is not null  and ((p.Fagcost > 0) or (p.Fsubcost > 0) or(p.Fsubcost2 >0) or (a.Fspefund >0))   group by a.vpid   order by a.dcreatetime desc";
		}
		else if(counttime !=null && !"".equals(counttime)){
			sql ="select distinct(a.vpid),a.fbalance,a.fsepayFactor,a.fadvarceFactor,a.fbalanceFactor,a.Fothercost,a.dconfirmtime,a.vsales,a.vclient,a.ftotalprice,a.einvtype,a.fpreadvance,a.vcreditcard,a.dpaytime,a.fsepay,a.fprebalance,a.fpresubcost,a.fpreagcost,a.fspefund,a.ftax,a.fsubcost,a.vcollremarks,a.vprojectcontent,a.voldpid,a.equotype,p.dsubcosttime,p.dsubcosttime2,p.dagtime  from t_quotation  as a,t_project  as p  where 1=1 and p.vpid =a.vpid and ( (year(p.dsubcosttime)=year(now())) or (year(p.dsubcosttime2)=year(now())) or(year(p.dagtime)=year(now()))) and ((month(p.dsubcosttime)='"+counttime+"') or (month(p.dsubcosttime2)='"+counttime+"') or ( month(p.dagtime)='"+counttime+"' )) and  ((p.Fagcost > 0) or (p.Fsubcost > 0) or(p.Fsubcost2 >0) or (a.Fspefund >0))   group by a.vpid  order by a.dcreatetime desc";
		}
		else{
			sql= "select * from t_quotation  where 1=1" + str.toString()
					+ " order by dcreatetime desc";
		}
		System.out.println(sql+":sql");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setSales(rs.getString("vsales"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setPreagcost(getTotalAgCost(qt.getPid(), "fpreagcost"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setOthercost(rs.getFloat("Fothercost"));
				qt.setObject(getAgRemarks(qt.getPid()));
				qt.setCollRemarks(rs.getString("vcollremarks"));
				qt.setOldPid(rs.getString("voldpid"));
				//qt.setQuotype(rs.getString(""));
				qt.setQuotype(rs.getString("equotype"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setAdvarceFactor(rs.getFloat("fadvarceFactor"));
				qt.setSepayFactor(rs.getFloat("fsepayFactor"));
				qt.setBalanceFactor(rs.getFloat("fbalanceFactor"));
				qt.setSubcost(getTotalSubCost(qt.getPid(), "fsubcost", "fsubcost2"));
				qt.setPresubcost(getTotalSubCost(qt.getPid(), "fpresubcost", "fpresubcost2"));
				qt.setAgcost(getTotalAgCost(qt.getPid(),"fagcost"));
				totalperformence += qt.getPreadvance() + qt.getSepay() + qt.getBalance();
				total += qt.getTotalprice();
				list.add(qt);
			}
			f[0] = totalperformence;
			f[1] = total;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;
	}
	/**
	 * 财务报价单统计
	 *
	 * @param start
	 * @param end
	 * @param type
	 * @return
	 */
	public float[] getFinanceProject(String type ,String acceptstart,String acceptend,String year, String month,String dept, String group,List<Quotation> list) {
		StringBuffer str = new StringBuffer();
		String param="";
		float[] f = new float[2];
		float totalperformence = 0;
		float total = 0;
		if(acceptstart !=null && acceptstart !="" && acceptend !="" && acceptend !=null){
			if(acceptstart !="" && acceptend ==""){
				acceptstart+=" 00:00:00 ";
				str.append(" and q.dconfirmtime is not null and (q.dconfirmtime='"+acceptstart+"' or(q.dpaytime='"+acceptstart+"') or ( q.Dsepaytime= '"+acceptstart+"') or (q.dbalancetime= '"+acceptstart+"'))");
			}else if(acceptstart =="" && acceptend !=""){
				acceptend+=" 23:59:59 ";
				str.append(" and q.dconfirmtime is not null and (q.dconfirmtime='"+acceptend+"' or(q.dpaytime= '"+acceptend+"') or (q.Dsepaytime= '"+acceptend+"') or(q.dbalancetime = '"+acceptend+"'))");
			}else if(acceptstart !="" && acceptend !=""){
				acceptstart+=" 00:00:00 ";acceptend+=" 23:59:59 ";
				str.append(" and q.dconfirmtime is not null and ((q.dconfirmtime>='"+acceptstart+"' and q.dconfirmtime<='"+acceptend+"') or (q.dpaytime >= '"+acceptstart+"' and q.dpaytime <= '"+acceptend+"') or (q.Dsepaytime>= '"+acceptstart+"' and q.Dsepaytime<= '"+acceptend+"') or(q.dbalancetime >= '"+acceptstart+"' and q.dbalancetime <= '"+acceptend+"'))");
			}
		}
		else if (year != null && !"".equals(year)) {
			str.append(" and q.dconfirmtime is not null and (year(q.dconfirmtime)= '"+year+"'  and month(q.dconfirmtime)= '"+month+"'  or( year(q.dpaytime) = '"+year+"') and month(q.dpaytime)= '"+month+"' or year(q.Dsepaytime)= '"+year+"'  and month(q.Dsepaytime)= '"+month+"'  or( year(q.dbalancetime) = '"+year+"') and month(q.dbalancetime)= '"+month+"'  ) ");
		}
		if(dept !=null && !"".equals(dept)){
			if(dept.equals("1")){
				str.append(" and q.vpid like 'LCQ1%' ");
			}else if(dept.equals("2")){
				param=" ,(select count(*) from t_phy_project where  vpid=q.vpid and dendtime is null GROUP BY vpid  ) as isNotFishCount ";
				param+=" ,(select dendtime from t_phy_project  where  vpid=q.vpid GROUP BY vpid  ORDER BY dendtime desc ) as dendtime ";
				str.append(" and q.vpid like 'LCQ2%'");
			}
			if(dept.equals("3")){
				str.append(" and q.vpid like 'LCQE%'");
			}if(dept.equals("G")){
				str.append(" and q.vpid like 'LCQG%'");
			}if(dept.equals("D")){
				str.append(" and q.vpid like 'LCQD%'");
			}
		}
		if(group !=null && !"".equals(group)){
			str.append(" and u.groupid ='"+group+"'");
		}
		//}
		//未加排单人员2012-03-26
		//	String sql= "select q.* from t_quotation  as q ,t_user as u where u.name  =q.vsales" + str.toString()+ " order by q.dcreatetime desc";
		String sql= "select q.*,cp.vcreatename,u.groupid "+param+" from t_quotation   as q left join (select  distinct(vpid),vcreatename  from t_chem_project  ) as cp on q.vpid =cp.vpid,t_user as u  where u.name  =q.vsales and u.estatus='有效'  " + str.toString()+ "  order by q.dcreatetime desc";
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		PhyProject pp =new PhyProject();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			int i=0;
			while (rs.next()) {
				qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setSales(rs.getString("vsales"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setPreagcost(getTotalAgCost(qt.getPid(), "fpreagcost"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setOthercost(rs.getFloat("Fothercost"));
				qt.setObject(getAgRemarks(qt.getPid()));
				qt.setCollRemarks(rs.getString("vcollremarks"));
				qt.setOldPid(rs.getString("voldpid"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setAdvarceFactor(rs.getFloat("fadvarceFactor"));
				qt.setSepayFactor(rs.getFloat("fsepayFactor"));
				qt.setBalanceFactor(rs.getFloat("fbalanceFactor"));
				qt.setSubcost(getTotalSubCost(qt.getPid(), "fsubcost","fsubcost2"));
				qt.setPresubcost(getTotalSubCost(qt.getPid(),"fpresubcost", "fpresubcost2"));
				qt.setAgcost(getTotalAgCost(qt.getPid(),"fagcost"));
				qt.setDeductions(rs.getFloat("fdeductions"));
				qt.setChannel(rs.getFloat("fchannel"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setFinish(rs.getTimestamp("dfinish"));
				qt.setBadDebt(rs.getString("badDebt"));
				qt.setGroupId(rs.getInt("groupId"));

				if(qt.getPid().indexOf("LCQ2")==-1&&dept !=null && !"G".equals(dept)){
					qt.setCreatename(rs.getString("cp.vcreatename"));
				}else{
					//安规的排单人员
					pp.setPid(qt.getPid());
					PhyProject phyProject= PhyProjectAction.getInstance().findByConditions(pp);
					if(phyProject !=null){
						qt.setCreatename(PhyProjectAction.getInstance().findByConditions(pp).getServname());
					}
				}
				if(dept.equals("2")){
					String isNotFishCount=rs.getString("isNotFishCount");
					if(isNotFishCount ==null || Integer.parseInt(isNotFishCount)==0){
						qt.setFinish(rs.getTimestamp("dendtime"));
					}
				}
				if(dept.equals("3")){
					qt.setFinish(rs.getTimestamp("dreceipt"));
				}
				totalperformence += qt.getPreadvance() + qt.getSepay()
						+ qt.getBalance();
				total += qt.getTotalprice();
				list.add(qt);
				i++;
			}
			//System.out.println(i);
			f[0] = totalperformence;
			f[1] = total;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;
	}

	/**
	 * 财务报价单统计
	 *
	 * @param start
	 * @param end
	 * @param type
	 * @return
	 */
	public float[] getPayFinance(String dept,List<Quotation> list) {
		StringBuffer str = new StringBuffer();
		float[] f = new float[2];
		float totalperformence = 0;
		float total = 0;

		if(dept !=null && !"".equals(dept)){
			if(dept.equals("1")){
				str.append(" and q.vpid like 'LCQ1%'");
			}
			if(dept.equals("2")){
				str.append(" and q.vpid like 'LCQ2%'");
			}
		}

		String sql= "select Dconfirmtime ,vpid ,vsales  ,vclient,ftotalprice,Fpreadvance,Dpaytime,Fsepay,Dsepaytime,Fbalance,dbalancetime   from t_quotation as q where dcreatetime<=now()  and year(dcreatetime) >=2011 and  Dconfirmtime is not null  and (ftotalprice-(Fpreadvance+Fsepay+Fbalance)>10 or equotype ='flu' )" + str.toString()+ " order by q.dcreatetime desc";
//		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setSales(rs.getString("vsales"));
				qt.setClient(rs.getString("vclient"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepaytime(rs.getTimestamp("Dsepaytime"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalancetime(rs.getTime("dbalancetime"));
				list.add(qt);
			}
			f[0] = totalperformence;
			f[1] = total;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;
	}

	//查询机构管理的备注
	public String getAgRemarks(String pid){
		String sql ="select distinct(p.vpid),p.vagremarks from t_quotation q,t_project p where p.vpid =q.vpid  and p.vpid =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		ResultSet rs = null;
		String agremarks =null;
		int countChilds=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				agremarks=rs.getString("p.vagremarks");
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
	/***
	 * 销售二部的报价单统计
	 * 2010-9-29
	 * @param month
	 * @param type
	 * @param list
	 * @param start
	 * @return
	 */
	public float[] getFinanceProject2(String year,String month, String type,List<Quotation> list,String start,String area,String quostart, String quoend,
									  String acceptstart, String acceptend,String paytimestart,String paytimend) {
		StringBuffer str = new StringBuffer();
		float[] f = new float[2];
		float totalperformence = 0;
		float total = 0;

		if ("search".equals(type)) {
			//报价时间
			if (quostart != null && !"".equals(quostart)
					&& quoend != null && !"".equals(quoend)) {
				str.append(" and q.dcreatetime >= '" + quostart
						+ "' and q.dcreatetime <= '" + quoend + "'");
			}
			//收单时间
			if (acceptstart != null && !"".equals(acceptstart)
					&& acceptend != null && !"".equals(acceptend)) {
				str.append(" and q.dconfirmtime is not null and dconfirmtime >= '" + acceptstart
						+ "' and q.dconfirmtime <= '" + acceptend + "'");
			}
			//收款时间
			if (paytimestart != null && !"".equals(paytimestart)
					&& paytimend != null && !"".equals(paytimend)) {
				str.append(" and q.dpaytime is not null and dpaytime >= '" + paytimestart
						+ "' and q.dpaytime <= '" + paytimend + "'");
			}
		} else{
			if(year !=null && !"".equals(year)){
				str.append(" and year (q.dcreatetime)="+year+"");
			}
			if (month != null && !"".equals(month)) {
				str.append(" and month(q.dcreatetime)="+month+"");
			}

		}


		if(area !=null && !"".equals(area)){
			if(area.equals("安规")){
				str.append("    AND  q.vpid like 'LCQ2%'");
			}else if(area.equals("广州")){
				str.append("     AND  q.vpid like 'LCQG%'");
			}
		}
		String sql="select q.*,oq.remark as remark ,(oq.count*oq.saleprice) as a ,(select dendtime from t_phy_project  where  vpid=q.vpid GROUP BY vpid  ORDER BY dendtime desc ) as dendtime  from t_quotation as q ,t_sales_order as o,t_sales_order_quoitem as oq  where 1=1   and oq.orderid =o.id and o.vpid =q.vpid "+str;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setClient(rs.getString("vclient"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setSales(rs.getString("vsales"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setPaynotes(rs.getString("vpaynotes"));
//				System.out.println(qt.getPaynotes());
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setIsfinish(rs.getString("eisfinish"));
				qt.setPaymentclear(rs.getString("epaymentclear"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setPreacount(rs.getFloat("fpreacount"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setTag(rs.getString("vtag")+rs.getString("remark"));
				qt.setAuditman(rs.getString("vauditman"));
				qt.setAudittime(rs.getTimestamp("daudittime"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setObject(getAgRemarks(qt.getPid()));
				qt.setSubcost(getTotalSubCost(qt.getPid(), "fsubcost","fsubcost2"));
				//单个项目的金额
				qt.setProjectPrice(rs.getFloat("a"));
				qt.setPresubcost(getTotalSubCost(qt.getPid(),"fpresubcost", "fpresubcost2"));
				qt.setAgcost(getTotalAgCost(qt.getPid(), "fagcost"));
				qt.setPreagcost(getTotalAgCost(qt.getPid(), "fpreagcost"));
				qt.setAdvarceFactor(rs.getFloat("fadvarceFactor"));
				qt.setSepayFactor(rs.getFloat("fsepayFactor"));
				qt.setBalanceFactor(rs.getFloat("fbalanceFactor"));
				qt.setDeductions(rs.getFloat("fdeductions"));
				qt.setChannel(rs.getFloat("fchannel"));
				qt.setFinish(rs.getTimestamp("dendtime"));
				list.add(qt);
			}
			String sql1="select  sum(q.ftotalprice) as totalprice,sum((q.fpreadvance+q.fsepay+q.fbalance)) as totalperformence from t_quotation as q where 1=1 and equotype !='flu' and year(q.dcreatetime)=year(now())    "+str;

			pstmt = DB.prepareStatement(conn, sql1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalperformence=rs.getFloat("totalperformence");
				total=rs.getFloat("totalprice");
			}


			f[0] = totalperformence;
			f[1] = total;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;
	}
	public float[] getFinanceProject2(String type ,String year, String month,String dept, String group,List<Object> list) {
		List<Quotation> listQuotation =new ArrayList<Quotation>();
		List listFloat=new ArrayList<Object>();

		StringBuffer str = new StringBuffer();
		float[] f = new float[2];
		float totalperformence = 0;
		float total = 0;

		//收单时间
		if (year != null && !"".equals(year)&& month != null && !"".equals(month)) {
			str.append(" and q.dconfirmtime is not null and " +
					"((year(dconfirmtime) =  '" + year+"' and month(q.dconfirmtime)= '" + month + "') " +
					"or (year(q.dpaytime)='" + year+"' and month(q.dpaytime)= '" + month + "') " +
					"or (year(q.Dsepaytime)='" + year+"' and month(q.Dsepaytime)= '" + month + "')" +
					"or (year(q.dbalancetime)='" + year+ "' and month(q.dbalancetime)= '" + month + "'))");
		}
		if(dept !=null && !"".equals(dept)){
			if(dept.equals("2")){
				str.append(" AND  q.vpid like 'LCQ2%'");
			}else if(dept.equals("G")){
				str.append(" AND  q.vpid like 'LCQG%'");
			}else if(dept.equals("D")){
				str.append(" AND  q.vpid like 'LCQD%'");
			}

		}
		if(group !=null && !"".equals(group)){
			str.append(" and u.groupid ='"+group+"'");
		}
		String sql="select q.*,oq.remark as remark ,(oq.count*oq.saleprice) as a  from t_quotation as q ,t_sales_order as o,t_sales_order_quoitem as oq,t_user as u where 1=1 and   u.id =o.salesid    and oq.orderid =o.id and o.vpid =q.vpid  "+str +" order by q.dcreatetime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation qt = null;
		int i=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			PhyProject pp =new PhyProject();
			while (rs.next()) {
				i++;
				qt = new Quotation();
				List myTemp=new ArrayList<Object>();
				qt.setPid(rs.getString("vpid"));
				qt.setOldPid(rs.getString("voldpid"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setClient(rs.getString("vclient"));
				qt.setProjectcontent(rs.getString("vprojectcontent"));
				qt.setSales(rs.getString("vsales"));
				qt.setCompany(rs.getString("vcompany"));
				qt.setCreatetime(rs.getTimestamp("dcreatetime"));
				qt.setCreateuser(rs.getString("vcreateuser"));
				qt.setConfirmtime(rs.getTimestamp("dconfirmtime"));
				qt.setConfirmuser(rs.getString("vconfirmuser"));
				qt.setCompletetime(rs.getTimestamp("dcompletetime"));
				qt.setAdvancetype(rs.getString("eadvancetype"));
				qt.setTotalprice(rs.getFloat("ftotalprice"));
				qt.setPreadvance(rs.getFloat("fpreadvance"));
				qt.setCreditcard(rs.getString("vcreditcard"));
				qt.setPaytime(rs.getTimestamp("dpaytime"));
				qt.setPaynotes(rs.getString("vpaynotes"));
				qt.setSepay(rs.getFloat("fsepay"));
				qt.setSepayacount(rs.getString("vsepayacount"));
				qt.setSepaynotes(rs.getString("vsepaynotes"));
				qt.setSepaytime(rs.getTimestamp("dsepaytime"));
				qt.setPrebalance(rs.getFloat("fprebalance"));
				qt.setBalance(rs.getFloat("fbalance"));
				qt.setBalanceacount(rs.getString("vbalanceacount"));
				qt.setBalancenotes(rs.getString("vbalancenotes"));
				qt.setBalancetime(rs.getTimestamp("dbalancetime"));
				qt.setRefund(rs.getFloat("frefund"));
				qt.setRefunddesc(rs.getString("vrefunddesc"));
				qt.setProjectcount(rs.getInt("iprojectcount"));
				qt.setIsfinish(rs.getString("eisfinish"));
				qt.setPaymentclear(rs.getString("epaymentclear"));
				qt.setPrespefund(rs.getFloat("fprespefund"));
				qt.setSpefund(rs.getFloat("fspefund"));
				qt.setSpefundtype(rs.getString("vspefundtype"));
				qt.setSpefundtime(rs.getTimestamp("dspefundtime"));
				qt.setSpefunddesc(rs.getString("vspefunddesc"));
				qt.setPreacount(rs.getFloat("fpreacount"));
				qt.setAcount(rs.getFloat("facount"));
				qt.setInvmethod(rs.getString("einvmethod"));
				qt.setInvtype(rs.getString("einvtype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setInvprice(rs.getFloat("finvprice"));
				qt.setInvhead(rs.getString("vinvhead"));
				qt.setInvcontent(rs.getString("vinvcontent"));
				qt.setInvtime(rs.getTimestamp("dinvtime"));
				qt.setInvcode(rs.getString("vinvcode"));
				qt.setStatus(rs.getString("vstatus"));
				qt.setCollRemarks(rs.getString("vcollremarks"));
				qt.setTag(rs.getString("vtag")+rs.getString("remark"));
				qt.setAuditman(rs.getString("vauditman"));
				qt.setAudittime(rs.getTimestamp("daudittime"));
				qt.setTax(rs.getFloat("ftax"));
				qt.setPresubcost(rs.getFloat("fpresubcost"));
				qt.setObject(getAgRemarks(qt.getPid()));
				qt.setSubcost(getTotalSubCost(qt.getPid(), "fsubcost","fsubcost2"));
				//单个项目的金额
				qt.setProjectPrice(rs.getFloat("a"));
				qt.setPresubcost(getTotalSubCost(qt.getPid(),"fpresubcost", "fpresubcost2"));
				qt.setAgcost(getTotalAgCost(qt.getPid(), "fagcost"));
				qt.setPreagcost(getTotalAgCost(qt.getPid(), "fpreagcost"));
				qt.setAdvarceFactor(rs.getFloat("fadvarceFactor"));
				qt.setSepayFactor(rs.getFloat("fsepayFactor"));
				qt.setBalanceFactor(rs.getFloat("fbalanceFactor"));
				qt.setDeductions(rs.getFloat("fdeductions"));
				qt.setChannel(rs.getFloat("fchannel"));
				qt.setQuotype(rs.getString("equotype"));
				//安规的排单人员
				pp.setPid(qt.getPid());
				PhyProject phyProject= PhyProjectAction.getInstance().findByConditions(pp);
				if(phyProject !=null){
					qt.setCreatename(PhyProjectAction.getInstance().findByConditions(pp).getServname());
				}
				listQuotation.add(qt);
				//---------------------------------2013-03-24--------------------------
				//本月收款比例=已收金额/报价金额
				String nowYM=new SimpleDateFormat("yyyy-MM").format(new Date());
				String payYM="";
				if(qt.getPaytime() !=null && !"".equals(qt.getPaytime())){
					//System.out.println("进来");
					payYM=new SimpleDateFormat("yyyy-MM").format(qt.getPaytime());//一次收款的年、月
				}
				String sepayYM="";
				if(qt.getSepaytime() !=null && !"".equals(qt.getSepaytime())){
					sepayYM=new SimpleDateFormat("yyyy-MM").format(qt.getSepaytime());//二次收款的年、月
				}
				String balanceYM="";
				if(qt.getBalancetime() !=null && !"".equals(qt.getBalancetime())){
					balanceYM=new SimpleDateFormat("yyyy-MM").format(qt.getBalancetime());//尾次收款的年、月
				}
				// Float nowYMPay =qt.getPreadvance() + qt.getSepay() + qt.getBalance();
				Float nowYMPay =0f; //本月收款
				if(payYM !=null && payYM.equals(nowYM)){ //如果一次收款等于本月
					nowYMPay +=qt.getPreadvance();
				}else if (sepayYM !=null && sepayYM.equals(nowYM)){//如果二次收款等于本月
					nowYMPay +=qt.getSepay();
				}else if(balanceYM !=null && balanceYM.equals(nowYM)){//如果尾次收款等于本月
					nowYMPay +=qt.getBalance();
				}
				//本月比例=本月已收款/本月报价总额
				float nowYMScale =nowYMPay/qt.getTotalprice();
				float subcostSum=0f; //总分包费
				if(qt.getSubcost()>0){
					subcostSum +=qt.getSubcost();
				}else{
					subcostSum +=qt.getPresubcost();
				}
				//  预计总外部分包费计提=预计总外部分包费计提*本月比例
				float presubcostAccrue=qt.getPresubcost()*nowYMScale;
				//预计总机构合作费计提=预计总机构合作费计提*本月比例
				float preagcostAccrue=	 qt.getPreagcost()*nowYMScale;
				//总特殊接待费预算计提=总特殊接待费预算计提*本月比例
				float prespefundAccrue= qt.getPrespefund()*nowYMScale;
				//发票计提
				float taxAccrue=0f;
				if(qt.getInvtype().equals("发票")){
					taxAccrue=(float) ((qt.getTotalprice()*0.08)*nowYMScale);
				}
				//本月小计
				float nowYMSubtotal=nowYMPay-presubcostAccrue-preagcostAccrue-prespefundAccrue-taxAccrue;
				myTemp.add(nowYMScale);
				myTemp.add(nowYMPay);
				myTemp.add(taxAccrue);
				myTemp.add(presubcostAccrue);
				myTemp.add(preagcostAccrue);
				myTemp.add(prespefundAccrue);
				myTemp.add(nowYMSubtotal);
				listFloat.add(myTemp);
				//---------------------------------2013-03-24--------------------------

			}
			list.add(listQuotation);
			list.add(listFloat);
			String sql1="select  sum(q.ftotalprice) as totalprice,sum((q.fpreadvance+q.fsepay+q.fbalance)) as totalperformence from t_quotation as q where 1=1 "+str;
//				System.out.println(sql1+"***");
			pstmt = DB.prepareStatement(conn, sql1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalperformence=rs.getFloat("totalperformence");
				total=rs.getFloat("totalprice");
			}


			f[0] = totalperformence;
			f[1] = total;


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;

	}
	/**
	 * 分包费合计
	 *
	 * @param pid
	 * @return
	 */
	private float getTotalSubCost(String pid, String str, String str2) {
		String sql = "select sum(" + str + "),sum(" + str2
				+ ") from t_project where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		float totalsubcost = 0;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalsubcost += rs.getFloat(1);
				totalsubcost += rs.getFloat(2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return totalsubcost;
	}

	/**
	 * 根据报价单号取得总机构费用
	 * @param pid 报价单号
	 * @param str
	 * @return
	 */
	private float getTotalAgCost(String pid, String str) {
		String sql = "select sum(" + str + ") from t_project where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		float totalagcost = 0;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalagcost += rs.getFloat(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return totalagcost;
	}

	//四舍五进保留两位小数点的方法
	public  String getFourToFive(Float score_type)
	{
		double bl=(Math.round(score_type/.01)*.01);
		String st=String.valueOf(bl);
		/**注意,这里用.作为分隔符是失效的,不知道为什么,所以采用替换的办法*/
		st=st.replace(".", "_");
		String []st_arr=st.split("_");
		String temp="";
		if(st_arr[1].length()>2)
		{
			temp=st_arr[1].substring(0, 1);
		}
		else
		if(st_arr[1].length()<1)
		{
			temp=st_arr[1]+"0";
		}
		else
		{
			temp=st_arr[1];
		}
		return st_arr[0]+"."+temp;
	}
	//四舍五进保留两位小数点的方法
	public  String getFourToFive1(double score_type)
	{
		double bl=(Math.round(score_type/.01)*.01);
		String st=String.valueOf(bl);
		/**注意,这里用.作为分隔符是失效的,不知道为什么,所以采用替换的办法*/
		st=st.replace(".", "_");
		String []st_arr=st.split("_");
		String temp="";
		if(st_arr[1].length()>2)
		{
			temp=st_arr[1].substring(0, 1);
		}
		else
		if(st_arr[1].length()<1)
		{
			temp=st_arr[1]+"0";
		}
		else
		{
			temp=st_arr[1];
		}
		return st_arr[0]+"."+temp;
	}

	/***
	 * 统计环境数据
	 * @param year  年度统计
	 * @param month 月度统计
	 * @return
	 */
	public List getEdmManage(String year, String month) {
		List temp= new ArrayList();
		temp.add("vpid");
		temp.add("vclient");
		temp.add("Dpaytime");
		temp.add("Fpreadvance");
		temp.add("vcreditcard");
		temp.add("Dinvtime");
		temp.add("Vinvcode");
		temp.add("dsampltime");
		temp.add("vsampling");
		StringBuffer str =new StringBuffer();
		if(!year.equals("") && year !=null){
			str.append(" and "+year+"=year(Dcreatetime)");
		}
		if(!month.equals("") && month !=null){
			str.append(" and "+month+"=month(Dcreatetime)");
		}
		String sql ="select vpid,vclient,Dpaytime,Fpreadvance,vcreditcard,Dinvtime,Vinvcode,dsampltime,vsampling from t_quotation where vpid like '%LCDE%' "+str;
//		System.out.println(sql);
		return new ImsDB().getInfor(temp,sql);
	}

	/***
	 * 生成收据编号
	 * @return
	 */
	public String receiptNo(String pid){
//		 System.out.println(pid);
		StringBuffer str = new StringBuffer();
		String last = "";
		if(pid.indexOf("LCQ1")>-1){
			str.append("1");
		}
		else if(pid.indexOf("LCQ2")>-1){
			str.append("2");
		}else if(pid.indexOf("LCQD")>-1){
			str.append("3");
		}else if (pid.indexOf("LCQG")>-1){
			str.append("4");
		}else{
			str.append("0");
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select distinct(receiptNo) from t_receipt where receiptNo like '"+str+"%' order by dcreatetime desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("receiptNo");
//					System.out.println(sub);
				int code = Integer.parseInt(sub.substring(1,sub.length()));
				code += 1;
				last =new DecimalFormat("0000000").format(code);
			} else {
				last ="0000001";
			}
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
	public static void main(String[] args) {
		System.out.println(FinanceQuotationAction.getInstance().receiptNo("销售二部"));
	}
}
