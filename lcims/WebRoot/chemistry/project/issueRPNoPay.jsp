<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.text.SimpleDateFormat"%>


<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
 <%@ include file="../../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String status = "";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid");
		rid = request.getParameter("rid");
		status = request.getParameter("status");
		pm = ChemProjectAction.getInstance().searchIssueRPNoPay(pageNo,pageSize,pid,rid,"page");
	} else {
		pm = ChemProjectAction.getInstance().searchIssueRPNoPay(pageNo,pageSize,"","","page");
	}
	
	
	
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>管理化学项目</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
		
	function changeStatus() {
		with (document.getElementById("search")) {
			method = "post";
			action = "myproject.jsp";
			submit();
		}
	}
		
	function cancelproject(sid) {
		if(confirm("确定取消项目?")) {
			window.self.location = "cancelproject.jsp?sid=" + sid;
		}
	}
	
	function showdialog(sid) {
		window.showModalDialog("../projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}
	function showproject(sid) {
		window.showModalDialog("../projectismethod.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	function showflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/flow_manage.jsp";
	}
	
	function modifyproject() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要修改的数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条数据！");
			return;
		}
	
		window.self.location = "modifyproject.jsp?sid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function addflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?pid=";
	}
	
	function deleteProject() {
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
				action = "../../project/deleteproject.jsp";
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
		window.self.location = "issueRPNoPay.jsp?pageNo=1&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function previousPage() {
		window.self.location = "issueRPNoPay.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=pid%>&rid=<%=rid%>";
	}	
	
	function nextPage() {
		window.self.location = "issueRPNoPay.jsp?pageNo=<%=pm.getNextPageNo()%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function bottomPage() {
		window.self.location = "issueRPNoPay.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=pid%>&rid=<%=rid%>";
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
							<b>报告管理&gt;&gt;发出报告但未付款</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="myproject.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">请输入报价单号：</font>
							<input id="pid" type="text" name="pid" size="40"  />
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
					</td>
				</tr>
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">请输入报告编号：</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=搜索>
					</td>
				</tr>
			</table>
			</form>
			
			
			
			
			<hr width="100%" align="center" size=0>
			<form name="userForm" id="userForm">
			<input name="pid" type="hidden" value="<%=pid %>" />
			<input name="rid" type="hidden" value="<%=rid %>" />
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">查询列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					
					<td class="rd6" >
						 报价单号
					</td>
					<td class="rd6" >
						报告号
					</td>
					<td class="rd6" >
						销售人员
					</td>
					<td class="rd6" >
						付款方式
					</td>
					<td class="rd6" >
						是否付款
					</td>
					<td class="rd6" >
						报告发放时间
					</td>
					<td class="rd6" width="6%" >
						发放形式
					</td>
					<td class="rd6" >
						最迟汇款时间
					</td>
					
				</tr>
				
				<%
				List list = pm.getList();
				for(int i=0;i<list.size();i++) {
				
					ChemProject cp =(ChemProject)list.get(i);
					Quotation q= (Quotation)cp.getObj();
					//根据客户名称获取该客户的付款方式
					String pay="";
					//System.out.println(q.getClient()+"：客户名称");
					List temp =ClientAction.getInstance().getClientInMonth(q.getClient());
					if(temp.size()>0){
						for(int j=0;j<temp.size();j++){
						ClientForm cf =(ClientForm)temp.get(j);
						pay =cf.getPay();
						}
					}else{
					pay="现付";
					}
					
				 %>
				
				<tr>
				
				<tr>
					
					<td class="rd8">
						<%=cp.getPid() %>
					</td>
					<td class="rd8">
						<%=cp.getRid() %>
					</td>
					
					<td class="rd8">
						<%=q.getSales() %>
					</td>
					<td class="rd8">
						<%=pay %>
					</td>
				
					<td class="rd8">
						<%=q.getPaystatus()%>
					</td>
					<td class="rd8">
						<%=cp.getSendtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getSendtime()) %>
					</td>
					<td class="rd8">
						<%=cp.getIsmethod()==null?"":cp.getIsmethod() %>
					</td>
					<td class="rd8">
						<%=cp.getEndtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime()) %>
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
														
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改项目" onClick="modifyproject()">
							<%
						if(user.getTicketid().matches("11111111")) {
					%>
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="删除" onClick="deleteProject()">
					<%
						}
					 %>
						</div>
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>
