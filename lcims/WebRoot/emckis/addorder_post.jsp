<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
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
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	if(command == null || !"add".equals(command)) {
		out.println("请添加报价单！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	String quotype = request.getParameter("quotype");
	String strcompanyid = request.getParameter("companyid");
	int companyid = 0;
	if(strcompanyid != null && !"".equals(strcompanyid)) {
		companyid = Integer.parseInt(strcompanyid);
	}
	String strsalesid = request.getParameter("salesid");
	int salesid = 0;
	if(strsalesid != null && !"".equals(strsalesid)) {
		salesid = Integer.parseInt(strsalesid);
	}
	//String strservid = request.getParameter("servid");
	//System.out.println(strservid);
//	int servid = 0;
//	if(strservid != null && !"".equals(strservid)) {
//		servid = Integer.parseInt(strservid);
//	}
	//System.out.println(servid);
	String client = request.getParameter("client");
	int clientid = 0;
	ClientForm cf = ClientAction.getInstance().getClientByName(client);
	if(cf == null) {
		out.println("客户不存在，请重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	String stradvancetypeid = request.getParameter("advancetypeid");
	int advancetypeid = 0;
	if(stradvancetypeid != null && !"".equals(stradvancetypeid)) {
		advancetypeid = Integer.parseInt(stradvancetypeid);
	}
	String invmethod = request.getParameter("invmethod");
	String invtype = request.getParameter("invtype");
	//获取旧的报价单号
	String oldPid=request.getParameter("oldPid");
	//String amstart =request.getParameter("amstart");
	//String amend =request.getParameter("amend");
	//String pmstart =request.getParameter("pmstart");
	//String pmend =request.getParameter("pmend");
	//收款时间
	String collectionStr=request.getParameter("collectionD");
	Date collection = new SimpleDateFormat("yyy.MM.dd").parse(collectionStr);
	//测试时间
	String testStr =request.getParameter("testD");
	Date test = new SimpleDateFormat("yyy.MM.dd").parse(testStr);
	//收件时间
	String receiptStr=request.getParameter("receiptD");

	Date receipt = new SimpleDateFormat("yyy.MM.dd").parse(receiptStr);
	//开票总金额
	String strinvcount = request.getParameter("invcount");
	String UI = request.getParameter("UI");
	float invcount = 0;
	if(!("".equals(strinvcount) || strinvcount == null)) {
		invcount = Float.parseFloat(strinvcount);
	}
	//开票抬头
	String invhead = request.getParameter("invhead");
	//String invcontent = request.getParameter("invcontent");
//	String strprespefund = request.getParameter("prespefund").trim();
//	float prespefund = 0;
//	if(!("".equals(strprespefund) || strprespefund == null)) {
//		prespefund = Float.parseFloat(strprespefund);
//	}
	// completetime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse("000-00-00 00:00");
	//Date quotime = new SimpleDateFormat("yyy-MM-dd");
	String tag = request.getParameter("tag");
	//产品说明
	String product = request.getParameter("product");
	String detail = request.getParameter("detail");
	float totalprice = 0;
	//String timeStr=new TimeTest().TimeSerial(amstart, pmstart,amend,pmend);
	//float f=Float.parseFloat(timeStr);
	//totalprice=f*400;
	float standprice = 0;
	List<QuoItem> quoitemlist = new ArrayList<QuoItem>();
	String[] itemnames = request.getParameterValues("itemname");
	String[] samplenames = request.getParameterValues("samplename");
	String[] itemcounts = request.getParameterValues("itemcount");
	String[] saleprices = request.getParameterValues("saleprice");
	String[] remarks = request.getParameterValues("remark");
	//添加实际价格
	String[] prices = request.getParameterValues("price");
	for(int i=0;i<itemnames.length;i++) {
		if(itemnames[i] != null && !"".equals(itemnames[i])) {
			QuoItem quoitem = new QuoItem();
			Item item = ItemAction.getInstance().getItemByName(itemnames[i]);
			quoitem.setItem(item);
			quoitem.setCount(Float.parseFloat(itemcounts[i]));
			quoitem.setSamplename(samplenames[0]);
			quoitem.setRemark(remarks[i]);
			quoitem.setSaleprice(Float.parseFloat(saleprices[i]));
			quoitem.setPrice(Float.parseFloat(prices[i]));
			DecimalFormat df = new DecimalFormat("##");      
			//实际价格*数量=总价格，以前是标准价格*数量=总价格
			totalprice +=Float.parseFloat(df.format(quoitem.getCount()*(quoitem.getPrice()>0?quoitem.getPrice():quoitem.getSaleprice())));
			quoitemlist.add(quoitem);
		}
	}
	
	Order o = new Order();
	Company company = new Company();
	UserForm sales = UserAction.getInstance().getUserById(salesid);
	UserForm service = new UserForm();
	AdvanceType advancetype = new AdvanceType();
	Bank bank = new Bank();
	company.setId(companyid);
	//bank.setId(bankid);
	advancetype.setId(advancetypeid);
	
	o.setQuotype(quotype);
	o.setCompany(company);
	o.setSales(sales);
	o.setService(service);
	o.setClient(cf);
	//o.setCircle(circle);
	o.setBank(bank);
	//System.out.println(quotime);
	//System.out.println(completetime);
	//o.setQuotime(quotime);
	//o.setCompletetime(completetime);
	o.setAdvancetype(advancetype);
	o.setInvmethod(invmethod);
	o.setInvtype(invtype);
	o.setInvcount(invcount);
	o.setInvhead(invhead);
	//o.setInvcontent(invcontent);
	//o.setPrespefund(prespefund);
	o.setTag(tag);
	o.setProduct(product);
	//o.setProductsample(productsample);
	o.setDetail(detail);
	o.setTotalprice(totalprice);
	o.setStandprice(standprice);
	//o.setCreateuser(createuser);
	o.setQuoitems(quoitemlist);
	o.setOldPid(oldPid);
	//o.setAmstart(amstart);
	//o.setAmend(amend); 
	//o.setPmend(pmend);
//	o.setPmstart(pmstart);
	o.setCollection(collection);
	o.setTest(test);
	o.setReceipt(receipt);
	o.setUI(UI);
	int isok = OrderAction.getInstance().addOrder(o,"3");
	if(isok != 0) {
		out.println("订单添加成功");
		out.println("<a href='orderdetail.jsp?id="+isok + "'>返回</a>");
		return;
	} else {
		out.println("订单添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>