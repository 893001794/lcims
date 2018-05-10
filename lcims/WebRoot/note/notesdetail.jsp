<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
	
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	int id = 0;
	if(strid != null && !"".equals(strid)) {
		id = Integer.parseInt(strid);
	}
	Forum fr = ForumAction.getInstance().getNotesById(id); 
 %>
	
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>系统公告内容</title>
		<link rel="stylesheet" type="text/css"
			href="PiscesTextEditor/style.css">
		<style type="text/css">
<!--
.STYLE3 {
	font-size: 18px;
	font-weight: bold;
}

/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}
-->
</style>
		<script type="text/javascript">
	function addnotes() {
			with (document.getElementById("addnotes")) {
			method="post";
			action="addnotes_post.jsp";
			submit();
			}
		}
		function goBack() {
		window.self.location="system_notes.jsp";
	}
</script>
	</head>
	<body class="body1">
	<br>
		<form name="addnotes" id="addnotes">

			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td align="center">
						<b><h2>
								系统公告内容
							</h2> </b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<table height="51">
					<tr>
						<td width="17%">
							<span class="STYLE3">主题：</span>
						</td>
						<td width="565">
							<input name="head" value="<%=fr.getHead() %>" size="80" type="text" readonly/>
						</td>
					</tr>
					<br>
		
			<div align="center">
				<tr>
					<td valign="middle">
						<span class="STYLE3">内容：</span>
					</td>
					<td>
						<textarea name="content" rows="10" cols="80" readonly><%=fr.getContent() %></textarea>
					</td>
				</tr>
	
			</table>
		</form>
		<p>
			&nbsp;
		</p>
		<hr width="97%" align="center" size=0>
		<div align="center">
			<input name="btnBack" class="button1" type="button" id="btnBack"
				value="返回" onClick="goBack()" />
		</div>

	</body>

</html>