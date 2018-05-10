<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="../comman.jsp" %>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		out.println("请选择要修改的订单！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	int id = Integer.parseInt(strid);
	Order order = OrderAction.getInstance().getOrderById(id);
	if(!"admin".equals(user.getName())) {
		if("y".equals(order.getStatus())) {
			out.println("订单已审核，不可以修改！");
			out.println("<br><a href='javascript:window.history.back();'>返回</a>");
			return;
		}
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>修改报价单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		
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
		function modifyOrder() {
			with (document.getElementById("quotationform")) {
			method="post";
			action="modifyorder_post.jsp";
			submit();
			}
		}
	
	window.onload=function()
    {//页面加载时的函数
    	getSales();
    }
    
    
    function changetype(object){
	if(!(object.value.indexOf("new") ==0)){
	document.getElementById("trpid").style.display = "";
	}else{
	document.getElementById("trpid").style.display = "none";
	}
	}
    
    	function changetype(object){
	if(!(object.value.indexOf("new") ==0)){
	document.getElementById("trpid").style.display = "";
	}else{
	document.getElementById("trpid").style.display = "none";
	}
	}
	
       function getSales(){//当第一个下拉框的选项发生改变时调用该函数
      var companyid = document.getElementById('companyid').value;
      var url = "addorder_sales.jsp?companyid=" + companyid + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
         //指定回调函数为callback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //回调函数
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//解析XML文档
        }else{
          alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //解析返回xml的方法
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
     // alert(xmlDoc+"***----------");
      var xSel = xmlDoc.getElementsByTagName('select');
      //获得XML文档中的所有<select>标记
      var select_root = document.getElementById('salesid');
      //获得网页中的第二个下拉框
      select_root.options.length=0;
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
        var option = new Option(xText,xValue);
        //根据每组value和text标记的值创建一个option对象
        try{
          select_root.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
      }
      var ops =document.getElementById("salesid").options;
		for(var i=0;i<ops.length;i++) {
			if(ops[i].value == <%=order.getSales().getId()%>){
				ops[i].selected = true;	
			}
		}
    }
	</script>
	
	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return CheckForm(this)">&nbsp; 
			<input name="command" type="hidden" value="add" />
			<input name="status" type="hidden" value="<%=order.getStatus() %>" />
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
						<b>&gt;&gt;销售管理&gt;&gt;修改订单</b>
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
							<input name="pid" type="text" value="<%=order.getPid() %>" size="40"  readonly="readonly"
									style="background-color: #FFCC99"/>
						</td>
						<td width="17%">
							报价单类型：
						</td>
						<td width="33%">
							<select name="quotype" id="quotype" style="width: 300px" onchange="changetype(this);">
								<option value="new" <%=order.getQuotype().equals("new")?"selected":"" %>>
									新报价单
								</option>
								<option value="add" <%=order.getQuotype().equals("add")?"selected":"" %>>
									补充重测报价单
								</option>
								<option value="mod" <%=order.getQuotype().equals("mod")?"selected":"" %>>
									修改报告报价单
								</option>
								<option value="add" <%=order.getQuotype().equals("add")?"selected":"" %>>
									增加报告报价单
								</option>
								<option value="flu" <%=order.getQuotype().equals("flu")?"selected":"" %>>
									冲红报价单
								</option>
								<option value="med" <%=order.getQuotype().equals("med")?"selected":"" %>>
									转译报告报价单
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("quotype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=order.getQuotype()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
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
					
					} else{
					%>
					<tr style="display: none;" id ="trpid">
						<td width="350">关联旧报价单：</td>
						<td>
						<input type="text" size="40" id ="oldPid" name ="oldPid">
						<script>   
						        $("#oldPid").autocomplete("../pid_ajax.jsp",{
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
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;</td>
					</tr>
					<%
										}%>
					<tr>
						<td>
							销售人员：
						</td>
						<td>
							<select name="salesid" id="salesid" style="width: 300px">
							</select>
						</td>
						<td>
							客服人员：
						</td>
						<td>
							<select name="servid" id="servid" style="width: 300px">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=value %>" <%=order.getService().getId()==Integer.parseInt(value)?"selected":"" %> ><%=map.get(value) %></option>
								<%
								 }
								%>
							</select>
						</td>

					</tr>
					<tr>
						<td>
							客户：
						</td>
						<td>
							<input name="client" type="text" id="client" size="40"
								onblur="validateclient(this);" value="<%=order.getClient().getName()==null?"":order.getClient().getName() %>" />
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
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
						<td>
							账号：
						</td>
						<td width="33%">
							<select name="bankid" style="width: 300px">
								<%
								Map<String,String> banks = FlowFinal.getInstance().getBank(0,user.getDept(),user.getId());
								for(String value:banks.keySet()) {
								 %>
								<option value="<%=value %>" <%=order.getBank().getId()==Integer.parseInt(value)?"selected":"" %> ><%=banks.get(value) %></option>
								<%
								 }
								  %>
							</select>
						</td>
						
					</tr>
					<tr>
						<td>
							周期：
						</td>
						<td>
							<input name="circle" type="text" id="circle" size="40" value="<%=order.getCircle() %>"/>
						</td>
						
						<td>
							报价日期：
						</td>
						<td width="33%">
							<input name="quotime" type="text" id="quotime" size="40" value="<%=order.getQuotime() %>"/>
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'quotime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
					</tr>
					<tr>
						<td>
							客户要求时间：
						</td>
						<td width="33%">
							<input name="completetime" type="text" id="completetime"
								size="40" value="<%=order.getCompletetime()==null?"":order.getCompletetime()%>"/>
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'completetime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							分公司：
						</td>
						<td>
							<select name="companyid" id="companyid" style="width: 300px"
								onChange="Change_Select();" >
								<option value="1">
									中山
								</option>
								<option value="2">
									广州
								</option>
								<option value="3">
									东莞
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("companyid").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value==<%=order.getCompany().getId()%>){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
					</tr>
					<tr>
					<td>
					报告客户：
					</td>
					<td>
					<input type="text" name ="rpClient" id ="rpClient" size="40" value="<%=order.getRpclient()==null ?"":order.getRpclient() %>" > 
					</td>
					<td>
					<%
					
					String check="";
					if(order.getGreenchannel()!=null & !"".equals(order.getGreenchannel())){
					check="checked";
					}
				
					 %>
					<input type="checkbox" name ="greencheckbox" id="greencheckbox" value="green" <%=check %>>绿色通道:</td>
					<td><input type="text" size="40" name ="greenchannel" id="greenchannel"  value="<%=order.getGreenchannel() %>"></td></tr>
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
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="<%=quoitem.getSamplename() %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="itemcount<%=i+1%>" name="itemcount" size="13" onBlur="getTotal('<%=i+1 %>');" value="<%=quoitem.getCount() %>">
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
								<input type="text" id="remark<%=i+1%>" name="remark" size="23" value="<%=quoitem.getRemark() %>">
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
							<select name="advancetypeid" style="width: 300px">
								<%
								Map<String,String> advancetypes = FlowFinal.getInstance().getAdvancetype();
								for(String value:advancetypes.keySet()) {
								 %>
								<option value="<%=value %>" <%=order.getAdvancetype().getId()==Integer.parseInt(value)?"selected":"" %>><%=advancetypes.get(value) %></option>
								<%
								 }
								  %>
							</select>
						</td>
						<td width="17%">
							开票方式：
						</td>
						<td width="33%">
							<select name="invmethod" id="invmethod" style="width: 300px"
								onChange="changeMethod(this)">
								<option value="总项目">
									总项目
								</option>
								<option value="分项目">
									分项目
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("invmethod").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=order.getInvmethod()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							票据类型：
						</td>
						<td>
							<select name="invtype" id="invtype" style="width: 300px">
								<!-- <option value="全额">
									全额
								</option>
								<option value="借开">
									借开
								</option>
								<option value="发票">
									发票
								</option>
								 -->
								
								<option value="普通发票" selected>普通发票</option>
								<option value="专用发票" selected>专用发票</option>
								<option value="不含机构费用">
									不含机构费用
								</option>
								
								<option value="收据">
									收据
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("invtype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=order.getInvtype()%>".charCodeAt()){
										ops[i].selected = true;	
										changeSelect(document.getElementById("invtype"));
									}
								}
						</script>
						</td>
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								onFocus="getinvprice(this);" value="<%=order.getInvcount() %>"/>
						</td>
					</tr>
					<tr>
						<td width="17%">
							开票抬头：
						</td>
						<td width="33%">
							<input name="invhead" id="invhead" type="text" size="40"
								onFocus="getinvhead(this);" value="<%=order.getInvhead() %>"/>
						</td>
						<td width="17%">
							开票内容：
						</td>
						<td width="33%">
							<input name="invcontent" id="invcontent" type="text" size="40"
								onFocus="getinvcontent(this);" value="<%=order.getInvcontent() %>"/>
						</td>
					</tr>

				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊接待费预算
						</td>
						
						<td width="33%">
						<%
						if(user.getIsShowFspefund() !=null&&user.getIsShowFspefund().equals("y")){
						%>
							<input name="prespefund" id="prespefund" type="text" size="40" value="<%=order.getPrespefund()%>"/>
						<%}else{%>
							<input name="prespefund" id="prespefund" type="hidden" size="40" value="<%=order.getPrespefund()%>" />
						<%} %>
						</td>
						
						
						<td width="17%">
							备注：
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" value="<%=order.getTag() %>"/>
						</td>

					</tr>
					<tr>
						<td width="17%">
							成品需求：
						</td>
						<td width="33%">
							<input name="product" id="product" type="text" size="40" value="<%=order.getProduct() %>"/>
						</td>
						<td width="17%">
							成品样品资料：
						</td>
						<td width="33%">
							<input name="productsample" id="productsample" type="text"
								size="40" value="<%=order.getProductsample() %>"/>
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊说明：						</td>
						<td width="83%">
							<input name="detail" id="detail" type="text" size="77" value="<%=order.getDetail() %>"/>
					  </td>

					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="修改订单" onClick="modifyOrder()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
