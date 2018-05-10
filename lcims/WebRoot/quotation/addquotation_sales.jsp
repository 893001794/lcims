<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%		
		//request.setCharacterEncoding("GBK");
		
		response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        //request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String company = request.getParameter("company");
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
        company = URLDecoder.decode(company,"UTF-8");

		//company = new String(company.getBytes("ISO8859-1"),"GBK");
        List<String> list = FlowFinal.getInstance().getSales(company);
        for(int i=0;i<list.size();i++) {
        	String v = list.get(i);
        	xml += "<select><value>" + v + "</value><text>" + v + "</text></select>";
        }
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>