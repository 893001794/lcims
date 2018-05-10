<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="javax.mail.Folder"%>
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String dept = request.getParameter("area");
if(dept == null){
dept ="1";
}
List<Quotation> list = new ArrayList<Quotation>();
float[] f;
f = FinanceQuotationAction.getInstance().getPayFinance(dept,list);
//System.out.println(list+"------------");
  session.setAttribute("financeQ",list);
  session.setAttribute("total",f);
 %>
 
<html>
<head>
<title>已收单未收款</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script src="../../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../../javascript/suggest.js"></script>
		<script src="../../javascript/orderscript.js"></script>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" href="../../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
<script language="javascript">

<!--
function showquotationlog(pid) {
	window.open("quotationlog.jsp?pid=" + pid);
}

function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../financeManage";
	}
}

    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
	    	var search =document.getElementById("search");
	    	search.submit();
    }
    

function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
  function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../payFinanceExport";
	}
}
    
</script>
</head>
<body>
<br>
<h4 align="center">财务报价单统计</h4>
<form name ="search" id ="search" action="payFinance.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	<tr>
		部门：
		<select name ="area" id ="area" onChange="Change_Select();">
			<option value="1" <%="1".equals(dept)?"selected":"" %>>销售一部</option>
			<option value="2" <%="2".equals(dept)?"selected":"" %>>销售二部</option>
		</select>
		<input name="export" value="导出到Excel" type="button" onClick="exportToExcel();" />
			&nbsp;&nbsp;
	</tr>
</table>
</form>
  <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
    	  <td align="center" valign="middle">所属时期(收单日期)</td>
	      <td align="center" valign="middle">报价单号</td>
	      <td  align="center" valign="middle">销售</td>
	      <td  align="center" valign="middle" width="200px" style="width: 200px">客户名称</td>
	      <td  align="center" valign="middle">报价金额</td>
	      <td  align="center" valign="middle">预收款</td>
		  <td  align="center" valign="middle">预收款时间</td>
		  <td  align="center" valign="middle">二次收款</td>
		  <td  align="center" valign="middle">二次预收款时间</td>
		  <td  align="center" valign="middle">尾次收款</td>
		  <td  align="center" valign="middle">尾次收款时间</td>
		  <td  align="center" valign="middle">欠款金额</td>
    </tr>
 	 <%
    for(int i=0;i<list.size();i++) {
    	Quotation qt = list.get(i);
    	String str="";
    	UserForm sales = UserAction.getInstance().getUserByName(qt.getSales());
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
    	<td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy.MM").format(qt.getConfirmtime())%></td>
    	<td><a href="javascript:showquotationlog('<%=qt.getPid() %>');"><%=qt.getPid() %></a></td>
     	 <td><%=qt.getSales() %></td>
      <td width="400px"><%=qt.getClient() %></td>
      <td><%=str%><%=qt.getTotalprice() %></td>
      <td><%=qt.getPreadvance()%></td>
      <td><%=qt.getPaytime()==null?"":qt.getPaytime()%></td>
      <td><%=qt.getSepay()%></td>
      <td><%=qt.getSepaytime()==null?"":qt.getSepaytime()%></td>
      <td><%=qt.getBalance()%></td>
      <td><%=qt.getBalancetime()==null?"":qt.getBalancetime()%></td>
      <td><%=qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance())%></td>
    </tr>
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
