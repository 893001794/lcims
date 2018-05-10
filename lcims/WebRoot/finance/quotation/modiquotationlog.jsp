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
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	String pageNo = request.getParameter("pageNo");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("quotation_manage.jsp");
		return;
	}
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
	List<Project> list = ProjectAction.getInstance().getAllProjectByPid(pid);
	
	int companyid=0;
	if(qt.getCompany().equals("中山")){
	companyid=1;
	}else if (qt.getCompany().equals("广州")){
	companyid=2;
	}else if (qt.getCompany().equals("东莞")){
	companyid=3;
	}
	
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
		function getAcount(acount) {
			if(acount.value == "") {
				acount.value = "<%=qt.getPreadvance()+qt.getSepay()+qt.getBalance()-qt.getSubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax()%>";
			}
		}
		
		function printstatement() {
			window.open("printstatement.jsp?pid=<%=qt.getPid()%>");
		}
		function goBack() {
		window.self.location="quotation_manage.jsp?pageNo=<%=pageNo%>";
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("addappform").value += temp;
			document.getElementById("addappform").value += "\n";
		}
		function addInorganic(temp0) {
			document.getElementById("inorganic").value += temp;
			document.getElementById("inorganic").value += "\n";
		}
		function addInorganicDetail(temp1) {
			document.getElementById("inorganicdetail").value += temp1;
			document.getElementById("inorganicdetail").value += "\n";
		}
		function addOrganic(temp2) {
			document.getElementById("organic").value += temp2;
			document.getElementById("organic").value += "\n";
		}
		function addOrganicDetail(temp3) {
			document.getElementById("organicdetail").value += temp3;
			document.getElementById("organicdetail").value += "\n";
		}
		function addfood(temp4) {
			document.getElementById("food").value += temp4;
			document.getElementById("food").value += "\n";
		}
	</script>

	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">

		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;财务管理&gt;&gt;款项登记</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" method="post" action="quotationlog_post.jsp">
			<input name="pageNo" value="<%=pageNo %>" type="hidden"/>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getPid() %>" />
						</td>

						<td width="17%">
							分公司：
						</td>
						<td width="33%">

							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany() %>" />
						</td>

					</tr>
					<tr>
						
						
						<td>
							立项时间：
						</td>
						<td>
							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCreatetime()) %>" />
						</td>
						<td>
							销售人员：
						</td>
						<td>
							<input name="sales" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSales() %>" />
						</td>
					
					</tr>

					<tr>
						<td width="116">
							报价金额：
						</td>
						<td width="168">
							<input name="totalprice" type="text" readonly="readonly"
								size="40" style="background-color: yellow"
								value="<%=qt.getTotalprice() %>" />
						</td>
						<td width="100">
							应完成时间：
						</td>
						<td width="611">
							<input style="background-color: #F2F2F2" readonly="readonly"
								size="40" value="<%=qt.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime())%>" />
						</td>
					</tr>

					<tr>
						<td>
							客户名称：
						</td>
						<td>
							<input style="background-color: #F2F2F2" readonly="readonly"
								size="40" value="<%=qt.getClient() %>" />
						</td>
						
						<td>
							项目名称：
						</td>
						<td>
							<input type="text" style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getProjectcontent() %>" />
						</td>
					</tr>
					<tr>

						<td>
							收款方式：
						</td>
						<td>
							<input name="advancetype" value="<%=qt.getAdvancetype()==null?"":qt.getAdvancetype() %>"
								type="text" size="40" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>
						<td>
					</tr>
				</table>
			</div>
			
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">

					<tr>
						<td width="17%">
							已收预付款：
						</td>
						<td width="33%">
							<%String va = "value='" + new DecimalFormat("###########.00").format(qt.getPreadvance()) + "' readonly='readonly' style='background-color: #F2F2F2'";%>
							<input name="preadvance" type="text" size="40"
								<%=qt.getPreadvance()==0?"":va %> />
								
						</td>
						<td>
							预付款收款日期：
						</td>
						<td>
							<input name=paytime type="text" size="40" 
								<%=qt.getPaytime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getPaytime()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						<td width="132">
							收款账号：
						</td>
						<td width="263">
						<%if(qt.getCreditcard()==null||"".equals(qt.getCreditcard())){
						%>
						<select name="creditcard" style="width: 300px">		
						<option value="" selected="selected">请选择收款帐号</option>	
						<option value="现金">现金</option>									
						<option value="建行8833">建行8833</option>									
<% 
						
						Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
									for(String value:banks.keySet()) {
									 %>
								<option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
								<%
								 }					
								  %>
							</select>
						<%	}else{
								  %>
								<input name="creditcard" type="text" size="40" <%=("value='" + qt.getCreditcard() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> 					
								 <%
								 }
							 %>
						
							
								
						</td>
						<td>
							预付款收款票据：
						</td>
						<td>
						<%if(qt.getPaynotes()==null||"".equals(qt.getPaynotes())){
						%>
					<select name="paynotes"  style="width: 290px">
					
					 <option value="" selected="selected">请选择收款票据</option>
					    <option value="发票">发票</option>
					    <option value="收据">收据</option>
					</select>
					<%}else{
					%>
					<input name="paynotes" type="text" size="40" <%=("value='" + qt.getPaynotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
					<%
					}
					 %>
							<!--  <input name="paynotes" type="text" size="40" <%=(qt.getPaynotes()==null||"".equals(qt.getPaynotes()))?"":("value='" + qt.getPaynotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />-->
								
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							二次收款金额：
						</td>
						<td width="33%">
							<input name="sepay" type="text" size="40"
								<%=qt.getSepay()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getSepay()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
						<td>
							二次收款日期：
						</td>
						<td>
							<input name="sepaytime" type="text" size="40" 
								<%=qt.getSepaytime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSepaytime()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
						
					</tr>
					<tr>
						<td width="17%">
							二次收款账号：
						</td>
						<td width="33%">
						<%if(qt.getSepayacount()==null||"".equals(qt.getSepayacount())){
	
						%>
					<select name="sepayacount" style="width: 300px">	
					<option value="" selected="selected">请选择收款帐号</option>	
					<option value="现金">现金</option>									
					<option value="建行8833">建行8833</option>									
<% 
						
						
						Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
									for(String value:banks.keySet()) {
									 %>
								<option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
								<%
								 }					
								  %>
							</select>
						<%	}else{
								  %>
								<input name="sepayacount" type="text" size="40" <%=("value='" + qt.getSepayacount() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								 <%
								 }
								 
							 %>
							
								
						</td>
						<td>
							二次收款票据：
						</td>
						<td>
						<%if(qt.getSepaynotes()==null||"".equals(qt.getSepaynotes())){
						%>
					<select name="sepaynotes"  style="width: 290px">
					    <option value="" selected="selected">请选择收款票据</option>							
					    <option value="发票">发票</option>
					    <option value="收据">收据</option>
					</select>
					<%}else{
					%>
					<input name="sepaynotes" type="text" size="40" <%=("value='" + qt.getSepaynotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
					<%
					}
					 %>
							<!--  <input name="sepaynotes" type="text" size="40" <%=(qt.getSepaynotes()==null||"".equals(qt.getSepaynotes()))?"":("value='" + qt.getSepaynotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />-->
								
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							应收尾款金额：
						</td>
						<td width="33%">
							<input name="prebalance" type="text" size="40" 
								<%=qt.getPrebalance()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getPrebalance()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
						<td width="17%">
							实收尾款金额：
						</td>
						<td width="33%">
							<input name="balance" type="text" size="40" 
								<%=qt.getBalance()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getBalance()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						<td>
							尾款收款账号：
						</td>
						<td>
						
						<%if(qt.getBalanceacount()==null||"".equals(qt.getBalanceacount())){
	
						%>
					<select name="balanceacount" style="width: 300px">		
					<option value="" selected="selected">请选择收款帐号</option>	
					<option value="现金">现金</option>									
					<option value="建行8833">建行8833</option>								
<% 
						
						
						Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
									for(String value:banks.keySet()) {
									 %>
								<option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
								<%
								 }					
								  %>
							</select>
						<%	}else{
								  %>
								<input name="balanceacount" type="text" size="40" <%=("value='" + qt.getBalanceacount() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								 <%
								 }
								 
							 %>
							
								
							
						</td>
						<td>
							尾款收款日期：
						</td>
						<td>
							<input name="balancetime" type="text" size="40" 
								<%=qt.getBalancetime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getBalancetime()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
					<td width="116">
							收款备注：
						</td>
						<td width="593">
							<textarea name="collRemarks" rows="6" cols="40"><%=qt.getCollRemarks()==null?"":qt.getCollRemarks() %></textarea>
						</td>
					</tr>
					<tr>
						
						<td>
							项目退款金额：
						</td>
						<td>
							<input name="refund" type="text" size="40" 
								<%=qt.getRefund()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getRefund()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
						<td>
							尾款收款票据：
						</td>
						<td>
						<%if(qt.getBalancenotes()==null||"".equals(qt.getBalancenotes())){
						%>
						<select name="balancenotes"  style="width: 290px">
						
					    <option value="" selected="selected">请选择收款票据</option>		
					    <option value="发票">发票</option>
					    <option value="收据">收据</option>
						</select>
					<%}else{
					%>
					<input name="balancenotes" type="text" size="40" <%=("value='" + qt.getBalancenotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> 
					<%
					}
					 %>
						
							<!-- <input name="balancenotes" type="text" size="40" <%=(qt.getBalancenotes()==null||"".equals(qt.getBalancenotes()))?"":("value='" + qt.getBalancenotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> -->
								
						</td>
					</tr>

					<tr>
						<td width="116">
							项目退款说明：
						</td>
						<td width="593">
							<textarea name="refunddesc" rows="6" cols="40"><%=qt.getRefunddesc()==null?"":qt.getRefunddesc() %></textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊接待费预算：
						</td>
						<td width="33%">
							<input name="prespefund" type="text" size="40" readonly="readonly"
								style="background-color: #F2F2F2"
								value="<%=qt.getPrespefund()==0?"":new DecimalFormat("###########.00").format(qt.getPrespefund()) %>" />
								
						</td>
						<td width="17%">
							实际特殊接待费：
						</td>
						<td width="33%">
							<input name="spefund" type="text" size="40" 
								<%=qt.getSpefund()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getSpefund()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						<td>
							特殊接待费支付方式：
						</td>
						<td>
						<%if(qt.getSpefundtype()==null||"".equals(qt.getSpefundtype())){
						%>
						<select name="spefundtype" style="width: 300px">		
						<option value="" selected="selected">请选择特殊接待费支付方式</option>
						<option value="现金">现金</option>									
						<option value="建行3079">建行3079</option>									
						<option value="建行1050">建行1050</option>									
															

						</select>
						<%	}else{
								  %>
								<input name="spefundtype" type="text" size="40" <%=("value='" + qt.getSpefundtype() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								 <%
								 }
							 %>
						
							
							<!-- <input name="spefundtype" type="text" size="40" 
								<%=(qt.getSpefundtype()==null||"".equals(qt.getSpefundtype()))?"":("value='" + qt.getSpefundtype() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> -->
								
						</td>
						<td>
							特殊接待费支付日期：
						</td>
						<td>
							<input name="spefundtime" type="text" size="40" 
								<%=qt.getSpefundtime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSpefundtime()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						<td>
							特殊接待费支付备注：
						</td>
						<td>
							<textarea name="spefunddesc" rows="6" cols="40"><%=qt.getSpefunddesc()==null?"":qt.getSpefunddesc() %></textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="116">
							开票方式：
						</td>
						<td width="168">
							<input name="invtype" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvtype()==null?"":qt.getInvtype() %>"/>
						</td>
						<td width="17%">
							票据编号：
						</td>
						<td width="33%">
							<input name="invcode" type="text" size="40" 
								<%=(qt.getInvcode()==null||"".equals(qt.getInvcode()))?"":("value='" + qt.getInvcode() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
						
					</tr>
					<tr>
						<td width="132">
							开票总金额：
						</td>
						<td width="263">
							<input name="invcount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvcount()==0?"":new DecimalFormat("###########.00").format(qt.getInvcount()) %>"/>
						</td>
						<td width="132">
							实际开票金额：
						</td>
						<td width="263">
							<input name="invprice" type="text" size="40" 
								<%=qt.getInvprice()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getInvprice()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
									
						</td>
					</tr>
					<tr>
						<td width="17%">
							票据抬头：
						</td>
						<td width="33%">
							<input name="invhead" type="text" size="40"
								 value="<%=qt.getInvhead()==null?"":qt.getInvhead() %>"/>
						</td>
						<td>
							票据日期：
						</td>
						<td>
							<input name="invtime" size="40" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
								<%=qt.getInvtime()==null?"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getInvtime()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						
						<td width="17%">
							票据内容：
						</td>
						<td width="33%">
							<input name="invcontent" type="text" size="40"
								 value="<%=qt.getInvcontent()==null?"":qt.getInvcontent() %>"/>
						</td>
						<td width="17%">
							税金:
						</td>
						<td width="33%">
						<%
						Double sun=0.0;
							if(qt.getPreadvance()!=0 && "发票".equals(qt.getPaynotes())){
							sun +=qt.getPreadvance()*0.08;
						
							}
							if(qt.getSepay()!=0 && "发票".equals(qt.getSepaynotes())){
							sun +=qt.getSepay()*0.08;
							}
							if(qt.getPrebalance()!=0 && "发票".equals(qt.getBalancenotes())){
						
							sun +=qt.getPrebalance()*0.08;
							}
						 %>
						 <input name="tax" type="text" size="40" value="<%=sun%>" style="background-color: #F2F2F2" readonly="readonly"/>
							<!--  <input name="tax" type="text" size="40" value="<%=qt.getTax()==0?"":qt.getTax() %>"/>-->	
						</td>
					</tr>
					<tr>
						<td width="17%">
							备注:
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40"
								 value="<%=qt.getTag()==null?"":qt.getTag() %>"/>	
						</td>
						<td width="17%">
							其他费用:
						</td>
						<td width="33%">
						
							<input name="othercost" type="text" size="40" value="<%=qt.getSumOtherscost()==0?"":qt.getSumOtherscost() %>"/>	
							<!--  <input name="othercost" type="text" size="40" value="<%=qt.getOthercost()==0?"":qt.getOthercost() %>"/>-->	

						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							业绩核算基数：
						</td>
						<td width="33%">
							<input name="preacount" type="text" size="40" readonly='readonly' style='background-color: #F2F2F2'
								value='<%=qt.getPreacount()==0?"":new DecimalFormat("###########.00").format(qt.getPreacount())%>'  />
								
						</td>
						<td width="17%">
							业绩结算基数：
						</td>
						<td width="33%">
							<input name="acount" type="text" size="40" onFocus="getAcount(this)" 
								<%=qt.getAcount()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getAcount()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
				</table>
				<p>
					<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5" border="1">
					<tr bgcolor="#A9F5F2">
					 <td>报告编号</td>
					 <td>报告应出时间</td>
					 <td>分项目金额</td>
					 <td>业绩核算基数</td>
					 <td>业绩结算基数</td>
					 <td>操作</td>
					</tr>
				<%
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					Date rptime = null;
					if(!"化学测试".equals(p.getPtype())) {
						PhyProject pp = (PhyProject)p.getObj();
						rptime = pp.getRptime();
					} else {
						ChemProject cp = (ChemProject)p.getObj();
						rptime = cp.getRptime();
					}
					
				 %>
					<tr>
						<td><%=p.getRid() %></td>
						<td><%=rptime %></td>
						<td><%=p.getPrice() %></td>
						<td><%=p.getPpreacount() %></td>
						<td><%=p.getPacount() %></td>
						<td><a href="../project/projectlog.jsp?sid=<%=p.getSid() %>&ptype=<%=URLEncoder.encode(p.getPtype(),"UTF-8") %>" style="color: blue">分项目款项</a></td>
					</tr>
				<%
				}
				 %>
				</table>
			</div>
				
			</div>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnModify" class="button1" type="button"
				id="btnModify" value="打印内部对账单" onClick="printstatement()">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="款项更新">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
			<p>&nbsp;</p>
		</form>
	</body>
</html>
