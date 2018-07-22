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
	float chem=0.0f; //化学项目总报价单金额，传到”入账页面“
	float safe=0.0f; //安全项目总报价单金额，传到”入账页面“
	float op=0.0f; //化学项目总报价单金额，传到”入账页面“
	float emc=0.0f; //化学项目总报价单金额，传到”入账页面“
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
		
		function fincome(chem,safe,op,emc) {
			var vpid =document.getElementById("pid").value;
				vpid=vpid.substring(0,vpid.length-1);
			with (document.getElementById("form1")) {
				method="post";
				action="../../cashcount/fincome.jsp?pid="+vpid+"&chem="+chem+"&safe="+safe+"&op="+op+"&emc="+emc;
				submit();
			}
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
							&nbsp;
							<b>财务管理&gt;&gt;款项登记</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" id="form1" method="post" action="quotationlog_post.jsp" onsubmit="return addtextarea();" >
			<input name="pageNo" value="<%=pageNo %>" type="hidden"/>
			<input type="hidden" value="<%=pidStr%>" id="pidStr" name ="pidStr">
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input id="pid" name="pid" size="40" type="text"
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
								 //後面添加的參數
								if("现金".equals(qt.getCreditcard())){
								%>
								<option value="现金" selected="selected">现金</option>		
								<%
								}else{
								%>
								<option value="现金">现金</option>		
								<%
								}
								if("香港公账".equals(qt.getCreditcard())){
							%>
							<option value="香港公账" selected="selected">香港公账户</option>		
							<%
							}else{
							%>
							<option value="香港公账">香港公账</option>		
							<%
							}	
								if("香港私账".equals(qt.getCreditcard())){
							%>
							<option value="香港私账" selected="selected">香港私账</option>		
							<%
							}else{
							%>
							<option value="香港私账">香港私账</option>		
							<%
							}
							
							if("客户自缴机构".equals(qt.getCreditcard())){
							%>
							<option value="客户自缴机构" selected="selected">客户自缴机构</option>		
							<%
							}
							if("香港账户".equals(qt.getCreditcard())){
							%>
							<option value="香港账户" selected="selected">香港账户</option>		
							<%
							}
							if("立创代收机构款".equals(qt.getCreditcard())){
							%>
							<option value="立创代收机构款" selected="selected">立创代收机构款</option>		
							<%
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
					
					<select name="paynotes"  style="width: 290px">
					
					 <option value="" selected="selected">请选择收款票据</option>
					 <%
					 		String paynotes=qt.getInvtype();
					 		if(qt.getPaynotes() !=null &&!qt.getPaynotes().equals("")){
					 		paynotes=qt.getPaynotes() ;
					 		}
					 		if("发票".equals(paynotes)){
							%>
							<option value="发票" selected="selected">发票</option>		
							<%
							}
							if("形式发票".equals(paynotes)){
							%>
						<option value="形式发票" selected="selected">形式发票</option>
						<%
							}else{
						%>
						<option value="形式发票">形式发票</option>
						<%
						}
						if("普通发票".equals(paynotes)){
							%>
							<option value="普通发票" selected="selected">普通发票</option>		
							<%
							}else{
							%>
						<option value="普通发票">普通发票</option>
						  <%
						  }
							if("专用发票".equals(paynotes)){
							%>
							<option value="专用发票" selected="selected">专用发票</option>		
							<%
							}else{
							%>
						<option value="专用发票">专用发票</option>
						  <%
						  }
							if("收据".equals(paynotes)){
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
						<%
							Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
							for(String value:banks.keySet()) {
									if(banks.get(value).equals(qt.getBalanceacount())){
									 %>
										<option value="<%=banks.get(value)%>"<%=banks.get(value)!=null&&qt.getCreditcard().equals(banks.get(value))?"selected":""%>><%=banks.get(value) %></option>
								<%
									 }	else {
									  %>
									  <option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
									  <%
									 }
							 }	
								 //後面添加的參數
								 if("建行8833".equals(qt.getSepayacount())){
									%>
									<option value="建行8833" selected="selected">建行8833</option>		
									<%
									}else{
									%>
									<option value="建行8833">建行8833</option>		
									<%
									}
								if("现金".equals(qt.getSepayacount())){
								%>
								<option value="现金" selected="selected">现金</option>		
								<%
								}else{
								%>
								<option value="现金">现金</option>		
								<%
								}
								if("香港公账".equals(qt.getSepayacount())){
							%>
							<option value="香港公账" selected="selected">香港公账户</option>		
							<%
							}else{
							%>
							<option value="香港公账">香港公账</option>		
							<%
							}	
								if("香港私账".equals(qt.getSepayacount())){
							%>
							<option value="香港私账" selected="selected">香港私账</option>		
							<%
							}else{
							%>
							<option value="香港私账">香港私账</option>		
							<%
							}
							
							if("客户自缴机构".equals(qt.getSepayacount())){
							%>
							<option value="客户自缴机构" selected="selected">客户自缴机构</option>		
							<%
							}
							if("香港账户".equals(qt.getSepayacount())){
							%>
							<option value="香港账户" selected="selected">香港账户</option>		
							<%
							}
							if("立创代收机构款".equals(qt.getSepayacount())){
							%>
							<option value="立创代收机构款" selected="selected">立创代收机构款</option>		
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
					<select name="sepaynotes"  style="width: 290px">
					    <option value="" selected="selected">请选择收款票据</option>	
					    		
					   <%
					   	String sepaynotes="";
					   	if(qt.getSepaynotes()!=null&& !"".equals(qt.getSepaynotes())){
					   	sepaynotes=qt.getSepaynotes();
					   	}
					  	 if("发票".equals(sepaynotes)){
							%>
							<option value="发票" selected="selected">发票</option>		
							<%
							}
						 if("形式发票".equals(sepaynotes)){
							%>
						<option value="形式发票" selected="selected">形式发票</option>
						<%
						}else{
						%>
						<option value="形式发票">形式发票</option>
						<%
						}
						if("普通发票".equals(sepaynotes)){
							%>
							<option value="普通发票" selected="selected">普通发票</option>		
							<%
							}else{
							%>
						<option value="普通发票">普通发票</option>
						  <%
						  }
							if("专用发票".equals(sepaynotes)){
							%>
							<option value="专用发票" selected="selected">专用发票</option>		
							<%
							}else{
							%>
						<option value="专用发票">专用发票</option>
						  <%
						  }
							if("收据".equals(sepaynotes)){
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
						<%
							Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
							for(String value:banks.keySet()) {
									if(banks.get(value).equals(qt.getBalanceacount())){
									 %>
										<option value="<%=banks.get(value)%>"<%=banks.get(value)!=null&&qt.getCreditcard().equals(banks.get(value))?"selected":""%>><%=banks.get(value) %></option>
								<%
									 }	else {
									  %>
									  <option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
									  <%
									 }
							 }	
								 //後面添加的參數
								 if("建行8833".equals(qt.getBalanceacount())){
									%>
									<option value="建行8833" selected="selected">建行8833</option>		
									<%
									}else{
									%>
									<option value="建行8833">建行8833</option>		
									<%
									}
								if("现金".equals(qt.getBalanceacount())){
								%>
								<option value="现金" selected="selected">现金</option>		
								<%
								}else{
								%>
								<option value="现金">现金</option>		
								<%
								}
								if("香港公账".equals(qt.getBalanceacount())){
							%>
							<option value="香港公账" selected="selected">香港公账户</option>		
							<%
							}else{
							%>
							<option value="香港公账">香港公账</option>		
							<%
							}	
								if("香港私账".equals(qt.getBalanceacount())){
							%>
							<option value="香港私账" selected="selected">香港私账</option>		
							<%
							}else{
							%>
							<option value="香港私账">香港私账</option>		
							<%
							}
							
							if("客户自缴机构".equals(qt.getBalanceacount())){
							%>
							<option value="客户自缴机构" selected="selected">客户自缴机构</option>		
							<%
							}
							if("香港账户".equals(qt.getBalanceacount())){
							%>
							<option value="香港账户" selected="selected">香港账户</option>		
							<%
							}
							if("立创代收机构款".equals(qt.getBalanceacount())){
							%>
							<option value="立创代收机构款" selected="selected">立创代收机构款</option>		
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
							<input name="balancetime" id="balancetime" type="text" size="40" 
								<%=qt.getBalancetime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getBalancetime()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
					<td width="116">
							收款备注：
						</td>
						<td width="593" colspan="3">
						<!-- onfocus="addtextarea();" -->
							<textarea name="collRemarks" id ="collRemarks" rows="6" cols="120" onfocus="addtextarea();"><%=qt.getCollRemarks()==null?"":qt.getCollRemarks()%></textarea>
						</td>
					</tr>
					<tr>

						<td>
							项目退款金额：
						</td>
						<td>
							<input name="refund" type="text" size="40" 
								<%=qt.getRefund()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getRefund()) + "'"+ read +stype) %> />
						</td>
						<td>
							尾款收款票据：
						</td>
						<td>
						<select name="balancenotes"  style="width: 290px">
						
					    <option value="" selected="selected">请选择收款票据</option>		
					  <%
					  		String balancenotes="";
					  		if(qt.getBalancenotes() !=null&&!"".equals(qt.getBalancenotes())){
					  		balancenotes=qt.getBalancenotes();
					  		}
					  		 if("发票".equals(balancenotes)){
							%>
							<option value="发票" selected="selected">发票</option>		
							<%
							}
							if("形式发票".equals(balancenotes)){
							%>
							<option value="形式发票" selected="selected">形式发票</option>
							<%
							}else{
							%>
							<option value="形式发票">形式发票</option>
							<%
							}
							if("普通发票".equals(balancenotes)){
							%>
							<option value="普通发票" selected="selected">普通发票</option>		
							<%
							}else{
							%>
						<option value="普通发票">普通发票</option>
						  <%
						  }
							if("专用发票".equals(balancenotes)){
							%>
							<option value="专用发票" selected="selected">专用发票</option>		
							<%
							}else{
							%>
						<option value="专用发票">专用发票</option>
						  <%
						  }
							if("收据".equals(balancenotes)){
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
			<%
			//if(user.getId()!=158){
			 %>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊接待费预算：
						</td>
						<td width="33%">
							<input name="prespefund" type="text" size="40" 
								value="<%=qt.getPrespefund()==0?"":new DecimalFormat("###########.00").format(qt.getPrespefund()) %>" />
								
						</td>
						<td width="17%">
							实际特殊接待费：
						</td>
						<td width="33%">
							<input name="spefund" type="text" size="40" 
								<%=qt.getSpefund()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getSpefund()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td>
							特殊接待费支付方式：
						</td>
						<td>
						<%
						if(qt.getSpefundtype()==null||"".equals(qt.getSpefundtype())||type.equals("modi")){
						%>
						<select name="spefundtype" style="width: 300px">		
						<option value="" selected="selected">请选择特殊接待费支付方式</option>
						<option value="现金">现金</option>									
						<option value="建行3079">建行3079</option>									
						<option value="建行1050">建行1050</option>	
						<option value="中行6647">中行6647</option>	
						<option value="工行5919">工行5919</option>									
															

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
								<%=qt.getSpefundtime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSpefundtime()) + "'"+ read +stype) %> />
								
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
			<%
			//} 
			%>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="116">
							开票方式：
						</td>
						<td width="168">
							<select name="invtype" style="width: 300px">
								<option value="专用发票" <%=qt.getInvtype().equals("专用发票")?"selected":"" %>>
									专用发票
								</option>
								<%--<option value="发票" <%=qt.getInvtype().equals("发票")?"selected":"" %>>
										发票
								</option>--%>
								<option value="普通发票" <%=qt.getInvtype().equals("普通发票")?"selected":"" %> >
									普通发票
								</option>
								<option value="形式发票" <%=qt.getInvtype().equals("形式发票")?"selected":"" %> >
									形式发票
								</option>
								<option value="收据"  <%=qt.getInvtype().equals("收据")?"selected":"" %>>
									收据
								</option>
							</select>
							<!--	
							<input name="invtype" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvtype()==null?"":qt.getInvtype() %>"/>
								
								  -->
						</td>
						<td width="17%">
							票据编号：
						</td>
						<td width="33%">
							<input name="invcode" type="text" size="40" 
								<%=(qt.getInvcode()==null||"".equals(qt.getInvcode()))?"":("value='" + qt.getInvcode() + "'") %> />
								
						</td>
						
					</tr>
					<tr>
						<td width="132">
							开票总金额：
						</td>
						<td width="263">
							<input name="invcount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly" value="<%=str%><%=qt.getInvcount()==0?"":new DecimalFormat("###########.00").format(qt.getInvcount()) %>"/>
						</td>
						<td width="132">
							实际开票金额：
						</td>
						<td width="263">
							<input name="invprice" type="text" size="40" 
								<%=qt.getInvprice()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getInvprice()) + "'") %> />
									
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
						float sun=0.0f;
							if(qt.getPreadvance()!=0 && qt.getInvtype().indexOf("发票")>-1){
							sun +=qt.getPreadvance()*0.08;
							}
							if(qt.getSepay()!=0 && qt.getInvtype().indexOf("发票")>-1){
							sun +=qt.getSepay()*0.08;
							}
							if(qt.getPrebalance()!=0 && qt.getInvtype().indexOf("发票")>-1){
						
							sun +=qt.getPrebalance()*0.08;
							}
						 %>
						 <input name="tax" type="text" size="40" value="<%=sun%>" style="background-color: #F2F2F2" readonly="readonly"/>	
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
						
							<!-- <input name="othercost" type="text" size="40" value="<%=qt.getSumOtherscost()==0?"":qt.getSumOtherscost() %>"/>-->	
							 <input name="othercost" type="text" size="40" value="<%=qt.getOthercost()==0?"":qt.getOthercost() %>"/>	

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
						<td width="17%">,
						</td>
						<td width="33%">
							<input name="acount" type="text" size="40" readonly='readonly' onFocus="getAcount(this)" 
								<%=qt.getAcount()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getAcount()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						<td width="17%">
							坏账扣款：
						</td>
						<td width="33%">
							<input name="badDebt" type="text" size="40"  value='<%=qt.getBadDebt()==null?"":qt.getBadDebt()%>'  />
						</td>
						<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;
						</td>
					</tr>
				</table>
				<p>
					<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5" border="1">
					<tr bgcolor="#A9F5F2">
					 <td>报告编号</td>
					 <td>项目</td>
					 <td>报告应出时间</td>
					 <td>分项目金额</td>
					 <td>实际分包费A</td>
					 <td>实际分包费B</td>
					 <td>业绩核算基数</td>
					 <td>业绩结算基数</td>
					 <td>操作</td>
					</tr>
				<%
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					Date rptime = null;
					System.out.println(p.getPtype());
					if(!("化学测试".equals(p.getPtype())||"化妆品".equals(p.getPtype())||"环境".equals(p.getPtype()))) {
					//if(!("化学测试".equals(p.getPtype())||!"化妆品".equals(p.getPtype()))) {
						PhyProject pp = (PhyProject)p.getObj();
						rptime = pp.getRptime();
						if(p.getPtype().indexOf("光性能")>-1){
							op+=p.getPrice();
						}else if(p.getPtype().indexOf("安全")>-1){
							safe+=p.getPrice();
						}else if(p.getPtype().indexOf("EMC")>-1){
							emc+=p.getPrice();
						}
					} else {
						ChemProject cp = (ChemProject)p.getObj();
						rptime = cp.getRptime();
						chem+=p.getPrice();
					}
					
				 %>
					<tr>
						<td><%=p.getRid() %></td>
						<td><%=p.getPtype()%></td>
						<td><%=rptime %></td>
						<td><%=p.getPrice() %></td>
						<td><%=p.getSubcost()%></td>
						<td><%=p.getSubcost2()%></td>
						<td><%=p.getPpreacount() %></td>
						<td><%=p.getPacount() %></td>
						<td><a href="../project/projectlog.jsp?sid=<%=p.getSid() %>&ptype=<%=URLEncoder.encode(p.getPtype(),"UTF-8") %>" style="color: blue">分项目款项</a></td>
					</tr>
				<%
				}
				 %>
				</table>
			</div>
				<br>
				<br>
				<!-- 2013-2-23添加了一个div，就是下面的div -->
				<div class="outborder">
					<table width="100%">
					<tr>
						<td width="73%">
								<table width="100%"  cellpadding="5" cellspacing="5" border="1">
									<tr bgcolor="#A9F5F2">
											<td  >
												项目名
											</td>
											<td>
												业绩
											</td>
											<td >
												预估分包费
											</td>
											<td>
												机构费
											</td>
											<td >
												拆分费
											</td>
											
										</tr>
										
										<%
										
										//小计
										float Sassist=0f;
										float Spresubcost=0f;
										float Spreeagcost=0f;
										float Service=0f;
										List temp =new ArrayList();
										List ZOList=new ArrayList();
										float nu0=0;
										float nu1=1;
										float nu2=0.3f;
										float nu3=0.7f;
										float nu4=0.4f;
										float nu5=0.6f;
										float nu6=0.35f;
										float nu7=0.65f;
										
										//化学测试C、电子电器安全测试S、EMC测试E、光性能测试P、能效测试N
										temp.add("化学测试");
										temp.add("电子电器安全测试");
										temp.add("光性能测试");
										temp.add("EMC测试");
										temp.add("能效测试");
										float Z=0.0f;
										List ZList=new ArrayList();//能效数组
										
										List CIList=new ArrayList();//化学出纳数组;
										List SIList=new ArrayList();//安全出纳数组
										List EIList=new ArrayList();//EMC出纳数组
										List PIList=new ArrayList();//光能出纳数组
										List NIList=new ArrayList();//能效出纳数组
										
										List COList=new ArrayList();//化学入纳数组
										List SOList=new ArrayList();//安全入纳数组
										List POList=new ArrayList();//光能入纳数组
										List EOList=new ArrayList();//EMC入纳数组
										List NOList=new ArrayList();//能效入纳数组
										
										List ZIList=new ArrayList();
										float Z1=0f;
										float A=0f;
										float S=0f;
										//float a1=0f;
										for(int i=0;i<temp.size();i++){
											String ptype=temp.get(i).toString();
											List inforList=DaoFactory.getInstance().getProjectPrice().cashier(pid,ptype); //5行3列
											if(inforList !=null && inforList.size()>0){
												List cloums=(List)inforList.get(0);
												Z1+=Float.parseFloat(cloums.get(0).toString());
												//System.out.println(Z1+"---Z1");
												A+=Float.parseFloat(cloums.get(1).toString());
												S+=Float.parseFloat(cloums.get(2).toString());
											}
										//a1=Float.parseFloat(cloums.get(0).toString());
										}
										
										for(int i=0;i<temp.size();i++){
											String ptype=temp.get(i).toString();
											List inforList=DaoFactory.getInstance().getProjectPrice().cashier(pid,ptype); //5行3列
											if(inforList !=null && inforList.size()>0){
												List cloums=(List)inforList.get(0);
										//Z1+=Float.parseFloat(cloums.get(0).toString());
										//------------------------------------------------------------
												for(int j=0;j<15;j++){
													//化学使用的公式
													if(pid.indexOf("LCQ1")>-1){
													//化学的第一行
														if(i==0){
															if(j<3){
																CIList.add(nu1);
																COList.add(nu0);
															}else if(j==5){
																CIList.add(nu2);
																COList.add(-nu3);
															}else if(j==8){
																CIList.add(nu4);
																COList.add(-nu5);
															}else if(j==11){
																CIList.add(nu6);
																COList.add(-nu7);
															}else if(j>11){
																CIList.add(nu0);
																COList.add(nu0);
															}else {
																CIList.add(nu0);
																COList.add(-nu1);
															}
														}
														if(i==1){
															if(j>2&&j<5){
																SIList.add(nu1);
																SOList.add(-nu1);
															}else if(j==5){
																SIList.add(nu3);
																SOList.add(nu0);
															}else{
																SIList.add(nu0);
																SOList.add(nu0);
															}
														}
														if(i==2){
															if(j>5&&j<8){
																PIList.add(nu1);
																POList.add(-nu1);
															}else if(j==8){
																PIList.add(nu5);
																POList.add(nu0);
															}else{
																PIList.add(nu0);
																POList.add(nu0);
															}
														}
														if(i==3){
															if(j>8&&j<11){
																EIList.add(nu1);
																EOList.add(-nu1);
															}else if(j==11){
																EIList.add(nu7);
																EOList.add(nu0);
															}else{
																EIList.add(nu0);
																EOList.add(nu0);
															}
														}
														if(i==4){
															NIList.add(nu0);
															NOList.add(nu0);
														}
													}
													if(pid.indexOf("LCQ2")>-1){
													//化学的第一行
														if(i==0){
															if(j<2){
																CIList.add(nu1);
																COList.add(-nu1);
															}else if(j==2){
																CIList.add(nu7);
																COList.add(nu0);
															}else {
																CIList.add(nu0);
																COList.add(nu0);
															}
														}
														if(i==1){
															if(j<2){
																SIList.add(nu0);
																SOList.add(-nu1);
															}else if(j==2){
																SIList.add(nu6);
																SOList.add(-nu7);
															}else if(j>2&&j<6){
																SIList.add(nu1);
																SOList.add(nu0);
															}else if(j>5&&j<8){
																SIList.add(nu0);
																SOList.add(-nu1);
															}else if(j==8){
																SIList.add(nu4);
																SOList.add(-nu5);
															}else if(j>8&&j<11){
																SIList.add(nu0);
																SOList.add(-nu1);
															}else if(j==11){
																SIList.add(nu6);
																SOList.add(-nu7);
															}else{
																SIList.add(nu0);
																SOList.add(nu0);
															}
														}
														if(i==2){
															if(j>5&&j<8){
																PIList.add(nu1);
																POList.add(-nu1);
															}else if(j==8){
																PIList.add(nu5);
																POList.add(nu0);
															}else{
																PIList.add(nu0);
																POList.add(nu0);
															}
														}
														if(i==3){
															if(j>8&&j<11){
															EIList.add(nu1);
															EOList.add(-nu1);
															}else if(j==11){
															EIList.add(nu7);
															EOList.add(nu0);
															}else{
															EIList.add(nu0);
															EOList.add(nu0);
															}
														}
														if(i==4){
															NIList.add(nu0);
															NOList.add(nu0);
														}
													}
																
													if(pid.indexOf("LCQG")>-1){
													//化学的第一行
														if(i==0){
															if(j<2){
															CIList.add(nu1);
															COList.add(-nu1);
															}else if(j==2){
															CIList.add(nu7);
															COList.add(nu0);
															}else {
															CIList.add(nu0);
															COList.add(nu0);
															}
														}
														if(i==1){
															if(j>2&&j<5){
															SIList.add(nu1);
															SOList.add(-nu1);
															}else if(j==5){
															SIList.add(nu3);
															SOList.add(nu0);
															}else{
															SIList.add(nu0);
															SOList.add(nu0);
															}
														}
														if(i==2){
															if(j<2){
															PIList.add(nu0);
															POList.add(-nu1);
															}else if(j==2){
															PIList.add(nu6);
															POList.add(-nu7);
															}else if(j>2&&j<5){
															PIList.add(nu0);
															POList.add(-nu1);
															}else if(j==5){
															PIList.add(nu2);
															POList.add(-nu3);
															}else if(j>5&&j<9){
															PIList.add(nu1);
															POList.add(nu0);
															}else if(j>8&&j<11){
															PIList.add(nu0);
															POList.add(-nu1);
															}else if(j==11){
															PIList.add(nu6);
															POList.add(-nu7);
															}else{
															PIList.add(nu0);
															POList.add(nu0);
															}
														}
														if(i==3){
															if(j>8&&j<11){
															EIList.add(nu1);
															EOList.add(-nu1);
															}else if(j==11){
															EIList.add(nu7);
															EOList.add(nu0);
															}else{
															EIList.add(nu0);
															EOList.add(nu0);
															}
														}
														if(i==4){
															NIList.add(nu0);
															NOList.add(nu0);
														}
											}
												
										}
								
										//------------------------------------------------------------
										%>
									<tr align="left">
										<td>
											<%=ptype%>
										</td>
										<%
										if(inforList.size()>0){
											for(int j=0; j<cloums.size();j++){
													float S1=0f;
													float S2=0f;
													float acount=qt.getAcount(); //总业绩
													float tax=0f; //总税金
													if(qt.getInvtype()!=null&& qt.getInvtype().indexOf("发票")>-1){
														tax=qt.getTotalprice()*0.08f;
													}
													//System.out.println(Float.parseFloat(cloums.get(0).toString()));
													float G=Float.parseFloat(cloums.get(0).toString())/Z1;//业绩+税金
													float prespefund=qt.getPrespefund() ; //特殊接待费
													float presubcost=Float.parseFloat(cloums.get(1).toString());//分包
													float preagcost=Float.parseFloat(cloums.get(2).toString());//机构
													//S2=Z+tax+prespefund+presubcost+preagcost+
													//项目业绩
													Z=G*(qt.getTotalprice()-A-S-prespefund-tax);
													//化学
													if(j>0){
													ZList.add(cloums.get(j));
													}
												%>
												<td>
												<%=cloums.get(j)%>
												</td>
												<%
											}
											ZList.add(Z);
											if(i==0){
											ZIList.add(CIList);
											ZOList.add(COList);
											}
											if(i==1){
											ZIList.add(SIList);
											ZOList.add(SOList);
											}
											
											if(i==2){
											ZIList.add(PIList);
											ZOList.add(POList);
											}
											if(i==3){
											ZIList.add(EIList);
											ZOList.add(EOList);
											}
											if(i==4){
											ZIList.add(NIList);
											ZOList.add(NOList);
											}
										}
									
										Sassist+=Float.parseFloat(cloums.get(0).toString());
										Spresubcost+=Float.parseFloat(cloums.get(1).toString());
										Spreeagcost+=Float.parseFloat(cloums.get(2).toString());
										Service+=Z;
																							
										 %>
										 <td>
										 	<%=Z==0.0?0:Z%>
										 </td>
										
									</tr>
													<%
											}
									}
										 %>
										 <tr>
										 	<td>
												小计
											</td>
											<td>
												<%=Sassist%>
											</td>
											<td >
												<%=Spresubcost%>
											</td>
											<td>
												<%=Spreeagcost%>
											</td>
											<td >
												<%=Service%>
											</td>
										 </tr>
									</table>
						</td>
						<td>
								<%
								for(int i=0;i<ZList.size();i++){
									//System.out.print(ZList.get(i)+"--");
								}
								for(int i=0;i<ZOList.size();i++){
									List cloums =(List)ZOList.get(i);
									for(int j=0;j<cloums.size();j++){
									//	System.out.print(cloums.get(j)+"**");
									}
									//System.out.println();
								}
								
								 %>
								<table width="100%" cellpadding="5" cellspacing="5" border="1">
									<tr bgcolor="#A9F5F2">
											
											<td>
												入纳
											</td>
											<td>
												出纳
											</td>
											<td>
												账户应收入
											</td>
										</tr>
										<%
										//System.out.println("Prespefund:"+qt.getPrespefund());
										//System.out.println("tax:"+sun);
									float ICashier=0.0f;
									float ICashierStr=0.0f; //账户应收
									float ZICashierStr=0.0f; //总账户应收
									float OCashier=0.0f;
									float ZICashier=0.0f;
									float ZOCashier=0.0f;
									float a=0f;
									float b=0f;
									float c=0f;
									for(int i=0;i<ZIList.size();i++){
									ICashier=0;
									OCashier=0;
									//System.out.println(ZIList.size());
											List cloums =(List)ZIList.get(i);
											List cloums1 =(List)ZOList.get(i);
											for(int j=0;j<cloums.size();j++){
												//ZList.size()
												a=Float.parseFloat(ZList.get(j).toString());
												b=Float.parseFloat(cloums.get(j).toString());
												//c=Float.parseFloat(cloums1.get(j).toString());
												ICashier+=a*b;
											}
											
											for(int j=0;j<cloums1.size();j++){
												//ZList.size()
												a=Float.parseFloat(ZList.get(j).toString());
												//b=Float.parseFloat(cloums.get(j).toString());
												c=Float.parseFloat(cloums1.get(j).toString());
												//ICashier+=a*b;
												OCashier+=a*c;
												//System.out.print(ICashier+"-j-");
											}
											ZICashier+=ICashier;
											ZOCashier+=OCashier;
											
											float acount=qt.getAcount(); //总业绩
											float tax=qt.getTotalprice()*0.08f; //总税金
											if((qt.getPid().indexOf("LCQ1")>-1&&i==0)||(qt.getPid().indexOf("LCQ2")>-1&&i==1)||(qt.getPid().indexOf("LCQG")>-1&&i==2)||(qt.getPid().indexOf("LCQE")>-1&&i==3)){
											if(qt.getInvtype() !=null && qt.getInvtype().indexOf("发票")>-1){
											ICashierStr=ICashier+qt.getPrespefund()+(qt.getTotalprice()*0.08f);
												}else{
												ICashierStr=ICashier+qt.getPrespefund();
												}
											}else{
												ICashierStr=ICashier;
											}
												ZICashierStr+=ICashierStr;
											
										%>
										<tr>
												 <td>
												 	<%=ICashier%>
												 </td>
										
												 <td>
												 	<%=OCashier%>
												 </td>
												  <td>
												 	<%=ICashierStr%>
												 </td>
											</tr>
										<%} %>
										<tr>
												 <td>
												 	<%=ZICashier%>
												 </td>
										
												 <td>
												 	<%=ZOCashier%>
												 </td>
												 <td>
												 	<%=ZICashierStr%>
												 </td>
											</tr>
									</table>
						</td>
					</tr>
					</table>
				</div>
			</div>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
			<%if(user.getId()!=233){
						%>
				<input name="btnModify" class="button1" type="button"
				id="btnModify" value="打印内部对账单" onClick="printstatement()">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="款项更新">
				&nbsp;
				
				<input type="button" name ="lock" id="lock" value="<%=lockStr%>" onClick="lock1('<%=qt.getPid()%>','<%=qt.getLock()%>')">&nbsp;&nbsp;
				<%
				}
				 %>
				 
				<input name="btnBack" class="button1" type="button" id="btnBack" value="入账" onClick="fincome('<%=chem%>','<%=safe%>','<%=op%>','<%=emc%>')" />
				<input name="btnBack" class="button1" type="button" id="btnBack" value="返回" onClick="goBack()" />
			</div>
			<p>&nbsp;</p>
		</form>
	</body>
</html>
