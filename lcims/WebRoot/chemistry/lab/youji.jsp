<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.lab.Youji"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
 
<%
	Youji y = LabAction.getInstance().getYouji();
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
  <h4 align="center">�л��Ʊ�״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�л����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=y.getPcount0() %></td>
      <td><%=y.getPyou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=y.getPcount1() %></td>
      <td><%=y.getPyou1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=y.getPcount2() %></td>
      <td><%=y.getPyou2() %></td>
      
    </tr>
  </table>
<br>
<h4 align="center">�л�ǰ����״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�л����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=y.getBcount0() %></td>
      <td><%=y.getByou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=y.getBcount1() %></td>
      <td><%=y.getByou1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=y.getBcount2() %></td>
      <td><%=y.getByou2() %></td>
    </tr>
  </table>
    <br>
  <h4 align="center">�л�����״̬</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�л����Ե�ӵ�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=y.getIcount0() %></td>
      <td><%=y.getIyou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=y.getIcount1() %></td>
      <td><%=y.getIyou1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=y.getIcount2() %></td>
      <td><%=y.getIyou2() %></td>
      
    </tr>
  </table>
       <br>
  <h4 align="center">�л�δ��ɵ�������</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">��Ŀ�ȼ�</td>
      <td width="33%" align="center" valign="middle">��Ŀ����</td>
      <td width="34%" align="center" valign="middle">�л�δ��ɲ��Ե�����</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>��ͨ</td>
      <td><%=y.getPcount0() + y.getBcount0() + y.getIcount0() %></td>
      <td><%=y.getPyou0() + y.getByou0() + y.getIyou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�Ӽ�</td>
      <td><%=y.getBcount1() + y.getPcount1() + y.getIcount1() %></td>
      <td><%=y.getPyou1() + y.getByou1() + y.getIyou1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>�ؼ�</td>
      <td><%=y.getPcount2() + y.getBcount2() + y.getIcount2() %></td>
      <td><%=y.getPyou2() + y.getByou2() + y.getIyou2() %></td>
      
    </tr>
  </table>
  <br>
  <br>
</body>
</html>
