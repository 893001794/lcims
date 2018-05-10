<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("addquotation.jsp");
		return;
	}
	pid = pid.toUpperCase();
	String quotype = request.getParameter("quotype");
	String company = request.getParameter("company");
	String sales = request.getParameter("sales");
	String client = request.getParameter("client");
	String projectcontent = request.getParameter("projectcontent");
	String strcompletetime = request.getParameter("completetime");
	Date completetime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strcompletetime);
	
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
	
	String advancetype = request.getParameter("advancetype");
	String strinvcount = request.getParameter("invcount");
	float invcount = 0;
	if(!("".equals(strinvcount) || strinvcount == null)) {
		invcount = Float.parseFloat(strinvcount);
	}
	String invtype = request.getParameter("invtype");
	String invmethod = request.getParameter("invmethod");
	String invhead = request.getParameter("invhead");
	String invcontent = request.getParameter("invcontent");
	String strprespefund = request.getParameter("prespefund").trim();
	float prespefund = 0;
	if(!("".equals(strprespefund) || strprespefund == null)) {
		prespefund = Float.parseFloat(strprespefund);
	}
	String tag = request.getParameter("tag");
	String createuser = user.getName();
	
	
	Quotation qt = new Quotation();
	qt.setPid(pid);
	qt.setQuotype(quotype);
	qt.setCompany(company);
	qt.setSales(sales);
	qt.setClient(client);
	qt.setProjectcontent(projectcontent);
	qt.setCompletetime(completetime);
	qt.setTotalprice(totalprice);
	qt.setAdvancetype(advancetype);
	qt.setInvcount(invcount);
	qt.setInvtype(invtype);
	qt.setInvmethod(invmethod);
	qt.setInvcontent(invcontent);
	qt.setInvhead(invhead);
	qt.setPrespefund(prespefund);
	qt.setTag(tag);
	qt.setCreateuser(createuser);
	qt.setStandprice(standprice);
	qt.setStatus("建立");
	
	if(QuotationAction.getInstance().addQuotation(qt)) {
		out.println("添加成功");
		out.println("<a href='../project/project_finance_manage.jsp?command=search&pid=" + qt.getPid() + "'>返回</a>");
		return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>