<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
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
	String oldrid = request.getParameter("oldrid");
	String rid = request.getParameter("rid");
	if(!oldrid.equals(rid)) {
		Project pro = PhyProjectAction.getInstance().getProjectByRid(rid);
		if(rid == null || "".equals(rid) || pro != null) {
			out.println("<div alight=center>");
			out.println("�������Ѵ��ڣ��뷵���������룡");
			out.println("<br><a href='javascript:window.history.back();'>����</a>");
			out.println("</div>");
		}
	}
	
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	String strrptime = request.getParameter("rptime");
	if(strrptime == null || "".equals(strrptime)) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}
	Date rptime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strrptime);
	String rpclient = request.getParameter("rpclient");
	
	String contact = request.getParameter("contact");
	String samplename = request.getParameter("samplename");
	String samplecount = request.getParameter("samplecount");
	//String samplecategory = request.getParameter("samplecategory");
	String samplemodel = request.getParameter("samplemodel");
	//System.out.println(samplemodel+"------------------");
	String testStandard = request.getParameter("testStandard");
	//��ȡ���ѹ
	String ratedvoltage=request.getParameter("ratedvoltage");
	//��ȡ�����
	String ratedcurrent=request.getParameter("ratedcurrent");
	//��ȡ�����
	String ratedpower=request.getParameter("ratedpower");
	//��ȡ����
	String other=request.getParameter("other");
	//��ȡ��Դ����
	String lightsourcetype=request.getParameter("lightsourcetype");
	String notes = request.getParameter("notes");
	String level = request.getParameter("level");
	String servname = request.getParameter("servname");
	String quotype = request.getParameter("quotype");
	String ptype = request.getParameter("ptype");
	String rptype = request.getParameter("rptype");
	String company = request.getParameter("company");
	String engineer = request.getParameter("engineer");
	
	
		
	Project p = new Project();
	PhyProject pp = new PhyProject();
	p.setRid(rid);
	p.setSid(sid);
	p.setPid(pid);
	p.setPtype(ptype);
	//p.setTestcontent(testcontent);
	p.setLevel(level);
	p.setNotes(notes);
	
	pp.setRptype(rptype);
	pp.setContact(contact);
	pp.setRptime(rptime);
	pp.setRpclient(rpclient);
	pp.setSamplename(samplename);
	pp.setSamplecount(samplecount);
	pp.setServname(servname);
	pp.setEngineer(engineer);
	pp.setSamplemodel(samplemodel);
	pp.setTestStandard(testStandard);
	pp.setRatedvoltage(ratedvoltage);
	pp.setRatedcurrent(ratedcurrent);
	pp.setRatedpower(ratedpower);
	pp.setOther(other);
	pp.setLightsourcetype(lightsourcetype);
	p.setObj(pp);
	
	if(PhyProjectAction.getInstance().modifyPhyProject(p)) {
		out.println("<div alight=center>");
		out.println("��ӳɹ�");
		out.println("<a href='phyproject_manage.jsp'>����</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
%>