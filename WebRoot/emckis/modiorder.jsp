<%@page import="java.text.SimpleDateFormat"%>
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
     //alert(xmlDoc+"***----------");
      var xSel = xmlDoc.getElementsByTagName('select');
     // alert(xSel);
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
        var option = new Option(xText, xValue);
        //根据每组value和text标记的值创建一个option对象
        
        try{
          select_root.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
      }
      var ops = document.getElementById("salesid").options;
		for(var i=0;i<ops.length;i++) {
			if(ops[i].value == <%=order.getSales().getId()%>){
				ops[i].selected = true;	
			}
		}
    }
	</script>
	
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="modifyorder_post.jsp?status=modify">
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
							<select name="quotype" id="quotype" style="width: 300px" >
								<option value="new">
									新报价单
								</option>
							</select>
						</td>
						
					</tr>
					
					<tr>
						<td>
							销售人员：
						</td>
						<td>
							<select name="salesid" id="salesid" style="width: 300px">
							</select>
						</td>
						<td>
							客户：
						</td>
						<td>
							<input name="client" type="text" id="client" size="40"
								onblur="validateclient(this);" value="<%=order.getClient().getName()==null?"":order.getClient().getName()%>" />
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

					</tr>
					<tr style="display: block;" id ="trpid">
						<td> 
							使用方式： 
						</td>
						<%
							String strUser="";
							if(order.getOldPid()!=null&&!order.getOldPid().equals("")){
								strUser="项目";
							}else{
								strUser="租场";
							}
						 %>
						<td width="33%">
							<select name="usetype" style="width: 300px" id="usetype" onchange="hidden(this.value);">
								<option value="">---选择使用方式---</option>
								<option value="marketRent" <%=strUser.equals("租场")?"selected":"" %>>租场</option>
								<option value="report" <%=strUser.equals("项目")?"selected":"" %>>项目</option>
							</select>
						</td>
						<td>
							分公司：
						</td>
						<td>
							
							<select name="companyid" id="companyid" style="width: 300px"  >
								<option value="1">
									中山
								</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>
							产品名称：
						</td>
						<td>
							<input name="product" id="product" value="<%=order.getProduct()%>" size="40" readonly="readonly">		
						</td>
						<td>
							收件日期
						</td>
						<td>
							<input name="collectionD" type="text" id="collectionD" size="40"  value="<%=order.getCollection()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getCollection()):""%>" readonly="readonly"/>
						</td>
						
						
					</tr>
					<tr>
						<td>
							测试日期
						</td>
						<td>
							<input name="testD" type="text" id="testD" size="40"  value="<%=order.getTest()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getTest()):""%>" readonly="readonly" />
						</td>
						<td>
							收单日期
						</td>
						<td>
							<input name="receiptD" type="text" id="receiptD" size="40"  value="<%=order.getReceipt()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getReceipt()):""%>"  readonly="readonly"/>
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
							上午开始时间：
						</td>
						<td>
							<input name="amstart" type="text" id="amstart" size="40"  value="<%=order.getAmstart()%>" readonly="readonly"/>
						</td>
						<td>
							上午结束时间：
						</td>
						<td>
							<input name="amend" type="text" id="amend" size="40"  value="<%=order.getAmend()%>" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>
							下午开始时间：
						</td>
						<td>
							<input name="pmstart" type="text" id="pmstart" size="40"  value="<%=order.getPmstart()%>" readonly="readonly"/>
						</td>
						<td>
							下午结束时间：
						</td>
						<td>
							<input name="pmend" type="text" id="pmend" size="40"  value="<%=order.getPmend()%>" readonly="readonly"/>
						</td>
					</tr>-->
					<%
						if(order.getOldPid()!=null){
						%>
						<tr>
							<td>
								二部报价单：
							</td>
							<td>
								<input type="text" size="40" id ="oldPid" name ="oldPid" value="<%=order.getOldPid()==null?"":order.getOldPid()%>"  readonly="readonly">
							</td>
							<td>
								流水号： 
							</td>
							<td>
								<input name="UI" type="text" id="UI" size="40" value="<%=order.getUI() %>"/>
							</td>
						</tr>
					<%
						}
					 %>
					
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
						<td width="16%">
							<div align="center">
								标准价
							</div>
						</td>
						<td width="16%">
							<div align="center">
								实际价
							</div>
						</td>
						<td width="9%">
							<div align="center">
								测试小时数
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
								<input type="text" id="samplename<%=i+1%>" name="samplename" size="25" value="<%=quoitem.getSamplename() %>" readonly="readonly">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="saleprice<%=i%>" name="saleprice" size="13" readonly="readonly" value="<%=quoitem.getItem().getStandprice()%>"
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
								<input type="text" id="itemtotal<%=i%>" name="itemtotal" size="13" readonly="readonly"
									style="background-color: #FFCC99" onchange="sumTotalprice();" value="<%=quoitem.getCount()*quoitem.getSaleprice()%>">
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
								<input type="text" id="standprice<%=i%>" name="price" size="13" readonly="readonly"
									style="background-color: #FFCC99">
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
							付款方式：
						</td>
						<td width="33%">
						<select name="advancetypeid" style="width: 300px">
								<%
								Map<String,String> advancetypes = FlowFinal.getInstance().getAdvancetype();
								for(String value:advancetypes.keySet()) {
									if(Integer.parseInt(value)>8){
								 %>
								<option value="<%=value %>" <%=order.getAdvancetype().getId()==Integer.parseInt(value)?"selected":"" %>><%=advancetypes.get(value) %></option>
								<%
									}
								 }
								  %>
							</select>
						</td>
						<td>
							票据类型：
						</td>
						<td>
							<select name="invtype" id="invtype" style="width: 300px">
								<%--<option value="全额">
									全额
								</option>
								<option value="不含机构费用">
									不含机构费用
								</option>
								<option value="借开">
									借开
								</option>
								<option value="收据">
									收据
								</option>--%>
									<option value="普通发票">
										普通发票
									</option>
									<option value="专用发票">
										专用发票
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
					</tr>
				</table>
				<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
							<td width="17%">
							开票抬头：
						</td>
						<td width="33%">
							<input name="invhead" id="invhead" type="text" size="40"
								value="<%=order.getInvhead() %>" />
						</td>
						<td width="17%">
							开票总金额：
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40"
								value="<%=order.getTotalprice()%>" />
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							备注：
						</td>
						<td width="83%">
							<input name="tag" type="text" size="40" value="<%=order.getTag() %>" />
					  </td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							特殊说明：
						</td>
						<td width="83%">
							<input name="detail" id="detail" type="text" size="77" value="<%=order.getDetail() %>" />
					  </td>
					</tr>
				</table>
			</div>


			<hr width="97%" align="center" size=0>
				<div align="center">
				<input name="btnAdd" class="button1" type="submit"" id="btnAdd"
					value="修改订单">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
