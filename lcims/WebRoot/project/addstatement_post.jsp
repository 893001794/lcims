<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>

<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page errorPage="../error.jsp" %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>

<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String free = request.getParameter("free");
	String ptype = request.getParameter("ptype");
	
	String strprice = request.getParameter("price").trim();
	float price = 0;
	if(!("".equals(strprice) || strprice == null)) {
		price = Float.parseFloat(strprice);
	}
	
	String strinsubcost = request.getParameter("insubcost").trim();
	float insubcost = 0;
	if(!("".equals(strinsubcost) || strinsubcost == null)) {
		insubcost = Float.parseFloat(strinsubcost);
	}
	
	String strpresubcost1 = request.getParameter("presubcost1").trim();
	float presubcost1 = 0;
	if(!("".equals(strpresubcost1) || strpresubcost1 == null)) {
		presubcost1 = Float.parseFloat(strpresubcost1);
	}
	
	String subname1 = request.getParameter("subname1");
	
	if(presubcost1 == 0) {
		subname1 = null;
	}
	
	String strpresubcost2 = request.getParameter("presubcost2").trim();
	float presubcost2 = 0;
	if(!("".equals(strpresubcost2) || strpresubcost2 == null)) {
		presubcost2 = Float.parseFloat(strpresubcost2);
	}
	
	String subname2 = request.getParameter("subname2");
	
	if(presubcost2 == 0) {
		subname2 = null;
	}
	
	String strpreagcost = request.getParameter("preagcost").trim();
	float preagcost = 0;
	if(!("".equals(strpreagcost) || strpreagcost == null)) {
		preagcost = Float.parseFloat(strpreagcost);
	}
	
	String agname = request.getParameter("agname");
	
	String clientpay = request.getParameter("clientpay");
	
	if(preagcost == 0) {
		agname = null;
	}
	
	String strpreinvprice = request.getParameter("preinvprice").trim();
	float preinvprice = 0;
	if(!("".equals(strpreinvprice) || strpreinvprice == null)) {
		preinvprice = Float.parseFloat(strpreinvprice);
	}
	
	float ppreacount = 0;
	if("n".equals(clientpay)) {
		ppreacount = price - (insubcost + presubcost1 + presubcost2 + preagcost);
	} else {
		ppreacount = price - (insubcost + presubcost1 + presubcost2);
	}
	
	String invtype = request.getParameter("invtype");
	
	String invhead = request.getParameter("invhead");
	
	String invcontent = request.getParameter("invcontent");
	
	//得到检测的内容
	String testcontent=request.getParameter("testcontent");
	String buildname = user.getName();
	
	String type = request.getParameter("type");
	String lab = request.getParameter("lab");
	String isout = request.getParameter("isout");
	String copy=request.getParameter("copy");
	String company = request.getParameter("company");
	String Currencytype=request.getParameter("Currencytype");
	String Currencytype2=request.getParameter("Currencytype2");
	//分解的份数
	String copiesStr =request.getParameter("copies");
	String presub=presubcost1+Currencytype;
	String presu2=presubcost2+Currencytype2;
	Project p = new Project();
	p.setPid(pid);
	p.setPtype(ptype);
	p.setPrice(price);
	p.setInsubcost(insubcost);
	p.setPresubcost(presub);
	p.setSubname(subname1);
	p.setPresubcost2(presu2);
	p.setSubname2(subname2);
	p.setPreagcost(preagcost);
	p.setAgname(agname);
	p.setClientpay(clientpay);
	p.setPreinvprice(preinvprice);
	p.setInvtype(invtype);
	p.setInvhead(invhead);
	p.setInvcontent(invcontent);	
	p.setBuildname(buildname);
	p.setPpreacount(ppreacount);
	p.setType(type);
	p.setIsout(isout);
	p.setLab(lab);
	//添加检测内容
	p.setTestcontent(testcontent);
	if("y".equals(free)) {
		if(ProjectAction.getInstance().addFreeStatement(p)) {
			out.println("<div alight=center>");
			out.println("添加成功");
			out.println("<a href='project_finance_manage.jsp?command=search&pid=" + pid + "'>返回</a>");
			out.println("</div>");
			return;
		} else {
			out.println("<div alight=center>");
			out.println("添加失败，请返回重新输入！");
			out.println("<br><a href='javascript:window.history.back();'>返回</a>");
			out.println("</div>");
			return;
		}
	} else {
	//添加多份
	boolean flag =false;
	int copies=0;
	if(copiesStr !=null){
		copies=Integer.parseInt(copiesStr);
	}
	if(copies>99){
		out.println("<div alight=center>");
		out.println("批量分解不能大于99份！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
	int copysize=0;
	if(copy !=null){
		copysize=Integer.parseInt(copy);
	}
	//System.out.println(copies);
	if(copysize>0||copies>0){
		if(copysize==0&&copies>0){
			copysize=copies;
		}
		for(int i=0;i<copysize;i++){
		flag=ProjectAction.getInstance().addStatement(p);
		}
	}else{
	flag=ProjectAction.getInstance().addStatement(p);
	}
	if(flag ==true) {
			out.println("<div alight=center>");
			out.println("添加成功");
			out.println("<a href='project_finance_manage.jsp?command=search&pid=" + pid + "'>返回</a>");
			out.println("</div>");
			return;
		} else {
			out.println("<div alight=center>");
			out.println("添加失败，请返回重新输入！");
			out.println("<br><a href='javascript:window.history.back();'>返回</a>");
			out.println("</div>");
			return;
		}
	}
%>