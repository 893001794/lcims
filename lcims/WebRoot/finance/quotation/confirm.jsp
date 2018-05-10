<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page errorPage="../error.jsp" %>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		//out.println("<script language='javascript'>alert('确认不成功，请返回重新确认！');window.close();</script>");

		
		out.println("<div alight=center>");
		out.println("确认不成功，请返回重新确认！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
	String confirmuser = user.getName();
	if(QuotationAction.getInstance().confirmQuotation(pid,confirmuser)) {
	    //out.println("<script language='JavaScript'>");
	   // out.println("javascript:parent.opener.location.reload(); ");
		//out.println("alert('已确认收到');");
		//out.println("window.close();");
		//out.println("</script>");
		//out.println("<script language='javascript'>alert('已确认收到！');window.close();opener.location.reload();</script>");
		
		out.println("<div alight=center>");
		out.println("已确认收到");
		out.println("<a href='quotation_confirm.jsp'>返回</a>");
		out.println("</div>");
	} else {
	
		//out.println("<script language='javascript'>alert('确认不成功，请返回重新确认！');window.close();</script>");
		out.println("<div alight=center>");
		out.println("确认不成功，请返回重新确认！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
 %>

