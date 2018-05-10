<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@ page errorPage="../error.jsp" %>
<%
	response.setContentType("text/xml");
    response.setHeader("Cache-Control", "no-cache");
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String xml_start = "<selects>";
    String xml_end = "</selects>";
    String xml = "";
    
	String show = "请读入报告条形码";
	String kw = "";
	String sound = "yes";

	String keywords = request.getParameter("keywords").trim();


    xml += "<select><value>" + show + "</value><text>" + kw + "</text><sound>" + sound + "</sound></select>";
    
    String last_xml = xml_start + xml + xml_end;
    response.getWriter().write(last_xml);
        
%>

<html>
<head>
 
<script type="text/javascript">
function play() {
document.embeds('MediaPlaye').play();

alert("play");
}
</script>


</head>
<body>
<input type="button" onclick="sele();" value="点我"/>

<br>

    
   <embed   id="MediaPlaye"   name="MediaPlaye"   src='Readagain.wav'   autostart=false   loop=false></embed>
  <input   type=button   onclick="stop();"   value=stop>   
  <input   type=button   onclick="play();"   value=play>   
<input   type=button   onclick="document.embeds('MediaPlaye').stop()"   value=1111>   
  <input   type=button   onclick="document.embeds('MediaPlaye').play()"   value=22222>  

</body>
</html>