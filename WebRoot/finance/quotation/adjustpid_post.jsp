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

<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.kis.Adjustpid"%>
<%@page import="com.lccert.crm.kis.AdjustpidAction"%>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("modifypid");
	String a =request.getParameter("invmethod");
	String status=request.getParameter("status");
	if(pid == null || "".equals(pid)) {
		out.println("传值不成功！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	String adjustinvcount = request.getParameter("adjustinvcount");
	String quotype = request.getParameter("type");
	String pidtype="";
	String rid="";
	if(quotype.equals("1")){
	pidtype="sup";
	}
	
	if(quotype.equals("2")){
	 rid =request.getParameter("rid");
	pidtype="add";
	}
	
	if(quotype.equals("3")){
	pidtype="flu";
	}
	
	
	
	float invcount = 0;
	if(!("".equals(adjustinvcount) || adjustinvcount == null)) {
		invcount = Float.parseFloat(adjustinvcount);
	}
	
	
	Adjustpid adjust = new Adjustpid();
	adjust.setPid(pid);
	adjust.setRid(rid);
	adjust.setFadjustinvcount(invcount);
	adjust.setEquotype(pidtype);
	boolean  isok =false;
	if(status.equals("add")){
	 isok= AdjustpidAction.getInstance().addAdjust(adjust);
	}else if(status.equals("aud")){
	isok=AdjustpidAction.getInstance().audAdjust(adjust);
	}
	
	if(isok ==true) {
		out.println("审核成功");
		//out.println("<a href='adjustpid.jsp?status=check&pid=" + pid + "&type="+quotype+"'>返回</a>");
		if(status.equals("add")){
		response.sendRedirect("adjustpid.jsp?status=check&command=search&pid="+pid+"&type="+quotype);
		}
		return;
	} else {
		out.println("修改报价单类型失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>