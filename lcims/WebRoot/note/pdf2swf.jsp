<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>

<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>

<%
	request.setCharacterEncoding("GBK");
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>pdf2swf文档</title>
<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>

 <script type="text/javascript">
    function showReport() {
	var rid =document.getElementById("rid").value;
	var radio =document.getElementById("radio");
	var radioValue =radio.value;
	for(var i =0;i<radio.length;i++){
		if(myform.radio[i].checked==true ){
		radioValue =myform.radio[i].value;
		break ;
		}
	}
	
	var security=document.getElementById("security").value;
	if(rid ==""){
	alert("请输入报告编号!!!")
	return ;
	}else{
		if(security ==""){
		alert("请输入防伪码!!!");
		return ;
		}else{
				$.ajax({ //调用jquery ajax
				type:"POST",  //跳转方法为POST
				//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
				url:"/lcims/verificationS", //跳转了路径
				data:"rid="+rid+"&security="+security, //传输的值或参数
		        error: function(){alert("error!!");},  //如果路径错误或者参数有错的时候就弹出此窗口
				success: function(data){  //如果正确或拿到java里面传输过来的值
				 var agent = $(data).find('agent'); //得到一个名称为agent的xml对象//得到一个名称为agent的xml对象
				if(agent.attr('suc') == 'true'){ //得到名称为agent的xml对象里面suc元素，并且判断suc元素的值是否为true
					alert("确认成功！");
					//window.open("http://192.168.0.7:1234/report/pdf2swf?rid="+rid+"&erptype="+radioValue);
					window.open("http://127.0.0.1:8080/report/pdf2swf?rid="+rid+"&erptype="+radioValue+"&security="+security);
					}
				else{
					alert("请输入防伪码不正确");
					return false;
					}}
			});
		}
	}
	}
    </script>
	</head>
	<body ><div align="center"> 
			</div><hr width="100%" size=0 align="center"><div align="center"> 
			<form method="post" action="#" autocomplete="off" name="myform"> 
	<input type="hidden" name="command" value="search"> 
			<table cellspacing="5" cellpadding="5" border="0" width="100%" style="margin-left: 13em;"> 
				<tr> 
					<td width="50%" valign="middle"> 
							<font color="red">请输入报告编号：</font> 
							<input type="text" id="rid" name="rid" size="40"> 
							<input type="radio" value="C" name="radio" checked>中文模板 
							<input type="radio" value="E" name="radio">英文模板 
							 <script>   
						        $("#rid").autocomplete("../vrid_ajax.jsp",{
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
					 
				</tr> 
				<tr> 
					<td> 
					<font color="red">请输入防伪码&nbsp;&nbsp;：</font> 
					<input type="text" id="security" name="security" size="40"> 
					<input type="button" onclick="showReport();" name="Submit" value="查看"> 
					</td> 
				</tr> 
			</table> 
		</form></div>
	</body>
</html>
