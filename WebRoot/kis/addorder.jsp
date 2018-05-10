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
	UserForm userF=UserAction.getInstance().getUserById(user.getId());
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
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
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
	    
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"客户名称是否存在");
	    validateclient(client);
	    }
	    
      function ajaxChange(){
	    Change_Select();
	    servinfo();
	    }
	    function checkForm(TheForm) {

		if (TheForm.quotime.value == "") {
			alert ("报价日期不能为空！");
			TheForm.quotime.focus();
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
	
	function addorder(obj){
	var quotype=document.getElementById("quotype").value;
	var quotime=document.getElementById("quotime").value;
	var itemid1=document.getElementById("itemid1").value;
	var circle=document.getElementById("circle").value;
	if(quotype == ""){
	alert("请选择报价单类型！");
	return false;
	}
	if(circle == ""){
	alert("周期不能为空！");
	return false;
	}
	
	
	if(quotime == ""){
	alert("报价日期不能为空！");
	return false;
	}
	
	
	
	
	if(itemid1 ==""){
	alert("至少要输入一项测试项目！");
	return false;
	}
	var quotype =document.getElementById("quotype").value;
	if(!(quotype.indexOf("new") == 0)){
	var oldPid =document.getElementById("oldPid").value;
		if(oldPid ==""){
		alert("关联旧报价单不能为空！！");
		return false;
		}
		if(quotype =="flu"){
		var remark =document.getElementById("remark1").value;
			if(remark == ""){
			alert("备注文本框不能为空对象！！");
			return false;
			}
		}
		}
	var rpClient=document.getElementById("rpClient").value;
	 if(rpClient == null){
	 alert("报告客户不能为空对象！！！！")  
	 return false;
	 } 
		
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
			var companyid=document.getElementById("companyid").value;//获取公司id
			//alert("部门:"+obj+"----分公司:"+companyid);
			if(companyid ==1 && obj =="销售一部"){ //如果是中山的并且是销售一部的才做判断
			//alert("近年来 ");
			checkPrice();//检查和验证销售在项目报价是否低于其控制价格范围内
			}else{
			//如果是销售二部或者是中山以外的就不作判断
			with (document.getElementById("quotationform")) {
					method="post";
					action="addorder_post.jsp";
					submit();
					}
			}
			
			}else{
			alert("客户不存在，请先输入客户资料！");
			window.open("../client/addclient.jsp");
			return false;
			}
			}
		})
		
	}
	
	function checkSubmit(obj){
	var client;
	if(obj == 1){
	  var jqueryObj = $("#client");   
     // 获取文本框中用户输入的数据   
      client = jqueryObj.val(); 
	}
	if(obj == 2){
		document.getElementById("rpClient").value=document.getElementById("client").value;
	  var jqueryObj = $("#rpClient");   
     // 获取文本框中用户输入的数据   
      client = jqueryObj.val(); 
	}
		//先检查是否有值
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

	
	 var xmlHttp ;

function createXmlHttpResquest(){
try{
    xmlHttp=new ActiveXObject('Msxml2.XMLHTTP');
} catch(e){
	try{
    	xmlHttp=new ActiveXObject('Microsoft.XMLHTTP');//IE核心
	}catch(e){
       	try{
       		xmlHttp=new XMLHttpRequest();//ns、firefox核心
       	}catch(e){
       		xmlHttp = false;
       	}
	}
}
}
    function servinfo()   
    {   
   var companyid;
  // alert(parents);
   createXmlHttpResquest();
   
  
   companyid= document.getElementById("companyid").value;
  
   if(companyid ==""){
   companyid=<%=userF.getCompanyid()%>
   }
  
   xmlHttp.onreadystatechange = handleServerResponse;
   xmlHttp.open("GET", "/lcims/ajaxItem?parents="+companyid+"&stutas=3",true);
   xmlHttp.setRequestHeader( "Content-Type ",   "application/x-www-form-urlencoded");         
	//需要加入时间参数以防止缓存问题，确保每次提交的URL不同  
	xmlHttp.send(null);
    }
    
    
    
    
    function handleServerResponse(){ 
 		 if (xmlHttp.status == 200)//加载成功
        {
        document.getElementById("gridiv").innerHTML=xmlHttp.responseText;
        
        } 
	
    }
    
    function getValueByPid(obj){
    var pid=obj.value;
    var myform=document.getElementById("quotationform");
    	if(pid.length<12){
	    
	    }else{
	    		var quotype=document.getElementById("quotype").value;
	    		
	    //获取报价单类型quotype
	   // var quotype =document.getElementById("quotype").value;
	    
		   	 	if(pid !="" && quotype !="new"){
		    	myform.action ="addorder.jsp?oldPid="+pid+"&quotype="+quotype;
		    	myform.submit();
		    
		    	}
	    }
   
    }
    
  function checkPrice(){
  var str="";
  var str1="";
  	var flag=false;
  	var grade="";
  	var strcontrolprice;
   // alert(document.getElementsByName("itemid").value);
    //获取各项项目的销售报价
    var itemid=document.getElementsByName("itemid");
    //获取项目名称
    var itemname=document.getElementsByName("itemname");
    //获取标准价格
    var standprice=document.getElementsByName("standprice");
    //销售实际报价的金额
     var saleprice=document.getElementsByName("saleprice");
     //获取控制价格
     var controlprice =document.getElementsByName("controlprice");
    for(var i =0;i<itemid.length;i++){
    if(itemid[i].value !=""){
    if(standprice[i].value*0.85>saleprice[i].value){
    if(standprice[i].value*0.75>saleprice[i].value){
    strcontrolprice=standprice[i].value*0.75;
    grade="high";
    str1="只能Hadi";
    }else{
     strcontrolprice=standprice[i].value*0.85;
    str1="需要销售主管或经理";
     grade="";
    }
    str+=itemname[i].value+"报价低于"+strcontrolprice+"\n"+"\n";
    flag =true;
    }
    }
    }
    //alert(str+":输出的内容");
    if(str !="" && str !=null){
    alert(str+str1+"密码确认！");
    }
   if(flag == true){
    var ret =window.showModalDialog("verification.jsp", "newwin", "dialogHeight=10px, dialogWidth=100px,toolbar=no,menubar=no");//弹出子窗口，并且获取中只窗口的值
	$.ajax({ //调用jquery ajax
		type:"POST",  //跳转方法为POST
		//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
		url:"/lcims/verificationPwd", //跳转了路径
		data:"userName="+ret+"&grade="+grade, //传输的值或参数
        error: function(){alert("error!!");},  //如果路径错误或者参数有错的时候就弹出此窗口
		success: function(data){  //如果正确或拿到java里面传输过来的值
		    var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
		 	if(agent.attr('suc') == 'true'){ //得到名称为agent的xml对象里面suc元素，并且判断suc元素的值是否为true
		 	var userId=agent.attr('name'); //得到名称为xml对象里面的name对象
		 	document.getElementById("confirmUserId").value=userId;
		 	alert(userId);
		 	//alert(agent.attr('name'));
			alert("确认成功！");
			with (document.getElementById("quotationform")) {
					method="post";
					action="addorder_post.jsp";
					submit();
					}
			}else{
			alert("请输入密码或密码不正确");
			return false;
			}}
	});
   }else{
   with (document.getElementById("quotationform")) {
	method="post";
	action="addorder_post.jsp";
	submit();
	}
					}
   
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
						<!--  <select name="quotype" id="quotype" style="width: 300px" onchange="modifymoney();">-->
							<select name="quotype" id="quotype" style="width: 300px" onchange="changetype(this);">
								<option value="" >
									选择报价单类型
								</option>
								<option value="new"  <%=quotype.equals("new")?"selected":"" %>>
									新报价单
								</option>
								<option value="add" <%=quotype.equals("add")?"selected":"" %>>
									补充重测报价单
								</option>
								<option value="mod" <%=quotype.equals("mod")?"selected":"" %>>
									修改报告报价单
								</option>
								<option value="med" <%=quotype.equals("med")?"selected":"" %>>
									转译报告报价单
								</option>
								<option value="flu" <%=quotype.equals("flu")?"selected":"" %>>
									冲红报价单
								</option>
							</select>
						</td>
						<td>
							分公司：
						</td>
						<td>
						<%if(user.getTicketid().equals("11101111")|| user.getTicketid().equals("11111111")||user.getName().equals("古英燕[Grace]")){
						%>
						<select name="companyid" id="companyid" style="width: 300px"
								onChange="ajaxChange();">
								<option value="1" selected="selected">
									中山
								</option>
								<option value="2">
									广州
								</option>
								<option value="3">
									东莞
								</option>
							</select>
						<%
						}else{
						%>
								<input name="companyid" id="companyid" type="hidden" value="<%=userF.getCompanyid()%>" >
							       <input size="40" value="<%=userF.getCompany() %>" readonly="readonly" style="background-color: #F2F2F2">
							      
						<%
						}
						 %>
							
						</td>
					</tr>
					<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
						<tr style="display: block;" id ="trpid">
						<td width="350">关联旧报价单：</td>
						<td>
						<input type="text" size="40" id ="oldPid" name ="oldPid"  value="<%=oldPid%>">  
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;</td>
					</tr>
							<%
							}else{
							%>
					<tr style="display: none;" id ="trpid">
						<td width="350">关联旧报价单：</td>
						<td>
						<input type="text" size="40" id ="oldPid" name ="oldPid" onblur="getValueByPid(this);" >
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
<%} %>
					<tr>
						<td>
							销售人员：
						</td>
						<td>
						<!-- 从addorder.jsp页面中parseMessage()方法取值-->
							<%
							 if(user.getDept().indexOf("销售")==0 && user.getPopdom().equals("user")&&!user.getName().equals("古英燕[Grace]")){
						%>
						<input type ="hidden" value="<%=user.getId()%>" name="salesid" id="salesid">
						<input type="text" value="<%=user.getName()%>"  size="40" readonly="readonly" style="background-color: #F2F2F2">
							 <%
							 }else{
							 %>
							<select name="salesid" id="salesid" style="width: 300px">
							</select>
							<% }
							 %>
							
						</td>
						<td width="15%">
							客服人员：
						</td>
						<td>
						<%
							if(oldPid !=null && ! "".equals(oldPid)){
							%>
							<select name="servid" id="servid" style="width: 300px">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=value%>" <%=order.getService().getId()==Integer.parseInt(value)?"selected":"" %> ><%=map.get(value) %></option>
								<%
								 }
								%>
							</select>
							<%
							}else{
							%>
							<div id ="gridiv"></div>
							<%
							}
						%>
						</td>

					</tr>
					<tr>
						<td>
							客户：
						</td>
						<td>
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="client" type="text" id="client" size="40" value="<%=order.getClient().getName()==null?"":order.getClient().getName() %>" readonly="readonly"/>
							<%
							}else{
							%>
						
							<input name="client" type="text" id="client" size="40" />
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
						     <%} %>
						</td>
						<td>
							账号：
						</td>
						<td width="33%">
							<select name="bankid" style="width: 300px"  >
								<%
								 String strcompanyid = request.getParameter("companyid");
								     int companyid = 0;
								    if(strcompanyid != null && !"".equals(strcompanyid)) {
							        companyid = Integer.parseInt(strcompanyid);
							        }else{
							        	companyid=userF.getCompanyid();
							        }
									Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
									for(String value:banks.keySet()) {
									if(userF.getCompany().equals("东莞")){
									%>
										<option value="<%=value %>" <%=Integer.parseInt(value)==6?"selected":""%>><%=banks.get(value) %></option>
									<%
									}else{
									
									 %>
								<option value="<%=value %>"><%=banks.get(value)%></option>
								<%
								 }
								 	}
								 
								  %>
							</select>
						</td>
						
					</tr>
					
					<tr>
						<td>
							周期：
						</td>
						<td>
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="circle" type="text" id="circle" size="40" value="<%=order.getCircle() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="circle" type="text" id="circle" size="40"  onchange="checkSubmit(1);"/>
							<%} %>
						</td>
						<td width="10%">
							估计测试的点数：
						</td>
						<td>
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="estimatesPoints"  type="text" value="<%=order.getEstimatesPoints()%>" size="40" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="estimatesPoints" type="text" id="estimatesPoints" size="40" />
							<%} %>
						</td>
						
					</tr>
					<tr>
					<td>
							报价日期：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="quotime" type="text" id="quotime" size="40" value="<%=order.getQuotime() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="quotime" type="text" id="quotime" size="40"  value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>"/>
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'quotime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
								<%} %>
						</td>
						<td>
							客户要求时间：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="completetime" type="text" id="completetime"
								size="40" value="<%=order.getCompletetime()==null?"":order.getCompletetime()%>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="completetime" type="text" id="completetime"
								size="40" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'completetime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
								<% }%>
						</td>
						<td>&nbsp;
						</td>
						<td width="33%">&nbsp;
						</td>
					</tr>
					<tr>
					<td>
					报告客户：
					</td>
					<td>
					<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input type="text" name ="rpClient" id ="rpClient" size="40" value="<%=order.getRpclient()==null ?"":order.getRpclient() %>" readonly="readonly">
						<%
							}else{
							%>
					<input type="text" name ="rpClient" id ="rpClient" size="40" onkeydown="checkSubmit(2);" onmousedown="checkSubmit(2);" >
					<%} %> 
					</td>
					<td><input type="checkbox" name ="greencheckbox" id="greencheckbox" value="green">绿色通道:</td>
					<td><input type="text" size="40" name ="greenchannel" id="greenchannel"></td></tr>
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
						<td width="9%">
							<div align="center">
								数量
							</div>
						</td>
						<td width="9%">
							<div align="center">
								标准价
							</div>
						</td>
						<td width="9%" style="display: none;">
							<div align="center">
								控制报价金额
							</div>
						</td>
						<td width="9%">
							<div align="center">
								单价
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
						<td width="8%" class="hid">
							<div align="center">
								分包说明
							</div>
						</td>
					</tr>
					<%
					for(int i=1;i<11;i++) {
					 %>
					<tr>
						<td>
							<div align="center">
								<%=i %>
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
								<input type="text" id="itemcount<%=i%>" name="itemcount" size="13" onBlur="getTotal('<%=i %>');">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
									<input type="hidden" id="price<%=i%>" name="price" size="13" >
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="controlprice<%=i%>" name="controlprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i%>" name="saleprice" size="13" onBlur="getTotal('<%=i %>');">
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
						<td class="hid">
							<div align="center">
								<input type="text" id="outprice<%=i%>" name="outprice" size="11" readonly="readonly"
									style="background-color: #FFCC99">
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
								if(oldPid !=null && !"".equals(oldPid )){
									if(Integer.parseInt(value)<9){
								%>
								<option value="<%=value %>" <%=Integer.parseInt(value)==order.getAdvancetype().getId()?"selected":"" %>><%=advancetypes.get(value) %></option>
								<%
									}
								}else{
									if(Integer.parseInt(value)<9){
								 %>
								<option value="<%=value %>" <%=advancetypes.get(value).equals("出报告前支付")?"selected":""%> ><%=advancetypes.get(value) %></option>
								<%
								 }
								 }
								 }
								  %>
							</select>
							
						</td>
						<td width="17%">
							开票方式：
						</td>
						<td width="33%">
						
							<select name="invmethod" id="invmethod" style="width: 300px"
								onChange="changeMethod(this)">
								<option value="总项目" selected>
									总项目
								</option>
								<%
								if(oldPid !=null && !"".equals(oldPid )){
								%>
								<option value="分项目" <%=order.getInvmethod().equals("分项目")?"selected":"" %>>
							
								<%
								}
								else{
								%>
									<option value="分项目">
								<%
								}
								%>
								
									分项目
								</option>
							</select>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							票据类型：
						</td>
						<td>
						
							<select name="invtype" style="width: 300px">
							<!--<option value="发票" selected>
									发票
								</option>-->
								<option value="普通发票" selected>普通发票</option>
								<%
								if(oldPid !=null && !"".equals(oldPid )){
								%>
								<option value="不含机构费用"  <%=order.getInvtype().equals("不含机构费用")?"selected":"" %>>
									不含机构费用
								</option>
								<option value="专用发票"  <%=order.getInvtype().equals("专用发票")?"selected":"" %>>专用发票</option>
								<!-- <option value="借开"  <%=order.getInvtype().equals("借开")?"selected":"" %>>
									借开
								</option> -->
								<option value="收据"  <%=order.getInvtype().equals("收据")?"selected":"" %>>
									收据
								</option>
								<%
								}
								else{
								%>
								
								<option value="不含机构费用" >
									不含机构费用
								</option>
								<!-- <option value="借开" >
									借开
								</option> -->
								<option value="专用发票" selected>专用发票</option>
								<option value="收据" >
									收据
								</option>
								<%
								}
								%>
								
							</select>
						</td>
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								onFocus="getinvprice(this);" />
						</td>
					</tr>
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
							开票内容：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="invcontent" id="invcontent" type="text" size="40"
								value="<%=order.getInvcontent() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="invcontent" id="invcontent" type="text" size="40"
								onFocus="getinvcontent(this);" />
								<%} %>
						</td>
					</tr>

				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊接待费预算
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="prespefund" id="prespefund" type="text" size="40" value="<%=order.getPrespefund() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="prespefund" id="prespefund" type="text" size="40" />
							<%} %>
						</td>
						<td width="17%">
							备注：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="tag" type="text" size="40" value="<%=order.getTag() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="tag" type="text" size="40" />
							<%} %>
						</td>

					</tr>
					<tr>
						<td width="17%">
							成品需求：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="product" id="product" type="text" size="40" value="<%=order.getProduct() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="product" id="product" type="text" size="40" />
							<%} %>
						</td>
						<td width="17%">
							成品样品资料：
						</td>
						<td width="33%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="productsample" id="productsample" type="text"
								size="40" value="<%=order.getProductsample() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="productsample" id="productsample" type="text"
								size="40" />
								<%} %>
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊说明：						</td>
						<td width="83%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="detail" id="detail" type="text" size="77" value="<%=order.getDetail() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="detail" id="detail" type="text" size="77" />
							<%} %>
					  </td>

					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
			<!-- addorder('<%=userF.getDept() %>') -->
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存订单" onClick="addorder('<%=userF.getDept() %>');">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
