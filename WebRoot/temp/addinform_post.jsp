<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.temp.QuotationInput"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("addinform.jsp");
		return;
	}
	pid = pid.toUpperCase();
	String company = request.getParameter("company");
	String sales = request.getParameter("sales");
	String client = request.getParameter("client");
	String projectcontent = request.getParameter("projectcontent");
	
	String strstandprice = request.getParameter("standprice").trim();
	float standprice = 0;
	if(!("".equals(strstandprice) || strstandprice == null)) {
		standprice = Float.parseFloat(strstandprice);
	}
	
	String strtotalprice = request.getParameter("totalprice").trim();
	float totalprice = 0;
	if(!("".equals(strtotalprice) || strtotalprice == null)) {
		totalprice = Float.parseFloat(strtotalprice);
	}
	
	
	String tag = request.getParameter("tag");
	String createuser = user.getName();
	
	
	Quotation qt = new Quotation();
	qt.setPid(pid);
	qt.setCompany(company);
	qt.setSales(sales);
	qt.setClient(client);
	qt.setProjectcontent(projectcontent);
	qt.setTotalprice(totalprice);
	qt.setTag(tag);
	qt.setCreateuser(createuser);
	qt.setStandprice(standprice);
	qt.setStatus("项目完成");
	
	if(QuotationInput.getInstance().addQuotation(qt)) {
		out.println("添加成功");
		out.println("<a href='project_finance_manage.jsp?command=search&pid=" + qt.getPid() + "'>返回</a>");
		return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>