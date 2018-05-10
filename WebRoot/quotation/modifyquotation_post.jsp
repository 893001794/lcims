<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	pid = pid.toUpperCase();
	
	int id = 0;
	String strid = request.getParameter("id");
	if(strid != null && !"".equals(strid)) {
		id = Integer.parseInt(strid);
	}
	
	String quotype = request.getParameter("quotype");
	String company = request.getParameter("company");
	String sales = request.getParameter("sales");
	String client = request.getParameter("client");
	String projectcontent = request.getParameter("projectcontent");
	String strcompletetime = request.getParameter("completetime");
	Date completetime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strcompletetime);
	String strtotalprice = request.getParameter("totalprice");
	float totalprice = Float.parseFloat(strtotalprice);
	String advancetype = request.getParameter("advancetype");
	String strinvcount = request.getParameter("invcount");
	float invcount = 0;
	if(strinvcount != null && !"".equals(strinvcount)) {
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
	String strstandprice = request.getParameter("standprice").trim();
	float standprice = 0;
	if(!("".equals(strstandprice) || strstandprice == null)) {
		standprice = Float.parseFloat(strstandprice);
	}
	
	
	Quotation qt = new Quotation();
	qt.setId(id);
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
	qt.setTag(tag);
	qt.setPrespefund(prespefund);
	qt.setCreateuser(createuser);
	qt.setStandprice(standprice);
	
	if(QuotationAction.getInstance().updateQuotation(qt)) {
		out.println("修改成功");
		out.println("<a href='myquotation.jsp'>返回</a>");
		return;
	} else {
		out.println("修改失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>