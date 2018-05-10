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
<title>�ٵ���Ŀ</title>
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
<h4 align="center">�ٵ���Ŀ</h4>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td  align="center" valign="middle">��Ŀ�ȼ�</td>
      <td  align="center" valign="middle">������</td>
      <td  align="center" valign="middle">��ʵ����ʱ��</td>
      <td  align="center" valign="middle">Ӧ������ʱ��</td>
	  <td  align="center" valign="middle">��Ŀ״̬</td>
	  <td  align="center" valign="middle">�ͷ���Ա</td>
	  <td  align="center" valign="middle">����</td>
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
      <td><a href="javascript:showdialog('<%=p.getSid() %>');">����</a></td>
    </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
