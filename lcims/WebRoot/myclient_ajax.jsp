<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
    <%@ include file="comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%> 

<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	String name = user.getName();
	List<ClientForm> clientForms = ClientAction.getInstance().getMyClientsByAjax(key,name);
	for(int i=0;i<clientForms.size();i++) {
		ClientForm client = (ClientForm)clientForms.get(i);
		out.println(client.getName());
	}
%>
