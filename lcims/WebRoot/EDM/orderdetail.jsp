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
	//System.out.println(id+"---id");
	Order order = OrderAction.getInstance().getOrderById(id);
	String projectleader=order.getProjectleader();
	String projectId ="";
	String userId ="";
	//System.out.println(projectleader+"----");
	if(projectleader !=null&&!"".equals(projectleader)){
		projectId=projectleader.substring(0,projectleader.indexOf("("));
		userId=projectleader.substring(projectleader.indexOf("(")+1,projectleader.indexOf(")"));
	}
	
	//System.out.println(projectId+"----采样员");
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
		window.open("putongyouzhangn.jsp?id=<%=id%>&status=y","","dialogWidth:900px;dialogHeight:700px");
	}
	
	function auditorder(obj) {
		 //如果在审核时才添加采样员的方法---2012-1-10---
		// var id =window.showModalDialog("projectleader.jsp?id=<%=id%>", "newwin", "dialogHeight=500px, dialogWidth=400px,toolbar=no,menubar=no");//弹出子窗口，并且获取中只窗口的值
		//alert("审核成功！！");
		//if(id !=null){
		// window.self.location="orderconfirm.jsp?id=<%=id%>";
		// }
		//如果在审核时才添加采样员的方法---2012-1-10---下面代码是在添加报价单的时候利用ajax添加采样员信息的
		if(obj==""){
			alert("请销售人员先在报价单处选择采样员！！！");
			return false;
		}
		$.ajax({ //调用jquery ajax
			type:"POST",  //跳转方法为POST
			url:"/lcims/emdPrice", //跳转了路径
			data:"empida=<%=projectId%>&userid=<%=userId%>&pid=<%=order.getPid()%>", //传输的值或参数
	        error: function(){alert("error!!");},  //如果路径错误或者参数有错的时候就弹出此窗口
	        success: function(data){  //如果正确或拿到java里面传输过来的值
			    var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
			 	var flag=agent.attr('suc'); //得到名称为xml对象里面的name对象
			 	if(flag.indexOf(true) >-1){
			 	 window.self.location="orderconfirm.jsp?id=<%=id%>";
			  	 }
			 	}
		});
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
					报告客户：
					</td>
					<td>
					<input type="text" name ="rpClient" id ="rpClient" size="40" value="<%=order.getRpclient()==null ?"":order.getRpclient() %>" readonly="readonly"> 
					</td>
					<td>
							分公司：
						</td>
						<td>
							<input name="companyid" type="text" id="companyid" size="40" value="<%=order.getCompany().getName() %>" readonly="readonly"/>
						</td>
					<!--
						<td>
							周期：
						</td>
						<td>
							<input name="circle" type="text" id="circle" size="40" value="<%=order.getCircle() %>" readonly="readonly"/>
						</td>
						  -->
						
					</tr>
					<tr>
						<td>
							客户要求时间：
						</td>
						<td width="33%">
							<input name="completetime" type="text" id="completetime"
								size="40" value="<%=order.getCompletetime() %>" readonly="readonly"/>
						</td>
						<%
						String strPlane ="";
						if(order.getSamplePlane() !=null){
						strPlane=order.getSamplePlane();
						}
						 %>
						<td colspan="2"><input type="checkbox" value="C" <%=strPlane.equals("C")?"checked":"" %>  name ="TSsample" id="TSsample">采样&nbsp;&nbsp;<input type="checkbox" value="S" <%=strPlane.equals("S")?"checked":"" %> name ="TSsample" id="TSsample">送样</td>
					</tr>
					
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
							<div align="center" >
								测试小项目
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
						<%if(user.getPstatus().equals("y")){ %>
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
						<%} %>
						<td width="5%">
							<div align="center">
								方法
							</div>
						</td>
						<td width="5%">
							<div align="center">
								二级
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
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getName() %>" readonly="readonly">
							</div>
						</td>
						<td >
							<div align="center">
								<input type="text" disabled="disabled" id="samplename<%=i+1%>" name="samplename" size="25" value="<%=quoitem.getSamplename()==null?"":quoitem.getSamplename() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i+1%>" name="itemcount" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getCount() %>" readonly="readonly">
							</div>
						</td>
						
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i+1%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getStandprice() %>" >
							</div>
						</td>
						<%if(user.getPstatus().equals("y")){ %>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getSaleprice() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onChange="sumTotalprice();" value="<%=quoitem.getCount()*quoitem.getSaleprice() %>" >
							</div>
						</td>
						<%
						}else{
						%>
							<td style="display: none;">
							<div align="center">
								<input type="text" id="standprice<%=i+1%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getStandprice() %>" >
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getSaleprice() %>" readonly="readonly">
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onChange="sumTotalprice();" value="<%=quoitem.getCount()*quoitem.getSaleprice() %>" >
							</div>
						</td>
						<%
						}
						 %>
						<td>
							<select name="plane" id="plane<%=i+1 %>" style="width: 150px" onChange="child('<%=i%>',this.value);" >
								<option value="<%=quoitem.getPlaneId()%>"><%=OrderAction.getInstance().getQuoItems(quoitem.getPlaneId(),"plane")%></option>
								
							</select>
						</td>
						<td>
							<select name="yle" id="yle<%=i+1 %>" style="width: 150px" >
							<option value="<%=quoitem.getChildId()%>"><%=OrderAction.getInstance().getQuoItems(quoitem.getChildId(),"child")%></option>
							</select>
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
								<%=i+1 %>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="itemid<%=i+1%>" name="itemid" size="8.7" value="" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemname<%=i+1%>" name="itemname" size="25" readonly="readonly"
									style="background-color: #FFCC99" value="" >
							</div>
						</td>
						<td >
							<div align="center"  >
								<input disabled="disabled" type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="" readonly="readonly"> 
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i+1%>" name="itemcount" size="13" onBlur="getTotal('<%=i+1 %>');" value="" readonly="readonly">
							</div>
						</td>
						
						<td>
							<div align="center">
								<input type="text" id="standprice<%=i+1%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99" value="">
							</div>
						</td>
						<%if(user.getPstatus().equals("y")){ %>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onChange="sumTotalprice();" value="">
							</div>
						</td>
						<%}else{
						%>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="standprice<%=i+1%>" name="standprice" size="13" readonly="readonly"
									style="background-color: #FFCC99" value="">
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="" readonly="readonly">
							</div>
						</td>
						<td style="display: none;">
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onChange="sumTotalprice();" value="">
							</div>
						</td>
						<%
						} %>
						<td>
							<select name="plane" id="plane<%=i+1 %>" style="width: 150px" onChange="child('<%=i%>',this.value);" >
							</select>
						</td>
						<td>
							<select name="yle" id="yle<%=i+1 %>" style="width: 150px" >
							</select>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i+1%>" name="remark" size="23" value="" readonly="readonly">
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
						<td width="33%" style="text-align: left;">
							<input name="advancetypeid" id="advancetypeid" type="text" size="40" value="<%=order.getAdvancetype().getName() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							采样员：
						</td>
						<td>
							<input type="hidden"" id="projectleader" name ="projectleader" size="40" value="<%=order.getProjectleader()==null?"":order.getProjectleader()%>">
							<input type="text" id="sampling" name ="sampling" onfocus="auditorder(this.value);" size="40" value="<%=order.getSampling()==null?"":order.getSampling()%>" readonly="readonly">
						</td>
						<!-- 
						<td width="17%" style="display: none;">
							开票方式：
						</td>
						<td width="33%" style="display: none;" style="text-align: left;">
							<input name="invmethod" id="invmethod" type="text" size="40" value="<%=order.getInvmethod() %>" readonly="readonly"/>
						</td>
						 -->
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
						<td>
							采样时间：
						</td>
						<td width="33%">
							<input name="sampltime" type="text" id="sampltime" size="40"  value="<%=order.getSampltime()==null?"":order.getSampltime()%>" readonly="readonly"/>
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'sampltime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<!-- 
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%" style="display: none;">
							<input name="invcount" id="invcount" type="text" size="40"  onFocus="getTotalPrice();" />
						</td>
						 -->
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
							特殊说明：						</td>
						<td width="83%">
							<input name="detail" id="detail" type="text" size="125" value="<%=order.getDetail() %>" readonly="readonly"/>
					  </td>

					</tr>
					<tr>
						<td>样品编号:</td>
						<td><input type="text" size="40" value="<%=order.getSampleNo()%>" name ="sampleNo" id="sampleNo"  readonly="readonly"></td>
					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
			<%
			if("n".equals(order.getStatus()) && user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {
			 %>
				<input name="btnAdd" class="button1" type="button" id="audit"
					value="审核确认" onClick="auditorder('<%=projectId%>')">
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
