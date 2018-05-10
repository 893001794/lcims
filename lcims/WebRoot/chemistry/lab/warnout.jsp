<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
 
<%
	List<Project> cps = ChemProjectAction.getInstance().getWarnAndOut();
 %>
 
<html>
<head>
<title>预警与外包项目</title>
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
<h4 align="center">预警与外包项目</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td width="10%" align="center" valign="middle">项目等级</td>
      <td width="25%" align="center" valign="middle">报告编号</td>
      <td width="25%" align="center" valign="middle">应出报告时间</td>
      <td width="10%" align="center" valign="middle">外包</td>
      <td width="30%" align="center" valign="middle">项目预警备注</td>
    </tr>
    
    <%
    for(int i=0;i<cps.size();i++) {
    	Project p = cps.get(i);
    	ChemProject cp = (ChemProject)p.getObj();
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=p.getLevel() %></td>
      <td><%=p.getRid() %></td>
      <td><%=cp.getRptime() %></td>
      <td><%=p.getIsout() %></td>
      <td><%=cp.getWarning()==null?"":cp.getWarning() %></td>
    </tr>
    
    <%
    }
     %>
  </table>
  <br>
  <br>
  <br>
</body>
</html>
