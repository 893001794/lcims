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
		out.println("��ѡ��Ҫ�޸ĵĿͻ���<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
	String strcontactid = request.getParameter("contactid");
	int contactid = 0;
	if(strcontactid != null && !"".equals(strcontactid)) {
		contactid = Integer.parseInt(strcontactid);
	}
	
	
	if(!ClientAction.getInstance().modifyMainContact(clientid,contactid)) {
		out.println("��Ҫ��ϵ���޸�ʧ�ܣ�<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
	response.sendRedirect("showcontact.jsp?clientid=" + clientid);
	return;
%>