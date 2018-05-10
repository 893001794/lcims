<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientArea"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@ page errorPage="../../error.jsp"%>
<%@ include file="../../comman.jsp"%>
<%
	request.setCharacterEncoding("GBK");
	
	int quotationC=0;
	int receipt=0;
	String recpitNo ="";
	
	String bank="";
	String client =request.getParameter("client");
	String content =request.getParameter("receiptContent");
	String invprice =request.getParameter("invprice");
	
	String creditcard = request.getParameter("creditcard").trim();
	String pidStr = request.getParameter("pidStr");
	String pidStr1 ="";
	if(pidStr.split(",").length<=0){
	out.println("请添加报价单！");
	out.println("<br><a href='javascript:window.history.back();'>返回</a>");
	return;
	}
	String p1=pidStr.split(",")[0].toString();
	if(p1.indexOf("/")==-1){
	return ;
	}
	Quotation q=new Quotation();
	//System.out.println("报价单："+p1.substring(0,p1.indexOf("/")));
	recpitNo=FinanceQuotationAction.getInstance().receiptNo(p1.substring(0,p1.indexOf("/")));
//	System.out.println("收据编号："+recpitNo);
	//System.out.print(pidStr.split(",").length);
	List receiptList =new ArrayList();
	for(String value:pidStr.split(",")){
		if(value.indexOf("/")>-1){
			List quotationList =new ArrayList();
			String pid =value.substring(0,value.indexOf("/"));
			pidStr1+=pid+",";
		//	System.out.println(pid+client+"---"+content+"---"+preadvance+"---"+user.getName());
		 	String toPrice=value.substring(value.indexOf("/")+1,value.length());
		 	//System.out.println(toPrice+"--每份报价单的金额---");
		 //	System.out.println(creditcard+"-----");
		 		bank=creditcard;
		 		quotationList.add(recpitNo);
				quotationList.add(invprice);
		 	if(creditcard!=""&&!creditcard.equals("借开")){
		 		quotationList.add(toPrice);
		 		//quotationList.add(toPrice);
				quotationList.add(creditcard);
		 	}
			
			quotationList.add(pid);
			quotationC=DaoFactory.getInstance().getReceipt().updateQuotation(quotationList,bank);
			}
	}
	//receiptNo,vpid,vclient,vcontent,fpreadvance,vreceiptpeople,
		receiptList.add(recpitNo);
		receiptList.add(pidStr1);
		receiptList.add(client);
		receiptList.add(content);
		receiptList.add(invprice);
		receiptList.add(user.getName());
		receipt=DaoFactory.getInstance().getReceipt().insertReceipt(receiptList);
	if(receipt>0) {
			out.println("添加成功!<br>");
			out.println("<a href='receipt.jsp?recpitNo="+recpitNo+ "'>打印收据</a>");
					return;
		}else{
			out.println("添加失败！<br>");
			
	}

	
	
%>

