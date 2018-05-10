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
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%
request.setCharacterEncoding("UTF-8");
String command = request.getParameter("command");

String month=request.getParameter("month");
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



List list = new ArrayList();
list =PhyProjectAction.getInstance().getPhyStatus(year,month,"");
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
	myform.action ="right.jsp";
	myform.submit();
	}
	
	
	function showdialog(sid) {
		window.showModalDialog("../../chemistry/projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}
//-->
</script>
</head>
<body>
<br>
<h4 align="center">电子电器项目状态</h4>
<form name ="search" id ="search" action="financequotationexport2.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	
	<tr>
	<td>
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

	<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td  align="center" valign="middle">报价单编号</td>
	  <td  align="center" valign="middle">报告编号</td>
	  <td  align="center" valign="middle">项目</td>
	  <td  align="center" valign="middle">测试内容</td>
	  <td  align="center" valign="middle">创建人</td>
	  <td  align="center" valign="middle" width="10%">项目状态</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	List temp =(List)list.get(i);
    	for(int j=0;j<temp.size();j++){
    	Project p= (Project)temp.get(j);
    	PhyProject phy=(PhyProject)p.getObj();
     %>
    
      <tr align=center valign=middle bgcolor="white"> 
	      <td><%=p.getPid()%></td>
	      <td width="400px"><a href="javascript:showdialog('<%=p.getSid()%>');"><%=p.getRid()%></a></td>
	      <td width="400px"><%=p.getPtype()%></td>
	      <td width="400px"><%=p.getTestcontent()%></td>
	      <td width="400px"><%=p.getBuildname()%></td>
	      <td><%=phy.getStatus()%></a></td>
     </tr>
    
    <%
    }
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
