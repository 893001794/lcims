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
	
		function checkForm() {
		var str=document.getElementsByName('consignA');  //选择所有name="aihao"的对象，返回数组
		var objarray=str.length;
		var chestr="";
		for(var i=0;i<objarray;i++ ){
		if(str[i].checked == true){
			chestr +=str[i].value+",";
		}
		}
			if(chestr == "") {
				alert("请选择托运物品名称!");
				return false;
			}
			if(document.form1.payment.value == "") {
				alert("请选择付款方式!");
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
							<b>客服管理&gt;&gt;化学项目排单</b>
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
							报价单编号：
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=p.getPid()==null?"":p.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="18%">
							报价单类型：
						</td>
						<td width="">
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
						<td width="15%">
							总金额：
						</td>
						<td>
						
							<input name="totalprice" size="40" type="text" value="<%=new DecimalFormat("#.00").format(qt.getTotalprice()) %>"
								 />
						</td>
						<td width="12%">
							项目类型：
						</td>
						<td width="">
							<input name="ptype" size="40" type="text"
								value="<%=p.getPtype() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td width="15%">
							收件公司：
						</td>
						<td>
							<input type="text"  name ="username" value="<%=user.getName() %>">
							<input name="consigneeC" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient()%>"
								 />
						</td>
						<td width="7%">
							收件人：
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
						收件详细地址：
						</td>
						<td colspan="3"><input name ="contactAdd" size="90" value="<%=client.getAddr()==null?"":client.getAddr() %>"></td>
					</tr>
					<tr>
				<td width="15%">
						收件TEL：
						</td>
						<td width="20%">
						<input name ="contactTEL" size="40" value="<%=client.getContact().getTel() %>|<%=client.getContact().getMobile()%>">
						&nbsp;
						</td>
					</tr>
					<tr>
						<td width="">
						托运物品名称：
						</td>	
						<td colspan="3">
						<div id="mydiv">
								报告
								<input type="checkbox" name="consignA" id ="consignA" value="报告" 
									 />
								|&nbsp; 发票
								<input type="checkbox" name="consignA" id ="consignA"  value="发票"
									 />
								|&nbsp; 收据
								<input type="checkbox" name="consignA" id ="consignA"  value="收据" 
									 />
									|&nbsp; 票据
								<input type="checkbox" name="consignA" id ="consignA"  value="票据" 
									/>
									|&nbsp; 资料
								<input type="checkbox" name="consignA" id ="consignA"  value="资料" 
									/>
									|&nbsp;样品
								<input type="checkbox" name="consignA"  id ="consignA" value="样品" 
									/>
									|&nbsp; 申请表
								<input type="checkbox" name="consignA" id ="consignA"  value="申请表" 
								 />
							</div>
						</td>
					</tr>
					<tr>
						<td width="">
						付款方式:
						</td>
						<td>
						<div id="mydiv1">
						到付
								<input type="checkbox" name="payment" value="到付" 
									onClick="chooseOne(this);" checked="checked" />
								|&nbsp; 月结
								<input type="checkbox" name="payment" value="月结"
									onClick="chooseOne(this);" />
						</div>
						<script>   
							
					     function chooseOne(cb) {   
					         var obj = document.getElementById("mydiv1");   
					         for (i=0; i<obj.children.length; i++){   
					             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
					             //else    obj.children[i].checked = cb.checked;   
					             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
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
						value="打印快递" onclick="checkForm()">
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
