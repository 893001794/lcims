<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	String head = request.getParameter("head").trim();
	String content = request.getParameter("content").trim();
	String createname = user.getName();
	String deadtime = request.getParameter("deadtime");
	String class1 =request.getParameter("category").trim();
	
	Forum fr = new Forum();
	fr.setHead(head);
	fr.setContent(content);
	fr.setCreatename(createname);
	fr.setDeadtime(new SimpleDateFormat("yyyy-MM-dd").parse(deadtime));
	fr.setIscid(new Integer(class1));
	if(ForumAction.getInstance().addForum(fr)) {
		ForumAction.getInstance().sendForum(fr);
		out.println("��ӳɹ�");
		out.println("<a href='system_notes.jsp'>����</a>");
		return;
	} else {
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
%>