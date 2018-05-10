<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="clientcommon.jsp"  %>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding("GBK");
	String clientid = request.getParameter("clientid");
	String strcontactid = request.getParameter("contactid");
	int contactid = 0;
	if(strcontactid != null && !"".equals(strcontactid)) {
		contactid = Integer.parseInt(strcontactid);
	}
	int id = 0;
	String strid = request.getParameter("id");
	if(strid != null && !"".equals(strid)) {
		id = Integer.parseInt(strid);
	}
	
	String name = request.getParameter("name");
	String shortname = request.getParameter("shortname");
	String ename = request.getParameter("ename");
	String contact = request.getParameter("contact");
	String sex = request.getParameter("sex");
	String dept = request.getParameter("dept");
	String job = request.getParameter("job");
	String tel = request.getParameter("tel");
	String mobile = request.getParameter("mobile");
	String fax = request.getParameter("fax");
	String qq = request.getParameter("qq");
	String email = request.getParameter("email");
	String addr = request.getParameter("addr");
	String eaddr = request.getParameter("eaddr");
	String zipcode = request.getParameter("zipcode");
	String sales = request.getParameter("sales");
	int salesid = UserAction.getInstance().getIdByName(sales);
	if(salesid ==0) {
		out.println("负责销售不存在！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	String product = request.getParameter("product");
	String clevel = request.getParameter("clevel");
	String creditlevel = request.getParameter("creditlevel");
	String pay = request.getParameter("pay");
	//String area = request.getParameter("area");
	String status = request.getParameter("status");
	
	
	ClientForm client = new ClientForm();
	client.setId(id);
	client.setClientid(clientid);
	client.setName(name);
	client.setShortname(shortname);
	client.setEname(ename);
	client.setAddr(addr);
	client.setEaddr(eaddr);
	client.setZipcode(zipcode);
	client.setSalesid(salesid);
	client.setProduct(product);
	client.setClevel(clevel);
	client.setCreditlevel(creditlevel);
	client.setPay(pay);
	//client.setArea(area);
	client.setStatus(status);
	ContactForm cf = new ContactForm();
	cf.setId(contactid);
	cf.setContact(contact);
	cf.setSex(sex);
	cf.setDept(dept);
	cf.setJob(job);
	cf.setEmail(email);
	cf.setMobile(mobile);
	cf.setFax(fax);
	cf.setQq(qq);
	cf.setTel(tel);
	client.setContact(cf);
	if(!ClientAction.getInstance().modifyClient(client)) {
		out.println("修改失败！<br>");
		out.println("<a href='history.back()'>返回</a>");
		return;
	}
	
	out.println("修改成功!<br>");
	out.println("<a href='clientdetail.jsp?clientid=" + client.getClientid() + "'>返回列表</a>");
%>