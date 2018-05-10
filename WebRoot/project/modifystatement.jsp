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
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="java.util.Map"%>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}
	int id = Integer.parseInt(strid);
	
	Project p = ProjectAction.getInstance().getProjectById(id);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}
	
	String month=""; //��ȡ�������A��Ǯ
	String monthType=""; //��ȡ�������A��������
	String month2=""; //��ȡ�������A��Ǯ
	String monthType2=""; //��ȡ�������A��������
	String presubcost=p.getPresubcost();
	String presubcost2=p.getPresubcost2();
	boolean result = presubcost.matches(".*\\p{Alpha}.*"); //�ж��������A�Ľ�������Ƿ���Ӣ���ַ�
	boolean result2 =presubcost2.matches(".*\\p{Alpha}.*");//�ж��������B�Ľ�������Ƿ���Ӣ���ַ�
	if(result == true ){
	 month=presubcost.substring(0,presubcost.length()-3);
	 monthType=presubcost.substring(presubcost.length()-3,presubcost.length());
	}else{
	month =presubcost;
	}
	
	if(result2 == true ){
	 month2=presubcost2.substring(0,presubcost2.length()-3);
	 monthType2=presubcost2.substring(presubcost2.length()-3,presubcost2.length());
	}else{
	month2 =presubcost2;
	}
	
	String Currency=request.getParameter("Currency");
	
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	
	if(qt == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
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
window.onload=function()
    {
    	var obj = document.getElementById("ptype");
    	//if(!(obj.value.indexOf("��ѧ����")==0 && "��ѧ����".indexOf(obj.value)==0)) {
    		changePtype(obj);
    	//}
    }
function changePtype(obj) {
	if(!(obj.value.indexOf("��ѧ����")==0 && "��ѧ����".indexOf(obj.value)==0)) {//ѡ�а������ʱ
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
          subname1.add(new Option("<%=subname2.get(value)%>","<%=subname2.get(value)%>",false,<%=subname2.get(value).equals(p.getSubname())%>));
          subname2.add(new Option("<%=subname2.get(value)%>","<%=subname2.get(value)%>",false,<%=subname2.get(value).equals(p.getSubname2())%>));
          
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
          subname1.add(new Option("<%=subname.get(value)%>","<%=subname.get(value)%>",false,<%=subname.get(value).equals(p.getSubname())%>));
          subname2.add(new Option("<%=subname.get(value)%>","<%=subname.get(value)%>",false,<%=subname.get(value).equals(p.getSubname2())%>));
          
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
	
	function showrid() {
		window.open("showrid.jsp","","dialogWidth:800px;dialogHeight:600px");
	}
	
	
	function changeSelect(invtype) {
		if(invtype.value.match("����")) {
			document.getElementById("invhead").readOnly=true;
			document.getElementById("invhead").style.background="#F2F2F2";
			document.getElementById("invhead").value = "";
			
			document.getElementById("invcontent").readOnly=true;
			document.getElementById("invcontent").style.background="#F2F2F2";
			document.getElementById("invcontent").value = "";
			
			document.getElementById("preinvprice").readOnly=true;
			document.getElementById("preinvprice").style.background="#F2F2F2";
			document.getElementById("preinvprice").value = "";
			
		} else {
			document.getElementById("invhead").readOnly=false;
			document.getElementById("invhead").style.background="#FFFFFF";
			
			document.getElementById("invcontent").readOnly=false;
			document.getElementById("invcontent").style.background="#FFFFFF";
			
			document.getElementById("preinvprice").readOnly=false;
			document.getElementById("preinvprice").style.background="#FFFFFF";
			
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
</script>



	</head>

	<body class="body1" >
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
					<b>&gt;&gt;���۹���&gt;&gt;�޸���Ŀ���˵�</b>
				</td>
			</tr>
		</table>

		<hr width="97%" align="center" size=0>

		<form name="form1" action="modifystatement_post.jsp" method="post">
			<input type="hidden" name="sid" value="<%=p.getSid() %>">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>

						<td>
							���۵���ţ�
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=qt.getPid()==null?"":qt.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							���۵����ͣ�
						</td>
						<td>
							<%
						String strquo = "";
						if("new".equals(qt.getQuotype())) 
							strquo = "�±��۵�";
						else if("add".equals(qt.getQuotype()))
							strquo = "�����زⱨ�۵�";
						else if("mod".equals(qt.getQuotype()))
							strquo = "�޸ı��汨�۵�";
						 %>
							<input name="quotype" size="40" type="text"
								value="<%=strquo %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
					<tr>
						<td>
							�ͻ����ƣ�
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							&nbsp;
						</td>
						<td>
							&nbsp;
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
					<input name="ptype" type="text" value="<%=p.getPtype() %>" size="40" style="background-color: #F2F2F2" readonly="readonly"/>
					<%-- 
						<select name="ptype" id="ptype" style="width: 300px" onchange="changePtype(this);">
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
							<option value="��Ч����">
								��Ч����
							</option>
						</select>
						<script type="text/javascript">
								var ops = document.getElementById("ptype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=cp.getPtype()%>".charCodeAt()){
										ops[i].selected = true;	
										changePtype(obs);
									}
								}
						</script>
					--%>
					</td>
					<td width="17%">
					�������ݣ�
					</td>
					<td width="33%">
					<input name="testcontent" type="text" size="40"
									value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>" />
					</td>
					</tr>
				</table>
				<table id="dis" cellpadding="5" cellspacing="5" width="95%" style="display: none;">
				<tr>

						<td width="40%">
							<div id="mydiv">
								�Բ�
								<input type="checkbox" id="type" name="type" value="�Բ�" 
									onClick="chooseOne(this);" />
								|&nbsp; ��������
								<input type="checkbox" id="type" name="type" value="��������"
									onClick="chooseOne(this);" />

							</div>
						<script type="text/javascript">
								var obj = document.getElementById("mydiv");
								for(var i=0;i<obj.children.length;i++) {
									if(obj.children[i].value.indexOf("<%=p.getType()%>")==0 && "<%=p.getType()%>".indexOf(obj.children[i].value)==0){
										obj.children[i].checked = true;
									}
								}
						</script>
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
								<input type="checkbox" id="lab" name="lab" value="��ɽʵ����" 
									onClick="chooseOne2(this);" />
								|&nbsp; ��ݸʵ����
								<input type="checkbox" id="lab" name="lab" value="��ݸʵ����"
									onClick="chooseOne2(this);" />
							</div>
							<script type="text/javascript">
								var obj = document.getElementById("mydiv2");
								for(var i=0;i<obj.children.length;i++) {
									if(obj.children[i].value.indexOf("<%=p.getLab()%>")==0 && "<%=p.getLab()%>".indexOf(obj.children[i].value)==0){
										obj.children[i].checked = true;
									}
								}
						</script>
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
							<input type="radio" name="isout" id="isout" value="n"  />
							��
							<input type="radio" name="isout" id="isout" value="y" />
						</td>
						<script type="text/javascript">
							for (var i = 0; i < form1.isout.length; i++) {
								if (form1.isout[i].value.indexOf("<%=p.getIsout()%>")==0 && "<%=p.getIsout()%>".indexOf(form1.isout[i].value)==0) {
									form1.isout[i].checked = true;
								}
							}
						</script>
						<td width="10%">
							&nbsp;
						</td>
						<td width="40%">&nbsp;</td>
						<td width="10%">&nbsp;</td>
					</tr>
			</table>
			</div>
			<div class="outborder">
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						����Ŀ��
					</td>
					<td width="33%">
						<input name="price" type="text" value="<%=p.getPrice() %>" size="40" />
					</td>
					<td width="17%">
						�ڲ��ְ���Ԥ�ƣ�
					</td>
					<td width="33%">
						<input name="insubcost" type="text" value="<%=p.getInsubcost() %>" size="40" />
					</td>
				</tr>
				<tr>
					<td>
						�ⲿ�ְ���AԤ�ƣ�
					</td>
				<td>
						<input name="presubcost1" type="text" size="20" value="<%=month %>"/><font color="red"><input name="Currencytype" value="<%=monthType%>" id="Currencytype" type="text" size="3" readonly="readonly"/></fon
						<div id="payId"  style="display: none">
						<select name="paystatus" id="paystatus" style="width: 80px" onchange="ispaystatus(1)">
						<option value="" selected>ѡ�����</option>
						<option value="�۱�" <%=monthType.equals("HKD")?"selected":"" %>>�۱�</option>
						<option value="ŷԪ"  <%=monthType.equals("EUR")?"selected":"" %>>ŷԪ</option>
						<option value="��Ԫ"  <%=monthType.equals("AUD")?"selected":"" %>>��Ԫ</option>
						<option value="��Ԫ"  <%=monthType.equals("USD")?"selected":"" %>>��Ԫ</option>
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
						<select name="subname1" id="subname1" style="width: 300px">
							<option value="" selected>��ѡ��</option>
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
						<input name="presubcost2" type="text" value="<%=month2 %>" size="20" /><font color="red"><input name="Currencytype2" id="Currencytype2" value="<%=monthType2 %>" type="text" size="3" readonly="readonly" /></fon
						<div id="payId"  style="display: none">
						<select name="paystatus2" id="paystatus2" style="width: 80px" onchange="ispaystatus(2)">
						<option value="" selected>ѡ�����</option>
						<option value="�۱�" <%=monthType2.equals("HKD")?"selected":"" %>>�۱�</option>
						<option value="ŷԪ"  <%=monthType2.equals("EUR")?"selected":"" %>>ŷԪ</option>
						<option value="��Ԫ"  <%=monthType2.equals("AUD")?"selected":"" %>>��Ԫ</option>
						<option value="��Ԫ"  <%=monthType2.equals("USD")?"selected":"" %>>��Ԫ</option>
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
						<select name="subname2" id="subname2" style="width: 300px">
							<option value="">��ѡ��</option>
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
						<input name="preagcost" type="text" value="<%=p.getPreagcost() %>" size="40" />
					</td>
					<td>
						�����������ƣ�
					</td>
					<td>
						<select name="agname" id="agname" style="width: 300px">
							<option value="">��ѡ��</option>
							<%
								for(String value:agname.keySet()) {
								 %>
								<option value="<%=agname.get(value) %>" <%=agname.get(value).equals(p.getAgname())?"selected":"" %>><%=agname.get(value) %></option>
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
					<script type="text/javascript">
							for (var i = 0; i < form1.clientpay.length; i++) {
								if (form1.clientpay[i].value.indexOf("<%=p.getClientpay()%>")==0 && "<%=p.getClientpay()%>".indexOf(form1.clientpay[i].value)==0) {
									form1.clientpay[i].checked = true;
								}
							}
						</script>
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
						<input name="preinvprice" id="preinvprice" type="text" value="<%=p.getPreinvprice() %>" size="40" />
					</td>

					<td width="17%">
						����Ʊ��ʽ��
					</td>
					<td width="33%">
						<select name="invtype" id="invtype" style="width: 300px" onchange="changeSelect(this);">
							<option value="ȫ��" selected>
								ȫ��
							</option>
							<option value="������������">
								������������
							</option>
							<option value="����">
								����
							</option>
							<option value="�վ�">
								�վ�
							</option>
						</select>
						<script type="text/javascript">
							var ops = document.getElementById("invtype").options;
							var str2 = "<%=p.getInvtype()%>";
							for(var i=0;i<obj.children.length;i++) {
								var str1 = obj.children[i].value;
								if(str1.indexOf(str2)==0 && str2.indexOf(str1)==0){
									obj.children[i].selected = true;
								}
							}
						</script>
					</td>

				</tr>
				<tr>
					<td>
						��Ʊ��ͷ��
					</td>
					<td>
						<input name="invhead" id="invhead" type="text" value="<%=p.getInvhead()==null?"":p.getInvhead() %>" size="40" />
					</td>
					<td>
						��Ʊ���ݣ�
					</td>
					<td>
						<input name="invcontent" id="invcontent" type="text" value="<%=p.getInvcontent()==null?"":p.getInvcontent() %>" size="40" />
					</td>
				</tr>
				
				
			</table>
			</div>
				


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="�޸�">
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
