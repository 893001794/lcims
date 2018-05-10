<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>平方根计算</title>
</head>

<SCRIPT LANGUAGE="LiveScript">
function Newton(Input){
   var X = 1;
   var FX = X*X - Input.value;
   for (var i = 0; i < 10; i++) {
      X = X - FX/(2*X);
      FX = X*X - Input.value;
   }
   Input.value = X;
   return true;
}
function ClearForm(form) {
   form.Sqr.value = "";
}

function a(){
	document.write("2的平方根等于："+Math.sqrt(2)+"<br>"); 
	document.write("2的平方根等于："+Math.sqrt(((10-0.12)*1000)/(10+273))); 
	alert("2的平方根等于："+Math.sqrt(((10-0.12)*1000)/(10+273)));
	alert("2的平方根等于："+10*0.05*0.5*Math.sqrt(((10-0.12)*1000)/(10+273)));
}
</SCRIPT>
<CENTER><H1></H1>
<p>
<hr>
<b>
<FORM METHOD=POST>输入平方数:</b>       <b><INPUT TYPE=TEXT NAME=Sqr SIZE=23 MAXLENGTH=10 onFocus="ClearForm(this.form)"></b>             
<b><INPUT TYPE="button" VALUE="计算" onClick="a()">
</FORM><BR CLEAR=ALL>
<body>
</body>
</html>