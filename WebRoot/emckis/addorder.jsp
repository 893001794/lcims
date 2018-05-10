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
	UserForm userF=UserAction.getInstance().getUserByName(user.getName());
	//关联旧的报价单号
	String oldPid= request.getParameter("oldPid");
	//报价单类型
	String quotype= "";
	if(request.getParameter("quotype") !=null){
	quotype=request.getParameter("quotype");
	}
	Order order;
	if(oldPid !=null || ! "".equals(oldPid)){
	int id= OrderAction.getInstance().getOrderByPid(oldPid);
	 order= OrderAction.getInstance().getOrderById(id);
	}else{
	order =new Order();
	}
	
	
	
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加报价单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/orderscript.js"></script>
		
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
		window.onload=function()
	    {//页面加载时的函数
	    	Change_Select();
	    }
	    
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"客户名称是否存在");
	    validateclient(client);
	    }
	    
	    function checkForm(TheForm) {

		if (TheForm.quotime.value == "") {
			alert ("报价日期不能为空！");
			TheForm.quotime.focus();
			return(false);
		}
		if (TheForm.completetime.value == "") {
			alert ("客户要求时间不能为空！");
			TheForm.completetime.focus();
			return(false);
		}
		if (TheForm.estimatesPoints.value == "") {
			alert ("估计测试点数不能为空！");
			TheForm.estimatesPoints.focus();
			return(false);
		}
		if (TheForm.collectionD.value == "") {
			alert ("收件时间不能为空！");
			TheForm.collectionD.focus();
			return(false);
		}
		if (TheForm.receiptD.value == "") {
			alert ("收单时间不能为空！");
			TheForm.receiptD.focus();
			return(false);
		}

		return(true);
	}
	
	function modifymoney(){
	var quotype=document.getElementById("quotype").value;
	if(quotype=="sup" || quotype=="add" || quotype=="flu"){
	var modifymoneytype=0;
	if(quotype =="sup"){
	modifymoneytype=1;
	}
	if(quotype =="add"){
	modifymoneytype=2;
	}
	if(quotype =="flu"){
	modifymoneytype=3;
	}
	self.location.href="../finance/quotation/adjustpid.jsp?type="+modifymoneytype;
	}
	}
	
	function changetype(object){
	if(!(object.value.indexOf("new") ==0)){
	document.getElementById("trpid").style.display = "";
	}else{
	document.getElementById("trpid").style.display = "none";
	}
	}
	
	function addorder(){
	var itemid1=document.getElementById("itemid1").value;
	var usetype =document.getElementById("usetype").value; //使用方式
	if(usetype == ""){
		alert("请选择使用方式！！！");
		return false;
	}	
	if(usetype=="marketRent"){
		//if(document.getElementById("amstart").value=="" && document.getElementById("pmstart").value==""){
		////alert("请输入开始时间！！！");
		//return false;
		//}
		//if(document.getElementById("amend").value==""&&document.getElementById("pmend").value==""){
		//alert("请输入结束时间！！！");
		//return false;
		//}
	}else if(usetype == "report"){
		if(document.getElementById("oldPid").value==""){
		alert("请输入二部报价单！！！");
		return false;
		}
	}
	if(itemid1 ==""){
	alert("至少要输入一项测试项目！");
	return false;
	}
		var myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addorder_post.jsp";
		myform.submit();
	
	}
	
	function checkClient(){
		 var jqueryObj = $("#client");   
     // 获取文本框中用户输入的数据   
     var client = jqueryObj.val();   
		//先检查是否有值
		jQuery.ajax({
			url:'validateclient.jsp?client='+encodeURI(encodeURI(client)),
			type:'POST',
			synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
			success:function(msg){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
			if(msg.indexOf(true) >-1){
			with (document.getElementById("quotationform")) {
					method="post";
					//action="addorder_post.jsp";
					//submit();
					}
			}else{
			alert("客户不存在，请先输入客户资料！");
			window.open("../client/addclient.jsp");
			return false;
			}
			}
		})
	}
