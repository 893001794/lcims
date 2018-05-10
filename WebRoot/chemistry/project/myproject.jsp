<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
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
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,pid,rid,status,"");
	} else {
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"","","","");
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
	
	function modifyproject(obj) {
		var count = 0;
		var j = 0;
		var sid;
		var rid;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			
			if (document.getElementsByName("selectFlag")[i].checked) {
				var thisString=document.getElementsByName("selectFlag")[i].value;
				sid = thisString.substring(0,thisString.lastIndexOf('/'));
				rid =thisString.substring(thisString.lastIndexOf('/')+1,thisString.length);
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
		if(obj=="sid"){
		window.self.location = "modifyproject.jsp?sid=" +sid;
		}else{
		//window.self.location = "../../sample/b.jsp?rid=" +rid;
		window.open ("../../sample/b.jsp?rid=" +rid, "newwindow", "height=200, width=600, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no") //写成一行 

		//window.showModalDialog("../../sample/b.jsp?rid=" +rid, "newwin", "dialogHeight=100px, dialogWidth=100px,toolbar=no,menubar=no");//弹出子窗口，并且获取中只窗口的值
		}
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
		window.self.location = "myproject.jsp?command=search&pageNo=1&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function previousPage() {
		window.self.location = "myproject.jsp?command=search&pageNo=<%=pm.getPreviousPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}	
	
	function nextPage() {
		window.self.location = "myproject.jsp?command=search&pageNo=<%=pm.getNextPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function bottomPage() {
		window.self.location = "myproject.jsp?command=search&pageNo=<%=pm.getBottomPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
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
							<b>化学项目管理&gt;&gt;管理化学项目</b>
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
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">&nbsp;&nbsp;&nbsp;项目状态：&nbsp;&nbsp;&nbsp;</font>
							<select name="status" style="width: 300px" onchange="changeStatus()">
								<option value="">
									全部
								</option>
								<option value="1">
									立项
								</option>
								<option value="2">
									排单
								</option>
								<option value="3">
									流转单
								</option>
								<option value="4">
									测试
								</option>
								<option value="5">
									测试完成
								</option>
								<option value="6">
									重测
								</option>
								<option value="9">
									结案
								</option>
								<option value="10">
									发证
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("status").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.indexOf("<%=status%>")==0 && "<%=status%>".indexOf(ops[i].value) == 0){
										ops[i].selected = true;	
									}
								}
						</script>
					</td>
				</tr>

			</table>
			</form>
			
			
			
			
			<hr width="100%" align="center" size=0>
			<form name="userForm" id="userForm">
			<input name="pid" type="hidden" value="<%=pid %>" />
			<input name="rid" type="hidden" value="<%=rid %>" />
			<table width="1400" height="20" border="0" align="center"
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
			<table width="1400" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						 报价单号
					</td>
					<td class="rd6" >
						项目编号
					</td>
					<td class="rd6" >
						报告编号
					</td>
					<td class="rd6" >
						化妆品编号
					</td>
					<td class="rd6" >
						项目类型
					</td>
					<td class="rd6" >
						报告类型
					</td>
					<td class="rd6" width="6%" >
						样品的类型
					</td>
					<td class="rd6" >
						应出报告时间
					</td>
					
					<td class="rd6" >
						项目等级
					</td>
					<td class="rd6" >
						状态
					</td>
					
					<td class="rd6">
						操作
					</td>
				</tr>
				
				<%
				List<Project> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					ChemProject cp = (ChemProject)p.getObj();
				 %>
				
				<tr>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid()%>/<%=p.getRid()%>">
					</td>
					<td class="rd8">
						<%=p.getPid() %>
					</td>
					<td class="rd8">
						<%=p.getSid() %>
					</td>
					<td class="rd8">
						<a href="projectdetail.jsp?sid=<%=p.getSid()%>"><%=p.getRid()==null?"":p.getRid()  %></a>
					</td>
					<td class="rd8">
						<%=p.getFilingNo()==null?"":p.getFilingNo()  %>
					</td>
					<td class="rd8">
						<%=p.getPtype()==null?"":p.getPtype() %>
					</td>
					<td class="rd8">
						<%=cp.getRptype()==null?"":cp.getRptype() %>
					</td>
					<td class="rd8">
						<%=cp.getItem()==null?"":cp.getItem() %>
					</td>
					<td class="rd8">
						<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>
					
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<%=cp.getStatus() %>
					</td>
					<td class="rd8">
					<%
					if(!("排单".equals(cp.getStatus()) || "".equals(cp.getStatus()))) {
					 %>
						[<a href="../flow/myflows.jsp?sid=<%=p.getSid() %>">流转单</a>]
					<%
					}
					 %>
					 [<a href="javascript:showdialog('<%=p.getSid() %>');">进度</a>]
					 [<a href="../dynamicproject.jsp?sid=<%=p.getSid() %>">补样/换样</a>]
					 [<a href="javascript:showproject('<%=p.getSid() %>');">报告发出方式</a>]
					 
					<%
					if(!"取消".equals(cp.getStatus()) && "admin".equals(user.getUserid())) {
					 %>
					 
					 [<a href="javascript:cancelproject('<%=p.getSid() %>');">取消项目</a>]
					 
					<%
					}
					 %>
					</td>			
				</tr>
				
				<%
				}
				 %>
				
			</table>
			<table width="1400" height="30" border="0" align="center"
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
								id="btnModify" value="修改项目" onClick="modifyproject('sid')">
								<input name="btnModify" class="button1" type="button"
								id="btnModify" value="打印标签" onClick="modifyproject('rid')">
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
