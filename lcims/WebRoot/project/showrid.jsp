<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	List<Project> list = new ArrayList<Project>();
	
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		String pid = request.getParameter("pid");
		list = ChemProjectAction.getInstance().getChemProjectByPid(pid,"");
	}
	
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>关联项目</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	
	function update() {
		var obj = document.getElementsByName("selectFlag");
		var j = 0;
		for (var i = 0; i < obj.length; i++) {
			if (obj[i].checked) {
				j = i;
			}
		}
		window.opener.document.getElementById("rid").value = obj[j].value;
		window.close();
	}
	

		
</script>
	</head>

	<body class="body1" scroll="yes">
		
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
							<b>分解项目&gt;&gt;关联项目</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<table width=95% border=0 cellspacing=5 cellpadding=5 >
				<tr>
					<td width=50%>
						<form name=search method="post"
							action="showrid.jsp" autocomplete="off">
							<font color="red">请输入报价单号：</font>
							<input type="hidden" name="command" value="search">
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=搜索>
							 <script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
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
							<input type="hidden" name=type size="25" value="all" />

						</form>
					</td>
				</tr>

			</table>
			<hr width="100%" align="center" size=0>
			<form name="userform" id="userform">
			
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" >
						选择
					</td>
					<td class="rd6" >
						报告编号
					</td>
					<td class="rd6" >
						项目类型
					</td>
					<td class="rd6" >
						报告类型
					</td>
					<td class="rd6" >
						应完成时间
					</td>
					
					<td class="rd6" >
						项目等级
					</td>
					<td class="rd6" >
						状态
					</td>
					
				</tr>
				
				<%
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					ChemProject cp = (ChemProject)p.getObj(); 
				 %>
				
				<tr>
				
				<tr>
					<td class="rd8">
						<input type="radio" name="selectFlag" id="selectFlag" class="checkbox1"
							value="<%=p.getRid() %>">
					</td>
					
					<td class="rd8">
						<a href="projectdetail.jsp?rid=<%=p.getRid() %>"><%=p.getRid() %></a>
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
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<%=cp.getStatus() %>
					</td>
							
				</tr>
				
				<%
				}
				 %>
				
			</table>
		</form>
		
		<div align="center">
			<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="确定" onClick="update();" />
								&nbsp;&nbsp;&nbsp;
			<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="关闭" onClick="window.close();" />
						</div>
	</body>
</html>
