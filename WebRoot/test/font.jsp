<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'font.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		span.selectexample {
			background:#cccccc;
			color:#fff;
		}
	</style>
  </head>
  
<body>
<table align="center" border="0" cellpadding="0" cellspacing="0"  bgcolor="#0909aa" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=blue,endColorStr=skyblue) progid:DXImageTransform.Microsoft.Shadow(color=blue,direction=135,strength=15);">
<tr>
<td align="center" width="450" height="30" style="filter:glow(color=#CCCCCC,strength=10);font-family:楷体_GB2312;font-size:18px;">骓不逝兮可奈何，</td>
</tr>
<tr>
<td align="center" width="450" height="30" style="filter:glow(color=#CCCCCC,strength=20);font-family:楷体_GB2312;font-size:18px;">虞兮虞兮奈若何？</td>
</tr></table>
Try it below. If you select something and it looks like<span class="selectexample">this</span>,
your browser supports selection styles.
</body>
</html>
