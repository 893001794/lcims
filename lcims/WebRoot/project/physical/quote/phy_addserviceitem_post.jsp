<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	//获取状态
	String status=request.getParameter("status");
	String nameCH = request.getParameter("nameCH");
	String nameEN = request.getParameter("nameEN");
	String price = request.getParameter("price");
	String idStr =request.getParameter("id");
	int id =Integer.parseInt(idStr);
	//String samplecategory = request.getParameter("samplecategory");
	String circle = request.getParameter("circle");
	String market = request.getParameter("market");
	String lab = request.getParameter("lab");
	String restrictitem = request.getParameter("restrictitem");
	String demand = request.getParameter("demand");
	String testStandard = request.getParameter("testStandard"); //测试标准
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
	list.add(lab);
	list.add(market);
	list.add(standard);
	list.add(restrictitem);
	list.add(price);
	list.add(circle);
	list.add(demand);
	//调用添加的方法
	int count =0;
	if(id>0){
	count=DaoFactory.getInstance().getPhyQuoteManageDao().upQuoteManage("psi",list,id);
	}else{
	count =DaoFactory.getInstance().getPhyQuoteManageDao().addQuoteManage("psi",list);
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
			out.println("操作成功！！！");
			out.println("<a href='myproject.jsp?status=psi'>返回</a>");
			out.println("</div>");
			}
		//response.setHeader("Refresh","phy_addserviceitem.jsp");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
%>