<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="java.util.ArrayList"%>

<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	UserForm user = (UserForm)session.getAttribute("user");
	//boolean flag =false;
	//---------------------2011-08-----02-------------------
	boolean flag =user.getTicketid().matches("00010101");
		//---------------------2011-08-----02-------------------
	
	List<Quotation> lists=new ArrayList<Quotation>();
	if(flag == true){
	 	lists = QuotationAction.getInstance().searchQuotation(key,"part","G");
	}else if(user.getName().equals("Å·Íñö©")){
		lists = QuotationAction.getInstance().searchQuotation(key,"part","2");
	}
	else{
		lists = QuotationAction.getInstance().searchQuotation(key,"part","");
	}
	for(int i=0;i<lists.size();i++) {
		Quotation quotation = lists.get(i);
		out.println(quotation.getPid());
	}
%>