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
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	String pid = request.getParameter("pid");
	String retest = request.getParameter("retest");
	String addsamples = request.getParameter("retest5");
	String flowtype = request.getParameter("flowtype");
	String lab = request.getParameter("lab");
	String strtestcount = request.getParameter("testcount");
	if(strtestcount == null || "".equals(strtestcount)) {
		out.println("�޸�ʧ�ܣ���������Ե�����");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	int testcount = Integer.parseInt(strtestcount);
	String oldwarning = request.getParameter("oldwarning");
	String warning = request.getParameter("warning").trim();
	String sampledesc = request.getParameter("sampledesc");
	String testparent = request.getParameter("testparent");
	String testchild = request.getParameter("testchild");
	String appform = request.getParameter("appform");
	
	
	//-----------------------------------------------------------------------------
	//��ȡʵ���Ҳ��Է����������ı���
	String describe = request.getParameter("testPlans");
	describe=describe.trim();
	//��������
	String type =request.getParameter("ptyp");
	String testplan = request.getParameter("testPlan").trim();
	String projectName ="";
	String childName ="";
	String languageC="";
	String languageE="";
	String des="";
	String id ="";
	String childshorName="";
	
	//��̬��ȡ�����Ŀ��һ�����ࡢ�������ࡢ��������
	String [] acclist =testplan.split(";");
	String CNAS="y";
	//ѭ��ÿ����ת��Ҫ�����ٸ���Ŀ����
		for(int i=0;i<acclist.length;i++){
		projectName+=acclist[i].substring(acclist[i].indexOf(":")+1,acclist[i].indexOf("|"))+";";
		childName+=acclist[i].substring(acclist[i].lastIndexOf("|")+1,acclist[i].length())+";";
		id=acclist[i].substring(0,acclist[i].indexOf(":"));
		childshorName =FlowAction.getInstance().getchildNameByPlanName(Integer.parseInt(id.trim()));
		
		
		if(ChemTestDaoImpl.getInstance().isCNAS(Integer.parseInt(id.trim())).equals("n")){
			CNAS="n";
		}
		
		if(type.equals("˫�ﱨ��")){
		List list=FlowFinal.getInstance().diglossia(Integer.parseInt(id.trim()),type);
		//ѭ����ȡ��ÿ����ת��������Ŀ������
		   for(int j=0;j<list.size();j++){
			Diglossia tp =(Diglossia)list.get(j);
			languageC+=id+":"+childshorName+"$"+tp.getParentNameC()+" | "+tp.getChildNameC()+" | "+tp.getPlanNameC()+";";
			languageE+=id+":"+childshorName+"$"+tp.getParentNameE()+" | "+tp.getChildNameE()+" | "+tp.getPlanNameE()+";";
		   }
		  }else{
		List list=FlowFinal.getInstance().getTestPlan(Integer.parseInt(id.trim()),type);
		//ѭ����ȡ��ÿ����ת��������Ŀ������
		   for(int j=0;j<list.size();j++){
			TestPlan tp =(TestPlan)list.get(j);
			des+=id+":"+childshorName+"$"+tp.getParentName()+" | "+tp.getChildName()+" | "+tp.getPlanName()+";";
		   }
		 }
		}
	
	
	
	//-----------------------------------------------------------------------------
	
	
	String pduser = user.getName();
	String oldflowtype = request.getParameter("oldflowtype");
	String oldfid = fid;
	if(!oldflowtype.equals(flowtype)) {
		fid = FlowAction.getInstance().makeFid(rid,flowtype,retest);
	}
	
	if(fid == null) {
		out.println("�޸�ʧ�ܣ�����ϵ����Ա��");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
	Flow flow = new Flow();
	flow.setFid(fid);
	flow.setSid(sid);
	flow.setPid(pid);
	flow.setRid(rid);
	flow.setAddsamples(addsamples);
	flow.setFlowtype(flowtype);
	flow.setLab(lab);
	flow.setTestcount(testcount);
	//-----------------------------------------------------------------
	if(type.equals("���ı���")){
	flow.setTestplanC(des);
	flow.setTestplanE("");
	}
	else if(type.equals("Ӣ�ı���")){
	flow.setTestplanE(des);
	flow.setTestplanC("");
	}
	else if(type.equals("˫�ﱨ��")){
	flow.setTestplanE(languageE);
	flow.setTestplanC(languageC);
	
	
	}
	flow.setTestparent(projectName);
	flow.setTestchild(childName);
	flow.setDescribe(describe);
	//-----------------------------------------------------------------
	flow.setPduser(pduser);
	flow.setRetest(retest);
	
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setRid(rid);
	p.setSid(sid);
	cp.setAppform(appform);
	cp.setSampledesc(sampledesc);
	cp.setWarning(warning);
	p.setObj(cp);

	
	if(FlowAction.getInstance().modifyFlow(flow,p,oldfid,oldwarning)) {
		out.println("��ӳɹ�");
		if("y".equals(retest)) {
			ChemProjectAction.getInstance().reTest(rid);
		}
		//�����ĿԤ�������ʼ�֪ͨ�����Ա
		if(cp.getWarning()!= null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
			ChemProjectAction.getInstance().sendwarning(p.getSid(),user.getName());
		}
		response.sendRedirect("detail.jsp?fid=" + flow.getFid());
		return;
	} else {
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
%>