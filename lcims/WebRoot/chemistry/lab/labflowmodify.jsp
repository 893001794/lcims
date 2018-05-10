<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%
	request.setCharacterEncoding("GBK");
	String fid = request.getParameter("fid");
	if(fid == null || "".equals(fid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Flow flow = FlowAction.getInstance().getFlowByFid(fid); 
	if(flow == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(flow.getSid(),""); 
	if(p==null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	ChemProject cp = (ChemProject)p.getObj();
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>编辑流转单</title>
<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>

		<script language="javascript">
		function goBack() {
			window.history.back();
		}
		
</script>
	</head>

	<body class="body1">
		<form name="form1" method="post" action="labflowmodify_post.jsp">
			<input name="fid" type="hidden" value="<%=flow.getFid() %>">
			<input name="sid" type="hidden" value="<%=flow.getSid() %>">
			<input name="oldwarning" type="hidden" value="<%=cp.getWarning() %>">
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
						<img src="../../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>化学实验室管理&gt;&gt;编辑流转单</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
		<div class="outborder">
			<table cellpadding="5" cellspacing="0" width="95%">
				<tr>
					<td width="17%">
						报价单编号：
					</td>
					<td width="33%">
						<input name="pid" size="40" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getPid() %>" />
					</td>

					<td width="17%">
						报告类型：
					</td>
					<td width="33%">
						
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=cp.getRptype() %>" />
					</td>

				</tr>
				<tr>
					<td>
						应出报告时间：
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>" />
					</td>
					<td>
						报告编号：
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getRid() %>" />
					</td>
				</tr>
				<tr>
					<td>
						项目接收时间：
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime()) %>" />
					</td>
					<td>
						项目等级：
					</td>
					<td>
						<input type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getLevel() %>" />
					</td>
				</tr>
			</table>
			
		</div>
			
			<div class="outborder">
			
			<table cellpadding="5" cellspacing="5">
				<tr>
					<td width="17%">
						测试样品描述：
					</td>
					<td>
						<textarea cols="73" rows="4" readonly="readonly"  style="background-color: #F2F2F2"><%=cp.getSampledesc() %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						申请表补充信息：
					</td>
					<td>
						<textarea cols="73" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=cp.getAppform() %></textarea>
					</td>
				</tr>
				
			
				<tr>
					<td>
						测试大项：
					</td>
					<td>
						<textarea cols="76" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getTestparent() %></textarea>
					</td>
					
				</tr>
			
				<tr>
					<td>
						测试小项：
					</td>
					<td>
						<textarea cols="76" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getTestchild() %></textarea>
					</td>
				</tr>
			</table>
			</div>
			
			<div class="outborder">
			<table cellpadding="5" cellspacing="0" width="95%">
				<tr>
					<td width="17%">
						流转单种类：
					</td>
					<td width="33%">
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getFlowtype() %>"/>
					</td>
					<td width="17%">
						测试实验室：
					</td>
					<td width="33%">
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getLab() %>"/>
					</td>
				</tr>
				<tr>
					<td>
						测试点数：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getTestcount() %>"/>
					</td>
					<td>
						流转单工分A：
					</td>
					<td>
						<input name="workpoint" type="text" value="<%=flow.getVworkpoint()==null?"":flow.getVworkpoint() %>"/>
					</td>
				</tr>
				<tr>
					<td>
						流转单工分B：
					</td>
					<td>
						<input name="workpoint2" type="text" value="<%=flow.getVworkpoint2()==null?"":flow.getVworkpoint2() %>"/>
					</td>
					<td width="17%">
						项目预警备注：
					</td>
					<td>
						<textarea name="warning" rows="5" cols="40" ><%=cp.getWarning()==null?"":cp.getWarning() %></textarea>
					</td>
				</tr>
			</table>
			</div>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="保存" />
					&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
