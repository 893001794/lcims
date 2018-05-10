<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>

<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	List<String> lists = QuotationAction.getInstance().getprojectByAjax(key);
	for(int i=0;i<lists.size();i++) {
		String projectName = lists.get(i);
		out.println(projectName);
	}
%>