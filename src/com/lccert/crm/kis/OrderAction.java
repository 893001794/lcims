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
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;

/**
 * 报价单管理类（包括service层和dao层）
 * @author Eason
 *
 */
public class OrderAction {

	private static OrderAction instance = null;

	private OrderAction() {

	}

	public synchronized static OrderAction getInstance() {
		if (instance == null) {
			instance = new OrderAction();
		}
		return instance;
	}

	/**
	 * 自动生成报价单号
	 * @param order 报价单
	 * @return
	 */
	private String makePid(Order order) {

		StringBuffer str = new StringBuffer();
		String last = "";

		int companyid = order.getCompany().getId();
		if(companyid!=4){
			str.append("LCQ");
			if(companyid == 1) {
				String dept = order.getSales().getDept();
				if("销售二部".equals(dept)) {
					str.append("2");//中山销售二部
				} else {
					str.append("1");//中山销售一部
				}
			} else if(companyid == 2) {
				str.append("G");//广州
			} else if(companyid == 3) {
				str.append("D");//东莞
			} else if(companyid == 4) {
				str.append("S");//顺德
			} else if(companyid == 5) {
				str.append("J");//江门
			}
		}else{
			str.append("LCDE");
		}
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		String key = str.toString() + year;
		str.append(year + month);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_sales_order where vpid like '%" + key + "%'" +
				" order by substring(vpid,9,12) desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vpid");
				int code = Integer.parseInt(sub.substring(8, sub.length()));
				code += 1;
				last = new DecimalFormat("0000").format(code);
			} else {
				last = "0001";
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
	private String makeEPid(Order order,String status) {
		StringBuffer str = new StringBuffer();
		String last = "";
		int companyid = order.getCompany().getId();
		if(status.equals("2")){
			str.append("LCDE");
		}
		if(status.equals("3")){
			str.append("LCQE");
		}
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		String key = str.toString() + year;
		str.append(year + month);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_sales_order where vpid like '%" + key + "%'" +
				" order by substring(vpid,9,12) desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vpid");
				int code = Integer.parseInt(sub.substring(8, sub.length()));
				code += 1;
				last = new DecimalFormat("0000").format(code);
			} else {
				last = "0001";
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

	/**
	 * 添加报价单
	 * @param order
	 * @return
	 */
	public synchronized int addOrder(Order order,String status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		int isok = 0;
		if(status.equals("1")){
			order.setPid(makePid(order));
		}else{
			order.setPid(makeEPid(order,status));
		}
		String sql = "insert into t_sales_order(vpid,quotype,companyid,salesid," +
				"servid,completetime,clientid,circle,bankid,quotime,advancetypeid," +
				"invmethod,invtype,invcount,invhead,invcontent,prespefund,tag,product," +
				"productsample,detail,totalprice,standprice,createuser,createtime,status,estimatespoints," +
				"voldpid,rpclient,greenchannel,confirmid,vsampleplan,vsampleNo,amstart,amend,pmstart,pmend,dcollection,dtest,dreceipt,UI,vedmprojectuserid,vsampling,dsampltime)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),'n',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, order.getPid());
			pstmt.setString(2, order.getQuotype());
			pstmt.setInt(3, order.getCompany().getId());
			pstmt.setInt(4, order.getSales().getId());
			pstmt.setInt(5, order.getService().getId());
			if(order.getCompletetime()== null){
				pstmt.setTimestamp(6,null);
			}else{
				pstmt.setTimestamp(6, new Timestamp(order.getCompletetime().getTime()));
			}

			pstmt.setInt(7, order.getClient().getId());
			pstmt.setString(8, order.getCircle());
			pstmt.setInt(9, order.getBank().getId());
			if(order.getQuotime()== null){
				pstmt.setTimestamp(10,null);
			}else{
				pstmt.setTimestamp(10,new Timestamp(order.getQuotime().getTime()));
			}
			//pstmt.setTimestamp(10, new Timestamp(order.getQuotime().getTime()));
			pstmt.setInt(11,order.getAdvancetype().getId());
			pstmt.setString(12, order.getInvmethod());
			pstmt.setString(13, order.getInvtype());
			pstmt.setFloat(14, order.getInvcount());
			pstmt.setString(15, order.getInvhead());
			pstmt.setString(16, order.getInvcontent());
			pstmt.setFloat(17, order.getPrespefund());
			pstmt.setString(18, order.getTag());
			pstmt.setString(19, order.getProduct());
			pstmt.setString(20, order.getProductsample());
			pstmt.setString(21, order.getDetail());
			pstmt.setFloat(22, order.getTotalprice());
			pstmt.setFloat(23, order.getStandprice());
			pstmt.setString(24, order.getCreateuser());
			pstmt.setInt(25, order.getEstimatesPoints());
			pstmt.setString(26, order.getOldPid());
			pstmt.setString(27, order.getRpclient());
			pstmt.setString(28, order.getGreenchannel());
			pstmt.setInt(29, order.getConfirmid());
			pstmt.setString(30, order.getSamplePlane());
			pstmt.setString(31, order.getSampleNo());
			pstmt.setString(32, order.getAmstart());
			pstmt.setString(33, order.getAmend());
			pstmt.setString(34, order.getPmstart());
			pstmt.setString(35, order.getPmend());
			if(order.getCollection()== null){
				pstmt.setTimestamp(36,null);
			}else{
				pstmt.setTimestamp(36,new Timestamp(order.getCollection().getTime()));
			}
			if(order.getTest()== null){
				pstmt.setTimestamp(37,null);
			}else{
				pstmt.setTimestamp(37,new Timestamp(order.getTest().getTime()));
			}
			if(order.getReceipt()== null){
				pstmt.setTimestamp(38,null);
			}else{
				pstmt.setTimestamp(38,new Timestamp(order.getReceipt().getTime()));
			}
			pstmt.setString(39, order.getUI());
			pstmt.setString(40, order.getProjectleader());
			pstmt.setString(41, order.getSampling());
			if(order.getSampltime()== null){
				pstmt.setTimestamp(42,null);
			}else{
				pstmt.setTimestamp(42, new Timestamp(order.getSampltime().getTime()));
			}
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			rs.next();
			int key = rs.getInt(1);

			List<QuoItem> list = order.getQuoitems();

			sql = "insert into t_sales_order_quoitem(orderid,itemid,count,saleprice,remark,samplename,planeid,childid,price) values(?,?,?,?,?,?,?,?,?)";
			pstmt = DB.prepareStatement(conn, sql);
			for(int i=0;i<list.size();i++) {
				QuoItem quoitem = list.get(i);
				pstmt.setInt(1, key);
				pstmt.setInt(2, quoitem.getItem().getId());
//				System.out.println(quoitem.getItem().getId()+"---");
				pstmt.setFloat(3, quoitem.getCount());
				pstmt.setFloat(4, quoitem.getSaleprice());
				pstmt.setString(5, quoitem.getRemark());
				pstmt.setString(6, quoitem.getSamplename());
				pstmt.setInt(7, quoitem.getPlaneId());
				pstmt.setInt(8, quoitem.getChildId());
				pstmt.setFloat(9,quoitem.getPrice());
				pstmt.addBatch();
			}
			pstmt.executeBatch();

			conn.commit();
			isok = key;
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
		return isok;
	}





	/**
	 * 修改报价单
	 * @param order
	 * @return
	 */
	public synchronized boolean modifyOrder(Order order) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_sales_order set vpid=?,quotype=?,companyid=?,salesid=?," +
				"servid=?,completetime=?,clientid=?,circle=?,bankid=?,quotime=?,advancetypeid=?," +
				"invmethod=?,invtype=?,invcount=?,invhead=?,invcontent=?,prespefund=?,tag=?,product=?," +
				"productsample=?,detail=?,totalprice=?,standprice=?,voldpid=? ,rpclient=?,greenchannel=?,vsampleplan=?,vsampleNo=?,voldpid=?,UI=?,vedmprojectuserid=?,vsampling=?,dsampltime=? where id=?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, order.getPid());
			pstmt.setString(2, order.getQuotype());
			pstmt.setInt(3, order.getCompany().getId());
			//System.out.println(order.getCompany().getId());
			pstmt.setInt(4, order.getSales().getId());
			pstmt.setInt(5, order.getService().getId());
			if(order.getCompletetime()==null){
				pstmt.setTimestamp(6, null);
			}else{
				pstmt.setTimestamp(6, new Timestamp(order.getCompletetime().getTime()));
			}
			pstmt.setInt(7, order.getClient().getId());
			pstmt.setString(8, order.getCircle());
			pstmt.setInt(9, order.getBank().getId());

			if(order.getQuotime()==null){
				pstmt.setTimestamp(10, null);
			}else{
				pstmt.setTimestamp(10, new Timestamp(order.getQuotime().getTime()));
			}
			pstmt.setInt(11,order.getAdvancetype().getId());
			pstmt.setString(12, order.getInvmethod());
			pstmt.setString(13, order.getInvtype());
			pstmt.setFloat(14, order.getInvcount());
			pstmt.setString(15, order.getInvhead());
			pstmt.setString(16, order.getInvcontent());
			pstmt.setFloat(17, order.getPrespefund());
			pstmt.setString(18, order.getTag());
			pstmt.setString(19, order.getProduct());
			pstmt.setString(20, order.getProductsample());
			pstmt.setString(21, order.getDetail());
			pstmt.setFloat(22, order.getTotalprice());
			pstmt.setFloat(23, order.getStandprice());
			pstmt.setString(24, order.getOldPid());
			pstmt.setString(25, order.getRpclient());
			pstmt.setString(26, order.getGreenchannel());
			pstmt.setString(27, order.getSamplePlane());
			pstmt.setString(28, order.getSampleNo());
			pstmt.setString(29, order.getOldPid());
			pstmt.setString(30, order.getUI());
			pstmt.setString(31, order.getProjectleader());
			pstmt.setString(32, order.getSampling());
			if(order.getSampltime()==null){
				pstmt.setTimestamp(33, null);
			}else{
				pstmt.setTimestamp(33, new Timestamp(order.getSampltime().getTime()));
			}
			pstmt.setInt(34, order.getId());

			pstmt.executeUpdate();
			List<QuoItem> list = order.getQuoitems();
			for(int i=0;i<list.size();i++) {
				QuoItem quoitem = list.get(i);
				System.out.println("====="+quoitem.getPrice());
				if(quoitem.getId()==0) {
					sql = "insert into t_sales_order_quoitem(orderid,itemid,count,saleprice,remark,samplename,planeid,childid,price) values(?,?,?,?,?,?,?,?,?)";
				} else {
					sql = "update t_sales_order_quoitem set orderid=?,itemid=?,count=?,saleprice=?,remark=?,samplename=?,planeid=?,childid=?,price=? where id=" + quoitem.getId();
				}
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, order.getId());
				pstmt.setInt(2, quoitem.getItem().getId());
				pstmt.setFloat(3, quoitem.getCount());
				pstmt.setFloat(4, quoitem.getSaleprice());
				pstmt.setString(5, quoitem.getRemark());
				pstmt.setString(6, quoitem.getSamplename());
				pstmt.setInt(7, quoitem.getPlaneId());
				pstmt.setInt(8, quoitem.getChildId());
				pstmt.setFloat(9,quoitem.getPrice());
				pstmt.executeUpdate();
			}
			Quotation quo=QuotationAction.getInstance().getQuotationByPid(order.getPid());
			if(quo !=null && !"".equals(quo)){
				if(!quo.getQuotype().equals(order.getQuotype())){
					sql ="update t_quotation set equotype=?,greenchannel=?,salesid=? where vpid =?";
					pstmt.setString(1, order.getQuotype());
					pstmt.setString(2, order.getGreenchannel());
					pstmt.setInt(3,order.getSales().getId());
					pstmt.setString(4, order.getPid());
					pstmt.executeUpdate();
				}
			}

			//面向异常编程
			if("y".equals(order.getStatus())) {
				if(!modifyquotation(order.getId())) {
					throw new SQLException();
				}
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
	 * 修改报价单编号
	 * @param order
	 * @return
	 */
	public synchronized boolean modOrderPid(String oldPid,String newPid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;

		String sql = "update t_sales_order set vpid=? where vpid=?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, newPid);
			pstmt.setString(2, oldPid);
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


	//查询最大的编号

	/**
	 * 根据用户名取得用户信息
	 * @param name
	 * @return
	 */
	public String getMaxPid() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String pid ="";
		String sql = "select  vpid from t_sales_order  where vpid LIKE '%LCQ11008%' ORDER BY vpid DESC  LIMIT 0 , 1";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pid=rs.getString("vpid");
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
		return pid;
	}
	/**
	 * 得到销售本人所有订单
	 * @param pageNo
	 * @param pageSize
	 * @param salesid
	 * @return
	 */
	public PageModel getMyAllOrders(int pageNo, int pageSize,int salesid,String pid,int clientid,String parttype) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Order> list = new ArrayList<Order>();
		StringBuffer str = new StringBuffer();
		str.append(" and salesid='" + salesid + "'");
		if(pid != null && !"".equals(pid)) {
			str.append(" and vpid like '%" + pid + "%'");
		}
		if(clientid != 0) {
			str.append(" and clientid = " + clientid);
		}
		if ("no".equals(parttype)) {
			str.append(" and status = 'n'");
		} else if("yes".equals(parttype)){
			str.append(" and status = 'y'");
		}
		String sql = "select * from t_sales_order where 1=1 "+str.toString()+" order by id desc limit "+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			//pstmt.setInt(1, salesid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setPid(rs.getString("vpid"));
				order.setQuotype(rs.getString("quotype"));

				order.setCompany(getCompanyById(rs.getInt("companyid")));
				order.setSales(UserAction.getInstance().getUserById(rs.getInt("salesid")));
				order.setService(UserAction.getInstance().getUserById(rs.getInt("servid")));
				order.setCompletetime(rs.getTimestamp("completetime"));
				order.setClient(ClientAction.getInstance().getClientById(rs.getInt("clientid")));
				order.setCircle(rs.getString("circle"));
				order.setBank(getBankById(rs.getInt("bankid")));
				order.setQuotime(rs.getTimestamp("quotime"));
				order.setAdvancetype(getAdvanctById(rs.getInt("advancetypeid")));
				order.setInvmethod(rs.getString("invmethod"));
				order.setInvtype(rs.getString("invtype"));
				order.setInvcount(rs.getFloat("invcount"));
				order.setInvhead(rs.getString("invhead"));
				order.setInvcontent(rs.getString("invcontent"));
				order.setPrespefund(rs.getFloat("prespefund"));
				order.setTag(rs.getString("tag"));
				order.setProduct(rs.getString("product"));
				order.setProductsample(rs.getString("productsample"));
				order.setTotalprice(rs.getFloat("totalprice"));
				order.setStandprice(rs.getFloat("standprice"));
				order.setDetail(rs.getString("detail"));
				order.setCreateuser(rs.getString("createuser"));
				order.setCreatetime(rs.getTimestamp("createtime"));
				order.setStatus(rs.getString("status"));
				order.setQuoitems(getQuoItems(order.getId()));

				list.add(order);
			}
			int totalRecords = getSalesTotalRecords(conn, "select count(*) from t_sales_order where 1=1 "+str.toString()+"");
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
	 * 得到所有销售订单
	 * @param pageNo
	 * @param pageSize
	 * @param salesid
	 * @return
	 */
	public PageModel getAllOrders(int pageNo, int pageSize,String status,String pid,String uid,Integer clientid,String year,String month) {
		//System.out.println(pageNo+"---"+pageSize);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Order> list = new ArrayList<Order>();
		String str ="";
		if(status !=null && !"".equals(status)){
			str+=" and vpid like 'LCQE%'";
		}
		if(pid !=null && !"".equals(pid)){
			str+=" and vpid like '%"+pid+"%'";
		}
		if(uid !=null && !"".equals(uid)){
			str+=" and UI like '%"+uid+"%'";
		}
		if(clientid != 0) {
			str+=" and clientid = " + clientid;
		}
		//System.out.println(pid+"----"+uid);
		if((pid ==null || "".equals(pid)) && (uid ==null||"".equals(uid))){
			if (month != null && !"".equals(month)) {
				str+=" and month(dreceipt)="+month+"";
			}
			if(year !=null && !"".equals(year)){
				str+=" and year (dreceipt)="+year+"";
			}
		}
		String sql = "select * from t_sales_order where 1=1 "+str+" order by id desc limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setPid(rs.getString("vpid"));
				order.setQuotype(rs.getString("quotype"));
				order.setCompany(getCompanyById(rs.getInt("companyid")));
				order.setSales(UserAction.getInstance().getUserById(rs.getInt("salesid")));
				order.setService(UserAction.getInstance().getUserById(rs.getInt("servid")));
				order.setCompletetime(rs.getTimestamp("completetime"));
				order.setClient(ClientAction.getInstance().getClientById(rs.getInt("clientid")));
				order.setCircle(rs.getString("circle"));
				order.setBank(getBankById(rs.getInt("bankid")));
				order.setQuotime(rs.getTimestamp("quotime"));
				order.setAdvancetype(getAdvanctById(rs.getInt("advancetypeid")));
				order.setInvmethod(rs.getString("invmethod"));
				order.setInvtype(rs.getString("invtype"));
				order.setInvcount(rs.getFloat("invcount"));
				order.setInvhead(rs.getString("invhead"));
				order.setInvcontent(rs.getString("invcontent"));
				order.setPrespefund(rs.getFloat("prespefund"));
				order.setTag(rs.getString("tag"));
				order.setProduct(rs.getString("product"));
				order.setProductsample(rs.getString("productsample"));
				order.setTotalprice(rs.getFloat("totalprice"));
				order.setStandprice(rs.getFloat("standprice"));
				//order.setSaleprice(rs.getFloat("saleprice"));
				order.setDetail(rs.getString("detail"));
				order.setCreateuser(rs.getString("createuser"));
				order.setCreatetime(rs.getTimestamp("createtime"));
				order.setStatus(rs.getString("status"));
				order.setQuoitems(getQuoItems(order.getId()));
				order.setCollection(rs.getTimestamp("dcollection"));
				order.setTest(rs.getTimestamp("dtest"));
				order.setReceipt(rs.getTimestamp("dreceipt"));
				order.setAmstart(rs.getString("amstart"));
				order.setAmend(rs.getString("amend"));
				order.setPmstart(rs.getString("pmstart"));
				order.setPmend(rs.getString("pmend"));
				order.setProduct(rs.getString("product"));
				order.setOldPid(rs.getString("voldpid"));
				order.setUI(rs.getString("UI"));
				StringBuffer projectcontent = new StringBuffer();
				for(int i=0;i<order.getQuoitems().size();i++) {
					projectcontent.append(order.getQuoitems().get(i).getItem().getName());
					projectcontent.append(";");
				}
				order.setProjectcontent(projectcontent.toString());
				list.add(order);
			}
			int totalRecords = getSalesTotalRecords(conn, "select count(*) from t_sales_order where 1=1 "+str+"");
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
	 * 得到个人订单数量
	 * @param conn
	 * @param salesid
	 * @return
	 */
	private int getSalesTotalRecords(Connection conn, String sql) {
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
	 * 根据报价单号来查询样品名称
	 * @param companyid
	 * @return
	 */
	public String getsamplenameByPid(String pid) {
		//System.out.println(pid+"-----");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String samplename=""; //样品名称
		String sql = "select soq.samplename from t_quotation as q,t_sales_order as so,t_sales_order_quoitem as soq  where so.vpid =q.vpid and so.id =soq.orderid  and  q.vpid =?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				samplename=rs.getString("samplename");
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
		return samplename;
	}


	/**
	 * 根据ID得到公司详细信息
	 * @param companyid
	 * @return
	 */
	private Company getCompanyById(int companyid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Company company = new Company();
//		System.out.println(companyid);
		String sql = "select * from t_company where id = ? order by id desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, companyid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				company.setId(rs.getInt("id"));
				company.setName(rs.getString("name"));
				company.setFullname(rs.getString("fullname"));
				company.setAddress(rs.getString("address"));
				company.setTel(rs.getString("tel"));
				company.setFax(rs.getString("fax"));
				company.setUrl(rs.getString("url"));
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
		return company;
	}

	/**
	 * 根据id查找银行账号详细信息
	 * @param bankid
	 * @return
	 */
	private Bank getBankById(int bankid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Bank bank = new Bank();
		String sql = "select * from t_sales_order_bank where id = ? order by id desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, bankid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bank.setId(rs.getInt("id"));
				bank.setName(rs.getString("name"));
				bank.setCreditcard(rs.getString("creditcard"));
				bank.setAccount(rs.getString("account"));
				bank.setAddress(rs.getString("address"));
				bank.setDesc(rs.getString("vdesc"));
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
		return bank;
	}

	/**
	 * 根据id查找付款方式详细信息
	 * @param advancetypeid
	 * @return
	 */
	private AdvanceType getAdvanctById(int advancetypeid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		AdvanceType advancetype = new AdvanceType();
		String sql = "select * from t_sales_order_advancetype where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, advancetypeid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				advancetype.setId(rs.getInt("id"));
				advancetype.setName(rs.getString("name"));
				advancetype.setDesc(rs.getString("vdesc"));
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
		return advancetype;
	}

	/**
	 * 根据订单号取得测试项目
	 * @param orderid
	 * @return
	 */
	public List<QuoItem> getQuoItems(int orderid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<QuoItem> list = new ArrayList<QuoItem>();
		String sql = "select * from t_sales_order_quoitem where orderid = ? order by id";
//		System.out.println(sql+"----"+orderid);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, orderid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QuoItem qi = new QuoItem();
				qi.setId(rs.getInt("id"));
				qi.setOrderid(rs.getInt("orderid"));
				qi.setItem(getItemById(rs.getInt("itemid")));
				qi.setCount(rs.getFloat("count"));
				qi.setSaleprice(rs.getFloat("saleprice"));
				qi.setRemark(rs.getString("remark"));
				qi.setSamplename(rs.getString("samplename"));
				qi.setPlaneId(rs.getInt("planeid"));
				qi.setChildId(rs.getInt("childid"));
				qi.setPrice(rs.getFloat("price"));
				list.add(qi);
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

	/***
	 * 根据id获取名称
	 * @param orderid
	 * @return
	 */
	public String  getQuoItems(int orderid,String status) {
//		System.out.println(orderid);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String str ="";
		String sql ="";
		if(status.equals("plane")){
			sql = "select * from t_edm_test_plan where id = ? order by id";
		}else if (status.equals("child")){
			sql = "select * from t_edm_test_child where id = ? order by id";
		}
//		System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, orderid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				str=rs.getString("vname");
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
		return str;
	}

	/**
	 * 根据测试ID取得测试具体内容
	 * @param itemid
	 * @return
	 */
	public Item getItemById(int itemid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Item item = new Item();
		String sql = "select * from t_sales_order_item where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, itemid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				item.setId(rs.getInt("id"));
				item.setItemNumber(rs.getString("item_number"));
				item.setName(rs.getString("name"));
				item.setFullname(rs.getString("fullname"));
				item.setSaleprice(rs.getFloat("saleprice"));
				item.setStandprice(rs.getFloat("standprice"));
				item.setControlprice(rs.getFloat("controlprice"));
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
		return item;
	}

	/**
	 * 搜索个人订单
	 * @param pageNo
	 * @param pageSize
	 * @param salesid
	 * @param pid
	 * @param clientid
	 * @param parttype
	 * @return
	 */
	public PageModel searchMyOrder(int pageNo,int pageSize,int salesid,String pid, int clientid,String parttype) {
		String sql ="select * from t_sales_order where 1=1 ";
		StringBuffer str = new StringBuffer();
		str.append(" and salesid='" + salesid + "'");
		if(pid != null && !"".equals(pid)) {
			str.append(" and vpid like '%" + pid + "%'");
		}
		if(clientid != 0) {
			str.append(" and clientid = " + clientid);
		}
		if ("no".equals(parttype)) {
			str.append(" and status = 'n'");
		} else if("yes".equals(parttype)){
			str.append(" and status = 'y'");
		}
		str.append(" order by id desc ");
		sql = sql+str.toString();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Order> list = new ArrayList<Order>();
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setPid(rs.getString("vpid"));
				order.setQuotype(rs.getString("quotype"));
				order.setCompany(getCompanyById(rs.getInt("companyid")));
				order.setSales(UserAction.getInstance().getUserById(rs.getInt("salesid")));
				order.setService(UserAction.getInstance().getUserById(rs.getInt("servid")));
				order.setCompletetime(rs.getTimestamp("completetime"));
				order.setClient(ClientAction.getInstance().getClientById(rs.getInt("clientid")));
				order.setCircle(rs.getString("circle"));
				order.setBank(getBankById(rs.getInt("bankid")));
				order.setQuotime(rs.getTimestamp("quotime"));
				order.setAdvancetype(getAdvanctById(rs.getInt("advancetypeid")));
				order.setInvmethod(rs.getString("invmethod"));
				order.setInvtype(rs.getString("invtype"));
				order.setInvcount(rs.getFloat("invcount"));
				order.setInvhead(rs.getString("invhead"));
				order.setInvcontent(rs.getString("invcontent"));
				order.setPrespefund(rs.getFloat("prespefund"));
				order.setTag(rs.getString("tag"));
				order.setProduct(rs.getString("product"));
				order.setProductsample(rs.getString("productsample"));
				order.setTotalprice(rs.getFloat("totalprice"));
				order.setStandprice(rs.getFloat("standprice"));
				order.setDetail(rs.getString("detail"));
				order.setCreateuser(rs.getString("createuser"));
				order.setCreatetime(rs.getTimestamp("createtime"));
				order.setStatus(rs.getString("status"));
				order.setQuoitems(getQuoItems(order.getId()));
				list.add(order);
			}
			int totalRecords = getSalesTotalRecords(conn, "select count(*) from  t_sales_order  t where t.vpid in (select vpid from t_sales_order where 1=1 "+str.toString()+")");
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
	 * 搜索所有销售订单
	 * @param pageNo
	 * @param pageSize
	 * @param salesid
	 * @param pid
	 * @param clientid
	 * @param parttype
	 * @return
	 */
	public PageModel searchOrder(int pageNo,int pageSize,String pid,String uid, int clientid,String parttype) {
		String whereStr="";
		String countSql="select count(*) from t_sales_order where 1=1 ";
		StringBuffer str = new StringBuffer();
		str.append("select * from t_sales_order where 1=1");
		if(pid != null && !"".equals(pid)) {
			whereStr=" and vpid like '%" + pid + "%'";
			//str.append(" and vpid like '%" + pid + "%'");
		}
		if(uid != null && !"".equals(uid)) {
			whereStr+=" and UI like '%" + uid + "%'";
			//str.append(" and UI like '%" + uid + "%'");
		}
		if(clientid != 0) {
			whereStr+=" and clientid = " + clientid;
			//str.append(" and clientid = " + clientid);
		}
		if ("no".equals(parttype)) {
			whereStr+= "and status = 'n'";
			//str.append(" and status = 'n'");
		} else if("yes".equals(parttype)){
			whereStr+= "and status = 'y'";
			//str.append(" and status = 'y'");
		}
		str.append(whereStr);
		str.append(" order by id desc");
		countSql+=whereStr;
		String sql = str.toString();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Order> list = new ArrayList<Order>();
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setPid(rs.getString("vpid"));
				order.setQuotype(rs.getString("quotype"));
				order.setCompany(getCompanyById(rs.getInt("companyid")));
				//System.out.println(rs.getInt("salesid")+"-----销售id");
				order.setSales(UserAction.getInstance().getUserById(rs.getInt("salesid")));
				//System.out.println(UserAction.getInstance().getUserById(rs.getInt("salesid"))+"------------------");
				order.setService(UserAction.getInstance().getUserById(rs.getInt("servid")));
				order.setCompletetime(rs.getTimestamp("completetime"));
				order.setClient(ClientAction.getInstance().getClientById(rs.getInt("clientid")));
				order.setCircle(rs.getString("circle"));
				order.setBank(getBankById(rs.getInt("bankid")));
				order.setQuotime(rs.getTimestamp("quotime"));
				order.setAdvancetype(getAdvanctById(rs.getInt("advancetypeid")));
				order.setInvmethod(rs.getString("invmethod"));
				order.setInvtype(rs.getString("invtype"));
				order.setInvcount(rs.getFloat("invcount"));
				order.setInvhead(rs.getString("invhead"));
				order.setInvcontent(rs.getString("invcontent"));
				order.setPrespefund(rs.getFloat("prespefund"));
				order.setTag(rs.getString("tag"));
				order.setProduct(rs.getString("product"));
				order.setProductsample(rs.getString("productsample"));
				order.setTotalprice(rs.getFloat("totalprice"));
				order.setStandprice(rs.getFloat("standprice"));
				order.setDetail(rs.getString("detail"));
				order.setCreateuser(rs.getString("createuser"));
				order.setCreatetime(rs.getTimestamp("createtime"));
				order.setStatus(rs.getString("status"));
				order.setQuoitems(getQuoItems(order.getId()));
				order.setCollection(rs.getTimestamp("dcollection"));
				order.setTest(rs.getTimestamp("dtest"));
				order.setReceipt(rs.getTimestamp("dreceipt"));
				order.setAmstart(rs.getString("amstart"));
				order.setAmend(rs.getString("amend"));
				order.setPmstart(rs.getString("pmstart"));
				order.setPmend(rs.getString("pmend"));
				order.setProduct(rs.getString("product"));
				order.setUI(rs.getString("UI"));
				StringBuffer projectcontent = new StringBuffer();
				for(int i=0;i<order.getQuoitems().size();i++) {
					projectcontent.append(order.getQuoitems().get(i).getItem().getName());
					projectcontent.append(";");
				}
				order.setProjectcontent(projectcontent.toString());
				list.add(order);
			}
			int totalRecords = getSalesTotalRecords(conn, countSql);
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
	 * 根据ID得到订单
	 * @param id
	 * @return
	 */
	public Order getOrderById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Order order = new Order();
		String sql = "select * from t_sales_order where id = ?";
//		System.out.println(sql+"--"+id);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				order.setId(rs.getInt("id"));
				order.setPid(rs.getString("vpid"));
				order.setQuotype(rs.getString("quotype"));
				order.setCompany(getCompanyById(rs.getInt("companyid")));
				order.setSales(UserAction.getInstance().getUserById(rs.getInt("salesid")));
				order.setService(UserAction.getInstance().getUserById(rs.getInt("servid")));
				order.setCompletetime(rs.getTimestamp("completetime"));
				order.setClient(ClientAction.getInstance().getClientById(rs.getInt("clientid")));
				order.setCircle(rs.getString("circle"));
				order.setBank(getBankById(rs.getInt("bankid")));
				order.setQuotime(rs.getTimestamp("quotime"));
				order.setAdvancetype(getAdvanctById(rs.getInt("advancetypeid")));
				order.setInvmethod(rs.getString("invmethod"));
				order.setInvtype(rs.getString("invtype"));
				order.setInvcount(rs.getFloat("invcount"));
				order.setInvhead(rs.getString("invhead"));
				order.setInvcontent(rs.getString("invcontent"));
				order.setPrespefund(rs.getFloat("prespefund"));
				order.setTag(rs.getString("tag"));
				order.setProduct(rs.getString("product"));
				order.setProductsample(rs.getString("productsample"));
				order.setTotalprice(rs.getFloat("totalprice"));
				order.setStandprice(rs.getFloat("standprice"));
				order.setDetail(rs.getString("detail"));
				order.setCreateuser(rs.getString("createuser"));
				order.setCreatetime(rs.getTimestamp("createtime"));
				order.setStatus(rs.getString("status"));
				order.setQuoitems(getQuoItems(order.getId()));
				order.setOldPid(rs.getString("voldpid"));
				order.setRpclient(rs.getString("rpclient"));
				order.setEstimatesPoints(rs.getInt("estimatespoints"));
				order.setGreenchannel(rs.getString("greenchannel"));
				order.setConfirmid(rs.getInt("confirmid"));
				order.setSamplePlane(rs.getString("vsampleplan"));
				order.setSampleNo(rs.getString("vsampleNo"));
				order.setAmstart(rs.getString("amstart"));
				order.setAmend(rs.getString("amend"));
				order.setPmstart(rs.getString("pmstart"));
				order.setPmend(rs.getString("pmend"));
				order.setCollection(rs.getTimestamp("dcollection"));
				order.setTest(rs.getTimestamp("dtest"));
				order.setReceipt(rs.getTimestamp("dreceipt"));
				order.setProduct(rs.getString("product"));
				order.setUI(rs.getString("UI"));
				order.setProjectleader(rs.getString("vedmprojectuserid"));
				order.setSampling(rs.getString("vsampling"));
				order.setSampltime(rs.getTimestamp("dsampltime"));
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
		return order;
	}



	/**
	 * 根据pid得到订单id
	 * @param id
	 * @return
	 */
	public int getOrderByPid(String pid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		int id =0;
		String sql = "select id from t_sales_order where vpid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				id=rs.getInt("id");
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
		return id;
	}
	/**
	 * 审核订单
	 * @param id
	 * @return
	 */
	public boolean confirmorder(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_sales_order set status='y' where id = ?";

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
	 * 审核订单后，添加报价单
	 * @param id
	 * @return
	 */
	public boolean createquotation(int id,String auditor) {
		//	System.out.println("审核人:"+auditor);
		Order order = getOrderById(id);
		Quotation qt = new Quotation();
		qt.setPid(order.getPid());
		qt.setQuotype(order.getQuotype());
		qt.setCompany(order.getCompany().getName());
		qt.setSales(order.getSales().getName());
		qt.setClient(order.getClient().getName());
		StringBuffer projectcontent = new StringBuffer();
		for(int i=0;i<order.getQuoitems().size();i++) {
			projectcontent.append(order.getQuoitems().get(i).getItem().getName());
			projectcontent.append(";");
		}
		qt.setProjectcontent(projectcontent.toString());
		qt.setCompletetime(order.getCompletetime());
		qt.setTotalprice(order.getTotalprice());
		qt.setAdvancetype(order.getAdvancetype().getName());
		qt.setInvcount(order.getInvcount());
		qt.setInvtype(order.getInvtype());
		qt.setInvmethod(order.getInvmethod());
		qt.setInvcontent(order.getInvcontent());
		qt.setInvhead(order.getInvcontent());
		qt.setPrespefund(order.getPrespefund());
		qt.setTag(order.getTag());
		qt.setCreateuser(order.getCreateuser());
		qt.setStandprice(order.getStandprice());
		qt.setOldPid(order.getOldPid());
		qt.setRpclient(order.getRpclient());
		qt.setGreenchannel(order.getGreenchannel());
		qt.setConfirmid(order.getConfirmid());
		qt.setStatus("建立");
		qt.setAuditman(auditor);
		qt.setAmstart(order.getAmstart());
		qt.setAmend(order.getAmend());
		qt.setPmstart(order.getPmstart());
		qt.setPmend(order.getPmend());
		qt.setCollection(order.getCollection());
		qt.setTest(order.getTest());
		qt.setReceipt(order.getReceipt());
		qt.setProduct(order.getProduct());
		qt.setSampling(order.getSampling());
		qt.setSampltime(order.getSampltime());

		if(!QuotationAction.getInstance().addQuotation(qt)) {
			return false;
		}
		if(!confirmorder(id)) {
			return false;
		}

		return true;
	}

	/**
	 * 修改报价单
	 * @param id
	 * @return
	 */
	public boolean modifyquotation(int id) {
		Order order = getOrderById(id);
		Quotation qt = new Quotation();
		qt.setPid(order.getPid());
		qt.setQuotype(order.getQuotype());
		qt.setCompany(order.getCompany().getName());
		qt.setSales(order.getSales().getName());
		qt.setClient(order.getClient().getName());

		StringBuffer projectcontent = new StringBuffer();
		for(int i=0;i<order.getQuoitems().size();i++) {
			projectcontent.append(order.getQuoitems().get(i).getItem().getName());
			projectcontent.append(";");
		}

		qt.setProjectcontent(projectcontent.toString());
		qt.setCompletetime(order.getCompletetime());
		qt.setTotalprice(order.getTotalprice());
		qt.setAdvancetype(order.getAdvancetype().getName());
		qt.setInvcount(order.getInvcount());
		qt.setInvtype(order.getInvtype());
		qt.setInvmethod(order.getInvmethod());
		qt.setInvcontent(order.getInvcontent());
		qt.setInvhead(order.getInvcontent());
		qt.setPrespefund(order.getPrespefund());
		qt.setTag(order.getTag());
		qt.setCreateuser(order.getCreateuser());
		qt.setStandprice(order.getStandprice());

		if(!QuotationAction.getInstance().updateQuotation(qt)) {
			return false;
		}

		return true;
	}

	/**
	 * 删除测试项
	 * @param quoitemid
	 * @return
	 */
	public boolean deleteQuoitemById(int quoitemid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isok = false;
		boolean auto = false;
		String sql = "delete from t_sales_order_quoitem where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, quoitemid);
			pstmt.executeUpdate();

			conn.commit();
			isok = true;
		} catch (SQLException e) {
			try {
				conn.rollback();
				isok = false;
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


	//根据报价但老查询估计的测试点数
	public int getEstimateSpoints(String pid ){
		String sql = "select estimatespoints from t_sales_order where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int estimatespoints=0;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				estimatespoints=rs.getInt("estimatespoints");

			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return estimatespoints;
	}

}
