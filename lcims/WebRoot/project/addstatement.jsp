<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="java.util.Map"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	String free = request.getParameter("free");
	String Currency=request.getParameter("Currency");
	Quotation qt = null;
	String Currencytype=request.getParameter("Currencytype");
	if (command != null && "search".equals(command)) {
		String pid = request.getParameter("pid");
		if(pid == null || "".equals(pid) || "null".equals(pid)) {
			response.sendRedirect("project_finance_manage.jsp");
			return;
		} else {
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
		}
	}
	
	if(qt == null) {
		qt = new Quotation();
	}
Map<String,String> subname = FlowFinal.getInstance().getsubname("��ѧ");
Map<String,String> subname2 = FlowFinal.getInstance().getsubname("����");
Map<String,String> agname = FlowFinal.getInstance().getagname();
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��Ŀ�ֽ�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}


</style>

<script type="text/javascript">
<%--
function changeAgename(obj) {
	
	if(obj.value == "") {
		document.getElementById("cpay").style.display = "none";
		document.getElementById("form1").clientpay[0].checked = true;
	} else {
		document.getElementById("cpay").style.display = "";
	}
}
--%>
function changePtype(obj) {
	if(!(obj.value.indexOf("��ѧ����")==0 ||obj.value.indexOf("��ױƷ")==0 ||obj.value.indexOf("����")==0)){//ѡ�а������ʱ
		//alert("��ʾ����");
		document.getElementById("cpay").style.display = "";
		document.getElementById("dis").style.display = "";
		var subname1 = document.getElementById('subname1');
	    subname1.options.length=0;
	    var subname2 = document.getElementById('subname2');
	    subname2.options.length=0;
       try{
          subname1.add(new Option("��ѡ��",""));
          subname2.add(new Option("��ѡ��",""));
          
          <%
          for(String value:subname2.keySet()) {
          %>
          subname1.add(new Option("<%=subname2.get(value)%>","<%=subname2.get(value)%>"));
          subname2.add(new Option("<%=subname2.get(value)%>","<%=subname2.get(value)%>"));
          
          <%
          }
          %>
          
        }catch(e){
        }
	} else {//ѡ�л�ѧ����ʱ
		document.getElementById("cpay").style.display = "none";
		document.getElementById("form1").clientpay[0].checked = true;
		//alert("����");
		document.getElementById("dis").style.display = "none";
		var subname1 = document.getElementById('subname1');
	    subname1.options.length=0;
	    var subname2 = document.getElementById('subname2');
	    subname2.options.length=0;
         try{
          subname1.add(new Option("��ѡ��",""));
          subname2.add(new Option("��ѡ��",""));
         <%
          for(String value:subname.keySet()) {
          %>
          subname1.add(new Option("<%=subname.get(value)%>","<%=subname.get(value)%>"));
          subname2.add(new Option("<%=subname.get(value)%>","<%=subname.get(value)%>"));
          
          <%
          }
          %>
        }catch(e){
        }
	}
}

