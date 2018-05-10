<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	String start = request.getParameter("start");
	//��ȡʱ��
	String endDate=request.getParameter("end");
	String startD=request.getParameter("startD");
	PageModel  pm ;
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}

	FinanceQuotationUtil fqu = new FinanceQuotationUtil();
	fqu.setStart(startD==null?"":startD);
	fqu.setEnd(endDate==null?"":endDate);
	fqu.setPageNo(pageNo);
	fqu.setPageSize(pageSize);
	pm = QuotationAction.getInstance().getAllBills(pageNo,pageSize,start,fqu);
	if (pm == null) {
		pm = new PageModel();
	}
 %>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>������</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
			<link rel="stylesheet" href="../../css/css1.css" type="text/css"
			media="screen">
	</head>

	<body class="body1">
	<form name="form1" method="post" action="showbills_manage.jsp?start=<%=start%>">
			<table width="98%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
			<td>
				��ʼʱ��
				</td>
					<td>
						<input name="startD" type="text" id="startD" size="20" maxlength="50"
							value="">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'startD'})"
							src="../../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</td>
			<td>
				����ʱ��
				</td>
					<td>
						<input name="end" type="text" id="end" size="20" maxlength="50"
							value="">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})"
							src="../../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</td>

					<td>
						<input type="submit" name="Submit" value="�ύ" >
					</td>
				</tr>
			</table>
		</form>
	
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�������&gt;&gt;ǩ���鿴</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					
					<td class="rd6" >
						���۵����
					</td>
					<td class="rd6" >
						�ͻ�����
					</td>
					<td class="rd6" >
						��Ŀ����
					</td>
					<td class="rd6" >
						���۽��
					</td>
					<td class="rd6" >
						���ս��
					</td>
					<td class="rd6" >
						Ԥ���ְ���
					</td>
					<td class="rd6" >
						Ԥ��������
					</td>
					<td class="rd6" >
						ǩ����ʱ��
					</td>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						������Ŀ
					</td>
					<td class="rd6">
						״̬
					</td>
					
				</tr>
				
				<%
				List<Quotation> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Quotation qt = list.get(i);
				 %>
				
				<tr>
					
					
					<td class="rd8">
						<%=qt.getPid() %>
					</td>
					<td class="rd8">
						<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client == null) {
								client = new ClientForm();
							}
						 %>
						
						<%=client.getName() %>
						
					</td>
					<td class="rd8">
						<span class="short"><%=qt.getProjectcontent() %></span>
					</td>
					<td class="rd8">
						<%=qt.getTotalprice() %>
					</td>
					<td class="rd8">
						<%=qt.getPreadvance() + qt.getSepay() + qt.getBalance() %>
					</td>
					<td class="rd8">
						<%=qt.getPresubcost() %>
					</td>
					<td class="rd8">
						<%=qt.getPreagcost() %>
					</td>
					<td class="rd8">
						<%=qt.getCreatetime() %>
					</td >
					<td class="rd8">
						<%=qt.getSales() %>
					</td>
					<td class="rd8">
						<%=qt.getProjectcount() %>
					</td>
					<td class="rd8">
						<%=qt.getStatus() %>
					</td>					
				</tr>
				
				<%
				}
				 %>
				
			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr style="background-color: #E0F8E0">
				<td height="25" colspan="12" align="left">
					<div align="center">
						��¼��������<%=pm.getTotalRecords()%>
						��ǰҳ/��ҳ��:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a
							href="showbills_manage.jsp?pageNo=1&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&startD=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&start=<%=start%>"
							class="red">��ҳ</a>
						<a
							href="showbills_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&startD=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&start=<%=start%>"
							class="red">��һҳ</a>
						<a
							href="showbills_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&startD=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&start=<%=start%>"
							class="red">��һҳ</a>
						<a
							href="showbills_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&startD=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&start=<%=start%>"
							class="red">ĩҳ</a>
					</div>
				</td>
			</tr>
			</table>
	</body>
</html>
