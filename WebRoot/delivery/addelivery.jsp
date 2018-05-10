<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	String status=request.getParameter("status");
	UserForm user = (UserForm)session.getAttribute("user");
	status=new String (status.getBytes("ISO-8859-1"), "GBK");
	Quotation qt = null;
	if (sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;		
	}
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}
	qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	
	if(qt == null) {
		qt = new Quotation();
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>���</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script src="../javascript/orderscript.js"></script>
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
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
		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
	
		function checkForm() {
		var str=document.getElementsByName('consignA');  //ѡ������name="aihao"�Ķ��󣬷�������
		var objarray=str.length;
		var chestr="";
		for(var i=0;i<objarray;i++ ){
		if(str[i].checked == true){
			chestr +=str[i].value+",";
		}
		}
			if(chestr == "") {
				alert("��ѡ��������Ʒ����!");
				return false;
			}
			if(document.form1.payment.value == "") {
				alert("��ѡ�񸶿ʽ!");
				return false;
			}
			//document.form1.action ="printdelivery.jsp?consignA="+chestr+"&sid=<%=sid %>&status=<%=status %>"
			document.form1.action ="newdelivery.jsp?consignA="+chestr+"&sid=<%=sid %>&status=<%=status %>"
			window.close();
			document.form1.submit();
		}
		
	</script>

	</head>

	<body class="body1">
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
							<b>�ͷ�����&gt;&gt;��ѧ��Ŀ�ŵ�</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>


		<form name="form1" action="buildproject_post.jsp" method="post">
		
			<input type="hidden" name="id" value="<%=p.getId() %>">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
						<td width="20%">
							���۵���ţ�
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=p.getPid()==null?"":p.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="18%">
							���۵����ͣ�
						</td>
						<td width="">
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
						<td width="15%">
							�ܽ�
						</td>
						<td>
						
							<input name="totalprice" size="40" type="text" value="<%=new DecimalFormat("#.00").format(qt.getTotalprice()) %>"
								 />
						</td>
						<td width="12%">
							��Ŀ���ͣ�
						</td>
						<td width="">
							<input name="ptype" size="40" type="text"
								value="<%=p.getPtype() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td width="15%">
							�ռ���˾��
						</td>
						<td>
							<input type="text"  name ="username" value="<%=user.getName() %>">
							<input name="consigneeC" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient()%>"
								 />
						</td>
						<td width="7%">
							�ռ��ˣ�
						</td>
						<td width="20%">
								<%
								ContactForm contact =new ContactForm();
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client != null) {
								List<ContactForm> contacts = ClientAction.getInstance().getContacts(client.getClientid());
								for(int i=0;i<contacts.size();i++) {
									 contact = contacts.get(i);
						 %>
						 <input name ="recipient"  value="<%=client.getContact().getContact() %>" size="40">
								<%
							 	}
							 }
						  %>

						</td>
					</tr>
					<tr>
					<td width="15%">
						�ռ���ϸ��ַ��
						</td>
						<td colspan="3"><input name ="contactAdd" size="90" value="<%=client.getAddr()==null?"":client.getAddr() %>"></td>
					</tr>
					<tr>
				<td width="15%">
						�ռ�TEL��
						</td>
						<td width="20%">
						<input name ="contactTEL" size="40" value="<%=client.getContact().getTel() %>|<%=client.getContact().getMobile()%>">
						&nbsp;
						</td>
					</tr>
					<tr>
						<td width="">
						������Ʒ���ƣ�
						</td>	
						<td colspan="3">
						<div id="mydiv">
								����
								<input type="checkbox" name="consignA" id ="consignA" value="����" 
									 />
								|&nbsp; ��Ʊ
								<input type="checkbox" name="consignA" id ="consignA"  value="��Ʊ"
									 />
								|&nbsp; �վ�
								<input type="checkbox" name="consignA" id ="consignA"  value="�վ�" 
									 />
									|&nbsp; Ʊ��
								<input type="checkbox" name="consignA" id ="consignA"  value="Ʊ��" 
									/>
									|&nbsp; ����
								<input type="checkbox" name="consignA" id ="consignA"  value="����" 
									/>
									|&nbsp;��Ʒ
								<input type="checkbox" name="consignA"  id ="consignA" value="��Ʒ" 
									/>
									|&nbsp; �����
								<input type="checkbox" name="consignA" id ="consignA"  value="�����" 
								 />
							</div>
						</td>
					</tr>
					<tr>
						<td width="">
						���ʽ:
						</td>
						<td>
						<div id="mydiv1">
						����
								<input type="checkbox" name="payment" value="����" 
									onClick="chooseOne(this);" checked="checked" />
								|&nbsp; �½�
								<input type="checkbox" name="payment" value="�½�"
									onClick="chooseOne(this);" />
						</div>
						<script>   
							
					     function chooseOne(cb) {   
					         var obj = document.getElementById("mydiv1");   
					         for (i=0; i<obj.children.length; i++){   
					             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
					             //else    obj.children[i].checked = cb.checked;   
					             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
					             else obj.children[i].checked = true;   
					         }   
					     }   
 					</script>
						</td>
					<tr>
				</table>
			</div>
			<br>
			


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="��ӡ���" onclick="checkForm()">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onClick="goBack()" />
				</div>
				<p>
					&nbsp;

				</p>
				
		</form>
	</body>
</html>
