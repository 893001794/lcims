<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="java.util.Map"%>

<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
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
	
	ChemProject cp = (ChemProject)p.getObj();
	
	qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	
	if(qt == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>项目立项</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>
		<script src="../../javascript/Calendar.js"></script>
		<script language="javascript">
		
		function checkDate(Object) {
		if(document.getElementById("rptime").value==""){
			alert("应出报告时间不能为空");
			return ;
		}else{
		//应出报告的时间
		    var rptime=document.getElementById("rptime").value;
		    //获取到父窗口的
		    var a = window.dialogArguments;
		    //将父窗口的值更变
			a.action="flow_manage.jsp?start=1&rptime="+rptime+"&sid="+Object;
			//命令父窗口跳转
			a.submit();
			//关闭子窗口
			window.close();
			
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
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>更改应出报告日期</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>


		<form name="form1" action="modifyproject_post.jsp" method="post">
			<input type="hidden" name="id" value="<%=p.getId() %>">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
						<td>
							报价单编号：
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=p.getPid()==null?"":p.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2"  />
						</td>
						<td width="17%">
							报价单类型：
						</td>
						<td width="33%">
							<%
						String strquo = "";
						if("new".equals(qt.getQuotype())) 
							strquo = "新报价单";
						else if("add".equals(qt.getQuotype()))
							strquo = "补充重测报价单";
						else if("mod".equals(qt.getQuotype()))
							strquo = "修改报告报价单";
						 %>
							<input name="quotype" size="40" type="text"
								value="<%=strquo %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>

					</tr>
					<tr>
						<td>
							项目编号：
						</td>
						<td>
							<input name="sid" size="40" type="text" value="<%=p.getSid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							项目类型：
						</td>
						<td width="33%">
							<input name="ptype" size="40" type="text"
								value="<%=p.getPtype() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td>
							客户名称：
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td >
							&nbsp;
						</td>
						<td >
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div class="outborder">
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td width="17%">
							报告类型：
						</td>
						<td width="33%">
							<select name="rptype" id="rptype" style="width: 300px" disabled="disabled">
								<option value="中文报告">
									中文报告
								</option>
								<option value="英文报告">
									英文报告
								</option>
								<option value="双语报告">
									双语报告
								</option>
								<option value="不出报告">
									不出报告
								</option>
								<option value="其他">
									其他
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("rptype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.indexOf("<%=cp.getRptype()%>")==0 && "<%=cp.getRptype()%>".indexOf(ops[i].value) == 0){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
						<td width="17%">
							报告应出时间：
						</td>
						<td width="33%">
							<input name="rptime" type="text" id="rptime" size="40"
								value="<%=cp.getRptime()==null?"":cp.getRptime() %>" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',el:'rptime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>

					</tr>

					<tr>
						<td>
							项目等级：
						</td>
						<td>
							<select name="level" id="level" style="width: 300px" disabled="disabled">
								<option value="普通" selected="selected">
									0级-普通
								</option>
								<option value="加急">
									1级-加急
								</option>
								<option value="特急">
									2级-特急
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("level").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=p.getLevel()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
						<td>
							客服人员：
						</td>
						<td>
							<select name="servname" id="servname" style="width: 300px" disabled="disabled">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=map.get(value) %>" <%=cp.getServname().equals(map.get(value))?"selected":"" %> ><%=map.get(value) %></option>
								<%
								 }
								%>
							</select>
							<script type="text/javascript">
								var obj = document.getElementById("servname").options;
								var str2 = "<%=cp.getServname()%>";
								for(var i=0;i<obj.length;i++) {
									var str1 = obj[i].value;
									if(str1.indexOf(str2)==0 && str2.indexOf(str1)==0){
										obj[i].selected = true;
									}
								}
						</script>
						</td>
					</tr>
				</table>


				<table cellpadding="5" cellspacing="5" width="95%">

					<tr>
						<td width="17%">
							客户联系人：
						</td>
						<td width="33%">
							<select name="contact" style="width: 300px" disabled="disabled"> 
								<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client != null) {
								List<ContactForm> contacts = ClientAction.getInstance().getContacts(client.getClientid());
								for(int i=0;i<contacts.size();i++) {
									ContactForm contact = contacts.get(i);
									String str = "";
									if(cp.getContact() != null) {
										if(cp.getContact().equals(contact.getContact())) {
											str = "selected";
										}
									}
						 %>
								<option value="<%=contact.getContact() %>" <%=str %> ><%=contact.getContact() %></option>
								<%
							 	}
							 }
						  %>

							</select>
						</td>
						<td width="17%">
							报告客户名称：
						</td>
						<td width="33%">
							<input name="rpclient" size="40"
								value="<%=cp.getRpclient()==null?"":cp.getRpclient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						

					</tr>
				</table>
				</div>
				<div class="outborder">
					<table cellpadding="5" cellspacing="5" width="95%">

						<tr>
							<td width="17%">
								样品名称：
							</td>
							<td>
								<input name="samplename" type="text" size="80" value="<%=cp.getSamplename() %>" readonly="readonly"/>
							</td>

						</tr>

						<tr>
							<td>
								样品量：
							</td>
							<td>
								<input name="samplecount" type="text" size="80" value="<%=cp.getSamplecount() %>" readonly="readonly"/>
							</td>
						</tr>

						<tr>
							<td>
								测试项目：
							</td>
							<td>
								<input name="testcontent" type="text" size="80"
									value="<%=p.getTestcontent() %>" readonly="readonly"/>
							</td>

						</tr>
					</table>
					<p>
						&nbsp;
					</p>
				</div>


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="保存" onclick="checkDate('<%=sid %>')">
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
