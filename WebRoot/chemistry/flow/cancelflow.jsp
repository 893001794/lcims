<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String fid = request.getParameter("fid");
	if(fid == null || "".equals(fid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	if(FlowAction.getInstance().cancelFlow(fid)) {
		out.println("<div alight=center>");
		out.println("ȡ����ת���ɹ�");
		out.println("<a href='flow_manage.jsp'>����</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("ȡ����ת��ʧ�ܣ��뷵�أ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
%>