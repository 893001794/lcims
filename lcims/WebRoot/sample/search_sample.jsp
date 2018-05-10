<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
 <%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	//获取字段名
	List temp =new ArrayList();
	temp.add("s.id");
	temp.add("s.vsno");
	temp.add("s.vsid");
	temp.add("s.vsampleName");
	temp.add("s.vmodel");
	temp.add("s.vspeichorot");
	temp.add("s.voperator");
	temp.add("s.dcreatetime");
	temp.add("sp.vclient");
	String command=request.getParameter("command");
	List rows =null;
	if(command !=null){
	String pid =request.getParameter("pid");
	String sno =request.getParameter("sno");
	String client =request.getParameter("client");
	if(pid !=null && !"".equals(pid)){
		rows=DaoFactory.getInstance().getSimpleDao().getSampleByPid(temp,pid,"",null);
	}else if(sno !=null && !"".equals(sno)){
		rows=DaoFactory.getInstance().getSimpleDao().getSampleByPid(temp,"",sno,null);
	}else if(client !=null && !"".equals(client)){
		rows=DaoFactory.getInstance().getSimpleDao().getSampleByPid(temp,"",null,client);
	}
	}
	else{
		rows =DaoFactory.getInstance().getSimpleDao().getSample(temp);
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>管理样品</title>
		<link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
		<script type="text/javascript" src="../javascript/jquery-1.3.2.js"></script> 
		<script type="text/javascript" src="../javascript/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
		<script type="text/javascript">
		$(function() {
			   $("#myTable")
			    .tablesorter({widthFixed: true})
			    .tablesorterPager({container: $("#pager")});
			});
			
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
	   window.self.location = "modifySample.jsp?&id=" + document.getElementsByName("selectFlag")[j].value;
	}

function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	
	function modify(){
		var str="";
			for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
					if (document.getElementsByName("selectFlag")[i].checked) {
						str+=document.getElementsByName("selectFlag")[i].value+";";
					}
				}
					 window.self.location = "modifySample.jsp?id="+str;
		}

	function sampleStatus(obj){
		var str="";
			for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
					if (document.getElementsByName("selectFlag")[i].checked) {
						str+=document.getElementsByName("selectFlag")[i].value+";";
					}
				}
				//alert(str);
				window.showModalDialog("outbound.jsp?id="+str+"&status="+obj.value,"","dialogWidth:700px;dialogHeight:500px");
					// window.self.location = "outbound.jsp?id="+str+"&status="+obj.value;
	
	}		
	
	function printlabel(){
	var str="";
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
				if (document.getElementsByName("selectFlag")[i].checked) {
					str+=document.getElementsByName("selectFlag")[i].value+";";
				}
			}
			 window.self.location = "label.jsp?&id="+str;
	}
	
	function showdialog(sno) {
		window.showModalDialog("samplestatus.jsp?sno=" + sno,"","dialogWidth:900px;dialogHeight:500px");
	}
	
	function outdialog(sno){
	window.showModalDialog("outbound.jsp?sno=" + sno,"","dialogWidth:700px;dialogHeight:500px");
	}
</script>
	</head>

	<body>
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>&nbsp; 
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>样品管理&gt;&gt;查看样品</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="search_sample.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">请输入报告编号：</font>
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
						
							<font color="red">请输入样品编号：</font>
							<input id="sno" type="text" name="sno" size="40"  />
							<input type=submit name=Submit value=搜索>
					</td>
				</tr>
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">请输入客户名称：</font>
							<input id="client" type="text" name="client" size="40"  />
							<input type=submit name=Submit value=搜索>
					</td>
				</tr>
			</table>
			</form>
			<hr width="100%" align="right" size=0>
			<form name="userForm" id="userForm">
			
			
			<table cellspacing="1" class="tablesorter" id="myTable">
   
    	<thead>
		<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<th >
						 样品编号
					</th >
					
					<th >
						 样品名称
					</th >
					<th >
						 样品型号
					</th >
					<th >
						 项目编号
					</th >
					<th>
						送样客户
					</th>
					<th >
						存放位置
					</th >
					<th >
						增样人
					</th >
					<th >
						追样时间
					</th >

		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12">&nbsp;</th>
			

		</tr>
	</tfoot>
	<tbody>
		
		<%
				for(int i=0;i<rows.size();i++) {
					List columns = (List)rows.get(i);
					
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=columns.get(0)%>">
							
					</td>
					<td >
							<%=columns.get(1)%>
					</td>
					
					<td >
							<%=columns.get(3)%>
					</td>
					<td>
							<%=columns.get(4)%>
					</td>
					<td>
						<%=columns.get(2)%>
					</td>
					<td>
						<%=columns.get(8)%>
					</td>
					<td>
						<%=columns.get(5)%>
					</td>
					<td>
						<%=columns.get(6) %>
					</td>
					<td>
					[<a href="javascript:showdialog('<%=columns.get(1) %>');">明细</a>]
					</td>
					
		</tr>
				 <%
				 }
				  %>
	
</table>

	<hr width="100%" align="center" size=0>
	<br>
	<br>
	<br>
	<br>
			<table width="100%" height="138" border="0" align="right"
				cellpadding="0" cellspacing="0">
				<tr>
					<td nowrap class="rd19">
						<div id="pager" class="pager" align="right">
						<form>
						   <img src="../images/first.png" width="16" height="16" class="first"/>
						   <img src="../images/prev.png" width="16" height="16" class="prev"/>
						   <input type="text" class="pagedisplay"/>
						   <img src="../images/next.png" width="16" height="16" class="next"/>
						   <img src="../images/last.png" width="16" height="16" class="last"/>
						   <select class="pagesize">
						    <option selected="selected" value="10">10</option>
						    <option value="20">20</option>
						    <option value="30">30</option>
						    <option value="40">40</option>
						   </select>
						   <select onchange="sampleStatus(this);">
						   	<option value="入库">入库</option>
						   	<option value="出库">出库</option>
						   	<option value="寄出">寄出</option>
						   	<option value="退样">退样</option>
						   	<option></option>
						   </select>		
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改项目" onClick="modify()">
							&nbsp;
							<%
							//if(user.getTicketid().matches("\\d\\d\\d\\d1\\d\\d\\d")) {
					%>							
						<!-- 	<input name="btnModify" class="button1" type="button"
							id="btnModify" value="删除" onClick="deleteProject()"> -->
					<%
					//	}
					 %>
					 <input name="btnprint" class="button1" type="button"
								id="btnprint" value="打印标签" onClick="printlabel();">
						</form>
					</div>
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>