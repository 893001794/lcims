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
		out.println("���۵������ڣ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	int id = Integer.parseInt(strid);
	
	String status = request.getParameter("status");
	
	String pid = request.getParameter("pid");
	String quotype = request.getParameter("quotype");
	String strcompanyid = request.getParameter("companyid");
	//System.out.println(strcompanyid+":�ֹ�˾id");
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
		out.println("�ͻ������ڣ����������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
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
	invmethod="����Ŀ";
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
	//��ȡ��ѡ���ֵ
	String greencheckbox=request.getParameter("greencheckbox");
	//��ȡ��ɫͨ����ֵ
	String greenchannel="";
	//��Ʒ���
	String sampleNo=request.getParameter("sampleNo");
	//��Ʒ��ʽ
	String samplePlan=request.getParameter("TSsample");
	if(greencheckbox !=null ){
	greenchannel=request.getParameter("greenchannel");
	}
	//��ȡ�����ɵı��۵���
	String oldPid=request.getParameter("oldPid");
	//��ȡ����ͻ�����
	String rpClient=request.getParameter("rpClient");
	//��ȡ��Ŀid+����id
	String projectleader=request.getParameter("projectleader");
	//��ݸ�������Ĳ���Ա����
	String sampling=request.getParameter("sampling");
	//��ݸ�������Ĳ���ʱ��
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
	//��ݸ�������Ĳ���Ա����
	o.setSampling(sampling);
	//��ݸ�������Ĳ���ʱ��
	o.setSampltime(samplD);
	if(OrderAction.getInstance().modifyOrder(o)) {
		out.println("�����޸ĳɹ�");
		out.println("<a href='myorder.jsp'>����</a>");
		return;
	} else {
		out.println("�����޸�ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
%>