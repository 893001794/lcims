<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@ include file="../comman.jsp"  %>

<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("myquotation.jsp");
		return;
	}
	
	String command = request.getParameter("command");
	if(command != null && "audit".equals(command)) {
		String auditman = user.getName();
		if(QuotationAction.getInstance().auditQuotation(pid,auditman)) {
		out.println("<div alight=center>");
		out.println("审核成功");
		out.println("<a href='quotation_confirm.jsp'>返回</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("审核不成功，请返回重新审核！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
	}
	
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
	if(qt == null) {
		response.sendRedirect("project_confirm.jsp");
		return;
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>订单审核</title>
		<link rel="stylesheet" href="../css/drp.css">

		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>

		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		
		function modify() {
			window.self.location = "../../quotation/modifyquotation.jsp?pid=<%=qt.getPid() %>";
		}
		
</script>



	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">

		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;销售管理&gt;&gt;审核订单</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" method="post" action="confirm.jsp?command=audit">
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getPid() %>" size="40" />
						</td>

						<td width="17%">
							分公司：
						</td>
						<td width="33%">

							<input type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany() %>" size="40" />
						</td>

					</tr>
					<tr>

						<td>
							销售人员：
						</td>
						<td>
							<input name="rid" type="text" style="background-color: #F2F2F2"
								size="40" readonly="readonly" value="<%=qt.getSales() %>" />
						</td>

						<td>
							立项时间：
						</td>
						<td>
							<input type="text" style="background-color: #F2F2F2" size="40"
								readonly="readonly"
								value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCreatetime()) %>" />
						</td>
					</tr>
					<tr>
						<td>
							项目内容：
						</td>
						<td>
							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getProjectcontent() %>" />
						</td>
						<td>
							客户名称：
						</td>
						<td>
							<input style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getClient() %>" />
						</td>
					</tr>

				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							标准报价：
						</td>
						<td width="33%">
							<input name="standprice" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getStandprice() %>" />
						</td>
						<td width="17%">
							项目总金额：
						</td>
						<td width="33%">
							<input name="totalprice" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>" />
						</td>

					</tr>

					<tr>
						<td width="17%">
							项目收款方式：
						</td>
						<td width="33%">
							<input name="paytime" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getAdvancetype() %>" />
						</td>
						<td>
							开发票方式：
						</td>
						<td>
							<input name="preadvance" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getInvtype() %>" />
						</td>
					</tr>
					<tr>

						<td width="17%">
							开票题头：
						</td>
						<td width="33%">
							<input name="preadvance" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getInvhead() %>" />
						</td>
						<td>
							开票总金额：
						</td>
						<td>
							<input name="preadvance" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getInvcount()) %>" />
						</td>
					</tr>
				</table>
				<br>
				<div class="outborder" align="center">
					<table width="95%" cellpadding="5" cellspacing="5">
						<tr>
							<td width="17%">
								内部分包费预计：
							</td>
							<td width="33%">
								<input name="insubcost" type="text"
									value="<%=qt.getInsubcost() %>" size="40"
									style="background-color: #F2F2F2" readonly="readonly" />
							</td>
							<td width="17%">
								外部分包费预计：
							</td>
							<td width="33%">
								<input name="price" type="text" value="<%=qt.getPresubcost() %>" size="40"
									style="background-color: #F2F2F2" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								合作机构费用预计：
							</td>
							<td>
								<input name="presubcost1" type="text"
									value="<%=qt.getPreagcost() %>" size="40"
									style="background-color: #F2F2F2" readonly="readonly" />
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="审核确认">
					&nbsp;&nbsp;&nbsp;
					<input name="btnModify" class="button1" type="button" id="btnAdd"
						value="修改" onClick="modify()">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
		</form>
	</body>
</html>
