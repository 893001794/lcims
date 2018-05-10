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

<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="com.lccert.crm.vo.TestChildParent"%>
<%@page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("GBK");
	String type = request.getParameter("testype");
	String chemtestName = request.getParameter("chemtestName").trim();
	String chemtestype = request.getParameter("chemtestype");
	String chemteststatus = request.getParameter("chemteststatus");
	if(request.getParameter("type") !=null && !"".equals(request.getParameter("type"))){
	type=new String (type.getBytes("ISO-8859-1"),"GBK");
	}
	boolean falg=false;
	int intType=0;
	if(type.equals("顶级分类")){
		falg =ChemTestDaoImpl.getInstance().addTopLevel(chemtestName,chemteststatus);
	}
	if(type.equals("一级分类")){
	//获取一级的Id
	String yleId =request.getParameter("parentid");
	intType=1;
	TestParents tp=new TestParents();
	
	tp.setName(chemtestName);
	tp.setType(chemtestype);
	tp.setStatus(chemteststatus);
	tp.setYle(yleId);
	
	if(request.getParameter("type") !=null && !"".equals(request.getParameter("type"))){
	int id =Integer.parseInt(request.getParameter("id"));
	tp.setId(id);
	falg =ChemTestDaoImpl.getInstance().upParent(tp);
	}else{
	falg =ChemTestDaoImpl.getInstance().addParent(tp);
	}

	}
	
	if(type.equals("二级分类")){
	intType=2;
	String chemtestParent = request.getParameter("chemtestParent");
	TestChildParent tcp =new TestChildParent();
	tcp.setChildName(chemtestName);
	tcp.setType(chemtestype);
	tcp.setStatus(chemteststatus);
	tcp.setParentId(Integer.parseInt(chemtestParent));
	if(request.getParameter("type") !=null && !"".equals(request.getParameter("type"))){
	int id =Integer.parseInt(request.getParameter("id"));
	tcp.setId(id);
	falg=ChemTestDaoImpl.getInstance().upChild(tcp);
	}else{
	falg=ChemTestDaoImpl.getInstance().addChild(tcp);
	}
	
	}
	
	if(type.equals("三级分类")){
	intType=3;
	String chemtestchild = request.getParameter("chemtestchild");
	//获取实验室测试方法描述的文本域
	String describe1C = request.getParameter("describe1C").trim();
	String describe2C = request.getParameter("describe2C").trim();

	String describe3C = request.getParameter("describe3C").trim();
	String describe1E = request.getParameter("describe1E").trim();
	String describe2E = request.getParameter("describe2E").trim();

	String describe3E =request.getParameter("describe3E");
	
	//是否带CNSA章
	String isCNAS=request.getParameter("isCNAS");
	TestPlan tp=new TestPlan();
	tp.setChildName(chemtestName);
	tp.setStatus(chemteststatus);
	tp.setChildId(Integer.parseInt(chemtestchild));
	tp.setDescribe1C(describe1C);
	tp.setDescribe2C(describe2C);
	tp.setDescribe3C(describe3C);
	tp.setDescribe1E(describe1E);
	tp.setDescribe2E(describe2E);
	tp.setDescribe3E(describe3E);
	tp.setCnastatus(isCNAS);

	if(request.getParameter("type") !=null && !"".equals(request.getParameter("type"))){
	int id =Integer.parseInt(request.getParameter("id"));
	tp.setId(id);
	falg=ChemTestDaoImpl.getInstance().upPlan(tp);
	}else{
	falg=ChemTestDaoImpl.getInstance().addPlan(tp);
	}
	
	
	}
	
	if(falg == true) {
		out.println("操作成功");
		if(chemtestype ==null){
		chemtestype="";
		}
		String url ="searchchemtest.jsp?flowtype="+intType+"&code=code&city="+URLEncoder.encode(chemtestype);
		response.sendRedirect(url);
	return;
	} else {
		out.println("操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
%>