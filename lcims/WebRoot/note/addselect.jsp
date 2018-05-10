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
    
    <title>My JSP 'addselect.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function move(fbox,tbox) {
var i = 0;
if(fbox.value != "") {
var no = new Option();
no.value = fbox.value;
no.text = fbox.value;
tbox.options[tbox.options.length] = no;
fbox.value = "";
   }
}
function remove(box) {
for(var i=0; i<box.options.length; i++) {
if(box.options[i].selected  &&  box.options[i] != "") {
box.options[i].value = "";
box.options[i].text = "";
   }
}
BumpUp(box);
} 
function BumpUp(abox) {
for(var i = 0; i < abox.options.length; i++) {
if(abox.options[i].value == "")  {
for(var j = i; j < abox.options.length - 1; j++)  {
abox.options[j].value = abox.options[j + 1].value;
abox.options[j].text = abox.options[j + 1].text;
}
var ln = i;
break;
   }
}
if(ln < abox.options.length)  {
abox.options.length -= 1;
BumpUp(abox);
   }
}
function Moveup(dbox) {
for(var i = 0; i < dbox.options.length; i++) {
if (dbox.options[i].selected  &&  dbox.options[i] != ""  &&  dbox.options[i] != dbox.options[0]) {
var tmpval = dbox.options[i].value;
var tmpval2 = dbox.options[i].text;
dbox.options[i].value = dbox.options[i - 1].value;
dbox.options[i].text = dbox.options[i - 1].text
dbox.options[i-1].value = tmpval;
dbox.options[i-1].text = tmpval2;
      }
   }
}
function Movedown(ebox) {
for(var i = 0; i < ebox.options.length; i++) {
if (ebox.options[i].selected  &&  ebox.options[i] != ""  &&  ebox.options[i+1] != ebox.options[ebox.options.length]) {
var tmpval = ebox.options[i].value;
var tmpval2 = ebox.options[i].text;
ebox.options[i].value = ebox.options[i+1].value;
ebox.options[i].text = ebox.options[i+1].text
ebox.options[i+1].value = tmpval;
ebox.options[i+1].text = tmpval2;
      }
   }
}
//  End -->
</script>
  </head>
  
  <body>

<form ACTION="" METHOD="POST">
<table>
<tr>

<td>
<input type="button" value="增加" onclick="move(this.form.list1,this.form.list2)" name="B1"><br>
<input type="button" value="删除" onclick="remove(this.form.list2)" name="B2"><br>
<input type="button" value="向上" onclick="Moveup(this.form.list2)" name="B3"><br>
<input type="button" value="向下" onclick="Movedown(this.form.list2)" name="B4">
</td>
<td>
<select multiple size=7 name="list2">
<option value="one">ASP</option>
<option value="two">PHP</option>
<option value="three">ASP.NET</option>
<option value="four">JAVA</option>
<option value="five">DELPHI</option>
</select>
</td>
</tr>
<tr>
<td>
<input type="text" name="list1" value="">
</td></tr>
</table>
</form>
  </body>
</html>
