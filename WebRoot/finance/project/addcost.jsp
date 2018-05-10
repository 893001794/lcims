<%@ page language="java" contentType="text/html; charset=gbk"  pageEncoding="gbk"%> 
 <%@ page errorPage="../../error.jsp" %>
<html>
<head>
<title>财务管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<meta http-equiv="refresh" content="60*30">
<link rel="stylesheet" href="../../css/css1.css" type="text/css" media="screen">

</head>

<script language="JavaScript">
<!--
function change(obj,i) {
he=parseInt(obj.style.height);
if (he>=80&&he<=400)
   obj.style.height=he+i+'px';
else 
   obj.style.height='80px';
}

function chk(theForm){
if (theForm.classid.value == ""){
                alert("请选择部门!");
                theForm.classid.focus();
                return (false);
        } 
if (theForm.addtime.value == ""){
                alert("请输入日期!");
                theForm.addtime.focus();
                return (false);
        } 
if (theForm.money.value == ""){
                alert("请输入金额!");
                theForm.money.focus();
                return (false);
        } 
if (theForm.project.value == ""){
                alert("请输入项目名称!");
                theForm.project.focus();
                return (false);
        } 
}
//-->
</script>
<body text="#000000" topmargin=0>
<table cellpadding="2" cellspacing="1" border="0" width="95%" class="tableBorder" align=center>
  <form action="" method=post id=form1 name=form1 onSubmit="return chk(this)">
    <tr bgcolor=ffffff> 
      <th height=25 colspan=5 align="center">实际费用登记     </th>
    </tr>
    <tr  bgcolor=ffffff> 
      <td width="26%" class=forumrow><div align="right">费用类型：</div></td>
      <td width="18%" class=forumrow><select name="classid">
	  <option value="">请选择费用类型</option>
	  	<option value="">分包费用</option>
	  	<option value="">内部分包费用</option>
		<option value="">机构费用</option>
		<option value="">其他费用</option>
        </select>
      </td>
      <td width="7%" class=forumrow><div align="right">费用支付日期：</div></td>
      <td colspan="2" class=forumrow><input name="addtime" type="text" id="addtime" size="12" maxlength="12" readonly> 
        <input onclick="popUpCalendar(this, form1.addtime, 'yyyy-mm-dd')" type="button" value="请选择日期"></td>
    </tr>
    <tr  bgcolor=ffffff> 
      <td class=forumrow><div align="right">金额：</div></td>
      <td colspan="4" class=forumrow>
	  <input name="money" type="text" id="money" size="10" maxlength="10">
	  (<span class="red">元</span>)</td>
    </tr>
    <tr  bgcolor=ffffff> 
      <td class=forumrow><div align="right">机构名称：</div></td>
      <td colspan="4" class=forumrow> <input name="project" type="text" id="project" size="50" maxlength="50"></td>
    </tr>
    <tr  bgcolor=ffffff> 
      <td class=forumrow><div align="right">费用支付票据：</div></td>
      <td colspan="4" class=forumrow> <input name="project" type="text" id="project" size="50" maxlength="50"></td>
    </tr>
    <tr  bgcolor=ffffff> 
      <td rowspan="2" class=forumrow><div align="right">备注：</div></td>
      <td colspan="4" class=forumrow><textarea name="message" cols="50" rows="8" id="message"></textarea>      </td>
    </tr>
    <tr  bgcolor=ffffff> 
      <td width="25" colspan="3" class=forumrow>&nbsp; </td>
      <td width="38%" class=forumrow><a href="javascript:change(document.all.message,-50)"><img src="../../images/minus1.gif" alt="缩小文本框" width="20" height="20" border="0"></a> 
        <a href="javascript:change(document.all.message,50)"><img src="../../images/plus1.gif" alt="放大文本框" width="20" height="20" border="0"></a></td>
    </tr>
    <tr  bgcolor=ffffff> 
      <td colspan="5" align="center" class=forumrow><input type="submit" name="add" value="添 加"></td>
    </tr>

</table>
</html>