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
        String status = request.getParameter("status");
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
        if(status.equals("1")){
       String [] plan =planid.split(",");
	       for(int j=0;j<plan.length;j++){
		        List list = ItemAction.getInstance().getEdmPlane(plan[j]);
		        	xml += "<select><value>" +list.get(0) + "</value><text>" +list.get(1)+ "</text></select>";
	       }
       }else if(status.equals("2")){
       String parentid=ItemAction.getInstance().getEdmYleParent(planid);
       	  String [] plan =parentid.split(",");
     	  for(int j=0;j<plan.length;j++){
	        List list = ItemAction.getInstance().getEdmChild(plan[j]);
	        	xml += "<select><value>" +list.get(0) + "</value><text>" +list.get(1)+ "</text></select>";
	        }
       }
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>