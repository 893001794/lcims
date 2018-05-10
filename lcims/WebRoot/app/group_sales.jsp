<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.net.URLDecoder"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.user.UserForm"%>
<%		
		response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        //request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String itemNumber = request.getParameter("itemNumber");
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
        List list =DaoFactory.getInstance().getInventoryDao().getCategoryByParent(itemNumber);
        for(int i=0;i<list.size();i++) {
        	List group =(List)list.get(i);
        	xml += "<select><value>" + group.get(0) + "</value><text>" +group.get(1) + "</text></select>";
        }
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>