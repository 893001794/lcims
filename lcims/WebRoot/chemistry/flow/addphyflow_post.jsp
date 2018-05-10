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
	//String sid = request.getParameter("sid").trim();
	String sidStr = request.getParameter("sidStr").trim();
	//System.out.println(sidStr);
	String[] sidLeng =sidStr.split(",");
	String sid =sidLeng[0];
	boolean flag=false;
	String pid = request.getParameter("pid").trim();
	String lab = request.getParameter("lab").trim();
	String retest = request.getParameter("retest").trim();
	String warningS=request.getParameter("warningS");
	String warningStr = request.getParameter("warning").trim();
	String warning="";
	if(warningS==null || warningS.equals("")){
		warning=warningStr;
	}else{
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		warning=warningS+date+":"+time+"出数据;";
	}
	String appform=request.getParameter("appform").trim();
		//报告类型
	String type =request.getParameter("rptype").trim();
	String testplan = request.getParameter("testPlan").trim();
	String flowtype = request.getParameter("flowtype").trim();
	String oldwarning = request.getParameter("oldwarning").trim();
	String level =request.getParameter("level");
	String fid = FlowAction.getInstance().makeFid(rid,flowtype,retest);
	if(fid == null) {
		out.println("添加失败，请联系管理员！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
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
	if(type.equals("中文报告")){
	flow.setTestplanC(testplan);
	flow.setTestplanE("");
	}
	else if(type.equals("英文报告")){
	flow.setTestplanE(testplan);
	flow.setTestplanC("");
	}
	
	
	if(FlowAction.getInstance().addPhyFlow(flow,oldwarning,warning)) {
		//获取五位数的随机数
		String rest="";
	  	//String rest=String.valueOf(Math.random()).substring(2,7);
	  	Random random = new Random(); 
	  	for(int i=0;i<5;i++){
            rest+=random.nextInt(9);    
        }
        int rest1=Integer.parseInt(rest)+10000;
		int num =0;
		//先查询该报告是否有防伪码
		int security=FlowAction.getInstance().getSecurityByRid(rid);
		if(security>0){
		num=security;
		}else{
		num =rest1;
		}
		FlowAction.getInstance().addSecurityBySid(num,rid);
		out.println("添加成功");
		if("y".equals(retest)) {
			ChemProjectAction.getInstance().reTest(rid);
		}
		//如果项目预警，则发邮件通知相关人员
		//如果项目预警，则发邮件通知相关人员
		if(warning!= null && !"".equals(warning) && !oldwarning.equals(warning)) {
			ChemProjectAction.getInstance().sendPhywarning(flow.getSid());
		}
		//response.sendRedirect("http://127.0.0.1:8080/report/synthesis?sid="+sid+"&fid="+flow.getFid());
		
		response.sendRedirect("phydetail.jsp?fid=" + flow.getFid());
	return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>