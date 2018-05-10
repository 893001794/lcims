<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	//关联旧的报价单号
	String condition1="";
	if(request.getParameter("condition1") !=null){
		condition1=request.getParameter("condition1");
	}
	String step="";
	if(request.getParameter("step") !=null){
		step=request.getParameter("step");
	}
	String followstate="";
	if(request.getParameter("followstate") !=null){
		followstate=request.getParameter("followstate");
	}

	String status= request.getParameter("status");
	String restart= "";
	String condition2="";
	String tracking="";
	String client="";
	String custom="";
	String content="";
	String start="";
	String end="";
	
	if(request.getParameter("restart") !=null &&!"".equals(request.getParameter("restart"))){
		restart=request.getParameter("restart");
		condition2= request.getParameter("condition2");
		start= request.getParameter("start");
		end= request.getParameter("end");
		
	}
		if(request.getParameter("tracking") !=null){
			tracking= request.getParameter("tracking");
		}
		if(request.getParameter("client") !=null){
			client= request.getParameter("client");
		}
		if(request.getParameter("custom") !=null){
				custom= request.getParameter("custom");
		}
		if(request.getParameter("content") !=null){
			content= request.getParameter("content");
		}
	if(status==null && condition1 !=null){
		condition1=new String (condition1.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && step !=null){
		step=new String (step.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && followstate !=null){
		followstate=new String (followstate.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && condition2 !=null){
		condition2=new String (condition2.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && tracking !=null){
		tracking=new String (tracking.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && client !=null){
		client=new String (client.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && custom !=null){
		custom=new String (custom.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && content !=null){
		content=new String (content.getBytes("ISO8859-1"),"GBK");
	}
	int pageNo = 1;
	int pageSize = 25;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	//判断是否为销售人员
	String ctsName = request.getParameter("ctsName");
	PageModel pm=new SearchFactory().getVOLClient().getVOLInfor(pageNo,pageSize,followstate,step,condition1,condition2,start,end,tracking,client,custom,content,ctsName);
	List rows =(List)pm.getList();
	//System.out.println(rows.size()+"--------------");
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>后勤管理</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
.hid {
	display: none;
}
</style>
	<script type="text/javascript">
	function topPage() {
		window.self.location = "VOLClient.jsp?pageNo=1&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}
	
	function previousPage() {
		window.self.location = "VOLClient.jsp?pageNo=<%=pm.getPreviousPageNo()%>&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}	
	
	function nextPage() {
		window.self.location = "VOLClient.jsp?pageNo=<%=pm.getNextPageNo()%>&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}
	
	function bottomPage() {
		window.self.location = "VOLClient.jsp?pageNo=<%=pm.getBottomPageNo()%>&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}
	
	function checkForm(){
		document.getElementById("condition1").value="按条件查询";
		var radio=document.getElementById("restart");
		var condition2=document.getElementById("condition2").value;
		var start=document.getElementById("start").value;
		var end=document.getElementById("end").value;
		if(radio.checked==true){
			if(condition2 !="未联系"){
				if((start ==null || start =="")&&(end ==null || end =="")){
					alert("请输入'从'xxx'到'xxx时间值");
					return false;
				}
			}
		}
		
		var myform=document.getElementById("quotationform");
		myform.submit();
	}
	
	function addcon(obj) {
		var str="";
		var url="";
		if(obj == "add"){
			str="添加"
			url="contact_manage.html";
		}else if(obj == "mod"){
			str="修改"	
		}else if(obj == "dele"){
			str="删除";
		}
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要"+str+"的联系记录！");
			return;
		}
		if (count > 1) {
			alert("一次只能选择一条记录！");
			return;
		}
		var custId = document.getElementsByName("selectFlag")[j].value;
			window.self.location = url+"?custId=" + custId;
	}
	</script>
	</head>

	<body>
		<form method="post" name="quotationform" id="quotationform" action="VOLClient.jsp?status=seach&&ctsName=<%=ctsName%>">
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
						<b>客户跟踪平台&gt;&gt;客户跟踪</b></em>
					</td>
				</tr>
			</table>
		
			<hr width="97%" align="center" size=0>
			<div>
			<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
				<tr>
					<td width="70%">
					客户进度：<select name ="step" id="step" onchange="condition(this.value);">
						<option value="" selected="selected">全部</option>
						<option value="成交" <%=step.equals("成交")?"selected":"" %>>成交客户</option>
						<option value="潜在" <%=step.equals("潜在")?"selected":"" %>>潜在客户</option>
					</select>&nbsp;&nbsp;
					<select name ="condition1" id="condition1" onchange="condition(this.value);">
						<option value="" selected="selected">全部</option>
						<option value="今天要回访" <%=condition1.equals("今天要回访")?"selected":"" %>>今天要回访</option>
						<option value="近5天要回访" <%=condition1.equals("近5天要回访")?"selected":"" %>>近5天要回访</option>
						<option value="已过回访日期" <%=condition1.equals("已过回访日期")?"selected":"" %>>已过回访日期</option>
						<option value="近5天已联系" <%=condition1.equals("近5天已联系")?"selected":"" %>>近5天已联系</option>
						<option value="按条件查询" <%=condition1.equals("按条件查询")?"selected":"" %>>按条件查询</option>
					</select>&nbsp;&nbsp;
					<script type="text/javascript">
						function condition(obj){
							if(obj != "按条件查询"){
								var myform=document.getElementById("quotationform");
								myform.submit();
							}
						}
					</script>
					<input type="checkbox"" value="y" name ="restart" id ="restart" <%=restart.equals("y")?"checked":""%>>
					<select name="condition2" id="condition2">
						<option value="回访日期" <%=condition2.equals("回访日期")?"selected":"" %>>回访日期</option>
						<option value="最近联系日期" <%=condition2.equals("最近联系日期")?"selected":"" %>>最近联系日期</option>
						<option value="创建日期" <%=condition2.equals("创建日期")?"selected":"" %>>创建日期</option>
						<option value="收集日期" <%=condition2.equals("收集日期")?"selected":"" %> >收集日期</option>
						<!--  <option value="未联系" <%=condition2.equals("未联系")?"selected":"" %>>未联系</option>-->
					</select>
					&nbsp;&nbsp;
					从:
						<input name="start" type="text" id="start" size="20" maxlength="50" value="<%=start%>">
				      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'start'})" 
				      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
					到：
						<input name="end" type="text" id="end" size="20" maxlength="50"value="<%=end%>">
				      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})" 
				      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
					&nbsp;&nbsp;
					跟踪进度：<select name ="tracking" id ="tracking">
						<option value="" selected="selected">---跟踪进度---</option>
						<option value="01 新建待跟" <%=tracking.equals("01 新建待跟")?"selected":"" %>>新建待跟</option>
						<option value="02 传真申请表格" <%=tracking.equals("02 传真申请表格")?"selected":"" %>>传真申请表格</option>
						<option value="03 上门拜访" <%=tracking.equals("03 上门拜访")?"selected":"" %>>上门拜访</option>
						<option value="04  关系联络" <%=tracking.equals("04  关系联络")?"selected":"" %>>关系联络</option>
						<option value="05 报价待确认" <%=tracking.equals("05 报价待确认")?"selected":"" %>>报价待确认</option>
					</select>
					
					客户:
						<input name="client" type="text" id="client" size="25" maxlength="50" value="<%=client%>">
				      	
					自定义项：<select name ="custom" id ="custom">
						<option value="" selected="selected">---自定义项---</option>
						<option value="地区" <%=custom.equals("地区")?"selected":"" %>>地区</option>
						<option value="地址" <%=custom.equals("地址")?"selected":"" %>>地址</option>
						<option value="电话" <%=custom.equals("电话")?"selected":"" %>>电话</option>
						<option value="传真" <%=custom.equals("传真")?"selected":"" %>>传真</option>
					</select>
					内容：
					<input name="content" type="text" id="content" size="30" maxlength="50" value="<%=content%>">
					&nbsp;
					跟随状态：<select name ="followstate" id="followstate" onchange="condition(this.value);">
						<option value="" selected="selected">全部</option>
						<option value="线索跟踪" <%=followstate.equals("线索跟踪")?"selected":"" %>>线索跟踪</option>
						<option value="商机跟踪" <%=followstate.equals("商机跟踪")?"selected":"" %>>商机跟踪</option>
					</select>&nbsp;&nbsp;
					<input type="button" onclick="checkForm();" value="提交" >
					</td>
				</tr>
			</table>
				<br>
				<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">CTS查询</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
					<tr>
				      <td class="rd6"  align="center" valign="middle" width="200px" style="width: 200px">客户全称</td>
				      <td class="rd6"  align="center" valign="middle">电话</td>
				      <td class="rd6"  align="center" valign="middle">客户简称</td>
				      <td class="rd6"  align="center" valign="middle">负责人</td>
				      <td class="rd6"  align="center" valign="middle">最近联系日期</td>
				      <td class="rd6"  align="center" valign="middle">回访日期</td>
				      <td class="rd6"  align="center" valign="middle">跟踪进度</td>
				      <td class="rd6"  align="center" valign="middle">地区</td>
				      <td class="rd6"  align="center" valign="middle">行业</td>
				      <td class="rd6"  align="center" valign="middle">正在跟踪人</td>
				      <td class="rd6"  align="center" valign="middle">客户关系</td>
    				</tr>
    				<%
    				for(int i=0;i<rows.size();i++){
    					List columns =(List)rows.get(i);
    					%>
    					<tr>
    					<%
    					for(int j=0;j<columns.size();j++){
    						if(j<columns.size()-2){
    							if(j==1){
    							%>
    							<td class="rd8">
									<a href="contact_manage.html?custId=<%=columns.get(0)%>"><%=columns.get(1)%></a>
								</td>
    							<%
    							}else if(j>1){
    							%>
    							<td class="rd8"><%=columns.get(j)%></td>
    							<%
    							}
	    					}
    					}
    					%>
    					</tr>
    					<%
    				}
    				 %>
				</table>
			</div>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt"><%=pm.getTotalRecords()%> 条记录</font>&nbsp;
							<font color="#FFFFFF" size="2pt">共&nbsp; <%=pm.getTotalPages() %> &nbsp;页</font>&nbsp;
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
