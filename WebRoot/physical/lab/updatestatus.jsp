<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
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
	int istatus = 0;
	String stristatus = request.getParameter("istatus");
	if(stristatus != null && !"".equals(stristatus)) {
		istatus = Integer.parseInt(stristatus);
	}
	
	Project p = new Project();
	PhyProject pp = new PhyProject();
	p.setSid(sid);
	pp.setIstatus(istatus);
	p.setObj(pp);
	
	if(PhyProjectAction.getInstance().updateStatus(p)) {
		out.println("<div alight=center>");
		out.println("��Ŀ״̬���³ɹ�");
		out.println("<a href='phylab_manage.jsp'>����</a>");
		out.println("</div>");
	} else {
		out.println("<div alight=center>");
		out.println("��Ŀ״̬����ʧ�ܣ��뷵�أ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
	}
%>