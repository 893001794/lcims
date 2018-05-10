<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String rid = request.getParameter("rid");
	String engineer = request.getParameter("engineer");
	String workpoint = request.getParameter("workpoint");
	String oldwarning = request.getParameter("oldwarning");
	String warningS=request.getParameter("warningS");
	String warningStr = request.getParameter("warning");
	String warning="";
	if(warningS==null || warningS.equals("")){
		warning=warningStr;
	}else{
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		warning=warningS+date+":"+time+"出数据;";
	}
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setSid(sid);
	p.setRid(rid);
	cp.setEngineer(engineer);
	cp.setWorkpoint(workpoint);
	cp.setWarning(warning);
	p.setObj(cp);
	
	if(ChemProjectAction.getInstance().Labmodify(p,oldwarning)) {
		if(cp.getWarning()!= null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
			ChemProjectAction.getInstance().sendwarning(p.getSid(),user.getName());
		}
		ChemProjectAction.getInstance().sendEmail(p.getSid(),cp.getEngineer());
		out.println("<div alight=center>");
		out.println("添加成功");
		out.println("<a href='mylabproject.jsp'>返回</a>");
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