<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	String eitem="";
	if(user.getDept().equals("化学工程部")){
	eitem="成品";
	}
	String command = request.getParameter("command");
	List<Project> list = null;
	Quotation qt = null;
	if (command != null && "search".equals(command)) {
		String type = request.getParameter("type");
		String keywords = request.getParameter("keywords");
		String rid =request.getParameter("rid");
		if(rid !=null && !"".equals(rid)){
		keywords=ProjectChemImpl.getInstance().getPidByRid(rid);
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"",rid,"",eitem);
			qt = QuotationAction.getInstance().getQuotationByPid(keywords);
		}
		else if(!(keywords == null || "".equals(keywords))) {
			pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,keywords,"","",eitem);
			qt = QuotationAction.getInstance().getQuotationByPid(keywords);
		}
	} else {
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"","","",eitem);
	}
	
	list = pm.getList();
	
	if(qt == null) {
		qt = new Quotation();
	}
	

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>添加流转单</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	
	
	
	function modifyflow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要添加流转单的项目！");
			return;
		}
		if (count > 1) {
			alert("一次只能选择一个项目！");
			return;
		}
	
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?rid=" + document.getElementsByName("selectFlag")[j].value;
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
		window.self.location = "searchproject.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "searchproject.jsp?pageNo=<%=pm.getPreviousPageNo()%>";
	}	
	
	function nextPage() {
		window.self.location = "searchproject.jsp?pageNo=<%=pm.getNextPageNo()%>";
	}
	
	function bottomPage() {
		window.self.location = "searchproject.jsp?pageNo=<%=pm.getBottomPageNo()%>";
	}
	
	function buil(){
		var flag =false;
		var result="";
		var check = document.getElementsByName("selectFlag");
		for(var i=0;i<check.length;i++){
		if(check[i].checked==true){
			flag =true;
			result+=check[i].value+",";
		}
	    }
	    if(flag == false){
	   		alert("请选择要排的单！！！");
	   	}else{
	   		window.self.location="../flow/addflow.jsp?command=search&type=batch&sid="+result;
	   		
	   	}
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
						<b>化学项目管理&gt;&gt;添加流转单</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>



	<form name=search method=post action=searchproject.jsp?command=search autocomplete="off">
			<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 13em">
					<tr>
						<td valign=middle width=50%>
					
							<font color="red">请输入报价单号：</font>
							<input id="keywords" type="text" name="keywords" size="40" />
							<input type=submit name=Submit value=搜索>
							<script>   
						        $("#keywords").autocomplete("../../pid_ajax.jsp",{
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
							<input type="hidden" name=type size="25" value="pid" />
							
							
							
						
						</td>
					</tr>
					
					
					
					<tr>
						<td valign=middle width=50%>
					
							<font color="red">请输入报告编号：</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=搜索>
							 <script>   
						        $("#rid").autocomplete("../../vrid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
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
		</div>
		
		<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="2pt" style="font-weight: bolder">报价单编号</font>
				</td>
				<td width="49%" class="rd6">
					<font size="2pt" style="font-weight: bolder">客户名称</font>
			</tr>
			<tr align="center">
				<td class="rd8"><%=qt.getPid()==null?"":qt.getPid()%></td>
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
						<font color="#FFFFFF" size="2pt">查询列表</font>
					<td width="27%" nowrap class="rd16">
						<div align="right"><input type="button" onclick="buil();" value="批量增加">
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
						报价单编号
					</td>
					<td class="rd6">
						报告编号
					</td>
					<td class="rd6" >
						化妆品编号
					</td>
					<td class="rd6">
						项目类型
					</td>
					<td class="rd6">
						报告类型
					</td>
					<td class="rd6">
						应完成时间
					</td>
					<td class="rd6">
						项目等级
					</td>
					<td class="rd6">
						状态
					</td>
					<td class="rd6">
						流转单列表
					</td>
				</tr>

				<%
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						ChemProject cp = (ChemProject)p.getObj();
				 %>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid()%>/<%=p.getRid()%>">
					</td>
					<td class="rd8">
						<a href="../../quotation/detail.jsp?pid=<%=p.getPid() %>"><%=p.getPid() %></a>
					</td>
					<td class="rd8">
						<a href="projectdetail.jsp?sid=<%=p.getSid() %>"><%=p.getRid() %></a>
					</td>
					<td class="rd8">
						<%=p.getFilingNo()==null?"":p.getFilingNo()  %>
					</td>
					<td class="rd8">
						<%=p.getPtype() %>
					</td>
					<td class="rd8">
						<%=cp.getRptype() %>
					</td>
					<td class="rd8">
						<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>

					<td class="rd8">
						<%=p.getLevel() %>
					</td>
					<td class="rd8">
						<%=cp.getStatus() %>
					</td>
					<td class="rd8">
					<%if(!(user.getId()==231||user.getId()==114||user.getId()==77)){
					%>
					[<a href="../flow/addflow.jsp?type=null&sid=<%=p.getSid()%>,">添加</a>]&nbsp;
					<%
					}%>
					[<a href="../flow/flow_manage.jsp?sid=<%=p.getSid() %>">查看</a>]
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
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp;<%=pm.getTotalPages() %> &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
						</div>
					</td>
				</tr>
			</table>

		</form>

	</body>
</html>
