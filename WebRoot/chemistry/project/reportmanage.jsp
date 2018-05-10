<%@page import="com.lccert.crm.dao.DaoFactory"%>
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
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@ include file="../../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String parttype="";
	String worktype="";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	String command = request.getParameter("command");
	if(request.getParameter("rid") !=null){
	rid= request.getParameter("rid").trim();
	}
	boolean flag =false;
	//调用此方法
	if(request.getParameter("worktype")!=null){
	//添加t_chem_project的填充时间/填充人/审核时间/审核人
	worktype=request.getParameter("worktype").trim() ;
		if(worktype.equals("ynucompletin")){//填数
		flag=DaoFactory.getInstance().getChemProjectDao().upStatus("填数",rid);
		}else if (worktype.equals("yconfirm")){ //审核
		flag=DaoFactory.getInstance().getChemProjectDao().upStatus("审核",rid);
		}
		//System.out.println(flag+":flag");
	
	ChemProjectAction.getInstance().upChemProjectStatus(worktype,user.getName(),rid);
	pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"","","","");
	}else{
	if (command != null && "search".equals(command)) {
	if(request.getParameter("parttype") !=null){
		parttype= request.getParameter("parttype").trim();
		}
	//	System.out.println("获取复选框的值:"+parttype);
		pid = request.getParameter("pid").trim();
		rid = request.getParameter("rid").trim();
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,pid,rid,parttype,"");
	} else {
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"","","","");
	}
	}
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>化学报告管理</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
		
	function cancelproject(sid) {
		if(confirm("确定取消项目?")) {
			window.self.location = "cancelproject.jsp?sid=" + sid;
		}
	}
	
	function showImg(sid) {
		window.showModalDialog("../../project/report/searchImages.jsp?sid=" + sid);
	}
	
	function isountDialog(obj){
	window.self.location="isoutproject.jsp?sid="+obj;
	}
	
	function submitNumber(obj,rid){
	var myform =document.getElementById("search");
	//myform.action="../../fileCopy?worktype="+obj+"&rid="+rid;
	myform.action="reportmanage.jsp?worktype="+obj+"&rid="+rid;
	myform.submit();
	}
	
	
	
	function showReport(sid,userid) {
		//跳到另外一个项目
		//window.open("http://192.168.0.28:8080/report/synthesis?sid=" + sid+"&userid="+userid);
		window.open("http://192.168.0.7:1234/report/synthesis?sid=" + sid+"&userid="+userid);
	}
	function showComAppReport(sid,userid) {
		//跳到另外一个项目
		//window.open("http://192.168.0.28:8080/report/comAppReport?sid=" + sid+"&userid="+userid);
		window.open("http://192.168.0.7:1234/report/comAppReport?sid=" + sid+"&userid="+userid);
	}
	function receiptNotice(sid,userid) {
		//跳到另外一个项目
		window.open("http://192.168.0.7:1234/report/receiptNotice?sid=" + sid+"&userid="+userid);
	  	//window.open("http://192.168.0.28:8080/report/receiptNotice?sid=" + sid+"&userid="+userid);
	}
	//下载功能
	function showDownReport(sid,userid) {
		//window.open("http://192.168.0.28:8080/report/synthesis?type=no&sid=" + sid+"&userid="+userid);
		window.open("http://192.168.0.7:1234/report/synthesis?type=no&sid=" + sid+"&userid="+userid);
		
	}
	function uploadImage(sid) {
		window.open("../../project/report/uploadImages.jsp?sid=" + sid);
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
		window.self.location = "reportmanage.jsp?pageNo=1&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>&parttype=<%=parttype%>";
	}
	
	function previousPage() {
		window.self.location = "reportmanage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>&parttype=<%=parttype%>";
	}	
	
	function nextPage() {
		window.self.location = "reportmanage.jsp?pageNo=<%=pm.getNextPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>&parttype=<%=parttype%>";
	}
	
	function bottomPage() {
		window.self.location = "reportmanage.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=<%=command%>&pid=<%=pid%>&rid=<%=rid%>&parttype=<%=parttype%>";
	}
	


