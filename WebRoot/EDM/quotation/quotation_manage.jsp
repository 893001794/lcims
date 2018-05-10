<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.user.UserForm"%>

<%

	
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	
	}
	PageModel pm = null;
	String pid = request.getParameter("pid");

	String price = request.getParameter("price");
	String client = request.getParameter("client");
	if(client != null && !"".equals(client)) {
		client = new String(client.getBytes("iso-8859-1"),"GBK");
	} 
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String status=request.getParameter("status");
	FinanceQuotationUtil fqu = new FinanceQuotationUtil();
	fqu.setPid(pid==null?"":pid);
	fqu.setPrice(price==null?"":price);
	fqu.setClient(client==null?"":client);
	fqu.setStart(start==null?"":start);
	fqu.setEnd(end==null?"":end);
	fqu.setStatus(status==null?"":status);
	fqu.setPageNo(pageNo);
	fqu.setPageSize(pageSize);
	UserForm user = (UserForm)session.getAttribute("user");
	//boolean flag =user.getTicketid().matches("00010101");
	String userName =user.getName();
	if(userName.equals("֣�")){
	fqu.setStatus("LCQD");
	}
	//else if(flag == true){
	//fqu.setStatus("LCQG");
	//}

	pm = FinanceQuotationAction.getInstance().searchQuotations(fqu,"");

	
	
	if (pm == null) {
		pm = new PageModel();
	}
%>

<html>
	<head>
		<title>�����嵥</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../../css/css1.css" type="text/css"
			media="screen">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<script language="JavaScript" type="text/JavaScript">
function delpay()
{
   if(confirm("ȷ��Ҫɾ������"))
     return true;
   else
     return false;	 
}

	function changeStatus() {
			var  myform =document.getElementById("form1");
			myform.method = "post";
			myform.action = "quotation_manage.jsp";
			myform.submit();
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="get" action="quotation_manage.jsp">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th height="25">
						���۵���
					</th>
					<th>
						���۽��
					</th>
					<th>
						�ͻ�����
					</th>
					<th>
						��ʼʱ��
					</th>
					<th>
						����ʱ��
					</th>
					<th>
						����
					</th>

					<th>
						&nbsp;
					</th>

				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=pid type="text" id="pid" size="20" maxlength="50"
							value="">
					</td>
					<td>
						<input name=price type="text" id="price" size="20" maxlength="50"
							value="">
					</td>
					<td>
						<input name=client type="text" id="client" size="20"
							maxlength="50" value="">
					</td>
					<td>
						<input name="start" type="text" id="start" size="20"
							maxlength="50" value="">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'start'})"
							src="../../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</td>

					<td>
						<input name="end" type="text" id="end" size="20" maxlength="50"
							value="">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})"
							src="../../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</td>
<%if(!userName.equals("֣�")){%>
					<td>������
							<select name="status" style="width: 100px" onchange="changeStatus()">
							<option value="">
									ȫ��
							</option>
								<option value="LCQ1">
									��ɽ����һ
								</option>
								<option value="LCQ2">
									��ɽ���۶�
								</option>
								<option value="LCQG">
									����
								</option>
								<option value="LCQD">
									��ݸ
								</option>
							</select>
							
					</td>
					<%}  %>
					<td>
						<input type="submit" name="Submit" value="�ύ">
						<input type="reset" name="Submit2" value="����">
					</td>
					
				</tr>
			</table>
		</form>
		<table width="98%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="11">
					�����嵥�������
				</th>
				<th height="25" >
					<a href="edm_manage.jsp">����ͳ��</a>
				</th>
			</tr>
			<tr>
				<td height="25" class=forumrow>
					<div align="center">
						ID
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						���۵���
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						�ͻ�����
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						��������
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						���۽��(Ԫ)
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						���ս��(Ԫ)
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						�տʽ
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						���۴���
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						��˾
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						�յ�����
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						״̬
					</div>
				</td>
				<td class=forumrow >
					<div align="center">
						����
					</div>
				</td>
			</tr>

			<%
				List<Quotation> list = pm.getList();
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						Quotation qt = list.get(i);
			%>

			<tr>
				<td height="25">
					<div align="center">
						<%=i%>
					</div>
				</td>
				<td height="25">
					<div align="center">
						<a href="quotationdetail.jsp?pid=<%=qt.getPid()%>"><font
							color="red"><%=qt.getPid()%></font>
						</a>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getClient()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getCreatetime() == null ? ""
							: new SimpleDateFormat("yyyy-MM-dd HH:mm")
									.format(qt.getCreatetime())%>
					</div>
				</td>
				<td>
					<div align="right">
						<%=qt.getTotalprice() == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(qt
									.getTotalprice())%>
					</div>
				</td>
				<td>
					<div align="right">
						<%
						
						float preprice = qt.getPreadvance() + qt.getSepay() + qt.getBalance();
						 %>
						<%=preprice == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(preprice)%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getAdvancetype() == null ? "" : qt
							.getAdvancetype()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getSales()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getCompany()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getConfirmtime() == null ? ""
							: new SimpleDateFormat("yyyy-MM-dd HH:mm")
									.format(qt.getConfirmtime())%>
					</div>
				</td>
				<td>
					<div align="center">
						<font color="red"><%=qt.getStatus()%></font>
					</div>
				</td>
				<td>
					<div align="center">
						<%
							if (qt.getAcount() == 0) {
						%>
						<a
							href="quotationlog.jsp?pid=<%=qt.getPid()%>&pageNo=<%=pm.getPageNo()%>&type=1"
							style="color: blue">�Ǽǿ���</a>
						<%
							} else {
						%>
						<a href="quotationdetail.jsp?pid=<%=qt.getPid()%>&type=1"
							style="color: blue">�鿴</a>
						<%
							}
						%>
						
						<%if(user.getName().equals("�ຣɺ[Kitty]")){
					%>
					
					<a href="quotationlog.jsp?pid=<%=qt.getPid()%>&pageNo=<%=pm.getPageNo()%>&type=modi"
							style="color: blue">�޸�</a>
					<%
					} %>
					</div>
					
				</td>
			</tr>
			<%
				}
				}
			%>
			<tr style="background-color: #E0F8E0">
				<td height="25" colspan="12" align="left">
					<div align="center">
						��¼��������<%=pm.getTotalRecords()%>
						��ǰҳ/��ҳ��:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a
							href="quotation_manage.jsp?pageNo=1&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&status=<%=fqu.getStatus()%>"
							class="red">��ҳ</a>
						<a
							href="quotation_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&start=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&status=<%=fqu.getStatus()%>"
							class="red">��һҳ</a>
						<a
							href="quotation_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&start=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&status=<%=fqu.getStatus()%>"
							class="red">��һҳ</a>
						<a
							href="quotation_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&start=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&status=<%=fqu.getStatus()%>"
							class="red">ĩҳ</a>
					</div>
				</td>
			</tr>
		</table>