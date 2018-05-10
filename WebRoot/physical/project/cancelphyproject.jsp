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
		out.println("取消项目成功");
		out.println("<a href='myproject.jsp'>返回</a>");
		out.println("</div>");
	} else {
		out.println("<div alight=center>");
		out.println("取消项目失败，请返回！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
	}
%>