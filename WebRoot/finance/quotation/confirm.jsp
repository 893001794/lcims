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
		//out.println("<script language='javascript'>alert('ȷ�ϲ��ɹ����뷵������ȷ�ϣ�');window.close();</script>");

		
		out.println("<div alight=center>");
		out.println("ȷ�ϲ��ɹ����뷵������ȷ�ϣ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
	String confirmuser = user.getName();
	if(QuotationAction.getInstance().confirmQuotation(pid,confirmuser)) {
	    //out.println("<script language='JavaScript'>");
	   // out.println("javascript:parent.opener.location.reload(); ");
		//out.println("alert('��ȷ���յ�');");
		//out.println("window.close();");
		//out.println("</script>");
		//out.println("<script language='javascript'>alert('��ȷ���յ���');window.close();opener.location.reload();</script>");
		
		out.println("<div alight=center>");
		out.println("��ȷ���յ�");
		out.println("<a href='quotation_confirm.jsp'>����</a>");
		out.println("</div>");
	} else {
	
		//out.println("<script language='javascript'>alert('ȷ�ϲ��ɹ����뷵������ȷ�ϣ�');window.close();</script>");
		out.println("<div alight=center>");
		out.println("ȷ�ϲ��ɹ����뷵������ȷ�ϣ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
 %>

