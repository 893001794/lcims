<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.TimerTask.MyTimerTask"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Depot"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	int id =0;
	String statusStr="";
	String depotid="";
	String hrefStr="";
	//获取操作的状态
	String status=request.getParameter("status");
	if(status.equals("del")){
	 depotid =request.getParameter("id");
	id =DaoFactory.getInstance().getDepotDao().delDeport(Integer.parseInt(depotid));
	statusStr="删除";
	hrefStr="article_manage.jsp";
	}else{
	//获取物品名称
	String article = request.getParameter("article");
	//获取品牌
	String c1 = request.getParameter("c1");
	//获取规格型号
	String  specification= request.getParameter("specification");
	//获取数量
	String  number= request.getParameter("number");
	//获取金额
	String  price= request.getParameter("price");
	//获取供应商
	String  client= request.getParameter("client");
	//获取计量单位
	String c2 = request.getParameter("c2");
	//获取使用状态
	String  c3= request.getParameter("c3");
	//获取使用部门
	String  dept= request.getParameter("dept");
	//获取存放位置
	String c4 = request.getParameter("c4");
	//获取使用年限
	String usedateStr = request.getParameter("usedate");
	Date usedate = null;
	if(usedateStr != null && !"".equals(usedateStr)) {
		usedate = new SimpleDateFormat("yyy-MM-dd").parse(usedateStr);
	}
	
	//获取合同编号
	String contract=request.getParameter("contract");
	//获取存放位置
	String c5 = request.getParameter("c5");
	//获取保管人
	String  keeper= request.getParameter("keeper");
	//根据用户名称来查询用户的id
	int userid =UserAction.getInstance().getIdByName(keeper);
	//获取复校准日期
	String nextcalStr = request.getParameter("nextcal");
	Date nextcal = null;
	if(nextcalStr != null && !"".equals(nextcalStr)) {
		nextcal = new SimpleDateFormat("yyy-MM-dd").parse(nextcalStr);
		
	}else{
	nextcal = new SimpleDateFormat("yyy-MM-dd").parse(new Date().toLocaleString());
	}
	//获取校准日期
	String calibrationStr = request.getParameter("calibration");
	Date calibration = null;
	if(calibrationStr != null && !"".equals(calibrationStr)) {
		calibration = new SimpleDateFormat("yyy-MM-dd").parse(calibrationStr);
	}else{
	calibration = new SimpleDateFormat("yyy-MM-dd").parse(new Date().toLocaleString());
	}
	//获取发票代号
	String  invoicecode= request.getParameter("invoicecode");
	//获取发票号码
	String  invoiceno= request.getParameter("invoiceno");
	//获取备注
	String  notes= request.getParameter("notes");
	String company ="";
	String str =user.getCompany();
	if(str.equals("中山")){
	str="Z";
	}
	if(str.equals("东莞")){
	str="D";
	}
	if(str.equals("广州")){
	str="G";
	}
	
	Depot depot=new Depot();

	depot.setAid(Integer.parseInt(article));
	depot.setBrand(c1);
	depot.setSpecification(specification);
	depot.setPrice(Float.parseFloat(price));
	depot.setNumber(Integer.parseInt(number));
	depot.setUnitofaccount(c2);
	depot.setClient(client);
	depot.setDeptid(Integer.parseInt(dept));
	depot.setUsestatus(c3);
	depot.setUserdate(usedate);
	depot.setAperture(c4);
	depot.setKeepid(userid);
	depot.setFundstype(c5);
	depot.setCalibration(calibration); 
	depot.setNextcal(nextcal); 
	depot.setInvoicecode(invoicecode);
	depot.setInvoiceno(invoiceno);
	depot.setRemarks(notes);
	depot.setContract(contract);
	
	if(status.equals("ad")){
	id =DaoFactory.getInstance().getDepotDao().addDepot(depot,str);
	statusStr="添加";
	}if(status.equals("up")){
	 depotid =request.getParameter("id");
	depot.setId(Integer.parseInt(depotid));
	id =DaoFactory.getInstance().getDepotDao().updateDepot(depot);
	statusStr="更改";
	}
	hrefStr="printarticle.jsp?id=" + id ;
	 }
	if(id !=0) {
		out.println("<div alight=center>");
		out.println(statusStr+"成功");
		out.println("<a href='"+hrefStr+"'>返回</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println(statusStr+"失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
	out.println("</div>");
	return;
	}
%>