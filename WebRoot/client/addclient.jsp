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
		<title>����¿ͻ�</title>
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
			alert ("�ͻ����Ʋ���Ϊ�գ�");
			TheForm.name.focus();
			return(false);
		}
		

		if (TheForm.contact.value == "") {
			alert ("��Ҫ��ϵ�˲���Ϊ�գ�");
			TheForm.contact.focus();
			return(false);
		}

		if (TheForm.tel.value == "") {
			alert ("��ϵ�绰����Ϊ�գ�");
			TheForm.tel.focus();
			return(false);
		}
		
		if (TheForm.email.value == "") {
			alert ("�������䲻��Ϊ�գ�");
			TheForm.email.focus();
			return(false);
		}
		
		if (TheForm.email.value != "") {
			if (!chkemail(TheForm.email.value)) {
				alert ("���������ʽ����ȷ����������ֻ����дһ����");
				TheForm.email.focus();
				return(false);
			}
		}
		if (TheForm.addr.value == "") {
			alert ("��ַ����Ϊ�գ�");
			TheForm.addr.focus();
			return(false);
		}
		
		if (TheForm.sales.value == "") {
			alert ("�������۲���Ϊ�գ�");
			TheForm.sales.focus();
			return(false);
		}
		
	return(true);
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
							<b>�ͻ�����&gt;&gt;��ӿͻ�</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				
				<tr>
					<td width="20%">
						�ͻ����ƣ�
					</td>
					<td width="80%">
						<input name="name" type="text" id="name" size="60">
					</td>
				</tr>
				<tr>
					<td width="20%">
						�ͻ���ƣ�
					</td>
					<td width="80%">
						<input name="shortname" type="text" id="shortname" size="60">
					</td>
				</tr>
				<tr>
					<td width="10%">
						�ͻ�Ӣ������
					</td>
					<td width="90%">
						<input name="ename" type="text" id="ename" size="60" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						��Ҫ��ϵ�ˣ�
					</td>
					<td width="80%">
						<input name="contact" type="text" id="contact" size="60">
					</td>
				</tr>
				<tr>
					<td width="20%">
						�Ա�
					</td>
					<td width="80%">
						��<input name="sex" type="radio" id="sex" size="60" value="��">
						Ů<input name="sex" type="radio" id="sex" size="60" value="Ů">
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
						<input name="job" type="text" id="dept" size="60" />
					</td>
				<tr>
					<td width="10%">
						��ϵ�绰��
					</td>
					<td width="90%">
						<input name="tel" type="text" id="tel" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�ֻ���
					</td>
					<td width="90%">
						<input name="mobile" type="text" id="mobile" size="60" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						������룺
					</td>
					<td width="80%">
						<input name="fax" type="text" id="fax" size="60">
					</td>
				</tr>
				<tr>
					<td width="10%">
						QQ/MSN��
					</td>
					<td width="90%">
						<input name="qq" type="text" id="qq" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������䣺
					</td>
					<td width="90%">
						<input name="email" type="text" id="email" size="60" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						��ַ��
					</td>
					<td width="80%">
						<input name="addr" type="text" id="addr" size="60">
					</td>
				</tr>
				<tr>
					<td width="10%">
						Ӣ�ĵ�ַ��
					</td>
					<td width="90%">
						<input name="eaddr" type="text" id="eaddr" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������룺
					</td>
					<td width="90%">
						<input name="zipcode" type="text" id="zipcode" size="60" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������ۣ�
					</td>
					<td width="90%">
						<input name="sales" type="text" id="sales" size="60" />
						<!-- ����ajax�ķ�����AutoComplete�ؼ��������û����ı�������ǰ������ĸ���Ǻ��ֵ�ʱ��,�ÿؼ����ܴӴ�����ݵ��Ļ������ݿ��ｫ��������Щ��ĸ��ͷ��������ʾ���û�,���û�ѡ��,�ṩ���㡣  -->
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
						�ͻ���Ҫ��Ʒ��
					</td>
					<td width="80%">
						<input name="product" type="text" id="product" size="60">
					</td>
				</tr>
				
				<tr>
					<td>
						�ͻ��ȼ���
					</td>
					<td>
						<select name="clevel" style="width: 300px">
							<option value="normal" selected="selected">
								��ͨ
							</option>
							<option value="vip">
								VIP
							</option>
							
						</select>
					</td>
				</tr>
				
				<tr>
					<td>
						���ʽ��
					</td>
					<td>
						<select name="pay" style="width: 300px">
							<option value="�ָ�" selected="selected">
								�ָ�
							</option>
							<option value="���">
								���
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						����
					</td>
					<td>
						<select id="area" name="area" style="width: 300px">
							<option value="">ѡ������</option>
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
					value="����¿ͻ�" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
