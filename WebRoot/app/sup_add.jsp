<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.lcim.app.Supplier"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@ include file="../comman.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	
	if(command != null && "add".equals(command)) {
		String name = request.getParameter("name");
		String bank = request.getParameter("bank");
		String creditname = request.getParameter("creditname");
		String creditcard = request.getParameter("creditcard");
		
		Supplier  sup = new Supplier();
		sup.setName(name);
		sup.setBank(bank);
		sup.setCreditname(creditname);
		sup.setCreditcard(creditcard);
		if(ApplicationAction.getInstance().addSuppier(sup)) {
			out.println("添加成功");
			out.println("<a href='app_add.jsp'>返回</a>");
			return;
		}
	}
 %>


<html>
<head>
<title>款项申请表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" src=../check.js></script>
<script src="javascript/Calendar.js"></script>
<script language="javascript">

	function goBack() {
		window.history.back();
	}
	
	function trim(string)
    {
        return string.replace(/(^\s*)|(\s*$)/g, "");
    }

	function CheckForm(TheForm) {

		if (trim(TheForm.vid.value) == "") {
			alert ("发票代码不能为空！");
			TheForm.vid.focus();
			return(false);
		}

		if (trim(TheForm.icode.value) == "") {
			alert ("发票号码不能为空！");
			TheForm.icode.focus();
			return(false);
		} 
		
		if (trim(TheForm.icode.value).length != 8) {
			alert ("发票号码应为8位数字！");
			TheForm.icode.focus();
			return(false);
		} 
		
		if (trim(TheForm.price.value) == "") {
			alert ("金额不能为空！");
			TheForm.price.focus();
			return(false);
		} 

	}
	

</script>
</head>

<body>
<form action="sup_add.jsp?command=add" method="post" name="form1" id="form1">
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr align="center">
      <td><h1>添加受款单位</h1></td>
    </tr>
  </table>
  <table width="70%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999" align="center">
    <tr bgcolor="f1f1f1"> 
      <td width="19%">受款单位：</td>
      <td width="81%"><input name="name" type="text" id="name" size="60"></td>
    </tr>
    <tr bgcolor="f1f1f1"> 
      <td width="19%">开户行地址：</td>
      <td width="81%"><input name="bank" type="text" id="bank" size="60"></td>
    </tr>
    <tr bgcolor="f1f1f1"> 
      <td width="19%">账户名称：</td>
      <td width="81%"><input name="creditname" type="text" id="creditname" size="60"></td>
    </tr>
    <tr bgcolor="f1f1f1"> 
      <td width="19%">银行账户：</td>
      <td width="81%"><input name="creditcard" type="text" id="creditcard" size="60"></td>
    </tr>
  </table>
  <br>
			<div align="center">
				<input name="Submit" type="submit" value="保存">
				&nbsp;&nbsp;&nbsp;
				<input name="button" type="button" value="返回" onclick="goBack();">
			</div>
</form>
</body>
</html>
