<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>

<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.kis.AdjustpidAction"%>
<%@page import="com.lccert.crm.kis.Adjustpid"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String str="";
	String pid =request.getParameter("pid");
	String status =request.getParameter("status");
	String pidtype =request.getParameter("type");
	String command=request.getParameter("command");	
	Order order =null;
	Float adjustInvcount=0.0f;
	Adjustpid adjust =null;
	 String rid =null;
	if(pid !=null && command !=null && command.equals("search")){
	 order = OrderAction.getInstance().getOrderById(OrderAction.getInstance().getOrderByPid(pid));
	  adjust=AdjustpidAction.getInstance().getAdjustById(pid);
	   rid =adjust.getRid();
	  if(adjust.getFadjustinvcount() !=null){
	  adjustInvcount=adjust.getFadjustinvcount();
	  }
	 
	}
	if(order == null){
	order =new Order();
	}
	if(adjust ==null){
		 adjust = new Adjustpid();
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>修改报价单</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
        <script src="../../javascript/jquery.js"></script>
        <script src="../../javascript/jquery.autocomplete.min.js"></script>
        <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<script src="../javascript/jquery.js"></script>
	<script src="../../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../../javascript/suggest.js"></script>
		<script src="../../javascript/orderscript.js"></script>
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
		function audAdjust(){
			var myfrom =document.getElementById("quotationform");
			myfrom.method="post";
			myfrom.action="adjustpid_post.jsp?status=aud";
			myfrom.submit();
		}
		function addAdjust(ojb){
			var adjust =document.getElementById("adjustinvcount").value;
			var pid =document.getElementById("modifypid").value;
			var myfrom =document.getElementById("quotationform");
			if(adjust == 0.0 ){
			alert(ojb+"文本框不能为空！！");
			return false;
			}
			if(ojb == "增加报告总金额"){
			var rid =document.getElementById("rid").value
			if(rid == ""){
				alert("报告号文本框不能为空！！");
				return false;
			}
			}
			if(pid ==""){
			alert("请输入报价单号！！");
			return false;
			}else{
			myfrom.method="post";
			myfrom.action="adjustpid_post.jsp?status=add";
			myfrom.submit();
			}
		}
			
			
		function goBack() {
			window.self.location = "../../kis/myorder.jsp";
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
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>财务管理&gt;&gt;调整报价单</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action="adjustpid.jsp?type=<%=pidtype %>"
							autocomplete="off">
							<input type="hidden" name="command" value="search" />
							<font color="red">请输入报价单号：</font>
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=搜索>
							 <script>   
						        $("#pid").autocomplete("../../pid_ajax.jsp",{
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
							
						</form>
					</td>
				</tr>

			</table>

			</div>
			<form method="post" name="quotationform" id="quotationform" >
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
					if(quoitems ==null){
					quoitems =new ArrayList();
					}
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
								<input type="text" id="itemid<%=i+1%>" name="itemid" size="8.7" value="<%=quoitem.getItem().getItemNumber() %>" onblur="clearAll('<%=i+1 %>');" readonly="readonly">
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
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="<%=quoitem.getSamplename() %>">
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
									style="background-color: #FFCC99" value="<%=quoitem.getItem().getStandprice() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getSaleprice() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemtotal<%=i+1%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onchange="sumTotalprice();" value="<%=quoitem.getCount()*quoitem.getSaleprice() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="remark<%=i+1%>" name="remark" size="23" readonly="readonly" value="<%=quoitem.getRemark() %>">
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
							<input name="quoitemid" type="hidden" value="" readonly="readonly"/>
								<%=i+1 %>
							</div>
						</td>
						<td>
							<div align="center" >
								<input type="text" id="itemid<%=i+1%>" name="itemid" size="8.7" value="" readonly="readonly">
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
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="" readonly="readonly">
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
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i+1%>" name="saleprice" size="13" onBlur="getTotal('<%=i+1 %>');" value="" readonly="readonly">
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
					<%}
					} 
					
					%>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
						<input type="hidden" name="type" id ="type" size="25" value="<%=pidtype %>" />
						<input type="hidden" name="modifypid" id ="modifypid" size="25" value="<%=pid%>" />
							付款方式：
						</td>
						<td width="33%">
						<%
						if(order.getAdvancetype() ==null){
						%>
						<input name="advancetypeid" id="advancetypeid" type="text" size="40" value="" readonly="readonly"/>
						<%
						}else{
						%>
						<input name="advancetypeid" id="advancetypeid" type="text" size="40" value="<%=order.getAdvancetype().getName()==null?"":order.getAdvancetype().getName() %>" readonly="readonly"/>
						<%
						}
						 %>
							
						</td>
						<td width="17%">
							开票方式：
						</td>
						<td width="33%">
							<input name="invmethod" id="invmethod" type="text" size="40" value="<%=order.getInvmethod()==null?"":order.getInvmethod()%>" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							票据类型：
						</td>
						<td>
							<input name="invtype" id="invtype" type="text" size="40" value="<%=order.getInvtype() ==null?"":order.getInvtype() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								value="<%=order.getInvcount() %>" readonly="readonly"/>
						</td>
					</tr>
				
					<tr>
					<%
					if(pidtype.equals("1")){
					str="补充重测总金额";
					}
					if(pidtype.equals("3")){
					str="冲红总金额";
					}
					if(pidtype.equals("2")){
					str="增加报告总金额";
					%>
					<td width="17%">
							报告号：
						</td>
						<td width="33%">
						<%if(rid !=null){
						%>
							<input id="rid" type="text" name="rid" size="40" value="<%=rid %>" readonly="readonly"/>
						<%
						}else{
						%>
							
						
							<input id="rid" type="text" name="rid" size="40" />
							  <script>   
						        $("#rid").autocomplete("../../vrid_ajax.jsp",{
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
							<%
						}
						 %>
						</td>
					<%
					}else{
					%>
					<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;&nbsp;
						</td>
					<%
					}
					
					 %>
						
						<td width="17%">
							<%=str %>:
						</td>
						<td width="33%">
						<%
						if(status !=null && status.equals("check") || adjustInvcount !=0.0f){
						
						%>
							<input name="adjustinvcount" id="adjustinvcount" type="text" size="40"
								onFocus="getinvcontent(this);" value="<%=adjustInvcount%>" readonly="readonly"/>
						<% 
						}else{
						%>
						
							<input name="adjustinvcount" id="adjustinvcount" type="text" size="40"
								onFocus="getinvcontent(this);" value="<%=adjustInvcount%>"/>
						<% 
						}
						 %>
						
						</td>
					</tr>
					<tr>
						<td width="17%">
							开票抬头：
						</td>
						<td width="33%">
							<input name="invhead" id="invhead" type="text" size="40"
								value="<%=order.getInvhead() ==null?"":order.getInvhead()%>" readonly="readonly"/>
						</td>
						<td width="17%">
							开票内容：
						</td>
						<td width="33%">
							<input name="invcontent" id="invcontent" type="text" size="40"
								value="<%=order.getInvcontent()==null?"":order.getInvcontent() %>" readonly="readonly"/>
						</td>
					</tr>

				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊接待费预算
						</td>
						<td width="33%">
							<input name="prespefund" id="prespefund" type="text" size="40" value="<%=order.getPrespefund() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							备注：
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" value="<%=order.getTag()==null?"":order.getTag() %>" readonly="readonly"/>
						</td>

					</tr>
					<tr>
						<td width="17%">
							成品需求：
						</td>
						<td width="33%">
							<input name="product" id="product" type="text" size="40" value="<%=order.getProduct()==null?"":order.getProduct() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							成品样品资料：
						</td>
						<td width="33%">
							<input name="productsample" id="productsample" type="text"
								size="40" value="<%=order.getProductsample() ==null?"":order.getProductsample()%>" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊说明：						</td>
						<td width="83%">
							<input name="detail" id="detail" type="text" size="77" value="<%=order.getDetail()==null?"": order.getDetail()%>" readonly="readonly"/>
					  </td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
			<%
				if(status==null){
				if(adjustInvcount ==0.0f){				%>
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="添加" onclick="addAdjust()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				}
			if(user.getTicketid().matches("11111111") && adjust.getStatus()!=null && adjust.getStatus().equals("n")) {
			%>	
				 <input name="btnAdd" class="button1" type="button" onclick ="audAdjust('<%=pidtype%>')" id="btnAdd" value="审核">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				}
				}
			 %>
				
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack();" />
			</div>
			
			
			
		</form>
	</body>
</html>
