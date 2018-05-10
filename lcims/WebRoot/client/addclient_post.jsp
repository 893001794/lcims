<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
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
	String area = request.getParameter("area");
	String code = ClientArea.getInstance().getAreaCode(area);
	////System.out.println(code);
	String clientid = ClientAction.getInstance().makeClientId(code,area);
	System.out.println(clientid);
	if(clientid == null || "".equals(clientid)) {
		out.println("客户ID生成错误！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	if(area == null || "".equals(area)) {
		out.println("请选择区域！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	String name = request.getParameter("name");
	String shortname = request.getParameter("shortname");
	ClientForm clientForm=ClientAction.getInstance().findByName(name,shortname);
	if(clientForm !=null) {
		out.println("用户名已存在,由"+clientForm.getSales()+"销售跟进，请重新输入！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
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
	String command = request.getParameter("command");
	
	if(command != null && "confirm".equals(command)) {
		ClientForm client = new ClientForm();
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
		client.setArea(area);
		ContactForm cf = new ContactForm();
		cf.setContact(contact);
		cf.setSex(sex);
		cf.setDept(dept);
		cf.setJob(job);
		cf.setEmail(email);
		cf.setFax(fax);
		cf.setTel(tel);
		cf.setMobile(mobile);
		cf.setQq(qq);
		client.setContact(cf);
		boolean flag =ClientAction.getInstance().addClient(client);
		if(flag ==true) {
			out.println("添加成功!<br>");
			out.println("<a href='clientdetail.jsp?clientid="+ client.getClientid() + "'>查看用户详细信息</a>");
			return;
		}else{
			out.println("添加失败！<br>");
			out.println("<a href='javascript:window.history.back();'>返回</a>");
			return;
		}
		
		
	}
%>

