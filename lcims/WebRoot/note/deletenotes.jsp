<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%
	String[] ids = request.getParameterValues("selectFlag");
	for(int i=0;i<ids.length;i++) {
		//System.out.println("ids[" + i + "] = " + ids[i]);
		ForumAction.getInstance().deleteForumById(ids[i]);
	}
	response.sendRedirect(request.getHeader("Referer"));
%>