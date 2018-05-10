<%@ page contentType="text/html;charset=GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<html>
<head>
<title>项目状态查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
<form name=form1 method=post action=control_order.jsp>
<table width=100% border=0 cellspacing=0 cellpadding=0 align=center>
<th><h1>项目状态查询</h1></th>
<br>
  <tr> 
    <td bgcolor=999999> 
    <table width=100% border=0 cellspacing=1 cellpadding=3>
  <tr bgcolor=f1f1f1>
	  <td align=center valign=middle width=50%>请输入报告编号： 
      <input type=text name=keywords value=>
      <input type=submit name=Submit value=搜索>
    </td>
    <td align=center valign=middle width=50%>请输入报价单编号： 
      <input type=text name=keywords value=>
      <input type=submit name=Submit value=搜索>
    </td>
    </tr></table>
	 
    </td>
  </tr>
</table>
</form>
<h5 align="center">---------------------------------------------------------------------------------------------------------------------</h5>
<table align="center">
<tr>
<td>报价单编号：</td>
<td align="left"><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>报告编号：</td>
<td align="left"><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>项目等级：</td>
<td><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
</table>
<table align="center">
<tr>
<td>客户名称：</td>
<td align="left"><input type="text" size="25" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>客服人员：</td>
<td align="left"><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>销售人员：</td>
<td align="left"><input type="text" size="15" style="background-color: #F2F2F2"  readonly="readonly"/></td>
</tr>
</table>

<table align="center">
<tr>
<td>测试项目：</td>
<td>
<input size="60" style="background-color: #F2F2F2"  readonly="readonly"/>
</td>
<td>项目存在外包：</td>
<td><input type="checkbox" readonly="readonly"/></td>
</tr>
<br>
<tr align="center">
<td>样品名称：</td>
<td><input type="text" size="60" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>项目取消：</td>
<td><input type="checkbox"/></td>
</tr>
</table>

<table align="center">
<tr>
<td>食品级成品状态备注：</td>
<td>
<input size="70" style="background-color: #F2F2F2"  readonly="readonly"/>
</td>
</tr>
<tr>
<td>项目预警备注：</td>
<td>
<textarea rows="6" cols="50"></textarea>
</td>
</tr>
</table>
<table align="center">
<tr>
<td>项目预警：</td>
<td><input type="checkbox"/></td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<td>报告已发出：</td>
<td><input type="checkbox"/></td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<td>迟单：</td>
<td><input type="checkbox"/></td>
</tr>
</table>
<table align="center">
<tr>
<td>送实验室时间：</td>
<td><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
<td>项目完成:</td>
<td><input type="checkbox"/></td>
</tr>
<br>
<tr align="center">
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
<td style="background-color: rgb(255, 255, 0);"><input type="text" style="background-color: #F2F2F2"  readonly="readonly"/></td>
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
