<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.Warnning"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.DynamicProjectTime"%>
<%@page import="com.lccert.crm.project.ProjectTimeAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid").trim();
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	ChemProject cp = (ChemProject)p.getObj();
	List<DynamicProjectTime> list = ProjectTimeAction.getInstance().getProjectTime(p.getRid());
	if(list == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	} 
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��Ŀ��̬</title>
		
		<script type="text/javascript">
		
			function addtime() {
				window.open("project/addprojecttime.jsp?sid=<%=p.getSid()%>");
			}
		
		</script>
		
<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>

		
	</head>

	<body class="body1">  
		<p>&nbsp;</p>
			<div align="center"><h2>��Ŀ״̬</h2></div>
			<div class="outborder">
				
			<table align="center" border="1" cellspacing=5 cellpadding=5 width="95%">
				<tr bgcolor="#01DF01">
					<th>��Ŀ��</th>
					<th>ʱ��</th>
					<th>������</th>
					<th>�¼�</th>
				</tr>
				
				<%
				if(cp.getSendtime()!= null) {
				 %>
				
				<tr>
					<td>
						<%=p.getRid() %>
					</td>
					<td>
						<%=cp.getSendtime() %>
					</td>
					<td>
						<%=cp.getSenduser()==null?"":cp.getSenduser() %>
					</td>
					<td>
						���淢��ʱ��
					</td>
				</tr>
				<%
				}
				if(cp.getEndtime()!= null) {
				 %>
				<tr>
					<td>
						<%=p.getRid() %>
					</td>
					<td>
						<%=cp.getEndtime() %>
					</td>
					<td>
						<%=cp.getEnduser()==null?"":cp.getEnduser() %>
					</td>
					<td>
						�������ʱ��
					</td>
				</tr>
				<%
				}
				 %>
				
				<%
				for(int i=0;i<list.size();i++) {
					DynamicProjectTime dpt = list.get(i);
				 %>
				
				<tr>
					<td>
						<%=dpt.getRid() %>
					</td>
					<td>
						<%=dpt.getTime() %>
					</td>
					<td>
						<%=dpt.getUser() %>
					</td>
					<td>
						<%=dpt.getEvent() %>
					</td>
				</tr>
				
				<%
				}
				 %>
				<%
				if(cp.getCreatetime()!= null) {
				 %>
				<tr>
					<td>
						<%=p.getRid() %>
					</td>
					<td>
						<%=cp.getCreatetime() %>
					</td>
					<td>
						<%=cp.getCreatename() %>
					</td>
					<td>
						��Ŀ�ŵ�ʱ��
					</td>
				</tr>
				<%
				}
				if(p.getBuildtime()!= null) {
				 %>
				<tr>
					<td>
						<%=p.getRid() %>
					</td>
					<td>
						<%=p.getBuildtime() %>
					</td>
					<td>
						<%=p.getBuildname() %>
					</td>
					<td>
						��Ŀ����ʱ��
					</td>
				</tr>
				<%
				}
				 %>
				</table>
				</div>

			<p>&nbsp;</p>
		<hr width="97%" align="center" size=0>
		<div align="center">
		<input type="button" value="����/����" onclick="addtime();">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="����" onclick="window.history.back();">
		</div>
		
	</body>
</html>
