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
		<title>pdf2swf�ĵ�</title>
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
	alert("�����뱨����!!!")
	return ;
	}else{
		if(security ==""){
		alert("�������α��!!!");
		return ;
		}else{
				$.ajax({ //����jquery ajax
				type:"POST",  //��ת����ΪPOST
				//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
				url:"/lcims/verificationS", //��ת��·��
				data:"rid="+rid+"&security="+security, //�����ֵ�����
		        error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
				success: function(data){  //�����ȷ���õ�java���洫�������ֵ
				 var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����//�õ�һ������Ϊagent��xml����
				if(agent.attr('suc') == 'true'){ //�õ�����Ϊagent��xml��������sucԪ�أ������ж�sucԪ�ص�ֵ�Ƿ�Ϊtrue
					alert("ȷ�ϳɹ���");
					//window.open("http://192.168.0.7:1234/report/pdf2swf?rid="+rid+"&erptype="+radioValue);
					window.open("http://127.0.0.1:8080/report/pdf2swf?rid="+rid+"&erptype="+radioValue+"&security="+security);
					}
				else{
					alert("�������α�벻��ȷ");
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
							<font color="red">�����뱨���ţ�</font> 
							<input type="text" id="rid" name="rid" size="40"> 
							<input type="radio" value="C" name="radio" checked>����ģ�� 
							<input type="radio" value="E" name="radio">Ӣ��ģ�� 
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
					<font color="red">�������α��&nbsp;&nbsp;��</font> 
					<input type="text" id="security" name="security" size="40"> 
					<input type="button" onclick="showReport();" name="Submit" value="�鿴"> 
					</td> 
				</tr> 
			</table> 
		</form></div>
	</body>
</html>
