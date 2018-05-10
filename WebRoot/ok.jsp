<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.sun.corba.se.impl.copyobject.JavaStreamObjectCopierImpl"%>

<%@page import="java.applet.Applet"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	 
	//JSObject window =JSObject.getWindow(new Applet());
	//if(window !=null){
	//window.eval("doAlert(11111)");
	//}
	
	
 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ok.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	.text_readonly
	{
	zoom:1;outline:0;line-height:20px; background-color:#fff;border:0px;
	width:500px;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;
	 }   
function text_readonly(){   
    var mc = document.getElementById("text_content");   
    if(mc != null && mc.value.length>0){   
        mc.rows = (mc.scrollHeight/20+2);   
    }   
}  
	</style>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>

<BODY>     
 <% 
  String ip=request.getHeader("x-forwarded-for"); 
   %> 
   <% 
      if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
   %> 
   <% 
      ip = request.getHeader("Proxy-Client-IP"); 
   %> 
   <% 
      }if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
   %> 
   <% 
      ip = request.getHeader("WL-Proxy-Client-IP"); 
   %> 
   <% 
      }if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
   %> 
   <% 
      ip = request.getRemoteAddr(); 
   %> 
  
  
    <input type = "text" name="ip" 
    value="<%= request.getRemoteAddr()%>" id="macip"/> 
 
//text文本 怎么放内容看各种语言   
<textarea class="text_readonly" disable="true" id="text_content" name="text_content" rows="4">   
Assuming you have the Globalize plugin installed, the first thing you llneed to do is to generate its migration fileIf you want data for a full</textarea>   
    <br/> 
   <% 
      } 
   %> 

  </BODY>     
</html>
