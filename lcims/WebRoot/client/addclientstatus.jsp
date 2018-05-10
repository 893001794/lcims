<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientStatusForm"%>
<%@page import="com.lccert.crm.client.ClientRivalForm"%>
<%@page import="com.lccert.crm.client.ClientProjectForm"%>
<%@page import="com.lccert.crm.client.ClientProjectAction"%>
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
	String clientid = request.getParameter("clientid");
	ClientForm client=null;
	ClientProjectForm clientProject=null;
	if(clientid != null || !"".equals(clientid)) {
		client=ClientAction.getInstance().findById(clientid);
		clientProject=ClientProjectAction.getInstance().findClientProject(Integer.parseInt(clientid));
	}
	if(clientProject==null){
		clientProject=new ClientProjectForm();
	}
 %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>添加客户进度</title>
	<link rel="stylesheet" href="../css/drp.css">
	<link rel="stylesheet" href="../css/style.css">
	<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
	<script src="../javascript/jquery.js"></script>
	<script src="../javascript/jquery.autocomplete.min.js"></script>
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
	<script src="../javascript/Calendar.js"></script>
	<script type="text/javascript" src="../javascript/suggest.js"></script>
	<script src="../javascript/orderscript.js"></script>
	<script type="text/javascript">
		window.onload=function()
	    {//页面加载时的函数
	    	Change_Select();
	    	servinfo();
	    }
	    
	
	function addclientStatus(){
		var client=$("#client").val();
		var type=$("#type").val();;
		var sort=$("#sort").val();
		var procure=$("#procure").val();
		var projectround=$("#projectround").val();
		var projectamount=$("#projectamount").val();
		if(client == ""){
			alert("请输入客户名称！");
			return false;
		}else{
			jQuery.ajax({
				url:'validateclient.jsp?client='+ encodeURI(encodeURI(client)),
				type:'POST',
				synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
				success:function(msg){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
				if(msg.indexOf(true) >-1){
				}else{
				alert("客户不存在，请先输入客户资料！");
				window.open("../client/addclient.jsp");
				return false;
				}
				}
			})
		}
		if(type == ""){
			alert("请选择类型！");
			return false;
		}
		
		if(sort == ""){
			alert("请输入类别！");
			return false;
		}
		if(procure == ""){
			alert("请输入项目意向！");
			return false;
		}
		if(procure == ""){
			alert("请输入项目意向！");
			return false;
		}
		if(projectround == ""){
			alert("请输入项目周期！");
			return false;
		}
		if(projectamount == ""){
			alert("请输入采购金额！");
			return false;
		}else if(isNaN(projectamount)){
			alert("采购金额只能输入数字或数字与小数点组合！");
			return false;
		}
		with (document.getElementById("quotationform")) {
			method="post";
			action="addclientstatus_post.jsp";
			submit();
		}
	}
/*	var str = $("#visitnum").val();
			if(isNaN(str)){
				alert("拜访面谈次数为数字!!!");
				return(false);
			}*/
	//在计划里面添加新一行
	function addLastTr(){
		var trCount=$("#clientStatusTab").find("tr").length;
		var trStr="<tr>";
			trStr+="<td><div align='center'>"+trCount+"</div></td>";
		    trStr+="<td><div align='center'><input type='text' id='followupdate"+trCount+"' name='followupdate' size='35' style='width: 100%' onfocus='getCurDate(this);'></div></td>";
			trStr+="<td><div align='center'><input type='text' id='statuscas"+trCount+"' name='statuscas' size='30' style='width: 100%'></div></td>";
			trStr+="<td><div align='center'><input type='text' id='remark"+trCount+"' name='remark' size='20' style='width: 100%' ></div></td>";
			trStr+="<td><div align='center'><input type='text' id='register"+trCount+"' name='register' size='20' style='width: 100%' ></div></td>";
			trStr+"</tr>";	
			$("#clientStatusTab tr:last").after(trStr);		
	}
	//获取系统时间
	function getCurDate(obj){
		var d = new Date();
		var vYear = d.getFullYear();
		var vMon = d.getMonth() + 1;
		var vDay = d.getDate();
		$(obj).val(vYear+"-"+vMon+"-"+vDay);
	}
