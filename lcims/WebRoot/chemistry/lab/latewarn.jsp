<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.project.Project"%>
 
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	float latepercent = 0;
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	List<Project> list = null;

	list = LabAction.getInstance().getWarnProject();
 %>
 
<html>
<head>
<title>迟单项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--

function showdialog(sid) {
		window.showModalDialog("../projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}

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
<h4 align="center">迟单项目</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td  align="center" valign="middle">项目等级</td>
      <td  align="center" valign="middle">报告编号</td>
      <td  align="center" valign="middle">送实验室时间</td>
      <td  align="center" valign="middle">应出报告时间</td>
	  <td  align="center" valign="middle">项目状态</td>
	  <td  align="center" valign="middle">客服人员</td>
	  <td  align="center" valign="middle">操作</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Project p = list.get(i);
    	ChemProject cp = (ChemProject)p.getObj();
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=p.getLevel() %></td>
      <td><a href="../project/projectdetail.jsp?sid=<%=p.getSid() %>"><%=p.getRid() %></a></td>
      <td><%=cp.getCreatetime() %></td>
      <td><%=cp.getRptime() %></td>
      <td><%=cp.getStatus() %></td>
      <td><%=cp.getServname() %></td>
      <td><a href="javascript:showdialog('<%=p.getSid() %>');">进度</a></td>
    </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
