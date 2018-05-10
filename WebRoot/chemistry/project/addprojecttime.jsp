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
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.lccert.crm.chemistry.util.Config"%>
<%@ include file="../../comman.jsp" %>
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
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�����Ŀ��̬</title>
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
	<form name="form1" action="addprojecttime_post.jsp" method="post" enctype="multipart/form-data">
		<input name="sid" type="hidden" value="<%=p.getSid() %>" />
		<input name="command" type="hidden" value="add" />
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h1> 
							�����Ŀ��̬ 
						</h1> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<div class="outborder">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						�����ţ�
					</td>
					<td width="20%">
						<input name="rid" type="text" size="15"
							style="background-color: #F2F2F2" readonly="readonly"
							value="<%=p.getRid()==null?"":p.getRid()%>" />
					</td>
					<td width="17%">
						��Ŀ�ȼ���
					</td>
					<td >
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getLevel()==null?"":p.getLevel()%>" />
					</td>
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						������Ŀ��
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>" />
					</td>
				</tr>

				<tr>
					<td>
						��Ʒ���ƣ�
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=cp.getSamplename()==null?"":cp.getSamplename()%>" />
					</td>
				</tr>

			</table>
			</div>
			<p>&nbsp;</p>
			<div class="outborder">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						�¼���
					</td>
					<td width="33%">
						<select name="event" style="width: 300px" onchange="change_select();">
							<option value="send">��������/����֪ͨ</option>
							<option value="accept">�յ�����/������Ʒ</option>
							<option value="���ϸ�֪ͨ">���ϸ�֪ͨ</option>
							<option value="�ѳ�TUV����">�ѳ�TUV����</option>
						</select>
					</td>
					
					<td width="17%">
						����������
					</td>
					<td width="33%">
						<select name="count" style="width: 300px">
							<option value="��һ��">��һ��</option>
							<option value="�ڶ���">�ڶ���</option>
							<option value="������">������</option>
							<option value="���Ĵ�">���Ĵ�</option>
							<option value="�����">�����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						֪ͨ���ͣ�
					</td>
					<td >
					<div id="types">
						<input name="type" type="checkbox" value="����" checked onclick="chooseOne(this);"/>������
						<input name="type" type="checkbox" value="����" onclick="chooseOne(this);"/>������
						<input name="type" type="checkbox" value="����/����" onclick="chooseOne(this);"/>����/������
					</div>
					<script>   
							
					     function chooseOne(cb) {   
					         var obj = document.getElementById("types");   
					         for (i=0; i<obj.children.length; i++){   
					             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
					             //else    obj.children[i].checked = cb.checked;   
					             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
					             else obj.children[i].checked = true;   
					         }   
					     }   
 					</script>
					</td>
					<td width="17%">
						������
					</td>
					<td width="33%">
						<input type="file" name="file" />
					</td>
				</tr>
			</table>
			</div>
			
		<hr width="97%" align="center" size=0>
		<div align="center">
		<input type="submit" value="ȷ��" >
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="�ر�" onclick="window.close();">
		</div>
		</form>
	</body>
</html>
