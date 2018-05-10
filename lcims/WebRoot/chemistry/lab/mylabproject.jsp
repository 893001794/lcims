<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
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
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String rid = "";
	String command = request.getParameter("command");
	//if (command != null && "search".equals(command)) {
	//	rid = request.getParameter("rid");
	//	System.out.println("进来了");
	//	pm = ChemProjectAction.getInstance().searchLabProjects(pageNo,pageSize,rid);
	//} else {
	//pm = ChemProjectAction.getInstance().searchLabProjects(pageNo,pageSize,"");
	//}
	
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	String pid = request.getParameter("pid");
	if(pid != null && !"".equals(pid)) {
		pid = new String(pid.getBytes("iso-8859-1"),"GBK"); 
	} else {
		pid = "";
	}
	String pName = request.getParameter("pName");
	if(pName != null && !"".equals(pName)) {
		pName = new String(pName.getBytes("iso-8859-1"),"GBK"); 
	} else {
		pName = "";
	}
	//判断公司名称
	String start = request.getParameter("start");
	if(start != null && !"".equals(start)) {
		start = new String(start.getBytes("iso-8859-1"),"GBK"); 
	} else {
		start = "";
	}
	
	String type = request.getParameter("type");
	if(type!= null && !"".equals(type)) {
	type = new String(type.getBytes("iso-8859-1"),"GBK"); 
	}else{
	type = "";
	}
	String status = request.getParameter("status");
	if(status!= null && !"".equals(status)) {
	status = new String(status.getBytes("iso-8859-1"),"GBK"); 
	}else{
		status = "";
	}
	pm = ChemProjectAction.getInstance().searchLabProjects(pageNo,pageSize,pid,pName,type,status,start);
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>实验室管理</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	function showdialog(sid) {
		window.showModalDialog("../projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
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
		window.self.location = "mylabproject.jsp?pageNo=1&command=<%=command%>&rid=<%=rid%>&pName=<%=pName%>&type=<%=type%>&status=<%=status%>&start=<%=start%>";
	}
	
	function previousPage() {
		window.self.location = "mylabproject.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&rid=<%=rid%>&pName=<%=pName%>&type=<%=type%>&status=<%=status%>&start=<%=start%>";
	}	
	
	function nextPage() {
		window.self.location = "mylabproject.jsp?pageNo=<%=pm.getNextPageNo()%>&command=<%=command%>&rid=<%=rid%>&pName=<%=pName%>&type=<%=type%>&status=<%=status%>&start=<%=start%>";
	}
	
	function bottomPage() {
		window.self.location = "mylabproject.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=<%=command%>&rid=<%=rid%>&pName=<%=pName%>&type=<%=type%>&status=<%=status%>&start=<%=start%>";
	}
	



function showReport(rid) {
		
		//跳到另外一个项目
	//window.open("http://192.168.0.7:8080/report/synthesis?sid=" + sid);
	//window.open("http://127.0.0.1:8080/report/patch?rid=" + rid);
	window.open("http://report.lccert.com:1234/report/patch?rid=" + rid);
	}
	//下载功能
	function showDownReport(rid) {
	 //window.open("http://192.168.0.7:8080/report/synthesis?type=no&sid=" + sid);
	 window.open("http://127.0.0.1:8080/report/patch?type=no&rid=" + rid);
	 //window.open("http://report.lccert.com:1234/report/patch?type=no&rid=" + rid);
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
							<b>化学实验室管理&gt;&gt;管理项目</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search method="post" action="mylabproject.jsp" autocomplete="off">
			<table width="95%" border="0" cellpadding="0" cellspacing="0" align="center" class=TableBorder>
		    <tr height="22" valign="middle" class="rd6"> 
		      <th width="20%" height="25">报告单号</th>
		      <th width="15%">项目名称 </th>
		      <th width="25%">项目完成状态</th>
		      <th width="25%">项目状态</th>
		      <th width="25%">操作</th>
		    
    </tr>
    	 <tr height="22" valign="middle" align="center" class="rd8"> 
	      <td>
	      <input type="hidden" name="command" value="search">
	     <input id="pid" type="text" name="pid" size="20" />
	      		<script>   
					 $("#pid").autocomplete("../../vrid_ajax.jsp",{
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
	      
	      <td>
	      <input type="text" size="20" id="pName" type="text" name="pName" >
	      	<script>   
					 $("#pName").autocomplete("../../projectName_ajax.jsp",{
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
		
      
      <td>
      		<select name="status" id="status" style="width: 100px" >
								<option value="">
									全部
								</option>
								<option value="测试中">
									测试中
								</option>
								<option value="测试完成">
									测试完成
								</option>
								
							</select>
					<script type="text/javascript">
						var ops2 = document.getElementById("status").options;
						for(var i=0;i<ops2.length;i++) {
							if(ops2[i].value.indexOf("<%=status%>")==0 && "<%=status%>".indexOf(ops2[i].value) == 0){
								ops2[i].selected = true;
							}
						}
					</script>
			  </td>
		      <td>
		      		<select name="type" id="type" style="width: 100px">
								<option value="">
									全部
								</option>
								<option value="散单">
									散单
								</option>
								<option value="食品">
									食品
								</option>
								<option value="成品">
									成品
								</option>
								
							</select>
							<script type="text/javascript">
									var ops2 = document.getElementById("type").options;
									for(var i=0;i<ops2.length;i++) {
									if(ops2[i].value.indexOf("<%=type%>")==0 && "<%=type%>".indexOf(ops2[i].value) == 0){
										ops2[i].selected = true;	
									}
								}
						</script>
		       </td>
		       
		       <td><input type=submit name=Submit value=搜索></td>
				<td><input type="hidden" name=type size="25" value="all" /></td>
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
						报告编号
					</td>
					<td class="rd6" >
						化妆品号
					</td>
					<td class="rd6" >
						项目类型
					</td>
					<td class="rd6" >
						报告类型
					</td>
					<td class="rd6" >
						应出报告时间
					</td>
					
					<td class="rd6" >
						项目等级
					</td>
					<td class="rd6">
						项目工程师
					</td>
					<td class="rd6" >
						项目工分
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
							value="<%=p.getSid() %>">
					</td>
					<td class="rd8">
						<a href="javascript:showdialog('<%=p.getSid()%>');"><%=p.getRid()==null?"":p.getRid()  %></a>
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
						<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>
					
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<%=cp.getEngineer()==null?"":cp.getEngineer() %>
					</td>
					<td class="rd8">
						<%=cp.getWorkpoint()==null?"":cp.getWorkpoint() %>
					</td>
					<td class="rd8">
						<%=cp.getStatus() %>
					</td>
					<td class="rd8">
					<%
					if(!("排单".equals(cp.getStatus()) || "".equals(cp.getStatus()))) {
					 %>
						[<a href="labflow.jsp?rid=<%=p.getRid() %>">流转单</a>]
					<%
					}
					 %>
					[<a href="labmodify.jsp?sid=<%=p.getSid() %>">分配工程师</a>]
					
					[<a href="javascript:showReport('<%=p.getRid() %>')">补样</a>]
					[<a href="javascript:showDownReport('<%=p.getRid() %>')">下载补样</a>]
					
					<%
					if("n".equals(cp.getIschecked()) && cp.getEngineer() != null) {
					 %>
					[<a href="checkingfinish.jsp?sid=<%=p.getSid() %>">初检完成</a>]
					<%} %>
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
														
						</div>
					</td>
				</tr>
			</table>
			
		
	</body>
</html>
