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
		out.println("���ʧ�ܣ�<br>");
		out.println("<a href='javascript:window.history.back();'>����</a>");
		return;
	}
	ClientForm client = ClientAction.getInstance().getClientById(clientid); 
	List<ContactForm> list = ClientAction.getInstance().getContacts(clientid); 
	
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>������ϵ��</title>
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
						<b>�ͻ����:</b>&nbsp;
						<b><%=client.getClientid() %></b>
					</td>
					<td width="522" class="p1" height="25" nowrap>
						<b>�ͻ�����:</b>&nbsp;
						<b><%=client.getName() %></b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>

			<table cellpadding="5" cellspacing="5" align="center" width="90%"
				style="border: medium; border-width: medium;">
				<tr style="background-color: #F781BE; font-weight: bolder">
					<td>
						��ǰ
					</td>
					<td>
						��ϵ��
					</td>
					<td>
						�Ա�
					</td>
					<td>
						����
					</td>
					<td>
						ְλ
					</td>
					<td>
						�绰
					</td>
					<td>
						�ֻ�
					</td>
					<td>
						�������
					</td>
					<td>
						QQ/MSN
					</td>
					<td>
						��������
					</td>
					<td>
						���ʱ��
					</td>
					<td>
						״̬
					</td>
					<td>
						�ɹ�����ְ��
					</td>
					<td>
						��Ա��Ҫ��
					</td>
					<td>
						֧�ֶ�
					</td>
					<td>
						�ݷ���̸����
					</td>
					<%
				if(user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {
	
			%>

					<td>
						����
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
							href="modifycontact.jsp?id=<%=cf.getId() %>&clientid=<%=clientid %>">�޸�</a>
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
					value="�����ϵ��" onclick="addcontact()" />
					&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
					value="�޸���Ҫ��ϵ��" onclick="modifycontact()" />
					&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
