<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.chemistry.lab.Shipin"%>
 
<%
	Shipin s = LabAction.getInstance().getShipin();
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
  <h4 align="center">ʳƷ���Ʊ�״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">ʳƷ�����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=s.getPcount0() %></td>
      <td><%=s.getPshi0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=s.getPcount1() %></td>
      <td><%=s.getPshi1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=s.getPcount2() %></td>
      <td><%=s.getPshi2() %></td>
      
    </tr>
  </table>
<br>
<h4 align="center">ʳƷ��ǰ����״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">ʳƷ�����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=s.getBcount0() %></td>
      <td><%=s.getBshi0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=s.getBcount1() %></td>
      <td><%=s.getBshi1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=s.getBcount2() %></td>
      <td><%=s.getBshi2() %></td>
    </tr>
  </table>
    <br>
  <h4 align="center">ʳƷ������״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�л����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=s.getIcount0() %></td>
      <td><%=s.getIshi0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=s.getIcount1() %></td>
      <td><%=s.getIshi1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=s.getIcount2() %></td>
      <td><%=s.getIshi2() %></td>
      
    </tr>
  </table>
       <br>
  <h4 align="center">ʳƷ��δ��ɵ�������</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�л�δ��ɲ��Ե�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=s.getPcount0() + s.getBcount0() + s.getIcount0() %></td>
      <td><%=s.getPshi0() + s.getBshi0() + s.getIshi0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=s.getBcount1() + s.getPcount1() + s.getIcount1() %></td>
      <td><%=s.getPshi1() + s.getBshi1() + s.getIshi1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=s.getPcount2() + s.getBcount2() + s.getIcount2() %></td>
      <td><%=s.getPshi2() + s.getBshi2() + s.getIshi2() %></td>
      
    </tr>
  </table>
  <br>
  <br>
</body>
</html>
