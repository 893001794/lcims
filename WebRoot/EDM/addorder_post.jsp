<%@page import="com.lccert.crm.chemistry.util.DelRepeatStr"%>
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
	//获取旧的报价单号
	String oldPid=request.getParameter("oldPid");
	//获取报告客户的名称
	//获取复选框的值
	String greencheckbox=request.getParameter("greencheckbox");
	//获取绿色通道的值
	String greenchannel="";
	//打折后需要销售经理审批后登记次销售经理的id
	String confirmUserId =request.getParameter("confirmUserId");
	
	if(greencheckbox !=null ){
	greenchannel=request.getParameter("greenchannel");
	}
	//System.out.println("获取复选框的值:"+greencheckbox);
	String rpClient = request.getParameter("rpClient");
	String strinvcount = request.getParameter("invcount");
	//样品编号
	String sampleNo=request.getParameter("sampleNo");
	//样品形式
	String samplePlan=request.getParameter("TSsample");
	
	//System.out.println(sampleNo+"---"+samplePlan);
	float invcount = 0;
	
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
	//环评输入价格
	String envAssStr=request.getParameter("envAss");
	List<QuoItem> quoitemlist = new ArrayList<QuoItem>();
	String[] itemnames = request.getParameterValues("itemname");
	String[] samplenames = request.getParameterValues("samplename");
	String[] itemcounts = request.getParameterValues("itemcount");
	String[] saleprices = request.getParameterValues("saleprice");
	String[] plane = request.getParameterValues("plane");
	String[] yle = request.getParameterValues("yle");
	String[] remarks = request.getParameterValues("remark");
	String result="";
	float envAssF=0f;
	
	for(int i=0;i<itemnames.length;i++) {
	System.out.println(itemnames[i]);
		if(itemnames[i] != null && !"".equals(itemnames[i])) {
			QuoItem quoitem = new QuoItem();
			int planeId=0;
			if(plane[i] !=null){
			planeId=Integer.parseInt(plane[i]);
			}
			int yleId=0;
			if(yle[i] !=null){
			yleId=Integer.parseInt(yle[i]);
			result+=yleId+",";
			}
			Item item = ItemAction.getInstance().getItemByName(itemnames[i]);
			quoitem.setItem(item);
			quoitem.setCount(Integer.parseInt(itemcounts[i]));
			if(samplenames !=null){
				if(samplenames.length>i){
					quoitem.setSamplename(samplenames[i]);
				}
			}
			//如果测试项目为环评的时候取的价格是手动输入值
			if(itemnames[i].equals("环评项目")){
				if(envAssStr !=null&&!"".equals(envAssStr)){
				envAssF=Float.parseFloat(envAssStr);
			quoitem.setSaleprice(envAssF);
				}
			}else{
			quoitem.setSaleprice(Float.parseFloat(saleprices[i]));
				}
			quoitem.setPlaneId(planeId);
			quoitem.setChildId(yleId);
			quoitem.setRemark(remarks[i]);
			//totalprice += quoitem.getCount()*quoitem.getSaleprice();
			standprice += quoitem.getCount()*quoitem.getItem().getStandprice();
			quoitemlist.add(quoitem);
		}
	}
	int id=0;
	 Set set=new DelRepeatStr().delRepeatStr(result);
			Iterator  it=set.iterator();
			 while(it.hasNext()){
				 String str=it.next().toString();
				 if(str !=null && !"".equals(str)){
					 id=Integer.parseInt(str);
				 }
				List list =ItemAction.getInstance().getPrice(id);
				System.out.println(id);
				if(id==2215){
				totalprice+=envAssF;
				}else{
				totalprice+=Float.parseFloat(list.get(0).toString());
				}
				}
	if(invcount==0.0){
	invcount=totalprice;
	}else if(!("".equals(strinvcount) || strinvcount == null)) {
		invcount = Float.parseFloat(strinvcount);
	}
	
	Order o = new Order();
	Company company = new Company();
	UserForm sales = UserAction.getInstance().getUserById(salesid);
	UserForm service = UserAction.getInstance().getUserById(servid);
	AdvanceType advancetype = new AdvanceType();
	Bank bank = new Bank();
	company.setId(companyid);
	bank.setId(bankid);
	advancetype.setId(advancetypeid);
	o.setQuotype(quotype);
	o.setCompany(company);
	o.setSales(sales);
	o.setService(service);
	o.setClient(cf);
	o.setCircle(circle);
	o.setBank(bank);
	//东莞环境部的项目id+采样员id
	o.setProjectleader(projectleader);
	//东莞环境部的采样员名称
	o.setSampling(sampling);
	//东莞环境部的采样时间
	o.setSampltime(samplD);
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
	o.setOldPid(oldPid);
	o.setRpclient(rpClient);
	o.setSamplePlane(samplePlan);
	o.setSampleNo(sampleNo);
	if(confirmUserId!=null&&!"".equals(confirmUserId)){
		o.setConfirmid(Integer.parseInt(confirmUserId));
	}
	o.setGreenchannel(greenchannel);
	int isok = OrderAction.getInstance().addOrder(o,"2");
	if(isok != 0) {
		out.println("订单添加成功");
		out.println("<a href='orderdetail.jsp?id=" + isok + "'>返回</a>");
		return;
	} else {
		out.println("订单添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>