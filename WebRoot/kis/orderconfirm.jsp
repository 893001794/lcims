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
		out.println("��ѡ����Ҫ��˵Ķ���");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
	int id = Integer.parseInt(strid);
	String auditor=user.getName();
	if(OrderAction.getInstance().createquotation(id,auditor)) {
		out.println("<div alight=center>");
		out.println("��˳ɹ�");
		response.sendRedirect("myorder.jsp");
		//out.println("<a href='myorder.jsp'>����</a>");
		out.println("</div>");
	} else {
		out.println("<div alight=center>");
		out.println("��˲��ɹ����뷵��������ˣ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
 %>

