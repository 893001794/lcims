<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.vo.TestChildParent"%>
<%		
		//request.setCharacterEncoding("GBK");
		response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String type = request.getParameter("type");
        String parentId = request.getParameter("parentId");
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
		type = new String(type.getBytes("ISO8859-1"),"GBK");
        List samll = FlowFinal.getInstance().getAllTestSmall(type,Integer.parseInt(parentId));
        for(int i=0;i<samll.size();i++) {
        	TestChildParent tcp =(TestChildParent) samll.get(i);
        	xml += "<select2><value>" +tcp.getId()+ "</value><text>" + tcp.getChildName() + "</text></select2>";
        }
        
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>