</script>
	</head>

	<body class="body1">
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
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
							<b>化学项目管理&gt;&gt;化学报告管理</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search method="post" id="search"
							action="reportmanage.jsp" autocomplete="off">
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
				<%
				if(user.getId()==101 || user.getId()==97 ||user.getId()==121 ||user.getId()==133 || user.getId()==103){
				 %>
				 <tr>
            	<td>
            	<div id="mydiv">
            	
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="ynucompletin" <%=parttype.equals("ynucompletin")?"checked":"" %> />&nbsp;完成未填数&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);" value="yconfirm" <%=parttype.equals("yconfirm")?"checked":"" %>/>&nbsp;完成未审核&nbsp;
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
						         var search=document.getElementById("search");
						         search.action ="reportmanage.jsp";
						         search.submit();
						     }   
						 </script>
						 	
            	</td>
            </tr>
<%
}
 %>
			</table>
			</form>
			
			<hr width="100%" align="center" size=0>
			
			<table width="100%" height="20" border="0" align="center"
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
			<table width="100%" border="1" cellspacing="0" cellpadding="0"
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
						防伪码
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
						报告填数时间/人
					</td>
					<td class="rd6" >
						报告审核时间/人
					</td>
					<td class="rd6" >
						项目等级
					</td>
					<td class="rd6" >
						状态
					</td>
					<td class="rd6" width="11%">
						操作
					</td>
				</tr>
				
				<%
				List<Project> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					ChemProject cp = (ChemProject)p.getObj();
					String  security =p.getObjf().toString()+"";
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
						<%=security%>
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
						<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>
					
					
					<td class="rd8">
					<%=cp.getNucopletintime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getNucopletintime()) %>/<%=cp.getNucopletinuser()==null?"":cp.getNucopletinuser() %>
					</td>
					
				<td class="rd8">
					<%=cp.getRpconfirmtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRpconfirmtime()) %>/<%=cp.getRpconfirmuser()==null?"":cp.getRpconfirmuser() %>
					</td>
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<%=cp.getStatus() %>
					</td>
					<td class="rd8">
					<%-- 
						[<a href="../../project/report/uploadImages.jsp?sid=<%=p.getSid() %>">上传图片</a>]
					 	[<a href="javascript:showImg('<%=p.getSid() %>')">查看图片</a>]
					 --%>
					 
					 	<%
					 	if(user.getId() !=121 && user.getId() !=133 && user.getId()!=114){
					 		if(cp.getRptype() !=null && cp.getRptype().equals("双语报告")){
					 	
					 	%>
					 	
					 	[<a href="javascript:showReport('<%=p.getSid() %>','<%=user.getId() %>')">中文</a>]
					 	[<a href="javascript:showDownReport('<%=p.getSid() %>','<%=user.getId() %>')">英文</a>]
					 	
					 	<%
						 	}else if(cp.getFilingNo() !=null && cp.getFilingNo().indexOf("GDGF")>-1){
						 	%>
						 		[<a href="javascript:showComAppReport('<%=p.getSid() %>','<%=user.getId() %>')">生成模板</a>]
						 		[<a href="javascript:receiptNotice('<%=p.getSid() %>','<%=user.getId() %>')">受理通知</a>]
						 	<%
						 	}else{
						 	%>
						 		[<a href="javascript:showReport('<%=p.getSid() %>','<%=user.getId() %>')">生成模板</a>]
						 	<%
						 	}
						 	if(p.getIsout().equals("y")){
						 	%>
						 	
						 		[<a href="javascript:isountDialog('<%=p.getSid()%>')">外包</a>]
						 	<%
						 	}
						 	if(cp.getNucopletintime()==null&& user.getYnucompletin().equals("y")){
						 	%>
						 		<br><input type="button" onclick="submitNumber('ynucompletin','<%=p.getRid() %>');" value="填数">
							 	<%
							 	}
						 	
					 	}
					 	 if(cp.getRpconfirmtime()==null  && user.getYconfirm().equals("y")){
					 	 %>
					 	<input type="button" onclick="submitNumber('yconfirm','<%=p.getRid() %>');" value="审核">
					 	<%
					 	}
					 	 %> 
					</td>
				</tr>
				
				<%
				}
				 %>
				
			</table>
			<table width="100%" height="30" border="0" align="center"
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
