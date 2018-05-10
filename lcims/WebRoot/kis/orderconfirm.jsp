<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		out.println("<div alight=center>");
		out.println("请选择需要审核的对象！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
	int id = Integer.parseInt(strid);
	String auditor=user.getName();
	if(OrderAction.getInstance().createquotation(id,auditor)) {
		out.println("<div alight=center>");
		out.println("审核成功");
		response.sendRedirect("myorder.jsp");
		//out.println("<a href='myorder.jsp'>返回</a>");
		out.println("</div>");
	} else {
		out.println("<div alight=center>");
		out.println("审核不成功，请返回重新审核！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
 %>

