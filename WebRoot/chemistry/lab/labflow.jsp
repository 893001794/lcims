<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
 <%@ page errorPage="../../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid");
	if(rid == null || "".equals(rid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	List<Flow> list = FlowAction.getInstance().getFlowByRid(rid);
	
	

%>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>流转单列表</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script type="text/javascript">
	function goBack() {
			window.history.back();
		}
	
</script>

	</head>

	<body class="body1">

		<div align="center">
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="35">
				<tr>
					<td class="p1" height="18" nowrap>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td width="522" class="p1" height="17" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>化学实验室管理&gt;&gt;流转单列表</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>

			<form name="userform" id="userform">
		</div>
		
		<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">报告编号</font>
				</td>
			</tr>
			<tr align="center">
				<td class="rd8"><%=rid %></td>
			</tr>
		</table>
		<p>
			&nbsp;
		</p>

		<table width="95%" height="20" border="0" align="center"
			cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="30%" class="rd19">
					<font color="#FFFFFF" size="2pt">流转单列表</font>
				</td>


			</tr>
		</table>
		<table width="95%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="table1">
			<tr>
				<td class="rd6" width="5%">
					<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
				</td>
				<td class="rd6">
					流转单编号
				</td>
				<td class="rd6">
					流转单类型
				</td>
				<td class="rd6">
					实验室
				</td>
				<td class="rd6">
					排单人
				</td>
				<td class="rd6">
					排单时间
				</td>
				<td class="rd6">
					流转单工分A
				</td>
				<td class="rd6">
					流转单工分B
				</td>
				<td class="rd6">
					操作
				</td>
			</tr>

			<%
					if(list != null) {
					for(int i=0;i<list.size();i++) {
						Flow flow = list.get(i);
				 %>

			<tr>
				<td class="rd8">
					<input type="checkbox" name="selectFlag" class="checkbox1"
						value="<%=flow.getFid()%>">
				</td>
				<td class="rd8">
					<a href="detail.jsp?fid=<%=flow.getFid() %>"><%=flow.getFid() %></a>
				</td>
				<td class="rd8">
					<%=flow.getFlowtype() %>
				</td>
				<td class="rd8">
					<%=flow.getLab() %>
				</td>
				<td class="rd8">
					<%=flow.getPduser() %>
				</td>
				<td class="rd8">
					<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(flow.getPdtime()) %>
				</td>
				<td class="rd8">
					<%=flow.getVworkpoint()==null?"":flow.getVworkpoint() %>
				</td>
				<td class="rd8">
					<%=flow.getVworkpoint2()==null?"":flow.getVworkpoint2() %>
				</td>
				<td class="rd8">
					<a href="labflowmodify.jsp?fid=<%=flow.getFid() %>">编辑</a>
				</td>
			</tr>

			<%
					}
				}
				 %>

		</table>
		<table width="95%" height="30" border="0" align="center"
			cellpadding="0" cellspacing="0" class="rd1">
			<tr>
				<td nowrap class="rd19">
					<div align="right">
						&nbsp;&nbsp;
						
					</div>

				</td>

			</tr>
		</table>

		<div align="center">
	<input name="btnModify" class="button1" type="button"
							id="btnModify" value="返回" onClick="goBack()">
		</div>
	</body>
</html>
