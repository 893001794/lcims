<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
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
	//String pid = request.getParameter("pid");
	String pidStr = request.getParameter("pid");
	String uiNo = request.getParameter("ui");
	//System.out.println(pidStr);
	String pidStr1="";
	float sumPrice =0.0f;
	//System.out.println(pidStr.split(",").length+"---");
	if(pidStr.split(",").length<=0){
	return;
	}else{
		for(String value:pidStr.split(",")){
				if(value.indexOf("/")==-1)return;
				pidStr1+=value.substring(0,value.indexOf("/"))+",";
				//sumPrice+=Float.parseFloat(value.substring(value.indexOf("/")+1,value.length()));
		}
	}
	String [] pidLenght=pidStr1.split(",");
	String pid=pidLenght[0];
	Order order =new Order();
	String str ="";
	String type =request.getParameter("type");   //类型
	String pageNo = request.getParameter("pageNo");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("quotation_manage.jsp");
		return;
	}
	//------------------------------------------------------------------------------------------
		String lockType = request.getParameter("lockType");
		String lock = request.getParameter("lock");
		if(lockType !=null&& "1".equals(lockType)){
			if(lock!=null&&lock!=""){
				if(lock.equals("n")){
				lock ="y";
				}else{
				lock ="n";
				}
			}
			Quotation q =new Quotation();
			//System.out.println(q);
			q.setPid(pid);
			q.setLock(lock);
			FinanceQuotationAction.getInstance().quotationLock(q);
		}
	//------------------------------------------------------------------------------------------
	Quotation qt;
	if(QuotationAction.getInstance().getQuotationByPid(pid) ==null && "".equals(QuotationAction.getInstance().getQuotationByPid(pid))){
	qt = new Quotation();
	}else{
	qt= QuotationAction.getInstance().getQuotationByPid(pid);
    int id = OrderAction.getInstance().getOrderByPid(pid);
    int status=0;
    order = OrderAction.getInstance().getOrderById(id);
	
	}
	
	//--------------------------------------------------
	if(lockType !=null&& "1".equals(lockType)){
		//收单确认
		if(qt.getConfirmtime()==null ||(qt.getConfirmtime()!=null &&"".equals(qt.getConfirmtime()==null ) )){
			QuotationAction.getInstance().confirmQuotation(pid,user.getName());
		}
	}
	//--------------------------------------------------
	
	float subtotal =0f;
	String creditcard="";
	String uiValue="";
	int cashierType=0;
	if(uiNo!=null && !"".equals(uiNo)){
		List row=DaoFactory.getInstance().getCashier().cashierInfor(uiNo);
		if(row.size()>0){
			cashierType=1;
			List cloums=(List)row.get(0);
			subtotal=Float.parseFloat(cloums.get(0).toString());
			creditcard=cloums.get(1).toString();
			uiValue=cloums.get(2).toString();
		}
	}
	
	List<Project> list = ProjectAction.getInstance().getAllProjectByPid(pid);
	int companyid=0;
	if(qt.getCompany().equals("中山")){
	companyid=1;
	}else if (qt.getCompany().equals("广州")){
	companyid=2;
	}else if (qt.getCompany().equals("东莞")){
	companyid=3;
	}
	
	String lockStr="加锁";
	if(qt.getLock() !=null && qt.getLock() !=""){
		if(qt.getLock().equals("y")){
			lockStr="解锁";
		}
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
		
		function flush(){
		var form1=document.getElementById("form1");
		form1.action ="quotationlog.jsp"
		form1.submit();
		}
		
		function addtextarea(){
			//预收款时间
			var paytime=document.getElementById("paytime").value;
			//预收款账号
			var creditcard=document.getElementById("creditcard").value;
			//预收款金额
			var preadvance=document.getElementById("preadvance").value;
			//二次收款时间
			var sepaytime=document.getElementById("sepaytime").value;
			//二次收款账号
			var sepayacount=document.getElementById("sepayacount").value;
			//二次收款金额
			var sepay=document.getElementById("sepay").value;
			//尾次收款时间
			var balancetime=document.getElementById("balancetime").value;
			//尾次收款账号
			var balanceacount=document.getElementById("balanceacount").value;
			//尾次收款金额
			var balance=document.getElementById("balance").value;
			var textAreaV="";
			if(preadvance !=""){
				textAreaV+="1:"+paytime+"收到账号为"+creditcard+"的"+preadvance+"元"+"\n";
			}
			if(sepay !=""){
				textAreaV+="2:"+sepaytime+"收到账号为"+sepayacount+"的"+sepay+"元"+"\n";
			}
			if(balance !=""){
				textAreaV+="3:"+balancetime+"收到账号为"+balanceacount+"的"+balance+"元";
			}
			if(document.getElementById("collRemarks").value==""){
				document.getElementById("collRemarks").value=textAreaV;
			}
			
		}
		function lock1(Object,lock){
			 var myForm =document.getElementById("form1");
	   // var lock =document.getElementById("lock").value;
			myForm.action="quotationlog.jsp?lockType=1&type=1&pid="+Object+"/,&lock="+lock;
			myForm.submit();
			return ;
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
					<img src="../../images/mark_arrow_02.gif" width="14" height="14"> 
							&nbsp; <b>订单&gt;&gt;收款情况</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" id="form1" method="post" action="quotationlog_post.jsp" onsubmit="return addtextarea();" >
			<input name="pageNo" value="<%=pageNo %>" type="hidden"/>
			<input type="hidden" value="<%=pidStr%>" name ="pidStr">
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=pidStr1%>" />
						</td>

						<td width="17%">
							分公司：
						</td>
						<td width="33%">

							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany() %>" />
						</td>

					</tr>
					<%
					//System.out.println(qt.getPid().indexOf("LCQE"));
					if(qt.getPid().indexOf("LCQE")>-1){
					%>
					<tr>
						<td width="17%">
							流水账号：
						</td>
						<td width="33%">
							<input name="UI" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=order.getUI()%>" />
						</td>

						<td width="17%">
							二部报价单号：
						</td>
						<td width="33%">

							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=order.getOldPid()%>" />
						</td>
					</tr>
					<%
					} %>
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
								value="<%=str%><%=qt.getTotalprice() %>" />
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
							 name ="client"	size="40" value="<%=qt.getClient() %>" />
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
						
					</tr>
					<tr>
					<td>特殊说明：</td>
						<td colspan="3">
						<input name="advancetype" value="<%=order.getDetail()==null?"":order.getDetail()%>"
								type="text" size="125" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>
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
						
							<%
							String read="";
							String stype="";
							if(type==null){
							type="";
							}
							//System.out.println(type+"---------"+pidStr.split(",").length);
							if(!type.equals("modi")&&pidStr.split(",").length>1){
							 read="readonly='readonly'";
							 stype ="style='background-color: #F2F2F2'";
							}
							String va="value='" + new DecimalFormat("###########.00").format(qt.getPreadvance()) + "'"+ read +stype;
							%>
							<input name="preadvance" id="preadvance" type="text" size="40"
								<%=va%> />
								
						</td>
						<td width="17%">
							预付款收款日期：
						</td>
						<td>
							<input name=paytime id ="paytime" type="text" size="40" 
								<%=qt.getPaytime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getPaytime()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td width="132">
							收款账号：
						</td>
						<td width="263">
						<%
						if(qt.getCreditcard()==null||"".equals(qt.getCreditcard())||type.equals("modi")){
						%>
						<select name="creditcard" style="width: 300px">		
						<option value="">请选择收款帐号</option>	
						<%

							if("现金".equals(qt.getCreditcard())){
							%>
							<option value="现金" selected="selected">现金</option>		
							<%
							}else{
							%>
							<option value="现金">现金</option>		
							<%
							}
							if("建行8833".equals(qt.getCreditcard())){
							%>
							<option value="建行8833" selected="selected">建行8833</option>		
							<%
							}else{
							%>
							<option value="建行8833">建行8833</option>		
							<%
							}
							if("客户自缴机构".equals(qt.getCreditcard())){
							%>
							<option value="客户自缴机构" selected="selected">客户自缴机构</option>		
							<%
							}else{
							%>
							<option value="客户自缴机构">客户自缴机构</option>		
							<%
							}
							if("香港账户".equals(qt.getCreditcard())){
							%>
							<option value="香港账户" selected="selected">香港账户</option>		
							<%
							}else{
							%>
							<option value="香港账户">香港账户</option>		
							<%
							}
							if("立创代收机构款".equals(qt.getCreditcard())){
							%>
							<option value="立创代收机构款" selected="selected">立创代收机构款</option>		
							<%
							}else{
							%>
							<option value="立创代收机构款">立创代收机构款</option>		
							<%
							}
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
						<%	}else{
								  %>
								<input name="creditcard" id="creditcard" type="text" size="40" <%=("value='" + qt.getCreditcard() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> 					
								 <%
								 }
							 %>
						
							
								
						</td>
						<td>
							预付款收款票据：
						</td>
						<td>
					
						<%
						
						if(qt.getPaynotes()==null||"".equals(qt.getPaynotes())||type.equals("modi")){
						%>
					<select name="paynotes"  style="width: 290px">
					
					 <option value="" selected="selected">请选择收款票据</option>
					  <%
							if("发票".equals(qt.getInvtype())){
							%>
							<option value="发票" selected="selected">发票</option>		
							<%
							}else{
							%>
						<option value="发票">发票</option>
					   
							<%
							}
							if("收据".equals(qt.getInvtype())){
							%>
							<option value="收据" selected="selected">收据</option>		
							<%
							}else{
							%>
							 <option value="收据">收据</option>
							<%
							}
							%>
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
							<input name="sepay" id="sepay" type="text" size="40"
								<%=qt.getSepay()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getSepay()) + "'"+ read +stype) %> />
								
						</td>
						<td width="17%">
							二次收款日期：
						</td>
						<td>
							<input name="sepaytime" id="sepaytime" type="text" size="40" 
								<%=qt.getSepaytime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSepaytime()) + "'"+ read +stype) %> />
								
						</td>
						
					</tr>
					<tr>
						<td width="17%">
							二次收款账号：
						</td>
						<td width="33%">
						<%if(qt.getSepayacount()==null||"".equals(qt.getSepayacount())||type.equals("modi")){
	
						%>
					<select name="sepayacount" id ="sepayacount" style="width: 300px">	
					<option value="" selected="selected">请选择收款帐号</option>	
					<%	if("现金".equals(qt.getCreditcard())){
							%>
							<option value="现金" selected="selected">现金</option>		
							<%
							}else{
							%>
							<option value="现金">现金</option>		
							<%
							}
							if("建行8833".equals(qt.getCreditcard())){
							%>
							<option value="建行8833" selected="selected">建行8833</option>		
							<%
							}else{
							%>
							<option value="建行8833">建行8833</option>		
							<%
							}
							if("客户自缴机构".equals(qt.getCreditcard())){
							%>
							<option value="客户自缴机构" selected="selected">客户自缴机构</option>		
							<%
							}else{
							%>
							<option value="客户自缴机构">客户自缴机构</option>		
							<%
							}
							if("香港账户".equals(qt.getCreditcard())){
							%>
							<option value="香港账户" selected="selected">香港账户</option>		
							<%
							}else{
							%>
							<option value="香港账户">香港账户</option>		
							<%
							}
							if("立创代收机构款".equals(qt.getCreditcard())){
							%>
							<option value="立创代收机构款" selected="selected">立创代收机构款</option>		
							<%
							}else{
							%>
							<option value="立创代收机构款">立创代收机构款</option>		
							<%
							}				
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
						<%if(qt.getSepaynotes()==null||"".equals(qt.getSepaynotes())||type.equals("modi")){
						%>
					<select name="sepaynotes"  style="width: 290px">
					    <option value="" selected="selected">请选择收款票据</option>							
					   <%

							if("发票".equals(qt.getSepaynotes())){
							%>
							<option value="发票" selected="selected">发票</option>		
							<%
							}else{
							%>
						<option value="发票">发票</option>
					   
							<%
							}
							if("收据".equals(qt.getSepaynotes())){
							%>
							<option value="收据" selected="selected">收据</option>		
							<%
							}else{
							%>
							 <option value="收据">收据</option>
							<%
							}
							%>
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
							<input name="prebalance" id="prebalance" type="text" size="40" 
								<%=qt.getPrebalance()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getPrebalance()) + "'"+ read +stype) %> />
								
						</td>
						<td width="17%">
							实收尾款金额：
						</td>
						<td width="33%">
							<input name="balance" id="balance" type="text" size="40" 
								<%=qt.getBalance()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getBalance()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td>
							尾款收款账号：
						</td>
						<td>
						
						<%if(qt.getBalanceacount()==null||"".equals(qt.getBalanceacount())||type.equals("modi")){
	
						%>
					<select name="balanceacount" id ="balanceacount"  style="width: 300px">		
					<option value="">请选择收款帐号</option>	
						<%if("现金".equals(qt.getCreditcard())){
							%>
							<option value="现金" selected="selected">现金</option>		
							<%
							}else{
							%>
							<option value="现金">现金</option>		
							<%
							}
							if("建行8833".equals(qt.getCreditcard())){
							%>
							<option value="建行8833" selected="selected">建行8833</option>		
							<%
							}else{
							%>
							<option value="建行8833">建行8833</option>		
							<%
							}
							if("客户自缴机构".equals(qt.getCreditcard())){
							%>
							<option value="客户自缴机构" selected="selected">客户自缴机构</option>		
							<%
							}else{
							%>
							<option value="客户自缴机构">客户自缴机构</option>		
							<%
							}
							if("香港账户".equals(qt.getCreditcard())){
							%>
							<option value="香港账户" selected="selected">香港账户</option>		
							<%
							}else{
							%>
							<option value="香港账户">香港账户</option>		
							<%
							}
							if("立创代收机构款".equals(qt.getCreditcard())){
							%>
							<option value="立创代收机构款" selected="selected">立创代收机构款</option>		
							<%
							}else{
							%>
							<option value="立创代收机构款">立创代收机构款</option>		
							<%
							}				
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
							<input name="balancetime" id="balancetime" type="text" size="40" 
								<%=qt.getBalancetime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getBalancetime()) + "'"+ read +stype) %> />
						</td>
					</tr>
					<tr>
						<td width="17%">
							票据号：
						</td>
						<td width="33%">
							<input name="prebalance" id="prebalance" type="text" size="40" 
								value="<%=(qt.getInvcode()==null||"".equals(qt.getInvcode()))?"":qt.getInvcode()%>" />
								
						</td>
						<td width="17%">
							开票金额：
						</td>
						<td width="33%">
							<input name="balance" id="balance" type="text" size="40" 
										
								value="<%=str%><%=qt.getInvcount()==0?(qt.getInvprice()==0?"":new DecimalFormat("###########.00").format(qt.getInvprice())):new DecimalFormat("###########.00").format(qt.getInvcount()) %>"
								
						</td>
					</tr>
					<tr>
						<td width="17%">
							票据日期：
						</td>
						<td width="33%">
							<input name="prebalance" id="prebalance" type="text" size="40" 
								value="<%=qt.getInvtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getInvtime())%>"/>
								
						</td>
						<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;
						</td>
					</tr>
				</table>
			<p>&nbsp;</p>
		</form>
	</body>
</html>
