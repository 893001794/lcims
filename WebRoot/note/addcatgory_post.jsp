<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.system.Category"%>
<%@page import="com.lccert.crm.system.CategoryAction"%>

<%
	request.setCharacterEncoding("GBK");
	String categoryName = request.getParameter("category");
	Category cate =new Category();
	cate.setName(categoryName);
	if(CategoryAction.getInstance().addCategory(cate)){
	    out.println("��ӳɹ�");
		out.println("<a href='addnotes.jsp;'>����</a>");
		return;
	} else {
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
%>