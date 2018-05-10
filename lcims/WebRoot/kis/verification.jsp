<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>√‹¬Î ‰»Î</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="javascript">
	function trans(){
	var pwd=document.getElementById("pwd").value;
	   window.returnValue=pwd;
	   window.close();
} 
</script>


  </head>
  
  <body>
  <form action="">
    <table width="400" height="10" align="center" >
    	<tr>
    		<td>
    			√‹¬Î:<input type="password" size="40" name ="pwd" id="pwd">&nbsp;&nbsp;
    			<input type="button" onclick="trans();" value="»∑∂®">
    		</td>
    	</tr>
 	
    </table>
    </form>
  </body>
</html>
