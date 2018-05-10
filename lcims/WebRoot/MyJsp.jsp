<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.sun.corba.se.impl.copyobject.JavaStreamObjectCopierImpl"%>

<%@page import="java.applet.Applet"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
    <script type="text/javascript" language="javascript"> 
        function Chck() 
        {   
            var len = 0;   
            var str=document.getElementById("input1").value;
            for (var i=0; i<str.length; i++)
            {   
                if (str.charCodeAt(i)>127 || str.charCodeAt(i)==94) {   
                    len += 2;   
                } else {   
                    len ++;   
                }   
            }   
            alert(len); 
            if(len>20)
            {
                alert("對不起，您輸入的內容大於20個字節！");
            }
        } 
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input id="input1" type="text" onblur="Chck();" /> 
        <input type="button" value="确定" onclick="Chck();" /> 
        </div>
    </form>
</body>
</html>

