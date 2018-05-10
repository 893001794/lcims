<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%
	String[] ids = request.getParameterValues("selectFlag");
	String keywords = request.getParameter("keywords");
	String type = request.getParameter("type");
	for(int i=0;i<ids.length;i++) {
		//System.out.println("ids[" + i + "] = " + ids[i]);
		FlowAction.getInstance().delFlow(ids[i]);
	}
	//System.out.println(request.getHeader("Referer"));
	response.sendRedirect(request.getHeader("Referer") + "&keywords=" + keywords + "&type=" + type);
%>