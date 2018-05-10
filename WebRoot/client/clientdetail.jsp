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
		<title>�ͻ���ϸ��Ϣ</title>
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
			alert ("����۵���ţ�");
			TheForm.rtime.focus();
			return(false);
		}

		if (TheForm.sales.value == "") {
			alert ("����д������Ա��");
			TheForm.sales.focus();
			return(false);
		}

		if (TheForm.client.value == "-1") {
			alert ("��ѡ��ͻ����ƣ�");
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
						<b>&gt;&gt;�ͻ�����&gt;&gt;�ͻ���ϸ��Ϣ</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td width="20%">
						�ͻ����룺
					</td>
					<td width="80%">
						<input name="clientid" type="text" id="clientid" size="60" value="<%=client.getClientid() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						�ͻ����ƣ�
					</td>
					<td width="80%">
						<input name="name" type="text" id="name" size="60" value="<%=client.getName() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						�ͻ���ƣ�
					</td>
					<td width="80%">
						<input name="shortname" type="text" id="shortname" size="60" value="<%=client.getShortname() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="10%">
						�ͻ�Ӣ������
					</td>
					<td width="90%">
						<input name="ename" type="text" id="ename" size="60" value="<%=client.getEname() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						��ϵ�ˣ�
					</td>
					<td width="80%">
						<input name="contact" type="text" id="contact" size="60" value="<%=client.getContact().getContact() %>" readonly="readonly" style="background-color: #F2F2F2">
						<a href="showcontact.jsp?clientid=<%=client.getClientid() %>">������ϵ��</a>
					</td>
				</tr>
				<tr>
					<td width="20%">
						�Ա�
					</td>
					<td width="80%">
						<input name="sex" type="text" id="sex" size="60" value="<%=client.getContact().getSex() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						���ţ�
					</td>
					<td width="80%">
						<input name="dept" type="text" id="dept" size="60" value="<%=client.getContact().getDept() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						ְλ��
					</td>
					<td width="80%">
						<input name="job" type="text" id="job" size="60" value="<%=client.getContact().getJob() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="10%">
						��ϵ�绰��
					</td>
					<td width="90%">
						<input name="tel" type="text" id="tel" size="60" value="<%=client.getContact().getTel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						��ϵ�ֻ���
					</td>
					<td width="90%">
						<input name="mobile" type="text" id="mobile" size="60"  value="<%=client.getContact().getMobile()%>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						������룺
					</td>
					<td width="80%">
						<input name="fax" type="text" id="fax" size="60" value="<%=client.getContact().getFax() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������䣺
					</td>
					<td width="90%">
						<input name="email" type="text" id="email" size="60" value="<%=client.getContact().getEmail() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						��ַ��
					</td>
					<td width="80%">
						<input name="addr" type="text" id="addr" size="60" value="<%=client.getAddr() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="10%">
						Ӣ�ĵ�ַ��
					</td>
					<td width="90%">
						<input name="eaddr" type="text" id="eaddr" size="60" value="<%=client.getEaddr() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������룺
					</td>
					<td width="90%">
						<input name="zipcode" type="text" id="zipcode" size="60" value="<%=client.getZipcode() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������ۣ�
					</td>
					<td width="90%">
						<input name="sales" type="text" id="sales" size="60" value="<%=UserAction.getInstance().getNameById(client.getSalesid()) %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
				<tr>
					<td width="20%">
						�ͻ���Ҫ��Ʒ��
					</td>
					<td width="80%">
						<input name="product" type="text" id="product" size="60" value="<%=client.getProduct() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						�ͻ��ȼ���
					</td>
					<td>
						<input name="clevel" type="text" id="clevel" size="60" value="<%=client.getClevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						���ý�
					</td>
					<td>
						<input name="creditlevel" type="text" id="creditlevel" size="60" value="<%=client.getCreditlevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						���ʽ��
					</td>
					<td>
						<input name="pay" type="text" id="pay" size="60" value="<%=client.getPay() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						����
					</td>
					<td>
						<input name="area" type="text" id="area" size="60" value="<%=client.getArea() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						�ͻ�״̬��
					</td>
					<td>
						<input name="status" type="text" id="status" size="60" value="<%=client.getStatus() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				
				
			</table>

			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="�޸Ŀͻ���Ϣ" onclick="modifyclient()">
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>