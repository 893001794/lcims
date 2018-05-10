<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.impl.SalesOrderItemDaoImpl"%>
<%@page import="com.lccert.crm.vo.SalesOrderItem"%>
<%@ include file="../comman.jsp"  %>
<%
	String itemNumber=request.getParameter("itemNumber");
	List list =SalesOrderItemDaoImpl.getInstance().findByItemNumber(itemNumber);
	SalesOrderItem sale =new SalesOrderItem();
	for(int i=0;i<list.size();i++){
	sale=(SalesOrderItem)list.get(i);
	}
	 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӱ��۵�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.js"></script>
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
.hid {
	display: none;
}
</style>
<script type="text/javascript">
	function goBack(){
	window.history.back();
	}
</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="saleorder_post.jsp">
			<input name="command" type="hidden" value="add" />
			<input name="totalprice" id="totalprice" type="hidden" value="" />
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
						<img src="../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>&gt;&gt;���۵�����&gt;&gt;¼�뱨�۵�</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>

						<td width="10%">
							������Ŀ���룺
						</td>
						<td width="33%">
							<input type="text" name="itemnumber"  value="<%=itemNumber%>"  size="40" readonly="readonly" style="background-color: #F2F2F2">
						</td>
						<td>
							������Ŀ���ƣ�
						</td>
						<td>
						<input type="text" value="<%=sale.getName()==null?"":sale.getName()%>"  size="40" readonly="readonly" style="background-color: #F2F2F2">
							
						</td>
					</tr>

					<tr>
						<td>
							��׼���۽�
						</td>
						<td>
						
						<input type="text" name="standprice" value="<%=sale.getStandprice()==null?"":sale.getStandprice()%>"  size="40" >
						</td>
						<td width="15%">
							���۱��۽�
						</td>
						<td>
							<input type="text" name="saleprice" value="<%=sale.getSaleprice()==null?"":sale.getSaleprice()%>"  size="40" >��
						</td>

					</tr>
					<tr>
						<td>
							���Ʊ��۽�
						</td>
						<td>
							<input type="text" name ="controlprice" value="<%=sale.getControlprice()==null?"":sale.getControlprice()%>"  size="40" >
						</td>
						<td>
							���
						</td>
						<td width="33%">
							<select name="category" style="width: 300px">
								<option value="" selected="selected">--��ѡ����Ŀ����--</option>
								<%
								String category=sale.getCategory()==null?"":sale.getCategory();
								if(category.equals("���")){
								
								
								%>
									<option value="���" selected="selected">���</option>
								<%
								}else{
								%>
									<option value="���">���</option>
								<%
								
								}if(category.equals("��������")){
								%>
								<option value="��������" selected="selected">��������</option>
								<%
								
								}else{
								%>
								<option value="��������">��������</option>
								<%
								
								
								}
								 %>
							
								
							</select>
						</td>
						
					</tr>
					<tr>
						<td>
							��ͨ���ڣ�
						</td>
						<td>
							<input name="normalperiod" type="text" id="normalperiod" size="40" value="<%=sale.getNormalPeriod()==null?"":sale.getNormalPeriod() %>"/>��
						</td>
						<td width="10%">
							�Ӽ����ڣ�
						</td>
						<td>
							<input name="urgentperiod" type="text" id="urgentperiod" size="40" value="<%=sale.getUrgentPeriod()==null?"":sale.getUrgentPeriod()%>"/>��
						</td>
						
					</tr>
					<tr>
					<td>
							�ؼ����ڣ�
						</td>
						<td width="33%">
							<input name="absolutperiod" type="text" id="absolutperiod" size="40" value="<%=sale.getAbsolutPeriod()==null?"":sale.getAbsolutPeriod() %>"/>�� 
						</td>
						<td>
							
						</td>
						<td width="33%">
						
						</td>
						<td>&nbsp;
							

						</td>
						<td width="33%">&nbsp;
							

						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" type="submit" id="btnAdd"
					value="�޸�" >
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
