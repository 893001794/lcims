<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%		
		//request.setCharacterEncoding("GBK");
		response.setContentType("text/xml");
		//System.out.println("进来");
        response.setHeader("Cache-Control", "no-cache");
          request.setCharacterEncoding("UTF-8");
          response.setCharacterEncoding("UTF-8");
       String type = request.getParameter("type");
        //type =new String(type.getBytes("ISO-8859-1"),"GBK");
       // System.out.println(type+"--------type");
        
        
        String topLevel =request.getParameter("topLevel");  //获取顶级的id
        int topLevelId=0;
        if(topLevel !=null){
  			topLevelId=Integer.parseInt(topLevel);      	
        }
        //根据顶级的id来获取对应的一级的类别
        
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
		type = new String(type.getBytes("ISO8859-1"),"GBK");
        List big = FlowFinal.getInstance().getAllTestBig(type,topLevelId);
        System.out.println("------"+big+"-----");
        for(int i=0;i<big.size();i++) {
        	TestParents tp =(TestParents) big.get(i);
        	xml += "<select1><value>" + tp.getId() + "</value><text>" + tp.getName() + "</text></select1>";
        }
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
        
%>