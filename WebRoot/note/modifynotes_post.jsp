<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	int id = 0;
	if(strid == null || "".equals(strid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	} else {
		id = Integer.parseInt(strid);
	}
	String head = request.getParameter("head");
	String content = request.getParameter("content");
	
	Forum fr = new Forum();
	fr.setId(id);
	fr.setHead(head);
	fr.setContent(content);
	
	if(ForumAction.getInstance().modForum(fr)) {
		ForumAction.getInstance().sendForum(fr);
		out.println("�޸ĳɹ�");
		out.println("<a href='system_notes.jsp'>����</a>");
		return;
	} else {
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
%>