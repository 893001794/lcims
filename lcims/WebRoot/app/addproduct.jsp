<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String status=request.getParameter("status");
	String proudctId=request.getParameter("proudctId");
	//大类
	int genera=0;
	//小类
	int group =0;
	//产品名称
	String product="";
	//单位
	String unit="";
	//规格
	String standard ="";
	//参考价
	float price =0f;
	//预警量
	String warning="";
	//供应商
	String suppliername="";
	//是否为固定资产
	String assets ="";
	if(proudctId !=null){
		List row =DaoFactory.getInstance().getInventoryDao().getProduct(Integer.parseInt(proudctId));
		List columns =(List)row.get(0);
		genera=Integer.parseInt(columns.get(3).toString());
		//System.out.println("大类:"+genera);
		group=Integer.parseInt(columns.get(4).toString());
		//System.out.println("小类:"+group);
		product=columns.get(0).toString();
		unit=columns.get(5).toString();
		standard=columns.get(6).toString();
		price=Float.parseFloat(columns.get(1).toString());
		warning=columns.get(7).toString();
		assets=columns.get(8).toString();
		suppliername=columns.get(2).toString();
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加报价单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script type="text/javascript" src="../javascript/jquery-1.3.2.min.js" ></script>
		<script type="text/javascript" src="../javascript/mln.colselect.js"></script>
        <link href="../css/mln-main.css" rel="stylesheet" type="text/css" charset="utf-8" />
        <!-- 调用日期样式 -->
        <script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link href="../css/mln.colselect.css" rel="stylesheet" type="text/css">

		<%@ include file="searchallsupplier.jsp"%>
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
<script type="text/javascript">
	var req;
	function load(){
	var genera=document.getElementById("genera").value;
	Change_Select(genera);
	}
    function Change_Select(obj){//当第一个下拉框的选项发生改变时调用该函数
      var url = "group_sales.jsp?itemNumber=" +obj + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("POST",url,true);
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
         // alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //解析返回xml的方法
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
      var xSel = xmlDoc.getElementsByTagName('select');
      //获得XML文档中的所有<select>标记
      var select_root = document.getElementById('group');
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
	     var ops = document.getElementById("group").options;
			for(var i=0;i<ops.length;i++) {
				if(ops[i].value==<%=group%>){
					ops[i].selected = true;	
				}
			}
		
	    }   
    
	    function checkForm(TheForm) {
		if (TheForm.product.value == "") {
			alert ("产品名不能为空！");
			TheForm.quotime.focus();
			return(false);
		}
		if (TheForm.standard.value == "") {
			alert ("规格不能为空！");
			TheForm.completetime.focus();
			return(false);
		}
		if (TheForm.unit.value == "") {
			alert ("单位不能为空！");
			TheForm.estimatesPoints.focus();
			return(false);
		}
		return(true);
	}   
	
	function addproduct(obj){
		var product =document.getElementById("product");
		var standard =document.getElementById("standard");
		var  unit=document.getElementById("unit");
		var  warning=document.getElementById("warning");
		if(product.value ==null || product.value==""){
			alert ("产品名不能为空！");
			product.focus();
			return false;
		}
		if(standard.value ==null || standard.value==""){
			alert ("规格不能为空！");
			standard.focus();
			return false;
		}
		if(unit.value ==null || unit.value==""){
			alert("请输入标准！！！");
			unit.focus();
			return false;	
		}
		if(warning.value ==null || warning.value==""){
			alert("请输预警量！！！");
			unit.focus();
			return false;	
		}
		
		myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addproduct_post.jsp?status="+obj+"&proudctId=<%=proudctId%>";
		myform.submit();
	}
</script>
	</head>
	<body class="body1" onload="load();">
		<form method="post" name="quotationform" id="quotationform" action="addinventory_post.jsp"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="confirmUserId" id ="confirmUserId" type ="hidden" value="">
			<input name="totalprice" id="totalprice" type="hidden" value="" />
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
							<b>库存管理&gt;&gt;添加产品信息</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>

						<td width="12%">
							大类：
						</td>
						<td width="33%">
							<select name="genera" id="genera" style="width: 300px" onchange="Change_Select(this.value);">
								<%
								Map<String,String> map =DaoFactory.getInstance().getInventoryDao().getCategory();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=value%>" <%=genera==Integer.parseInt(value)?"selected":"" %>><%=map.get(value)%></option>
								<%
								 }
								%>
							</select>
						</td>
						<td>
							小类：
						</td>
						<td>
						<select name="group" id="group" style="width: 300px">
						</select>
						</td>
					</tr>
					<tr>
						<td>
							产品名：
						</td>
						<td>
							<input name="product" id ="product" size="40" value="<%=product==null?"":product%>">
						</td>
						<td>
							单位：
						</td>
						<td width="33%">
							<input name="unit" type="text" id="unit" size="40" value="<%=unit==null?"":unit%>"/>
						</td>

					</tr>
					<tr>
						<td>
							规格：
						</td>
						<td>
							<input name="standard" type="text" id=""standard"" size="40" value="<%=standard==null?"":standard%>">
						</td>
						<td width="10%">
							参考价：
						</td>
						<td>
							<input name="price" type="text" id="price" size="40" value="<%=price%>" />
						</td>
						
					</tr>
					<tr>
						<td width="10%">
							预警量:
						</td>
						<td>
							<input id ="warning"  name ="warning" size="40" value="<%=warning==null?"":warning%>" >
						</td>
						<td>
							供应商：
						</td>
						<td>
							<input id="suppliername" type="text" name="suppliername"
								size="40" onkeyup="suggest(this.value,event,this);"
								onkeydown="return tabfix(this.value,event,this);"
								onblur="clearSuggest();" value="<%=suppliername==null?"":suppliername%>"/>
							<p class="nodisplay">
								<label>
									kIndex
								</label>
								<input class="nodisplayd" type="text" id="keyIndex" />
							</p>
							<p class="nodisplay">
								<label>
									rev
								</label>
								<input class="nodisplayd" type="text" id="sortIndex" />
							</p>

							<div id="results"></div>
						</td>
					</tr>
					<tr>
						<td> 
							是否固定资产： 
						</td>
						<td>
							<input name="assets" type="radio"" id="assets" size="40" value="n" checked="checked">否
							<input name="assets" type="radio"" id="assets" size="40" value="y" <%=assets.equals("y")?"checked":"" %>>是
						</td>
						<td width="10%"> 
							 &nbsp;
						</td>
						<td>
							&nbsp;
						</td>
						
					</tr>
					<tr>
					
						<td colspan="4" style="text-align: center;">
						<%if(status ==null){
						%>
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="保存并返回本页" onClick="addproduct(1)">
						&nbsp;
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="保存" onClick="addproduct(0);">
						<%
						}else{
						%>
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="修改" onClick="addproduct('<%=status%>')">
						<%
						} %>
						
					</td>
					</tr>
				</table>
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
