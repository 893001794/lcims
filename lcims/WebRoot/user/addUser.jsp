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
		<title>����¿ͻ�</title>
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
	<!-- 1.��ֹ���ᵥ��
	<script>
	function submitFun()
	{
	//�߼��ж�
	return true; //������ύ
	//�߼��ж�
	return false;//��������ύ
	}
	</script>-->
	<!--  //ע��˴�����д�� onsubmit=��submitFun();�� ���򽫱������ύ��
��ƪ������Դ�ڣ�����ѧԺ http://edu.codepub.com   ԭ�����ӣ�http://edu.codepub.com/2009/0416/2999.php-->
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
						<b>&gt;&gt;�û�����&gt;&gt;����û�</b>
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
									�û��Ĺ��ţ�
								</td>
								<td width="80%">
									<input name="Userid" type="text" id="Userid" size="60">
								</td>
							</tr>
							<tr>
								<td width="20%">
									�û����ƣ�
								</td>
								<td width="80%">
									<input name="name" type="text" id="name" size="60" >
								</td>
							</tr>
							<tr>
							<tr>
								<td width="20%">
									�û����룺
								</td>
								<td width="80%">
									<input name="Password" type="password" id="Password" size="60" value="12345678">
								</td>
							</tr>
							
							<tr>
								<td width="20%">
									�ϼ�id��
								</td>
								<td width="80%">
									<input name="superiorid" type="text" id="superiorid" size="60" >������������","������
								</td>
							</tr>
							
							<tr>
								<td width="10%">
									�������䣺
								</td>
								<td width="90%">
									<input name="email" type="text" id="email" size="60"/>
								</td>
							</tr>
							
							<tr>
								<td width="10%">
									�û���״̬��
								</td>
								<td width="90%">
									<input name="Estatus" type="text" id="Estatus" size="60" value="��Ч"/>
								</td>
							</tr>
							<tr>
								<td width="20%">
									�û��ĵ绰���룺
								</td>
								<td width="80%">
									<input name="Tel" type="text" id="Tel" size="60">
								</td>
							</tr>
							<tr>
								<td width="20%">
									�û����ֻ���
								</td>
								<td width="80%">
									<input name="phone" type="text" id="phone" size="60" >
								</td>
							</tr>
							<tr>
								<td width="20%">
									�����ص㣺
								</td>
								<td width="80%">
									
									<select name="address" id="address" style="width: 150px">
										<option value="1" selected="selected">��ɽ</option>
										<option value="2" selected="selected">����</option>
										<option value="3" selected="selected">��ݸ</option>
								</select>
								</td>
							</tr>
							<tr>
								<td width="20%">
									�Ա�
								</td>
								<td width="80%">
									��<input name="sex" type="radio" id="sex" size="60" value="��" checked="checked">
									Ů<input name="sex" type="radio" id="sex" size="60" value="Ů">
								</td>
							</tr>
							<tr>
								<td width="20%"> 
									�Ƿ�����Ա�� 
								</td>
								<td width="80%">
									��<input name="sales" type="radio" id="sales" size="60" value="��" >
									��<input name="sales" type="radio" id="sales" size="60" value="��" checked="checked">
								</td>
							</tr>
							<tr>
								<td width="20%"> 
									�Ƿ�ͷ���Ա�� 
								</td>
								<td width="80%">
									��<input name="serv" type="radio" id="serv" size="60" value="��" >
									��<input name="serv" type="radio" id="serv" size="60" value="��" checked="checked">
								</td>
							</tr>
							<tr>
								<td width="20%"> 
									�Ƿ�鿴����Ӵ���
								</td>
								<td width="80%">
									��<input name="isShowFspefund" type="radio" id="isShowFspefund" size="60" value="��" >
									��<input name="isShowFspefund" type="radio" id="isShowFspefund" size="60" value="��" checked="checked">
								</td>
							</tr>
							<tr>
								<td width="10%">
									���ţ�
								</td>
								<td width="90%">
									<input name="dept" type="text" id="dept" size="60" />
								</td>
							<tr>
								<td width="10%">
									ְλ��
								</td>
								<td width="90%">
									<input name="job" type="text" id="dept" size="60"  />
								</td>
							</tr>
							<tr>
								<td width="10%">
									��ɫ��
								</td>
								<td width="90%">
									<input name="Popdom" type="text" id="Popdom" size="60" value="user"/>
								</td>
							</tr>
							<tr>
								<td width="10%">
									Ȩ�ޣ�
								</td>
								<td width="90%">
									<select name="Ticketed" type="text" id="Ticketed" style="width: 430px">
										<option value="10000000">����Ȩ��</option>
										<option value="00100000">���ӵ�����</option>
										<option value="00100000">�ͷ���</option>
										<option value="00000010">���̲�</option>
										<option value="00010101">����</option>
										<option value="00010100">��������</option>
										<option value="10100000">���ӵ���ʵ���Ҹ�����</option>
										<option value="11111110">���̲�������</option>
										<option value="11111100">�ͷ�������</option>
									</select>
								</td>
							
							</tr>
							<tr>
								<td colspan="2">
								<font style="color: red;size: 8">�ֱ���0��1��ɣ�0������Ȩ�ޣ�1������Ȩ�ޡ���һλ�����ͻ��������۹������۹���ģ���Ȩ�ޣ��ڶ�λ�������۹������۵������ͻ�������ѯ�ͻ����ͻ������ͻ���������λ������ѧ�ͷ�������ѧʵ���ҹ���������Ŀ����ģ���Ȩ�ޣ�����λ�����������ģ���Ȩ��;����λ��������������۵�ͳ��</font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="����¿ͻ�" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
