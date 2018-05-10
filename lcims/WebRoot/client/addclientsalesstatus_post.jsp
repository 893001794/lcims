<%@page import="com.lccert.crm.client.ClientSalesStatusAction"%>
<%@page import="com.lccert.crm.client.ClientSalesStatusForm"%>
<%@page import="com.lccert.crm.client.ClientProjectAction"%>
<%@page import="com.lccert.crm.client.ClientProjectForm"%>
<%@page import="com.lccert.crm.client.ClientStatusForm"%>
<%@page import="com.lccert.crm.client.ClientRivalForm"%>
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
	ClientSalesStatusForm clientSalesStatus=new ClientSalesStatusForm();
	String id = request.getParameter("id");
	String clientId = request.getParameter("clientId");
	String client = request.getParameter("client");
	String clientType = request.getParameter("clientType");
	String nature = request.getParameter("nature");
	String basicinfor = request.getParameter("basicinfor");
	String rivalinfor = request.getParameter("rivalinfor");
	String procureflow = request.getParameter("procureflow");
	String projectinfor = request.getParameter("projectinfor");
	String inquirystage = request.getParameter("inquirystage");
	String salesstrategy = request.getParameter("salesstrategy");
	String totalpriceStr = request.getParameter("totalprice");
	String signbackpriceStr = request.getParameter("signbackprice");
	String sampleinfor = request.getParameter("sampleinfor");
	String partpayment = request.getParameter("partpayment");
	String invoice = request.getParameter("invoice");
	String certificate = request.getParameter("certificate");
	String satisfaction = request.getParameter("satisfaction");
	String remark = request.getParameter("remark");
	float totalprice=0f;
	if(totalpriceStr !=null){
		totalprice=Float.parseFloat(totalpriceStr);
	}
	float signbackprice=0f;
	if(signbackpriceStr !=null){
		signbackprice=Float.parseFloat(signbackpriceStr);
	}
	clientSalesStatus.setClientid(clientId);
	clientSalesStatus.setClientName(client);
	clientSalesStatus.setClientType(clientType);
	clientSalesStatus.setNature(nature);
	clientSalesStatus.setBasicInfor(basicinfor);
	clientSalesStatus.setRivalInfor(rivalinfor);
	clientSalesStatus.setProcureFlow(procureflow);
	clientSalesStatus.setProjectInfor(projectinfor);
	clientSalesStatus.setInquirYstage(inquirystage);
	clientSalesStatus.setSalesStrategy(salesstrategy);
	clientSalesStatus.setTotalPrice(totalprice);
	clientSalesStatus.setSignBackPrice(signbackprice);
	clientSalesStatus.setSampleInfor(sampleinfor);
	clientSalesStatus.setPartPayment(partpayment);
	clientSalesStatus.setInvoice(invoice);
	clientSalesStatus.setCertificate(certificate);
	clientSalesStatus.setSatisFaction(satisfaction);
	clientSalesStatus.setRemark(remark);
	int isok=0;
	System.out.println(id);
	if(id !=null && !"".equals(id)&& !"null".equals(id)){
		clientSalesStatus.setId(Integer.parseInt(id));
		isok=ClientSalesStatusAction.getInstance().addClientSalesStatus(clientSalesStatus);
	}else{
		isok=ClientSalesStatusAction.getInstance().addClientSalesStatus(clientSalesStatus);
	}
	if(isok != 0) {
		out.println("销售客户跟进记录操作成功");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	} else {
		out.println("销售客户跟进记录操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
%>