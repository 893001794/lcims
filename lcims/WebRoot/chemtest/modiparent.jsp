<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding("GBK");
	String id=request.getParameter("id");
	TestParents tp =new TestParents();
	tp =ChemTestDaoImpl.getInstance().getParentsById(Integer.parseInt(id));
	
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�����ת��</title>
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

		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		
</script>

	
		
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
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���̲�����&gt;&gt;��Ӳ�����Ŀ</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
			<br>
			<%
			String status=request.getParameter("status");
			status = new String(status.getBytes("ISO-8859-1"), "GBK");   
			 %>

			<form method="post" action="addchemtest_post.jsp?testype=<%=status %>&type=modi&id=<%=id %>" >
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						��������������
					</td>
					<td width="33%">
		
						<input name="chemtestName" type="text" size="40" value="<%=tp.getName()%>"<%=tp.getName() ==null?"":tp.getName() %>/>
					</td>
					</tr>
					<tr>
					<td width="17%">
						���
					</td>
					<td width="33%">
						<select name ="chemtestype" style="width: 250px">
							<option value="" selected="selected">----��ѡ�������Ŀ����----</option>
							<%if(tp.getType().equals("�޻���ת��")) {
							%>
							<option value="<%=tp.getType() %>" <%=tp.getType()!=null?"selected":"" %>><%=tp.getType() %></option>
							<%
							}else{
							%>
							<option value="�޻���ת��" >�޻���ת��</option>
							<%
							}
							if(tp.getType().equals("�л���ת��")) {
							%>
							<option value="<%=tp.getType() %>" <%=tp.getType()!=null?"selected":"" %>><%=tp.getType() %></option>
							<%
							}else{
							%>
						<option value="�л���ת��" >�л���ת��</option>
							<%
							}if(tp.getType().equals("ʳƷ��ת��")) {
							%>
							<option value="<%=tp.getType() %>" <%=tp.getType()!=null?"selected":"" %>><%=tp.getType() %></option>
							<%
							}else{
							%>
						<option value="ʳƷ��ת��" >ʳƷ��ת��</option>
							<%
							}if(tp.getType().equals("�����ת��")) {
							%>
							<option value="<%=tp.getType() %>" <%=tp.getType()!=null?"selected":"" %>><%=tp.getType() %></option>
							<%
							}else{
							%>
							<option value="�����ת��" >�����ת��</option>
							<%
							}
							%>
							
						
						</select>
					</td>
				</tr>
				<tr id ="parentid" style="display: none;">
					<td>һ����Ŀ��id</td>
					<td><input name ="parentid" id ="parentid" value="<%=tp.getYle() %>" size="40"><font color="red">id��id֮����,����</font></td>
				</tr>
				<tr>
					<td width="17%">
						�Ƿ���Ч��
					</td>
					<td width="33%">
						<select name ="chemteststatus" style="width: 150px">
						<option value="y" selected="selected">y</option>
							<%
						if(tp.getStatus().equals("n")) {
							%>
							<option value="<%=tp.getStatus() %>" <%=tp.getStatus()!=null?"selected":"" %>><%=tp.getStatus()%></option>
							<%
							}else{
							%>
							<option value="n">n</option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				
			</table>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="�޸�" >
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
