<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.temp.QuotationInput"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>

<%
	request.setCharacterEncoding("GBK");
	String add = request.getParameter("add");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
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
	
	
	
	String rid = request.getParameter("rid");
	String strbuildtime = request.getParameter("buildtime");
	Date buildtime = null;
	if(strbuildtime != null && !"".equals(strbuildtime)) {
		buildtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(strbuildtime);
	}
	String testcontent = request.getParameter("testcontent");
	String samplename = request.getParameter("samplename");
	
	float ppreacount = price - (insubcost + presubcost1 + presubcost2 + preagcost);
	String rpclient = request.getParameter("rpclient");
	
	String buildname = user.getName();
	String type = request.getParameter("type");
	String lab = request.getParameter("lab");
	String isout = request.getParameter("isout");
	String company = request.getParameter("company");
	
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setRid(rid);
	p.setPid(pid);
	p.setPtype(ptype);
	p.setPrice(price);
	p.setInsubcost(insubcost);
	p.setPresubcost(presubcost1+"");
	p.setSubname(subname1);
	p.setPresubcost2(presubcost2+"");
	p.setSubname2(subname2);
	p.setPreagcost(preagcost);
	p.setAgname(agname);
	p.setClientpay(clientpay);
	p.setBuildname(buildname);
	p.setPpreacount(ppreacount);
	p.setBuildtime(buildtime);
	p.setTestcontent(testcontent);
	p.setType(type);
	p.setIsout(isout);
	p.setLab(lab);
	
	cp.setSamplename(samplename);
	cp.setRpclient(rpclient);
	p.setObj(cp);
	
	if(ProjectAction.getInstance().addTempProject(p)) {
		out.println("<div alight=center>");
		
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
%>