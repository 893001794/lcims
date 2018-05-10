<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
 <%@ include file="../../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = new PageModel();
	String pid = "";
	String rid = "";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid").trim();
		rid = request.getParameter("rid").trim();
		if(rid == null || "".equals(rid)) {
			pm = PhyProjectAction.getInstance().searchPhyProjects(pageNo,pageSize,pid,"pid");
		} else {
			pm = PhyProjectAction.getInstance().searchPhyProjects(pageNo,pageSize,rid,"rid");
		}
	} else {
		pm = PhyProjectAction.getInstance().searchPhyProjects(pageNo,pageSize,"","all");
	}
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>安规实验室管理</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	function begin(sid) {
		if(confirm("确定开始测试?")) {
			window.self.location = "updatestatus.jsp?sid=" + sid + "&istatus=4";
		}
	}
	
	function end(sid) {
		if(confirm("确定完成测试?")) {
			window.self.location = "updatestatus.jsp?sid=" + sid + "&istatus=5";
		}
	}
	
	function showdialog(sid) {
		window.showModalDialog("../projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	function showflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/flow_manage.jsp";
	}
	
	//function modifyproject() {
		///var count = 0;
		//var j = 0;
		//for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
		//	if (document.getElementsByName("selectFlag")[i].checked) {
		//		j = i;
		//		count ++;
		//	}
	//	}
		//if (count == 0) {
		//	alert("请选择需要修改的数据！");
		//	return;
		//}
	//	if (count > 1) {
	//		alert("一次只能修改一条数据！");
	//		return;
	//	}
	
	//	window.self.location = "modifyphyproject.jsp?sid=" + document.getElementsByName("selectFlag")[j].value;
	//}
	
	function addflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?pid=";
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
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	function topPage() {
		window.self.location = "phylab_manage.jsp?pageNo=1&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function previousPage() {
		window.self.location = "phylab_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}	
	
	function nextPage() {
		window.self.location = "phylab_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function bottomPage() {
		window.self.location = "phylab_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
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
							<b>电子电器管理&gt;&gt;管理实验室项目</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search method="post"
							action="phylab_manage.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
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
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						项目编号
					</td>
					<td class="rd6" >
						报告编号
					</td>
					<td class="rd6" >
						厂家名称
					</td>
					<td class="rd6" >
						 产品名
					</td>
					<td class="rd6" >
						产品型号
					</td>
					<td class="rd6" >
						开始时间
					</td>
					<td class="rd6" >
						结束时间
					</td>
					<td class="rd6" >
						检测状态
					</td>
					<td class="rd6">
						操作
					</td>
				</tr>
				
				<%
				List<Project> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					PhyProject pp = (PhyProject)p.getObj();
					Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				 %>
				
				<tr>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid() %>">
					</td>
					<td class="rd8">
						<%=p.getSid() %>
					</td>
					<td class="rd8">
						<a href="../project/phyprojectdetail.jsp?sid=<%=p.getSid()%>"><%=p.getRid()==null?"":p.getRid()  %></a>
					</td>
					<td class="rd8">
						<%=qt.getClient() %>
					</td>
					<td class="rd8">
						<%=pp.getSamplename() %>
					</td>
					<td class="rd8">
						<%=pp.getSamplemodel() %>
					</td>
					<td class="rd8">
						<%=pp.getBegintime()==null?"":pp.getBegintime() %>
					</td>
					<td class="rd8">
						<%=pp.getEndtime()==null?"":pp.getEndtime() %>
					</td>
					<td class="rd8">
						<%=pp.getStatus() %>
					</td>
					<td class="rd8">
					<%
					if(pp.getBegintime()==null) {
					 %>
					[<a href="../../chemistry/flow/addflow.jsp?ptype=phy&sid=<%=p.getSid()%>,">添加流转单</a>]&nbsp; 
					<%
					}
					if(pp.getBegintime() !=null && pp.getEndtime()==null) {
					 %>
					[<a href="javascript:end('<%=p.getSid() %>');">测试完成</a>]
					<%
					}
					 %>
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
														
							<!-- <input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改项目" onClick="modifyproject()">
								 -->
								
						</div>
					</td>
				</tr>
			</table>
			
		
	</body>
</html>
