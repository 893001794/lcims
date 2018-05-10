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
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	String add = request.getParameter("add");
	Quotation qt = null;
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

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��Ŀ�ֽ�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
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
	
	
	function changePtype(obj) {
	if(!(obj.value.indexOf("��ѧ����")==0 && "��ѧ����".indexOf(obj.value)==0)) {//ѡ�а������ʱ
		//alert("��ʾ����");
		document.getElementById("cpay").style.display = "";
		document.getElementById("dis").style.display = "";
		document.getElementById("chem").style.display = "none";
		var subname1 = document.getElementById('subname1');
	    subname1.options.length=0;
	    var subname2 = document.getElementById('subname2');
	    subname2.options.length=0;
       try{
          subname1.add(new Option("��ѡ��",""));
          subname2.add(new Option("��ѡ��",""));
          subname1.add(new Option("���","���"));
          subname2.add(new Option("���","���"));
          subname1.add(new Option("�����","�����"));
          subname2.add(new Option("�����","�����"));
          subname1.add(new Option("CFC","CFC"));
          subname2.add(new Option("CFC","CFC"));
          subname1.add(new Option("�㰲��","�㰲��"));
          subname2.add(new Option("�㰲��","�㰲��"));
          subname1.add(new Option("����","����"));
          subname2.add(new Option("����","����"));
          subname1.add(new Option("�㶫�ʼ�","�㶫�ʼ�"));
          subname2.add(new Option("�㶫�ʼ�","�㶫�ʼ�"));
          subname1.add(new Option("ITACS","ITACS"));
          subname2.add(new Option("ITACS","ITACS"));
          subname1.add(new Option("URGENT","URGENT"));
          subname2.add(new Option("URGENT","URGENT"));
          subname1.add(new Option("QUALSURE CONSULTANTS","QUALSURE CONSULTANTS"));
          subname2.add(new Option("QUALSURE CONSULTANTS","QUALSURE CONSULTANTS"));
        }catch(e){
        }
	} else {//ѡ�л�ѧ����ʱ
		document.getElementById("chem").style.display = "";
		document.getElementById("dis").style.display = "none";
		document.getElementById("cpay").style.display = "none";
		document.getElementById("form1").clientpay[0].checked = true;
		//alert("����");
		var subname1 = document.getElementById('subname1');
	    subname1.options.length=0;
	    var subname2 = document.getElementById('subname2');
	    subname2.options.length=0;
         try{
          subname1.add(new Option("��ѡ��",""));
          subname2.add(new Option("��ѡ��",""));
          subname1.add(new Option("SMQ","SMQ"));
          subname2.add(new Option("SMQ","SMQ"));
          subname1.add(new Option("SGS","SGS"));
          subname2.add(new Option("SGS","SGS"));
          subname1.add(new Option("�㶫�ʼ�","�㶫�ʼ�"));
          subname2.add(new Option("�㶫�ʼ�","�㶫�ʼ�"));
          subname1.add(new Option("��ɽ�ʼ�","��ɽ�ʼ�"));
          subname2.add(new Option("��ɽ�ʼ�","��ɽ�ʼ�"));
          subname1.add(new Option("CTI���ڷֹ�˾","CTI���ڷֹ�˾"));
          subname2.add(new Option("CTI���ڷֹ�˾","CTI���ڷֹ�˾"));
          subname1.add(new Option("CTI���ݷֹ�˾","CTI���ݷֹ�˾"));
          subname2.add(new Option("CTI���ݷֹ�˾","CTI���ݷֹ�˾"));
          subname1.add(new Option("����","����"));
          subname2.add(new Option("����","����"));
          subname1.add(new Option("�ж�","�ж�"));
          subname2.add(new Option("�ж�","�ж�"));
          subname1.add(new Option("ITS","ITS"));
          subname2.add(new Option("ITS","ITS"));
        }catch(e){
        }
	}
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
					<form name=search method=post
						action=addstatement.jsp?command=search autocomplete="off">
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


		<form name="form1" action="addstatement_post.jsp" method="post">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<input type="hidden" name="add" value="<%=add %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
					
						<td>
							���۵���ţ�
						</td>
						<td>
							<input name="pid" id="pid" size="40" type="text"
								value="<%=qt.getPid()==null?"":qt.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
						��Ŀ�ܽ�					</td>
					<td>
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>"/>				  </td>
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
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
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
							<option value="��Ч����">
								��Ч����
							</option>
						</select>
					</td>
					<td>
					�����ţ�
					</td>
					<td>
					<input name="rid" type="text" value="" size="40" />
					</td>
				</tr>
				</table>
				<table id="chem" cellpadding="5" cellspacing="5" width="95%" style="display: ;">
				<tr>
					<td width="17%">
							��Ŀ����ʱ�䣺
						</td>
						<td width="33%">
							<input name="buildtime" type="text" id="rptime" size="40" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'rptime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>
						<td width="17%">
							����ͻ����ƣ�
						</td>
						<td width="33%">
							<input id="rpclient" type="text" name="rpclient" size="40" />
							 <script>   
						        $("#rpclient").autocomplete("../client_ajax.jsp",{
						            delay:10,
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
					
				</tr>
				<tr>
					<td width="17%">
							��Ʒ���ƣ�
						</td>
						<td width="33%">
							<input name="samplename" type="text" value="" size="40" />
						</td>
						<td>
					������Ŀ��
					</td>
					<td>
					<input name="testcontent" type="text" value="" size="40" />
					</td>
				</tr>
			</table>
			<table id="dis" cellpadding="5" cellspacing="5" width="95%" style="display:none ;">
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
						<input name="price" id="price" type="text" value="" size="40" />
					</td>
					<td width="17%">
						�ڲ��ְ���Ԥ�ƣ�
					</td>
					<td width="33%">
						<input name="insubcost" type="text" value="" size="40" />
					</td>
				</tr>
				<tr>
					<td>
						�ⲿ�ְ���AԤ�ƣ�
					</td>
					<td>
						<input name="presubcost1" type="text" value="" size="40" />
					</td>
					<td>
						�ⲿ�ְ�����A���ƣ�
					</td>
					<td>
						<select name="subname1" style="width: 300px">
							<option selected value="">��ѡ��</option>
							<option value="SMQ">SMQ</option>
							<option value="SGS">SGS</option>
							<option value="�㶫�ʼ�">�㶫�ʼ�</option>
							<option value="��ɽ�ʼ�">��ɽ�ʼ�</option>
							<option value="CTI���ڷ�">CTI���ڷ�</option>
							<option value="CTI���ݷ�">CTI���ݷ�</option>
							<option value="����">����</option>
							<option value="�ж�">�ж�</option>
							<option value="ITS">ITS</option>
							<option value="����">����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						�ⲿ�ְ���BԤ�ƣ�
					</td>
					<td>
						<input name="presubcost2" type="text" value="" size="40" />
					</td>
					<td>
						�ⲿ�ְ�����B���ƣ�
					</td>
					<td>
						<select name="subname2" style="width: 300px">
							<option selected value="">��ѡ��</option>
							<option value="SMQ">SMQ</option>
							<option value="SGS">SGS</option>
							<option value="�㶫�ʼ�">�㶫�ʼ�</option>
							<option value="��ɽ�ʼ�">��ɽ�ʼ�</option>
							<option value="CTI���ڷ�">CTI���ڷֹ�˾</option>
							<option value="CTI���ݷ�">CTI���ݷֹ�˾</option>
							<option value="����">����</option>
							<option value="�ж�">�ж�</option>
							<option value="ITS">ITS</option>
							<option value="����">����</option>
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
							<option value="TUV RH">TUV RH</option>
							<option value="TUV PS">TUV PS</option>
							<option value="ITS">ITS</option>
							<option value="UL">UL</option>
							<option value="CQC">CQC</option>
							<option value="NEMKO">NEMKO</option>
							<option value="SGS">SGS</option>
							<option value="����">����</option>
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
			
			
				
				


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
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