function goBack() {
		window.history.back();
	}
	
	function getinvprice(invprice) {
		if(invprice.value == "") {
			invprice.value = document.getElementById("price").value;
		}
	}
	
	function getinvhead(invhead) {
		if(invhead.value == "") {
			invhead.value = document.getElementById("client").value;
		}
	}
	
	function getinvcontent(invcontent) {
		if(invcontent.value == "") {
			var content = "����" + document.getElementById("pid").value;
			invcontent.value = content;
		}
	}
	
	function isSubname(){
		var sub=document.getElementById("subname1").value;
		if(sub == "TUV(���)"){
		document.getElementById("payId").style.display="";
		}else{
		document.getElementById("payId").style.display="none";
		}
	}
	
	function ispaystatus(object){
	if(object == 1){
		var paystatus=document.getElementById("paystatus").value;
			if(paystatus == "�۱�"){
				document.getElementById("Currencytype").value="HKD"
			}if(paystatus == "ŷԪ"){
			document.getElementById("Currencytype").value="EUR"
			}if(paystatus == "��Ԫ"){
			document.getElementById("Currencytype").value="AUD"
			}if(paystatus == "��Ԫ"){
			document.getElementById("Currencytype").value="USD"
			}
	}else{
		var paystatus2=document.getElementById("paystatus2").value;
			if(paystatus2 == "�۱�"){
				document.getElementById("Currencytype2").value="HKD"
			}if(paystatus2 == "ŷԪ"){
			document.getElementById("Currencytype2").value="EUR"
			}if(paystatus2 == "��Ԫ"){
			document.getElementById("Currencytype2").value="AUD"
			}if(paystatus2 == "��Ԫ"){
			document.getElementById("Currencytype2").value="USD"
			}
	}
		
	}
	//��갴��ʱ����
	function keyUp1(){
		var hkd=document.getElementById("hkd2").value;
		document.getElementById("presubcost2").value=hkd*0.8811;
	}
	
	function changeSelect(invtype) {
		if(invtype.value.match("����")) {
			//document.getElementById("invhead").readOnly=true;
			//document.getElementById("invhead").style.background="#F2F2F2";
			document.getElementById("invhead").value = "";
			document.getElementById("invhead").style.display="none";
			
			//document.getElementById("invcontent").readOnly=true;
			//document.getElementById("invcontent").style.background="#F2F2F2";
			document.getElementById("invcontent").value = "";
			document.getElementById("invcontent").style.display="none";
			
			//document.getElementById("invcount").readOnly=true;
			//document.getElementById("invcount").style.background="#F2F2F2";
			document.getElementById("preinvprice").value = "";
			document.getElementById("preinvprice").style.display="none";
			
			document.getElementById("invmethod").options[0].selected=true;
			
		} else {
			document.getElementById("invhead").style.display="";
			document.getElementById("invcontent").style.display="";
			document.getElementById("preinvprice").style.display="";
		}
	}
	function checkSubmit(obj){
		if(obj=="batch"){
			var totalprice=document.getElementById("totalprice").value;
			var total=document.getElementById("total").value;
			var price=document.getElementById("price").value;
			var copies=document.getElementById("copies").value;
			if(total==""){
				alert("����Ŀ�ܽ���Ϊ��!!!");
				return false;
			}
			if(price==""){
				alert("ÿ�ݽ���Ϊ��!!!");
				return false;
			}
			if(copies==""){
				alert("��������Ϊ��!!!");
				return false;
			}
			if(total>totalprice){
				alert("����Ŀ�ܽ��ܴ��ڷ���Ŀ������");
				return false;
			}
			if(price*copies>total){
				alert("����*ÿ�ݽ�������ܴ��ڷ���Ŀ�ܽ�����");
				return false;
			}
		}
		var myfrom =document.getElementById("form1");
		//myfrom.action ="addstatement_post.jsp";
		myfrom.submit();
	}
</script>


	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;���۹���&gt;&gt;��Ŀ���˵�</b>
				</td>
			</tr>
		</table>

		<hr width="97%" align="center" size=0>
		<table width=100% border=0 cellspacing=5 cellpadding=5
			style="margin-left: 13em">
			<tr>
				<td valign=middle width=50%>
					<form name=search method=post name ="myfrom" id="myfrom" action=addstatement.jsp?command=search autocomplete="off">
						<font color="red">�����뱨�۵��ţ�</font>
						<input id="pid" type="text" name="pid" size="40" />
						<input type=submit name=Submit value=����>
						 <script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
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
						<input type="hidden" name=type size="25" value="all" />

					</form>
				</td>
			</tr>

		</table>

		<hr width="100%" align="center" size=0>


		<form name="form1" action="addstatement_post.jsp" method="post" >
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<input type="hidden" name="free" value="<%=free %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>

						<td>
							���۵���ţ�
						</td>
						<td>
							<input  name="pid" id="pid" size="40" type="text"
								value="<%=qt.getPid()==null?"":qt.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2"  />
						</td>
						<td>
							���۵����ͣ�
						</td>
						<td>
							<input name="quotype" size="40" type="text"
								value="<%=qt.getQuotype()==null?"":"new".equals(qt.getQuotype())?"�±��۵�":"�����زⱨ�۵�" %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
					<tr>
						<td>
							�ͻ����ƣ�
						</td>
						<td>
							<input name="client" id="client" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							��Ʒ����
						</td>
						<td>
							<input name="client" id="client" size="40"
								value="<%=qt.getObject()==null?"":qt.getObject()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
					<tr>
						<td>
						��Ŀ�ܽ�					</td>
					<td>
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>"/>				  </td>
					</tr>
				</table>
			</div>
