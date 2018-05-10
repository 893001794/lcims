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
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%
	String sno = request.getParameter("sno").trim();
	List list =new ArrayList();
	list.add("s.vsno");
	list.add("s.vsampleName");
	list.add("sp1.estatus");
	list.add("sp1.doutdatetime");
	list.add("sp1.tpplication");
	list.add("sp1.dindatetime");
	List rows=DaoFactory.getInstance().getSimpleDao().getSamplePurser(list,sno);
	

%>

<html>
	<head>
		<meta content="text/html; charset=GB18030">
		<meta http-equiv="cache-control" content="no-cache, must-revalidate">
		<title>项目进度查询</title>
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

		
	</head>

	<body class="body1">  
	
		<table width="70%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h1>
							样品跟踪表
						</h1> </b>
				</td>
			</tr>
		</table>
		
			<table align="center" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" width="90%"> 
			<tr bgcolor="#FFFFFF" >
				<th>样品编号</th>
				<th>样品名称</th>
				<th>状态</th>
				<th>状态时间</th>
				<th>用途</th>
			</tr>
		<%List colums =(List)rows.get(0); %>
			<tr bgcolor="#FFFFFF" >
				<td align="center"><%=colums.get(0) %></td>
				<td align="center"><%=colums.get(1) %></td>
				<td align="center">入库</td>
				<td align="center"><%=colums.get(5) %></td>
				<td align="center">入库</td>
			</tr>
			<%
			for(int i =0;i<rows.size();i++){
			if(i>0){
				List columns=(List)rows.get(i);
				%>
				<tr bgcolor="#FFFFFF" >
				<%
				for(int j=0;j<columns.size();j++){
					if(j<5){
					//if(j==3){
					
					%>
						<%
				//	}else{
					%>
					<td align="center">
						
							<%=columns.get(j) %>
						</td>
					<%
					}
					//}
				}
					 %>
				</tr>

			<%}
			} %>
			</table>
	</body>
</html>
