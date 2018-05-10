<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.quotation.BillsForm"%>
<%@page import="com.lccert.crm.quotation.BillsCountForm"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%
	request.setCharacterEncoding("GBK");
	String start=request.getParameter("start");
%>

<html>
	<head>
		<title>测试容量</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css"
			media="screen">
		<script language="JavaScript" type="text/JavaScript">
	function showdialog(start) {
	window.self.location = "showbills_manage.jsp?start=" + start;
		//window.showModalDialog("showbills_manage.jsp?start=" + start,"","dialogWidth:1000px;dialogHeight:700px");
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="post"
			action="quotation_confirm.jsp">

		</form>
		<table width="98%" border="1" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					测试容量设计日程表
				</th>
			</tr>
			
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					报告编号
						
					</div>
				</td>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					测试内容
						
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						测试实验室
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						测试类型
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						是否外包
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						测试机构
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						项目等级
					</div>
				</td>
			</tr>
			<%
				List list=ProjectAction.getInstance().findAllToDate(start);
				for(int i=0;i<list.size();i++){
					Project p=(Project)list.get(i);
					%>
				<tr>
					<td><%=p.getRid() %></td>
					<td><%=p.getTestcontent() %></td>
					<td><%=p.getLab()%></td>
					<td><%=p.getPtype() %></td>
					<td><%=p.getIsout() %></td>
					<td><%=p.getType()%></td>
					<td><%=p.getLevel()%></td>
				</tr>
					<%
				}
			 %>
			
		</table>