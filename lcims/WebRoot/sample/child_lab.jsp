<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.net.URLDecoder"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.user.UserForm"%>
<%		
		//request.setCharacterEncoding("GBK");
		
		response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        //request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String planid = request.getParameter("planid");
        int parentId=0;
        if(planid !=null){
        	parentId=Integer.parseInt(planid);
        }
        //String status = request.getParameter("status");
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
        List rows =DaoFactory.getInstance().getSimpleDao().getChildLab(parentId);
	       for(int j=0;j<rows.size();j++){
		        List columns =(List)rows.get(j);
		        	xml += "<select><value>" +columns.get(0) + "</value><text>" +columns.get(0)+ "</text></select>";
	       }
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>