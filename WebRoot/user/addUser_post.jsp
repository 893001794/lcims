<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.user.UserForm"%>
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

	String Userid = request.getParameter("Userid");
	String name = request.getParameter("name");
	String Password = request.getParameter("Password");
	String Estatus = request.getParameter("Estatus");
	String tel = request.getParameter("Tel");
	String sex = request.getParameter("sex");
	String dept = request.getParameter("dept");
	String job = request.getParameter("job");
	String Popdom = request.getParameter("Popdom");
	String Ticketed = request.getParameter("Ticketed");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String sales = request.getParameter("sales");
	int address=Integer.parseInt(request.getParameter("address"));
	String serv =request.getParameter("serv");
	String isShowFspefund =request.getParameter("isShowFspefund");//是否可以查看接待费
	//获取上级Id
	String superiorid = request.getParameter("superiorid");
	UserForm user = new UserForm();
	user.setUserid(Userid);
	user.setPassword(Password);
	user.setName(name);
	user.setSex(sex);
	user.setTel(tel);
	user.setEmail(email);
	if(address==1){
	
	user.setCompany("中山");
	}else if(address == 2){
	
	user.setCompany("广州");
	}else if(address == 3){
	
	 user.setCompany("东莞");
	}
	user.setDept(dept);
	user.setJob(job);
	user.setTicketid(Ticketed);
	user.setPopdom(Popdom);
	user.setPhone(phone);
	user.setCompanyid(address);
	user.setSuperiorid(superiorid);
	
	if(serv.equals("是")){
	user.setServ("y");
	}else{
	user.setServ("n");
	}
	if(isShowFspefund.equals("是")){
	user.setIsShowFspefund("y");
	}else{
	user.setIsShowFspefund("n");
	}
	
	if(sales.equals("是")){
	user.setSales("y");
	}else{
	user.setSales("n");
	}

	if(!UserAction.getInstance().addUser(user)) {
			out.println("添加失败！<br>");
			out.println("<a href='javascript:window.history.back();'>返回</a>");
			return;
	}else{
		
	out.println("添加成功!<br>");
		
		}
%>
