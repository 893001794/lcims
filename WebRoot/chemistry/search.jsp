<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@ page errorPage="../error.jsp" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��Ŀ���Ȳ�ѯ</title>
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
							��Ŀ���Ȳ�ѯ
						</h1> </b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action=control_order.jsp>
			<table width=95% border=0 cellspacing=0 cellpadding=0 align=center>
				<tr>

					<td align=center valign=middle width=47%>
						�����뱨���ţ�
						<input type=text name=keywords value="" size="20">
						<input type=submit name=Submit value=����>
					</td>
					<td align=center valign=middle width=48%>
						�����뱨�۵���ţ�
						<input type=text name=keywords value="" size="20">
						<input type=submit name=Submit value=����>
					</td>
				</tr>
			</table>
		</form>

		<hr width="97%" align="center" size=0>


		<table width=100% border=0 cellspacing=0 cellpadding=0 align=center>

			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						���۵���ţ�
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						�����ţ�
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						��Ŀ�ȼ���
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
						�ͻ����ƣ�
					</td>
					<td align="left">
						<input type="text" size="25" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						�ͷ���Ա��
					</td>
					<td align="left">
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						������Ա��
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
						������Ŀ��
					</td>
					<td>
						<input size="60" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						��Ŀ���������
					</td>
					<td>
						<input type="checkbox" readonly="readonly" />
					</td>
				</tr>
				<br>
				<tr align="center">
					<td>
						��Ʒ���ƣ�
					</td>
					<td>
						<input type="text" size="60" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						��Ŀȡ����
					</td>
					<td>
						<input type="checkbox" />
					</td>
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						ʳƷ����Ʒ״̬��ע��
					</td>
					<td>
						<input size="70" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						��ĿԤ����ע��
					</td>
					<td>
						<textarea rows="6" cols="50"></textarea>
					</td>
				</tr>
			</table>
			<table align="center">
				<tr>
					<td>
						��ĿԤ����
					</td>
					<td>
						<input type="checkbox" />
					</td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<td>
						�����ѷ�����
					</td>
					<td>
						<input type="checkbox" />
					</td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<td>
						�ٵ���
					</td>
					<td>
						<input type="checkbox" />
					</td>
				</tr>
			</table>
			<table align="center" cellspacing=5 cellpadding=5>
				<tr>
					<td>
						��ʵ����ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						��Ŀ���:
					</td>
					<td>
						<input type="checkbox" />
					</td>
				</tr>
				<tr align="center">
					<td>
						��Ŀ����ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						�ŵ�ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						�Ʊ���ʼʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						Ӧ������ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: yellow"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						�޻�ǰ����ʼʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						�л�ǰ����ʼʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						�޻��ϻ���ʼʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						�л��ϻ���ʼʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						�޻��������ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						�л��������ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
				</tr>
				<br>
				<tr>
					<td>
						�������ʱ�䣺
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly" />
					</td>
					<td>
						���淢��ʱ�䣺
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
