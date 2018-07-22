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
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.dao.impl.ChemProjectDaoImplMySql"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
 <%@ include file="../../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 20;
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String str =null;
	String pageNoStr = request.getParameter("pageNo");
	String startus=request.getParameter("startus");
	if(startus !=null){
	startus=new String(startus.getBytes("ISO-8859-1"),"GBK");
	//System.out.println(startus+"---------------");
	rid =request.getParameter("rid");
	String sid =request.getParameter("sid");
	
	//根据项目编号来查询流转单号
	List fidList =FlowAction.getInstance().getFlowBySid(sid);
	Flow flow=new Flow();
	boolean flag=false;
	if(fidList.size()>0){
	 flow=(Flow)fidList.get(0);
	 //更改项目状态
	flag=PhyProjectAction.getInstance().upPhyStart(startus,rid,sid,flow.getFid(),2);
	}else{
	out.print("<script type='text/javascript'>");
	out.print("alert('该项目还没有进入实验室，请客服人员添加流转单，才能操作！！！！！')");
	out.print("</script");
	}
	
	
	}
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo=Integer.parseInt(pageNoStr);
	}
	
	String command=request.getParameter("command");
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid").trim();
		rid = request.getParameter("rid").trim();
		if(rid == null || "".equals(rid)) {
			pm = PhyProjectAction.getInstance().searchPhyProjects(pageNo,pageSize,pid,"pid");
		} else {
			pm=PhyProjectAction.getInstance().searchPhyProjects(pageNo,pageSize,rid,"rid");
		}
	} else {
		pm =PhyProjectAction.getInstance().searchPhyProjects(pageNo,pageSize,"","all");
	}
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>管理安规项目</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	function cancelproject(sid) {
		if(confirm("确定取消项目?")) {
			window.self.location = "cancelphyproject.jsp?sid=" + sid;
		}
	}
	
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
	
		window.self.location = "modifyphyproject.jsp?sid=" + document.getElementsByName("selectFlag")[j].value;
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
	//点击下拉框，更改项目的状态
	function changStartus(obj,pid,rid,sid){
	//获取下拉框被选中的值
	var startus=obj.value;
	var myform =document.getElementById("search");
	myform.action ="phyproject_manage.jsp?command=search&startus="+startus+"&pid="+pid+"&rid="+rid+"&sid="+sid;
	myform.submit();
	
	}
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}
	
	//批量更改更改项目的状态
	function changStatus(obj){
		//获取下拉框被选中的值
	   var startus=obj;
	   var sidStr="";
	   var checkNum=0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if(document.getElementsByName("selectFlag")[i].checked==true){
				sidStr+= document.getElementsByName("selectFlag")[i].value+",";
				checkNum++;
			}
		}
		if(checkNum==0){
			alert("请选择要批量更改状态项目！！！");
		}else{
			//先检查是否有值
			jQuery.ajax({
			url:"/lcims/ajaxClass", //跳转了路径
				data:"method=batchProjectStatus&sidStr="+sidStr+"&startus="+startus, //传输的值或参数
				type:'POST',
				synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
				success: function(data){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
					var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
				 	if(agent.attr('suc') == 'true'){ //得到名称为agent的xml对象里面suc元素，并且判断suc元素的值是否为true
					 	alert("批量修改状态成功");
						var myform =document.getElementById("search");
						myform.action ="phyproject_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
						myform.submit();
					}else{
						alert("批量修改状态失败，可能选中项目还没有进入实验室，请客服人员添加流转单，才能操作！");
						return false;
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){ 
					alert("XMLHttpRequest:"+XMLHttpRequest);
					alert("textStatus:"+textStatus);
					alert("errorThrown:"+errorThrown);
				}
			})
		}
		
	}
	
	
	function topPage() {
		window.self.location = "phyproject_manage.jsp?pageNo=1&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function previousPage() {
		window.self.location = "phyproject_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}	
	
	function nextPage() {
		window.self.location = "phyproject_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function bottomPage() {
		window.self.location = "phyproject_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function showReport(sid,rid) {
		//alert(rid);
		//跳到另外一个项目
	//window.open("http://192.168.0.7:8080/report/synthesis?sid=" + sid);
	  //window.open("http://127.0.0.1:8080/report/phyCE?sid="+sid+"&rid="+rid);
	  window.open("http://report.lccert.com:1234/report/phyCE?sid="+ sid+"&rid="+rid);
	//window.open("http://192.168.0.239:8080/report/synthesis?sid=" + sid+"&userid="+userid);
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
							<b>安规项目管理&gt;&gt;管理安规项目</b>
						</td>
					</tr>
				</table>
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search method="post"
							action="phyproject_manage.jsp" autocomplete="off">
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
			<div align="right" style="width: 97%;"  width="95%">
				<select onchange="changStatus(this.value);">
					 <%
					  int statusType =0;
						  if(user.getDept().equals("客服")){
							  statusType =1;
							  }else if(user.getDept().equals("电子电器")){
							  statusType =2;
							  }else{
							  statusType =0;
						  }
						 Map<String,String> startusList =PhyProjectAction.getInstance().getPhyStatusType(statusType);
						 for(String value:startusList.keySet()){
						 %>
						 <option value="<%=startusList.get(value)%>" ><%=startusList.get(value) %></option>
						 <%
						 }
				 %>
				</select>
			</div>
			<form name="userForm" id="userForm">
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
						 报价单号
					</td>
					<td class="rd6" >
						项目编号
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
						应出报告时间
					</td>
					
					<td class="rd6" >
						项目等级
					</td>
					<td class="rd6" >
						状态
					</td>
					<td class="rd6" >
						结案时间
					</td>
					<td class="rd6">
						操作
					</td>
				</tr>
				<%
				List<Project> list = pm.getList();
				String boxStr="";
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					PhyProject pp = (PhyProject)p.getObj();
					//根据sid
					List cltList=DaoFactory.getInstance().getChemProjectDao().getChemLabTime(p.getSid());
					str=pp.getStatus();
					if(cltList.size()>0){
					if(!str.equals("结案") && !str.equals("发证")){
					ChemLabTime clt=(ChemLabTime)cltList.get(0);
					str=clt.getStatus();
					boxStr="";
					}
					else if(str.equals("发证")){
					boxStr="disabled='disabled'" ;
					}
					}else{
					boxStr="";
					}
				 %>
				
				<tr>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid() %>">
					</td>
					<td class="rd8">
						<%=p.getPid() %>
					</td>
					<td class="rd8">
						<%=p.getSid() %>
					</td>
					<td class="rd8">
						<a href="phyprojectdetail.jsp?sid=<%=p.getSid()%>"><%=p.getRid()==null?"":p.getRid()  %></a>
					</td>
					<td class="rd8">
						<%=p.getPtype()==null?"":p.getPtype() %>
					</td>
					<td class="rd8">
						<%=pp.getRptype()==null?"":pp.getRptype() %>
					</td>
					<td class="rd8">
						<%=pp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(pp.getRptime()) %>
					</td>
					
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<%=str == null?pp.getStatus():str%>
					</td>
					<td class="rd8">
						&nbsp;<%=pp.getEndtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(pp.getEndtime()) %>
					</td>
					<td class="rd8">
					&nbsp;
					<%--
					if(!"取消".equals(pp.getStatus()) && "admin".equals(user.getUserid())) {
					 %>
					 
					 [<a href="javascript:cancelproject('<%=p.getSid() %>');">取消项目</a>]
					 
					<%
					}
					 --%>
					 
					
				
					 <select <%=boxStr%> onchange="changStartus(this,'<%=p.getPid()%>','<%=p.getRid()%>','<%=p.getSid()%>');">
					 
					  <%
					  int classId =0;
					  if(user.getDept().equals("客服")){
					  classId =1;
					  }else if(user.getDept().equals("电子电器")){
					  classId =2;
					  }else{
					  classId =0;
					  }
					  
					 Map<String,String> startusTypeList =PhyProjectAction.getInstance().getPhyStatusType(classId);
					 for(String value:startusTypeList.keySet()){
					 if(str == null){
					 str=pp.getStatus();
					 }
					 %>
					
					 <option value="<%=startusTypeList.get(value)%>" <%=startusTypeList.get(value).equals(str)?"selected":""%>><%=startusTypeList.get(value) %></option>
					 <%
					 }
					  %>
					 </select>

					 [<a href="javascript:showReport('<%=p.getSid()%>','<%=p.getRid()%>')">CE</a>]
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
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp; <%=pm.getTotalPages()%> &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">当前第</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo()%></font>&nbsp;
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
