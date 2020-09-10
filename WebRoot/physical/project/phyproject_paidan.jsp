<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
 <%@ page errorPage="../../../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	List<Project> list = new ArrayList<Project>();
	Quotation qt = new Quotation();
	String pid = null;
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid").trim();
		if(!(pid == null || "".equals(pid))) {
			list = PhyProjectAction.getInstance().getPhyProjectByPid(pid,"排单");
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
		}
	} else {
		list = PhyProjectAction.getInstance().getPhyProjectByPid("","排单");
	}
	

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>安规项目排单</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />
		<link rel="stylesheet" href="../../css/jquery.tablesorter.pager.css" type="text/css" />
		<link rel="stylesheet" href="../../images/blue/style.css" type="text/css" media="print, projection, screen" />   
		<script type="text/javascript" src="../../javascript/jquery.js"></script>
		<script type="text/javascript" src="../../javascript/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript" src="../../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../../javascript/jquery.tablesorter.pager.js"></script>
		<script type="text/javascript">
		$(function() {
		   $("#myTable")
		    .tablesorter({widthFixed: true})
		    .tablesorterPager({container: $("#pager")});
		});
	function buildproject() {
		
		window.self.location = "buildphyproject.jsp?command=search&pid=<%=pid%>";	
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
	function goBack() {
		window.history.back();
	}	

	function showdialog(rid) {
		vReturnValue = window.showModalDialog("../../chemistry/projectstatus.jsp?rid=" + rid,"","dialogWidth:1300px;dialogHeight:800px");
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
						<b>安规项目管理&gt;&gt;排单</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>


			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=phyproject_paidan.jsp?command=search autocomplete="off">
							<font color="red">请输入报价单号：</font>
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=搜索>
							<script>   
						        $("#pid").autocomplete("../../pid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>   
							<input type="hidden" name=type size="25" value="all" />

						</form>
					</td>
				</tr>

			</table>

			<hr width="100%" align="center" size=0>
		</div>

		<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">报价单编号</font>
				</td>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">客户名称</font>
			</tr>
			<%if(qt !=null){%>
			<tr align="center">
				<td class="rd8"><%=qt.getPid()==null?"":qt.getPid() %></td>
				<%
						ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
						if(client == null) client = new ClientForm();
				%>
				<td class="rd8"><a href="../../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient()==null?"":qt.getClient() %></a></td>
			</tr>
			<%}%>
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
			<table cellspacing="1" class="tablesorter" id="myTable">
			<thead>
				<tr>
					<th >
						<input type="checkbox" name="ifAll" id="ifAll"
							onClick="checkAll()">
					</th >
					<th >
						报价单号
					</th >
					<th >
						项目编号
					</th >
					<th >
						项目类型
					</th >
					<th >
						状态
					</td>
					<th >
						排单
					</th >
				</tr>
			</thead>
	<tbody>
				<%
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						PhyProject cp = (PhyProject)p.getObj();
				 %>

				<tr>
					<td>
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="">
					</td>
					<td>
						<%=p.getPid() %>
					</td>
					<td>
						<%=p.getSid() %>
					</td>
					<td>
						<%=p.getPtype() %>
					</td>

					<td >
						<%=cp.getStatus() %>
					</td>
					
					<%if(cp.getRptime()==null) { %>
					
					<td>
						<a href="buildphyproject.jsp?command=search&sid=<%=p.getSid() %>">排单</a>
					</td>
					<%} %>
				</tr>

				<%
				}
				}
				 %>
</tbody>

			</table>
			<br>
			<table width="100%" height="138" border="0" align="right"
				cellpadding="0" cellspacing="0">
				<tr>
					<td nowrap class="rd19">
						<div id="pager" class="pager" align="right">
						<form>
						   <img src="../../images/first.png" width="16" height="16" class="first"/>
						   <img src="../../images/prev.png" width="16" height="16" class="prev"/>
						   <input type="text" class="pagedisplay"/>
						   <img src="../../images/next.png" width="16" height="16" class="next"/>
						   <img src="../../images/last.png" width="16" height="16" class="last"/>
						   <select class="pagesize">
						    <option selected="selected" value="10">10</option>
						    <option value="20">20</option>
						    <option value="30">30</option>
						    <option value="40">40</option>
						   </select>
						</form>
					</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
