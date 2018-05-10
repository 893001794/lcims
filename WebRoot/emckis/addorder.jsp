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
	
	
	
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӱ��۵�</title>
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
		
		<script type="text/javascript">
		window.onload=function()
	    {//ҳ�����ʱ�ĺ���
	    	Change_Select();
	    }
	    
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"�ͻ������Ƿ����");
	    validateclient(client);
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
		if (TheForm.estimatesPoints.value == "") {
			alert ("���Ʋ��Ե�������Ϊ�գ�");
			TheForm.estimatesPoints.focus();
			return(false);
		}
		if (TheForm.collectionD.value == "") {
			alert ("�ռ�ʱ�䲻��Ϊ�գ�");
			TheForm.collectionD.focus();
			return(false);
		}
		if (TheForm.receiptD.value == "") {
			alert ("�յ�ʱ�䲻��Ϊ�գ�");
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
	var usetype =document.getElementById("usetype").value; //ʹ�÷�ʽ
	if(usetype == ""){
		alert("��ѡ��ʹ�÷�ʽ������");
		return false;
	}	
	if(usetype=="marketRent"){
		//if(document.getElementById("amstart").value=="" && document.getElementById("pmstart").value==""){
		////alert("�����뿪ʼʱ�䣡����");
		//return false;
		//}
		//if(document.getElementById("amend").value==""&&document.getElementById("pmend").value==""){
		//alert("���������ʱ�䣡����");
		//return false;
		//}
	}else if(usetype == "report"){
		if(document.getElementById("oldPid").value==""){
		alert("������������۵�������");
		return false;
		}
	}
	if(itemid1 ==""){
	alert("����Ҫ����һ�������Ŀ��");
	return false;
	}
		var myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addorder_post.jsp";
		myform.submit();
	
	}
	
	function checkClient(){
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
			with (document.getElementById("quotationform")) {
					method="post";
					//action="addorder_post.jsp";
					//submit();
					}
			}else{
			alert("�ͻ������ڣ���������ͻ����ϣ�");
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
							<select name="quotype" id="quotype" style="width: 300px" onchange="changetype(this);">
								<option value="new"  <%=quotype.equals("new")?"selected":"" %>>
									�±��۵�
								</option>
							</select>
						</td>
						<td>
							�ֹ�˾��
						</td>
						<td>
						<select name="companyid" id="companyid" style="width: 300px"
								onChange="ajaxChange();">
								<option value="1" selected="selected">
									��ɽ
								</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>
							������Ա��
						</td>
						<td>
							<select name="salesid" id="salesid" style="width: 300px">
							</select>
							
						</td>
						<td width="15%">
							��Ʒ���ƣ�
						</td>
						<td>
							<input name="product" id="product" value="" size="40">							
						</td>

					</tr>
					<tr>
						<td>
							�ͻ���
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
							ʹ�÷�ʽ�� 
						</td>
						<td width="33%">
							<select name="usetype" style="width: 300px" id="usetype" onchange="hidden(this.value);">
								<option value="">---ѡ��ʹ�÷�ʽ---</option>
								<option value="marketRent">�ⳡ</option>
								<option value="report">��Ŀ</option>
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
						<td width="350">�������۵���</td>
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
							���翪ʼʱ�䣺
						</td>
						<td>
							<input name="amstart" type="text" id="amstart" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'HH:mm',el:'amstart'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							�������ʱ�䣺
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
							�����翪ʼʱ�䣺
						</td>
						<td>
							<input name="pmstart" type="text" id="pmstart" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'HH:mm',el:'pmstart'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							�������ʱ�䣺
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
							�ռ�����
						</td>
						<td>
							<input name="collectionD" type="text" id="collectionD" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'yyyy.MM.dd',el:'collectionD'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						
						<td>
							��������
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
							�յ�����
						</td>
						<td>
							<input name="receiptD" type="text" id="receiptD" size="40"  value=""/>
							<img onClick="WdatePicker({dateFmt:'yyyy.MM.dd',el:'receiptD'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							��ˮ��;
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
						<td width="16%">
							<div align="center">
								��׼��
							</div>
						</td>
						<td width="16%">
							<div align="center">
								ʵ�ʼ�
							</div>
						</td>
						<td width="9%">
							<div align="center">
								����Сʱ��
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
							���ʽ��
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
							Ʊ�����ͣ�
						</td>
						<td>
							<select name="invtype" style="width: 300px">
							<option value="��Ʊ" selected>
									��Ʊ
								</option>
								<option value="ȫ��">
									ȫ��
								</option>
								<option value="������������">
									������������
								</option>
								<option value="�迪">
									�迪
								</option>
								<option value="�վ�">
									�վ�
								</option>
							</select>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
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
							��Ʊ�ܽ�
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
							��ע��
						</td>
						<td width="83%">
							<input name="tag" id="tag" type="text" size="77" />
					  </td>

					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							����˵����
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
					value="���涩��" onClick="addorder();">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
