<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.lcim.app.Supplier"%>

<%@ include file="../comman.jsp"%>
<%@ page import="java.util.*"%>

<%
List<Supplier> list = ApplicationAction.getInstance().getAllSup();
 %>




<html>
	<head>
		<title>管理收款单位</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="../../style" rel="stylesheet" type="text/css">
		<script language="javascript">
	function addsup() {
		window.self.location = "sup_add.jsp";
	}
	function CheckSelect() {
		if (!document.form.checkbox.checked) {
			alert("请先选择，后转移！");
			return (false);
		} else
			return (true);
	}
</script>
	</head>
	<body>
		<br>
		<form name="form2" method="post"
			action="">
			<table width="100%" border="0" cellpadding="3" cellspacing="1"
				bgcolor="999999">
				<tr align="center" valign="middle" bgcolor="dddddd">
					<td>
						受款单位
					</td>
					<td>
						开户行地址
					</td>
					<td>
						账户名称
					</td>
					<td>
						银行账户
					</td>
					<td>
						操作
					</td>
				</tr>

				<%
				for(int i=0;i<list.size();i++) {
					Supplier sup = list.get(i);
				 %>

				<tr align=center valign=middle bgcolor=ffffff>

					<td>
						<%=sup.getName() %>
					</td>
					<td>
						<%=sup.getBank() %>
					</td>
					<td>
						<%=sup.getCreditname() %>
					</td>
					<td><%=sup.getCreditcard() %>
						
					</td>
					<td>
					<%
					if(user.getId()==103) {
					 %>
						<a href="sup_mod.jsp?id=<%=sup.getId() %>">修改</a>
					<%
					}
					 %>
					</td>
				</tr>
				<%
				}
				 %>

			</table>
		</form>



		<table width=100% border=0 cellspacing=1 cellpadding=3>
			<tr bgcolor=f1f1f1>
				<td align=center valign=middle width=50%>
					<input name="button" type="button" value="添加" onclick="addsup();">
				</td>
			</tr>
		</table>
	</body>
</html>
