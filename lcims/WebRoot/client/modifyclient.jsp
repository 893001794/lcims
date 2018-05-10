<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="clientcommon.jsp"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.AreaForm"%>
<%@page import="com.lccert.crm.client.ClientArea"%>
<%@ page errorPage="../error.jsp" %>


<%
	request.setCharacterEncoding("GBK");
	
	String clientid = request.getParameter("clientid");
	if(clientid == null || "".equals(clientid)) {
		response.sendRedirect("clientlist.jsp");
		return;
	}
	ClientForm client = ClientAction.getInstance().getClientById(clientid);
	if(client == null) {
		response.sendRedirect("clientlist.jsp");
		return;
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�޸Ŀͻ���Ϣ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script src="javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script src="../javascript/check.js"></script>
		<script language="javascript">
		function modifyclient() {
			with (document.getElementById("projectform")) {
			method="post";
			action="modifyclient_post.jsp";
			submit();
			}
		}
		function goBack() {
		window.self.location="searchclient.jsp";
	}

</script>





		<script language="javascript">
	function CheckForm(TheForm) {
		trimform(TheForm);
		if (TheForm.name.value == "") {
			alert ("�ͻ����Ʋ���Ϊ�գ�");
			TheForm.name.focus();
			return(false);
		}

		if (TheForm.contact.value == "") {
			alert ("��Ҫ��ϵ�˲���Ϊ�գ�");
			TheForm.contact.focus();
			return(false);
		}

		if (TheForm.tel.value == "") {
			alert ("��ϵ�绰����Ϊ�գ�");
			TheForm.tel.focus();
			return(false);
		}
		
		if (TheForm.email.value != "") {
			if (!chkemail(TheForm.email.value)) {
				alert ("���������ʽ����ȷ����������ֻ����дһ����");
				TheForm.email.focus();
				return(false);
			}
		}
		
		if (TheForm.addr.value == "") {
			alert ("��ַ����Ϊ�գ�");
			TheForm.addr.focus();
			return(false);
		}
		
		if (TheForm.sales.value == "") {
			alert ("�������۲���Ϊ�գ�");
			TheForm.sales.focus();
			return(false);
		}
		
	return(true);
	}
</script>

	</head>

	<body class="body1">
		<form method="post" name="projectform" id="projectform"
			action="modifyclient_post.jsp" onSubmit="return CheckForm(this)">
			<input name="contactid" type="hidden" value="<%=client.getContact().getId() %>" />
			<input name="id" type="hidden" value="<%=client.getId() %>" />
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
						<b>&gt;&gt;�ͻ�����&gt;&gt;�޸Ŀͻ���Ϣ</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td width="20%">
						�ͻ����룺
					</td>
					<td width="80%">
						<input name="clientid" type="text" id="clientid" size="60"
							value="<%=client.getClientid() %>" readonly="readonly" style="background-color: #F2F2F2">
					</td>
				</tr>
				<tr>
					<td width="20%">
						�ͻ����ƣ�
					</td>
					<td width="80%">
						<input name="name" type="text" id="name" size="60"
							value="<%=client.getName() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						�ͻ���ƣ�
					</td>
					<td width="80%">
						<input name="shortname" type="text" id="shortname" size="60"
							value="<%=client.getShortname() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						�ͻ�Ӣ������
					</td>
					<td width="90%">
						<input name="ename" type="text" id="ename" size="60"
							value="<%=client.getEname() %>"/>
					</td>
				</tr>
				<tr>
					<td width="20%">
						��ϵ�ˣ�
					</td>
					<td width="80%">
						<input name="contact" type="text" id="contact" size="60"
							value="<%=client.getContact().getContact() %>" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						�Ա�
					</td>
					<td width="80%">
						��
						<input name="sex" type="radio" id="sex1" size="60" value="��"
							checked="checked">
						Ů
						<input name="sex" type="radio" id="sex2" size="60" value="Ů">
						<script type="text/javascript">
							if("Ů".charCodeAt() == "<%=client.getContact().getSex()%>".charCodeAt()){
								document.getElementById("sex2").checked = true;	
							}
						
						</script>
					</td>
				</tr>
				<tr>
					<td width="10%">
						���ţ�
					</td>
					<td width="90%">
						<input name="dept" type="text" id="dept" size="60"
							value="<%=client.getContact().getDept() %>" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						ְλ��
					</td>
					<td width="90%">
						<input name="job" type="text" id="job" size="60"
							value="<%=client.getContact().getJob() %>" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						��ϵ�绰��
					</td>
					<td width="90%">
						<input name="tel" type="text" id="tel" size="60"
							value="<%=client.getContact().getTel() %>" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�ֻ���
					</td>
					<td width="90%">
						<input name="mobile" type="text" id="mobile" size="60"
							value="<%=client.getContact().getMobile() %>" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						������룺
					</td>
					<td width="80%">
						<input name="fax" type="text" id="fax" size="60"
							value="<%=client.getContact().getFax() %>">
					</td>
				</tr>
				<tr>
					<td width="10%">
						QQ/MSN��
					</td>
					<td width="90%">
						<input name="qq" type="text" id="qq" size="60"
							value="<%=client.getContact().getQq() %>" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������䣺
					</td>
					<td width="90%">
						<input name="email" type="text" id="email" size="60"
							value="<%=client.getContact().getEmail() %>" />
					</td>
				</tr>
				<tr>
					<td width="20%">
						��ַ��
					</td>
					<td width="80%">
						<input name="addr" type="text" id="addr" size="60"
							value="<%=client.getAddr() %>">
					</td>
				</tr>
				<tr>
					<td width="10%">
						Ӣ�ĵ�ַ��
					</td>
					<td width="90%">
						<input name="eaddr" type="text" id="eaddr" size="60"
							value="<%=client.getEaddr() %>" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������룺
					</td>
					<td width="90%">
						<input name="zipcode" type="text" id="zipcode" size="60"
							value="<%=client.getZipcode() %>" />
					</td>
				</tr>
				<tr>
					<td width="10%">
						�������ۣ�
					</td>
					<td width="90%">
						<input name="sales" type="text" id="sales" size="60" value="<%=UserAction.getInstance().getNameById(client.getSalesid()) %>"/>
						<script>   
						        $("#sales").autocomplete("../sales_ajax.jsp",{
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
					<td width="20%">
						�ͻ���Ҫ��Ʒ��
					</td>
					<td width="80%">
						<input name="product" type="text" id="product" size="60"
							value="<%=client.getProduct() %>">
					</td>
				</tr>

				<%
				if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")) {
	
			%>
				<tr>
					<td>
						���ý�
					</td>
					<td>
						<input name="creditlevel" type="text" id="creditlevel" size="60"
							value="<%=client.getCreditlevel() %>">

					</td>
				</tr>

				<%
				} else {
			 %>
				<input name="creditlevel" type="hidden" id="creditlevel" size="60"
					value="<%=client.getCreditlevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
				<%
				}
			 %>
				<tr>
					<td>
						�ͻ��ȼ���
					</td>
					<td>
						<select name="clevel" id="clevel" style="width: 300px">
							<option value="normal">
								��ͨ
							</option>
							<option value="vip">
								VIP
							</option>

						</select>
						<script type="text/javascript">
							var ops = document.getElementById("clevel").options;
							for(var i=0;i<ops.length;i++) {
								if(ops[i].value == "<%=client.getClevel()%>"){
										ops[i].selected = true;	
								}
							}
						</script>
					</td>
				</tr>
				
				<tr>
					<td>
						���ʽ��
					</td>
					<td>
					<%if(user.getId()==103){%>
						<select name="pay" id="pay" style="width: 300px">
							<option value="�ָ�" selected="selected">
								�ָ�
							</option>
							<option value="�½�">
								�½�
							</option>
							<option value="���">
								���
							</option>
						</select>
						<script type="text/javascript">
							var ops = document.getElementById("pay").options;
							for(var i=0;i<ops.length;i++) {
								if(ops[i].value.charCodeAt() == "<%=client.getPay()%>".charCodeAt()){
										ops[i].selected = true;	
								}
							}
						</script>
					<%
					}else{%>
					<input name="pay" type="text" id="pay" size="40"
							value="<%=client.getPay()%>" readonly="readonly"   style="background-color: #F2F2F2" >
					<%}
					%>
					
					</td>
				</tr>
				
				<tr>
					<td>
						����
					</td>
					<td>
						<select name="area" id="area" style="width: 300px" disabled="disabled">
							<%
								List<AreaForm> list = ClientArea.getInstance().getArea();
								for(int i=0;i<list.size();i++) {
									AreaForm af = list.get(i);
							 %>
							<option value="<%=af.getCity() %>"
								<%=af.getCity().equals(client.getArea())?"selected":"" %>>
								<%=af.getCity() %>
							</option>

							<%
								}
							 %>
						</select>

					</td>
				</tr>
				<tr>
					<td>
						�ͻ�״̬��
					</td>
					<td>
						<select name="status" id="status" style="width: 300px">
							<option value="��Ч">
								��Ч
							</option>
							<option value="��Ч">
								��Ч
							</option>

						</select>
						<script type="text/javascript">
							var ops = document.getElementById("status").options;
							for(var i=0;i<ops.length;i++) {
								if(ops[i].value.charCodeAt() == "<%=client.getStatus()%>".charCodeAt()){
										ops[i].selected = true;	
								}
							}
						</script>
					</td>
				</tr>
			</table>

			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type=submit id="btnAdd"
					value="�޸Ŀͻ���Ϣ" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
