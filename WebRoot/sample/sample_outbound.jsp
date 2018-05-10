<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.Warnning"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%
	//String sno = request.getParameter("sno").trim();
	request.setCharacterEncoding("GBK");
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String strId =request.getParameter("id");
	String status =request.getParameter("status");
	status=new String (status.getBytes("ISO-8859-1"),"GBK");
%>

<html>
	<head>
		<meta content="text/html; charset=GBK">
		<meta http-equiv="cache-control" content="no-cache, must-revalidate">
		<title>样品出库</title>
<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>
<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>

		<script type="text/javascript">
		function checkForm(){
		var tpplication =document.getElementById("tpplication").value;
		if(tpplication ==""){
		alert("请输入样品出库的用途！！！");
		return false;
		}
		var myform=document.getElementById("myform");
		myform.submit();
		window.close();
		}
		</script>
	</head>

	<body class="body1">  
	
		<table width="70%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h1>
							样品出库记录表
						</h1> </b>
				</td>
			</tr>
		</table>
		
		<hr width="70%" align="center" size=0>
		<form action="<%=basePath%>outbound_post.jsp?strId=<%=strId %>&status=<%=status %>" method="post" id ="myform" id ="myform" onsubmit="return checkForm();">
		<div class="outborder" style="text-align: center;" align="center">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="20%">
						样品<%=status %>时间：
					</td>
					<td>
						<input size="40" name ="outdatetime" id="outdatetime" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%>"/>
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'outdatetime'})" src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
					</td>
				</tr>

				<tr>
					<td>
						样品用途：
					</td>
					<td>
					<textarea rows="5" cols="10" name="tpplication" id="tpplication" style="width: 60%"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><input type="button" onClick="checkForm();" value="提交"></td>
				</tr>
			</table>
			</div>
			
			</form>
	</body>
</html>
