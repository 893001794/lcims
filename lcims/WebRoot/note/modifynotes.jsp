<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
	
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	int id = 0;
	if(strid == null || "".equals(strid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	} else {
		id = Integer.parseInt(strid);
	}
	Forum fr = ForumAction.getInstance().getNotesById(id); 
	if(fr == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
 %>
	
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�޸�ϵͳ����</title>
		<link rel="stylesheet" type="text/css"
			href="PiscesTextEditor/style.css">
		<style type="text/css">
<!--
.STYLE3 {
	font-size: 18px;
	font-weight: bold;
}

/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}
-->
</style>
		<script type="text/javascript">
	function mod() {
			with (document.getElementById("modnotes")) {
				method="post";
				action="modifynotes_post.jsp";
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
		<form name="modnotes" id="modnotes">
			<input name="id" type="hidden" value="<%=fr.getId() %>" />
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td align="center">
						<b><h2>
								�޸�ϵͳ����
							</h2> </b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<table height="51">
					<tr>
						<td width="17%">
							<span class="STYLE3">���⣺</span>
						</td>
						<td width="565">
							<input name="head" value="<%=fr.getHead() %>" size="80" type="text" />
						</td>
					</tr>
					<br>
			
			<div align="center">
				<tr>
					<td valign="middle">
						<span class="STYLE3">���ݣ�</span>
					</td>
					<td>
						<textarea name="content" rows="10" cols="80"><%=fr.getContent() %></textarea>
					</td>
				</tr>
		
			</table>
		</form>
		<p>
			&nbsp;
		</p>
		<hr width="97%" align="center" size=0>
		<div align="center">
			<input name="btnAdd" class="button1" type="button" id="btnAdd"
				value="�޸Ĺ���" onClick="mod()">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="btnBack" class="button1" type="button" id="btnBack"
				value="����" onClick="goBack()" />
		</div>

	</body>

</html>