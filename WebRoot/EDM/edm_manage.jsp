<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.quotation.EdmAction"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%
	request.setCharacterEncoding("GBK");
	Set set=EdmAction.getInstance().getAllQC();
	String month=request.getParameter("month");
	//年份
	String year =request.getParameter("year");
	
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date()).substring(2,4);
	}
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());
}
%>

<html>
	<head>
		<title>环境统计表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css"
			media="screen">
  <script language="JavaScript" type="text/JavaScript">
		function showdialog(start,year,month) {
			window.showModalDialog("show_edmqc.jsp?userId=" + start+"&year="+year+"&month="+month,"","dialogWidth:500px;dialogHeight:300px");
		}
		function searchsales(){
		   var myform =document.getElementById("form1");
			myform.action ="edm_manage.jsp";
			myform.submit();
		}
  </script>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" id ="form1" method="post" action="edm_manage.jsp" >
		<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">

	<tr>
	<td>
		年份：<select name ="year" id ="year" onchange="searchsales();">
			<option value="10" <%=("10").equals(year)?"selected":"" %>>2010</option>
			<option value="11" <%=("11").equals(year)?"selected":"" %>>2011</option>
			<option value="12" <%=("12").equals(year)?"selected":"" %>>2012</option>
			<option value="13" <%=("13").equals(year)?"selected":"" %>>2013</option>
			<option value="14" <%=("14").equals(year)?"selected":"" %>>2014</option>
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
		</td>
	</tr>
</table>
		<table width="98%" border="1" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					采样员状态统计
				</th>
			</tr>
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					采样员
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						A
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						B
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						C
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						D
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						E
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						F
					</div>
				</td>
			</tr>
			<%
			Iterator it =set.iterator();
			while(it.hasNext()){
	            String temp = it.next().toString();
	            String name =EdmAction.getInstance().getUserName(Integer.parseInt(temp));
	            %>
	            <tr>
	            	<td align="center"><a href="javascript:showdialog('<%=temp%>','<%=year%>','<%=month %>');"><%=name %></a></td>
	            	<%
	            		List list=EdmAction.getInstance().getTypeByUserId(temp,year,month);
	            		for(int i=0;i<list.size();i++){
	            		%>
	            		<td align="center"><%=list.get(i).toString()%></td>
	            		<%
	            		}
	            	 %>
	            </tr>
	            <%
	     		}            
			
			 %>
		</table>
	</form>
	</body>
</html>