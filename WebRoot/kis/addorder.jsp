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
	//�����ɵı��۵���
	String oldPid= request.getParameter("oldPid");
	//���۵�����
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
		<title>��ӱ��۵�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		
		<style type="text/css">
/*�������ı���ɫ*/
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
	    {//ҳ�����ʱ�ĺ���
	    	Change_Select();
	    	servinfo();
	    }
	    
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"�ͻ������Ƿ����");
	    validateclient(client);
	    }
	    
      function ajaxChange(){
	    Change_Select();
	    servinfo();
	    }
	    function checkForm(TheForm) {

		if (TheForm.quotime.value == "") {
			alert ("�������ڲ���Ϊ�գ�");
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
	alert("��ѡ�񱨼۵����ͣ�");
	return false;
	}
	if(circle == ""){
	alert("���ڲ���Ϊ�գ�");
	return false;
	}
	
	
	if(quotime == ""){
	alert("�������ڲ���Ϊ�գ�");
	return false;
	}
	
	
	
	
	if(itemid1 ==""){
	alert("����Ҫ����һ�������Ŀ��");
	return false;
	}
	var quotype =document.getElementById("quotype").value;
	if(!(quotype.indexOf("new") == 0)){
	var oldPid =document.getElementById("oldPid").value;
		if(oldPid ==""){
		alert("�����ɱ��۵�����Ϊ�գ���");
		return false;
		}
		if(quotype =="flu"){
		var remark =document.getElementById("remark1").value;
			if(remark == ""){
			alert("��ע�ı�����Ϊ�ն��󣡣�");
			return false;
			}
		}
		}
	var rpClient=document.getElementById("rpClient").value;
	 if(rpClient == null){
	 alert("����ͻ�����Ϊ�ն��󣡣�����")  
	 return false;
	 } 
		
     var jqueryObj = $("#client");   
     // ��ȡ�ı������û����������   
     var client = jqueryObj.val();   
		//�ȼ���Ƿ���ֵ
		jQuery.ajax({
			url:'validateclient.jsp?client='+encodeURI(encodeURI(client)),
			type:'POST',
			synch:true,//(Ĭ��: true) Ĭ�������£����������Ϊ�첽���������Ҫ����ͬ�������뽫��ѡ������Ϊ false��ע�⣬ͬ��������ס��������û�������������ȴ�������ɲſ���ִ�С�
			success:function(msg){//����ɹ���ص���������������������������������������ݣ�����״̬//
			if(msg.indexOf(true) >-1){
			var companyid=document.getElementById("companyid").value;//��ȡ��˾id
			//alert("����:"+obj+"----�ֹ�˾:"+companyid);
			if(companyid ==1 && obj =="����һ��"){ //�������ɽ�Ĳ���������һ���Ĳ����ж�
			//alert("������ ");
			checkPrice();//������֤��������Ŀ�����Ƿ��������Ƽ۸�Χ��
			}else{
			//��������۶�����������ɽ����ľͲ����ж�
			with (document.getElementById("quotationform")) {
					method="post";
					action="addorder_post.jsp";
					submit();
					}
			}
			
			}else{
			alert("�ͻ������ڣ���������ͻ����ϣ�");
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
     // ��ȡ�ı������û����������   
      client = jqueryObj.val(); 
	}
	if(obj == 2){
		document.getElementById("rpClient").value=document.getElementById("client").value;
	  var jqueryObj = $("#rpClient");   
     // ��ȡ�ı������û����������   
      client = jqueryObj.val(); 
	}
		//�ȼ���Ƿ���ֵ
		jQuery.ajax({
			url:'validateclient.jsp?client='+ encodeURI(encodeURI(client)),
			type:'POST',
			synch:true,//(Ĭ��: true) Ĭ�������£����������Ϊ�첽���������Ҫ����ͬ�������뽫��ѡ������Ϊ false��ע�⣬ͬ��������ס��������û�������������ȴ�������ɲſ���ִ�С�
			success:function(msg){//����ɹ���ص���������������������������������������ݣ�����״̬//
			if(msg.indexOf(true) >-1){
			}else{
			alert("�ͻ������ڣ���������ͻ����ϣ�");
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
    	xmlHttp=new ActiveXObject('Microsoft.XMLHTTP');//IE����
	}catch(e){
       	try{
       		xmlHttp=new XMLHttpRequest();//ns��firefox����
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
	//��Ҫ����ʱ������Է�ֹ�������⣬ȷ��ÿ���ύ��URL��ͬ  
	xmlHttp.send(null);
    }
    
    
    
    
    function handleServerResponse(){ 
 		 if (xmlHttp.status == 200)//���سɹ�
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
	    		
	    //��ȡ���۵�����quotype
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
    //��ȡ������Ŀ�����۱���
    var itemid=document.getElementsByName("itemid");
    //��ȡ��Ŀ����
    var itemname=document.getElementsByName("itemname");
    //��ȡ��׼�۸�
    var standprice=document.getElementsByName("standprice");
    //����ʵ�ʱ��۵Ľ��
     var saleprice=document.getElementsByName("saleprice");
     //��ȡ���Ƽ۸�
     var controlprice =document.getElementsByName("controlprice");
    for(var i =0;i<itemid.length;i++){
    if(itemid[i].value !=""){
    if(standprice[i].value*0.85>saleprice[i].value){
    if(standprice[i].value*0.75>saleprice[i].value){
    strcontrolprice=standprice[i].value*0.75;
    grade="high";
    str1="ֻ��Hadi";
    }else{
     strcontrolprice=standprice[i].value*0.85;
    str1="��Ҫ�������ܻ���";
     grade="";
    }
    str+=itemname[i].value+"���۵���"+strcontrolprice+"\n"+"\n";
    flag =true;
    }
    }
    }
    //alert(str+":���������");
    if(str !="" && str !=null){
    alert(str+str1+"����ȷ�ϣ�");
    }
   if(flag == true){
    var ret =window.showModalDialog("verification.jsp", "newwin", "dialogHeight=10px, dialogWidth=100px,toolbar=no,menubar=no");//�����Ӵ��ڣ����һ�ȡ��ֻ���ڵ�ֵ
	$.ajax({ //����jquery ajax
		type:"POST",  //��ת����ΪPOST
		//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
		url:"/lcims/verificationPwd", //��ת��·��
		data:"userName="+ret+"&grade="+grade, //�����ֵ�����
        error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
		success: function(data){  //�����ȷ���õ�java���洫�������ֵ
		    var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
		 	if(agent.attr('suc') == 'true'){ //�õ�����Ϊagent��xml��������sucԪ�أ������ж�sucԪ�ص�ֵ�Ƿ�Ϊtrue
		 	var userId=agent.attr('name'); //�õ�����Ϊxml���������name����
		 	document.getElementById("confirmUserId").value=userId;
		 	alert(userId);
		 	//alert(agent.attr('name'));
			alert("ȷ�ϳɹ���");
			with (document.getElementById("quotationform")) {
					method="post";
					action="addorder_post.jsp";
					submit();
					}
			}else{
			alert("��������������벻��ȷ");
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
							<b>���۹���&gt;&gt;��ӱ��۵�</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="12%">
							���۵����ͣ�
						</td>
						<td width="33%">
						<!--  <select name="quotype" id="quotype" style="width: 300px" onchange="modifymoney();">-->
							<select name="quotype" id="quotype" style="width: 300px" onchange="changetype(this);">
								<option value="" >
									ѡ�񱨼۵�����
								</option>
								<option value="new"  <%=quotype.equals("new")?"selected":"" %>>
									�±��۵�
								</option>
								<option value="add" <%=quotype.equals("add")?"selected":"" %>>
									�����زⱨ�۵�
								</option>
								<option value="mod" <%=quotype.equals("mod")?"selected":"" %>>
									�޸ı��汨�۵�
								</option>
								<option value="med" <%=quotype.equals("med")?"selected":"" %>>
									ת�뱨�汨�۵�
								</option>
								<option value="flu" <%=quotype.equals("flu")?"selected":"" %>>
									��챨�۵�
								</option>
							</select>
						</td>
						<td>
							�ֹ�˾��
						</td>
						<td>
						<%if(user.getTicketid().equals("11101111")|| user.getTicketid().equals("11111111")||user.getName().equals("��Ӣ��[Grace]")){
						%>
						<select name="companyid" id="companyid" style="width: 300px"
								onChange="ajaxChange();">
								<option value="1" selected="selected">
									��ɽ
								</option>
								<option value="2">
									����
								</option>
								<option value="3">
									��ݸ
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
						<td width="350">�����ɱ��۵���</td>
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
						<td width="350">�����ɱ��۵���</td>
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
							������Ա��
						</td>
						<td>
						<!-- ��addorder.jspҳ����parseMessage()����ȡֵ-->
							<%
							 if(user.getDept().indexOf("����")==0 && user.getPopdom().equals("user")&&!user.getName().equals("��Ӣ��[Grace]")){
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
							�ͷ���Ա��
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
							�ͻ���
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
							�˺ţ�
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
									if(userF.getCompany().equals("��ݸ")){
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
							���ڣ�
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
							���Ʋ��Եĵ�����
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
							�������ڣ�
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
							�ͻ�Ҫ��ʱ�䣺
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
					����ͻ���
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
					<td><input type="checkbox" name ="greencheckbox" id="greencheckbox" value="green">��ɫͨ��:</td>
					<td><input type="text" size="40" name ="greenchannel" id="greenchannel"></td></tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" border="1">
					<tr>
						<td width="3%">
							<div align="center">
								�к�
							</div>
						</td>
						<td width="6%">
							<div align="center">
								����
							</div>
						</td>
						<td width="16%">
							<div align="center">
								������Ŀ
							</div>
						</td>
						<td width="16%">
							<div align="center">
								��Ʒ����
							</div>
						</td>
						<td width="9%">
							<div align="center">
								����
							</div>
						</td>
						<td width="9%">
							<div align="center">
								��׼��
							</div>
						</td>
						<td width="9%" style="display: none;">
							<div align="center">
								���Ʊ��۽��
							</div>
						</td>
						<td width="9%">
							<div align="center">
								����
							</div>
						</td>
						<td width="9%">
							<div align="center">
								С��
							</div>
						</td>
						<td width="15%">
							<div align="center">
								��ע
							</div>
						</td>
						<td width="8%" class="hid">
							<div align="center">
								�ְ�˵��
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
							���ʽ��
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
								<option value="<%=value %>" <%=advancetypes.get(value).equals("������ǰ֧��")?"selected":""%> ><%=advancetypes.get(value) %></option>
								<%
								 }
								 }
								 }
								  %>
							</select>
							
						</td>
						<td width="17%">
							��Ʊ��ʽ��
						</td>
						<td width="33%">
						
							<select name="invmethod" id="invmethod" style="width: 300px"
								onChange="changeMethod(this)">
								<option value="����Ŀ" selected>
									����Ŀ
								</option>
								<%
								if(oldPid !=null && !"".equals(oldPid )){
								%>
								<option value="����Ŀ" <%=order.getInvmethod().equals("����Ŀ")?"selected":"" %>>
							
								<%
								}
								else{
								%>
									<option value="����Ŀ">
								<%
								}
								%>
								
									����Ŀ
								</option>
							</select>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							Ʊ�����ͣ�
						</td>
						<td>
						
							<select name="invtype" style="width: 300px">
							<!--<option value="��Ʊ" selected>
									��Ʊ
								</option>-->
								<option value="��ͨ��Ʊ" selected>��ͨ��Ʊ</option>
								<%
								if(oldPid !=null && !"".equals(oldPid )){
								%>
								<option value="������������"  <%=order.getInvtype().equals("������������")?"selected":"" %>>
									������������
								</option>
								<option value="ר�÷�Ʊ"  <%=order.getInvtype().equals("ר�÷�Ʊ")?"selected":"" %>>ר�÷�Ʊ</option>
								<!-- <option value="�迪"  <%=order.getInvtype().equals("�迪")?"selected":"" %>>
									�迪
								</option> -->
								<option value="�վ�"  <%=order.getInvtype().equals("�վ�")?"selected":"" %>>
									�վ�
								</option>
								<%
								}
								else{
								%>
								
								<option value="������������" >
									������������
								</option>
								<!-- <option value="�迪" >
									�迪
								</option> -->
								<option value="ר�÷�Ʊ" selected>ר�÷�Ʊ</option>
								<option value="�վ�" >
									�վ�
								</option>
								<%
								}
								%>
								
							</select>
						</td>
						<td width="17%">
							��Ʊ�ܽ�
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								onFocus="getinvprice(this);" />
						</td>
					</tr>
					<tr>
						<td width="17%">
							��Ʊ̧ͷ��
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
							��Ʊ���ݣ�
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
							����Ӵ���Ԥ��
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
							��ע��
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
							��Ʒ����
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
							��Ʒ��Ʒ���ϣ�
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
							����˵����						</td>
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
					value="���涩��" onClick="addorder('<%=userF.getDept() %>');">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
