<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="com.lccert.crm.vo.ProjectChem"%>
 <%@ include file="../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String status = "";
	String parttype="";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	if (request.getParameter("parttype") != null && !"".equals(request.getParameter("parttype"))) {
		parttype =request.getParameter("parttype");
	}
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid");
			pm = ProjectChemImpl.getInstance().searchProjectManarge(pageNo,pageSize,pid,rid,parttype,"food");
	} else {
		pm = ProjectChemImpl.getInstance().searchProjectManarge(pageNo,pageSize,"","",parttype,"food");
	}
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
	
function showdialog(sid) {
		window.showModalDialog("../chemistry/projectstatus.jsp?start=enginer&&sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
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
	   window.self.location = "addproject.jsp?up=update&&rid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function addflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?pid=";
	}
	
	function deleteProject() {
	
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count++;
			}
		}
		if (count>1) {
			alert("请选择需要删除的用户数据！");
			return;
		}
		if (window.confirm("是否确认删除选中的数据？")) {
			//执行删除
			with (document.getElementById("userForm")) {
				method = "post";
				action = "addprojec_post.jsp?start=del&&startype=food&&rid=" +document.getElementsByName("selectFlag")[j].value
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
		window.self.location = "product_manager.jsp?pageNo=1&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function previousPage() {
		window.self.location = "product_manager.jsp?pageNo=<%=pm.getPreviousPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}	
	
	function nextPage() {
		window.self.location = "product_manager.jsp?pageNo=<%=pm.getNextPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function bottomPage() {
		window.self.location = "product_manager.jsp?pageNo=<%=pm.getBottomPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
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
							<b>工程部管理&gt;&gt;食品管理</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="food_manager.jsp" autocomplete="off">
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
				<tr>
					<td valign=middle width=50%>
							<font color="red">请输入报告编号：</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=搜索>
					</td>
				</tr>			
   <tr>
            	<td>
            	<div id="mydiv">
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="projectName" <%=parttype.equals("projectName")?"checked":"" %> />&nbsp;项目排序&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="dcompletetime"  <%=parttype.equals("dcompletetime")?"checked":"" %> />&nbsp;应出报告排序&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="ridOrder" <%=parttype.equals("finish")?"checked":"" %>/>&nbsp;报告排序&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="NFinish" <%=parttype.equals("NFinish")?"checked":"" %>/>&nbsp;未完成&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);" value="Projectleader" <%=parttype.equals("Projectleader")?"checked":"" %>/>&nbsp;负责人排序&nbsp;
            		<input type=submit name=Submit value=提交>
            	</div>
            		 <script>   
	    
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else obj.children[i].checked = true;   
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
						 测试报告号
					</td>
					
					<td class="rd6" >
						 样品名称
					</td>
					<td class="rd6" >
						 测试项目
					</td>
					<td class="rd6" >
						排单时间
					</td>
					<td class="rd6" >
						应出报告的日期
					</td>
					<td class="rd6" >
						估计点数
					</td>
					<td class="rd6" >
						实际点数
					</td>
					<td class="rd6" >
						项目负责人
					</td>
					
					
					<td class="rd6" >
						项目签发人
					</td>
					<td class="rd6" >
						进度
					</td>
					<td class="rd6">
						进度时间
					</td>
				</tr>
				
				<%
				
				List<ProjectChem> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					ProjectChem p = list.get(i);
					if("报告审核完成".equals(p.getObject1())&& "".equals(rid)&& "".equals(pid)){
					
					
					}
					else{
					
				 %>
				<tr>
				
				<tr style="text-align: center;">
					<td class="rd8" >
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getRid()%>">
						
					</td>
					<td class="rd8">
							<%=p.getRid()%>
					</td>
					
					<td class="rd8" width="100px">
							<%=p.getSamplename()%>
					</td>
					<td class="rd8" width="200px">
							<%=p.getProjectcontent()%>
					</td>
					<td class="rd8">
						<%=p.getCreatetime() %>
					</td>
					<td class="rd8">
						<%=p.getCompletetime()%>
					</td>
					<td class="rd8">
						<%=p.getEstimate()==null?"":p.getEstimate() %>
					</td>
					<td class="rd8">
						<%=p.getItestcount()==null?"":p.getItestcount() %>
					</td>
					<td class="rd8">
						<%=p.getProjectleader()==null?"":p.getProjectleader() %>
					</td>
					<td class="rd8">
						<%=p.getProjectissuer()==null?"":p.getProjectissuer() %>
					</td>
					<td class="rd8">
					
					<%=p.getObject()%>
					</td>
					
					<td class="rd8">
					 [<a href="javascript:showdialog('<%=p.getSid()%>');">进度</a>]
					</td>			
				</tr>
				<%
				}
				}
				 %>
				
			</table>
			<table width="95%" height="138" border="0" align="center"
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
									<%
						if(user.getTicketid().matches("\\d\\d\\d\\d\\d\\d1\\d")) {
					%>							
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改项目" onClick="modifyproject()">
					<%
						}
					 %>
							&nbsp;
							<%
							if(user.getTicketid().matches("\\d\\d\\d\\d1\\d\\d\\d")) {
					%>							
							<input name="btnModify" class="button1" type="button"
							id="btnModify" value="删除" onClick="deleteProject()">
					<%
						}
					 %>
							
					
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>