</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return addclientStatus(this)">&nbsp; 
			
			<input name="id" id="id" type="hidden" value="<%=clientProject.getId()%>" />
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>客户管理&gt;&gt;添加客户进度</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="90%" cellpadding="5" cellspacing="5">
					<tr>
						<td >
							客户名称：
						</td>
						<td width="33%">
							<input name="clientId" type="hidden"" id="clientId" size="40" value="<%=client.getClientid()%>"/>
							<input name="client" type="text" id="client" size="40" value="<%=client.getName()%>" readonly="readonly"
									style="background-color: #FFCC99"/>
						</td>
						<td>
							资本类型：
						</td>
						<td>
							<select name="type" id="type" style="width: 300px">
								<%
									if(clientProject.getType() !=null && !clientProject.getType().equals("")){
									%>
									<option value="1" <%=clientProject.getType().equals("1")?"selected":""%>>合资</option>
									<option value="2" <%=clientProject.getType().equals("2")?"selected":""%>>私营</option>
									<option value="3" <%=clientProject.getType().equals("3")?"selected":""%>>台资</option>
									<option value="4" <%=clientProject.getType().equals("4")?"selected":""%>>港资</option>
									<option value="5" <%=clientProject.getType().equals("5")?"selected":""%>>日资</option>
									<option value="6" <%=clientProject.getType().equals("6")?"selected":""%>>美资</option>
									<option value="7" <%=clientProject.getType().equals("7")?"selected":""%>>国营</option>
									<%
									}else{
									%>
									<option value="1" >合资</option>
									<option value="2" >私营</option>
									<option value="3" >台资</option>
									<option value="4" >港资</option>
									<option value="5" >日资</option>
									<option value="6" >美资</option>
									<option value="7" >国营</option>
									<%
									}
								 %>
								
							</select>
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >产品类别：</td>
						<td>
							<input type="text" size="40" id ="sort" name ="sort"  value="<%=clientProject.getSort()==null?"":clientProject.getSort()%>">  
						</td>
						<td >采购项目周期：</td>
						<td >
							<input type="text" size="40" id ="projectround" name ="projectround"  value="<%=clientProject.getProjectRound()==null?"":clientProject.getProjectRound()%>">
						</td>
						
					</tr>
					<tr  id ="trpid">
						<td >采购金额</td>
						<td >
							<input type="text" size="40" id ="projectamount" name ="projectamount"  value="<%=clientProject.getProjectAmount()==null?"":clientProject.getProjectAmount()%>">
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;</td>
					</tr>
					<tr  id ="trpid">
						<td >采购意向：</td>
						<td colspan="3">
							<textarea rows="3" cols="3" style="width: 800px" id="procure" name="procure"><%=clientProject.getProcure()==null?"":clientProject.getProcure() %></textarea>
						</td>
					</tr>
					
				</table>
			</div>
			<div class="outborder">
				<table width="100%" border="1">
					<tr>
						<td width="5%">
							<div align="center">
								行号
							</div>
						</td>
						<td width="30%">
							<div align="center">
								对手名称
							</div>
						</td>
						<td width="10%">
							<div align="center">
								对手排名
							</div>
						</td>
						<td width="10%">
							<div align="center">
								优势
							</div>
						</td>
						<td width="10%">
							<div align="center">
								劣势
							</div>
						</td>
						<td width="10%">
							<div align="center">
								机会点
							</div>
						</td>
						<td width="10%">
							<div align="center">
								报价方式
							</div>
						</td>
						<td width="5%" >
							<div align="center">
								周期
							</div>
						</td>
						
					</tr>
					<%
					List<ClientRivalForm> clientRivals=clientProject.getClientRivalList();
					for(int i=0;i<6;i++) {
						if(clientRivals !=null && clientRivals.size()>i){
							ClientRivalForm clientRival=clientRivals.get(i);
					 %>
					<tr>
						<td>
							<div align="center">
								<%=i+1%>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="hidden"" id="rivalid<%=i%>" name="rivalid" size="35" style="width: 100%" value="<%=clientRival.getId()%>">
								<input type="text" id="name<%=i%>" name="name" size="18" style="width: 100%" value="<%=clientRival.getName()==null?"":clientRival.getName()%>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="rank<%=i%>" name="rank" size="18" value="<%=clientRival.getRank()==null?"":clientRival.getRank()%>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="advantage<%=i%>" name="advantage" size="18" value="<%=clientRival.getAdvantage()==null?"":clientRival.getAdvantage()%>" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="inferior<%=i%>" name="inferior" size="18" value="<%=clientRival.getInferior()==null?"":clientRival.getInferior()%>">
							</div>
						</td>
						<td >
							<div align="center">
								<input type="text" id="chance<%=i%>" name="chance" size="13" value="<%=clientRival.getChance()==null?"":clientRival.getChance() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="methods<%=i%>" name="methods" size="13" value="<%=clientRival.getMethods()==null?"":clientRival.getMethods() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="period<%=i%>" name="period" size="13" value="<%=clientRival.getPeriod()==null?"":clientRival.getPeriod()%>">
							</div>
						</td>
					</tr>
					<%}else{
					%>
					<tr>
						<td>
							<div align="center">
								<%=i+1%>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="name<%=i%>" name="name" size="18" style="width: 100%">
							</div>
						</td>
						
						<td>
							<div align="center">
								<input type="text" id="rank<%=i%>" name="rank" size="18">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="advantage<%=i%>" name="advantage" size="18" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="inferior<%=i%>" name="inferior" size="18"
							</div>
						</td>
						<td >
							<div align="center">
								<input type="text" id="chance<%=i%>" name="chance" size="13" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="methods<%=i%>" name="methods" size="13" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="period<%=i%>" name="period" size="13" >
							</div>
						</td>
					</tr>
					<%
						}
					} %>
				</table>
			</div>
			<div class="outborder">
				<table width="100%" border="1" id="clientStatusTab">
					<tr>
						<td width="5%">
							<div align="center">
								行号
							</div>
						</td>
						<td width="15%">
							<div align="center">
								日期(yyyy-MM-dd)
							</div>
						</td>
						<td width="35%">
							<div align="center">
								跟进情况
							</div>
						</td>
						<td width="35%">
							<div align="center">
								备注
							</div>
						</td>
						<td width="15%">
							<div align="center">
								出差/来访
							</div>
						</td>
					</tr>
					<%
					List<ClientStatusForm> clientStatusList=clientProject.getClientStatusList();
					int size=6;
					if(clientStatusList !=null && clientStatusList.size()>0){
						size=clientStatusList.size();
					}
					for(int i=0;i<size;i++) {
						if(clientStatusList !=null && clientStatusList.size()>i){
							ClientStatusForm clientStatus=clientStatusList.get(i);
					 %>
					<tr>
						<td>
							<div align="center">
								<%=i+1%>
							</div>
						</td>
						<td>
							<div align="center">
								<input type="hidden"" id="stautsId<%=i%>" name="stautsId" size="35" style="width: 100%" value="<%=clientStatus.getId()%>">
								<input type="text" id="followupdate<%=i%>" name="followupdate" size="35" style="width: 100%" value="<%=clientStatus.getFollowUpdate()==null?"":clientStatus.getFollowUpdate()%>" title="日期格式如:2016-01-01">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="statuscas<%=i%>" name="statuscas" size="30" style="width: 100%" value="<%=clientStatus.getStatusCas()==null?"":clientStatus.getStatusCas()%>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i%>" name="remark" size="20" style="width: 100%" value="<%=clientStatus.getRemark()==null?"":clientStatus.getRemark() %>" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="register<%=i%>" name="register" size="20" style="width: 100%" value="<%=clientStatus.getRegister()==null?"":clientStatus.getRegister() %>">
							</div>
						</td>
						
					</tr>
					<%}else{
					%>
					<tr>
						<td>
							<div align="center">
								<%=i+1 %>
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="followupdate<%=i%>" name="followupdate" size="35" style="width: 100%" onfocus="getCurDate(this);">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="statuscas<%=i%>" name="statuscas" size="30" style="width: 100%" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i%>" name="remark" size="20" style="width: 100%" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="register<%=i%>" name="register" size="20" style="width: 100%" >
							</div>
						</td>
						
					</tr>
					<%
					}
				} %>
				</table>
				<input type="button" value="增加进度" onclick="addLastTr();">
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存订单" onClick="addclientStatus();">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
