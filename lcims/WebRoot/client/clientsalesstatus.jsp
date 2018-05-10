<%@page import="com.lccert.crm.client.ClientSalesStatusForm"%>
<%@page import="com.lccert.crm.client.ClientSalesStatusAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="clientcommon.jsp"  %>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.user.UserForm"%> 
<%@ page errorPage="../error.jsp" %>

<%
	int pageNo = 1;
	int pageSize = 15;
	String StrPageNo = request.getParameter("pageNo");
	if(StrPageNo != null && !"".equals(StrPageNo)) {
		try {
			pageNo = Integer.parseInt(StrPageNo);
		} catch (NumberFormatException e) {
			pageNo = 1;
		}
	}
	int salesid = user.getId();
	String clientName = request.getParameter("clientName");
	PageModel pm = ClientSalesStatusAction.getInstance().getClientStatus(pageNo,pageSize,salesid,clientName);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�ҵĿͻ������б�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script type="text/javascript">
	
	function addUser() {
		
		window.self.location = "addclient.jsp";	
	}
	
	function modifyUser() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵĿͻ����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ���ͻ����ݣ�");
			return;
		}
	
		window.self.location = "modifyclient.jsp?clientid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteUser() {
		alert("��ʱû�д˹��ܣ�");
		return;
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("��ѡ����Ҫɾ�����û����ݣ�");
			return;
		}
		if (window.confirm("�Ƿ�ȷ��ɾ��ѡ�е����ݣ�")) {
			//ִ��ɾ��
			with (document.getElementById("userForm")) {
				method = "post";
				action = "flowlist.jsp?command=delete"
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	function topPage() {
		window.self.location = "myclient.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "myclient.jsp?pageNo=<%=pm.getPreviousPageNo() %>";
	}	
	
	function nextPage() {
		window.self.location = "myclient.jsp?pageNo=<%=pm.getNextPageNo() %>";
	}
	
	function bottomPage() {
		window.self.location = "myclient.jsp?pageNo=<%=pm.getBottomPageNo() %>";
	}
	

	

</script>
	</head>

	<body class="body1">
		<form name="userform" id="userform">
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
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�ͻ�����&gt;&gt;�ҵĿͻ�����</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
			<table width="130%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">�ͻ�����</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="130%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" width="5%">
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6">
						�ͻ�����
					</td>
					<td class="rd6">
						���Ȳ���
					</td>
					<td class="rd6">
						�ͻ�����
					</td>
					<td class="rd6">
						��Ҫ��
					</td>
					<td class="rd6">
						�ͻ�������Ϣ
					</td>
					<td class="rd6">
						����������Ϣ
					</td>
					<td class="rd6">
						�ɹ�����
					</td>
					<td class="rd6">
						��Ŀ��Ϣ
					</td>
					<td class="rd6">
						ѯ�۽׶�
					</td>
					<td class="rd6">
						���۲���
					</td>
					<td class="rd6">
						���۽��
					</td>
					<td class="rd6">
						���ۻ�ǩ���
					</td>
					<!--<td class="rd6">
						��Ʒ��Ϣ
					</td>
					<td class="rd6">
						����֧������
					</td>
					<td class="rd6">
						֧Ʊ����
					</td>
					<td class="rd6">
						����֤��
					</td>-->
					<td class="rd6">
						����̶�
					</td>
					<!--<td class="rd6">
						��ע
					</td>
					<td class="rd6">
						����
					</td>
										
				--></tr>
				
				<%
				
				
					List<ClientSalesStatusForm> list = pm.getList();
					for(int i=0;i<list.size();i++) {
						ClientSalesStatusForm clientSalesStatus = list.get(i);
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=clientSalesStatus.getId()%>">
					</td>
					<td class="rd8">
						<a href="addclientstatus.jsp?clientid=<%=clientSalesStatus.getClientid() %>"><%=clientSalesStatus.getClientName()%></a>
					</td>
					<td class="rd8">
						<a href="addclientsalesstatus.jsp?clientid=<%=clientSalesStatus.getClientid() %>">�ſ�</a>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getClientType()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getNature()==null?"":clientSalesStatus.getNature()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getBasicInfor()==null?"":clientSalesStatus.getBasicInfor() %>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getRivalInfor()==null?"":clientSalesStatus.getRivalInfor()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getProcureFlow()==null?"":clientSalesStatus.getProcureFlow()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getProjectInfor()==null?"":clientSalesStatus.getProjectInfor()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getInquirYstage()==null?"":clientSalesStatus.getInquirYstage()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getSalesStrategy()==null?"":clientSalesStatus.getSalesStrategy()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getTotalPrice()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getSignBackPrice()%>
					</td>
					
					<!--<td class="rd8">
						<%=clientSalesStatus.getSampleInfor()==null?"":clientSalesStatus.getSampleInfor()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getPartPayment()==null?"":clientSalesStatus.getPartPayment()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getInvoice()==null?"":clientSalesStatus.getInvoice()%>
					</td>
					<td class="rd8">
						<%=clientSalesStatus.getCertificate()==null?"":clientSalesStatus.getCertificate()%>
					</td>
					
					<td class="rd8" clientSalesStatus.getRemark()==null?"":clientSalesStatus.getRemark()>
					</td>
					<td class="rd8">
						
						
					</td>
				-->
				<td class="rd8">
					<%=clientSalesStatus.getSatisFaction()==null?"":clientSalesStatus.getSatisFaction()%>
				</td>
				</tr>
				<%
					}
				 %>
				
			</table>
			<table width="130%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;��&nbsp; <%=pm.getTotalPages() %> &nbsp;ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">��ǰ��</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="��ҳ"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="��ҳ"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="��ҳ" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
								onClick="bottomPage()">
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="���" onClick="addUser()">
							<!--<input name="btnDelete" class="button1" type="button"
								id="btnDelete" value="ɾ��" onClick="deleteUser()">
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸�" onClick="modifyUser()">
						--></div>
					</td>
				</tr>
			</table>
			
		</form>
		
	</body>
</html>
