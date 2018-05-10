<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String sid = request.getParameter("sid");
	String quotype = request.getParameter("quotype");
	
	String ptype = request.getParameter("ptype");
	String type = request.getParameter("type");
	String isout = request.getParameter("isout");
	String lab = request.getParameter("lab");
	String rptype = request.getParameter("rptype");
	String company = request.getParameter("company");
	
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
	
	if(preagcost == 0) {
		agname = null;
	}
	
	String strpreinvprice = request.getParameter("preinvprice").trim();
	float preinvprice = 0;
	if(!("".equals(strpreinvprice) || strpreinvprice == null)) {
		preinvprice = Float.parseFloat(strpreinvprice);
	}
	
	float ppreacount = price - (insubcost + presubcost1 + presubcost2 + preagcost);
	
	String invtype = request.getParameter("invtype");
	
	String invhead = request.getParameter("invhead");
	
	String invcontent = request.getParameter("invcontent");
	
	String buildname = user.getName();
	
	String rid = request.getParameter("rid");
	
	String rpclient = request.getParameter("rpclient");
	
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setSid(sid);
	p.setRid(rid);
	p.setPid(pid);
	p.setPtype(ptype);
	p.setType(type);
	p.setIsout(isout);
	p.setLab(lab);
	p.setPrice(price);
	p.setInsubcost(insubcost);
	p.setPresubcost(presubcost1+"");
	p.setSubname(subname1);
	p.setPresubcost2(presubcost2+"");
	p.setSubname2(subname2);
	p.setPreagcost(preagcost);
	p.setAgname(agname);
	p.setPreinvprice(preinvprice);
	p.setInvtype(invtype);
	p.setInvhead(invhead);
	p.setInvcontent(invcontent);	
	p.setBuildname(buildname);
	p.setPpreacount(ppreacount);
	
	cp.setRpclient(rpclient);
	cp.setRptype(rptype);
	
	if(ProjectAction.getInstance().modifyStatement(p)) {
		out.println("<div alight=center>");
		out.println("修改成功");
		out.println("<a href='../finance/project/project_confirm.jsp?command=search&pid=" + p.getPid() + "'>返回</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("添修改失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
%>