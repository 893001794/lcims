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
	String id =request.getParameter("id");
	String statusStr =request.getParameter("status");
	//库存Id
	String inventoryId =request.getParameter("inventoryId");
	//删除、修改
	String type =request.getParameter("type");
	String status="";
	String earea="" ; //区域
	String number =""; //数量
	String remark ="" ; //备注
	String productName=""; //产品名称
	String productPrice=""; //产品价格
	String client=""; //客户名称
	int productId=0;
	if(id !=null){
		productId =Integer.parseInt(id);
	}
	//获取库存信息
	if(inventoryId !=null){
		List inventoryRow=DaoFactory.getInstance().getInventoryDao().getInventory(Integer.parseInt(inventoryId));
		List inventoryColumn=(List)inventoryRow.get(0);
		productId=Integer.parseInt(inventoryColumn.get(0)+"");
		earea=inventoryColumn.get(1)+"";
		number=inventoryColumn.get(2)+"";
		productPrice=inventoryColumn.get(3)+"";
		client=inventoryColumn.get(4)+"";
		status=inventoryColumn.get(5)+"";
		remark=inventoryColumn.get(6)+"";
	}
	if(statusStr ==null){
		statusStr="";
	}
		if(statusStr.equals("storing")){
			status="入库";
		}else if(statusStr.equals("outbound")){
			status="出库";
		}
	List row=DaoFactory.getInstance().getInventoryDao().getProduct(productId);
	List column =(List)row.get(0);
	productName=column.get(0).toString();
	if(inventoryId ==null){
		productPrice =column.get(1).toString();
		client=column.get(2).toString();
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
    }   
	    function checkForm(obj) {
		if (document.getElementById("number").value == "") {
			alert ("数量不能为空！");
			document.getElementById("number").focus();
			return(false);
		}
		myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addinventory_post.jsp?type="+obj+"&inventoryId=<%=inventoryId%>";
		//alert(window.dialogArguments);
		myform.submit();
		window.close();
	}   
</script>
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="addinventory_post.jsp"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="id" id ="id" type ="hidden" value="<%=productId%>">
			<input name ="status" id ="status" type ="hidden" value="<%=status%>">
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
							<b>库存管理&gt;&gt;添加库存</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							产品名：
						</td>
						<td>
							<input name="product" id ="product" size="40" value="<%=productName%>">
						</td>
						<td width="15%">
							区域：
						</td>
						<td>
							<select name="earea" id="earea" style="width: 300px">
								<option value="中山" selected="selected">中山</option>
								<option value="东莞" <%=earea.equals("东莞")?"selected":"" %>>东莞</option>
							</select>
						</td>
					</tr>
					<%if(statusStr.equals("storing")){ %>
					<tr>
						<td width="10%"> 
							单价： 
						</td>
						<td>
							<input name="price" type="text" id="price" size="40" value="<%=productPrice%>"/>
						</td>
						<td>
							供应商：
						</td>
						<td>
							<input id="suppliername" type="text" name="suppliername"
								size="40" onkeyup="suggest(this.value,event,this);"
								onkeydown="return tabfix(this.value,event,this);"
								onblur="clearSuggest();" value="<%=client ==null?"":client%>"/>
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
					<%} %>
					<tr>
						<td>
							<%=status%>数量：
						</td>
						<td>
							<input name="number" type="text" id="number" size="40" value="<%=number%>">
						</td>
						<td>备注:
						</td>
						<td width="33%">
						<textarea rows="3" cols="3" style="width: 300px" name="remark" id ="remark">remark</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
						<%if(inventoryId ==null){
						%>
							<input type="button" onclick="checkForm('add')" value="添加">
						<%
						}else{
						%>
							<input type="button" onclick="checkForm('modi')" value="修改">
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
