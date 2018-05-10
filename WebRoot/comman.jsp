<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%
	UserForm user = (UserForm)session.getAttribute("user");
	if(user == null) {
		String url = request.getProtocol().substring(0, 4).toLowerCase() + "://"    
                  + request.getRemoteHost() + ":" + request.getLocalPort()    
                  + request.getContextPath() + "/login.jsp"; 
        out.println("<script language='javascript'>parent.location.href='" + url + "';</script>");
		return;
	}
	
 %>