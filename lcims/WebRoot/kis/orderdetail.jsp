<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="../comman.jsp"  %>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="java.util.List"%>
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
	//获取EMC报价号
	String emcPid=order.getPid();
	String pidStr=emcPid.substring(0,4);
	if(pidStr.equals("LCQE")) {
		response.sendRedirect("../emckis/orderdetail.jsp?id="+strid);
		return;
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单详细信息</title>
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
/*工作区的背景色*/
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
			<input name="command" type="hidden" value="add" />
			<input name="totalprice" id="totalprice" type="hidden" value="" />
			<input name="totalstandprice" id="totalstandprice" type="hidden" value="" />
			<input name="id" id="id" type="hidden" value="<%=order.getId() %>" />
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
						<img src="../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>&gt;&gt;报价管理&gt;&gt;报价详细信息</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单号：
						</td>
						<td width="33%">
							<input name="pid" type="text" value="<%=order.getPid() %>" size="40" readonly="readonly"/>
						</td>
						<td width="17%">
							报价单类型：
						</td>
						<td width="33%">
						<%
						String str = "";
						if("new".equals(order.getQuotype()))
							str = "新报价单";
						else if("add".equals(order.getQuotype()))
							str = "补充重测报价单";
						else if("flu".equals(order.getQuotype()))
							str = "冲红报价单";
						else if("med".equals(order.getQuotype()))
							str = "转译报告报价单";
						else 
							str = "修改报告报价单";
						 %>
						<input name="quotype" type="text" value="<%=str %>" size="40" readonly="readonly"/>
						</td>
						
					</tr>
					<%
					if(order.getOldPid()!=null && !"".equals(order.getOldPid())){
					%>
					<tr style="display: block;" id ="trpid">
						<td width="350">关联旧报价单：</td>
						<td>
						<input type="text" size="40" id ="oldPid" name ="oldPid" value="<%=order.getOldPid() %>">
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;</td>
					</tr>
					<%
					
					} %>
					<tr>
						<td>
							销售人员：
						</td>
						<td>
							<input name="salesid" type="text" value="<%=order.getSales().getName() %>" size="40" readonly="readonly"/>
						</td>
						<td>
							客服人员：
						</td>
						<td>
							<input name="servid" type="text" value="<%=order.getService().getName() %>" size="40" readonly="readonly"/>
						</td>

					</tr>
					<tr>
						<td>
							客户：
						</td>
						<td>
							<input name="client" type="text" id="client" size="40"
								 value="<%=order.getClient().getName()==null?"":order.getClient().getName() %>" readonly="readonly"/>
						</td>
						<td>
							账号：
						</td>
						<td width="33%">
							<input name="bankid" type="text" value="<%=order.getBank().getName() %>" size="40" readonly="readonly"/>
						</td>
						
					</tr>
					<tr>
						<td>
							周期：
						</td>
						<td>
							<input name="circle" type="text" id="circle" size="40" value="<%=order.getCircle() %>" readonly="readonly"/>
						</td>
						
						<td>
							报价日期：
						</td>
						<td width="33%">
							<input name="quotime" type="text" id="quotime" size="40" value="<%=order.getQuotime() %>" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>
							客户要求时间：
						</td>
						<td width="33%">
							<input name="completetime" type="text" id="completetime"
								size="40" value="<%=order.getCompletetime()==null?"":order.getCompletetime() %>" readonly="readonly"/>
						</td>
						<td>
							分公司：
						</td>
						<td>
							<input name="companyid" type="text" id="companyid" size="40" value="<%=order.getCompany().getName() %>" readonly="readonly"/>
						</td>
					</tr>
					<tr>
					<td>
					报告客户：
					</td>
					<td>
					<input type="text" name ="rpClient" id ="rpClient" size="40" value="<%=order.getRpclient()==null ?"":order.getRpclient() %>" readonly="readonly"> 
					</td>
					<td><%
					
					String check="";
					if(order.getGreenchannel()!=null & !"".equals(order.getGreenchannel())){
					check="checked";
					}
					 %>
					<input type="checkbox" name ="greencheckbox" id="greencheckbox" value="green" <%=check %>>绿色通道:</td>
					<td><input type="text" size="40" name ="greenchannel" id="greenchannel" readonly="readonly" value="<%=order.getGreenchannel() %>"></td></tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" border="1">
					<tr>
						<td width="3%">
							<div align="center">
								行号
							</div>
						</td>
						<td width="6%">
							<div align="center">
								代码
							</div>
						</td>
						<td width="16%">
							<div align="center">
								测试项目
							</div>
						</td>
						<td width="16%">
							<div align="center">
								样品名称
							</div>
						</td>
						<td width="9%">
							<div align="center">
								数量
							</div>
						</td>
						<td width="9%">
							<div align="center">
								标准价
							</div>
						</td>
						<td width="9%">
							<div align="center">
								单价
							</div>
						</td>
						<td width="9%">
							<div align="center">
								小计
							</div>
						</td>
						<td width="15%">
							<div align="center">
								备注
							</div>
						</td>
						<td width="8%" class="hid">
							<div align="center">
								分包说明
							</div>
						</td>
					</tr>
					<%
					List<QuoItem> quoitems = order.getQuoitems();
					for(int i=0;i<10;i++) {
					if(quoitems.size() > i) {
						QuoItem quoitem = quoitems.get(i);
					 %>
					<tr>
						<td>
							<div align="center">
							<input name="quoitemid" type="hidden" value="<%=quoitem.getId() %>" readonly="readonly"/>
								<%=i+1 %>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="itemid<%=i+1%>" name="itemid" size="8.7" value="<%=quoitem.getItem().getItemNumber() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemname<%=i+1%>" name="itemname" size="25" readonly="readonly"
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getName()%>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="<%=quoitem.getSamplename() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i+1%>" name="itemcount" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getCount()%>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i+1%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getStandprice() %>" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getSaleprice() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onchange="sumTotalprice();" value="<%=quoitem.getCount()*quoitem.getSaleprice() %>" >
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i+1%>" name="remark" size="23" value="<%=quoitem.getRemark() %>" readonly="readonly">
							</div>
						</td>
						<td class="hid">
							<div align="center">
								<input type="text" id="outprice<%=i+1%>" name="outprice" size="11" readonly="readonly"
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getOutprice() %>">
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
								<input type="text" id="itemcount<%=i+1%>" name="itemcount" size="13" onBlur="getTotal('<%=i+1 %>');" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i+1%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onchange="sumTotalprice();" value="">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i+1%>" name="remark" size="23" value="">
							</div>
						</td>
						<td class="hid">
							<div align="center">
								<input type="text" id="outprice<%=i+1%>" name="outprice" size="11" readonly="readonly"
									style="background-color: #FFCC99" value="">
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
							付款方式：
						</td>
						<td width="33%">
							<input name="advancetypeid" id="advancetypeid" type="text" size="40" value="<%=order.getAdvancetype().getName() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							开票方式：
						</td>
						<td width="33%">
							<input name="invmethod" id="invmethod" type="text" size="40" value="<%=order.getInvmethod() %>" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							票据类型：
						</td>
						<td>
							<input name="invtype" id="invtype" type="text" size="40" value="<%=order.getInvtype() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								value="<%=order.getTotalprice()%>" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td width="17%">
							开票抬头：
						</td>
						<td width="33%">
							<input name="invhead" id="invhead" type="text" size="40"
								value="<%=order.getInvhead() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							开票内容：
						</td>
						<td width="33%">
							<input name="invcontent" id="invcontent" type="text" size="40"
								value="<%=order.getInvcontent() %>" readonly="readonly"/>
						</td>
					</tr>

				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊接待费预算
						</td>
						<td width="17%">
							<%
							if(user.getIsShowFspefund() !=null && user.getIsShowFspefund().equals("y")){
							%>
								<input name="prespefund" id="prespefund" type="text" size="40" value="<%=order.getPrespefund()%>" readonly="readonly"/>
							<%}else{%>
								<input name="prespefund" id="prespefund" type="hidden" size="40" value="<%=order.getPrespefund()%>" />
							<%} %>
						</td>
						</td>
						<td width="17%">
							备注：
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" value="<%=order.getTag() %>" readonly="readonly"/>
						</td>

					</tr>
					<tr>
						<td width="17%">
							成品需求：
						</td>
						<td width="33%">
							<input name="product" id="product" type="text" size="40" value="<%=order.getProduct() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							成品样品资料：
						</td>
						<td width="33%">
							<input name="productsample" id="productsample" type="text"
								size="40" value="<%=order.getProductsample() %>" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊说明：						</td>
						<td width="83%">
							<input name="detail" id="detail" type="text" size="77" value="<%=order.getDetail() %>" readonly="readonly"/>
					  </td>

					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
			<%
			if("n".equals(order.getStatus()) && user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")||(user.getName().equals("余海珊")||user.getId()==110)) {
			 %>
				<input name="btnAdd" class="button1" type="button" id="audit"
					value="审核确认" onClick="auditorder()">
				&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			}
			 %>
				<input name="btnAdd" class="button1" type="button" id="printor"
					value="打印订单" onClick="printorder()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="back"
					value="返回" onClick="history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
