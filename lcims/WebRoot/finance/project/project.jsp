<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>���۵�����</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script language="javascript">
		
		function goBack() {
		window.self.location="project_manage.jsp";
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("addappform").value += temp;
			document.getElementById("addappform").value += "\n";
		}
		function addInorganic(temp0) {
			document.getElementById("inorganic").value += temp;
			document.getElementById("inorganic").value += "\n";
		}
		function addInorganicDetail(temp1) {
			document.getElementById("inorganicdetail").value += temp1;
			document.getElementById("inorganicdetail").value += "\n";
		}
		function addOrganic(temp2) {
			document.getElementById("organic").value += temp2;
			document.getElementById("organic").value += "\n";
		}
		function addOrganicDetail(temp3) {
			document.getElementById("organicdetail").value += temp3;
			document.getElementById("organicdetail").value += "\n";
		}
		function addfood(temp4) {
			document.getElementById("food").value += temp4;
			document.getElementById("food").value += "\n";
		}
	</script>

	</head>

	<body class="body1">
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
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;�������&gt;&gt;����Ŀ����</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
<%--
		<form name=search method=post action=addflow.jsp>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<font color="red">�������������۵��ţ�</font>
						<input type=text name=pid size="25" value=>

						<input type=submit name=Submit value=����>
					</td>
				</tr>
			</table>
		</form>
	--%>	
		<hr width="97%" align="center" size=0>
		<form name="form1">
			<table cellpadding="5" cellspacing="0" style="margin-left: 10em">
				<tr>
					<td>
						���۵���ţ�
					</td>
					<td>
						<input name="pid" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="lc0001" />
					</td>

					<td>
						�ֹ�˾��
					</td>
					<td>
						
						<input type="text"  style="background-color: #F2F2F2"
							readonly="readonly" value="��ɽ" />
					</td>

				</tr>
				<tr>
				<td>
						��Ŀ�����ţ�
					</td>
					<td>
						<input style="background-color: #F2F2F2"
							readonly="readonly" value="lce09090920" />
					</td>
					<td>
						Ӧ���ʱ�䣺
					</td>
					<td>
						<input style="background-color: #F2F2F2"
							readonly="readonly" value="2009-12-09 15:30" />
					</td>

				</tr>
				<tr>
					<td>
						��Ŀ�ȼ���
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="��ͨ" />
					</td>
					<td>
						������Ա��
					</td>
					<td>
						<input name="rid" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="sales" />
					</td>
				</tr>
				<tr>
					<td>
						�ͷ���Ա��
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="eason" />
					</td>
					<td>
						��Ŀ���ͣ�
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="��ѧ���" />
					</td>
				</tr>
				<tr>
					<td>
						������Ա��
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="eason" />
					</td>
					<td>
						����ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="2009-12-06 10:23" />
					</td>
				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">
			
				<tr>
					<td>
						�ͻ����ƣ�
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="��ɽ������������޹�˾" />
					</td>

				</tr>

				<tr>
					<td>
						�������ݣ�
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="ROHS" />
					</td>

				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">



				<tr>
					<td>
						����Ŀ��
					</td>
					<td>
						<input name="totalprice" type="text" />
					</td>
					<td>
						�ְ���Ԥ�ƣ�
					</td>
					<td>
						<input name="paytime" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						�ڲ��ְ���Ԥ�ƣ�
					</td>
					<td>
						<input name="preadvance" type="text" />
					</td>
					<td>
						��������Ԥ�ƣ�
					</td>
					<td>
						<input name="repaytime" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						��������Ԥ�ƣ�
					</td>
					<td>
						<input name="repaytime" type="text" />
					</td>
					<td>
						����Ʊ��ʽ��
					</td>
					<td>
						<select>
							<option>��ѡ��</option>
							<option>����</option>
							<option>ȫ��</option>
							<option>������������</option>
							
						</select>
					</td>
				</tr>
				<tr>
					<td>
						��Ʊ���⣺
					</td>
					<td>
						<input name="preadvance" type="text" />
					</td>
					<td>
						��Ʊ���ݣ�
					</td>
					<td>
						<input name="repaytime" type="text" />
					</td>
				</tr>
				
			</table>

			


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="���">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
