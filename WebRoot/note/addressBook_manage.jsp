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
	int g=0;
	if(request.getParameter("group") !=null && !"".equals(request.getParameter("group"))){
	g=Integer.parseInt(request.getParameter("group"));
	}
	
	List list=SearchFactory.getUserInfor().getAllUserInfor(g);
	if(list ==null){
	list =new ArrayList();
	}
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>通讯录</title>
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
	<br>传真总机:22833399(收) 22833597(发)  营运中心:22833752(收发) 化学部:22833341(发) 安规部:22833594(发) 广州公司:020-38731966(收发) 东莞分公司:0769-26620330(收发)<br>
	<form name ="myform" action="#" method="post">
	<div align="center">部门：<select name ="group" id="group" onchange="checkSelect(this);">
			<option value="" >---请选择部门----</option>
				<%
					//获取部门的下拉框
					List temp =SearchFactory.getUserInfor().getAllGroupInfor();
					for(int i=0;i<temp.size();i++){
					Group group =(Group)temp.get(i);
					
					%> 
					<option value="<%=group.getGROUP_ID() %>" <%=group.getGROUP_ID()==g ?"selected":"" %> ><%=group.getGROUP_NAME() %></option>
					<%
					}
				 %>
			</select></div>
			
			<br>
			
			<table width="100%" border="1" align="center">
			
				<tr>
					<td class="rd6">
						名称
					</td>
					<td class="rd6">
						座机
					</td>
					<td class="rd6">
						手机
					</td>
					<td class="rd6">
						天翼
					</td>
					<td class="rd6">
						邮箱
					</td>
				</tr>
				<%for(int i=0;i<list.size();i++){
				UserInfor user =(UserInfor)list.get(i);
				%>
				<tr>
			
				
					<td><%=user.getPSN_NAME()==null?"":user.getPSN_NAME()%></td>
					<td><%=user.getTEL_NO_DEPT()==null?"":user.getTEL_NO_DEPT()%></td>
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
