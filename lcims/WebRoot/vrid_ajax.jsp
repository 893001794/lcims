<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>


<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	List<String> lists = ProjectAction.getInstance().searchVrid(key);
	for(int i=0;i<lists.size();i++) {
		String vrid = lists.get(i);
		out.println(vrid);
	}
%>