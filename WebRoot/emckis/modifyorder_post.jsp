<%@page import="com.lccert.crm.chemistry.util.TimeTest"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Company"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.kis.Bank"%>
<%@page import="com.lccert.crm.kis.AdvanceType"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		out.println("报价单不存在！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	int id = Integer.parseInt(strid);
	String status = request.getParameter("status");
	String pid = request.getParameter("pid");
	String quotype = request.getParameter("quotype");
	String strcompanyid = request.getParameter("companyid");
	String usetype=request.getParameter("usetype");
	int companyid = 0;
	if(strcompanyid != null && !"".equals(strcompanyid)) {
		companyid = Integer.parseInt(strcompanyid);
	}
	String strsalesid = request.getParameter("salesid");
	int salesid = 0;
	if(strsalesid != null && !"".equals(strsalesid)) {
		salesid = Integer.parseInt(strsalesid);
	}
	String strservid = request.getParameter("servid");
	int servid = 0;
	if(strservid != null && !"".equals(strservid)) {
		servid = Integer.parseInt(strservid);
	}
	String client = request.getParameter("client");
	int clientid = 0;
	ClientForm cf = ClientAction.getInstance().getClientByName(client);
	if(cf == null) {
		out.println("客户不存在，请重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	clientid = cf.getId();
	String circle = request.getParameter("circle");
	String strbankid = request.getParameter("bankid");
	int bankid = 0;
	if(strbankid != null && !"".equals(strbankid)) {
		bankid = Integer.parseInt(strbankid);
	}
	String stradvancetypeid = request.getParameter("advancetypeid");
	int advancetypeid = 0;
	if(stradvancetypeid != null && !"".equals(stradvancetypeid)) {
		advancetypeid = Integer.parseInt(stradvancetypeid);
	}
	String invmethod = request.getParameter("invmethod");
	String invtype = request.getParameter("invtype");
	String strinvcount = request.getParameter("invcount");
	float invcount = 0;
	if(!("".equals(strinvcount) || strinvcount == null)) {
		invcount = Float.parseFloat(strinvcount);
	}
	String invhead = request.getParameter("invhead");
	String invcontent = request.getParameter("invcontent");
	String tag = request.getParameter("tag");
	String product = request.getParameter("product");
	String productsample = request.getParameter("productsample");
	String detail = request.getParameter("detail");
	//获取关联旧的报价单号
	String oldPid=request.getParameter("oldPid");
	String UI = request.getParameter("UI");
	if(usetype.equals("marketRent")){
		oldPid=null;
	}
	//获取报告客户名称
	String rpClient=request.getParameter("rpClient");
	String createuser = user.getName();
	//String amstart =request.getParameter("amstart");
	//String amend =request.getParameter("amend");
	//String pmstart =request.getParameter("pmstart");
	//String pmend =request.getParameter("pmend");
	//System.out.println(amstart+"---"+amend+"---"+pmstart+"---"+pmend);
	float totalprice = 0;
	//String timeStr=new TimeTest().TimeSerial(amstart, pmstart,amend,pmend);
	//float f=Float.parseFloat(timeStr);
	//totalprice=f*400;
	float standprice = 0;
	List<QuoItem> quoitemlist = new ArrayList<QuoItem>();
	String[] quoitemids = request.getParameterValues("quoitemid");
	String[] itemnames = request.getParameterValues("itemname");
	String[] samplenames = request.getParameterValues("samplename");
	String[] itemcounts = request.getParameterValues("itemcount");
	String[] saleprices = request.getParameterValues("saleprice");
	String[] remarks = request.getParameterValues("remark");
	//添加实际价格
	String[] prices = request.getParameterValues("price");
	for(int i=0;i<itemnames.length;i++) {
		if(itemnames[i] != null && !"".equals(itemnames[i])) {
		System.out.println("itemcounts:"+itemcounts[i]);
			QuoItem quoitem = new QuoItem();
			if(quoitemids[i]!=null && !"".equals(quoitemids[i])) {
				quoitem.setId(Integer.parseInt(quoitemids[i]));
			}
			Item item = ItemAction.getInstance().getItemByName(itemnames[i]);
			quoitem.setItem(item);
			quoitem.setCount(Float.parseFloat(itemcounts[i]));
			quoitem.setSamplename(samplenames[i]);
			quoitem.setRemark(remarks[i]);
			quoitem.setSaleprice(Float.parseFloat(saleprices[i]));
			quoitem.setPrice(Float.parseFloat(prices[i]));
			totalprice += quoitem.getCount()*quoitem.getPrice();
			quoitemlist.add(quoitem);
		} else if(quoitemids[i] != null && !"".equals(quoitemids[i])) {
			int quoitemid = Integer.parseInt(quoitemids[i]);
			OrderAction.getInstance().deleteQuoitemById(quoitemid);
		}
	}
	Order o = new Order();
	Company company = new Company();
	UserForm sales = new UserForm();
	UserForm service = new UserForm();
	ClientForm clientform = new ClientForm();
	AdvanceType advancetype = new AdvanceType();
	Bank bank = new Bank();
	company.setId(companyid);
	sales.setId(salesid);
	service.setId(servid);
	bank.setId(bankid);
	clientform.setId(clientid);
	advancetype.setId(advancetypeid);
	o.setId(id);
	o.setPid(pid);
	o.setQuotype(quotype);
	o.setCompany(company);
	o.setSales(sales);
	o.setService(service);
	o.setClient(clientform);
	o.setCircle(circle);
	o.setBank(bank);
	o.setAdvancetype(advancetype);
	o.setInvmethod(invmethod);
	o.setInvtype(invtype);
	o.setInvcount(invcount);
	o.setInvhead(invhead);
	o.setInvcontent(invcontent);
	o.setTag(tag);
	o.setProduct(product);
	o.setProductsample(productsample);
	o.setDetail(detail);
	o.setTotalprice(totalprice);
	o.setStandprice(standprice);
	o.setCreateuser(createuser);
	o.setQuoitems(quoitemlist);
	o.setStatus(status);
	o.setOldPid(oldPid);
	o.setRpclient(rpClient);
	o.setUI(UI);
	if(OrderAction.getInstance().modifyOrder(o)) {
		out.println("订单修改成功");
		out.println("<a href='orderdetail.jsp?id="+id+ "'>返回</a>");
		return;
	} else {
		out.println("订单修改失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>