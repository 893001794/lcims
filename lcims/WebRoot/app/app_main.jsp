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
//2013-6-22添加了一个查询参数user.getCompany();
	list = ApplicationAction.getInstance().getAllApp(command,user);
} else {
	list = ApplicationAction.getInstance().getAllApp("noaudit",user);
}
 %>




<html>
	<head>
		<title>管理申请表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="../../style" rel="stylesheet" type="text/css">
		<script language="javascript">
	function AlertDel(name) {
		if (confirm("确定要删除'" + name + "'记录吗"))
			return (true);
		else
			return (false);
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
<%--
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width=20%>
					申请表管理 -&gt; 管理申请表
				</td>

				<td align=center valign=middle width=50%>
					<form name=form1 method=post action=control.jsp?command=search>
						关键词：
						<input type=text name=keywords value=>
						<select name=type
							onchange="this.value=(this.options[this.selectedIndex]).value">
							<option value=icode selected>
								发票号码
							</option>
							<option value=salename>
								销货单位
							</option>
						</select>
						<input type=submit name=Submit value=搜索>
					</form>
				</td>

				<td width=30%>
					<form action="export.jsp" method="post" name="export">
						<input type="submit" value="导出所有发票数据到excel文档" />
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
						<input type=submit name="noaudit" value="全部">
					</form>
					</td>
					<td>
					<form name="form2" method="post" action="app_main.jsp?command=noaudit">
						<input type=submit name="noaudit" value="未审核">
					</form>
					</td>
					<td>
					<form name="form1" method="post" action="app_main.jsp?command=nopay">
						<input type=submit name="nopay" value="未支付">
					</form>
					</td>
					<td>
					<form name="form1" method="post" action="app_main.jsp?command=hadpay">
						<input type=submit name="hadpay" value="已支付">
					</form>
					</td>
					<td>
					<form name="form3" method="post" action="app_main.jsp?command=noaccept">
						<input type=submit name="noaccept" value="未收票">
					</form>
					</td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellpadding="3" cellspacing="1"
				bgcolor="999999">
				<tr align="center" valign="middle" bgcolor="dddddd">
					<td>
						操作
					</td>
					<td>
						申请表编号
					</td>
					<td>
						审核情况
					</td>
					<td>
						支付情况
					</td>
					<td>
						票据状态
					</td>
					<td>
						受款单位
					</td>
					<td>
						申请金额
					</td>
					<td>
						请款人
					</td>
					<td>
						支付方式
					</td>
					<td>
						支付类型
					</td>
					<td>
						请款日期
					</td>
					<td>
						预支付日期
					</td>
				</tr>

				<%
				for(int i=0;i<list.size();i++) {
					ApplicationForm af = list.get(i);
				 %>

				<tr align=center valign=middle bgcolor=ffffff>

					<td>
						[<a href="app_detail.jsp?app_id=<%=af.getApp_id() %>">管理</a>]
					<%
					if("n".equals(af.getIsaudit())) {
					 %>
						[<a href="app_mod.jsp?id=<%=af.getId() %>">修改</a>]
					<%
					}
					 %>
					</td>
					<td>
						<a href="app_detail.jsp?app_id=<%=af.getApp_id() %>"><%=af.getApp_id() %></a>
					</td>
					<td>
						<%="y".equals(af.getIsaudit())?"已审核":"未审核" %>
					</td>
					<td>
						<%=af.getPay_man()==null?"未支付":"已支付" %>
					</td>
					<td>
						<%=("y".equals(af.getInv_accept())?"已收":"未收") + af.getInv_type() %>
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
