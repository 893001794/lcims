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
		<title>�޸ı��۵�</title>
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
			alert(ojb+"�ı�����Ϊ�գ���");
			return false;
			}
			if(ojb == "���ӱ����ܽ��"){
			var rid =document.getElementById("rid").value
			if(rid == ""){
				alert("������ı�����Ϊ�գ���");
				return false;
			}
			}
			if(pid ==""){
			alert("�����뱨�۵��ţ���");
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
							<b>�������&gt;&gt;�������۵�</b>
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
							<font color="red">�����뱨�۵��ţ�</font>
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=����>
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
						<td width="9%">
							<div align="center">
								����
							</div>
						</td>
						<td width="9%">
							<div align="center">
								��׼��
							</div>
						</td>
						<td width="9%">
							<div align="center">
								����
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
						<td width="8%" class="hid">
							<div align="center">
								�ְ�˵��
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
							���ʽ��
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
							��Ʊ��ʽ��
						</td>
						<td width="33%">
							<input name="invmethod" id="invmethod" type="text" size="40" value="<%=order.getInvmethod()==null?"":order.getInvmethod()%>" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							Ʊ�����ͣ�
						</td>
						<td>
							<input name="invtype" id="invtype" type="text" size="40" value="<%=order.getInvtype() ==null?"":order.getInvtype() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							��Ʊ�ܽ�
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								value="<%=order.getInvcount() %>" readonly="readonly"/>
						</td>
					</tr>
				
					<tr>
					<%
					if(pidtype.equals("1")){
					str="�����ز��ܽ��";
					}
					if(pidtype.equals("3")){
					str="����ܽ��";
					}
					if(pidtype.equals("2")){
					str="���ӱ����ܽ��";
					%>
					<td width="17%">
							����ţ�
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
							��Ʊ̧ͷ��
						</td>
						<td width="33%">
							<input name="invhead" id="invhead" type="text" size="40"
								value="<%=order.getInvhead() ==null?"":order.getInvhead()%>" readonly="readonly"/>
						</td>
						<td width="17%">
							��Ʊ���ݣ�
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
							����Ӵ���Ԥ��
						</td>
						<td width="33%">
							<input name="prespefund" id="prespefund" type="text" size="40" value="<%=order.getPrespefund() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							��ע��
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" value="<%=order.getTag()==null?"":order.getTag() %>" readonly="readonly"/>
						</td>

					</tr>
					<tr>
						<td width="17%">
							��Ʒ����
						</td>
						<td width="33%">
							<input name="product" id="product" type="text" size="40" value="<%=order.getProduct()==null?"":order.getProduct() %>" readonly="readonly"/>
						</td>
						<td width="17%">
							��Ʒ��Ʒ���ϣ�
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
							����˵����						</td>
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
					value="���" onclick="addAdjust()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				}
			if(user.getTicketid().matches("11111111") && adjust.getStatus()!=null && adjust.getStatus().equals("n")) {
			%>	
				 <input name="btnAdd" class="button1" type="button" onclick ="audAdjust('<%=pidtype%>')" id="btnAdd" value="���">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				}
				}
			 %>
				
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack();" />
			</div>
			
			
			
		</form>
	</body>
</html>
