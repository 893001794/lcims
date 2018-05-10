<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.lab.SourceStatis"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
 
<%
	SourceStatis ss = LabAction.getInstance().getSourceStatics(); 
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


<h4 align="center">全部未完成项目</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="20%" align="center" valign="middle">项目等级</td>
      <td width="20%" align="center" valign="middle">项目数量</td>
      <td width="20%" align="center" valign="middle">无机测试点接单总数</td>
      <td width="20%" align="center" valign="middle">有机测试点接单总数</td>
      <td width="20%" align="center" valign="middle">食品级成品测试点总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=ss.getCount0() %></td>
      <td><%=ss.getWu0() %></td>
      <td><%=ss.getYou0() %></td>
      <td><%=ss.getFood0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=ss.getCount1() %></td>
      <td><%=ss.getWu1() %></td>
      <td><%=ss.getYou1() %></td>
      <td><%=ss.getFood1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=ss.getCount2() %></td>
      <td><%=ss.getWu2() %></td>
      <td><%=ss.getYou2() %></td>
      <td><%=ss.getFood2() %></td>
    </tr>
  </table>
  <br>
  <h4 align="center">单日接单统计</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="20%" align="center" valign="middle">项目等级</td>
      <td width="20%" align="center" valign="middle">项目数量</td>
      <td width="20%" align="center" valign="middle">无机测试点接单总数</td>
      <td width="20%" align="center" valign="middle">有机测试点接单总数</td>
      <td width="20%" align="center" valign="middle">食品级成品测试点总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=ss.getTcount0() %></td>
      <td><%=ss.getTwu0() %></td>
      <td><%=ss.getTyou0() %></td>
      <td><%=ss.getTfood0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=ss.getTcount1() %></td>
      <td><%=ss.getTwu1() %></td>
      <td><%=ss.getTyou1() %></td>
      <td><%=ss.getTfood1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=ss.getTcount2() %></td>
      <td><%=ss.getTwu2() %></td>
      <td><%=ss.getTyou2() %></td>
      <td><%=ss.getTfood2() %></td>
    </tr>
  </table>

    <br>
  <h4 align="center">报告编辑状态</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="20%" align="center" valign="middle">项目等级</td>
      <td width="20%" align="center" valign="middle">项目数量</td>
      <td width="20%" align="center" valign="middle">无机测试点接单总数</td>
      <td width="20%" align="center" valign="middle">有机测试点接单总数</td>
      <td width="20%" align="center" valign="middle">食品级成品测试点总数</td>
    </tr>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td>普通</td>
      <td><%=ss.getNcount0() %></td>
      <td><%=ss.getNwu0() %></td>
      <td><%=ss.getNyou0() %></td>
      <td><%=ss.getNfood0() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>加急</td>
      <td><%=ss.getNcount1() %></td>
      <td><%=ss.getNwu1() %></td>
      <td><%=ss.getNyou1() %></td>
      <td><%=ss.getNfood1() %></td>
    </tr>
    <tr align=center valign=middle bgcolor="white"> 
      <td>特急</td>
      <td><%=ss.getNcount2() %></td>
      <td><%=ss.getNwu2() %></td>
      <td><%=ss.getNyou2() %></td>
      <td><%=ss.getNfood2() %></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</body>
</html>
