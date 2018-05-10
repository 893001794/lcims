<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.quotation.EdmAction"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>

<%
	request.setCharacterEncoding("GBK");
	String userId =request.getParameter("userId");
	String year =request.getParameter("year");
	String month =request.getParameter("month");
	List rows =EdmAction.getInstance().getAllByUserId(userId,year,month);
%>

<html>
	<head>
		<title>状态明细表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css"
			media="screen">
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="post"
			action="quotation_confirm.jsp">

		</form>
		<table width="98%" border="1" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					采样员状态明细表
				</th>
			</tr>
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					报价单
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
					采样员
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						状态
					</div>
				</td>
			</tr>
			<%
				for(int i =0;i<rows.size();i++){
					List colums=(List)rows.get(i);
	            %>
	            <tr>
	            	<%
	            		for(int j=0;j<colums.size();j++){
	            		%>
	            		<td align="center"><%=colums.get(j).toString()%></td>
	            		<%
	            		}
	            	 %>
	            </tr>
	            <%
	     		}            
			
			 %>
		</table>