<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="java.util.ArrayList"%>
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
	FinanceQuotationUtil fqu = new FinanceQuotationUtil();
	String status=request.getParameter("status");
	fqu.setPid(pid==null?"":pid);
	fqu.setPageNo(pageNo);
	fqu.setPageSize(pageSize);
	fqu.setStatus(status);
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
		<title>�������</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../../css/css1.css" type="text/css"
			media="screen">
		<script language="JavaScript" type="text/JavaScript">
	function delpay() {
		if (confirm("ȷ��Ҫɾ������"))
			return true;
		else
			return false;
	}
	
	function detail(){
		//alert(first);
		self.location="confirmdialog.jsp";
		//window.open("confirmdialog.jsp");
	}
	function lock1(Object,lock){//����
		var myForm =document.getElementById("form1");
		// var lock =document.getElementById("lock").value;
		self.location="quotationlog.jsp?pid="+Object+"&type=1&pageNo=1";
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="post"
			action="quotation_confirm.jsp">
			<table width="98%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th width="20%" height="25">
						���۵���
					</th>
					<th width="20%" height="25">
						����
					</th>
					<%--
      <th width="25%">�ͻ�����</th>
      <th width="15%">�տʽ </th>
      <th width="25%">����Ӧ��ʱ��</th>
  --%>
					<th width="13%">
						&nbsp;
					</th>

				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=pid type="text" id="pid" size="20" maxlength="50">
					</td>
					<td>
						<%if(!userName.equals("֣�")){%>
					������
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
					
					<%}  %>
					</td>
					<%--
      <td><input name="client" type="text" id="client" size="20" maxlength="50" value=""></td>
      
      <td><select name="paytype" id="paytype">
		<option value="�½�" >�½�</option>
		<option value="ȫ��Ԥ��" >ȫ��Ԥ��</option>
		<option value="����Ԥ��" >����Ԥ��</option>
		<option value="��ɺ�ȫ��" >��ɺ�ȫ��</option>
		<option value="����" >����</option>
      </select></td>
      
      <td><input name="rptime" type="text" id="rptime" size="12" maxlength="12" readonly value=""> 
        <input name="button" type="button" onclick="popUpCalendar(this, form1.rptime, 'yyyy-mm-dd')" value="��ѡ������"></td>
      --%>
					<td>
						<input type="button" onclick="detail()"  value="�յ�ȷ��">
						<input type="submit" name="Submit" value="�ύ">
						
						<input type="reset" name="Submit2" value="����">
					</td>
				</tr>
			</table>
		</form>
		<table width="98%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					�����嵥�������
				</th>
			</tr>
			<tr>
				<td width="3%" height="25" class=forumrow>
					<div align="center">
						ID
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						���۵���
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						�ͻ�����
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						�ͻ�Ҫ��ʱ��
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						���۽��(Ԫ)
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						���ս��(Ԫ)
					</div>
				</td>
				<td width="7%" class=forumrow>
					<div align="center">
						�տʽ
					</div>
				</td>
				<td width="7%" class=forumrow>
					<div align="center">
						���۴���
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						״̬
					</div>
				</td>
				<td width="10%" class=forumrow>
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
						String lockStr="����";
						if(qt.getLock() !=null && qt.getLock() !=""){
							if(qt.getLock().equals("y")){
								lockStr="����";
							}
						}
			%>

			<tr>
				<td height="25">
					<div align="center">
						<%=i%>
					</div>
				</td>
				<td height="25">
					<div align="center">
						<%=qt.getPid()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getClient()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getCompletetime() == null ? ""
							: new SimpleDateFormat("yyyy-MM-dd HH:mm")
									.format(qt.getCompletetime())%>
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
						<%=qt.getPreadvance() == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(qt
									.getPreadvance())%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getAdvancetype()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getSales()%>
					</div>
				</td>
				<td>
					<div align="center">
					<%
					if("δ�յ�".equals(qt.getEconfrim())) {
					 %>
						<font color="red"><%=qt.getEconfrim()%></font>
					<%
					} else {
					 %>
					 <font color="green"><%=qt.getEconfrim()%></font>
					<%} %>
					</div>
				</td>
				<td>
				<%
				if("δ�յ�".equals(qt.getEconfrim())) {
				 %>
					<div align="center">
						<a href="../../quotation/detail.jsp?pid=<%=qt.getPid()%>"
							style="color: blue">ȷ��</a>
					</div>
				<%} %>

				</td>
			</tr>
			<%
				}
				}
			%>
			<tr style="background-color: #E0F8E0">
				<td height="25" colspan="10" align="left">
					<div align="center">
						��¼��������<%=pm.getTotalRecords()%>
						��ǰҳ/��ҳ��:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a href="quotation_confirm.jsp?pageNo=1&pid=<%=fqu.getPid()%>&status=<%=fqu.getStatus()%>"
							class="red">��ҳ</a>
						<a
							href="quotation_confirm.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=fqu.getPid()%>&status=<%=fqu.getStatus()%>"
							class="red">��һҳ</a>
						<a
							href="quotation_confirm.jsp?pageNo=<%=pm.getNextPageNo()%>&pid=<%=fqu.getPid()%>&status=<%=fqu.getStatus()%>"
							class="red">��һҳ</a>
						<a
							href="quotation_confirm.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=fqu.getPid()%>��&status=<%=fqu.getStatus()%>"
							class="red">ĩҳ</a>
					</div>
				</td>
			</tr>
		</table>