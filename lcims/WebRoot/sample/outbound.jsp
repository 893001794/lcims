<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String strId =request.getParameter("id");
	System.out.println(strId+":strId");
	String status =request.getParameter("status");
	status=new String (status.getBytes("ISO-8859-1"),"GBK");
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加报价单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script type="text/javascript" src="../javascript/jquery-1.3.2.min.js" ></script>
		<script type="text/javascript" src="../javascript/mln.colselect.js"></script>
        <link href="../css/mln-main.css" rel="stylesheet" type="text/css" charset="utf-8" />
        <!-- 调用日期样式 -->
        <script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link href="../css/mln.colselect.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
		function checkForm(){
		var tpplication =document.getElementById("tpplication").value;
		if(tpplication ==""){
		alert("请输入样品出库的用途！！！");
		return false;
		}
		//var myform=document.getElementById("myform");
		myform.action="outbound_post.jsp?strId=<%=strId%>&status=<%=status%>";
		myform.submit();
		window.close();
		}
		</script>
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
.hid {
	display: none;
}
</style>
<script type="text/javascript">
	
</script>
	</head>
	<body class="body1">
		<form method="post" name="myform" id="myform" action="outbound_post.jsp?strId=<%=strId%>&status=<%=status%>" onSubmit="return checkForm(this)">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="20%">
						样品<%=status%>时间：
					</td>
					<td>
						<input size="40" name ="outdatetime" id="outdatetime" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%>"/>
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'outdatetime'})" src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
					</td>
				</tr>

				<tr>
					<td>
						样品用途：
					</td>
					<td>
					<textarea rows="5" cols="10" name="tpplication" id="tpplication" style="width: 60%"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><input type="button" onClick="checkForm();" value="提交"></td>
				</tr>
			</table>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
