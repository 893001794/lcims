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
	String str="block";
	
	
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
		if (TheForm.completetime.value == "") {
			alert ("�ͻ�Ҫ��ʱ�䲻��Ϊ�գ�");
			TheForm.completetime.focus();
			return(false);
		}
		var quotationform=document.getElementById("quotationform");
		quotationform.submit();

	}
	function envAss(){
		var itemid=document.getElementsByName("itemid");
		for(var i=0;i<itemid.length;i++){
			var itemNuber=itemid[i].value;
			if(itemNuber!=""&& itemNuber=="28.01.06"){
				document.getElementById("mytr").style.display="block";
				var envAss=document.getElementById("envAss").value;
				if(envAss==""){
					alert("�����뻷����Ŀ�ĵ��ۣ�����");
					return false;
				}
			}
		}
	}
	
	
	
	function addorder(){
	var quotime=document.getElementById("quotime").value;
	var completetime=document.getElementById("completetime").value;
	var itemid1=document.getElementById("itemid1").value;
	
	if(quotime == ""){
	alert("�������ڲ���Ϊ�գ�");
	return false;
	}
	
	if(completetime==""){
	alert("�ͻ�Ҫ��ʱ�䲻��Ϊ�գ���");
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
		 var sampltime=document.getElementById("sampltime").value;
		  if(sampltime == null){
		 alert("ȡ��ʱ�䲻��Ϊ�գ�������")  
		 return false;
		 } 
		 var companyid=document.getElementById("companyid").value;
		var quotype=document.getElementById("quotype").value;
	 	 var quotationform=document.getElementById("quotationform");
	 	 getTotalPrice();
	 	 //����ǻ�������Ҫ��ȡ�ֶ�����Ļ������۽��
	 	 var itemid=document.getElementsByName("itemid");
	 	 var envAss="";
		for(var i=0;i<itemid.length;i++){
			var itemNuber=itemid[i].value;
			if(itemNuber!=""&& itemNuber=="28.01.06"){
				document.getElementById("mytr").style.display="block";
				envAss=document.getElementById("envAss").value;
				if(envAss==""){
					alert("�����뻷����Ŀ�ĵ��ۣ�����");
					return false;
				}
			}
		}
	 	 //�������Ա༭���ı����ͷų������������form�У���form�ύʱ��disabled��js����Ϊtrue����Ѿ�ʧЧ(�޷�����ֵ��̨Ҳ�޷�ȡֵ)���޷�ʹ��request.getparameter("xxx")���õ����ǵ�ֵ�ˡ�
	 	 var samplenames=document.getElementsByName("samplename");
		for(var i=1;i<samplenames.length;i++){
				document.getElementById("samplename"+i).disabled=false;
		}
	 	quotationform.action="addorder_post.jsp?companyid="+companyid+"&quotype="+quotype+"&envAss="+envAss;
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
  if(companyid ==4){
  companyid=3;
  }
   if(companyid ==""){
   companyid=<%=userF.getCompanyid()%>
   }
  
   xmlHttp.onreadystatechange = handleServerResponse;
   xmlHttp.open("GET", "/lcims/ajaxItem?parents="+companyid+"&stutas=4",true);
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
    
    function getTotalPrice(){
    var retul="";
    var result;
    	var yles =document.getElementsByName("yle");
    	for(var i=0;i<yles.length;i++){
    	var yle=yles[i].value;
	    	if(yle !="" && yle!=null){
	    		retul+=yle+",";
	    		}
	    		}
	   //  var empida = retul.split(",");
    //	alert(empida);SSSS
    	$.ajax({ //����jquery ajax
		type:"POST",  //��ת����ΪPOST
		url:"/lcims/emdPrice", //��ת��·��
		data:"empida="+retul, //�����ֵ�����
        error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
		success: function(data){  //�����ȷ���õ�java���洫�������ֵ
		    var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
		 	var totalPrice=agent.attr('name'); //�õ�����Ϊxml���������name����
		 	document.getElementById("invcount").value=totalPrice;
		 	}
	});
    }
    //��ĿС��
    function addTestPlane(obj,samplename){
    	var itemNumber =document.getElementById(obj).value;
    	var projectleader =window.showModalDialog("testPlane.jsp?itemNumber="+itemNumber, "newwin", "dialogHeight=500px, dialogWidth=400px,toolbar=no,menubar=no");//�����Ӵ��ڣ����һ�ȡ��ֻ���ڵ�ֵ
    	//alert(document.getElementById(obj).value);
    	if(itemNumber=="28.10.09"||itemNumber=="28.09.26"||item.itemid=="28.10.10"){
    		document.getElementById(samplename).value=projectleader;
    	}
    	
    }
    //���Ӳ���Ա
    function auditorder() {
    var childId="";
		var yles =document.getElementsByName("yle");
    	for(var i=0;i<yles.length;i++){
    	var yle=yles[i].value;
	    	if(yle !="" && yle!=null){
	    		childId+=yle+",";
	    		}
	    }
	    if(childId == ""){
	    	alert("�����������Ŀ����");
	    	return false;
	    }
	    //������Ա������
	   var projectleader =window.showModalDialog("projectleader1.jsp?childId="+childId, "newwin", "dialogHeight=500px, dialogWidth=400px,toolbar=no,menubar=no");//�����Ӵ��ڣ����һ�ȡ��ֻ���ڵ�ֵ
		//��ȡ����Ա����
		$.ajax({ //����jquery ajax
		type:"POST",  //��ת����ΪPOST
		url:"/lcims/emdPrice", //��ת��·��
		data:"projectleader="+projectleader, //�����ֵ�����
        error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
		success: function(data){  //�����ȷ���õ�java���洫�������ֵ
		    var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
		 	var userName=agent.attr('name'); //�õ�����Ϊxml���������name����
		 	document.getElementById("sampling").value=userName;
		 	}
	});
		document.getElementById("projectleader").value=projectleader;
	}
		</script>

	</head>

	<body class="body1">
	<!--addorder();  -->
		<form method="post" name="quotationform" id="quotationform" action ="addorder_post.jsp"
			onSubmit="return addorder();"><div align="left"> 
			<input type="hidden" name="command" value="add"> 
			<input type="hidden" name="confirmUserId" id="confirmUserId" value=""> 
			<input type="hidden" name="totalprice" id="totalprice" value=""> 
			</div><table width="95%" border="0" cellspacing="2" cellpadding="2">
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
							<select name="quotype" id="quotype" style="width: 300px" onchange="changetype(this);" disabled="disabled">
								<option value="new"  <%=quotype.equals("new")?"selected":"" %> >
									�±��۵�
								</option>
								<option value="add" <%=quotype.equals("add")?"selected":"" %>>
									�����زⱨ�۵�
								</option>
								<option value="mod" <%=quotype.equals("mod")?"selected":"" %>>
									�޸ı��汨�۵�
								</option>
								<option value="add" <%=quotype.equals("add")?"selected":"" %>>
									���ӱ��汨�۵�
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
						<select name="companyid" id="companyid" style="width: 300px"
								onChange="ajaxChange();" disabled="disabled">
								<option value="1" >
									��ɽ
								</option>
								<option value="2">
									����
								</option>
								<option value="3">
									��ݸ
								</option>
								<option value="4" selected="selected">
									����
								</option>
							</select>
							
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
						
							<%
							 if(user.getDept().indexOf("����")==0){
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
									Map<String,String> banks = FlowFinal.getInstance().getBank(companyid);
									for(String value:banks.keySet()) {
									if(userF.getCompany().equals("��ݸ")){
									%>
										<option value="<%=value %>" <%=Integer.parseInt(value)==6?"selected":""%>><%=banks.get(value) %></option>
									<%
									}else{		
									
									 %>
								<option value="<%=value %>"><%=banks.get(value) %></option>
								<%
								 }
								 	}
								 
								  %>
							</select>
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
					<td colspan="2" align="left"><div id ="mydiv"><input type="checkbox" value="C" checked="checked"  name ="TSsample" id="TSsample" onClick="chooseOne(this)">����&nbsp;&nbsp;<input type="checkbox" value="S" name ="TSsample" id="TSsample" onClick="chooseOne(this)">����</div></td>
						<script>   
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }   
						     }   
 						</script>
					<%if(user.getCompanyid() !=4 && user.getId() !=103){ %>
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
						<%} %>
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
								size="40" value="<%=order.getCompletetime() %>" readonly="readonly"/>
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
						
					</tr>
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
								����С��Ŀ
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
						<%if(user.getPstatus().equals("y")){ %>
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
						<%} %>
						<td width="5%">
							<div align="center">
								����
							</div>
						</td>
						<td width="5%">
							<div align="center">
								����
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
								<input disabled="disabled" type="text" id="samplename<%=i%>" name="samplename" onfocus="addTestPlane('itemid<%=i%>','samplename<%=i%>');" size="25" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i%>" name="itemcount" size="13" onBlur="getTotal('<%=i %>');">
							</div>
						</td>
						
						<td>
							<div align="center" >
								<input type="text" id="standprice<%=i%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<%if(user.getPstatus().equals("y")){ 
						%>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="controlprice<%=i%>" name="controlprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td >
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
						<%
						} else{
						%>
						<td style="display: none;">
							<div align="center" >
								<input type="text" id="standprice<%=i%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="controlprice<%=i%>" name="controlprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="saleprice<%=i%>" name="saleprice" size="13" onBlur="getTotal('<%=i %>');">
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="itemtotal<%=i%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onchange="sumTotalprice();">
							</div>
						</td>
						<%
						}%>
						<td>
							<select name="plane" id="plane<%=i %>" style="width: 150px" onchange="child('<%=i%>',this.value);">
							</select>
						</td>
						<td>
							<select name="yle" id="yle<%=i%>" style="width: 150px">
							</select>
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
								%>
								<option value="<%=value %>" <%=Integer.parseInt(value)==order.getAdvancetype().getId()?"selected":"" %>><%=advancetypes.get(value) %></option>
								<%
								}else{
								 %>
								<option value="<%=value %>" <%=advancetypes.get(value).equals("������ǰ֧��")?"selected":""%> ><%=advancetypes.get(value) %></option>
								<%
								 }
								 }
								  %>
							</select>
							
						</td>
						<td width="17%">
							����Ա��
						</td>
						<td>
							<input type="text"" id="projectleader" name ="projectleader" size="40">
							<input type="text" id="sampling" name ="sampling" onfocus="auditorder();" size="40">
						</td>
						<!-- 
						<td width="17%">
							��Ʊ��ʽ��
						</td>
						<td width="33%">
						
							<select name="invmethod" id="invmethod" style="width: 300px"
								onChange="changeMethod(this)" disabled="disabled">
								<option value="����Ŀ" selected>
									����Ŀ
								</option>
							<option value="����Ŀ">
									����Ŀ
								</option>
							</select>
						</td>
						 -->
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr style="display: none;" id="mytr">
						<td>
							������Ŀ���ۣ�
						</td>
						<td>
							<input type="text" name ="envAss" id ="envAss" size="40">
						</td>
					</tr>
					<tr>
						<td>
							Ʊ�����ͣ�
						</td>
						<td>
						
							<select name="invtype" style="width: 300px">
							<option value="��Ʊ" selected>
									��Ʊ
								</option>
								<option value="�վ�">
									�վ�
								</option>
							</select>
						</td>
						<td>
							����ʱ�䣺
						</td>
						<td width="33%">
							<input name="sampltime" type="text" id="sampltime" size="40"  value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()) %>"/>
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'sampltime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<!-- 
						<td width="17%">
							��Ʊ�ܽ�
						</td>
						<td width="33%" style="display: none;">
							<input name="invcount" id="invcount" type="text" size="40"  onFocus="getTotalPrice();" />
						</td>
						 -->
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
							����˵����						</td>
						<td width="83%">
						<%
							if(oldPid !=null &&! "".equals(oldPid)){
							%>
							<input name="detail" id="detail" type="text" size="125" value="<%=order.getDetail() %>" readonly="readonly"/>
						<%
							}else{
							%>
							<input name="detail" id="detail" type="text" size="125" />
							<%} %>
					  </td>

					</tr>
					<tr>
						<td>��Ʒ���:</td>
						<td><input type="text" size="125" name ="sampleNo" id="sampleNo"></td>
					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" 
					value="���涩��">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
