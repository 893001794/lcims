<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@ include file="../comman.jsp"  %>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.client.ClientPermission"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%
	if(!user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {
		response.sendRedirect("error.html");
		return;
	}
 %>


