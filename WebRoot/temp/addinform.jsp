<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp" %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加项目信息</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
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
</style>

		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script language="javascript">
		function addproject() {
			with (document.getElementById("projectform")) {
			method="post";
			action="addinform_post.jsp";
			submit();
			}
		}
		function goBack() {
		window.self.location="myquotation.jsp";
	}
	
	function getinvprice(invprice) {
		if(invprice.value == "") {
			invprice.value = document.getElementById("totalprice").value;
		}
	}
	
	function getinvhead(invhead) {
		if(invhead.value == "") {
			invhead.value = document.getElementById("client").value;
		}
	}
	
	function getinvcontent(invcontent) {
		if(invcontent.value == "") {
			var content = "检测费" + document.getElementById("pid").value;
			invcontent.value = content;
		}
	}
	
	function changeSelect(invtype) {
		if(invtype.value.match("不开")) {
			//document.getElementById("invhead").readOnly=true;
			//document.getElementById("invhead").style.background="#F2F2F2";
			document.getElementById("invhead").value = "";
			document.getElementById("invhead").style.display="none";
			
			//document.getElementById("invcontent").readOnly=true;
			//document.getElementById("invcontent").style.background="#F2F2F2";
			document.getElementById("invcontent").value = "";
			document.getElementById("invcontent").style.display="none";
			
			//document.getElementById("invcount").readOnly=true;
			//document.getElementById("invcount").style.background="#F2F2F2";
			document.getElementById("invcount").value = "";
			document.getElementById("invcount").style.display="none";
			
			document.getElementById("invmethod").options[0].selected=true;
			
		} else {
			//document.getElementById("invhead").readOnly=false;
			//document.getElementById("invhead").style.background="#FFFFFF";
			
			//document.getElementById("invcontent").readOnly=false;
			//document.getElementById("invcontent").style.background="#FFFFFF";
			
			//document.getElementById("invcount").readOnly=false;
			//document.getElementById("invcount").style.background="#FFFFFF";
			document.getElementById("invhead").style.display="";
			document.getElementById("invcontent").style.display="";
			document.getElementById("invcount").style.display="";
			
		}
	}
	
		function changeMethod(invmethod) {
		if(invmethod.value.match("分项目")) {
			document.getElementById("invtype").value = "全额";
			document.getElementById("invcount").value = "";
			document.getElementById("invhead").value = "";
			document.getElementById("invcontent").value = "";
			document.getElementById("invoice").style.display="none";
			
		} else {
			document.getElementById("invoice").style.display="";
		}
	}

</script>




		<script language="javascript">
	function CheckForm(TheForm) {

		if (TheForm.priceid.value == "") {
			alert ("请填报价单编号！");
			TheForm.rtime.focus();
			return(false);
		}

		if (TheForm.sales.value == "") {
			alert ("请填写销售人员！");
			TheForm.sales.focus();
			return(false);
		}

		if (TheForm.client.value == "-1") {
			alert ("请选择客户名称！");
			TheForm.client.focus();
			return(false);
		}
		
	return(true);
	}
</script>

<!-- -------------ajax菜单联动start------------------------- -->

<script type="text/javascript">
    var req;
    window.onload=function()
    {//页面加载时的函数
    	Change_Select();
    }
    
    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
      var company = document.getElementById('company').value;
      encodeURIComponent(company)
      var url = "addquotation_sales.jsp?company=" + encodeURI(encodeURI(company)) + "&timestampt=" + new Date().getTime();
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
      var xSel = xmlDoc.getElementsByTagName('select');
      //获得XML文档中的所有<select>标记
      var select_root = document.getElementById('sales');
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
  </script>

<!-- -------------ajax菜单联动end--------------------------- -->


	</head>

	<body class="body1">
		<form method="post" name="projectform" id="projectform"
			onSubmit="return CheckForm(this)">
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>
						&nbsp;

					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>&gt;&gt;报价单补录</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" type="text" id="pid" size="40" />
						</td>
						<td>
							项目名称：
						</td>
						<td>
							<input type="text" id="projectcontent" name="projectcontent"
								size="40" />
						</td>
						
					</tr>

					<tr>
						<td>
							分公司：
						</td>
						<td>
							<select name="company" id="company" style="width: 300px" onchange="Change_Select();">
								<option value="中山" selected="selected">
									中山
								</option>
								<option value="广州">
									广州
								</option>
								<option value="东莞">
									东莞
								</option>
							</select>
						</td>
						<td>
							销售人员：
						</td>
						<td>
							<select name="sales" id="sales" style="width: 300px">
							
							</select>
						</td>

					</tr>
					<tr>
						
						<td width="17%">
							客户名称：
						</td>
						<td width="33%">
							<input id="client" type="text" name="client" size="40" />
							 <script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
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
						<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;
						</td>
					</tr>
					
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							项目标准报价：
						</td>
						<td width="33%">
							<input name="standprice" id="standprice" type="text" size="40" />
						</td>
						<td width="17%">
							项目总金额：
						</td>
						<td width="33%">
							<input name="totalprice" id="totalprice" type="text" size="40" />
						</td>
					</tr>
					
					</table>
					
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						
						<td width="17%">
							备注：
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" />
						</td>
						<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;
						</td>
					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存项目" onClick="addproject()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
		</form>
	</body>
</html>
