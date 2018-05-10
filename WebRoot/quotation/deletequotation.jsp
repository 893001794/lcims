<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%
	String[] pids = request.getParameterValues("selectFlag");
	for(int i=0;i<pids.length;i++) {
		//System.out.println("pids[" + i + "] = " + pids[i]);
		QuotationAction.getInstance().delQuotationByPid(pids[i]);
	}
	response.sendRedirect(request.getHeader("Referer"));
%>