<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%> 

<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	List<String> sales = ClientAction.getInstance().getSalesByAjax(key);
	for(int i=0;i<sales.size();i++) {
		String sale = sales.get(i);
		out.println(sale);
	}
%>
