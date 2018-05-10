<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@page import="com.lccert.oa.vo.UserInfor"%>
<%@page import="com.lccert.oa.vo.Group"%>
<%
	request.setCharacterEncoding("GBK");
	List list=SearchFactory.getUserInfor().getAllAdd();
	if(list ==null){
	list =new ArrayList();
	}
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>项目管理</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script type="text/javascript">
		function checkSelect(obj){
		window.open("addressBook_manage.jsp?group="+obj.value);
		self.close() 
		//window.showModalDialog("addressBook_manage.jsp?group="+obj.value,"","dialogWidth:1000px;dialogHeight:700px");
		//window.close();
		}
		
		</script>
	</head>

	<body  >
	<form name ="myform" action="#" method="post">
				<table width="900" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align="center">
				<tr bgcolor="#FFFFFF" >
					<td class="rd6">
						中文名
					</td>
					<td class="rd6">
						英文名
					</td>
					<td class="rd6">
						部门
					</td>
					<td class="rd6">
						职位
					</td>
					<td class="rd6">
						手机号
					</td>
					<td  class="rd6">
						天翼号
					</td>
					<td class="rd6">
						电子邮件
					</td>
				</tr>
				<%for(int i=0;i<list.size();i++){
				UserInfor user =(UserInfor)list.get(i);
				%>
				<tr bgcolor="#FFFFFF" >
			
				
					<td><%=user.getPSN_NAME()==null?"":user.getPSN_NAME()%></td>
					<td><%=user.getNICK_NAME()==null?"":user.getNICK_NAME()%></td>
					<td><%=user.getGROUP_NAME()==null?"":user.getGROUP_NAME()%></td>
					<td><%=user.getMINISTRATION()==null?"":user.getMINISTRATION()%></td>
					<td><%=user.getMOBIL_NO()==null?"":user.getMOBIL_NO()%></td>
					<td><%=user.getBP_NO()==null?"":user.getBP_NO()%></td>
					<td><%=user.getEMAIL()==null?"":user.getEMAIL()%></td>
				</tr>
				<%
				} %>

				
			</table>
			<table width="100%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						
					</td>
					
				</tr>
			</table>

		</form>
		<div align="center">
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="关闭" onClick="window.close();"
>
						</div>
	</body>
</html>
