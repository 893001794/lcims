<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>


<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@page import="java.util.ArrayList"%>
<%@ page errorPage="../error.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加新客户</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script src="javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script type="text/javascript" src="../javascript/check.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
    	<script src="../javascript/jquery.autocomplete.js"></script>
		<script language="javascript">
		function addproject() {
			with (document.getElementById("projectform")) {
				method="post";
				action="addclient_post.jsp";
				submit();
			}
		}
		function goBack() {
		window.history.back();
	}

</script>

		<script src="../javascript/Calendar.js"></script>
	</head>

	<body class="body1">
	<!-- 1.阻止表单提单：
	<script>
	function submitFun()
	{
	//逻辑判断
	return true; //允许表单提交
	//逻辑判断
	return false;//不允许表单提交
	}
	</script>-->
	<!--  //注意此处不能写成 onsubmit=”submitFun();” 否则将表单总是提交的
本篇文章来源于：开发学院 http://edu.codepub.com   原文链接：http://edu.codepub.com/2009/0416/2999.php-->
		<form method="post" name="projectform" id="projectform" action="addUser_post.jsp"
			onSubmit="return CheckForm(this)">
			<input name="creditlevel" type="hidden" id="creditlevel" size="60" value="10000">
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>&gt;&gt;用户管理&gt;&gt;添加用户</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td width="10%">
					
					</td>
					<td>
						<table width="100%" border="0" cellpadding="2" cellspacing="1">
							<tr>
								<td width="20%">
									用户的工号：
								</td>
								<td width="80%">
									<input name="Userid" type="text" id="Userid" size="60">
								</td>
							</tr>
							<tr>
								<td width="20%">
									用户名称：
								</td>
								<td width="80%">
									<input name="name" type="text" id="name" size="60" >
								</td>
							</tr>
							<tr>
							<tr>
								<td width="20%">
									用户密码：
								</td>
								<td width="80%">
									<input name="Password" type="password" id="Password" size="60" value="12345678">
								</td>
							</tr>
							
							<tr>
								<td width="20%">
									上级id：
								</td>
								<td width="80%">
									<input name="superiorid" type="text" id="superiorid" size="60" >（两个以上用","隔开）
								</td>
							</tr>
							
							<tr>
								<td width="10%">
									电子邮箱：
								</td>
								<td width="90%">
									<input name="email" type="text" id="email" size="60"/>
								</td>
							</tr>
							
							<tr>
								<td width="10%">
									用户的状态：
								</td>
								<td width="90%">
									<input name="Estatus" type="text" id="Estatus" size="60" value="有效"/>
								</td>
							</tr>
							<tr>
								<td width="20%">
									用户的电话号码：
								</td>
								<td width="80%">
									<input name="Tel" type="text" id="Tel" size="60">
								</td>
							</tr>
							<tr>
								<td width="20%">
									用户的手机：
								</td>
								<td width="80%">
									<input name="phone" type="text" id="phone" size="60" >
								</td>
							</tr>
							<tr>
								<td width="20%">
									工作地点：
								</td>
								<td width="80%">
									
									<select name="address" id="address" style="width: 150px">
										<option value="1" selected="selected">中山</option>
										<option value="2" selected="selected">广州</option>
										<option value="3" selected="selected">东莞</option>
								</select>
								</td>
							</tr>
							<tr>
								<td width="20%">
									性别：
								</td>
								<td width="80%">
									男<input name="sex" type="radio" id="sex" size="60" value="男" checked="checked">
									女<input name="sex" type="radio" id="sex" size="60" value="女">
								</td>
							</tr>
							<tr>
								<td width="20%"> 
									是否销售员： 
								</td>
								<td width="80%">
									是<input name="sales" type="radio" id="sales" size="60" value="是" >
									否<input name="sales" type="radio" id="sales" size="60" value="否" checked="checked">
								</td>
							</tr>
							<tr>
								<td width="20%"> 
									是否客服人员： 
								</td>
								<td width="80%">
									是<input name="serv" type="radio" id="serv" size="60" value="是" >
									否<input name="serv" type="radio" id="serv" size="60" value="否" checked="checked">
								</td>
							</tr>
							<tr>
								<td width="20%"> 
									是否查看特殊接待费
								</td>
								<td width="80%">
									是<input name="isShowFspefund" type="radio" id="isShowFspefund" size="60" value="是" >
									否<input name="isShowFspefund" type="radio" id="isShowFspefund" size="60" value="否" checked="checked">
								</td>
							</tr>
							<tr>
								<td width="10%">
									部门：
								</td>
								<td width="90%">
									<input name="dept" type="text" id="dept" size="60" />
								</td>
							<tr>
								<td width="10%">
									职位：
								</td>
								<td width="90%">
									<input name="job" type="text" id="dept" size="60"  />
								</td>
							</tr>
							<tr>
								<td width="10%">
									角色：
								</td>
								<td width="90%">
									<input name="Popdom" type="text" id="Popdom" size="60" value="user"/>
								</td>
							</tr>
							<tr>
								<td width="10%">
									权限：
								</td>
								<td width="90%">
									<select name="Ticketed" type="text" id="Ticketed" style="width: 430px">
										<option value="10000000">销售权限</option>
										<option value="00100000">电子电器部</option>
										<option value="00100000">客服部</option>
										<option value="00000010">工程部</option>
										<option value="00010101">财务部</option>
										<option value="00010100">财务部主管</option>
										<option value="10100000">电子电器实验室副主任</option>
										<option value="11111110">工程部副经理</option>
										<option value="11111100">客服副经理</option>
									</select>
								</td>
							
							</tr>
							<tr>
								<td colspan="2">
								<font style="color: red;size: 8">分别由0和1组成，0代表无权限，1代表有权限。第一位代表：客户管理、报价管理、销售管理模块的权限；第二位代表：报价管理—报价单管理、客户管理—查询客户、客户管理—客户管理；第三位代表：化学客服管理、化学实验室管理、安规项目管理模块的权限；第四位代表：财务管理模块的权限;第六位代表：财务管理—报价单统计</font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="添加新客户" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
