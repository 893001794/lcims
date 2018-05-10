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
	String description = request.getParameter("description");
	//String samplecategory = request.getParameter("samplecategory");
	String salesinformation = request.getParameter("salesinformation");
	
	List list =new ArrayList ();
	list.add(nameCH);
	list.add(nameEN);
	list.add(description);
	list.add(salesinformation);
	//调用添加的方法
	int count =0;
	if(id>0){
	//更改标准
	count=DaoFactory.getInstance().getPhyQuoteManageDao().upQuoteManage("pc",list,id);
	}else{
	count=DaoFactory.getInstance().getPhyQuoteManageDao().addQuoteManage("pc",list);
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
			out.println("<a href='myproject.jsp?status=pc'>返回</a>");
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