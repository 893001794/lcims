<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.vo.Fpay"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("GBK");
	Fpay fpay = new Fpay();
	String id=request.getParameter("fpayId");
	String dpaytimeStr=request.getParameter("dpaytime");
	fpay.setDpaytime(dpaytimeStr);
	String supplier=request.getParameter("supplier");
	System.out.println(id+"---8888888888---supplier："+supplier);
	fpay.setSupplier(supplier);
	String dept=request.getParameter("dept");
	fpay.setDept(dept);
	String person=request.getParameter("person");
	fpay.setPerson(person);
	String chem=request.getParameter("chem");
	fpay.setChem(Double.parseDouble(chem));
	String safe=request.getParameter("safe");
	fpay.setSafe(Double.parseDouble(safe));
	String op=request.getParameter("op");
	fpay.setOp(Double.parseDouble(op));
	String emc=request.getParameter("emc");
	fpay.setEmc(Double.parseDouble(emc));
	String dr=request.getParameter("dr");
	fpay.setDr(Double.parseDouble(dr));
	String vip=request.getParameter("vip");
	fpay.setVip(Double.parseDouble(vip));
	String gmo=request.getParameter("gmo");
	fpay.setGmo(Double.parseDouble(gmo));
	String eq=request.getParameter("eq");
	fpay.setEq(Double.parseDouble(eq));
	String finance=request.getParameter("finance");
	fpay.setFinance(Double.parseDouble(finance));
	String administration=request.getParameter("administration");
	fpay.setAdministration(Double.parseDouble(administration));
	String engineering=request.getParameter("engineering");
	fpay.setEngineering(Double.parseDouble(engineering));
	String total=request.getParameter("total");
	fpay.setTotal(Double.parseDouble(total));
	String account=request.getParameter("account");
	fpay.setAccount(account);
	String einvtype=request.getParameter("einvtype");
	fpay.setEinvtype(einvtype);
	String billno=request.getParameter("billno");
	fpay.setBillno(billno);
	String invoiceno=request.getParameter("invoiceno");
	fpay.setInvoiceno(invoiceno);
	String remarks=request.getParameter("remarks");
	fpay.setRemarks(remarks);
	String onelevelsub=request.getParameter("onelevelsub");
	fpay.setOnelevelsub(onelevelsub);
	String twolevelsub=request.getParameter("twolevelsub");
	fpay.setTwolevelsub(twolevelsub);
	String threelevelsub=request.getParameter("threelevelsub");
	fpay.setThreelevelsub(threelevelsub);
	String travel=request.getParameter("travel");
	fpay.setTravel(travel);
	String summay=request.getParameter("summay");
	fpay.setSummay(summay);
	String entertain=request.getParameter("entertain");
	fpay.setEntertain(entertain);
	fpay.setId(Integer.parseInt(id));
	int key =DaoFactory.getInstance().getFpay().updateFpay(fpay);
	
	if(key >-1) {
		out.println("支出申请表操作成功");
		out.println("<br><a href='fpay_manage.jsp'>返回</a>");
		//out.println("<a href='editfincome.jsp?id=" + key + "'>返回</a>");
		return;
	} else {
		out.println("支出申请表操作失败！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>