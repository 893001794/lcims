<%@ page contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
 <%@ page errorPage="../../error.jsp" %>
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
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%
request.setCharacterEncoding("UTF-8");
String command = request.getParameter("command");

String month=request.getParameter("month");

String itemNumber=request.getParameter("itemNumber");
//年份
String year =request.getParameter("year");
if(year ==null ){
SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
year=sdf.format(new Date());
}

if(month ==null){
SimpleDateFormat sdf =new SimpleDateFormat("MM");
month=sdf.format(new Date());
}



float[] f;
List<Quotation> list = new ArrayList<Quotation>();
f=PhyProjectAction.getInstance().getPhyProjectInfor(year,month,itemNumber,list);
session.setAttribute("financequotation2",list);
session.setAttribute("total",f);
 %>
 
<html>
<head>
<title>电子电器项目统计</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--
function showquotationlog(pid) {
	window.open("quotationlog.jsp?pid=" + pid);
}

function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../financequotation2";
	}
}

function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}



function searchsales(){
   var myform =document.getElementById("search");
	myform.action ="phpInfo.jsp";
	myform.submit();
	}
//-->
</script>
</head>
<body>
<br>
<h4 align="center">电子电器项目统计</h4>
<form name ="search" id ="search" action="financequotationexport2.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	
	<tr>
	<td>
	<input type="hidden" value="<%=itemNumber %>" name ="itemNumber" id ="itemNumber" >
	年份：<select name ="year" id ="year" onchange="searchsales();">
			<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
			<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
			<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
			<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
			<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
		</select>
		月份：<select name ="month" id ="month" onchange="searchsales();">
			<option value="01" <%="01".equals(month)?"selected":""%>>1</option>
			<option value="02" <%="02".equals(month)?"selected":""%>>2</option>
			<option value="03" <%="03".equals(month)?"selected":""%>>3</option>
			<option value="04" <%="04".equals(month)?"selected":""%>>4</option>
			<option value="05" <%="05".equals(month)?"selected":""%>>5</option>
			<option value="06" <%="06".equals(month)?"selected":""%>>6</option>
			<option value="07" <%="07".equals(month)?"selected":""%>>7</option>
			<option value="08" <%="08".equals(month)?"selected":""%>>8</option>
			<option value="09" <%="09".equals(month)?"selected":""%>>9</option>
			<option value="10" <%="10".equals(month)?"selected":""%>>10</option>
			<option value="11" <%="11".equals(month)?"selected":""%>>11</option>
			<option value="12" <%="12".equals(month)?"selected":""%>>12</option>
		</select>
	
		</td></tr>
</table>
</form>

	<table align="center" width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
		<tr bgcolor="dddddd"> 
		
			<td align="center" valign="middle">报价起始时间</td>
			<td align="center" valign="middle">收单起始时间</td>
			<td align="center" valign="middle">订单总额</td>
			<td align="center" valign="middle">机构费</td>
		</tr>
		<tr bgcolor="white"> 
			<td align="center" valign="middle">
			
			</td>
			<td align="center" valign="middle">
			
			</td>
			<td align="center" valign="middle"><%=f[1] %></td>
			<td align="center" valign="middle"><%=f[0] %></td>
		</tr>
	</table>

<p>&nbsp;</p>
  <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td  align="center" valign="middle">报价单编号</td>
	  <td  align="center" valign="middle">项目名称</td>
	  <td  align="center" valign="middle">项目代码</td>
	  <td  align="center" valign="middle">总金额</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Quotation qt = list.get(i);
    	Item item =(Item)qt.getObj();
     %>
    
      <tr align=center valign=middle bgcolor="white"> 
	      <td>	<a href="../../kis/orderdetail.jsp?id=<%=item.getId() %>"><%=qt.getPid()%></a></td>
	      <td><%=item.getName()%></td>
	      <td width="400px"><%=item.getItemNumber()%></td>
	      <td><%=qt.getTotalprice()%></a></td>
     </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
