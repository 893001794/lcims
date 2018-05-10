<%@page import="com.lccert.crm.vo.Fpay"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page errorPage="../error.jsp"%>
<%@include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String idStr = request.getParameter("id");
	Fpay fpay=null;
	Integer id=Integer.parseInt(idStr);
	fpay=DaoFactory.getInstance().getFpay().getFpayById(id);
	if(fpay==null){
		fpay=new Fpay();
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӱ��۵�</title>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script src="../js/cashcount/fpay.js"></script>
		
		
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="editfpay_post.jsp" >
			<input name="command" type="hidden" value="edit" />
			<input name ="fpayId" id ="fpayId" type ="hidden" value="<%=id%>">
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
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�������&gt;&gt;�޸�֧�������</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td align="right">
							 ֧�����ڣ�
						</td>
						<td >
							<input type="text" id ="dpaytime"  name ="dpaytime" size="31" value="<%=fpay.getDpaytime()%>">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'dpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td align="right" width="14%">
							��Ӧ�� ��
						</td>
						<td >
							<input type="text" id ="supplier"  name ="supplier" size="35" value="<%=fpay.getSupplier()%>">
						</td>
						<td align="right">
							ժҪ��
						</td>
						<td >
							<input type="text" id ="summay"  name ="summay" size="35" value="<%=fpay.getSummay()%>">
						</td>
					</tr>
					<tr>
						<td width="14%" align="right">
							�������ţ�
						</td>
						<td >
							<select id="dept" name="dept" style="width: 280px;">
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("����һ��")?"selected":"" %>>����һ��</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("���۶���")?"selected":"" %>>���۶���</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("��������")?"selected":"" %>>��������</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("��ͻ���")?"selected":"" %>>��ͻ���</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("�����岿")?"selected":"" %>>�����岿</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("EMC��")||fpay.getDept().equals("EMC��")?"selected":"" %>>EMC��</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("JIM�Ŷ�")?"selected":"" %>>JIM�Ŷ�</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("���ۿͷ�")?"selected":"" %>>���ۿͷ�</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("������")?"selected":"" %>>������</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("����")?"selected":"" %>>����</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("������")?"selected":"" %>>������</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("�ʿز�")?"selected":"" %>>�ʿز�</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("�ܾ���")?"selected":"" %>>�ܾ���</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("��ѧʵ����")?"selected":"" %>>��ѧʵ����</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("��ȫʵ����")?"selected":"" %>>��ȫʵ����</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("������ʵ����")?"selected":"" %>>������ʵ����</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("EMCʵ����")?"selected":"" %>>EMCʵ����</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("��ѵѧԺ")?"selected":"" %>>��ѵѧԺ</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("���ݹ�˾")?"selected":"" %>>���ݹ�˾</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("���̲�")?"selected":"" %>>���̲�</option>
							</select>
						</td>
						<td width="14%" align="right">
							��Ա��
						</td>
						<td >
							<input type="text" id ="person"  name ="person" size="35" value="<%=fpay.getPerson() %>">
						</td>
						<td width="14%" align="right">
							�ܾ��죺
						</td>
						<td >
							<input type="text" id ="gmo"  name ="gmo" size="35" value="<%=fpay.getGmo()%>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							��ѧ��
						</td>
						<td >
							<input type="text" id ="chem"  name ="chem" size="35" value="<%=fpay.getChem()%>" onblur="sumTotal();">
						</td>
						<td align="right">
							��ȫ��
						</td>
						<td >
							<input type="text" id ="safe"  name ="safe" size="35" value="<%=fpay.getSafe() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							�����ܣ�
						</td>
						<td >
							<input type="text" id ="op"  name ="op" size="35" value="<%=fpay.getOp() %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							EMC��Ӫ��
						</td>
						<td >
							<input type="text" id ="emc"  name ="emc" size="35" value="<%=fpay.getEmc() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							EMC���ң�
						</td>
						<td >
							<input type="text" id ="dr"  name ="dr" size="35" value="<%=fpay.getDr() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							��ͻ�����
						</td>
						<td >
							<input type="text" id ="vip"  name ="vip" size="35" value="<%=fpay.getVip() %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							��������
						</td>
						<td >
							<input type="text" id ="eq"  name ="eq" size="35" value="<%=fpay.getEq()%>" onblur="sumTotal();">
						</td align="right">
						<td align="right">
							���񲿣�
						</td>
						<td >
							<input type="text" id ="finance"  name ="finance" size="35" value="<%=fpay.getFinance() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							��������
						</td>
						<td >
							<input type="text" id ="administration"  name ="administration" size="35" value="<%=fpay.getAdministration() %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							���̲���
						</td>
						<td >
							<input type="text" id ="engineering"  name ="engineering" size="35" value="<%=fpay.getEngineering() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							С�ƣ�
						</td>
						<td >
							<input type="text" id ="total"  name ="total" size="35" value="<%=fpay.getTotal() %>">
						</td>
						<td align="right">
							�˺����ƣ�
						</td>
						<td >
							<select id="account" name ="account"; style="width: 280px;">
								<option value="1769" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769")?"selected":"" %>>1769</option>
								<option value="1769-0002" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769-0002")?"selected":"" %>>1769-0002</option>
								<option value="1769-0003" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769-0003")?"selected":"" %>>1769-0003</option>
								<option value="1769-0004" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769-0004")?"selected":"" %>>1769-0004</option>
								<option value="5963" <%=fpay.getAccount()!=null && fpay.getAccount().equals("5963")?"selected":"" %>>5963</option>
								<option value="3232" <%=fpay.getAccount()!=null && fpay.getAccount().equals("3232")?"selected":"" %>>3232</option>
								<option value="8833" <%=fpay.getAccount()!=null && fpay.getAccount().equals("8833")?"selected":"" %>>8833</option>
								<option value="5016" <%=fpay.getAccount()!=null && fpay.getAccount().equals("5016")?"selected":"" %>>5016</option>
								<option value="4193" <%=fpay.getAccount()!=null && fpay.getAccount().equals("4193")?"selected":"" %>>4193</option>
								<option value="7084" <%=fpay.getAccount()!=null && fpay.getAccount().equals("7084")?"selected":"" %>>7084</option>
								<option value="1050" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1050")?"selected":"" %>>1050</option>
								<option value="�ֽ�" <%=fpay.getAccount()!=null && fpay.getAccount().equals("�ֽ�")?"selected":"" %>>�ֽ�</option>
								<option value="HK-�ֽ�" <%=fpay.getAccount()!=null && fpay.getAccount().equals("HK-�ֽ�")?"selected":"" %>>HK-�ֽ�</option>
							</select>
						</td>
						
					</tr>
					<tr>
						<td align="right">
							 Ʊ�����ͣ�
						</td>
						<td >
							<select id="einvtype" name ="einvtype"; style="width: 280px;" >
								<option value="��Ʊ" <%=fpay.getEinvtype()!=null && fpay.getEinvtype().equals("��Ʊ")?"selected":"" %>>��Ʊ</option>
								<option value="�վ�" <%=fpay.getEinvtype()!=null && fpay.getEinvtype().equals("�վ�")?"selected":"" %>>�վ�</option>
							</select>
						</td>
						<td align="right">
							 ��Ʊ���룺
						</td>
						<td >
							<input type="text" id ="invoiceno"  name ="invoiceno" size="35" value="<%=fpay.getInvoiceno() %>">
						</td>
						<td align="right">
							��ע��
						</td>
						<td >
							<textarea rows="6" cols="33" id ="remarks"  name ="remarks"> <%=fpay.getRemarks() %></textarea>
						</td>
						
					</tr>
					<tr>
						<td align="right">
							һ����Ŀ��
						</td>
						<td >
							<input type="text" id ="onelevelsub"  name ="onelevelsub" size="35" value="<%=fpay.getOnelevelsub() %>">
						</td>
						
						<td align="right">
							������Ŀ
						</td>
						<td >
							<input type="text" id ="twolevelsub"  name ="twolevelsub" size="35" value="<%=fpay.getTwolevelsub() %>">
						</td>
						<td >
							������Ŀ
						</td>
						<td >
							<input type="text" id ="threelevelsub"  name ="threelevelsub" size="35" value="<%=fpay.getThreelevelsub() %>" onblur="findSubsByThreeLevelSub(this.value);">
						</td>
					</tr>
					<tr>
						<td align="right">
							���������
						</td>
						<td >
							<input type="text" id ="travel"  name ="travel" size="35" value="<%=fpay.getTravel() %>">
						</td>
						
						<td align="right">
							�д��ͻ�
						</td>
						<td >
							<input type="text" id ="entertain"  name ="entertain" size="35" value="<%=fpay.getEntertain() %>">
						</td>
						<td >
							&nbsp;
						</td>
						<td >
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit"" id="btnAdd" value="�޸�" > &nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
