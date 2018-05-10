<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="clientcommon.jsp"  %>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientArea"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@ page errorPage="../error.jsp" %>


<%
	request.setCharacterEncoding("GB18030");
	String strid = request.getParameter("id");
	int id = 0;
	if(strid == null || "".equals(strid)) {
		out.println("请选择联系人！<br>");
		out.println("<a href='searchclient.jsp'>返回</a>");
		return;
	} else {
		id = Integer.parseInt(strid);
	}
	String clientid = request.getParameter("clientid");
	if(clientid == null || "".equals(clientid)) {
		out.println("请选择客户！<br>");
		out.println("<a href='searchclient.jsp'>返回</a>");
		return;
	}
	ClientForm client = ClientAction.getInstance().getClientById(clientid); 
	String name = client.getName();
	ContactForm cf = ClientAction.getInstance().getContactById(id); 
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>修改联系人</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script src="javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/jquery.js"></script>
		<script language="javascript">
		function modifycontact() {
			var str = $("#visitnum").val();
			if(isNaN(str)){
				alert("拜访面谈次数为数字!!!");
				return(false);
			}
			with (document.getElementById("projectform")) {
			method="post";
			action="modifycontact_post.jsp?id=<%=id%>";
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
						<b>&gt;&gt;客户管理&gt;&gt;修改联系人</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td width="20%">
						客户编号：
					</td>
					<td width="80%">
						<input name="clientid" type="text" id="clientid" size="60" value="<%=clientid %>" readonly="readonly" style="background-color: #F2F2F2;"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						客户名称：
					</td>
					<td width="80%">
						<input name="name" type="text" id="name" size="60" value="<%=name %>" readonly="readonly" style="background-color: #F2F2F2;"/>
					</td>
				</tr>
				
				<tr>
					<td width="20%">
						联系人：
					</td>
					<td width="80%">
						<input name="contact" type="text" id="contact" size="60" value="<%=cf.getContact() %>"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						性别：
					</td>
					<td width="80%">
						男<input name="sex" type="radio" id="sex1" size="60" value="男" checked="checked">
						女<input name="sex" type="radio" id="sex2" size="60" value="女">
						<script type="text/javascript">
							if("女".charCodeAt() == "<%=cf.getSex()%>".charCodeAt()){
								document.getElementById("sex2").checked = true;	
							}
						
						</script>
					</td>
				</tr>
				<tr>
					<td width="10%">
						部门：
					</td>
					<td width="90%">
						<input name="dept" type="text" id="dept" size="60" value="<%=cf.getDept() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						职位：
					</td>
					<td width="90%">
						<input name="job" type="text" id="job" size="60" value="<%=cf.getJob() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						联系电话：
					</td>
					<td width="90%">
						<input name="tel" type="text" id="tel" size="60" value="<%=cf.getTel() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						手机：
					</td>
					<td width="90%">
						<input name="mobile" type="text" id="mobile" size="60" value="<%=cf.getMobile() %>"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						传真号码：
					</td>
					<td width="80%">
						<input name="fax" type="text" id="fax" size="60" value="<%=cf.getFax() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						QQ/MSN：
					</td>
					<td width="90%">
						<input name="qq" type="text" id="qq" size="60" value="<%=cf.getQq() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						电子邮箱：
					</td>
					<td width="90%">
						<input name="email" type="text" id="email" size="60" value="<%=cf.getEmail() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						采购流程职能：
					</td>
					<td width="90%">
						<input name="purchase" type="text" id="purchase" size="60" value="<%=cf.getPurchase() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						人员重要度：
					</td>
					<td width="90%">
						<input name="level" type="text" id="level" size="60" value="<%=cf.getLevel() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						支持度：
					</td>
					<td width="90%">
						<input name="degree" type="text" id="degree" size="60" value="<%=cf.getDegree() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						拜访面谈次数：
					</td>
					<td width="90%">
						<input name="visitnum" type="text" id="visitnum" size="60" value="<%=cf.getVisitnum() %>"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						备注：
					</td>
					<td width="90%">
						<input name="notes" type="text" id="notes" size="60" value="<%=cf.getNotes()==null?"":cf.getNotes() %>"/>
					</td>
				</tr>
				
			</table>

			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="修改" onclick="modifycontact()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
