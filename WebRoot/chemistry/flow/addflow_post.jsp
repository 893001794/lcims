<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>
<%@page import="com.lccert.crm.vo.Diglossia"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid").trim();
	if(rid == null || "".equals(rid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String sidStr = request.getParameter("sidStr").trim();
	
	String pid = request.getParameter("pid").trim();
	
	if(rid.indexOf(",")>-1){
		
	}
	
	
	String retest = request.getParameter("retest").trim();
	String addsamples = request.getParameter("retest1").trim();
	
	String level = request.getParameter("level").trim();
	String flowtype = request.getParameter("flowtype").trim();
	String lab = request.getParameter("lab").trim();
	//��ȡʵ���Ҳ��Է����������ı���
	String describe = request.getParameter("testPlans").trim();
	describe=describe.trim();
	String strtestcount = request.getParameter("testcount").trim();
	if(strtestcount == null || "".equals(strtestcount)) {
		out.println("���ʧ�ܣ�������Ե�����");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	int testcount = Integer.parseInt(strtestcount);
	String oldwarning = request.getParameter("oldwarning").trim();
	String warning = request.getParameter("warning").trim().trim();
	String sampledesc = request.getParameter("sampledesc").trim();
	//��������
	String rptype =request.getParameter("rptype").trim();
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
		
		if(rptype.equals("˫�ﱨ��")){
		List list=FlowFinal.getInstance().diglossia(Integer.parseInt(id.trim()),rptype);
		//ѭ����ȡ��ÿ����ת��������Ŀ������
		   for(int j=0;j<list.size();j++){
			Diglossia tp =(Diglossia)list.get(j);
			languageC+=id+":"+childshorName+"$"+tp.getParentNameC()+" | "+tp.getChildNameC()+" | "+tp.getPlanNameC()+";";
			languageE+=id+":"+childshorName+"$"+tp.getParentNameE()+" | "+tp.getChildNameE()+" | "+tp.getPlanNameE()+";";
		   }
		  }else{
		List list=FlowFinal.getInstance().getTestPlan(Integer.parseInt(id.trim()),rptype);
		//ѭ����ȡ��ÿ����ת��������Ŀ������
		   for(int j=0;j<list.size();j++){
			TestPlan tp =(TestPlan)list.get(j);
			des+=id+":"+childshorName+"$"+tp.getParentName()+" | "+tp.getChildName()+" | "+tp.getPlanName()+";";
		   }
		 }
		}
	String appform = request.getParameter("appform");
	String pduser = user.getName();
	
	//-------------------------------2010-12-8----------------------
	
	Flow flow = new Flow();
	
	
	//--------------------2010-12-9   ��ȡ��ת��������
	//List list=FlowAction.getInstance().findDescribe(rid);
	//for(int i=0;i<list.size();i++){
	//	flow =(Flow)list.get(i);
	//	if(type.equals("���ı���")){
			//if(flow.getTestplanC().equals(des)){
			//	des="";
		//	}
	//	}
		//else if(type.equals("Ӣ�ı���")){
		//	if(flow.getTestplanE().equals(des)){
			//	des="";
			//}
	//	}
		//else if(type.equals("˫�ﱨ��")){
		//	if(flow.getTestplanE().equals(languageE)){
			//	languageE="";
			//}
			//if(flow.getTestplanC().equals(languageC)){
			//	languageC="";
			//}
		//}
	//}
	
	//---------------------------------------
	if(rptype.equals("���ı���")){
	flow.setTestplanC(des);
	flow.setTestplanE("");
	}
	else if(rptype.equals("Ӣ�ı���")){
	flow.setTestplanE(des);
	flow.setTestplanC("");
	}
	else if(rptype.equals("˫�ﱨ��")){
	flow.setTestplanE(languageE);
	flow.setTestplanC(languageC);
	}
	flow.setPid(pid);
	flow.setRetest(retest);
	flow.setAddsamples(addsamples);
	flow.setLevel(level);
	flow.setFlowtype(flowtype);
	flow.setLab(lab);
	
	flow.setTestcount(testcount);
	flow.setTestparent(projectName);
	flow.setTestchild(childName);
	flow.setPduser(pduser);
	flow.setDescribe(describe);
	flow.setCnastatus(CNAS);
	
	Project p = new Project();
	ChemProject cp = new ChemProject();
	
	cp.setAppform(appform);
	cp.setSampledesc(sampledesc);
	cp.setWarning(warning);
	p.setObj(cp);
	String[] sidLeng =sidStr.split(",");
	String sid ="";
	boolean flag=false;
	String type =null;
	if(sidLeng[0].indexOf("/")>-1){
		for(int i=0;i<sidLeng.length;i++){
		//System.out.println(sidLeng[i]);
			sid=sidLeng[i].substring(0,sidLeng[i].indexOf("/"));
			rid=sidLeng[i].substring(sidLeng[i].indexOf("/")+1,sidLeng[i].length());
			//System.out.println(rid+"-------------------"+i);
			flow.setSid(sid);
			flow.setRid(rid);
			p.setRid(rid);
			p.setSid(sid);
			String fid = FlowAction.getInstance().makeFid(rid,flowtype,retest);
			//System.out.println(fid);
		if(fid == null) {
			out.println("���ʧ�ܣ�����ϵ����Ա��");
			out.println("<br><a href='javascript:window.history.back();'>����</a>");
			return;
		}
		flow.setFid(fid);
		flag=FlowAction.getInstance().addFlow(flow,p,oldwarning);
		if(flag==true){
				//��ȡ��λ���������
		  	//String rest=String.valueOf(Math.random()).substring(2,7);
			//��ȡ��λ���������
			String rest="";
		  	//String rest=String.valueOf(Math.random()).substring(2,7);
			int num =0;
			//�Ȳ�ѯ�ñ����Ƿ��з�α��
			int security=FlowAction.getInstance().getSecurityByRid(rid);
			if(security>0){
				num=security;
			}else{
				Random random = new Random(); 
			  	for(int j=0;j<5;j++){
		            rest+=random.nextInt(9);    
		        }
		        num=Integer.parseInt(rest)+10000;
			}
			FlowAction.getInstance().addSecurityBySid(num,rid);
		}
		
		if("y".equals(retest)) {
			ChemProjectAction.getInstance().reTest(rid);
		}
		//�����ĿԤ�������ʼ�֪ͨ�����Ա
		if(cp.getWarning()!= null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
			ChemProjectAction.getInstance().sendwarning(sid,user.getName());
		}
		
		}
		type="batch";
	}else{
		   sid=sidLeng[0];
		   flow.setSid(sid);
		   flow.setRid(rid);
		   p.setRid(rid);
		   p.setSid(sid);
		   String fid = FlowAction.getInstance().makeFid(rid,flowtype,retest);
		if(fid == null) {
			out.println("���ʧ�ܣ�����ϵ����Ա��");
			out.println("<br><a href='javascript:window.history.back();'>����</a>");
			return;
		}
		flow.setFid(fid);
		flag=FlowAction.getInstance().addFlow(flow,p,oldwarning);  
		if(flag==true){
				//��ȡ��λ���������
		  	//String rest=String.valueOf(Math.random()).substring(2,7);
			//��ȡ��λ���������
			String rest="";
		  	//String rest=String.valueOf(Math.random()).substring(2,7);
			int num =0;
			//�Ȳ�ѯ�ñ����Ƿ��з�α��
			int security=FlowAction.getInstance().getSecurityByRid(rid);
			if(security>0){
			num=security;
			}else{
				Random random = new Random(); 
			  	for(int i=0;i<5;i++){
		            rest+=random.nextInt(9);    
		        }
		        num=Integer.parseInt(rest)+10000;
			}
			FlowAction.getInstance().addSecurityBySid(num,rid);
		}
		if("y".equals(retest)) {
			ChemProjectAction.getInstance().reTest(rid);
		}
		//�����ĿԤ�������ʼ�֪ͨ�����Ա
		if(cp.getWarning()!= null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
			ChemProjectAction.getInstance().sendwarning(p.getSid(),user.getName());
		}
	}

	if(flag == true) {
	    
		out.println("��ӳɹ�");
	
		
		//response.sendRedirect("http://127.0.0.1:8080/report/synthesis?sid="+sid+"&fid="+flow.getFid());
		
		response.sendRedirect("detail.jsp?fid=" + flow.getFid()+"&sid="+sidStr+"&type="+type);
	return;
	} else {
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
%>