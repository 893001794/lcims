<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("GBK");

String ems="";
String command=request.getParameter("command");
if(command !=null){
ems =request.getParameter("ems");
}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'sample_package.jsp' starting page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<script src="../javascript/jquery.js"></script>
	<script src="../javascript/jquery.autocomplete.min.js"></script>
	<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
	<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
	<style type="text/css" bogus="1"> 
.txt{ 
color:#005aa7; 
border-bottom:1px solid #005aa7; /* �»���Ч�� */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* ����ɫ͸�� */ 
} 
</style> 
<script type="text/javascript">
	function checkForm(){
		var status ="n";
		var ems =document.getElementById("ems").value;
		var lieferen=document.getElementById("lieferen");
		if(lieferen.checked == false && ems ==""){
		alert("�������ݱ�Ż��Ϸǿ�ݵ�ѡ�򣡣���");
		return false;
		}
		//alert(lieferen.checked);
		if(lieferen.checked == true){
		status="y";
		}
		//alert(status);
		document.getElementById("myems").value=ems;
		var client =document.getElementById("client").value;
		if(client ==""){
			alert("�ļ���˾����Ϊ��!!")
			return false;
		}
		var sales =document.getElementById("sales").value;
		if(sales ==""){
			alert("�ռ��˲���Ϊ��!!")
			return false;
		}
		var form1=document.getElementById("form1");
		form1.action="sample_package_post.jsp?status="+status+"&ems="+ems;
		form1.submit();
	}
	function getSales(obj){
	var client =obj.value;
	
	$.ajax({ //����jquery ajax
			type:"POST",  //��ת����ΪPOST
			//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
			url:"/lcims/samplePackage", //��ת��·��
			data:"client="+client, //�����ֵ�����
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        error: function(){},  //���·��������߲����д��ʱ��͵����˴���
			success: function(data){  //�����ȷ���õ�java���洫�������ֵ
				    var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
				  //  alert(agent.attr('name')+"��������ֵ");
				 	if(agent.attr('name') != ""){ //�õ�����Ϊagent��xml��������sucԪ�أ������ж�sucԪ�ص�ֵ�Ƿ�Ϊtrue
					 	document.getElementById("sales").value=agent.attr('name');
				 	}		
			 	}
		 	});
		}
</script>
  </head>
  
  <body onload="javascript:myform.ems.focus();"> 

    	<table border="0" align="center" width="900">
    	
    		<tr>
    			
    		    <form action="sample_package.jsp?" style="text-align: center;" name="myform" method="post">
    		    <input type="hidden" name="command" value="search" />
    			<td>��ݱ�ţ�</td>
    			<td><input type="text" name ="ems" size="26" value="<%=ems%>" >&nbsp;&nbsp; 
    			<input type="checkbox" name="lieferen" id="lieferen" onclick="changeStatus();">&nbsp;�ǿ��</td>
    			<script type="text/javascript">
						     function changeStatus(){
						     if(document.getElementById("lieferen").checked==true){
						     var ems=document.getElementById("ems");
						     ems.disabled=true;
						     }
						     }
						     </script>
						     
    			</form >
    		<form action="#" style="text-align: center;" name="form1" method="post">
    			<input type="hidden" name ="myems" id="myems" size="40" value="<%=ems%>">
    			<td>�������ƣ�</td>
    			<td><input name="packageName" id ="packageName" size="40"></td>
    			
    		</tr>
    		<tr>
    		<td>�ļ���˾��</td>
    			<td>
    			<input name="client" type="text" id="client" size="40" onblur="getSales(this);"/>
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
    			<td>&nbsp;</td>
    			<td>&nbsp;</td>
    		</tr>
    		<tr>
    		<td>���۵��ţ�</td>
    		<td>
    		<input type="text" size="40" name ="pid" id ="pid" >
						<script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
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
    		<td>��Ŀ��ţ�</td>
    		<td><input name ="sid" id ="sid" size="40"></td>
    		</tr>
    		<tr>
    		<td>�����ˣ�</td>
    		<td><input name ="sales" id ="sales" size="40"></td>
    		<td>����ʱ�䣺</td>
    			<td>
		    		<input name="dreceipt" type="text" id="dreceipt" size="40" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%>"/>
					<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'dreceipt'})" src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
				</td>
    		</tr>
    		<tr>
    		<td colspan="4" align="center"">
    			<input type="button" value="�ύ" onclick="checkForm();">
    		</td>
    		</tr>
    		</form>
    	</table>
    
</html>
