<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK" %>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.lab.Wuji"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
 
<%
	Wuji w = LabAction.getInstance().getWuji();
 %>
 
<html>
<head>
<title>ʵ����״̬</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>
<body>

<br>
    <br>
  <h4 align="center">�޻��Ʊ�״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�޻����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=w.getPcount0() %></td>
      <td><%=w.getPwu0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=w.getPcount1() %></td>
      <td><%=w.getPwu1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=w.getPcount2() %></td>
      <td><%=w.getPwu2() %></td>
      
    </tr>
  </table>
<br>
<h4 align="center">�޻�ǰ����״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�޻����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=w.getBcount0() %></td>
      <td><%=w.getBwu0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=w.getBcount1() %></td>
      <td><%=w.getBwu1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=w.getBcount2() %></td>
      <td><%=w.getBwu2() %></td>
    </tr>
  </table>
    <br>
  <h4 align="center">�޻�����״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�޻����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=w.getIcount0() %></td>
      <td><%=w.getIwu0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=w.getIcount1() %></td>
      <td><%=w.getIwu1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=w.getIcount2() %></td>
      <td><%=w.getIwu2() %></td>
      
    </tr>
  </table>
       <br>
  <h4 align="center">�޻�δ��ɵ�������</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�޻�δ��ɲ��Ե�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=w.getPcount0() + w.getBcount0() + w.getIcount0() %></td>
      <td><%=w.getPwu0() + w.getBwu0() + w.getIwu0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=w.getBcount1() + w.getPcount1() + w.getIcount1() %></td>
      <td><%=w.getPwu1() + w.getBwu1() + w.getIwu1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=w.getPcount2() + w.getBcount2() + w.getIcount2() %></td>
      <td><%=w.getPwu2() + w.getBwu2() + w.getIwu2() %></td>
      
    </tr>
  </table>
  <br>
  <br>
</body>
</html>
