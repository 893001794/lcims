<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@ page errorPage="../error.jsp" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>项目进度查询</title>
		<link rel="stylesheet" href="css/drp.css">

		<script language="javascript">
	function modify() {
		window.self.location = "modifyproject.jsp";
	}

	function goBack() {
		window.self.location = "projectlist.jsp";
	}
</script>
	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h1>
							项目进度查询
						</h1> </b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action=control_order.jsp>
			<table width=95% border=0 cellspacing=0 cellpadding=0 align=center>
				<tr>

					<td align=center valign=middle width=47%>
						请输入报告编号：
						<input type=text name=keywords value="" size="20">
						<input type=submit name=Submit value=搜索>
					</td>
					<td align=center valign=middle width=48%>
						请输入报价单编号：
						<input type=text name=keywords value="" size="20">
						<input type=submit name=Submit value=搜索>
					</td>
				</tr>
			</table>
		</form>

		<hr width="97%" align="center" size=0>


		<table width=100% border=0 cellspacing=0 cellpadding=0 align=center>

			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						报价单编号：
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						报告编号：
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						项目等级：
					</td>
					<td>
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
			</table>
			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						客户名称：
					</td>
					<td align="left">
						<input type="text" size="25" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						客服人员：
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						销售人员：
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						测试项目：
					</td>
					<td>
						<input size="60" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						项目存在外包：
					</td>
					<td>
						<input type="checkbox" readonly="readonly" />
					</td>
				</tr>
				<br>
				<tr align="center">
					<td>
						样品名称：
					</td>
					<td>
						<input type="text" size="60" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						项目取消：
					</td>
					<td>
						<input type="checkbox" />
					</td>
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						食品级成品状态备注：
					</td>
					<td>
						<input size="70" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						项目预警备注：
					</td>
					<td>
						<textarea rows="6" cols="50"></textarea>
					</td>
				</tr>
			</table>
			<table align="center">
				<tr>
					<td>
						项目预警：
					</td>
					<td>
						<input type="checkbox" />
					</td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<td>
						报告已发出：
					</td>
					<td>
						<input type="checkbox" />
					</td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<td>
						迟单：
					</td>
					<td>
						<input type="checkbox" />
					</td>
				</tr>
			</table>
			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						送实验室时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						项目完成:
					</td>
					<td>
						<input type="checkbox" />
					</td>
				</tr>
				<tr align="center">
					<td>
						项目接收时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						排单时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						制备开始时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						应出报告时间：
					</td>
					<td>
						<input type="text" style="background-color: yellow"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						无机前处理开始时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						有机前处理开始时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						无机上机开始时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						有机上机开始时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						无机数据完成时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						有机数据完成时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<br>
				<tr>
					<td>
						报告完成时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						报告发出时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
			</table>
		</table>
		<br>
		<br>
		<br>

	</body>
</html>
