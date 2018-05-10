<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@page import="com.lccert.crm.kis.Item"%>

<%
	String key = new String(request.getParameter("q").getBytes("iso8859-1"),"utf-8");
	List<Item> items = ItemAction.getInstance().getEndByKeyWords(key);
	StringBuffer str = new StringBuffer();
	str.append("[");
	for(int i=0;i<items.size();i++) {
		Item item = items.get(i);
		str.append("{\"itemid\":\"");
		str.append(item.getItemNumber());
		str.append("\",");
		str.append("\"name\":\"");
		str.append(item.getName());
		str.append("\",");
		str.append("\"saleprice\":\"");
		str.append(item.getSaleprice());
		str.append("\",");
		str.append("\"controlprice\":\"");
		str.append(item.getControlprice());
		str.append("\",");
		str.append("\"standprice\":\"");
		str.append(item.getStandprice());
		str.append("\",");
		str.append("\"outprice\":\"");
		str.append(item.getOutprice());
		str.append("\",");
		str.append("\"plane\":\"");
		str.append(item.getPlane());
		str.append("\"},");
		
	}
	//System.out.println(str+"£ºstr");
	String temp = str.substring(0,str.length()-1);
	String json = temp + "]";
//System.out.println("json:" + json);
	response.setContentType("application/json;charset=UTF-8");   
    response.setCharacterEncoding("UTF-8");   
        // ÉèÖÃä¯ÀÀÆ÷²»Òª»º´æ   
    response.setHeader("Pragma", "No-cache");   
    response.setHeader("Cache-Control", "no-cache");   
    response.setDateHeader("Expires", 0);
	response.getWriter().println(json);
	//response.getWriter().println("[{\"itemid\":\"01.01\",\"name\":\"Lead(Pb)\",\"saleprice\":\"80.0\",\"standprice\":\"100.0\",\"outprice\":\"0.0\"},{\"itemid\":\"01.02\",\"name\":\"Cadmium(Cd)ïÓ\",\"saleprice\":\"100.0\",\"standprice\":\"100.0\",\"outprice\":\"0.0\"}]");
%>
