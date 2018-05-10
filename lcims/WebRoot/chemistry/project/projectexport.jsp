<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>

<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	List<Project> list = new ArrayList<Project>();
	if (command != null && "search".equals(command)) {
		String pid = request.getParameter("pid");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String status = request.getParameter("status");
		list = ProjectAction.getInstance().getExportProjects(pid,start,end,status);
	}
	
	session.setAttribute("projects",list);
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>添加流转单</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
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
		window.self.location = "projectlist.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "projectlist.jsp?pageNo=";
	}	
	
	function nextPage() {
		window.self.location = "projectlist.jsp?pageNo=";
	}
	
	function bottomPage() {
		window.self.location = "projectlist.jsp?pageNo=";
	}
	
	


</script>

<script type="text/javascript">
	function exportproject() {
		if(confirm("确定导出?")) {
			window.self.location = "../../export";
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
						<b>化学项目管理&gt;&gt;项目报表管理</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>




			<form name="form1" method="post" action="projectexport.jsp?command=search">
  <table width="98%" border="0" cellpadding="0" cellspacing="0" align="center" class=TableBorder>
    <tr height="22" valign="middle" class="rd6"> 
      <th width="20%" height="25">报价单号</th>
      <th width="25%">开始时间</th>
      <th width="15%">结束时间 </th>
      <th width="25%">项目状态</th>
      <th width="13%">&nbsp;</th>
    
    </tr>
    <tr height="22" valign="middle" align="center" class="rd8"> 
      <td><input name=pid type="text" id="pid" size="20" maxlength="50" value=""></td>
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
      <td>
      	<input name="start" type="text" id="start" size="20" maxlength="50" value="">
      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',el:'start'})" 
      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      
      <td>
      	<input name="end" type="text" id="end" size="20" maxlength="50" value="">
      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',el:'end'})" 
      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	  </td>
      <td>
      	全部<input name="status" type="radio" id="status"  value="all" checked/>
      	完成<input name="status" type="radio" id="status"  value="yes" />
      	未完成<input name="status" type="radio" id="status"  value="no" />
      </td>
      <td><input type="submit" name="Submit" value="提交">
        <input type="reset" name="Submit2" value="重置">
       </td>
    </tr>
  </table>
</form>


			<hr width="100%" align="center" size=0>
		</div>
		
		<div align="center">
			<input name="export" value="导出项目到Excel文档" type="button" onclick="exportproject();"/>
		</div>
		
		
		<form name="userform" id="userform">

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
					<td class="rd6">
						<input type="checkbox" name="ifAll" id="ifAll"
							onClick="checkAll()">
					</td>
					<td class="rd6">
						报价单编号
					</td>
					<td class="rd6">
						客户
					</td>
					<td class="rd6">
						报告编号
					</td>
					<td class="rd6">
						测试项目
					</td>
					<td class="rd6">
						项目类型
					</td>
					<td class="rd6">
						报告类型
					</td>
					<td class="rd6">
						立项时间
					</td>
					<td class="rd6">
						报告应出时间
					</td>
					<td class="rd6">
						销售
					</td>
					<td class="rd6">
						项目等级
					</td>
					<td class="rd6">
						状态
					</td>
					
				</tr>

				<%
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						String rptype = "";
						String rptime = "";
						String status = "";
						if("化学测试".equals(p.getPtype())||"化妆品".equals(p.getPtype())) {
							ChemProject cp = (ChemProject)p.getObj();
							rptype = cp.getRptype();
							rptime = cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime());
							status = cp.getStatus();
						} else {
							PhyProject pp = (PhyProject)p.getObj();
							status = pp.getStatus();
						}
						Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				 %>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getRid() %>">
					</td>
					<td class="rd8">
						<a href="../../quotation/detail.jsp?pid=<%=p.getPid() %>"><%=p.getPid() %></a>
					</td>
					<td class="rd8">
						<%=qt.getClient() %>
					</td>
					<td class="rd8">
						<a href="projectdetail.jsp?sid=<%=p.getSid() %>"><%=p.getRid() %></a>
					</td>
					<td class="rd8">
						<%=p.getTestcontent() %>
					</td>
					<td class="rd8">
						<%=p.getPtype() %>
					</td>
					<td class="rd8">
						<%=rptype %>
					</td>
					<td class="rd8">
						<%=qt.getCreatetime() %>
					</td>
					<td class="rd8">
						<%=rptime %>
					</td>
					<td class="rd8">
						<%=qt.getSales() %>
					</td>
					<td class="rd8">
						<%=p.getLevel() %>
					</td>
					<td class="rd8">
						<%=status %>
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
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp; &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">当前第</font>&nbsp;
							<font color="#FF0000" size="2pt"></font>&nbsp;
							<font color="#FFFFFF" size="2pt">页</font>
						</div>
					</td>
					
				</tr>
			</table>

		</form>

	</body>
</html>
