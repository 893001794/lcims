<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.vo.Diglossia"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
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
	if(rid == null || "".equals(rid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String sid = request.getParameter("sid").trim();
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	//String sid = request.getParameter("sid").trim();
	
	String pid = request.getParameter("pid").trim();
	String lab = request.getParameter("lab").trim();
	String retest = request.getParameter("retest").trim();
	String warning = request.getParameter("warning").trim().trim();	
	String appform=request.getParameter("appform").trim();
		//��������
	String type =request.getParameter("ptyp").trim();
	String testplan = request.getParameter("testPlan").trim();
	String flowtype = request.getParameter("flowtype").trim();
	String oldwarning = request.getParameter("oldwarning").trim();
	String level =request.getParameter("level");
	String oldfid = fid;
	String oldflowtype = request.getParameter("oldflowtype");
	if(!oldflowtype.equals(flowtype)) {
		fid = FlowAction.getInstance().makeFid(rid,flowtype,retest);
	}
	
	if(fid == null) {
		out.println("�޸�ʧ�ܣ�����ϵ����Ա��");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	//-------------------------------2010-12-8----------------------
	
	Flow flow = new Flow();
	
	
		
	//---------------------------------------
	
	flow.setFid(fid);
	flow.setSid(sid);
	flow.setPid(pid);
	flow.setRid(rid);
	flow.setLab(lab);
	flow.setRetest(retest);
	flow.setFlowtype(flowtype);
	flow.setNotes(appform);
	System.out.println(appform);
	flow.setLevel(level);
	if(type.equals("���ı���")){
	flow.setTestplanC(testplan);
	flow.setTestplanE("");
	}
	else if(type.equals("Ӣ�ı���")){
	flow.setTestplanE(testplan);
	flow.setTestplanC("");
	}
	
	
	if(FlowAction.getInstance().modifyphyFlow(flow,oldwarning,warning,oldfid)) {
		out.println("��ӳɹ�");
		if("y".equals(retest)) {
			ChemProjectAction.getInstance().reTest(rid);
		}
		//�����ĿԤ�������ʼ�֪ͨ�����Ա
		if(warning!= null && !"".equals(warning) && !oldwarning.equals(warning)) {
			ChemProjectAction.getInstance().sendwarning(flow.getSid(),null);
		}
		response.sendRedirect("phydetail.jsp?fid=" + flow.getFid());
		return;
	} else {
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
%>