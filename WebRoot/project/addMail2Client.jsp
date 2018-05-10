<%@page import="com.lccert.crm.chemistry.util.DrawName"%>
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
<%@ include file="../comman.jsp"%>
<%
	request.setCharacterEncoding("GBK");
	String ridStr=request.getParameter("ridStr");
	String pid=request.getParameter("vpid");
	ridStr=new String (ridStr.getBytes("ISO-8859-1"), "GBK");
	Quotation qt = null;
	String activeUser=user.getName();
	qt = QuotationAction.getInstance().getQuotationByPid(pid);
	if(qt == null) {
		qt = new Quotation();
	}
	ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
	ContactForm contact =new ContactForm();
	if(client != null) {
		List<ContactForm> contacts = ClientAction.getInstance().getContacts(client.getClientid());
		contact = contacts.get(0);
	}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>快递</title>
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
/*工作区的背景色*/
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
	
		function checkForm(client,ridStr,activeUser) {
			var mail=document.getElementById("email").value;
			var surname=document.getElementById("surname").value;
			if(mail == ""){
				alert("收件客户邮箱不能为空！！！");
				return false;
			}
			if(surname == ""){
				alert("联系人！！！");
				return false;
			}
			var myform=document.getElementById("form1")
			myform.action ="../pdfEmail?mail="+mail+"&surname="+surname+"&client="+client+"&ridStr="+ridStr+"&activeUser="+activeUser
			//window.close();
			myform.submit();
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
							<b>客服管理&gt;&gt;发报告给客户</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>
		<form name="form1" id="form1" action="buildproject_post.jsp" method="post">
		<span><font style="color: red;">如果有多个客户邮箱地址请用";"隔开</font></span>
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
				<!-- 
					<tr>
						<td width="15%">
						发送报告：
						</td>
						<td colspan="3">
							<textarea name ="rid" id ="rid" rows="1" cols="2" style="width: 100%" readonly="readonly"><%=ridStr%></textarea>
						</td>
					</tr>
					-->
					<tr>
						<td width="15%">
						收件客户邮箱：
						</td>
						<td colspan="3">
							<textarea name ="email" id ="email" rows="1" cols="2" style="width: 100%"><%=client.getContact().getEmail()%></textarea>
						</td>
					</tr>
					<tr>
						<td>
							联系人：
						</td>
						<td colspan="3">
						<%
						String sex="";
						String surname="";
						if(client != null) {
	     				String contactName=client.getContact().getContact();
						 if(client.getContact().getSex().equals("女")){
						    	 sex="小姐";
						     }else{
						    	 sex="先生";
						     }
						     if(contactName!=null&&contactName.length()>1){
						    	 surname=new DrawName().getSurname(contactName);
						     }
						  }
						 %>
							<textarea name ="surname" id ="surname" rows="1" cols="2" style="width: 100%"><%=surname%><%=sex%></textarea>
						</td>
					</tr>
					<!-- 
					<tr>
						<td width="15%">
						标题：
						</td>
						<td colspan="3">
							<textarea name="title" id ="title" rows="2" cols="2" style="width: 100%"><%=client.getShortname()%><%=ridStr%>本邮件主题（如电子档报告）
							</textarea>
						</td>
						
					</tr>

					<tr>
						<td width="15%">
						邮件内容：
						</td>
						<td colspan="3">
							<textarea rows="3" name ="content" id ="content"  cols="2" style="width: 100%">
							<%=client.getContact().getContact()%>您好，<br>请查阅附件的电子档报告。<br> 如果您有任何疑问，欢迎随时与我们联系。 谢谢！
							</textarea>
						</td>
						
					</tr>
					 -->
				</table>
			</div>
			<br>
			


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="发送" onclick="checkForm('<%=client.getName()%>','<%=ridStr%>','<%=activeUser%>')">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
				<p>
					&nbsp;

				</p>
				
		</form>
	</body>
</html>
