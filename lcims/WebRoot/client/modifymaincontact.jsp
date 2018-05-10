<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="clientcommon.jsp"  %>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String clientid = request.getParameter("clientid");
	if(clientid == null || "".equals(clientid)) {
		out.println("请选择要修改的客户！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	String strcontactid = request.getParameter("contactid");
	int contactid = 0;
	if(strcontactid != null && !"".equals(strcontactid)) {
		contactid = Integer.parseInt(strcontactid);
	}
	
	
	if(!ClientAction.getInstance().modifyMainContact(clientid,contactid)) {
		out.println("主要联系人修改失败！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	response.sendRedirect("showcontact.jsp?clientid=" + clientid);
	return;
%>