<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.lab.SourceStatis"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
 
<%
	SourceStatis tf = new SourceStatis();
	SourceStatis ns = new SourceStatis();
	LabAction.getInstance().getTodayFinish(tf);
	LabAction.getInstance().getNotSend(ns);
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
<h4 align="center">������ɱ�������</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="20%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="20%" align="center" valign="middle">��Ŀ����</td>
      <td width="20%" align="center" valign="middle">�޻����Ե�ӵ�����</td>
      <td width="20%" align="center" valign="middle">�л����Ե�ӵ�����</td>
      <td width="20%" align="center" valign="middle">ʳƷ����Ʒ���Ե�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=tf.getTcount0() %></td>
      <td><%=tf.getTwu0() %></td>
      <td><%=tf.getTyou0() %></td>
      <td><%=tf.getTfood0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=tf.getTcount1() %></td>
      <td><%=tf.getTwu1() %></td>
      <td><%=tf.getTyou1() %></td>
      <td><%=tf.getTfood1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=tf.getTcount2() %></td>
      <td><%=tf.getTwu2() %></td>
      <td><%=tf.getTyou2() %></td>
      <td><%=tf.getTfood2() %></td>
    </tr>
  </table>
  <br>
  <h4 align="center">δ������������</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="20%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="20%" align="center" valign="middle">��Ŀ����</td>
      <td width="20%" align="center" valign="middle">�޻����Ե�ӵ�����</td>
      <td width="20%" align="center" valign="middle">�л����Ե�ӵ�����</td>
      <td width="20%" align="center" valign="middle">ʳƷ����Ʒ���Ե�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=ns.getTcount0() %></td>
      <td><%=ns.getTwu0() %></td>
      <td><%=ns.getTyou0() %></td>
      <td><%=ns.getTfood0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=ns.getTcount1() %></td>
      <td><%=ns.getTwu1() %></td>
      <td><%=ns.getTyou1() %></td>
      <td><%=ns.getTfood1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=ns.getTcount2() %></td>
      <td><%=ns.getTwu2() %></td>
      <td><%=ns.getTyou2() %></td>
      <td><%=ns.getTfood2() %></td>
    </tr>
  </table>
  <br>
  <br>
</body>
</html>
