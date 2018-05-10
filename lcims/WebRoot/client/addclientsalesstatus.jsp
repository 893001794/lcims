<%@page import="com.lccert.crm.client.ClientSalesStatusForm"%>
<%@page import="com.lccert.crm.client.ClientSalesStatusAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientStatusForm"%>
<%@page import="com.lccert.crm.client.ClientRivalForm"%>
<%@page import="com.lccert.crm.client.ClientProjectForm"%>
<%@page import="com.lccert.crm.client.ClientProjectAction"%>
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
	String clientid = request.getParameter("clientid");
	ClientForm client=null;
	ClientSalesStatusForm clientSalesStatus=null;
	if(clientid != null || !"".equals(clientid)) {
		client=ClientAction.getInstance().findById(clientid);
		clientSalesStatus=ClientSalesStatusAction.getInstance().findByClientId(Integer.parseInt(clientid));
	}
	if(clientSalesStatus==null){
		clientSalesStatus=new ClientSalesStatusForm();
	}
 %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>��ӿͻ������ܱ�</title>
	<link rel="stylesheet" href="../css/drp.css">
	<link rel="stylesheet" href="../css/style.css">
	<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
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
	function addclientSalesStatus(){
		var totalprice=$("#totalprice").val();
		var signbackprice=$("#signbackprice").val();
		if(isNaN(totalprice)){
			alert("���۽��ֻ���������ֻ�������С������ϣ�");
			return false;
		}
		if(isNaN(signbackprice)){
			alert("���۵���ǩ���ֻ���������ֻ�������С������ϣ�");
			return false;
		}
		with (document.getElementById("quotationform")) {
			method="post";
			action="addclientsalesstatus_post.jsp";
			submit();
		}
	}
	
