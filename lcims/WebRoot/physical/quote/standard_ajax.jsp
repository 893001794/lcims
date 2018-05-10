<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.PhyStandard"%> 

<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	List<PhyStandard> psList = DaoFactory.getInstance().getPhyProjectDao().getStandardByAjax(key);
	for(int i=0;i<psList.size();i++) {
		PhyStandard ps = (PhyStandard)psList.get(i);
		out.println(ps.getId()+":"+ps.getCode()+";");
	}
%>
