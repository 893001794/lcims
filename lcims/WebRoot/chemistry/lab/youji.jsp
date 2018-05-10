<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.lab.Youji"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
 
<%
	Youji y = LabAction.getInstance().getYouji();
 %>
 
<html>
<head>
<title>实验室状态</title>
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
  <h4 align="center">有机制备状态</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">项目等级</td>
      <td width="33%" align="center" valign="middle">项目数量</td>
      <td width="34%" align="center" valign="middle">有机测试点接单总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=y.getPcount0() %></td>
      <td><%=y.getPyou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=y.getPcount1() %></td>
      <td><%=y.getPyou1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=y.getPcount2() %></td>
      <td><%=y.getPyou2() %></td>
      
    </tr>
  </table>
<br>
<h4 align="center">有机前处理状态</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">项目等级</td>
      <td width="33%" align="center" valign="middle">项目数量</td>
      <td width="34%" align="center" valign="middle">有机测试点接单总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=y.getBcount0() %></td>
      <td><%=y.getByou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=y.getBcount1() %></td>
      <td><%=y.getByou1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=y.getBcount2() %></td>
      <td><%=y.getByou2() %></td>
    </tr>
  </table>
    <br>
  <h4 align="center">有机仪器状态</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">项目等级</td>
      <td width="33%" align="center" valign="middle">项目数量</td>
      <td width="34%" align="center" valign="middle">有机测试点接单总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=y.getIcount0() %></td>
      <td><%=y.getIyou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=y.getIcount1() %></td>
      <td><%=y.getIyou1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=y.getIcount2() %></td>
      <td><%=y.getIyou2() %></td>
      
    </tr>
  </table>
       <br>
  <h4 align="center">有机未完成点数总数</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="33%" align="center" valign="middle">项目等级</td>
      <td width="33%" align="center" valign="middle">项目数量</td>
      <td width="34%" align="center" valign="middle">有机未完成测试点总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=y.getPcount0() + y.getBcount0() + y.getIcount0() %></td>
      <td><%=y.getPyou0() + y.getByou0() + y.getIyou0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=y.getBcount1() + y.getPcount1() + y.getIcount1() %></td>
      <td><%=y.getPyou1() + y.getByou1() + y.getIyou1() %></td>
      
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=y.getPcount2() + y.getBcount2() + y.getIcount2() %></td>
      <td><%=y.getPyou2() + y.getByou2() + y.getIyou2() %></td>
      
    </tr>
  </table>
  <br>
  <br>
</body>
</html>
