<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Map"%>
<%@ include file="../../comman.jsp"  %>

<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	Quotation qt = null;
	if (sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;		
	}
	Project p =ProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>化学外包项目</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script src="../../javascript/orderscript.js"></script>
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
		<script src="../../javascript/jquery.autocomplete.js"></script>
		
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>


	</head>

	<body class="body1">
	<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>客服管理&gt;&gt;外包管理</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>


		<form name="form1" action="isoutproject_post.jsp" method="post">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
						<td width="15%">
							报告编号：
						</td>
						<td width="33%">
							<input name="rid" size="40" type="text"
								value="<%=p.getRid()==null?"":p.getRid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							项目编号：
						</td>
						<td width="33%">
							<input name="sid" size="40" type="text"
								value="<%=p.getSid()==null?"":p.getSid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>

					</tr>
					<tr>
						<td>
							项目等级：
						</td>
						<td>
							<input name="level" size="40" type="text" value="<%=p.getLevel()==null?"":p.getLevel()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							外包公司名称：
						</td>
						<td width="33%">
							<input name="subname" size="40" type="text"
								value="<%=p.getSubname()==null?p.getSubname2():p.getSubname() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td>
							测试项目：
						</td>
						<td colspan="2">
							<input name="testcontent" size="40"
								value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							&nbsp;
						</td>
						
					</tr>
				</table>

				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td width="14.3%">
							外包发出时间：
						</td>
						<td width="33%">
						<input name="ostime" type="text" id="ostime" size="40"  value="<%=p.getOstime()==null?"":p.getOstime() %>"/>
						<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'ostime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td width="15%">
							数据应回时间：
						</td>
						<td width="33%">
							<input name="ortime" type="text" id="ortime" size="40"  value="<%=p.getOrtime()==null?"":p.getOrtime() %>"/>
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'ortime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>
						</tr>
					<tr>
						<td> 
							请款时间： 
						</td>
						<td>
							<input name="bqtime" type="text" id="bqtime" size="40" value="<%=p.getBqtime()==null?"":p.getBqtime() %>"/>
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'bqtime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td>
							实际回数时间：
						</td>
						<td>
							<input name="oetime" size="40" id ="oetime" value="<%=p.getOetime()==null?"":p.getOetime() %>" readonly="readonly" style="background-color: #F2F2F2" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'oetime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						
					</tr>
					
					
					<%
					if(p.getType() !=null && !p.getType().equals("机构合作")){
					%>
					<tr>
					<td>实际外包金额</td>
					<td><input type="text" name ="oeprice" id ="oeprice" size="40" value="<%=p.getOeprice()%>"> </td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					</tr>
					<%
					} %>
					
					
					
					
					<%
					if(p.getType() !=null && p.getType().equals("机构合作")){
					%>
					<tr>
						<td>TUV项目编号:</td>
						<td><input type="text" name="tuvno" id="tuvno"  size="40" value="<%=p.getTuvno()==null?"":p.getTuvno()%>"></td>
						<td>TUV项目简称:</td>
						<td><input type="text" name="tuvpshort" id="tuvpshort" size="40" value="<%=p.getTuvpshort()==null?"":p.getTuvpshort()%>"></td>
					</tr>
					<tr>
						<td>立创实际报价:</td>
						<td><input type="text" name="lcrealprice" id="lcrealprice" size="40" value="<%=p.getLcrealprice() %>"></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<%
					} %>
					
				</table>
		


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" 
						value="添加"  >
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="window.history.back();" />
				</div>
				<p>
					&nbsp;

				</p>
				
		</form>
	</body>
</html>
