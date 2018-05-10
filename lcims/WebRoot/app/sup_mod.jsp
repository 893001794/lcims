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
	int id = 0;
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		out.println("��ѡ����Ҫ�޸ĵ��ܿλ��");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	id = Integer.parseInt(strid);
	
	
	
	String command = request.getParameter("command");
	
	if(command != null && "mod".equals(command)) {
		String name = request.getParameter("name");
		String bank = request.getParameter("bank");
		String creditname = request.getParameter("creditname");
		String creditcard = request.getParameter("creditcard");
		
		Supplier  sl = new Supplier();
		sl.setId(id);
		sl.setName(name);
		sl.setBank(bank);
		sl.setCreditname(creditname);
		sl.setCreditcard(creditcard);
		if(ApplicationAction.getInstance().modifySuppier(sl)) {
			out.println("�޸ĳɹ�");
			out.println("<a href='sup_main.jsp'>����</a>");
			return;
		}
	}
	
	Supplier sup = ApplicationAction.getInstance().getSupplierById(id);
 %>


<html>
<head>
<title>�޸��ܿλ</title>
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
			alert ("��Ʊ���벻��Ϊ�գ�");
			TheForm.vid.focus();
			return(false);
		}

		if (trim(TheForm.icode.value) == "") {
			alert ("��Ʊ���벻��Ϊ�գ�");
			TheForm.icode.focus();
			return(false);
		} 
		
		if (trim(TheForm.icode.value).length != 8) {
			alert ("��Ʊ����ӦΪ8λ���֣�");
			TheForm.icode.focus();
			return(false);
		} 
		
		if (trim(TheForm.price.value) == "") {
			alert ("����Ϊ�գ�");
			TheForm.price.focus();
			return(false);
		} 

	}
	

</script>
</head>

<body>
<form action="sup_mod.jsp?command=mod" method="post" name="form1" id="form1">
<input name="id" value="<%=sup.getId() %>" type="hidden" />
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr align="center">
      <td><h1>�޸��ܿλ</h1></td>
    </tr>
  </table>
  <table width="70%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999" align="center">
    <tr bgcolor="f1f1f1"> 
      <td width="19%">�ܿλ��</td>
      <td width="81%"><input name="name" type="text" id="name" size="60" value="<%=sup.getName() %>"></td>
    </tr>
    <tr bgcolor="f1f1f1"> 
      <td width="19%">�����е�ַ��</td>
      <td width="81%"><input name="bank" type="text" id="bank" size="60" value="<%=sup.getBank() %>"></td>
    </tr>
    <tr bgcolor="f1f1f1"> 
      <td width="19%">�˻����ƣ�</td>
      <td width="81%"><input name="creditname" type="text" id="creditname" size="60" value="<%=sup.getCreditname() %>"></td>
    </tr>
    <tr bgcolor="f1f1f1"> 
      <td width="19%">�����˻���</td>
      <td width="81%"><input name="creditcard" type="text" id="creditcard" size="60" value="<%=sup.getCreditcard() %>"></td>
    </tr>
  </table>
  <br>
			<div align="center">
				<input name="Submit" type="submit" value="�޸�">
				&nbsp;&nbsp;&nbsp;
				<input name="button" type="button" value="����" onclick="goBack();">
			</div>
</form>
</body>
</html>
