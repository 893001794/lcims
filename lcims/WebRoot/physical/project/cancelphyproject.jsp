<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	if(PhyProjectAction.getInstance().cancelPhyProject(sid)) {
		out.println("<div alight=center>");
		out.println("ȡ����Ŀ�ɹ�");
		out.println("<a href='myproject.jsp'>����</a>");
		out.println("</div>");
	} else {
		out.println("<div alight=center>");
		out.println("ȡ����Ŀʧ�ܣ��뷵�أ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
	}
%>