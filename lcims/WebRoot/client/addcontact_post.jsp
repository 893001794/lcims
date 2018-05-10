<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="clientcommon.jsp"  %>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientArea"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String clientid = request.getParameter("clientid");
	System.out.println(clientid+":不知名的id");
	if(clientid == null || "".equals(clientid)) {
		out.println("添加失败！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	String contact = request.getParameter("contact");
	String sex = request.getParameter("sex");
	String dept = request.getParameter("dept");
	String job = request.getParameter("job");
	String tel = request.getParameter("tel");
	String mobile = request.getParameter("mobile");
	String fax = request.getParameter("fax");
	String qq = request.getParameter("qq");
	String email = request.getParameter("email");
	String notes = request.getParameter("notes");
	String purchase = request.getParameter("purchase");
	String level = request.getParameter("level");
	String degree = request.getParameter("degree");
	String visitnumStr = request.getParameter("visitnum");
	int visitnum=0;
	if(visitnumStr !=null && !visitnumStr.equals("")){
		visitnum=Integer.parseInt(visitnumStr);
	}
	
	ContactForm cf = new ContactForm();
	cf.setContact(contact);
	cf.setSex(sex);
	cf.setDept(dept);
	cf.setJob(job);
	cf.setEmail(email);
	cf.setMobile(mobile);
	cf.setFax(fax);
	cf.setQq(qq);
	cf.setTel(tel);
	cf.setNotes(notes);
	cf.setPurchase(purchase);
	cf.setLevel(level);
	cf.setDegree(degree);
	cf.setVisitnum(visitnum);
	if(!ClientAction.getInstance().addContact(clientid,cf)) {
		out.println("添加失败！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		//return;
	} else {
		//out.println("window.self.location = 'showcontact.jsp?clientid=" + clientid + "'");
		response.sendRedirect("showcontact.jsp?clientid=" + clientid);
		//return;
	}
%>

