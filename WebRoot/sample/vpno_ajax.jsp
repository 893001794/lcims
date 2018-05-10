<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.dao.impl.SampleDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>


<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	List list =new ArrayList();
	list.add("vpno");
	List pnoList=DaoFactory.getInstance().getSimpleDao().getPackageNo(list,key);
	if(list.size()>0){
	List columns=(List)pnoList.get(0);
	for(int i=0;i<columns.size();i++){
	String pno =columns.get(i).toString();
	out.println(pno);
	}
	}
	
%>