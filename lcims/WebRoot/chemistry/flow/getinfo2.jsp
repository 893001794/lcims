<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%		
		//request.setCharacterEncoding("GBK");
		response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String parentId = request.getParameter("parentId");
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
        List big = FlowFinal.getInstance().getAllTestPlan(Integer.parseInt(parentId));
        for(int i=0;i<big.size();i++) {
        	TestPlan tp =(TestPlan) big.get(i);
            xml += "<select3><value>" +tp.getId()+":"+tp.getParentName().trim()+" | "+tp.getChildName().trim()+" | "+tp.getPlanName().trim()+ "</value><text>" +tp.getPlanName().trim()+ "</text></select3>";
        	//xml += "<select3><value>" +childName+":"+tp.getParentName().trim()+" | "+tp.getChildName().trim()+" | "+tp.getPlanName().trim()+ "</value><text>" +tp.getPlanName().trim()+ "</text></select3>";
        }
       // System.out.println(xml);
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>