<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.TimerTask.MyTimerTask"%>
<%
	String[] ids = request.getParameterValues("selectFlag");
	String pid = request.getParameter("pid");
	String rid = request.getParameter("rid");
	for(int i=0;i<ids.length;i++) {
		//System.out.println("ids[" + i + "] = " + ids[i]);
		ProjectAction.getInstance().delProjectBySid(ids[i]);
		new MyTimerTask().removeTask(pid);
		
	}
	//System.out.println(request.getHeader("Referer"));
	response.sendRedirect(request.getHeader("Referer") + "?command=search&pid=" + pid + "&rid=" + rid);
%>