<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>

<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>

<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	Quotation qt = null;
	String pid = null;
	String rid = null;
	float totalprice = 0;
	Flow f=null;
	if (command != null && "search".equals(command)) {
		
		rid=request.getParameter("rid");
		if(!(pid == null || "".equals(pid))) {
			pid = pid.trim();
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
			f = FlowAction.getInstance().getFlowByPid(pid);
		}
		if(!(rid == null || "".equals(rid))){
		//����rid����ѯpid
		rid =rid.trim();
		pid =FlowAction.getInstance().getPidByRid(rid);
		qt = QuotationAction.getInstance().getQuotationByPid(pid);
		//f = FlowAction.getInstance().getFlowByPid(pid);
		List list= FlowAction.getInstance().getFlowByRid(rid);
		for(int i=0;i<list.size();i++){
		f= (Flow)list.get(i);
		}
		}
	}
	
	if(qt == null) {
		qt = new Quotation();
	}
	if(f == null){
	f =new Flow();
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���۹���</title>
		<link rel="stylesheet" href="../css/drp.css">
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	
	function buildproject() {
		window.self.location = "addproject.jsp?up=add&&rid=<%=rid%>";	
	}
	function goBack() {
		window.history.back();
	}
</script>

	</head>

	<body class="body1">

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
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>���̹���&gt;&gt;���ɲ�����Ŀ</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>


			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=project_chemistry_manage.jsp
							autocomplete="off">
							<input type="hidden" name="command" value="search" />
							<font color="red">�����뱨���ţ�</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=����>
							 <script>   
						        $("#rid").autocomplete("../vrid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>   
							<input type="hidden" name=type size="25" value="all" />

						</form>
					</td>
					
				</tr>

			</table>

			<hr width="100%" align="center" size=0>
		</div>

		<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
			<tr>
				<td class="rd6">
					������
				</td>
				<td  class="rd6">
				������Ŀ����
				</td>
				<td  class="rd6">
					����������Ա
				</td>
				<td class="rd6">
					�ͻ�����
			</tr>
			<tr align="center">
				<td class="rd8"><%=f.getRid()==null?"":f.getRid() %></td>
				<td class="rd8">
				<%=qt.getProjectcontent() %>
				</td>
				<td class="rd8">
				<%=qt.getSales() %>
				</td>
				<td class="rd8">
					<%=qt.getClient()%>
				</td>
			</tr>
		</table>
		<br><div align="center">
		<input name="btnAdd" type="button" class="button1" id="btnAdd" value="��Ӳ��Ա�" onClick=buildproject();>
							&nbsp;&nbsp;&nbsp;
			<input name="btnAdd" type="button" class="button1" id="btnAdd"
				value="����" onClick="goBack();">
		</div>

	</body>
</html>
