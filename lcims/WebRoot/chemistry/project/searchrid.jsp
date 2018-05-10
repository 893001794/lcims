<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String parent  = request.getParameter("parent");
String child  = request.getParameter("child");
String describe  = request.getParameter("describe");
String planC  = request.getParameter("planC");
String planE  = request.getParameter("planE");
String cnas  = request.getParameter("cnas");
if(cnas == null){
cnas="";
}
//System.out.println("测试大类："+parent+"--测试小类:"+child+"--项目描述："+describe);



List<Flow> list = new ArrayList<Flow>();
if(command != null && "search".equals(command)) {
	list =FlowAction.getInstance().getRidByProject(parent,child,describe,planC,planE,cnas);
}

 %>
 
<html>
<head>
<title>月结客户项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
<script src="../../javascript/jquery.autocomplete.js"></script> 
<script language="javascript">
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
<h4 align="center">按项目查询报告</h4>
<form action="searchrid.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	<tr>
		<td>测试大类:
			<input name="parent" type="text" id="parent" size="20" maxlength="50" value="<%=parent==null?"":parent%>">
	      	&nbsp;&nbsp;
	      	测试小类:
			<input name="child" type="text" id="child" size="20" maxlength="50" value="<%=child==null?"":child%>">
	      	&nbsp;&nbsp;
	      	项目描述:
			<input name="describe" type="text" id="describe" size="20" maxlength="50" value="<%=describe==null?"":describe%>">
	      	&nbsp;&nbsp;
	      	方法中文说明:
			<input name="planC" type="text" id="planC" size="20" maxlength="50" value="<%=planC==null?"":planC%>">
	      	&nbsp;&nbsp;
	      	方法英文文说明:
			<input name="planE" type="text" id="planE" size="20" maxlength="50" value="<%=planE==null?"":planE%>">
	      	&nbsp;&nbsp;
			<input name="cnas" type="checkbox"" id="cnas" size="20" maxlength="50" value="y" <%=cnas.equals("y")?"checked":"" %>>
	      	CNAS
			<input name="button" value="统计" type="submit" />
		</td>
	</tr>
</table>
</form>

		<p>
			&nbsp;
		</p>

  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td align="center" valign="middle">报告号</td>
      <td  align="center" valign="middle">测试大类</td>
      <td  align="center" valign="middle">测试小类</td>
      <td  align="center" valign="middle">项目描述</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Flow flow = list.get(i);
    	
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=flow.getRid() %></td>
      <td><%=flow.getTestparent() %></td>
      <td><%=flow.getTestchild()%></td>
      <td><%=flow.getDescribe() %></td>
    </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
