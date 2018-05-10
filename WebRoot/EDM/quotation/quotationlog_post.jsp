<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid").trim();
	String pageNo = request.getParameter("pageNo");
	if(pid == null || "".equals(pid)) {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	String strtotalprice = request.getParameter("totalprice").trim();
	float totalprice = 0;
	if(!("".equals(strtotalprice) || strtotalprice == null)) {
		totalprice = Float.parseFloat(strtotalprice);
	}
	
	String strpreadvance = request.getParameter("preadvance").trim();
	float preadvance = 0;
	if(!("".equals(strpreadvance) || strpreadvance == null)) {
		preadvance = Float.parseFloat(strpreadvance);
	}
	
	String strpaytime = request.getParameter("paytime").trim();
	Date paytime = null;
	if(!(strpaytime == null || "".equals(strpaytime))) {
		paytime = new SimpleDateFormat("yyy-MM-dd").parse(strpaytime);
	}
	
	
	String creditcard = request.getParameter("creditcard").trim();
	
	String paynotes = request.getParameter("paynotes").trim();
	//获取备注的内容
	String collRemarks=request.getParameter("collRemarks").trim();
	
	String strsepay = request.getParameter("sepay").trim();
	float sepay = 0;
	if(!("".equals(strsepay) || strsepay == null)) {
		sepay = Float.parseFloat(strsepay);
	}
	
	String sepayacount = request.getParameter("sepayacount").trim();
	
	String strsepaytime = request.getParameter("sepaytime").trim();
	Date sepaytime = null;
	if(!(strsepaytime == null || "".equals(strsepaytime))) {
		sepaytime = new SimpleDateFormat("yyy-MM-dd").parse(strsepaytime);
	}
	
	String sepaynotes = request.getParameter("sepaynotes").trim();
	
	String strprebalance = request.getParameter("prebalance").trim();
	float prebalance = 0;
	if(!("".equals(strprebalance) || strprebalance == null)) {
		prebalance = Float.parseFloat(strprebalance);
	}
	
	String strbalance = request.getParameter("balance").trim();
	float balance = 0;
	if(!("".equals(strbalance) || strbalance == null)) {
		balance = Float.parseFloat(strbalance);
	}
	
	String balanceacount = request.getParameter("balanceacount").trim();
	
	String strbalancetime = request.getParameter("balancetime").trim();
	Date balancetime = null;
	if(!(strbalancetime == null || "".equals(strbalancetime))) {
		balancetime = new SimpleDateFormat("yyy-MM-dd").parse(strbalancetime);
	}
	
	String balancenotes = request.getParameter("balancenotes").trim();
	
	String strrefund = request.getParameter("refund").trim();
	float refund = 0;
	if(!("".equals(strrefund) || strrefund == null)) {
		refund = Float.parseFloat(strrefund);
	}
	
	String refunddesc = request.getParameter("refunddesc").trim();
	
	String strprespefund = request.getParameter("prespefund");
	float prespefund = 0;
	if(!("".equals(strprespefund) || strprespefund == null)) {
		prespefund = Float.parseFloat(strprespefund);
	}
	
	String strspefund = request.getParameter("spefund");
	float spefund = 0;
	if(!("".equals(strspefund) || strspefund == null)) {
		spefund = Float.parseFloat(strspefund);
	}
	
	String spefundtype = request.getParameter("spefundtype");
	
	String strspefundtime = request.getParameter("spefundtime");
	Date spefundtime = null;
	if(!(strspefundtime == null || "".equals(strspefundtime))) {
		spefundtime = new SimpleDateFormat("yyy-MM-dd").parse(strspefundtime);
	}
	
	String spefunddesc = request.getParameter("spefunddesc");
	
	String strinvprice = request.getParameter("invprice").trim();
	float invprice = 0;
	if(!("".equals(strinvprice) || strinvprice == null)) {
		invprice = Float.parseFloat(strinvprice);
	}
	
	String invcode = request.getParameter("invcode").trim();
	
	String strinvtime = request.getParameter("invtime").trim();
	Date invtime = null;
	if(!(strinvtime == null || "".equals(strinvtime))) {
		invtime = new SimpleDateFormat("yyy-MM-dd").parse(strinvtime);
	}
	
	String stracount = request.getParameter("acount").trim();
	float acount = 0;
	if(!("".equals(stracount) || stracount == null)) {
		acount = Float.parseFloat(stracount);
	}
	
	String strtax = request.getParameter("tax").trim();

	float tax = 0;
	if(!("".equals(strtax) || strtax == null)) {
		tax = Float.parseFloat(strtax);
	}
	float sum=0f;
			if(preadvance!=0 && "发票".equals(paynotes)){
				sum +=preadvance*0.08;
			}
			if(sepay!=0 && "发票".equals(sepaynotes)){
				sum +=sepay*0.08;
			}
			if(prebalance!=0 && "发票".equals(balancenotes)){
				sum +=prebalance*0.08;
			}
			tax=sum;
	String tag = request.getParameter("tag");
	
	String strothercost = request.getParameter("othercost").trim();
	float othercost = 0;
	if(!("".equals(strothercost) || strothercost == null)) {
		othercost = Float.parseFloat(strothercost);
	}
	
	String paystatus = "n";
	if(totalprice != 0 && (preadvance + sepay + balance) >= totalprice) {
		paystatus = "y";
	}
	
	
	Quotation qt = new Quotation();
	qt.setPid(pid);
	qt.setPreadvance(preadvance);
	qt.setPaytime(paytime);
	qt.setCreditcard(creditcard);
	qt.setPaynotes(paynotes);
	qt.setSepay(sepay);
	qt.setSepayacount(sepayacount);
	qt.setSepaytime(sepaytime);
	qt.setSepaynotes(sepaynotes);
	qt.setPrebalance(prebalance);
	qt.setBalance(balance);
	qt.setBalanceacount(balanceacount);
	qt.setBalancetime(balancetime);
	qt.setBalancenotes(balancenotes);
	qt.setRefund(refund);
	qt.setRefunddesc(refunddesc);
	qt.setPrespefund(prespefund);
	qt.setSpefund(spefund);
	qt.setSpefundtype(spefundtype);
	qt.setSpefundtime(spefundtime);
	qt.setSpefunddesc(spefunddesc);
	qt.setInvprice(invprice);
	qt.setInvcode(invcode);
	qt.setInvtime(invtime);
	qt.setAcount(acount);
	qt.setTax(tax);
	qt.setTag(tag);
	qt.setOthercost(othercost);
	qt.setPaystatus(paystatus);
	qt.setCollRemarks(collRemarks);
	
	if(FinanceQuotationAction.getInstance().updateQuotation(qt)) {
		out.println("添加成功");
		response.sendRedirect("quotationlog.jsp?type=1&pid=" + pid + "&pageNo=" + pageNo);
		return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>