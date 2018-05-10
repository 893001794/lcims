<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	List<Project> list = new ArrayList<Project>();
	Quotation qt = null;
	String pid = null;
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid").trim();
		if(!(pid == null || "".equals(pid))) {
			list = ProjectAction.getInstance().getAllProjectByPid(pid);
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
		}
	}
	
	if(qt == null) {
		qt = new Quotation();
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>项目管理</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script type="text/javascript">
	
	function buildproject() {
		
		window.self.location = "buildproject.jsp?command=search&pid=<%=pid%>";	
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
			alert("请选择需要修改的用户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条用户数据！");
			return;
		}
	
		window.self.location = "modifyquotation.jsp?pid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteUser() {
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
				action = "quotationlist.jsp?command=delete"
				submit();
			}
		}
	}
	
		

	function showdialog(rid) {
		window.showModalDialog("../chemistry/projectstatus.jsp?rid=" + rid,"","dialogWidth:900px;dialogHeight:700px");
	}
	


</script>

	</head>

	<body class="body1">

		

		<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">报价单编号</font>
				</td>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">客户名称</font>
			</tr>
			<tr align="center">
				<td class="rd8"><%=qt.getPid()==null?"":qt.getPid() %></td>
				<%
					ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
					if(client == null) client = new ClientForm();
				%>
				<td class="rd8"><a href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient()==null?"":qt.getClient() %></a></td>
			</tr>
		</table>
		<p>
			&nbsp;
		</p>

		<form name="userform" id="userform">
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">项目列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6">
						<input type="checkbox" name="ifAll" id="ifAll"
							onClick="checkAll()">
					</td>
					<td class="rd6">
						报告编号
					</td>
					<td class="rd6">
						项目类型
					</td>
					<td class="rd6">
						测试项目
					</td>
					<td class="rd6">
						报告类型
					</td>
					<td class="rd6">
						报告应出时间
					</td>

					<td class="rd6">
						项目等级
					</td>
					<td class="rd6">
						项目进度
					</td>
				</tr>

				<%
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						String rptype = "";
						String rptime = "";
						if(!"化学测试".equals(p.getPtype())) {
							PhyProject pp = (PhyProject)p.getObj();
						} else {
							ChemProject cp = (ChemProject)p.getObj();
							rptype = cp.getRptype();
							if(cp.getRptime() != null) {
								rptime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime());
							}
						}
				 %>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="">
					</td>

					<td class="rd8">
						<a href="../chemistry/project/projectdetail.jsp?sid=<%=p.getSid() %>"><%=p.getRid() %></a>
					</td>
					<td class="rd8">
						<%=p.getPtype() %>
					</td>
					<td class="rd8">
						<%=p.getTestcontent() %>
					</td>
					<td class="rd8">
						<%=rptype %>
					</td>
					<td class="rd8">
						<%=rptime %>

					</td>
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<a href="javascript:showdialog('<%=p.getRid() %>');">查看</a>
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
					<td nowrap class="rd19" height="2">
						
					</td>
					
				</tr>
			</table>

		</form>
		<div align="center">
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="关闭" onClick="window.close();"
>
						</div>
	</body>
</html>
