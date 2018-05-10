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
	    out.println("添加成功");
		out.println("<a href='addnotes.jsp;'>返回</a>");
		return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
%>