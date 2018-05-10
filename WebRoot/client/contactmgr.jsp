<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page errorPage="../error.jsp" %>
<%@ include file="clientcommon.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String clientid = request.getParameter("clientid");
	if(clientid == null || "".equals(clientid)) {
		out.println("添加失败！<br>");
		out.println("<a href='history.back()'>返回</a>");
		return;
	}
	
%>
	
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>管理联系人</title>
	</head>
    <frameset rows="20,100%,*" name="content" frameborder="1" framespacing="1" cols="*">
      <frame src="title.html" frameborder=0 noresize scrolling="NO" name="mtitle">
      <frame src="showcontact.jsp?clientid=<%=clientid %>" frameborder=0  name="main" marginwidth="0" marginheight="0" scrolling="YES">
      <frame src="" frameborder=0  name="detail">
    </frameset>
	<noframes>
		<body bgcolor="#FFFFFF">

		</body>
	</noframes>
</html>
