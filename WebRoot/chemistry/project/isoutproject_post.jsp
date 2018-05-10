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
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid");
	String sid = request.getParameter("sid");
	if(rid == null || "".equals(rid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	String strostime = request.getParameter("ostime");
	Date ostime = null;
	if(strostime != null && !"".equals(strostime)) {
		ostime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strostime);
	}
	
	String strortime = request.getParameter("ortime");
	Date ortime = null;
	if(strortime != null && !"".equals(strortime)) {
		ortime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strortime);
	}
	
	String strbqtime = request.getParameter("bqtime");
	Date bqtime = null;
	if(strbqtime != null && !"".equals(strbqtime)) {
		bqtime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strbqtime);
	}
	
	String stroetime = request.getParameter("oetime");
	Date oetime = null;
	if(stroetime != null && !"".equals(stroetime)) {
		oetime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(stroetime);
	}
	
	//TUV检测编号
	String tuvno = request.getParameter("tuvno");
	//TUV项目简称
	String tuvpshort = request.getParameter("tuvpshort");
	//立创实际报价（内部报价）
	String realprice = request.getParameter("lcrealprice");
	//实际报价金额
	String oepriceV = request.getParameter("oeprice");
	float oeprice=0.0f;
	if(oepriceV !=null && !"".equals(oepriceV)){
	oeprice=Float.parseFloat(oepriceV);
	}
	float lcrealprice =0.0f;
	if(realprice !=null && !"".equals(realprice)){
	lcrealprice=Float.parseFloat(realprice);
	}
	
%>
<%	
	Project p = new Project();
	
	p.setOstime(ostime);
	p.setOrtime(ortime);
	p.setBqtime(bqtime);
	p.setOetime(oetime);
	p.setTuvno(tuvno);
	p.setTuvpshort(tuvpshort);
	p.setLcrealprice(lcrealprice);
	p.setOeprice(oeprice);
	p.setSid(sid);
	p.setRid(rid);
	
	if(ProjectChemImpl.getInstance().isOutProject(p)) {
	
		
		out.println("<div alight=center>");
		out.println("添加成功");
		out.println("<a href='isoutproject.jsp?sid=" + p.getSid() + "'>返回</a>");
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