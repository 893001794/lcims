<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String currDate=sdf.format(new Date());
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӱ��۵�</title>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script src="../js/cashcount/fpay.js"></script>
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="fpay_post.jsp" onsubmit="getElById('btnAdd').disabled = true; return true">
			<input name="command" type="hidden" value="add" />
			<div class="outborder">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�������&gt;&gt;֧�������</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td align="right">
							 ֧�����ڣ�
						</td>
						<td >
							<input type="text" id ="dpaytime"  name ="dpaytime" size="31" value="<%=currDate%>">
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'dpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td align="right" width="14%">
							��Ӧ�� ��
						</td>
						<td >
							<input type="text" id ="supplier "  name ="supplier" size="35" value="">
						</td>
						<td align="right">
							ժҪ��
						</td>
						<td >
							<input type="text" id ="summay"  name ="summay" size="35" value="">
						</td>
					</tr>
					<tr>
						<td width="14%" align="right">
							�������ţ�
						</td>
						<td >
							<select id="dept" name="dept" style="width: 280px;">
								<option>����һ��</option>
								<option>���۶���</option>
								<option>��������</option>
								<option>��ͻ���</option>
								<option>�����岿</option>
								<option>EMC��</option>
								<option>JIM�Ŷ�</option>
								<option>���ۿͷ�</option>
								<option>������</option>
								<option>����</option>
								<option>������</option>
								<option>�ʿز�</option>
								<option>�ܾ���</option>
								<option>��ѧʵ����</option>
								<option>��ȫʵ����</option>
								<option>������ʵ����</option>
								<option>EMCʵ����</option>
								<option>��ѵѧԺ</option>
								<option>���ݹ�˾</option>
								<option>���̲�</option>
							</select>
						</td>
						<td width="14%" align="right">
							��Ա��
						</td>
						<td >
							<input type="text" id ="person"  name ="person" size="35" value="">
						</td>
						<td width="14%" align="right">
							�ܾ��죺
						</td>
						<td >
							<input type="text" id ="gmo"  name ="gmo" size="35" value="0" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							��ѧ��
						</td>
						<td >
							<input type="text" id ="chem"  name ="chem" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							��ȫ��
						</td>
						<td >
							<input type="text" id ="safe"  name ="safe" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							�����ܣ�
						</td>
						<td >
							<input type="text" id ="op"  name ="op" size="35" value="0" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							EMC��Ӫ��
						</td>
						<td >
							<input type="text" id ="emc"  name ="emc" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							EMC���ң�
						</td>
						<td >
							<input type="text" id ="dr"  name ="dr" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							��ͻ�����
						</td>
						<td >
							<input type="text" id ="vip"  name ="vip" size="35" value="0" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							��������
						</td>
						<td >
							<input type="text" id ="eq"  name ="eq" size="35" value="0" onblur="sumTotal();">
						</td align="right">
						<td align="right">
							���񲿣�
						</td>
						<td >
							<input type="text" id ="finance"  name ="finance" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							��������
						</td>
						<td >
							<input type="text" id ="administration"  name ="administration" size="35" value="0" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							���̲���
						</td>
						<td >
							<input type="text" id ="engineering"  name ="engineering" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							С�ƣ�
						</td>
						<td >
							<input type="text" id ="total"  name ="total" size="35" value="0">
						</td>
						<td align="right">
							�˺����ƣ�
						</td>
						<td >
							<select id="account" name ="account"; style="width: 280px;">
								<option value="1769">1769</option>
								<option value="1769-0002">1769-0002</option>
								<option value="1769-0003">1769-0003</option>
								<option value="1769-0004">1769-0004</option>
								<option value="5963">5963</option>
								<option value="3232">3232</option>
								<option value="8833">8833</option>
								<option value="5016">5016</option>
								<option value="4193">4193</option>
								<option value="7084">7084</option>
								<option value="1050">1050</option>
								<option value="�ֽ�">�ֽ�</option>
								<option value="HK-�ֽ�">HK-�ֽ�</option>
							</select>
						</td>
						
					</tr>
					<tr>
						<td align="right">
							 Ʊ�����ͣ�
						</td>
						<td >
							<select id="einvtype" name ="einvtype"; style="width: 280px;">
								<option value="��Ʊ">��Ʊ</option>
								<option value="�վ�">�վ�</option>
							</select>
						</td>
						<td align="right">
							 ��Ʊ���룺
						</td>
						<td >
							<input type="text" id ="invoiceno"  name ="invoiceno" size="35" value="">
						</td>
						<td align="right">
							��ע��
						</td>
						<td >
							<textarea rows="6" cols="33" id ="remarks"  name ="remarks"></textarea>
						</td>
						
					</tr>
					<tr>
						<td align="right">
							һ����Ŀ��
						</td>
						<td >
							<input type="text" id ="onelevelsub"  name ="onelevelsub" size="35" value="">
						</td>
						
						<td align="right">
							������Ŀ
						</td>
						<td >
							<input type="text" id ="twolevelsub"  name ="twolevelsub" size="35" value="">
						</td>
						<td >
							������Ŀ
						</td>
						<td >
							<input type="text" id ="threelevelsub"  name ="threelevelsub" size="35" value="" onblur="findSubsByThreeLevelSub(this.value);">
						</td>
					</tr>
					<tr>
						<td align="right">
							���������
						</td>
						<td >
							<input type="text" id ="travel"  name ="travel" size="35" value="">
						</td>
						
						<td align="right">
							�д��ͻ�
						</td>
						<td >
							<input type="text" id ="entertain"  name ="entertain" size="35" value="">
						</td>
						<td >
							&nbsp;
						</td>
						<td >
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input id="btnAdd" name="btnAdd" class="button1" type="submit"" id="btnAdd" value="����"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
