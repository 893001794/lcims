<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>

<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../../comman.jsp"%>
 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String client  = request.getParameter("client");
String seleYear =request.getParameter("seleyear");
String seleMonth =request.getParameter("selemonth");


String c="";
if(client !=null && !"".equals(client)){
  c =new String (request.getParameter("sClient").getBytes("ISO-8859-1"),"GBK");
}

//String year =request.getParameter("year");
//String month =request.getParameter("month");
//System.out.println(year);
//System.out.println(month);
Date date =new Date ();

if(seleYear == null || "".equals(seleYear)){
   seleYear = new SimpleDateFormat("yyyy").format(date); //获取年份
}if(seleMonth == null || "".equals(seleMonth)){
	seleMonth =new SimpleDateFormat("MM").format(date); //获取月份
}

List<Quotation> list = new ArrayList<Quotation>();
if(command != null && "search".equals(command)) {
	List<ClientForm> clients = ClientAction.getInstance().getClientInMonth(client);
	if(clients.size() != 0) {
		list = QuotationAction.getInstance().getPidByClientName(client,seleYear,seleMonth);
		session.setAttribute("clientprojects",list);
	}
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
<!--
function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../clientprojects";
	}
}


function weekToExcel(obj) {
	if(confirm("确定导出?")) {
		window.self.location = "../../weekstatistics?status="+obj;
	}
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
<h4 align="center">月结客户项目统计</h4>
<form action="clientproject.jsp?command=search&year=<%=seleYear %>&month=<%=seleMonth %>&sClient=<%=client%>" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	<tr>
		<td>客户名称:
			<input name="client" type="text" id="client" size="20" maxlength="50" value="<%=c %>">
			<script>   
						        $("#client").autocomplete("../../client_month_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
	      	&nbsp;&nbsp;
      		年份：<select name ="seleyear" id ="seleyear">
      			<option value="2010" <%=seleYear.equals("2010")?"selected":"" %>>2010</option>
      			<option value="2011" <%=seleYear.equals("2011")?"selected":"" %>>2011</option>
      			<option value="2012" <%=seleYear.equals("2012")?"selected":"" %>>2012</option>
      			<option value="2013" <%=seleYear.equals("2013")?"selected":"" %>>2013</option>
      			<option value="2014" <%=seleYear.equals("2014")?"selected":"" %>>2014</option>
      		</select>
      		&nbsp;&nbsp;
      		月份：<select name ="selemonth" id ="selemonth">
      			<option value="01" <%=seleMonth.equals("01")?"selected":"" %>>01</option>
      			<option value="02" <%=seleMonth.equals("02")?"selected":"" %>>02</option>
      			<option value="03" <%=seleMonth.equals("03")?"selected":"" %>>03</option>
      			<option value="04" <%=seleMonth.equals("04")?"selected":"" %>>04</option>
      			<option value="05" <%=seleMonth.equals("05")?"selected":"" %>>05</option>
      			<option value="06" <%=seleMonth.equals("06")?"selected":"" %>>06</option>
      			<option value="07" <%=seleMonth.equals("07")?"selected":"" %>>07</option>
      			<option value="08" <%=seleMonth.equals("08")?"selected":"" %>>08</option>
      			<option value="09" <%=seleMonth.equals("09")?"selected":"" %>>09</option>
      			<option value="10" <%=seleMonth.equals("10")?"selected":"" %>>10</option>
      			<option value="11" <%=seleMonth.equals("11")?"selected":"" %>>11</option>
      			<option value="12" <%=seleMonth.equals("12")?"selected":"" %>>12</option>
      		</select>
			<input name="button" value="统计" type="submit" />
			&nbsp;
			<input name="export" value="导出到Excel" type="button" onclick="exportToExcel();" />
			<%
			if((user.getDept().equals("客服部")&&user.getCompany().equals("东莞"))||user.getId()==103){
			 %>
			&nbsp;
			<input name="export" value="导出一周报告" type="button" onclick="weekToExcel('report');" />
			&nbsp;
			<input name="export" value="导出一周迟单" type="button" onclick="weekToExcel('late');" />
			&nbsp;
			<input name="export" value="导出一周客户" type="button" onclick="weekToExcel('client');" />
			<%
			}  if(user.getName().equals("甘敏凤[Min]")||user.getId()==103){
			%>
			&nbsp;
			<input name="export" value="导出排单量" type="button" onclick="weekToExcel('createname');" />
			<%
			} 
			%>
		</td>
	</tr>
</table>
</form>

		<p>
			&nbsp;
		</p>

  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td align="center" valign="middle">客户名称</td>
      <td  align="center" valign="middle">报价单号</td>
      <td  align="center" valign="middle">报告号</td>
      <td  align="center" valign="middle">分项目价格</td>
      <td  align="center" valign="middle">项目内容</td>
      <td  align="center" valign="middle">样品名称</td>
      <td  align="center" valign="middle">测试时间</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Quotation qt = list.get(i);
    	List<Project> lps = ChemProjectAction.getInstance().getChemProjectByPid(qt.getPid(),"");
    	for(int j=0;j<lps.size();j++) {
    		Project p = lps.get(j);
    		ChemProject cp =(ChemProject)p.getObj();
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=qt.getClient() %></td>
      <td><%=p.getPid() %></td>
      <td><%=p.getRid() %></td>
      <td><%=p.getPrice() %></td>
      <td><%=p.getTestcontent()%></td>
      <td><%=cp.getSamplename() %></td>
      <td><%=p.getBuildtime() %>
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
