<%@page import="com.lccert.crm.client.ClientSalesStatusForm"%>
<%@page import="com.lccert.crm.client.ClientSalesStatusAction"%>
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
	ClientSalesStatusForm clientSalesStatus=null;
	if(clientid != null || !"".equals(clientid)) {
		client=ClientAction.getInstance().findById(clientid);
		clientSalesStatus=ClientSalesStatusAction.getInstance().findByClientId(Integer.parseInt(clientid));
	}
	if(clientSalesStatus==null){
		clientSalesStatus=new ClientSalesStatusForm();
	}
 %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>添加客户进度总表</title>
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
	function addclientSalesStatus(){
		var totalprice=$("#totalprice").val();
		var signbackprice=$("#signbackprice").val();
		if(isNaN(totalprice)){
			alert("报价金额只能输入数字或数字与小数点组合！");
			return false;
		}
		if(isNaN(signbackprice)){
			alert("报价单回签金额只能输入数字或数字与小数点组合！");
			return false;
		}
		with (document.getElementById("quotationform")) {
			method="post";
			action="addclientsalesstatus_post.jsp";
			submit();
		}
	}
	
</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return addclientSalesStatus(this)">&nbsp; 
			
			<input name="id" id="id" type="hidden" value="<%=clientSalesStatus.getId()%>" />
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
							<b>客户管理&gt;&gt;添加客户进度总表</b>
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
							客户类型：
						</td>
						<td>
							<select name="clientType" id="clientType" style="width: 300px">
								<%
									if(clientSalesStatus.getClientType() !=null && !clientSalesStatus.getClientType().equals("")){
									%>
									<option value="目标客户" <%=clientSalesStatus.getClientType().equals("目标客户")?"selected":""%>>目标客户</option>
									<option value="有效客户" <%=clientSalesStatus.getClientType().equals("有效客户")?"selected":""%>>有效客户</option>
									<option value="意向客户" <%=clientSalesStatus.getClientType().equals("意向客户")?"selected":""%>>意向客户</option>
									<option value="准成交客户" <%=clientSalesStatus.getClientType().equals("准成交客户")?"selected":""%>>准成交客户</option>
									<option value="成交客户" <%=clientSalesStatus.getClientType().equals("成交客户")?"selected":""%>>成交客户</option>
									<%
									}else{
									%>
									<option value="目标客户" >目标客户</option>
									<option value="有效客户" >有效客户</option>
									<option value="意向客户" >意向客户</option>
									<option value="准成交客户" >准成交客户</option>
									<option value="成交客户" >成交客户</option>
									<%
									}
								 %>
								
							</select>
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >重要性：</td>
						<td>
							<select name="nature" id="nature" style="width: 300px">
								<%
									if(clientSalesStatus.getNature() !=null && !clientSalesStatus.getNature().equals("")){
									%>
									<option value="低" <%=clientSalesStatus.getNature().equals("低")?"selected":""%>>低</option>
									<option value="一般" <%=clientSalesStatus.getNature().equals("一般")?"selected":""%>>一般</option>
									<option value="中等" <%=clientSalesStatus.getNature().equals("中等")?"selected":""%>>中等</option>
									<option value="高等" <%=clientSalesStatus.getNature().equals("高等")?"selected":""%>>高等</option>
									<option value="VIP" <%=clientSalesStatus.getNature().equals("VIP")?"selected":""%>>VIP</option>
									<%
									}else{
									%>
									<option value="低" >低</option>
									<option value="一般" >一般</option>
									<option value="中等" >中等</option>
									<option value="高等" >高等</option>
									<option value="VIP" >VIP</option>
									<%
									}
								 %>
								
							</select>  
						</td>
						<td >客户基本信息：</td>
						<td >
							<select name="basicinfor" id="basicinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getBasicInfor()!=null && !clientSalesStatus.getBasicInfor().equals("")){
									%>
									<option value="正在收集" <%=clientSalesStatus.getBasicInfor().equals("正在收集")?"selected":""%>>正在收集</option>
									<option value="收集完成" <%=clientSalesStatus.getBasicInfor().equals("收集完成")?"selected":""%>>收集完成</option>
									<option value="信息复查" <%=clientSalesStatus.getBasicInfor().equals("信息复查")?"selected":""%>>信息复查</option>
									<option value="确认完成" <%=clientSalesStatus.getBasicInfor().equals("确认完成")?"selected":""%>>确认完成</option>
									<%
									}else{
									%>
									<option value="正在收集" >正在收集</option>
									<option value="收集完成" >收集完成</option>
									<option value="信息复查" >信息复查</option>
									<option value="确认完成" >确认完成</option>
									<%
									}
								 %>
								
							</select>  
						</td>
						
					</tr>
					<tr  id ="trpid">
						<td >竞争对手信息</td>
						<td >
							<select name="rivalinfor" id="rivalinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getRivalInfor() !=null && !clientSalesStatus.getRivalInfor().equals("")){
									%>
									<option value="正在收集" <%=clientSalesStatus.getRivalInfor().equals("正在收集")?"selected":""%>>正在收集</option>
									<option value="收集完成" <%=clientSalesStatus.getRivalInfor().equals("收集完成")?"selected":""%>>收集完成</option>
									<option value="信息复查" <%=clientSalesStatus.getRivalInfor().equals("信息复查")?"selected":""%>>信息复查</option>
									<option value="确认完成" <%=clientSalesStatus.getRivalInfor().equals("确认完成")?"selected":""%>>确认完成</option>
									<%
									}else{
									%>
									<option value="正在收集" >正在收集</option>
									<option value="收集完成" >收集完成</option>
									<option value="信息复查" >信息复查</option>
									<option value="确认完成" >确认完成</option>
									<%
									}
								 %>
								
							</select> 
						</td>
						<td >采购流程与组织架构</td>
						<td >
							<select name="procureflow" id="procureflow" style="width: 300px">
								<%
									if(clientSalesStatus.getProcureFlow() !=null && !clientSalesStatus.getProcureFlow().equals("")){
									%>
									<option value="正在收集" <%=clientSalesStatus.getProcureFlow().equals("正在收集")?"selected":""%>>正在收集</option>
									<option value="收集完成" <%=clientSalesStatus.getProcureFlow().equals("收集完成")?"selected":""%>>收集完成</option>
									<option value="信息复查" <%=clientSalesStatus.getProcureFlow().equals("信息复查")?"selected":""%>>信息复查</option>
									<option value="确认完成" <%=clientSalesStatus.getProcureFlow().equals("确认完成")?"selected":""%>>确认完成</option>
									<%
									}else{
									%>
									<option value="正在收集" >正在收集</option>
									<option value="收集完成" >收集完成</option>
									<option value="信息复查" >信息复查</option>
									<option value="确认完成" >确认完成</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					<tr  id ="trpid">
						<td >项目信息：</td>
						<td >
							<select name="projectinfor" id="projectinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getProjectInfor() !=null && !clientSalesStatus.getProjectInfor().equals("")){
									%>
									<option value="正在收集" <%=clientSalesStatus.getProjectInfor().equals("正在收集")?"selected":""%>>正在收集</option>
									<option value="收集完成" <%=clientSalesStatus.getProjectInfor().equals("收集完成")?"selected":""%>>收集完成</option>
									<option value="信息复查" <%=clientSalesStatus.getProjectInfor().equals("信息复查")?"selected":""%>>信息复查</option>
									<option value="促进阶段" <%=clientSalesStatus.getProjectInfor().equals("促进阶段")?"selected":""%>>促进阶段</option>
									<%
									}else{
									%>
									<option value="正在收集" >正在收集</option>
									<option value="收集完成" >收集完成</option>
									<option value="信息复查" >信息复查</option>
									<option value="促进阶段" >促进阶段</option>
									<%
									}
								 %>
								
							</select> 
						</td>
						<td >&nbsp;</td>
						<td >
							&nbsp;
						</td>
					</tr>
					
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="90%" cellpadding="5" cellspacing="5">
					<tr>
						<td >
							询价阶段：
						</td>
						<td width="33%">
							<select name="inquirystage" id="inquirystage" style="width: 300px">
								<%
									if(clientSalesStatus.getInquirYstage() !=null && !clientSalesStatus.getInquirYstage().equals("")){
									%>
									<option value="口头咨询" <%=clientSalesStatus.getInquirYstage().equals("口头咨询")?"selected":""%>>口头咨询</option>
									<option value="广泛咨询" <%=clientSalesStatus.getInquirYstage().equals("广泛咨询")?"selected":""%>>广泛咨询</option>
									<option value="具体资料咨询" <%=clientSalesStatus.getInquirYstage().equals("具体资料咨询")?"selected":""%>>具体资料咨询</option>
									<%
									}else{
									%>
									<option value="口头咨询" >口头咨询</option>
									<option value="广泛咨询" >广泛咨询</option>
									<option value="具体资料咨询" >具体资料咨询</option>
									<%
									}
								 %>
								
							</select>
						</td>
						<td>
							销售策略制定与调整阶段：
						</td>
						<td>
							<select name="salesstrategy" id="salesstrategy" style="width: 300px">
								<%
									if(clientSalesStatus.getSalesStrategy() !=null && !clientSalesStatus.getSalesStrategy().equals("")){
									%>
									<option value="方案制定" <%=clientSalesStatus.getSalesStrategy().equals("方案制定")?"selected":""%>>方案制定</option>
									<option value="方案沟通" <%=clientSalesStatus.getSalesStrategy().equals("方案沟通")?"selected":""%>>方案沟通</option>
									<option value="方案调整" <%=clientSalesStatus.getSalesStrategy().equals("方案调整")?"selected":""%>>方案调整</option>
									<option value="等待成交" <%=clientSalesStatus.getSalesStrategy().equals("等待成交")?"selected":""%>>等待成交</option>
									<%
									}else{
									%>
									<option value="方案制定" >方案制定</option>
									<option value="方案沟通" >方案沟通</option>
									<option value="方案调整" >方案调整</option>
									<option value="等待成交 >等待成交</option>
									<%
									}
								 %>
								
							</select>
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >报价金额：</td>
						<td>
							<input type="text" id="totalprice" name ="totalprice" value="<%=clientSalesStatus.getTotalPrice()%>">
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
						
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="90%" cellpadding="5" cellspacing="5">
					<tr  id ="trpid">
						<td >报价单回签金额：</td>
						<td >
							<input type="text" id="signbackprice" name ="signbackprice" value="<%=clientSalesStatus.getSignBackPrice() %>">
						</td>
						<td >样品资料提供</td>
						<td >
							<select name="sampleinfor" id="sampleinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getSampleInfor() !=null && !clientSalesStatus.getSampleInfor().equals("")){
									%>
									<option value="样品资料已提供完整" <%=clientSalesStatus.getSampleInfor().equals("样品资料已提供完整")?"selected":""%>>样品资料已提供完整</option>
									<option value="样品完整资料欠缺" <%=clientSalesStatus.getSampleInfor().equals("样品完整资料欠缺")?"selected":""%>>样品完整资料欠缺</option>
									<option value="资料完整样品欠缺" <%=clientSalesStatus.getSampleInfor().equals("资料完整样品欠缺")?"selected":""%>>资料完整样品欠缺</option>
									<option value="资料样品全欠缺" <%=clientSalesStatus.getSampleInfor().equals("资料样品全欠缺")?"selected":""%>>资料样品全欠缺</option>
									<%
									}else{
									%>
									<option value="样品资料已提供完整" >样品资料已提供完整</option>
									<option value="样品完整资料欠缺" >样品完整资料欠缺</option>
									<option value="资料完整样品欠缺" >资料完整样品欠缺</option>
									<option value="资料样品全欠缺" >资料样品全欠缺</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >款项支付部门：</td>
						<td >
							<select name="partpayment" id="partpayment" style="width: 300px">
								<%
									if(clientSalesStatus.getPartPayment() !=null && !clientSalesStatus.getPartPayment().equals("")){
									%>
									<option value="支付预付款" <%=clientSalesStatus.getPartPayment().equals("支付预付款")?"selected":""%>>支付预付款</option>
									<option value="全额款项付清" <%=clientSalesStatus.getPartPayment().equals("全额款项付清")?"selected":""%>>全额款项付清</option>
									<option value="欠缺尾款" <%=clientSalesStatus.getPartPayment().equals("欠缺尾款")?"selected":""%>>欠缺尾款</option>
									<option value="末支付任何款项" <%=clientSalesStatus.getPartPayment().equals("末支付任何款项")?"selected":""%>>末支付任何款项</option>
									<%
									}else{
									%>
									<option value="支付预付款" >支付预付款</option>
									<option value="全额款项付清" >全额款项付清</option>
									<option value="欠缺尾款" >欠缺尾款</option>
									<option value="末支付任何款项" >末支付任何款项</option>
									<%
									}
								 %>
								
							</select> 
						</td>
						<td >发票部份：</td>
						<td >
							<select name="invoice" id="invoice" style="width: 300px">
								<%
									if(clientSalesStatus.getInvoice() !=null && !clientSalesStatus.getInvoice().equals("")){
									%>
									<option value="已开全额发票" <%=clientSalesStatus.getInvoice().equals("已开全额发票")?"selected":""%>>已开全额发票</option>
									<option value="末开发票" <%=clientSalesStatus.getInvoice().equals("末开发票")?"selected":""%>>末开发票</option>
									<option value="开部份金额发票" <%=clientSalesStatus.getInvoice().equals("开部份金额发票")?"selected":""%>>开部份金额发票</option>
									<%
									}else{
									%>
									<option value="已开全额发票" >已开全额发票</option>
									<option value="末开发票" >末开发票</option>
									<option value="开部份金额发票" >开部份金额发票</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					<tr  id ="trpid">
						<td >报告证书部份：</td>
						<td >
							<select name="certificate" id="certificate" style="width: 300px">
								<%
									if(clientSalesStatus.getCertificate() !=null && !clientSalesStatus.getCertificate().equals("")){
									%>
									<option value="报告已出并寄出" <%=clientSalesStatus.getCertificate().equals("报告已出并寄出")?"selected":""%>>报告已出并寄出</option>
									<option value="报告已出末寄出" <%=clientSalesStatus.getCertificate().equals("报告已出末寄出")?"selected":""%>>报告已出末寄出</option>
									<option value="出草稿报告并确认" <%=clientSalesStatus.getCertificate().equals("出草稿报告并确认")?"selected":""%>>出草稿报告并确认</option>
									<option value="报告末出" <%=clientSalesStatus.getCertificate().equals("报告末出")?"selected":""%>>报告末出</option>
									<%
									}else{
									%>
									<option value="报告已出并寄出" >报告已出并寄出</option>
									<option value="报告已出末寄出" >报告已出末寄出</option>
									<option value="出草稿报告并确认" >出草稿报告并确认</option>
									<option value="报告末出" >报告末出</option>
									<%
									}
								 %>
							</select> 
						</td>
						<td >客户满意度部份：</td>
						<td >
							<select name="satisfaction" id="satisfaction" style="width: 300px">
								<%
									if(clientSalesStatus.getSatisFaction() !=null && !clientSalesStatus.getSatisFaction().equals("")){
									%>
									<option value="非常满意" <%=clientSalesStatus.getSatisFaction().equals("非常满意")?"selected":""%>>非常满意</option>
									<option value="满意度一般" <%=clientSalesStatus.getSatisFaction().equals("满意度一般")?"selected":""%>>满意度一般</option>
									<option value="满意度很差" <%=clientSalesStatus.getSatisFaction().equals("满意度很差")?"selected":""%>>满意度很差</option>
									<%
									}else{
									%>
									<option value="非常满意" >非常满意</option>
									<option value="满意度一般" >满意度一般</option>
									<option value="满意度很差" >满意度很差</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					<tr  id ="trpid">
						
						<td >备注：</td>
						<td colspan="3">
							<input type="text" id="remark" name="remark" size="150px;" style="width:850px" value="<%=clientSalesStatus.getRemark()%>">
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存订单" onClick="addclientSalesStatus();">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
