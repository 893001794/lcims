<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.vo.Fincome"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("GBK");
	Fincome fincome = new Fincome();
	String id=request.getParameter("id");
	System.out.println(id);
	fincome.setId(Integer.parseInt(id));
	String dpaytimeStr=request.getParameter("dpaytime");
	fincome.setDpaytime(dpaytimeStr);
	String client=request.getParameter("client");
	fincome.setClient(client);
	String vpyear=request.getParameter("vpyear");
	fincome.setVpyear(vpyear);
	String vpmonth=request.getParameter("vpmonth");
	fincome.setVpmonth(vpmonth);
	String vpid=request.getParameter("vpid");
	fincome.setVpid(vpid);
	String dept=request.getParameter("dept");
	fincome.setDept(dept);
	String sales=request.getParameter("sales");
	fincome.setSales(sales);
	String chemStr=request.getParameter("chem");
	fincome.setChem(Double.parseDouble(chemStr));
	String safeStr=request.getParameter("safe");
	fincome.setSafe(Double.parseDouble(safeStr));
	String opStr=request.getParameter("op");
	fincome.setOp(Double.parseDouble(opStr));
	String emcStr=request.getParameter("emc");
	fincome.setEmc(Double.parseDouble(emcStr));
	String drStr=request.getParameter("dr");
	fincome.setDr(Double.parseDouble(drStr));
	String vipStr=request.getParameter("vip");
	fincome.setVip(Double.parseDouble(vipStr));
	String eqStr=request.getParameter("eq");
	fincome.setEq(Double.parseDouble(eqStr));
	String financeStr=request.getParameter("finance");
	fincome.setFinance(Double.parseDouble(financeStr));
	String gzStr=request.getParameter("gz");
	fincome.setGz(Double.parseDouble(gzStr));
	String totalStr=request.getParameter("total");
	fincome.setTotal(Double.parseDouble(totalStr));
	String account=request.getParameter("account");
	fincome.setAccount(account);
	String einvtype=request.getParameter("einvtype");
	fincome.setEinvtype(einvtype);
	String province=request.getParameter("province");
	fincome.setProvince(province);
	String city=request.getParameter("city");
	fincome.setCity(city);
	String einvno=request.getParameter("einvno");
	fincome.setEinvno(einvno);
	String remarks=request.getParameter("remarks");
	fincome.setRemarks(remarks);
	int key =DaoFactory.getInstance().getFincome().updateFincome(fincome);;
	if(key >-1) {
		out.println("收入申请表操作成功");
		out.println("<br><a href='fincome_manage.jsp'>返回</a>");
		//out.println("<a href='editfincome.jsp?id=" + key + "'>返回</a>");
		return;
	} else {
		out.println("收入申请表操作失败！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>