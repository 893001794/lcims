<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.system.CategoryAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.system.Category"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>���ϵͳ����</title>
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
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<script type="text/javascript">
	function add() {
			var deadtime=document.getElementById("deadtime");
			var class1=document.getElementById("category");
			if(deadtime.value==""){
			alert("ʧЧ���ڲ���Ϊ��");
			return ;
			}
			if(class1.value==""){
			alert("��ѡ�񹫸�����")
			return;
			}
			with (document.getElementById("addnotes")) {
				method="post";
				action="addnotes_post.jsp";
				submit();
			}
		}
		function goBack() {
		window.self.location="system_notes.jsp";
	}
	
	function showdialog() {
	window.self.location("addcatgory.jsp");
		//window.showModalDialog("addcatgory.jsp",frist,"dialogWidth:600px;dialogHeight:400px");
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
								����ϵͳ����
							</h2> </b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>

			<table height="51" align="center">
				<tr>
					<td>
						����
					</td>
					<td width="250"><div align="center" > 
						<select name="category" id ="category" style="width: 300px" onchange="changeStatus()">
								<option value="">
									��ѡ������
								</option>
								<%
							
										List  list =CategoryAction.getInstance().getCategory();
										for(int i=0;i<list.size();i++){
										Category cate=(Category)list.get(i);
										%>
										
										<option value="<%=cate.getId() %>" <%=cate.getId()==0?"selected":"" %>>
									    <%=cate.getName() %>
										</option>
										<%
										}
										 %>
							</select>
							
					</td>
					<td align="left">
						[<a href="addcatgory.jsp">��ӷ���</a>]
					</td>
				</tr>
				<tr>
					<td width="17%">
						���⣺
					</td>
					<td colspan="2">
						<input name="head" value="" size="80" type="text" />
					</td>
				</tr>
				<br>


				<tr>
					<td valign="middle">
						���ݣ�
					</td>
					<td colspan="2">
						<textarea name="content" rows="10" cols="80"></textarea>
					</td>
				</tr>


				<tr>
					<td valign="middle">
						����ʧЧʱ�䣺
					</td>
					<td colspan="2">
						<input name="deadtime" type="text" id="deadtime" size="30"
							maxlength="50" value="" width="230px">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'deadtime'})"
							src="../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
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
				value="��ӹ���" onClick="add()">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="btnBack" class="button1" type="button" id="btnBack"
				value="����" onClick="goBack()" />
		</div>

	</body>

</html>