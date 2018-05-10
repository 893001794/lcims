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
        String strcompanyid = request.getParameter("companyid");
        
        int companyid = 0;
        if(strcompanyid != null && !"".equals(strcompanyid)) {
        	companyid = Integer.parseInt(strcompanyid);
        	//如果分公司区域为4则代表东莞
        	//if(companyid == 4){
        	//companyid=3;
        	//}
        }
        String xml_start = "<selects>";
        String xml_end = "</selects>";
        String xml = "";
        List<UserForm> list = FlowFinal.getInstance().getSales(companyid);
        for(int i=0;i<list.size();i++) {
        	UserForm sales = list.get(i);
        	xml += "<select><value>" + sales.getId() + "</value><text>" + sales.getName() + "</text></select>";
        }
        String last_xml = xml_start + xml + xml_end;
        response.getWriter().write(last_xml);
        
%>