</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="confirmUserId" id ="confirmUserId" type ="hidden" value="">
			<input name="totalprice" id="totalprice" type="hidden" value="" />
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
							<b>报价管理&gt;&gt;添加报价单</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>

						<td width="12%">
							报价单类型：
						</td>
						<td width="33%">
							<select name="quotype" id="quotype" style="width: 300px" onchange="changetype(this);">
								<option value="new"  <%=quotype.equals("new")?"selected":"" %>>
									新报价单
								</option>
							</select>
						</td>
						<td>
							分公司：
						</td>
						<td>
						<select name="companyid" id="companyid" style="width: 300px"
								onChange="ajaxChange();">
								<option value="1" selected="selected">
									中山
								</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>
							销售人员：
						</td>
						<td>
							<select name="salesid" id="salesid" style="width: 300px">
							</select>
							
						</td>
						<td width="15%">
							产品名称：
						</td>
						<td>
							<input name="product" id="product" value="" size="40">							
						</td>

					</tr>
					<tr>
						<td>
							客户：
						</td>
						<td>
						
							<input name="client" type="text" id="client" size="40"/>
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
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
						<td> 
							使用方式： 
						</td>
						<td width="33%">
							<select name="usetype" style="width: 300px" id="usetype" onchange="hidden(this.value);">
								<option value="">---选择使用方式---</option>
								<option value="marketRent">租场</option>
								<option value="report">项目</option>
							</select>
							<script type="text/javascript">
								function hidden(obj){
									if(obj=="marketRent"){
										document.getElementById("trpid").style.display = "none";
										document.getElementById("trdate").style.display = "block";
										
									}
									else if(obj=="report"){
										document.getElementById("trpid").style.display = "block";
										document.getElementById("trdate").style.display = "block";
									}
								}
							</script>
						</td>
					</tr>
					<tr style="display: none;" id ="trpid">
						<td width="350">二部报价单：</td>
						<td>
						<input type="text" size="40" id ="oldPid" name ="oldPid" onblur="getValueByPid(this);"  >
						<script>   
						        $("#oldPid").autocomplete("../pid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>   
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;</td>
					</tr>
					<!-- 
					<tr id ="trdate">
						<td>
							上午开始时间：
						</td>
						<td>
							<input name="amstart" type="text" id="amstart" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'HH:mm',el:'amstart'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							上午结束时间：
						</td>
						<td>
							<input name="amend" type="text" id="amend" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'HH:mm',el:'amend'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
					</tr>
					<tr id ="trdate">
						<td>
							下午午开始时间：
						</td>
						<td>
							<input name="pmstart" type="text" id="pmstart" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'HH:mm',el:'pmstart'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							下午结束时间：
						</td>
						<td>
							<input name="pmend" type="text" id="pmend" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'HH:mm',el:'pmend'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
					</tr> -->
					<tr>
						<td>
							收件日期
						</td>
						<td>
							<input name="collectionD" type="text" id="collectionD" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'yyyy.MM.dd',el:'collectionD'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						
						<td>
							测试日期
						</td>
						<td>
							<input name="testD" type="text" id="testD" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'yyyy.MM.dd',el:'testD'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
					</tr>
					<tr>
						<td>
							收单日期
						</td>
						<td>
							<input name="receiptD" type="text" id="receiptD" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'yyyy.MM.dd',el:'receiptD'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							流水号;
						</td>
						<td>
							<input name="UI" type="text" id="UI" size="40"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" border="1">
					<tr>
						<td width="3%">
							<div align="center">
								行号
							</div>
						</td>
						<td width="6%">
							<div align="center">
								代码
							</div>
						</td>
						<td width="16%">
							<div align="center">
								测试项目
							</div>
						</td>
						<td width="16%">
							<div align="center">
								样品名称
							</div>
						</td>
						<td width="16%">
							<div align="center">
								标准价
							</div>
						</td>
						<td width="16%">
							<div align="center">
								实际价
							</div>
						</td>
						<td width="9%">
							<div align="center">
								测试小时数
							</div>
						</td>
						<td width="9%">
							<div align="center">
								小计
							</div>
						</td>
						<td width="15%">
							<div align="center">
								备注
							</div>
						</td>
						
					</tr>
					<%
					for(int i=1;i<11;i++) {
					 %>
					<tr>
						<td>
							<div align="center">
								<%=i%>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="itemid<%=i%>" name="itemid" size="8.7" onblur="clearAll('<%=i %>');">
								<script type="text/javascript">
									showitem('<%=i%>');
								</script>
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemname<%=i%>" name="itemname" size="25" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="samplename<%=i%>" name="samplename" size="25">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i%>" name="saleprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="price<%=i%>" name="price" size="13" value="0">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i%>" name="itemcount" size="13" onBlur="getTotal('<%=i %>');">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onchange="sumTotalprice();">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i%>" name="remark" size="23">
							</div>
						</td>
						
					</tr>
					<%} %>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							付款方式：
						</td>
						<td width="33%">
							<select name="advancetypeid" style="width: 300px">
								<%
								Map<String,String> advancetypes = FlowFinal.getInstance().getAdvancetype();
								for(String value:advancetypes.keySet()) {
										if(Integer.parseInt(value)>8){
								%>
								<option value="<%=value %>" ><%=advancetypes.get(value) %></option>
								<%
								 }
								 }
								  %>
							</select>
							
						</td>
						<td width="17%">
							票据类型：
						</td>
						<td>
							<select name="invtype" style="width: 300px">
							<option value="发票" selected>
									发票
								</option>
								<option value="全额">
									全额
								</option>
								<option value="不含机构费用">
									不含机构费用
								</option>
								<option value="借开">
									借开
								</option>
								<option value="收据">
									收据
								</option>
							</select>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							开票抬头：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="invhead" id="invhead" type="text" size="40"
								value="<%=order.getInvhead() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="invhead" id="invhead" type="text" size="40"
								onFocus="getinvhead(this);" />
								<%} %>
						</td>
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%" align="left">
							<input name="invcount" id="invcount" type="text" size="40"
								onFocus="getinvprice(this);" />
						</td>
					</tr>

				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							备注：
						</td>
						<td width="83%">
							<input name="tag" id="tag" type="text" size="77" />
					  </td>

					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊说明：
						</td>
						<td width="83%">
							<input name="detail" id="detail" type="text" size="77" />
					  </td>

					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
			<!-- addorder('<%=userF.getDept() %>') -->
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存订单" onClick="addorder();">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
