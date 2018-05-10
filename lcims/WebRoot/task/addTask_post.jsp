<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Inventory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Company"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.kis.Bank"%>
<%@page import="com.lccert.crm.kis.AdvanceType"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	//产品名称
	String id = request.getParameter("id");
	String type =request.getParameter("type");
	String name = request.getParameter("name");
	String period = request.getParameter("period");
	String content = request.getParameter("content");
	String priority = request.getParameter("priority");
	String applicant = request.getParameter("applicant");//申请人
	String status = request.getParameter("status");
	List list =new ArrayList();
	int count=0;
		list.add(name);
		list.add(content);
		list.add(period);
		list.add(priority);
		list.add(applicant);
		list.add(status);
		if(type.equals("add")){
			count=DaoFactory.getInstance().getTaskDao().addTask(list);
		}else if (type.equals("modi")){
			list.add(id);
			count=DaoFactory.getInstance().getTaskDao().updTask(status,list);
		}
			if(count>0) {
				out.println("<div alight=center>");
				out.println("操作成功");
				//response.sendRedirect(request.getHeader("task.jsp"));
				out.println("<br><a href='task.jsp;'>返回</a>");
				//out.println("window.close();");
				out.println("</div>");
			return;
			}
		out.println("<div alight=center>");
		out.println("操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
		
%>