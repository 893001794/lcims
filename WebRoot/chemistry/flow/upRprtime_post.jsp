<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>

<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid");
	String prtime = request.getParameter("prtime");
	if(BarCodeAction.getInstance().getUpdateRptime(prtime,rid)){
	
	}
%>