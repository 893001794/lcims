<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="clientcommon.jsp"  %>

<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientArea"%>
<%@ page errorPage="../error.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加新客户</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
		<script src="../javascript/jquery.js"></script>
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
		window.self.location="searchclient.jsp";
	}

</script>





		<script language="javascript">
	function CheckForm(TheForm) {
		trimform(TheForm);
		if (TheForm.name.value == "") {
			alert ("客户名称不能为空！");
			TheForm.name.focus();
			return(false);
		}
		

		if (TheForm.contact.value == "") {
			alert ("主要联系人不能为空！");
			TheForm.contact.focus();
			return(false);
		}

		if (TheForm.tel.value == "") {
			alert ("联系电话不能为空！");
			TheForm.tel.focus();
			return(false);
		}
		
		if (TheForm.email.value == "") {
			alert ("电子邮箱不能为空！");
			TheForm.email.focus();
			return(false);
		}
		
		if (TheForm.email.value != "") {
			if (!chkemail(TheForm.email.value)) {
				alert ("电子邮箱格式不正确，电子邮箱只能填写一个！");
				TheForm.email.focus();
				return(false);
			}
		}
		if (TheForm.addr.value == "") {
			alert ("地址不能为空！");
			TheForm.addr.focus();
			return(false);
		}
		
		if (TheForm.sales.value == "") {
			alert ("负责销售不能为空！");
			TheForm.sales.focus();
			return(false);
		}
		
	return(true);
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
		<form method="post" name="projectform" id="projectform" action="addclient_post.jsp?command=confirm"
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
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>客户管理&gt;&gt;添加客户</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				
				<tr>
					<td width="20%">
						客户名称：
					</td>
					<td width="80%">
						<input name="name" type="text" id="name" size="60">
					</td>
				</tr>
				<tr>
					<td width="20%">
						客户简称：
					</td>
					<td width="80%">
						<input name="shortname" type="text" id="shortname" size="60">
					</td>
				</tr>
				<tr>
					<td width="10%">
						客户英文名：
					</td>
					<td width="90%">
						<input name="ename" type="text" id="ename" size="60" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						主要联系人：
					</td>
					<td width="80%">
						<input name="contact" type="text" id="contact" size="60">
					</td>
				</tr>
				<tr>
					<td width="20%">
						性别：
					</td>
					<td width="80%">
						男<input name="sex" type="radio" id="sex" size="60" value="男">
						女<input name="sex" type="radio" id="sex" size="60" value="女">
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
						<input name="job" type="text" id="dept" size="60" />
					</td>
				<tr>
					<td width="10%">
						联系电话：
					</td>
					<td width="90%">
						<input name="tel" type="text" id="tel" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						手机：
					</td>
					<td width="90%">
						<input name="mobile" type="text" id="mobile" size="60" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						传真号码：
					</td>
					<td width="80%">
						<input name="fax" type="text" id="fax" size="60">
					</td>
				</tr>
				<tr>
					<td width="10%">
						QQ/MSN：
					</td>
					<td width="90%">
						<input name="qq" type="text" id="qq" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						电子邮箱：
					</td>
					<td width="90%">
						<input name="email" type="text" id="email" size="60" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						地址：
					</td>
					<td width="80%">
						<input name="addr" type="text" id="addr" size="60">
					</td>
				</tr>
				<tr>
					<td width="10%">
						英文地址：
					</td>
					<td width="90%">
						<input name="eaddr" type="text" id="eaddr" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						邮政编码：
					</td>
					<td width="90%">
						<input name="zipcode" type="text" id="zipcode" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						负责销售：
					</td>
					<td width="90%">
						<input name="sales" type="text" id="sales" size="60" />
						<!-- 调用ajax的方法；AutoComplete控件就是在用户在文本框输入前几个字母或是汉字的时候,该控件就能从存放数据的文或是数据库里将所有以这些字母开头的数据提示给用户,供用户选择,提供方便。  -->
						<script>   
						        $("#sales").autocomplete("../sales_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
					</td>
				</tr>
				<tr>
				<tr>
					<td width="20%">
						客户主要产品：
					</td>
					<td width="80%">
						<input name="product" type="text" id="product" size="60">
					</td>
				</tr>
				
				<tr>
					<td>
						客户等级：
					</td>
					<td>
						<select name="clevel" style="width: 300px">
							<option value="normal" selected="selected">
								普通
							</option>
							<option value="vip">
								VIP
							</option>
							
						</select>
					</td>
				</tr>
				
				<tr>
					<td>
						付款方式：
					</td>
					<td>
						<select name="pay" style="width: 300px">
							<option value="现付" selected="selected">
								现付
							</option>
							<option value="买点">
								买点
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						区域：
					</td>
					<td>
						<select id="area" name="area" style="width: 300px">
							<option value="">选择区域</option>
							<%
								List<AreaForm> list = ClientArea.getInstance().getArea();
								for(int i=0;i<list.size();i++) {
									AreaForm af = list.get(i);
							 %>
								<option value="<%=af.getCity() %>" >
									<%=af.getCity() %>
								</option>
							<%
								}
							 %>
						</select>
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
