<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@page import="com.lccert.crm.vo.ProjectChem"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid");
	String pid = request.getParameter("pid");
	String startype = request.getParameter("startype");
	String gbk=request.getCharacterEncoding();
	String projectleader = request.getParameter("projectleader");
	String projectissuer = request.getParameter("projectissuer");
	String start =request.getParameter("start");
	String item =request.getParameter("traytype");
	String itestcount = request.getParameter("itestcount");
		String sid =request.getParameter("sid");

	//获取项目预警信息
	String warning=request.getParameter("warning");
	String oldwarning=request.getParameter("oldwarning");
	//获取旧的预警信息
	ProjectChem pc = new ProjectChem();
	pc.setPid(pid);
	pc.setProjectleader(projectleader);
	pc.setProjectissuer(projectissuer);
	pc.setWarning(warning);
	String aa="";
	if(itestcount!=null){
	pc.setItestcount(new Integer(itestcount));
	
	pc.setRid(rid);
		
		if(item.equals("成品")){
			aa="<a href='product_manager.jsp'>返回</a>";
		}else if(item.equals("食品")){
			aa="<a href='food_manager.jsp'>返回</a>";
		}
		
	if(item.equals("散单")){
		out.println("该样品类型为散单，添加不成功");
			out.println("<a href='project_chemistry_manage.jsp'>返回</a>");
			return;
	}
		
	if(start .equals("add")){
		String projectcontent = request.getParameter("projectcontent");
		String estimate = request.getParameter("estimate");
		
		String createtime = request.getParameter("dcreatetime");
		String completetime = request.getParameter("dcompletetime");
		String rpclient = request.getParameter("rpclient");
		String samplename = request.getParameter("vsamplename");
		
	
		pc.setProjectcontent(projectcontent);
		pc.setEstimate(new Integer(estimate));
	
		Date createtime1=new SimpleDateFormat("yyy-MM-dd HH:mm").parse(createtime);
		pc.setCreatetime(createtime1);
		Date completetime1=new SimpleDateFormat("yyy-MM-dd HH:mm").parse(completetime);
		pc.setCompletetime(completetime1);
		
		pc.setItem(item);
		pc.setSid(sid);
		pc.setRpclient(rpclient);
		pc.setSamplename(samplename);
		
	if(ProjectChemImpl.getInstance().addProjectChem(pc)){
	
			out.println("添加成功");
			out.println(aa);
			return;
		}
	}
	
	else if(start.equals("update")){
	if(ProjectChemImpl.getInstance().upProjectChem(pc)){
	//如果项目预警，则发邮件通知相关人员
		if(warning != null && !"".equals(warning) && !oldwarning.equals(warning)) {
			ChemProjectAction.getInstance().sendProjectwarning(sid,warning);
		}
			out.println("修改成功");
			out.println(aa);
			return;
		}
	
	}
	}
	else if(start.equals("del")){
		if(ProjectChemImpl.getInstance().delProjectChem(rid)){
		    out.println("删除成功");
	
			if(startype.equals("product")){
			aa="<a href='product_manager.jsp'>返回</a>";
			out.println(aa);
			}else{
			aa="<a href='food_manager.jsp'>返回</a>";
			out.println(aa);
			}
			
			return;
		}
		
	}

		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;

%>