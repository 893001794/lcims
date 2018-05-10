<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%
	String[] ids = request.getParameterValues("selectFlag");
	String status = request.getParameter("status");
	String ulr="?status="+status+"&1=1";
	for(int i=0;i<ids.length;i++) {
		FlowAction.getInstance().delFlow(ids[i]);
		if(ids[i].trim() !=null && !"".equals(ids[i].trim())){
			DaoFactory.getInstance().getPhyQuoteManageDao().delectQuoteManage(status,Integer.parseInt(ids[i].trim()));
		}
	}
		response.sendRedirect(request.getHeader("Referer")+ulr);
		ulr="";
%>