<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.net.URLDecoder"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%		
		//request.setCharacterEncoding("GBK");
		
		response.setContentType("text");
        //response.setHeader("Cache-Control", "no-cache");
        //request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String client = request.getParameter("client");

        client = URLDecoder.decode(client,"UTF-8");
		boolean flag = ClientAction.getInstance().selectClientByName(client);
			out.print(flag);
%>