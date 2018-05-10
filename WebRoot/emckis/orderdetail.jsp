<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="../comman.jsp"  %>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		response.sendRedirect("myorder.jsp");
		return;
	}
	
	int id = Integer.parseInt(strid);
	Order order = OrderAction.getInstance().getOrderById(id);
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>������ϸ��Ϣ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
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
.hid {
	display: none;
}
</style>
		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/orderscript.js"></script>
	<script type="text/javascript">
	function printorder() {
		window.showModelessDialog("printorder.jsp?id=<%=id%>","","dialogWidth:900px;dialogHeight:700px");
	}
	
	function auditorder() {
		window.self.location="orderconfirm.jsp?id=<%=id%>";
	}
	
	</script>
	
	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return CheckForm(this)">&nbsp;  
			<input type="hidden" name="command" value="add"><input type="hidden" name="totalprice" id="totalprice" value=""><input type="hidden" name="totalstandprice" id="totalstandprice" value=""><input type="hidden" name="id" id="id" value="<%=order.getId() %>">
			
			
			
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
						<img height="14" width="14" src="../images/mark_arrow_03.gif"> 
						&nbsp; 
						<b>&gt;&gt;���۹���&gt;&gt;������ϸ��Ϣ&gt;<font style="color:red"><%=order.getSales().getName()%></font></b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%"> 
							���۵��ţ�
						</td>
						<td width="33%">
							<input type="text" name="pid" value="<%=order.getPid() %>" size="40" readonly="readonly">
						</td>
						<td width="17%"> 
							���۵����ͣ� 
						</td>
						<td width="33%">
						<input type="text" name="quotype" value="�±��۵�" size="40" readonly="readonly">
						</td>
						
					</tr>
					
					<tr style="display: block;" id ="trpid">
						<td>  
							ʹ�÷�ʽ��  
						</td>
						<font size="1"><% 
							String strUser=""; 
							if(order.getOldPid()!=null&&!order.getOldPid().equals("")){ 
								strUser="��Ŀ"; 
							}else{ 
								strUser="�ⳡ"; 
							} 
						 %>
						<td width="33%">
							<font size="1"><input type="text" name="usetype" value="<%=strUser%>" size="40" readonly="readonly">
						</td>
						<td>
							�ֹ�˾�� 
						</td>
						<td>
							<font size="1"><input type="text" name="companyid" id="companyid" size="40" value="<%=order.getCompany().getName() %>" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>
							��Ʒ���ƣ� 
						</td>
						<td>
							<font size="1"><input name="product" id="product" value="<%=order.getProduct() %>" size="40">		
						</td>
						<td>
							�ռ�ʱ�� 
						</td>
						<td>
							<font size="1"><input type="text" name="collectionD" id="collectionD" size="40" value="<%=order.getCollection()%>" readonly="readonly">
						</td>
						
						
					</tr>
					<tr>
						<td>
							����ʱ�� 
						</td>
						<td>
							<font size="1"><input type="text" name="testD" id="testD" size="40" value="<%=order.getTest()%>" readonly="readonly">
						</td>
						<td>
							�յ�ʱ�� 
						</td>
						<td>
							<font size="1"><input type="text" name="receiptD" id="receiptD" size="40" value="<%=order.getReceipt()%>" readonly="readonly">
						</td>
						<td>
							&nbsp; 
						</td>
						<td>
							&nbsp; 
						</td>
					</tr>
					<!-- 
					<tr>
						<td>
							���翪ʼʱ�䣺 
						</td>
						<td>
							<font size="1"><input type="text" name="start" id="start" size="40" value="<%=order.getAmstart()%>" readonly="readonly">
						</td>
						<td>
							�������ʱ�䣺 
						</td>
						<td>
							<font size="1"><input type="text" name="end" id="end" size="40" value="<%=order.getAmend()%>" readonly="readonly">
						</td>
					</tr> 
					<tr>
						<td>
							���翪ʼʱ�䣺 
						</td>
						<td>
							<font size="1"><input type="text" name="start" id="start" size="40" value="<%=order.getPmstart()%>" readonly="readonly">
						</td>
						<td>
							�������ʱ�䣺 
						</td>
						<td>
							<font size="1"><input type="text" name="end" id="end" size="40" value="<%=order.getPmend()%>" readonly="readonly">
						</td>
					</tr>-->
					<font size="1">
					
						<tr>
							<td>
								�������۵��� 
							</td>
							<td>
							<input type="text" size="40" id="oldPid" name="oldPid" value="<%=order.getOldPid() %>" readonly="readonly">
							</td>
							<td>
								��ˮ�ţ� 
							</td>
							<td>
								<input name="UI" type="text" id="UI" size="40" value="<%=order.getUI() %>"/>
							</td>
						</tr>
					<font size="1">
					
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
					<font size="1"><% 
					List<QuoItem> quoitems = order.getQuoitems(); 
					for(int i=0;i<10;i++) { 
					if(quoitems.size() > i) { 
						QuoItem quoitem = quoitems.get(i); 
					 %>
					<tr>
						<td>
							<div align="center">
							<input name="quoitemid" type="hidden" value="<%=quoitem.getId() %>" />
								<%=i+1 %>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="itemid<%=i+1%>" name="itemid" size="8.7" value="<%=quoitem.getItem().getItemNumber() %>" onblur="clearAll('<%=i+1 %>');">
								<script type="text/javascript">
									showitem('<%=i+1%>');
								</script>
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemname<%=i+1%>" name="itemname" size="25" readonly="readonly"
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getName() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="<%=quoitem.getSamplename() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i%>" name="standprice" size="13" readonly="readonly" value="<%=quoitem.getItem().getStandprice()%>"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="price<%=i%>" name="price" size="13"  value="<%=quoitem.getPrice()%>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i%>" name="itemcount" size="13" onBlur="getTotal('<%=i %>');" value="<%=quoitem.getCount()%>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i%>" name="itemtotal" size="13"  onchange="sumTotalprice();" value="<%=new DecimalFormat("##").format(quoitem.getCount()*(quoitem.getPrice()>0?quoitem.getPrice():quoitem.getItem().getStandprice()))%>">
							</div>
						</td>
						
						<td>
							<div align="center">
								<input type="text" id="remark<%=i+1%>" name="remark" size="23" value="<%=quoitem.getRemark() %>">
							</div>
						</td>
						
					</tr>
					<%} else { %>
						<tr>
						<td>
							<div align="center">
							<input name="quoitemid" type="hidden" value="" />
								<%=i+1 %>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="itemid<%=i+1%>" name="itemid" size="8.7" value="">
								<script type="text/javascript">
									showitem('<%=i+1%>');
								</script>
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemname<%=i+1%>" name="itemname" size="25" readonly="readonly"
									style="background-color: #FFCC99" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="price<%=i%>" name="price" size="13">
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
					<%}} %>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							���ʽ�� 
						</td>
						<td width="33%">
							<input type="text" name="advancetypeid" id="advancetypeid" size="40" value="<%=order.getAdvancetype().getName() %>" readonly="readonly">
						</td>
						<td>
							Ʊ�����ͣ� 
						</td>
						<td>
							<input type="text" name="invtype" id="invtype" size="40" value="<%=order.getInvtype() %>" readonly="readonly">
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
							<td width="17%">
							��Ʊ̧ͷ�� 
						</td>
						<td width="33%">
							<input type="text" name="invhead" id="invhead" size="40" value="<%=order.getInvhead() %>" readonly="readonly">
						</td>
						<td width="17%">
							��Ʊ�ܽ� 
						</td>
						<td width="33%">
							<input type="text" name="invcount" id="invcount" size="40" value="<%=order.getTotalprice()%>" readonly="readonly">
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							��ע�� 
						</td>
						<td width="83%">
							<input type="text" name="tag" size="40" value="<%=order.getTag() %>" readonly="readonly">
					  </td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							����˵���� 
						</td>
						<td width="83%">
							<input type="text" name="detail" id="detail" size="77" value="<%=order.getDetail() %>" readonly="readonly">
					  </td>
					</tr>
				</table>
			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
			<% 
			if("n".equals(order.getStatus()) && (user.getId()==103||user.getId()==188||user.getId()==138)){ 
			 %>
				<input type="button" name="btnAdd" class="button1" id="audit" value="���ȷ��" onclick="auditorder()"> 
				&nbsp;&nbsp;&nbsp;&nbsp; 
			<% 
			} 
			 %>
				<input type="button" name="btnAdd" class="button1" id="printor" value="��ӡ����" onclick="printorder()"> 
				&nbsp;&nbsp;&nbsp;&nbsp; 
				<input type="button" name="btnBack" class="button1" id="back" value="����" onclick="history.back();">
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
