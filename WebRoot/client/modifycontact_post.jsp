<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="clientcommon.jsp"  %>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	int id = -1;
	if(strid != null && !"".equals(strid)) {
		try {
			id = Integer.parseInt(strid);
		} catch(NumberFormatException e) {
			id = -1;
		}
	}
	
	if(id == -1) {
		out.println("�޸�ʧ�ܣ�<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	String clientid = request.getParameter("clientid");
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
	cf.setId(id);
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
	if(!ClientAction.getInstance().modifyContact(cf)) {
		out.println("�޸�ʧ�ܣ�<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
	out.println("�޸ĳɹ�!<br>");
	out.println("<a href='showcontact.jsp?clientid=" + clientid + "'>�����б�</a>");
%>