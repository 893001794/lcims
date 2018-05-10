<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>
<%@page import="com.lccert.crm.vo.Diglossia"%>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.vo.SalesOrderItem"%>
<%@page import="com.lccert.crm.dao.impl.SalesOrderItemDaoImpl"%>
<%
	request.setCharacterEncoding("GBK");
	String itemnumber = request.getParameter("itemnumber");
	if(itemnumber == null || "".equals(itemnumber)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	
	String standprice = request.getParameter("standprice");
	String saleprice = request.getParameter("saleprice");
	String controlprice = request.getParameter("controlprice");
	String category = request.getParameter("category");   //category
	System.out.println(category+":category");
	
	String normalperiod = request.getParameter("normalperiod");
	String urgentperiod = request.getParameter("urgentperiod");
	String absolutperiod = request.getParameter("absolutperiod");
	SalesOrderItem sale =new SalesOrderItem();
	sale.setItem_number(itemnumber);
	sale.setStandprice(Float.parseFloat(standprice));
	sale.setSaleprice(Float.parseFloat(saleprice));
	sale.setControlprice(Float.parseFloat(controlprice));
	sale.setCategory(category);
	sale.setNormalPeriod(normalperiod);
	sale.setUrgentPeriod(urgentperiod);
	sale.setAbsolutPeriod(absolutperiod);

	if(SalesOrderItemDaoImpl.getInstance().updateByItemNumber(sale)  ==true) {
		out.println("添加成功");
		response.sendRedirect("saleorder_manage.jsp?command=command&itemName="+itemnumber);
	return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>