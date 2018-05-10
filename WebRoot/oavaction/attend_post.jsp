<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.oa.impl.OaVacationTypeDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");

	String userId = request.getParameter("userId");
	System.out.println(userId+"----------444444444444");
	if(userId ==null || "".equals(userId)){
		out.println("<script type='text/javascript'>");
	 	out.println("alert('该用户不存在，或已离职！！！');");
		out.println("window.history.back();");
		out.println("</script>");
	}
	String starttime = request.getParameter("starttime");
	String endtime = request.getParameter("endtime");
	String attendType = request.getParameter("attendType");
	String remarks = request.getParameter("remarks");
	//System.out.println(starttime+":starttime---"+endtime+":endtime----"+attendType+":attendType"+"---"+remarks+":remarks");
	int id =0;
	if(userId !=null && !"".equals(userId)){
		id =Integer.parseInt(userId);
	}
	List list =new ArrayList();
	list.add(id);
	list.add(starttime);
	list.add(endtime);
	list.add(attendType);
	list.add(remarks);
	if(DaoFactory.getInstance().getOaVacationTypeDao().addAttend(list)>0) {
			out.println("<script type='text/javascript'>");
			out.println("alert('添加成功!');");
			out.println("window.close();");
			out.println("</script>");
			
	}else{
			out.println("<script type='text/javascript'>");
		    out.println("alert('添加失败！');");
			out.println("window.history.back();");
			out.println("</script>");
		}
%>
