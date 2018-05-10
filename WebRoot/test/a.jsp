<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="java.io.PrintWriter"%>


 
<%
request.setCharacterEncoding("GBK");

 %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html;charset=gb2312">
<meta name="keywords" content="站长,网页特效,网页特效代码,js特效,js脚本,脚本,广告代码,zzjs,zzjs.net,www.zzjs.net,站长特效 网" />
<meta name="description" content="www.zzjs.net,站长特效网，站长必备js特效及广告代码。大量高质量js特效，提供高质量广告代码下载,尽在站长特效网" />
<title>网页特效 仿QQ邮箱弹出层选择收件人的效果 站长特效网欢迎您。</title>
<style type="text/css">
.black_overlay{display: none;position: absolute;top: 0%;left: 0%;width: 100%;height: 100%;background-color:#FFFFFF;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}
.white_content{display: none;position: absolute;top: 25%;left: 25%;width: 50%;height: 50%;padding: 16px;border: 16px solid orange;margin:-32px;background-color: white;z-index:1002;overflow: auto;}
</style>
<script language="javascript" type="text/javascript">
function moveselect(obj,target,all){
 if (!all) all=0
 if (obj!="[object]") obj=eval("document.all."+obj)
 target=eval("document.all."+target)
 if (all==0)
 {
   while (obj.selectedIndex>-1){
   //alert(obj.selectedIndex)
   mot=obj.options[obj.selectedIndex].text
   mov=obj.options[obj.selectedIndex].value
   obj.remove(obj.selectedIndex)
   var newoption=document.createElement("OPTION");
   newoption.text=mot
   newoption.value=mov
   target.add(newoption)
   }
 }//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
 else
 {
  //alert(obj.options.length)
  for (i=0;i<obj.length;i++)
   {
   mot=obj.options[i].text
   mov=obj.options[i].value
   var newoption=document.createElement("OPTION");
   newoption.text=mot
   newoption.value=mov
   target.add(newoption)
   }
obj.options.length=0
 }
}
function dakai(){
document.getElementById('light').style.display='block';
document.getElementById('fade').style.display='block'
}
function guanbi(){
//下面上把右边select的值传到文本框内
var yuanGong=document.getElementById("yuanGong")
yuanGong.value=""//如果不加这句，则每次选择的结果追加
var huoQu=document.getElementById("D2")
for(var k=0;k<huoQu.length;k++)
yuanGong.value=yuanGong.value + huoQu.options[k].value + " "//这里的" "中间为空格，为字符间的分隔符，可以改成别的
document.getElementById('light').style.display='none';
document.getElementById('fade').style.display='none'
}//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
</script>
</head>
<body>
<a href="http://www.zzjs.net/">站长特效网</a>,站长必备的高质量网页特效和广告代码。zzjs.net，站长js特效。<hr>
<!--欢迎来到站长特效网，我们网站收集大量高质量js特效，提供许多广告代码下载，网址：www.zzjs.net，zzjs@msn.com,用.net打造靓站-->
<input type="text" id="yuanGong" onclick="dakai()" size="50">
<div id="light" class="white_content">
<table border="1" width="350" id="table4" bordercolor="#CCCCCC" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF" cellpadding="3" cellspacing="0">
  <tr>
    <td width="150" height="200" align="center" valign="middle">
      该部门员工
      <select size="12" name="D1" ondblclick="moveselect(this,'D2')" multiple="multiple" style="width:140px">
        <option value="员工1">员工1</option>
        <option value="员工2">员工2</option>
        <option value="员工3">员工3</option>
      </select>
    </td>
    <td width="50" height="200" align="center" valign="middle">
      <input type="button" value="<<" name="B3" onclick="moveselect('D2','D1',1)" /><br />
      <input type="button" value="<" name="B5" onclick="moveselect('D2','D1')" /><br />
      <input type="button" value=">" name="B6" onclick="moveselect('D1','D2')" /><br />
      <input type="button" value=">>" name="B4" onclick="moveselect('D1','D2',1)" /><br />
    </td>
    <td width="150" height="200" align="center" valign="middle">
      未划分部门员工
      <select size="12" name="D2" id="D2" ondblclick="moveselect(this,'D1')" multiple="multiple" style="width:140px">
        <option value="员工4">员工4</option>
        <option value="员工5">员工5</option>
      </select>
    </td>
  </tr>
</table>
<a href="javascript:void(0)" onclick="guanbi()">确定</a>
<input type="button" name="button" onclick="guanbi()" value="也可以使用按钮来确定" />
</div>
<div id="fade" class="black_overlay"></div>
</body>
</html>