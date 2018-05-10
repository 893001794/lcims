<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid").trim();
	if(sid == null || "".equals(sid)) {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	String strsubcost = request.getParameter("subcost").trim();
	float subcost = 0;
	if(!("".equals(strsubcost) || strsubcost == null)) {
		subcost = Float.parseFloat(strsubcost);
	}
	//-------------------2013-2-21- ------------
	String strPresubcost = request.getParameter("presubcost").trim();
	//int presubcost = 0;
	//if(!("".equals(stPresubcost) || stPresubcost == null)) {
	//	presubcost = Integer.parseInt(stPresubcost);
	//}
	String strPresubcost2 = request.getParameter("presubcost2").trim();
	//int presubcost2 = 0;
	//if(!("".equals(stPresubcost2) || stPresubcost2 == null)) {
	//	presubcost2 =Integer.parseInt(stPresubcost2);
	//}
	String strPreagcost = request.getParameter("preagcost").trim();
	float preagcost = 0;
	if(!("".equals(strPreagcost) || strPreagcost == null)) {
		preagcost = Float.parseFloat(strPreagcost);
	}
	
	
	//-----------------------------------------
	
	String strsubcosttime = request.getParameter("subcosttime").trim();
	Date subcosttime = null;
	if(!(strsubcosttime == null || "".equals(strsubcosttime))) {
		subcosttime = new SimpleDateFormat("yyy-MM-dd").parse(strsubcosttime);
	}
	
	
	String subcostnotes = request.getParameter("subcostnotes").trim();
	
	String strsubcost2 = request.getParameter("subcost2").trim();
	float subcost2 = 0;
	if(!("".equals(strsubcost2) || strsubcost2 == null)) {
		subcost2 = Float.parseFloat(strsubcost2);
	}
	
	String strsubcosttime2 = request.getParameter("subcosttime2").trim();
	Date subcosttime2 = null;
	if(!(strsubcosttime2 == null || "".equals(strsubcosttime2))) {
		subcosttime2 = new SimpleDateFormat("yyy-MM-dd").parse(strsubcosttime2);
	}
	
	
	String subcostnotes2 = request.getParameter("subcostnotes2").trim();
	
	String insubtag = request.getParameter("insubtag").trim();
	
	String stragcost = request.getParameter("agcost").trim();
	//机构费用
	String agremarks =request.getParameter("agremarks");
	//类型
	String ptype=request.getParameter("ptype");

	float agcost = 0;
	if(!("".equals(stragcost) || stragcost == null)) {
		agcost = Float.parseFloat(stragcost);
	}
	
	String stragtime = request.getParameter("agtime").trim();
	Date agtime = null;
	if(!(stragtime == null || "".equals(stragtime))) {
		agtime = new SimpleDateFormat("yyy-MM-dd").parse(stragtime);
	}
	
	String agnotes = request.getParameter("agnotes").trim();
	
	String strotherscost = request.getParameter("otherscost").trim();
	float otherscost = 0;
	if(!("".equals(strotherscost) || strotherscost == null)) {
		otherscost = Float.parseFloat(strotherscost);
	}
	
	String otherstag = request.getParameter("otherstag").trim();
	
	String strinvprice = request.getParameter("invprice").trim();
	
	float invprice = 0;
	if(!("".equals(strinvprice) || strinvprice == null)) {
		invprice = Float.parseFloat(strinvprice);
	}
	//---------------2013-2-22
	float assist = 0;
	String strassist = request.getParameter("assist").trim();
	if(!("".equals(strassist) || strassist == null)) {
		assist = Float.parseFloat(strassist);
	}
	
	
	
	String strpacount = request.getParameter("pacount").trim();
	float pacount = 0;
	if(!("".equals(strpacount) || strpacount == null)) {
		pacount = Float.parseFloat(strpacount);
	}
	
	Project p = new Project();
	p.setSid(sid);
	p.setSubcost(subcost);
	p.setSubcosttime(subcosttime);
	p.setSubcostnotes(subcostnotes);
	p.setSubcost2(subcost2);
	p.setSubcosttime2(subcosttime2);
	p.setSubcostnotes2(subcostnotes2);
	p.setInsubtag(insubtag);
	p.setAgcost(agcost);
	p.setAgtime(agtime);
	p.setAgnotes(agnotes);
	p.setOtherscost(otherscost);
	p.setOtherstag(otherstag);
	p.setInvprice(invprice);
	p.setPacount(pacount);
	p.setAssist(assist);
	//presubcost,preagcost
	//p.setPresubcost();
	p.setPresubcost(strPresubcost);
	p.setPresubcost2(strPresubcost2);
	p.setPreagcost(preagcost);
	p.setAgremarks(agremarks);
	if(QuotationAction.getInstance().updateProject(p)) {
		out.println("添加成功");
		response.sendRedirect("projectlog.jsp?sid=" + sid+"&ptype="+URLEncoder.encode(ptype,"UTF-8"));
		return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>