<%@ page contentType="text/html;charset=GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<html>
<head>
<title>项目状态查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body onload="document.form1.keywords.focus()">
<form name=form1 method=post action=control_order.jsp>
<table width=100% border=0 cellspacing=0 cellpadding=0 align=center>
<th><h1>项目状态查询</h1></th>
<br>
  <tr> 
    <td bgcolor=999999> 
    <table width=100% border=0 cellspacing=1 cellpadding=3>
  <tr bgcolor=f1f1f1>
	  <td align=center valign=middle width=50%>输入栏： 
      <input type=text name=keywords value="" >
      <input type=submit name=Submit value=搜索>
    </td>
    </tr>
   </table>
    </td>
  </tr>
</table>
</form>
<h5 align="center">-----------------------------------------------------------------------------------------------------------</h5>
<table align="center">
<tr>
<td>报告编号：</td>
<td align="left"><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>项目等级：</td>
<td><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
</table>

<table align="center">
<tr align="center">
<td>测试项目：</td>
<td>
<input size="80" style="background-color: #F2F2F2"  readonly="readonly"/>
</td>
</tr>
<br>
<tr align="center">
<td>样品名称：</td>
<td><input type="text" size="80" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>

</table>
<table align="center">
<tr>
<td>项目接收时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>排单时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
<br>
<tr>
<td>制备开始时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>应出报告时间：</td>
<td style="background-color: rgb(255, 255, 0);"><input type="text" style="background-color: #F7FE2E"  readonly="readonly"/></td>
</tr>
<br>
<tr>
<td>无机前处理开始时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>有机前处理开始时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
<br>
<tr>
<td>无机上机开始时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>有机上机开始时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
<br>
<tr>
<td>无机数据完成时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>有机数据完成时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
<br>
<tr>
<td>报告完成时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>报告发出时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
</table>
<br>
<br>


</body>
</html>
