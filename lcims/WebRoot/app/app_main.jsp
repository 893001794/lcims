<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../comman.jsp"%>
<%@ page import="java.util.*"%>

<%
request.setCharacterEncoding("GBK");
List<ApplicationForm> list = null;
String command = request.getParameter("command");
if(command != null && !"".equals(command)) {
//2013-6-22�����һ����ѯ����user.getCompany();
	list = ApplicationAction.getInstance().getAllApp(command,user);
} else {
	list = ApplicationAction.getInstance().getAllApp("noaudit",user);
}
 %>




<html>
	<head>
		<title>���������</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="../../style" rel="stylesheet" type="text/css">
		<script language="javascript">
	function AlertDel(name) {
		if (confirm("ȷ��Ҫɾ��'" + name + "'��¼��"))
			return (true);
		else
			return (false);
	}
	function CheckSelect() {
		if (!document.form.checkbox.checked) {
			alert("����ѡ�񣬺�ת�ƣ�");
			return (false);
		} else
			return (true);
	}
</script>
	</head>
	<body>
		<br>
<%--
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width=20%>
					�������� -&gt; ���������
				</td>

				<td align=center valign=middle width=50%>
					<form name=form1 method=post action=control.jsp?command=search>
						�ؼ��ʣ�
						<input type=text name=keywords value=>
						<select name=type
							onchange="this.value=(this.options[this.selectedIndex]).value">
							<option value=icode selected>
								��Ʊ����
							</option>
							<option value=salename>
								������λ
							</option>
						</select>
						<input type=submit name=Submit value=����>
					</form>
				</td>

				<td width=30%>
					<form action="export.jsp" method="post" name="export">
						<input type="submit" value="�������з�Ʊ���ݵ�excel�ĵ�" />
					</form>
					<font color=red> </font>
				</td>
			</tr>
		</table>
--%>
			<table width="40%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr align="center" valign="middle">
					<td>
					<form name="form2" method="post" action="app_main.jsp?command=all">
						<input type=submit name="noaudit" value="ȫ��">
					</form>
					</td>
					<td>
					<form name="form2" method="post" action="app_main.jsp?command=noaudit">
						<input type=submit name="noaudit" value="δ���">
					</form>
					</td>
					<td>
					<form name="form1" method="post" action="app_main.jsp?command=nopay">
						<input type=submit name="nopay" value="δ֧��">
					</form>
					</td>
					<td>
					<form name="form1" method="post" action="app_main.jsp?command=hadpay">
						<input type=submit name="hadpay" value="��֧��">
					</form>
					</td>
					<td>
					<form name="form3" method="post" action="app_main.jsp?command=noaccept">
						<input type=submit name="noaccept" value="δ��Ʊ">
					</form>
					</td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellpadding="3" cellspacing="1"
				bgcolor="999999">
				<tr align="center" valign="middle" bgcolor="dddddd">
					<td>
						����
					</td>
					<td>
						�������
					</td>
					<td>
						������
					</td>
					<td>
						֧�����
					</td>
					<td>
						Ʊ��״̬
					</td>
					<td>
						�ܿλ
					</td>
					<td>
						������
					</td>
					<td>
						�����
					</td>
					<td>
						֧����ʽ
					</td>
					<td>
						֧������
					</td>
					<td>
						�������
					</td>
					<td>
						Ԥ֧������
					</td>
				</tr>

				<%
				for(int i=0;i<list.size();i++) {
					ApplicationForm af = list.get(i);
				 %>

				<tr align=center valign=middle bgcolor=ffffff>

					<td>
						[<a href="app_detail.jsp?app_id=<%=af.getApp_id() %>">����</a>]
					<%
					if("n".equals(af.getIsaudit())) {
					 %>
						[<a href="app_mod.jsp?id=<%=af.getId() %>">�޸�</a>]
					<%
					}
					 %>
					</td>
					<td>
						<a href="app_detail.jsp?app_id=<%=af.getApp_id() %>"><%=af.getApp_id() %></a>
					</td>
					<td>
						<%="y".equals(af.getIsaudit())?"�����":"δ���" %>
					</td>
					<td>
						<%=af.getPay_man()==null?"δ֧��":"��֧��" %>
					</td>
					<td>
						<%=("y".equals(af.getInv_accept())?"����":"δ��") + af.getInv_type() %>
					</td>
					<td>
						<%=af.getSup().getName() %>
					</td>
					<td>
					<%
					float total = af.getFirst_pay() + af.getSecond_pay() + af.getThird_pay();
					 %>
						<%=total == 0 ? "" : new DecimalFormat("#.00").format(total) %>
					</td>
					<td>
						<%=af.getApp_user() %>
					</td>
					<td>
						<%=af.getPay_method() %>
					</td>
					
					<td>
						<%=af.getPay_type() %>
					</td>
					<td>
						<%=af.getApp_time()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getApp_time()) %>
					</td>
					<td>
						<%=af.getPrepay_time1()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time1()) %>
					</td>
					
				</tr>
				<%
				}
				 %>

			</table>
		</form>



		

	</body>
</html>
