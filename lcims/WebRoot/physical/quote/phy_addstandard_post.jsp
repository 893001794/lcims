<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String idStr =request.getParameter("id");
	int id =Integer.parseInt(idStr);
	String status=request.getParameter("status");
	String nameCH = request.getParameter("nameCH");
	String nameEN = request.getParameter("nameEN");
	String suspendDate = request.getParameter("suspendDate");
	//String samplecategory = request.getParameter("samplecategory");
	String availability = request.getParameter("availability");
	String keywords = request.getParameter("keywords");
	String lab = request.getParameter("lab");
	String code = request.getParameter("code");
	int standardId=0;

	String standard = request.getParameter("standard");
	String link = request.getParameter("link"); //���Ա�׼
	if(standard !=null&&!"".equals(standard)){
		standardId=Integer.parseInt(standard.substring(0,standard.indexOf(":")));
	}
	
	List list =new ArrayList ();
	list.add(nameCH);
	list.add(nameEN);
	list.add(code);
	list.add(lab);
	list.add(availability);
	list.add(standardId);
	list.add(suspendDate);
	list.add(keywords);
	list.add(link);
	//������ӵķ���
	int count =0;
	if(id>0){
	//���ı�׼
	count=DaoFactory.getInstance().getPhyQuoteManageDao().upQuoteManage("ps",list,id);
	}else{
	count=DaoFactory.getInstance().getPhyQuoteManageDao().addQuoteManage("ps",list);
	}
	//int count =0;
	//---------------------2010-12-29--------------------
	if(count>0) {
		if(status !=null){
			out.print("<SCRIPT language=javascript>");
			out.print("function go(){window.history.go(-1);}");
			out.print("setTimeout('go()',0)");
			out.print("</SCRIPT>");
			}else{
			out.println("<div alight=center>");
			out.println("�����ɹ�");
			out.println("<a href='myproject.jsp?status=ps'>����</a>");
			out.println("</div>");
		}
	
		
		return;
	} else {
		out.println("<div alight=center>");
		out.println("����ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
%>