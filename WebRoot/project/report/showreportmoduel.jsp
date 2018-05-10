<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.report.ReportAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.report.ReportForm"%>
<%@ include file="../../comman.jsp"%>

<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	String strfileid = request.getParameter("fileid");
	int fileid = 4;
	if (strfileid != null && !"".equals(strfileid)) {
		fileid = Integer.parseInt(strfileid);
	}
	List<ReportForm> list = ReportAction.getInstance()
			.getReportListByParentid(fileid);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>选择报告模板</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<style>
body {
	padding-top: 50px;
	padding-left: 100px;
	padding-right: 150px;
}

.fileDiv {
	float: left;
	width: 100px;
	height: 100px;
	font-size: 12px;
	border: 1px solid #cccccc;
	margin-right: 20px;
	margin-bottom: 20px;
	text-decoration: none;
	text-shadow: none;
}

.seled {
	border: 1px solid #ff0000;
	background-color: #D6DFF7;
}

.fileDiv2 {
	border: 1px solid #ff0000;
	background-color: green;
	float: left;
	width: 100px;
	height: 100px;
	font-size: 12px;
	border: 1px solid #cccccc;
	margin-right: 20px;
	margin-bottom: 20px;
	text-decoration: none;
	text-shadow: none;
}
</style>
		<script type="text/javascript">
		function changeStyle(ob) {
			ob.className="fileDiv2";
		}
		
		function defaultStyle(ob) {
			ob.className="fileDiv";
		}
		
		function showreport(ob) {
			with (document.getElementById("form1")) {
				method="post";
				action="showreportmoduel.jsp?fileid=" + ob.name;
				submit();
			}
		}
	</script>
	</head>

	<body class="body1">
		<div align="center">
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="35">
				<tr>
					<td width="522" class="p1" height="17" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>化学项目管理&gt;&gt;化学报告管理&gt;&gt;选择报告模板</b>
					</td>
				</tr>
			</table>

		</div>
		<hr width="100%" align="center" size=0>
		<br>
		<form id="form1" method="post" action="showreportmoduel.jsp">
		<table width=100% border=0 cellspacing=0 cellpadding=0>
			
				<input type="hidden" name="command" value="search">
			<tr>
				<%
					Map<String, String> map = FlowFinal.getInstance().getFileDirect();
					for (String value : map.keySet()) {
				%>
				<td valign=middle>
					<input name="<%=value%>" type="button"
						value="<%=map.get(value)%>" onclick="showreport(this)" />
				</td>

				<%
					}
				%>
			</tr>

		</table>
		<br>
		<hr width="100%" align="center" size=0>
		<table width="100%">
			<tr>
				<%
					for (int i = 0; i < list.size(); i++) {
						ReportForm rf = list.get(i);
						if (i > 0 && i % 9 == 0) {
				%>
			</tr>
			<tr>
				<%
					}
				%>
				<td align="center">
					<a href="javascript:window.open('../../reportexport?sid=<%=sid%>&reportid=<%=rf.getReportid()%>');self.close();"
						name="fileDiv">
						<img src="../../images/doc.png" alt="<%=rf.getReportid()%>&nbsp;&nbsp;<%=rf.getTestcontent().replaceAll("\\+", "、")%>" width="100" height="100" />
						<div style="width:100px;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow: hidden;font-size: 14px;">
						<%=rf.getReportid().subSequence(6,rf.getReportid().length())%>&nbsp;<%=rf.getTestcontent().replaceAll("\\+", "、")%>
						</div>
					</a>
				</td>

				<%
					}
				%>
			</tr>
		</table>
	</body>

</html>
