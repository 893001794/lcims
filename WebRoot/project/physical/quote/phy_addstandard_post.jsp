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
	String link = request.getParameter("link"); //测试标准
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
	//调用添加的方法
	int count =0;
	if(id>0){
	//更改标准
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
			out.println("操作成功");
			out.println("<a href='myproject.jsp?status=ps'>返回</a>");
			out.println("</div>");
		}
	
		
		return;
	} else {
		out.println("<div alight=center>");
		out.println("操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
%>