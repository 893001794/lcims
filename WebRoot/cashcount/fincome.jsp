<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.util.Date"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	String chem = request.getParameter("chem");
	String safe = request.getParameter("safe");
	String op = request.getParameter("op");
	String emc = request.getParameter("emc");
	float sumTotal=Float.parseFloat(chem)+Float.parseFloat(safe)+Float.parseFloat(op)+Float.parseFloat(emc);
	String vpYear="";
	String vpMonth="";
	String salesName="";
	Order order;
	Quotation qt;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String dept = "";
	String currDate=sdf.format(new Date());
	String einvno="";//Ʊ�ݱ��=Ʊ������+Ʊ�ݱ��+ʵ�ʿ�Ʊ���
	String province ="" ; //ʡ
	String city=""; //��
	String payTime =""; //��һ���տ�
	if(pid !=null || ! "".equals(pid)){
	int id= OrderAction.getInstance().getOrderByPid(pid);
		order= OrderAction.getInstance().getOrderById(id);
		qt=QuotationAction.getInstance().getQuotationByPid(pid);
		String clientContact=qt.getClientContact();//�ͻ�����
		if(clientContact !=null && !"".equals(clientContact)){
			if(clientContact.indexOf("ʡ")>-1){
				province=clientContact.substring(0,clientContact.indexOf("ʡ")+1);
				city=clientContact.substring(clientContact.indexOf("ʡ")+1,clientContact.length());
				if(!province.equals("�㶫ʡ")){
					province="ʡ��";
					city=clientContact.substring(0,clientContact.indexOf("ʡ")+1);
				}
			}else{
				province="ʡ��";
				city=clientContact;
			}
		}
		 UserForm sales = UserAction.getInstance().getUserByName(qt.getSales());
		 if("��ɽ".equals(sales.getCompany())) {
			dept = sales.getDept();
		 } else {
			dept = sales.getCompany();
		 }
		
		if(qt.getInvtime() !=null && !"".equals(qt.getInvtime())){
			einvno+=sdf.format(qt.getInvtime())+"-";
		}
		if(qt.getInvcode()!=null && !"".equals(qt.getInvcode())){
			einvno+=qt.getInvcode()+":";
		}
		if(qt.getInvprice()!=0.0  ){
			einvno+=qt.getInvprice();
		}
		if(qt.getPaytime()!=null){
			payTime=qt.getPaytime()+"";
			payTime=payTime.substring(0,10);
		}else{
			payTime="";
		}
		 //Ʊ������
		 if(order ==null){
		 	order =new Order();
		 }else{
		 //������Աֻ��ʾ������
		 salesName=order.getSales().getName();
		 if(salesName !=null && !"".equals(salesName)){
		 	if(salesName.indexOf("[")>-1){
		 		salesName=salesName.substring(0,salesName.indexOf("["));
		 	}
		 }
		 	if(qt.getConfirmtime() !=null){
			 	 SimpleDateFormat year=new SimpleDateFormat("yyyy");
				 vpYear=year.format(qt.getConfirmtime());
				 SimpleDateFormat month=new SimpleDateFormat("MM");
				 vpMonth=month.format(qt.getConfirmtime());
		 	}
		 }
	 
	}else{
    qt=new Quotation ();
	order =new Order();
	}
	//�ظ�ˢ�¡��ظ��ύ 
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӱ��۵�</title>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script src="../js/cashcount/fincome.js"></script>
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="fincome_post.jsp" onsubmit="getElById('btnAdd').disabled = true; return true">
			<input name="command" type="hidden" value="add" />
			<input name ="confirmUserId" id ="confirmUserId" type ="hidden" value="">
			<div class="outborder">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�������&gt;&gt;���������</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td align="right">
							 �տ����ڣ�
						</td>
						<td >
							<input type="text" id ="dpaytime"  name ="dpaytime" size="31" value="<%=payTime%>">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'dpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td align="right">
							������ݣ�
						</td>
						<td >
							<input type="text" id ="vpyear"  name ="vpyear" size="35" value="<%=vpYear%>">
						</td>
						<td align="right">
							�����·ݣ�
						</td>
						<td >
							<input type="text" id ="vpmonth"  name ="vpmonth" size="35" value="<%=vpMonth%>">
						</td>
					</tr>
					<tr>
						<td align="right" width="14%">
							�ͻ����� ��
						</td>
						<td >
							<input type="text" id ="client"  name ="client" size="35" value="<%=order.getClient().getName()%>">
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
						</td>
						<td width="14%" align="right">
							�������ţ�
						</td>
						<td >
							<input type="text" id ="dept"  name ="dept" size="35" value="<%=dept%>">
						</td>
						<td width="14%" align="right">
							������Ա��
						</td>
						<td >
							<input type="text" id ="sales"  name ="sales" size="35" value="<%=salesName%>">
						</td>
					</tr>
					<tr>
						<td width="14%" align="right">
							���۵��ţ�
						</td>
						<td >
							<input type="text" id ="vpid"  name ="vpid" size="35" value="<%=pid%>">
						</td>
						<td align="right">
							����ʡ�ݣ�
						</td>
						<td >
							<input type="text" id ="province"  name ="province" size="35" value="<%=province%>">
						</td>
						<td align="right">
							���ڳ��У�
						</td>
						<td >
							<input type="text" id ="city"  name ="city" size="35" value="<%=city %>">
						</td>
					</tr>
					<tr>
						<td align="right">
							��ѧ��
						</td>
						<td >
							<input type="text" id ="chem"  name ="chem" size="35" value="<%=chem %>" onblur="sumTotal();">
						</td>
						<td align="right">
							��ȫ��
						</td>
						<td >
							<input type="text" id ="safe"  name ="safe" size="35" value="<%=safe %>" onblur="sumTotal();">
						</td>
						<td align="right">
							�����ܣ�
						</td>
						<td >
							<input type="text" id ="op"  name ="op" size="35" value="<%=op %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							EMC��Ӫ��
						</td>
						<td >
							<input type="text" id ="emc"  name ="emc" size="35" value="<%=emc%>" onblur="sumTotal();">
						</td>
						<td align="right">
							EMC���ң�
						</td>
						<td >
							<input type="text" id ="dr"  name ="dr" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							��ͻ�����
						</td>
						<td >
							<input type="text" id ="vip"  name ="vip" size="35" value="0" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							��������
						</td>
						<td >
							<input type="text" id ="eq"  name ="eq" size="35" value="0" onblur="sumTotal();">
						</td align="right">
						<td align="right">
							���񲿣�
						</td>
						<td >
							<input type="text" id ="finance"  name ="finance" size="35" value="0" onblur="sumTotal();">
						</td>
						<td align="right">
							���ݹ�˾��
						</td>
						<td >
							<input type="text" id ="gz"  name ="gz" size="35" value="0" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							С�ƣ�
						</td>
						<td >
							<input type="text" id ="total"  name ="total" size="35" value="<%=sumTotal%>" >
						</td>
						<td align="right">
							�˺����ƣ�
						</td>
						<td >
							<input type="text" id ="account"  name ="account" size="35" value="<%=qt.getCreditcard() %>">
						</td>
						<td align="right">
							 Ʊ�����ͣ�
						</td>
						<td >
							<select  id="einvtype" name="einvtype" style="width: 250px;">
								<option value="">��ѡ��Ʊ������</option>
								<option value="ר�÷�Ʊ" <%=order.getInvtype()!=null && order.getInvtype().equals("ר�÷�Ʊ")?"selected":"" %>>ר�÷�Ʊ</option>
								<option value="��ͨ��Ʊ" <%=order.getInvtype()!=null && order.getInvtype().equals("��ͨ��Ʊ")?"selected":"" %>>��ͨ��Ʊ</option>
								<option value="�վ�" <%=order.getInvtype()!=null && order.getInvtype().equals("�վ�")?"selected":"" %>>�վ�</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">
							Ʊ�ݱ�ţ�
						</td>
						<td >
							<input type="text" id ="einvno"  name ="einvno" size="35" value="<%=einvno%>">
						</td>
						<td align="right">
							��ע��
						</td>
						<td >
							<textarea rows="6" cols="33" id ="remarks"  name ="remarks" ></textarea>
						</td>
						<td align="right">
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
				<input id="btnAdd" name="btnAdd" class="button1" type="submit"" id="btnAdd" value="����"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
