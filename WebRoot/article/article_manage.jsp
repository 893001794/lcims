<%@page import="com.lccert.crm.dao.impl.ArticleDaoImpl"%>
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
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Depot"%>
 <%@ include file="../comman.jsp"  %>
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
	
	//String command = request.getParameter("command");
	//if (command != null && "search".equals(command)) {
		//pid = request.getParameter("pid");
		//pm =DaoFactory.getInstance().getDepotDao().searchAllDepot(pageNo,pageSize);
	//} else {
		pm =DaoFactory.getInstance().getDepotDao().searchAllDepot(pageNo,pageSize);
	//}
	
	
	
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>管理化学项目</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
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
	
	function printproject(){
	var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要打印数据的数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能打印一条数据！");
			return;
		}
	//alert(document.getElementsByName("selectFlag")[j].value);
		window.self.location = "printarticle.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
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
	//alert(document.getElementsByName("selectFlag")[j].value);
		window.self.location = "modifyarticle.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
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
		//alert(document.getElementsByName("selectFlag")[i].value);
				action = "article_post.jsp?status=del&id="+document.getElementsByName("selectFlag")[i].value;
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
		window.self.location = "article_manage.jsp?pageNo=1&pid=<%=pid%>";
	}
	
	function previousPage() {
		window.self.location = "article_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=pid%>";
	}	
	
	function nextPage() {
		window.self.location = "article_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&status=<%=status%>";
	}
	
	function bottomPage() {
		window.self.location = "article_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=pid%>";
	}
	
function showdialog(url,name,iWidth,iHeight)
{
var url; //转向网页的地址;
var name; //网页名称，可为空;
var iWidth; //弹出窗口的宽度;
var iHeight; //弹出窗口的高度;
var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
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
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>物品管理&gt;&gt;管理物品</b>
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
						        $("#pid").autocomplete("../pid_ajax.jsp",{
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
			</table>
			</form>
			
			
			
			
			<hr width="100%" align="center" size=0>
			<form name="userForm" id="userForm">
			<input name="pid" type="hidden" value="<%=pid %>" />
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">查询列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right">&nbsp;&nbsp;|&nbsp;&nbsp;<a href="article.jsp">添加物品列表</a></div>
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
						资产编号
					</td>
					<td class="rd6" >
						物品名称
					</td>
					<td class="rd6" >
						物品金额
					</td>
					<td class="rd6" >
						数量
					</td>
					<td class="rd6" >
						使用年限
					</td>
					<td class="rd6" width="6%" >
						经费来源
					</td>
					<td class="rd6" >
						发票
					</td>
					
					<td class="rd6" >
						供应商
					</td>
					
				</tr>
				
				<%
				List<Depot> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Depot depot = list.get(i);
				 %>
				
				<tr>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=depot.getId()%>">
					</td>
					<td class="rd8">
						<%=depot.getDid() %>
					</td>
					<td class="rd8">
						<%=DaoFactory.getInstance().getArticleDao().getNameById(depot.getAid()) %>
					</td>
					<td class="rd8">
						<%=depot.getPrice() %>
					</td>
					<td class="rd8">
						<%=depot.getNumber()%>
					</td>
					<td class="rd8">
						<%=depot.getUserdate() %>
					</td>
					<td class="rd8">
						<%=depot.getFundstype()%>
					</td>
					<td class="rd8">
						<%=depot.getInvoicecode()%>/<%=depot.getInvoiceno() %>
					</td>
					<td>
						<%=depot.getClient() %>
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
								id="btnModify" value="修改项目" onClick="modifyproject();">
								
								<input name="btnPrint" class="button1" type="button"
								id="btnPrint" value="打印" onClick="printproject();">
							<%
						if(user.getTicketid().matches("11111111")|| user.getId()==169) {
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