<p>&nbsp;</p>
			<div class="outborder">
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						��Ŀ���ͣ�
					</td>
					<td width="33%">
						<select name="ptype" style="width: 300px" onchange="changePtype(this);">
							<option value="��ѧ����" selected>
								��ѧ����
							</option>
							<option value="���ӵ�����ȫ����">
								���ӵ�����ȫ����
							</option>
							<option value="EMC����">
								EMC����
							</option>
							<option value="�����ܲ���">
								�����ܲ���
							</option>
							<option value="��ױƷ">
								��ױƷ
							</option>
							<option value="����">
								����
							</option>
						</select>
					</td>
					<td width="17%">
					�������ݣ�
					</td>
					<td width="33%">
					<input name="testcontent" type="text" size="40"
									value="<%=qt.getProjectcontent()==null?"":qt.getProjectcontent() %>" />
					</td>
				</tr>
			</table>
			<table id="dis" cellpadding="5" cellspacing="5" width="95%" style="display: none;">
				<tr>

						<td width="40%">
							<div id="mydiv">
								�Բ�
								<input type="checkbox" name="type" value="�Բ�" checked
									onClick="chooseOne(this);" />
								|&nbsp; ��������
								<input type="checkbox" name="type" value="��������"
									onClick="chooseOne(this);" />

							</div>

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
						</td>
						<td width="10%">&nbsp;</td>
						<td width="40%">
							<div id="mydiv2">
								��ɽʵ����
								<input type="checkbox" name="lab" value="��ɽʵ����" checked
									onClick="chooseOne2(this);" />
								|&nbsp; ��ݸʵ����
								<input type="checkbox" name="lab" value="��ݸʵ����"
									onClick="chooseOne2(this);" />
							</div>
							<script>   
					     function chooseOne2(cb) {   
					         var obj = document.getElementById("mydiv2");   
					         for (i=0; i<obj.children.length; i++){   
					             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
					             //else    obj.children[i].checked = cb.checked;   
					             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
					             else obj.children[i].checked = true;   
					         }   
					     }   
 					</script>
						</td>
						<td width="10%">&nbsp;</td>
					</tr>
					<tr>
						<td width="40%">
							����� 
							��
							<input type="radio" name="isout" id="isout" value="n" checked />
							��
							<input type="radio" name="isout" id="isout" value="y" />
						</td>
						<td width="10%">
							���ݸ��ƣ�
						</td>
						<td width="40%"><input type="text" value="0" name="copy" id ="copy">��</td>
						<td width="10%">&nbsp;</td>
					</tr>
			</table>
			</div>
			<div class="outborder">
			<table cellpadding="5" cellspacing="5" width="95%">
			<%
			String status= request.getParameter("status");
			if(status==null){
				status="";
			}
			if(status.equals("only")||status.equals("")){
			%>
			<tr>
					<td width="17%">
						����Ŀ��
					</td>
					<td width="33%">
						<input name="price" id="price" type="text" value="" size="40" />
					</td>
					<td width="17%">
						�ڲ��ְ���Ԥ�ƣ�
					</td>
					<td width="33%">
						<input name="insubcost" type="text" value="" size="40" />
					</td>
			</tr>
			<%
			}else if(status.equals("batch")){
			%>
			<tr>
					<td width="17%">
						����Ŀ�ܽ�
					</td>
					<td width="33%">
						<input name="total" id="total" type="text" value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>" size="40" />
					</td>
					<td width="17%">
						ÿ�ݽ�
					</td>
					<td width="33%">
						<input name="price" type="text" id="price" value="" size="40" />
					</td>
			</tr>
			<tr>
					<td width="17%">
						������
					</td>
					<td width="33%">
						<input name="copies" id="copies" name ="copies" type="text" value="" size="40" />
					</td>
					<td width="17%">
						�ڲ��ְ���Ԥ�ƣ�
					</td>
					<td width="33%">
						<input name="insubcost" type="text" value="" size="40" />
					</td>
			</tr>
			<%
			}
			
			 %>
				
				
				<tr>
					<td>
						�ⲿ�ְ���AԤ�ƣ�
					</td>
					<td>
					
						<input name="presubcost1" type="text" value="" size="20"/><font color="red"><input name="Currencytype" id="Currencytype" type="text" size="3" readonly="readonly"/></fon
						<div id="payId"  style="display: none">
						<select name="paystatus" id="paystatus" style="width: 80px" onchange="ispaystatus(1)">
						<option value="" selected>ѡ�����</option>
						<option value="�۱�">�۱�</option>
						<option value="ŷԪ">ŷԪ</option>
						<option value="��Ԫ">��Ԫ</option>
						<option value="��Ԫ">��Ԫ</option>
					</select>
					<script type="text/javascript">
								var ops2 = document.getElementById("paystatus").options;
								for(var i=0;i<ops2.length;i++) {
									if(ops2[i].value.indexOf("<%=Currency%>")==0 && "<%=Currency%>".indexOf(ops2[i].value) == 0){
										ops2[i].selected = true;	
									}
								}
					</script>
					</div>
					</td>
					<td>
						�ⲿ�ְ�����A���ƣ�
					</td>
					<td>
						<select name="subname1" style="width: 300px" onchange="isSubname()">
							<option selected value="">��ѡ��</option>
							<%
								for(String value:subname.keySet()) {
								 %>
								<option value="<%=subname.get(value) %>"><%=subname.get(value) %></option>
								<%
								 }
								%>
						</select>
					</td>
				</tr>
				
				<tr>
					<td>
						�ⲿ�ְ���BԤ�ƣ�
					</td>
					<td>
						<input name="presubcost2" type="text" value="" size="20" /><font color="red"><input name="Currencytype2" id="Currencytype2" type="text" size="3" readonly="readonly" /></fon
						<div id="payId"  style="display: none">
						<select name="paystatus2" id="paystatus2" style="width: 80px" onchange="ispaystatus(2)">
						<option value="" selected>ѡ�����</option>
						<option value="�۱�">�۱�</option>
						<option value="ŷԪ">ŷԪ</option>
						<option value="��Ԫ">��Ԫ</option>
						<option value="��Ԫ">��Ԫ</option>
					</select>
					<script type="text/javascript">
								var ops2 = document.getElementById("paystatus2").options;
								for(var i=0;i<ops2.length;i++) {
									if(ops2[i].value.indexOf("<%=Currency%>")==0 && "<%=Currency%>".indexOf(ops2[i].value) == 0){
										ops2[i].selected = true;	
									}
								}
					</script>
					</div>
					</td>
					<td>
						�ⲿ�ְ�����B���ƣ�
					</td>
					<td>
						<select name="subname2" style="width: 300px" onchange="isSubname1()">
							<option selected value="">��ѡ��</option>
							<%
								for(String value:subname.keySet()) {
								 %>
								<option value="<%=subname.get(value) %>"><%=subname.get(value) %></option>
								<%
								 }
								%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						������������Ԥ�ƣ�
					</td>
					<td>
						<input name="preagcost" type="text" value="" size="40" />
					</td>
					<td>
						�����������ƣ�
					</td>
					<td>
						<select name="agname" style="width: 300px" >
							<option selected value="">��ѡ��</option>
							<%
								for(String value:agname.keySet()) {
								 %>
								<option value="<%=agname.get(value) %>"><%=agname.get(value) %></option>
								<%
								 }
								%>
						</select>
					</td>
				</tr>
				<tr id="cpay" style="display: none;">
					<td>
						�ͻ��Խɣ�
					</td>
					<td>
						��
						<input type="radio" name="clientpay" id="clientpay" value="n" checked />
						��
						<input type="radio" name="clientpay" id="clientpay" value="y" />
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				</table>
				</div>
			
			
				<%
					String dis = "";
					if("����Ŀ".equals(qt.getInvmethod())) {
						dis = "style='display: none;'";
					}
				 %>
				
				<div class="outborder" <%=dis %>>
				 <p>&nbsp;</p>
				<table cellpadding="5" cellspacing="5" width="95%" >
				<tr>
					<td width="17%">
						��Ʊ��
					</td>
					<td width="33%">
						<input name="preinvprice" id="preinvprice" type="text"  size="40" onfocus="getinvprice(this);"/>
					</td>

					<td width="17%">
						����Ʊ��ʽ��
					</td>
					<td width="33%">
						<select name="invtype" id="invtype" style="width: 300px" onchange="changeSelect(this);">
							<option value="ȫ��" selected>
								ȫ��
							</option>
							<option value="����">
								����
							</option>
							<option value="������������">
								������������
							</option>
							<option value="����">
								����
							</option>
						</select>
						
					</td>

				</tr>
				<tr>
					<td>
						��Ʊ̧ͷ��
					</td>
					<td>
						<input name="invhead" id="invhead" type="text" size="40" onfocus="getinvhead(this);"/>
					</td>
					<td>
						��Ʊ���ݣ�
					</td>
					<td>
						<input name="invcontent" id="invcontent" type="text" size="40" onfocus="getinvcontent(this);"/>
					</td>
				</tr>
				
				
			</table>
			</div>
				


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button"" id="btnAdd" onclick="checkSubmit('<%=status%>')"
						value="���">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onclick="goBack()" />
				</div>
				<p>
					&nbsp;
				</p>
		</form>
	</body>
</html>
