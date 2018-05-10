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
	PageModel pm = ClientAction.getInstance().getClients(pageNo,pageSize,salesid);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>我的客户列表</title>
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
			alert("请选择需要修改的客户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条客户数据！");
			return;
		}
	
		window.self.location = "modifyclient.jsp?clientid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteUser() {
		alert("暂时没有此功能！");
		return;
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("请选择需要删除的用户数据！");
			return;
		}
		if (window.confirm("是否确认删除选中的数据？")) {
			//执行删除
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
							<b>客户管理&gt;&gt;我的客户</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">客户列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
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
						客户编号
					</td>
					<td class="rd6">
						客户密码
					</td>
					<td class="rd6">
						客户名称
					</td>
					<td class="rd6">
						负责销售
					</td>
					<td class="rd6">
						电话
					</td>
					<td class="rd6">
						电子邮箱
					</td>
					<td class="rd6">
						联系人
					</td>
										
				</tr>
				
				<%
					List<ClientForm> list = pm.getList();
					for(int i=0;i<list.size();i++) {
						ClientForm client = list.get(i);
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=client.getClientid() %>">
					</td>
					<td class="rd8">
						<a href="clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=client.getClientid() %></a>
					</td>
					<td class="rd8">
						<%=client.getPassword() %>
					</td>
					<td class="rd8">
						<%=client.getName() %>
					</td>
					<td class="rd8">
						<%=UserAction.getInstance().getNameById(client.getSalesid()) %>
					</td>
					<td class="rd8">
						<%=client.getContact().getTel()%>
					</td>
					<td class="rd8">
						<%=client.getContact().getEmail() %>
					</td>
					
					<td class="rd8">
						<%=client.getContact().getContact() %>
					</td>
							
				</tr>
				
				<%
					}
				 %>
				
			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp; <%=pm.getTotalPages() %> &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">当前第</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">页</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="首页"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="上页"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="下页" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="尾页"
								onClick="bottomPage()">
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="添加" onClick="addUser()">
							<input name="btnDelete" class="button1" type="button"
								id="btnDelete" value="删除" onClick="deleteUser()">
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改" onClick="modifyUser()">
						</div>
					</td>
				</tr>
			</table>
			
		</form>
		
	</body>
</html>
