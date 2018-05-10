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
	//System.out.println(strcompanyid+":分公司id");
	int companyid =4;
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
	String strquotime = request.getParameter("quotime");
	Date quotime = new SimpleDateFormat("yyy-MM-dd").parse(strquotime);
	String strcompletetime = request.getParameter("completetime");
	Date completetime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strcompletetime);
	String stradvancetypeid = request.getParameter("advancetypeid");
	int advancetypeid = 0;
	if(stradvancetypeid != null && !"".equals(stradvancetypeid)) {
		advancetypeid = Integer.parseInt(stradvancetypeid);
	}
	String invmethod = request.getParameter("invmethod");
	invmethod="总项目";
	String invtype = request.getParameter("invtype");
	String strinvcount = request.getParameter("invcount");
	float invcount = 0;
	if(!("".equals(strinvcount) || strinvcount == null)) {
		invcount = Float.parseFloat(strinvcount);
	}
	String invhead = request.getParameter("invhead");
	String invcontent = request.getParameter("invcontent");
	String strprespefund = request.getParameter("prespefund");
	float prespefund = 0;
	if(!("".equals(strprespefund) || strprespefund == null)) {
		prespefund = Float.parseFloat(strprespefund);
	}
	String tag = request.getParameter("tag");
	String product = request.getParameter("product");
	String productsample = request.getParameter("productsample");
	String detail = request.getParameter("detail");
	//获取复选框的值
	String greencheckbox=request.getParameter("greencheckbox");
	//获取绿色通道的值
	String greenchannel="";
	//样品编号
	String sampleNo=request.getParameter("sampleNo");
	//样品形式
	String samplePlan=request.getParameter("TSsample");
	if(greencheckbox !=null ){
	greenchannel=request.getParameter("greenchannel");
	}
	//获取关联旧的报价单号
	String oldPid=request.getParameter("oldPid");
	//获取报告客户名称
	String rpClient=request.getParameter("rpClient");
	//获取项目id+采样id
	String projectleader=request.getParameter("projectleader");
	//东莞环境部的采样员名称
	String sampling=request.getParameter("sampling");
	//东莞环境部的采样时间
	String sampltime=request.getParameter("sampltime");
	Date samplD = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(sampltime);
	String createuser = user.getName();
	float totalprice = 0;
	float standprice = 0;
	List<QuoItem> quoitemlist = new ArrayList<QuoItem>();
	String[] quoitemids = request.getParameterValues("quoitemid");
	String[] itemnames = request.getParameterValues("itemname");
	String[] samplenames = request.getParameterValues("samplename");
	System.out.println(samplenames+"*----");
	String[] itemcounts = request.getParameterValues("itemcount");
	String[] saleprices = request.getParameterValues("saleprice");
	String[] plane = request.getParameterValues("plane");
	String[] yle = request.getParameterValues("yle");
	String[] remarks = request.getParameterValues("remark");
	for(int i=0;i<itemnames.length;i++) {
			if(itemnames[i] != null && !"".equals(itemnames[i])) {
			int planeId=0;
				if(plane[i] !=null){
				planeId=Integer.parseInt(plane[i]);
				}
				int yleId=0;
				if(yle[i] !=null){
				yleId=Integer.parseInt(yle[i]);
				}
			QuoItem quoitem = new QuoItem();
			if(quoitemids[i]!=null && !"".equals(quoitemids[i])) {
				quoitem.setId(Integer.parseInt(quoitemids[i]));
			}
			Item item = ItemAction.getInstance().getItemByName(itemnames[i]);
			quoitem.setItem(item);
			quoitem.setCount(Integer.parseInt(itemcounts[i]));
			if(samplenames !=null){
			quoitem.setSamplename(samplenames[i]);
			}
			quoitem.setSaleprice(Float.parseFloat(saleprices[i]));
			quoitem.setPlaneId(planeId);
			quoitem.setChildId(yleId);
			quoitem.setRemark(remarks[i]);
			
			totalprice += quoitem.getCount()*quoitem.getSaleprice();
			standprice += quoitem.getCount()*quoitem.getItem().getStandprice();
			
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
	o.setQuotime(quotime);
	o.setCompletetime(completetime);
	o.setAdvancetype(advancetype);
	o.setInvmethod(invmethod);
	o.setInvtype(invtype);
	o.setInvcount(invcount);
	o.setInvhead(invhead);
	o.setInvcontent(invcontent);
	o.setPrespefund(prespefund);
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
	o.setGreenchannel(greenchannel);
	o.setSamplePlane(samplePlan);
	o.setSampleNo(sampleNo);
	o.setProjectleader(projectleader);
	//东莞环境部的采样员名称
	o.setSampling(sampling);
	//东莞环境部的采样时间
	o.setSampltime(samplD);
	if(OrderAction.getInstance().modifyOrder(o)) {
		out.println("订单修改成功");
		out.println("<a href='myorder.jsp'>返回</a>");
		return;
	} else {
		out.println("订单修改失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>