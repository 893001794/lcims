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
		out.println("�ͻ�ID���ɴ���<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
	if(area == null || "".equals(area)) {
		out.println("��ѡ������<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
	String name = request.getParameter("name");
	String shortname = request.getParameter("shortname");
	ClientForm clientForm=ClientAction.getInstance().findByName(name,shortname);
	if(clientForm !=null) {
		out.println("�û����Ѵ���,��"+clientForm.getSales()+"���۸��������������룡<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
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
		out.println("�������۲����ڣ�<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
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
			out.println("��ӳɹ�!<br>");
			out.println("<a href='clientdetail.jsp?clientid="+ client.getClientid() + "'>�鿴�û���ϸ��Ϣ</a>");
			return;
		}else{
			out.println("���ʧ�ܣ�<br>");
			out.println("<a href='javascript:window.history.back();'>����</a>");
			return;
		}
		
		
	}
%>

