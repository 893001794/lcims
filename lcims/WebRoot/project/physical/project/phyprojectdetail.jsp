<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = PhyProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	PhyProject pp = (PhyProject)p.getObj();
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>项目详细信息</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script language="javascript">
		
		function goBack() {
		window.self.location="javascript:window.history.back();";
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("addappform").value += temp;
			document.getElementById("addappform").value += "\n";
		}
		function addInorganic(temp0) {
			document.getElementById("inorganic").value += temp;
			document.getElementById("inorganic").value += "\n";
		}
		function addInorganicDetail(temp1) {
			document.getElementById("inorganicdetail").value += temp1;
			document.getElementById("inorganicdetail").value += "\n";
		}
		function addOrganic(temp2) {
			document.getElementById("organic").value += temp2;
			document.getElementById("organic").value += "\n";
		}
		function addOrganicDetail(temp3) {
			document.getElementById("organicdetail").value += temp3;
			document.getElementById("organicdetail").value += "\n";
		}
		function addfood(temp4) {
			document.getElementById("food").value += temp4;
			document.getElementById("food").value += "\n";
		}
	</script>

	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>电子电器管理&gt;&gt;项目详细信息</b>
				</td>
			</tr>
		</table>
		<%--<hr width="97%" align="center" size=0>

		<form name=search method=post action=addflow.jsp>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<font color="red">请输入完整报价单号：</font>
						<input type=text name=pid size="25" value=>

						<input type=submit name=Submit value=搜索>
					</td>
				</tr>
			</table>
		</form>
		--%>
		<hr width="97%" align="center" size=0>
		<form name="form1">
			<table cellpadding="5" cellspacing="0" style="margin-left: 10em">
				<tr>
					<td>
						报告编号：
					</td>
					<td>
						<input name="pid" type="text" value="<%=p.getRid() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						项目类型：
					</td>
					<td>
						<input name="pid" type="text" value="<%=p.getPtype() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					
				</tr>
				<tr>
					<td>
						报告应出时间：
					</td>
					<td>
						<input type="text" value="<%=pp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(pp.getRptime()) %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						报告类型：
					</td>
					<td>
						<input name="pid" type="text" value="<%=pp.getRptype() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					
					
				</tr>
				<tr>
					<td>
						客服人员：
					</td>
					<td>
						<input type="text" value="<%=pp.getServname()==null?"":pp.getServname() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						销售人员：
					</td>
					<td>
						<input type="text" value="<%=qt.getSales()==null?"":qt.getSales() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						工程师：
					</td>
					<td>
						<input type="text" value="<%=pp.getEngineer()==null?"":pp.getEngineer() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						项目等级：
					</td>
					<td>
						<input type="text" value="<%=p.getLevel()==null?"":p.getLevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
			
				<tr>
					<td>
						客户名称：
					</td>
					<td>
						<input value="<%=qt.getClient() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

					<td>
						报告客户名称：
					</td>
					<td>
						<input value="<%=pp.getRpclient() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">
				<tr>
					<td>
						样品名称：
					</td>
					<td>
						<input type="text" size="80" value="<%=pp.getSamplename()==null?"":pp.getSamplename() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>

				<tr>
					<td>
						样品量：
					</td>
					<td>
						<input type="text" size="80" value="<%=pp.getSamplecount()==null?"":pp.getSamplecount() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						样品类别：
					</td>
					<td>
						<input type="" size="80" value="<%=pp.getSamplecategory()==null?"":pp.getSamplecategory() %>" readonly="readonly" style="background-color: #F2F2F2"/>
						
					</td>
				</tr>
				<tr>
					<td>
						样品型号：
					</td>
					<td>
						<input type="text" size="80" value="<%=pp.getSamplemodel()==null?"":pp.getSamplemodel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						测试标准：
					</td>
					<td>
						<textarea name="testStandard" cols="73" rows="8" readonly="readonly" style="background-color: #F2F2F2"><%=pp.getTestStandard()==null?"":pp.getTestStandard()%></textarea>
					</td>
				</tr>
			</table>
			
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">

				<tr>
					<td>
						备注：
					</td>
					<td>
						<textarea name="notes" cols="73" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=p.getNotes()==null?"":p.getNotes() %></textarea>
					</td>
				</tr>
				
			</table>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
