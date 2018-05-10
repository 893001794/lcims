<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String pidStr = request.getParameter("pid");
//	System.out.println(pidStr);
	String pidStr1="";
	float sumPrice =0.0f;
	if(pidStr.split(",").length<=0){
	return;
	}else{
		for(String value:pidStr.split(",")){
				if(value.indexOf("/")==-1)return;
				pidStr1+=value.substring(0,value.indexOf("/"))+",";
				sumPrice+=Float.parseFloat(value.substring(value.indexOf("/")+1,value.length()));
		}
	}
	String [] pidLenght=pidStr1.split(",");
	String pid=pidLenght[0];
	Order order =new Order();
		String str ="";
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("quotation_manage.jsp");
		return;
	}
	Quotation qt;
	if(QuotationAction.getInstance().getQuotationByPid(pid) ==null && "".equals(QuotationAction.getInstance().getQuotationByPid(pid))){
	qt = new Quotation();
	}else{
	qt= QuotationAction.getInstance().getQuotationByPid(pid);
    int id = OrderAction.getInstance().getOrderByPid(pid);
    order = OrderAction.getInstance().getOrderById(id);
	
	}
	ClientForm cf =ClientAction.getInstance().getClientByName(qt.getClient());
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>报价单管理</title>
		<link rel="stylesheet" href="..//css/drp.css">
		<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
		
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>

		<script language="javascript">
		
</script>

	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">

		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>财务管理&gt;&gt;收款收据</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" id="form1" method="post" action="addreceipt_post.jsp" onsubmit="addtextarea();">
		<input type="hidden" value="<%=pidStr%>" name ="pidStr">
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="8%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=pidStr1%>" />
						</td>

						<td width="7%">
							收据金额：
						</td>
						<td width="33%">
							<input name="invprice" size="40" type="text" value="<%=sumPrice%>" />
						</td>
					</tr>
					<tr>
					<td width="5%">收款账号：
					</td>
					<td colspan="3">
					<select name="creditcard" style="width: 300px">	
						<option value="">请选择收款帐号</option>	
						<option value="借开">借开</option>
						<option value="现金">现金</option>
						<option value="建行8833">建行8833</option>
						<option value="客户自缴机构">客户自缴机构</option>
						<option value="香港账户">香港账户</option>	
						<option value="立创代收机构款">立创代收机构款</option>	
							<%
							int companyid=user.getCompanyid();
							Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
									for(String value:banks.keySet()) {
									if(banks.get(value).equals(qt.getCreditcard())){
								%>
								<option value="<%=banks.get(value)%>"<%=banks.get(value)!=null?"selected":""%>><%=banks.get(value) %></option>
								<%
								 }	else {
								  %>
								  <option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
								  <%
								 }
								 }				
								  %>
					</select>	
						
					</td>
					</tr>
					<tr>
						<td width="5%">
							今收到：
						</td>
						<td colspan="3">
							<input name="client" size="100" type="text" value="<%=qt.getClient()==null?"":qt.getClient()%>" />
						</td>
					</tr>
					<tr>
						<td width="5%">
							交      往：
						</td>
						<td colspan="3">
							<textarea name="receiptContent" rows="3" cols="3" style="width: 85%">测试费</textarea>
						</td>
					</tr>
				</table>
			</div>
				
			</div>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnModify" class="button1" type="submit""
				id="btnModify" value="添加">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
			<p>&nbsp;</p>
		</form>
	</body>
</html>
