<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.report.ReportImg"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.chemistry.util.Config"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	List<ReportImg> list = new ArrayList<ReportImg>();
	list = ChemProjectAction.getInstance().getImgs(sid);
	String head = new Config()._PATH;
	String fs = System.getProperties().getProperty("file.separator");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>查看报告图片</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		.body1 {
			background-color: #fffff5;
		}
	</style>

  </head>
  
  <body class="body1">
  	<div align="center">
  		<h1>报告图片</h1>
  		<h3>报告编号：<%=p.getRid() %></h3>
  	</div>
  	
	<table  border="0" cellpadding="0" cellspacing="0" align="center">
	<%
		for(int i=0;i<list.size();i++) {
			ReportImg img = list.get(i);
			String path = head + fs + img.getImgurl();
	 %>
		  <tr>
		    <td align="center" valign="middle" ><img name="" src="<%=path %>" width="330" height="360" alt="" style="" /></td>
		  </tr>
		  <tr>
		    <td width="320" height="25" align="center" ><%=img.getName() %></td>
		  </tr>
	<%
		}
	 %>
	</table>
  </body>
</html>
