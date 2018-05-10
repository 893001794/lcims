<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("GBK");
	String fid = request.getParameter("fid");
	if(fid == null || "".equals(fid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String rid = request.getParameter("rid");
	String sid = request.getParameter("sid");
	String workpoint = request.getParameter("workpoint");
	String workpoint2 = request.getParameter("workpoint2");
	String oldwarning = request.getParameter("oldwarning");
	String warning = request.getParameter("warning");
	Flow flow = new Flow();
	flow.setFid(fid);
	flow.setSid(sid);
	flow.setVworkpoint(workpoint);
	flow.setVworkpoint2(workpoint2);
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setRid(rid);
	p.setSid(sid);
	cp.setWarning(warning);
	p.setObj(cp);
	if(FlowAction.getInstance().LabFlowmodify(flow,p,oldwarning)) {
		if(cp.getWarning()!= null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
			ChemProjectAction.getInstance().sendwarning(p.getRid(),user.getName());
		}
		out.println("<div alight=center>");
		out.println("添加成功");
		out.println("<a href='labflow.jsp?rid=" + p.getRid() + "'>返回</a>");
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