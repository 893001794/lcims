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
	String category =request.getParameter("category");
	int categoryId =Integer.parseInt(category);
	String status=request.getParameter("status");
	String nameCH = request.getParameter("nameCH");
	String nameEN = request.getParameter("nameEN");
	String description = request.getParameter("description");
	//String samplecategory = request.getParameter("samplecategory");
	String salesinformation = request.getParameter("salesinformation");
	String testStandard = request.getParameter("testStandard"); //���Ա�׼
	String standard="";
		String [] str =testStandard.split(";");
		for(int i=0;i<str.length;i++){
		System.out.println(str[i].trim());
		if(str[i].trim()!=null&&!"".equals(str[i].trim())){
			standard+=str[i].trim().substring(0,str[i].trim().indexOf(":"))+",";
		}
		}
	List list =new ArrayList ();
	list.add(nameCH);
	list.add(nameEN);
	list.add(description);
	list.add(salesinformation);
	list.add(categoryId);
	list.add(standard);
	//������ӵķ���
	int count =0;
	if(id>0){
	//���ı�׼
	count=DaoFactory.getInstance().getPhyQuoteManageDao().upQuoteManage("pp",list,id);
	}else{
	count=DaoFactory.getInstance().getPhyQuoteManageDao().addQuoteManage("pp",list);
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
			out.println("<a href='myproject.jsp?status=pp'>����</a>");
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