<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>选择下拉菜单－www.51windows.Net</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META NAME="Description" CONTENT="Power by 51windows.Net">
</HEAD>
<BODY>
<p>选定一项或多项然后点击添加或移除(按住shift或ctrl可以多选)，或在选择项上双击进行添加和移除。</p>
<form method="post" name="myform">
  <table border="0" width="300">
    <tr>
      <td width="40%">
  <select style="width:100%;" multiple name="list1" size="12" ondblclick="moveOption(document.myform.list1, document.myform.list2)">
   <option value="北京">北京</option>
   <option value="上海">上海</option>
   <option value="山东">山东</option>
   <option value="安徽">安徽</option>
   <option value="重庆">重庆</option>
   <option value="福建">福建</option>
   <option value="甘肃">甘肃</option>
   <option value="广东">广东</option>
   <option value="广西">广西</option>
   <option value="贵州">贵州</option>
   <option value="海南">海南</option>
   <option value="河北">河北</option>
   <option value="黑龙江">黑龙江</option>
   <option value="河南">河南</option>
   <option value="湖北">湖北</option>
   <option value="湖南">湖南</option>
   <option value="内蒙古">内蒙古</option>
   <option value="江苏">江苏</option>
   <option value="江西">江西</option>
   <option value="吉林">吉林</option>
   <option value="辽宁">辽宁</option>
   <option value="宁夏">宁夏</option>
   <option value="青海">青海</option>
   <option value="山西">山西</option>
   <option value="陕西">陕西</option>
   <option value="四川">四川</option>
   <option value="天津">天津</option>
   <option value="西藏">西藏</option>
   <option value="新疆">新疆</option>
   <option value="云南">云南</option>
   <option value="浙江">浙江</option>
   <option value="香港">香港</option>
   <option value="澳门">澳门</option>
   <option value="台湾">台湾</option>
   <option value="其他">其他</option>
  </select>
   </td>
      <td width="20%" align="center">
  <input type="button" value="添加" onclick="moveOption(document.myform.list1, document.myform.list2)"><br><br>
  <input type="button" value="全选" onclick="moveAllOption(document.myform.list1, document.myform.list2)"><br><br>
  <input type="button" value="删除" onclick="moveOption(document.myform.list2, document.myform.list1)"><br><br>
  <input type="button" value="全删" onclick="moveAllOption(document.myform.list2, document.myform.list1)">
   </td>
      <td width="40%">
  <select style="width:100%;" multiple name="list2" size="12" ondblclick="moveOption(document.myform.list2, document.myform.list1)">
  </select>
   </td>
    </tr>
  </table>
值：<input type="text" name="city" size="40" value="" />
</form>
<script language="JavaScript">
<!--
function moveOption(e1, e2){
 try{
  for(var i = 0; i < e1.options.length; i++){
   if(e1.options[i].selected){
    var e = e1.options[i];
    e2.options.add(new Option(e.text, e.value));
    e1.remove(i);
    i = i - 1;
   }
  }
  document.myform.city.value=getvalue(document.myform.list2);
 }
 catch(e){}
}
function getvalue(geto){
 var allvalue = "";
 for(var i = 0; i < geto.options.length; i++){
  allvalue += geto.options[i].value + ",";
 }
 return allvalue;
}
function moveAllOption(e1, e2){
 try{
  for(var i = 0;i < e1.options.length; i++){
   var e = e1.options[i];
   e2.options.add(new Option(e.text, e.value));
   e1.remove(i);
   i = i - 1;
  }
  document.myform.city.value=getvalue(document.myform.list2);
 }
 catch(e){
  
 }
}
//-->
</script>
</BODY>
</HTML>