</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return addclientSalesStatus(this)">&nbsp; 
			
			<input name="id" id="id" type="hidden" value="<%=clientSalesStatus.getId()%>" />
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
							<b>�ͻ�����&gt;&gt;��ӿͻ������ܱ�</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="90%" cellpadding="5" cellspacing="5">
					<tr>
						<td >
							�ͻ����ƣ�
						</td>
						<td width="33%">
							<input name="clientId" type="hidden"" id="clientId" size="40" value="<%=client.getClientid()%>"/>
							<input name="client" type="text" id="client" size="40" value="<%=client.getName()%>" readonly="readonly"
									style="background-color: #FFCC99"/>
						</td>
						<td>
							�ͻ����ͣ�
						</td>
						<td>
							<select name="clientType" id="clientType" style="width: 300px">
								<%
									if(clientSalesStatus.getClientType() !=null && !clientSalesStatus.getClientType().equals("")){
									%>
									<option value="Ŀ��ͻ�" <%=clientSalesStatus.getClientType().equals("Ŀ��ͻ�")?"selected":""%>>Ŀ��ͻ�</option>
									<option value="��Ч�ͻ�" <%=clientSalesStatus.getClientType().equals("��Ч�ͻ�")?"selected":""%>>��Ч�ͻ�</option>
									<option value="����ͻ�" <%=clientSalesStatus.getClientType().equals("����ͻ�")?"selected":""%>>����ͻ�</option>
									<option value="׼�ɽ��ͻ�" <%=clientSalesStatus.getClientType().equals("׼�ɽ��ͻ�")?"selected":""%>>׼�ɽ��ͻ�</option>
									<option value="�ɽ��ͻ�" <%=clientSalesStatus.getClientType().equals("�ɽ��ͻ�")?"selected":""%>>�ɽ��ͻ�</option>
									<%
									}else{
									%>
									<option value="Ŀ��ͻ�" >Ŀ��ͻ�</option>
									<option value="��Ч�ͻ�" >��Ч�ͻ�</option>
									<option value="����ͻ�" >����ͻ�</option>
									<option value="׼�ɽ��ͻ�" >׼�ɽ��ͻ�</option>
									<option value="�ɽ��ͻ�" >�ɽ��ͻ�</option>
									<%
									}
								 %>
								
							</select>
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >��Ҫ�ԣ�</td>
						<td>
							<select name="nature" id="nature" style="width: 300px">
								<%
									if(clientSalesStatus.getNature() !=null && !clientSalesStatus.getNature().equals("")){
									%>
									<option value="��" <%=clientSalesStatus.getNature().equals("��")?"selected":""%>>��</option>
									<option value="һ��" <%=clientSalesStatus.getNature().equals("һ��")?"selected":""%>>һ��</option>
									<option value="�е�" <%=clientSalesStatus.getNature().equals("�е�")?"selected":""%>>�е�</option>
									<option value="�ߵ�" <%=clientSalesStatus.getNature().equals("�ߵ�")?"selected":""%>>�ߵ�</option>
									<option value="VIP" <%=clientSalesStatus.getNature().equals("VIP")?"selected":""%>>VIP</option>
									<%
									}else{
									%>
									<option value="��" >��</option>
									<option value="һ��" >һ��</option>
									<option value="�е�" >�е�</option>
									<option value="�ߵ�" >�ߵ�</option>
									<option value="VIP" >VIP</option>
									<%
									}
								 %>
								
							</select>  
						</td>
						<td >�ͻ�������Ϣ��</td>
						<td >
							<select name="basicinfor" id="basicinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getBasicInfor()!=null && !clientSalesStatus.getBasicInfor().equals("")){
									%>
									<option value="�����ռ�" <%=clientSalesStatus.getBasicInfor().equals("�����ռ�")?"selected":""%>>�����ռ�</option>
									<option value="�ռ����" <%=clientSalesStatus.getBasicInfor().equals("�ռ����")?"selected":""%>>�ռ����</option>
									<option value="��Ϣ����" <%=clientSalesStatus.getBasicInfor().equals("��Ϣ����")?"selected":""%>>��Ϣ����</option>
									<option value="ȷ�����" <%=clientSalesStatus.getBasicInfor().equals("ȷ�����")?"selected":""%>>ȷ�����</option>
									<%
									}else{
									%>
									<option value="�����ռ�" >�����ռ�</option>
									<option value="�ռ����" >�ռ����</option>
									<option value="��Ϣ����" >��Ϣ����</option>
									<option value="ȷ�����" >ȷ�����</option>
									<%
									}
								 %>
								
							</select>  
						</td>
						
					</tr>
					<tr  id ="trpid">
						<td >����������Ϣ</td>
						<td >
							<select name="rivalinfor" id="rivalinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getRivalInfor() !=null && !clientSalesStatus.getRivalInfor().equals("")){
									%>
									<option value="�����ռ�" <%=clientSalesStatus.getRivalInfor().equals("�����ռ�")?"selected":""%>>�����ռ�</option>
									<option value="�ռ����" <%=clientSalesStatus.getRivalInfor().equals("�ռ����")?"selected":""%>>�ռ����</option>
									<option value="��Ϣ����" <%=clientSalesStatus.getRivalInfor().equals("��Ϣ����")?"selected":""%>>��Ϣ����</option>
									<option value="ȷ�����" <%=clientSalesStatus.getRivalInfor().equals("ȷ�����")?"selected":""%>>ȷ�����</option>
									<%
									}else{
									%>
									<option value="�����ռ�" >�����ռ�</option>
									<option value="�ռ����" >�ռ����</option>
									<option value="��Ϣ����" >��Ϣ����</option>
									<option value="ȷ�����" >ȷ�����</option>
									<%
									}
								 %>
								
							</select> 
						</td>
						<td >�ɹ���������֯�ܹ�</td>
						<td >
							<select name="procureflow" id="procureflow" style="width: 300px">
								<%
									if(clientSalesStatus.getProcureFlow() !=null && !clientSalesStatus.getProcureFlow().equals("")){
									%>
									<option value="�����ռ�" <%=clientSalesStatus.getProcureFlow().equals("�����ռ�")?"selected":""%>>�����ռ�</option>
									<option value="�ռ����" <%=clientSalesStatus.getProcureFlow().equals("�ռ����")?"selected":""%>>�ռ����</option>
									<option value="��Ϣ����" <%=clientSalesStatus.getProcureFlow().equals("��Ϣ����")?"selected":""%>>��Ϣ����</option>
									<option value="ȷ�����" <%=clientSalesStatus.getProcureFlow().equals("ȷ�����")?"selected":""%>>ȷ�����</option>
									<%
									}else{
									%>
									<option value="�����ռ�" >�����ռ�</option>
									<option value="�ռ����" >�ռ����</option>
									<option value="��Ϣ����" >��Ϣ����</option>
									<option value="ȷ�����" >ȷ�����</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					<tr  id ="trpid">
						<td >��Ŀ��Ϣ��</td>
						<td >
							<select name="projectinfor" id="projectinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getProjectInfor() !=null && !clientSalesStatus.getProjectInfor().equals("")){
									%>
									<option value="�����ռ�" <%=clientSalesStatus.getProjectInfor().equals("�����ռ�")?"selected":""%>>�����ռ�</option>
									<option value="�ռ����" <%=clientSalesStatus.getProjectInfor().equals("�ռ����")?"selected":""%>>�ռ����</option>
									<option value="��Ϣ����" <%=clientSalesStatus.getProjectInfor().equals("��Ϣ����")?"selected":""%>>��Ϣ����</option>
									<option value="�ٽ��׶�" <%=clientSalesStatus.getProjectInfor().equals("�ٽ��׶�")?"selected":""%>>�ٽ��׶�</option>
									<%
									}else{
									%>
									<option value="�����ռ�" >�����ռ�</option>
									<option value="�ռ����" >�ռ����</option>
									<option value="��Ϣ����" >��Ϣ����</option>
									<option value="�ٽ��׶�" >�ٽ��׶�</option>
									<%
									}
								 %>
								
							</select> 
						</td>
						<td >&nbsp;</td>
						<td >
							&nbsp;
						</td>
					</tr>
					
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="90%" cellpadding="5" cellspacing="5">
					<tr>
						<td >
							ѯ�۽׶Σ�
						</td>
						<td width="33%">
							<select name="inquirystage" id="inquirystage" style="width: 300px">
								<%
									if(clientSalesStatus.getInquirYstage() !=null && !clientSalesStatus.getInquirYstage().equals("")){
									%>
									<option value="��ͷ��ѯ" <%=clientSalesStatus.getInquirYstage().equals("��ͷ��ѯ")?"selected":""%>>��ͷ��ѯ</option>
									<option value="�㷺��ѯ" <%=clientSalesStatus.getInquirYstage().equals("�㷺��ѯ")?"selected":""%>>�㷺��ѯ</option>
									<option value="����������ѯ" <%=clientSalesStatus.getInquirYstage().equals("����������ѯ")?"selected":""%>>����������ѯ</option>
									<%
									}else{
									%>
									<option value="��ͷ��ѯ" >��ͷ��ѯ</option>
									<option value="�㷺��ѯ" >�㷺��ѯ</option>
									<option value="����������ѯ" >����������ѯ</option>
									<%
									}
								 %>
								
							</select>
						</td>
						<td>
							���۲����ƶ�������׶Σ�
						</td>
						<td>
							<select name="salesstrategy" id="salesstrategy" style="width: 300px">
								<%
									if(clientSalesStatus.getSalesStrategy() !=null && !clientSalesStatus.getSalesStrategy().equals("")){
									%>
									<option value="�����ƶ�" <%=clientSalesStatus.getSalesStrategy().equals("�����ƶ�")?"selected":""%>>�����ƶ�</option>
									<option value="������ͨ" <%=clientSalesStatus.getSalesStrategy().equals("������ͨ")?"selected":""%>>������ͨ</option>
									<option value="��������" <%=clientSalesStatus.getSalesStrategy().equals("��������")?"selected":""%>>��������</option>
									<option value="�ȴ��ɽ�" <%=clientSalesStatus.getSalesStrategy().equals("�ȴ��ɽ�")?"selected":""%>>�ȴ��ɽ�</option>
									<%
									}else{
									%>
									<option value="�����ƶ�" >�����ƶ�</option>
									<option value="������ͨ" >������ͨ</option>
									<option value="��������" >��������</option>
									<option value="�ȴ��ɽ� >�ȴ��ɽ�</option>
									<%
									}
								 %>
								
							</select>
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >���۽�</td>
						<td>
							<input type="text" id="totalprice" name ="totalprice" value="<%=clientSalesStatus.getTotalPrice()%>">
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
						
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="90%" cellpadding="5" cellspacing="5">
					<tr  id ="trpid">
						<td >���۵���ǩ��</td>
						<td >
							<input type="text" id="signbackprice" name ="signbackprice" value="<%=clientSalesStatus.getSignBackPrice() %>">
						</td>
						<td >��Ʒ�����ṩ</td>
						<td >
							<select name="sampleinfor" id="sampleinfor" style="width: 300px">
								<%
									if(clientSalesStatus.getSampleInfor() !=null && !clientSalesStatus.getSampleInfor().equals("")){
									%>
									<option value="��Ʒ�������ṩ����" <%=clientSalesStatus.getSampleInfor().equals("��Ʒ�������ṩ����")?"selected":""%>>��Ʒ�������ṩ����</option>
									<option value="��Ʒ��������Ƿȱ" <%=clientSalesStatus.getSampleInfor().equals("��Ʒ��������Ƿȱ")?"selected":""%>>��Ʒ��������Ƿȱ</option>
									<option value="����������ƷǷȱ" <%=clientSalesStatus.getSampleInfor().equals("����������ƷǷȱ")?"selected":""%>>����������ƷǷȱ</option>
									<option value="������ƷȫǷȱ" <%=clientSalesStatus.getSampleInfor().equals("������ƷȫǷȱ")?"selected":""%>>������ƷȫǷȱ</option>
									<%
									}else{
									%>
									<option value="��Ʒ�������ṩ����" >��Ʒ�������ṩ����</option>
									<option value="��Ʒ��������Ƿȱ" >��Ʒ��������Ƿȱ</option>
									<option value="����������ƷǷȱ" >����������ƷǷȱ</option>
									<option value="������ƷȫǷȱ" >������ƷȫǷȱ</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					
					<tr  id ="trpid">
						<td >����֧�����ţ�</td>
						<td >
							<select name="partpayment" id="partpayment" style="width: 300px">
								<%
									if(clientSalesStatus.getPartPayment() !=null && !clientSalesStatus.getPartPayment().equals("")){
									%>
									<option value="֧��Ԥ����" <%=clientSalesStatus.getPartPayment().equals("֧��Ԥ����")?"selected":""%>>֧��Ԥ����</option>
									<option value="ȫ������" <%=clientSalesStatus.getPartPayment().equals("ȫ������")?"selected":""%>>ȫ������</option>
									<option value="Ƿȱβ��" <%=clientSalesStatus.getPartPayment().equals("Ƿȱβ��")?"selected":""%>>Ƿȱβ��</option>
									<option value="ĩ֧���κο���" <%=clientSalesStatus.getPartPayment().equals("ĩ֧���κο���")?"selected":""%>>ĩ֧���κο���</option>
									<%
									}else{
									%>
									<option value="֧��Ԥ����" >֧��Ԥ����</option>
									<option value="ȫ������" >ȫ������</option>
									<option value="Ƿȱβ��" >Ƿȱβ��</option>
									<option value="ĩ֧���κο���" >ĩ֧���κο���</option>
									<%
									}
								 %>
								
							</select> 
						</td>
						<td >��Ʊ���ݣ�</td>
						<td >
							<select name="invoice" id="invoice" style="width: 300px">
								<%
									if(clientSalesStatus.getInvoice() !=null && !clientSalesStatus.getInvoice().equals("")){
									%>
									<option value="�ѿ�ȫ�Ʊ" <%=clientSalesStatus.getInvoice().equals("�ѿ�ȫ�Ʊ")?"selected":""%>>�ѿ�ȫ�Ʊ</option>
									<option value="ĩ����Ʊ" <%=clientSalesStatus.getInvoice().equals("ĩ����Ʊ")?"selected":""%>>ĩ����Ʊ</option>
									<option value="�����ݽ�Ʊ" <%=clientSalesStatus.getInvoice().equals("�����ݽ�Ʊ")?"selected":""%>>�����ݽ�Ʊ</option>
									<%
									}else{
									%>
									<option value="�ѿ�ȫ�Ʊ" >�ѿ�ȫ�Ʊ</option>
									<option value="ĩ����Ʊ" >ĩ����Ʊ</option>
									<option value="�����ݽ�Ʊ" >�����ݽ�Ʊ</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					<tr  id ="trpid">
						<td >����֤�鲿�ݣ�</td>
						<td >
							<select name="certificate" id="certificate" style="width: 300px">
								<%
									if(clientSalesStatus.getCertificate() !=null && !clientSalesStatus.getCertificate().equals("")){
									%>
									<option value="�����ѳ����ĳ�" <%=clientSalesStatus.getCertificate().equals("�����ѳ����ĳ�")?"selected":""%>>�����ѳ����ĳ�</option>
									<option value="�����ѳ�ĩ�ĳ�" <%=clientSalesStatus.getCertificate().equals("�����ѳ�ĩ�ĳ�")?"selected":""%>>�����ѳ�ĩ�ĳ�</option>
									<option value="���ݸ屨�沢ȷ��" <%=clientSalesStatus.getCertificate().equals("���ݸ屨�沢ȷ��")?"selected":""%>>���ݸ屨�沢ȷ��</option>
									<option value="����ĩ��" <%=clientSalesStatus.getCertificate().equals("����ĩ��")?"selected":""%>>����ĩ��</option>
									<%
									}else{
									%>
									<option value="�����ѳ����ĳ�" >�����ѳ����ĳ�</option>
									<option value="�����ѳ�ĩ�ĳ�" >�����ѳ�ĩ�ĳ�</option>
									<option value="���ݸ屨�沢ȷ��" >���ݸ屨�沢ȷ��</option>
									<option value="����ĩ��" >����ĩ��</option>
									<%
									}
								 %>
							</select> 
						</td>
						<td >�ͻ�����Ȳ��ݣ�</td>
						<td >
							<select name="satisfaction" id="satisfaction" style="width: 300px">
								<%
									if(clientSalesStatus.getSatisFaction() !=null && !clientSalesStatus.getSatisFaction().equals("")){
									%>
									<option value="�ǳ�����" <%=clientSalesStatus.getSatisFaction().equals("�ǳ�����")?"selected":""%>>�ǳ�����</option>
									<option value="�����һ��" <%=clientSalesStatus.getSatisFaction().equals("�����һ��")?"selected":""%>>�����һ��</option>
									<option value="����Ⱥܲ�" <%=clientSalesStatus.getSatisFaction().equals("����Ⱥܲ�")?"selected":""%>>����Ⱥܲ�</option>
									<%
									}else{
									%>
									<option value="�ǳ�����" >�ǳ�����</option>
									<option value="�����һ��" >�����һ��</option>
									<option value="����Ⱥܲ�" >����Ⱥܲ�</option>
									<%
									}
								 %>
								
							</select> 
						</td>
					</tr>
					<tr  id ="trpid">
						
						<td >��ע��</td>
						<td colspan="3">
							<input type="text" id="remark" name="remark" size="150px;" style="width:850px" value="<%=clientSalesStatus.getRemark()%>">
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="���涩��" onClick="addclientSalesStatus();">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
