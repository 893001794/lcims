<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	if(ChemProjectAction.getInstance().checkingfinish(sid)) {
		ChemProjectAction.getInstance().sendCheckingfinish(sid);
		out.println("<div alight=center>");
		out.println("初检完成确认成功");
		out.println("<a href='mylabproject.jsp'>返回</a>");
		out.println("</div>");
	} else {
		out.println("<div alight=center>");
		out.println("初检完成确认失败，请返回！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
	}
%>