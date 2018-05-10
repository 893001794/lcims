<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="clientcommon.jsp"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientArea"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GB18030");
	String clientid = request.getParameter("clientid");
	if(clientid == null || "".equals(clientid)) {
		out.println("添加失败！<br>");
		out.println("<a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	ClientForm client = ClientAction.getInstance().getClientById(clientid); 
	List<ContactForm> list = ClientAction.getInstance().getContacts(clientid); 
	
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>所有联系人</title>
		<style type="text/css">
.body1 {
	background-color: #fffff5;
}
</style>

		<script language="javascript">
		function addcontact() {
			window.self.location = "addcontact.jsp?clientid=<%=clientid%>";
		}
		function goBack() {
			window.history.back();
		}
		
		function modifycontact() {
			with(document.getElementById("contactform")) {
				method="post";
				action="modifymaincontact.jsp";
				submit();
			}
		}

</script>

	</head>

	<body class="body1">
		<form name="contactform" id="contactform" >
			<input name="clientid" value="<%=client.getClientid() %>" type="hidden" />
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr align="center">
					<td width="522" class="p1" height="25" nowrap>
						<b>客户编号:</b>&nbsp;
						<b><%=client.getClientid() %></b>
					</td>
					<td width="522" class="p1" height="25" nowrap>
						<b>客户名称:</b>&nbsp;
						<b><%=client.getName() %></b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>

			<table cellpadding="5" cellspacing="5" align="center" width="90%"
				style="border: medium; border-width: medium;">
				<tr style="background-color: #F781BE; font-weight: bolder">
					<td>
						当前
					</td>
					<td>
						联系人
					</td>
					<td>
						性别
					</td>
					<td>
						部门
					</td>
					<td>
						职位
					</td>
					<td>
						电话
					</td>
					<td>
						手机
					</td>
					<td>
						传真号码
					</td>
					<td>
						QQ/MSN
					</td>
					<td>
						电子邮箱
					</td>
					<td>
						添加时间
					</td>
					<td>
						状态
					</td>
					<td>
						采购流程职能
					</td>
					<td>
						人员重要度
					</td>
					<td>
						支持度
					</td>
					<td>
						拜访面谈次数
					</td>
					<%
				if(user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {
	
			%>

					<td>
						管理
					</td>

					<%} %>

				</tr>

				<%
					for(int i=0;i<list.size();i++) {
						ContactForm cf = list.get(i);
				 %>

				<tr style="background-color: #F3F781">
					<td>
						<input name="contactid" value="<%=cf.getId() %>" type="radio" <%=client.getContact().getId()==cf.getId()?"checked":"" %>/>
					</td>
					<td>
						<%=cf.getContact() %>
					</td>
					<td>
						<%=cf.getSex() %>
					</td>
					<td>
						<%=cf.getDept() %>
					</td>
					<td>
						<%=cf.getJob() %>
					</td>
					<td>
						<%=cf.getTel() %>
					</td>
					<td>
						<%=cf.getMobile() %>
					</td>
					<td>
						<%=cf.getFax() %>
					</td>
					<td>
						<%=cf.getQq() %>
					</td>
					<td>
						<%=cf.getEmail() %>
					</td>
					<td>
						<%=cf.getTime() %>
					</td>
					<td>
						<%=cf.getStatus() %>
					</td>
					<td>
						<%=cf.getPurchase() %>
					</td>
					<td>
						<%=cf.getLevel() %>
					</td>
					<td>
						<%=cf.getDegree() %>
					</td>
					<td>
						<%=cf.getVisitnum() %>
					</td>

					<%
					if(user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {
					%>
					<td>
						[
						<a
							href="modifycontact.jsp?id=<%=cf.getId() %>&clientid=<%=clientid %>">修改</a>
						]
					</td>

					<%} %>

				</tr>

				<%
					}
				 %>

			</table>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="添加联系人" onclick="addcontact()" />
					&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
					value="修改主要联系人" onclick="modifycontact()" />
					&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
