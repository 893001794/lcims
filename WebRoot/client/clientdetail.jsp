<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@ include file="clientcommon.jsp"  %>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String clientid = request.getParameter("clientid");
	if(clientid == null || "".equals(clientid)) {
		response.sendRedirect("clientlist.jsp");
		return;
	}
	ClientForm client = ClientAction.getInstance().getClientById(clientid);
	//ContactForm cf=ClientAction.getInstance().getContactById(client.getContactid());
	if(client == null) {
		response.sendRedirect("clientlist.jsp");
		return;
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>客户详细信息</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script src="javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script language="javascript">
		function modifyclient() {
			with (document.getElementById("projectform")) {
			method="post";
			action="modifyclient.jsp?clientid=<%=client.getClientid() %>";
			submit();
			}
		}
		function goBack() {
		window.history.back();
	}

</script>





		<script language="javascript">
	function CheckForm(TheForm) {

		if (TheForm.priceid.value == "") {
			alert ("请填报价单编号！");
			TheForm.rtime.focus();
			return(false);
		}

		if (TheForm.sales.value == "") {
			alert ("请填写销售人员！");
			TheForm.sales.focus();
			return(false);
		}

		if (TheForm.client.value == "-1") {
			alert ("请选择客户名称！");
			TheForm.client.focus();
			return(false);
		}
		
	return(true);
	}
</script>
		<script src="../javascript/Calendar.js"></script>
	</head>

	<body class="body1">
		<form method="post" name="projectform" id="projectform"
			onSubmit="return CheckForm(this)">
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
						<b>&gt;&gt;客户管理&gt;&gt;客户详细信息</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td width="20%">
						客户编码：
					</td>
					<td width="80%">
						<input name="clientid" type="text" id="clientid" size="60" value="<%=client.getClientid() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						客户名称：
					</td>
					<td width="80%">
						<input name="name" type="text" id="name" size="60" value="<%=client.getName() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						客户简称：
					</td>
					<td width="80%">
						<input name="shortname" type="text" id="shortname" size="60" value="<%=client.getShortname() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="10%">
						客户英文名：
					</td>
					<td width="90%">
						<input name="ename" type="text" id="ename" size="60" value="<%=client.getEname() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						联系人：
					</td>
					<td width="80%">
						<input name="contact" type="text" id="contact" size="60" value="<%=client.getContact().getContact() %>" readonly="readonly" style="background-color: #F2F2F2">
						<a href="showcontact.jsp?clientid=<%=client.getClientid() %>">更多联系人</a>
					</td>
				</tr>
				<tr>
					<td width="20%">
						性别：
					</td>
					<td width="80%">
						<input name="sex" type="text" id="sex" size="60" value="<%=client.getContact().getSex() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						部门：
					</td>
					<td width="80%">
						<input name="dept" type="text" id="dept" size="60" value="<%=client.getContact().getDept() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						职位：
					</td>
					<td width="80%">
						<input name="job" type="text" id="job" size="60" value="<%=client.getContact().getJob() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="10%">
						联系电话：
					</td>
					<td width="90%">
						<input name="tel" type="text" id="tel" size="60" value="<%=client.getContact().getTel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						联系手机：
					</td>
					<td width="90%">
						<input name="mobile" type="text" id="mobile" size="60"  value="<%=client.getContact().getMobile()%>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						传真号码：
					</td>
					<td width="80%">
						<input name="fax" type="text" id="fax" size="60" value="<%=client.getContact().getFax() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						电子邮箱：
					</td>
					<td width="90%">
						<input name="email" type="text" id="email" size="60" value="<%=client.getContact().getEmail() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						地址：
					</td>
					<td width="80%">
						<input name="addr" type="text" id="addr" size="60" value="<%=client.getAddr() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="10%">
						英文地址：
					</td>
					<td width="90%">
						<input name="eaddr" type="text" id="eaddr" size="60" value="<%=client.getEaddr() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						邮政编码：
					</td>
					<td width="90%">
						<input name="zipcode" type="text" id="zipcode" size="60" value="<%=client.getZipcode() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						负责销售：
					</td>
					<td width="90%">
						<input name="sales" type="text" id="sales" size="60" value="<%=UserAction.getInstance().getNameById(client.getSalesid()) %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
				<tr>
					<td width="20%">
						客户主要产品：
					</td>
					<td width="80%">
						<input name="product" type="text" id="product" size="60" value="<%=client.getProduct() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						客户等级：
					</td>
					<td>
						<input name="clevel" type="text" id="clevel" size="60" value="<%=client.getClevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						信用金额：
					</td>
					<td>
						<input name="creditlevel" type="text" id="creditlevel" size="60" value="<%=client.getCreditlevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						付款方式：
					</td>
					<td>
						<input name="pay" type="text" id="pay" size="60" value="<%=client.getPay() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						区域：
					</td>
					<td>
						<input name="area" type="text" id="area" size="60" value="<%=client.getArea() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						客户状态：
					</td>
					<td>
						<input name="status" type="text" id="status" size="60" value="<%=client.getStatus() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				
				
			</table>

			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="修改客户信息" onclick="modifyclient()">
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>