<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.Date"%>
<%@ include file="comman.jsp"%>   

<%
	String command = request.getParameter("command");
	if(command != null && "logout".equals(command)) {
		session.removeAttribute("user");
		out.println("<script language='javascript'>parent.location.href='login.jsp';</script>");
		return;
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>Untitled Document</title>
		<link rel="stylesheet" href="style/drp.css">

		<script type="text/javascript">
			function logout() {
				if(confirm("确认注销?")) 
				{ 
					window.location.href='toolbar.jsp?command=logout';
				} 
			}
		</script>
		
		<script language="JavaScript">
function changeWin(){
    parent.workaround.cols="172,*";
	parent.toolBar.showMainMenu.style.display='none';	
}

</script>
		<style type="text/css">
<!--
body,td,th {
	color: #FFFFFF;
}
a:link {
	text-decoration: none;
	color: #FFFFFF;
}
a:visited {
	text-decoration: none;
	color: #FFFFFF;
}
a:hover {
	text-decoration: none;
	color: #FFFFFF;
}
a:active {
	text-decoration: none;
	color: #FFFFFF;
}
-->
</style>
	</head>

	<body class="boyd1" topmargin="0" leftmargin="0">
		<table width="100%" height="100%" border="0" cellpadding="0"
			cellspacing="0" bgcolor="#088A4B">
			<tr>
				<td width="5%" nowrap>
					&nbsp;
				</td>
				<td width="30%" nowrap>
					<font color="#FFFFFF">
						<div id="showMainMenu" style="display='none'">
							<a href="#" onClick="changeWin()">显示主菜单</a>
						</div> </font>
				</td>
				
				<td width="25%">
					系统时间：<%=new Date().toLocaleString() %> 
				</td>
				<td width="25%">
					 当前用户：<%=user.getName() %>
				</td>
				<td width="8%">
					<font color="#FFFFFF">关于 &nbsp;帮助</font>
				</td>
				<td width="2%">
					&nbsp;
				</td>
				<td width="6%">
					<a href="javascript:logout();" ><font color="#FFFFFF">注销</font></a>
				</td>
			</tr>
		</table>
	</body>
</html>
