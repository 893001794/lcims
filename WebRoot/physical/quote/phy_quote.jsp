<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	String id = request.getParameter("id");
	String fs = System.getProperties().getProperty("file.separator");
	//String phonoPath = fs+"oa"+fs+"43#Module"+fs+"�������"+fs+"����ϵͳ7"+fs+id+".JPG"; 
	String phonoPath = request.getParameter("phonoPath");
	List temp =new ArrayList();
	if(id !=null){
	int serviceId =Integer.parseInt(id.trim());
	temp=DaoFactory.getInstance().getQuoteDao().getServiceInfor(serviceId);
	}
	
%>

<html>
	<head>
		<meta content="text/html; charset=GB18030">
		<meta http-equiv="cache-control" content="no-cache, must-revalidate">
		<title>���ӵ���������Ϣ</title>
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
	
		
		<div class="outborder">
			<table align="center" cellspacing=5 cellpadding=5 width="95%" border="1">
				<tr>
					
				</tr>
				<%
				for(int i=0;i<temp.size();i++){
					List column =(List)temp.get(i);
				%>
					
						<%for(int j=0;j<column.size();j++){
						String str ="";
							if(j ==0){
								str="������Ŀ";
							}
							if(j ==1){
								str="����";
							}
							if(j ==2){
								str="��׼";
							}
							if(j ==3){
								str="��Ʒ����";
							}
							if(j ==4){
								str="��������";
							}
							%>
							<tr>
							<th><%=str%></th><td width="300"><%=column.get(j)%></td>
							<%
							if(i==0&& j==0){
							 %>
								<td rowspan="<%=column.size()%>" width="400"><img  src="<%=phonoPath %>" align="middle" width="400" height="300"></td>
							<%
							}
							 %>
							</tr>
							<%
						} %>
					
					<%
				}
				
				 %>
			</table>

			</div>
			
			<div class="outborder" align="center"">
				<input type="button" value="�ر�" onclick="window.close();">
			</div>
		
	</body>
</html>
