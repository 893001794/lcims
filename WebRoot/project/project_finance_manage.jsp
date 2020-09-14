<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@ include file="../comman.jsp"  %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	List<Project> list = new ArrayList<Project>();
	Quotation qt = null;
	String pid = null;
	float totalprice = 0;
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid");
		if(!(pid == null || "".equals(pid))) {
			pid = pid.trim();
			list = ProjectAction.getInstance().getAllProjectByPid(pid);
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
		}
	}
	
	if(qt == null) {
		qt = new Quotation();
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
	
	function buildproject(obj) {
		window.self.location = "addstatement.jsp?command=search&free=n&pid=<%=pid%>&status="+obj;	
	}
	
	function addproject() {
		window.self.location = "addstatement.jsp?command=search&free=y&pid=<%=pid%>";	
	}
	
	function modifyUser() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ��û����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ���û����ݣ�");
			return;
		}
	
		window.self.location = "modifyquotation.jsp?pid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteProject() {
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("��ѡ����Ҫɾ�����û����ݣ�");
			return;
		}
		if (window.confirm("�Ƿ�ȷ��ɾ��ѡ�е����ݣ�")) {
			//ִ��ɾ��
			with (document.getElementById("userForm")) {
				method = "post";
				action = "deleteproject.jsp"
				submit();
			}
		}
	}
	
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
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
						<b>���۹���&gt;&gt;��Ŀ�ֽ�</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>


			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=project_finance_manage.jsp
							autocomplete="off">
							<input type="hidden" name="command" value="search" />
							<font color="red">�����뱨�۵��ţ�</font>
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=����>
							 <script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
						            delay:10,
						            minChars:4,
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

		<table width="95%" height="20" border="0" align="center"
			cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="2pt" style="font-weight: bolder">���۵����</font>
				</td>
				<td width="49%" class="rd6">
					<font size="2pt" style="font-weight: bolder">�ͻ�����</font>
			</tr>
			<tr align="center">
				<td class="rd8"><%=qt.getPid()==null?"":qt.getPid() %></td>
				<%
					ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
					if(client == null) client = new ClientForm();
				%>
				<td class="rd8">
					<a
						href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient()==null?"":qt.getClient() %></a>
				</td>
			</tr>
		</table>
		<p>
			&nbsp;
		</p>

		<form name="userform" id="userform">
			<input name="pid" type="hidden" value="<%=qt.getPid() %>" />
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��Ŀ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6">
						<input type="checkbox" name="ifAll" id="ifAll"
							onClick="checkAll()">
					</td>
					<td class="rd6">
						�ڲ����˵���
					</td>
					<td class="rd6">
						��Ŀ����
					</td>
					<td class="rd6">
						����Ŀ���
					</td>
					<td class="rd6">
						Ԥ���ְ���
					</td>
					<td class="rd6">
						״̬
					</td>
					<td class="rd6">
						����
					</td>
				</tr>

				<%
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						String status = "";
						totalprice += p.getPrice();
						//--------------------------2010-12-15-------------------------
						if(!("��ѧ����".equals(p.getPtype())||"��ױƷ".equals(p.getPtype())||"����".equals(p.getPtype()))) {
							PhyProject pp = (PhyProject)p.getObj();
							status = pp.getStatus();
						}
						 else {//--------------------------2010-12-15-------------------------
							ChemProject cp = (ChemProject)p.getObj();
							status = cp.getStatus();
						}
				 %>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid() %>">
					</td>
					<td class="rd8">
						<%=p.getSid() %>
					</td>
					
					<td class="rd8">
						<%=p.getPtype() %>
					</td>
					
					<td class="rd8">
						<div align="right"><%=p.getPrice() %>&nbsp;</div>
					</td>
					<td class="rd8">
						<div align="right"><%=p.getPreagcost() %>&nbsp;</div>
					</td>
					
					
					<td class="rd8">
						<font color="red">
						<%=status %>
						</font>
					</td>
					<td class="rd8">
					<%
					
						if(("����".equals(status) || user.getTicketid().matches("\\d\\d\\d\\d1\\d\\d\\d"))&&(qt.getLock()!=null&&qt.getLock().equals("n"))) {
					 %>
						[<a href="modifystatement.jsp?id=<%=p.getId() %>">�޸�</a>]
					<%
						}
					 %>
					</td>

				</tr>

				<%
					}
				}
				 %>


			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;��&nbsp; &nbsp;ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">��ǰ��</font>&nbsp;
							<font color="#FF0000" size="2pt"></font>&nbsp;
							<font color="#FFFFFF" size="2pt">ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
						<%
						if(user.getTicketid().matches("11111111")||user.getId()==103) {
					%>
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="ɾ��" onClick="deleteProject()">
					<%
						}
					 %>
						</div>
					</td>
				</tr>
			</table>

		</form>
					
		<div align="center">
						<%
						System.out.println(qt.getLock());
						if(qt !=null ){
							if(qt.getLock()!=null&&qt.getLock().equals("n")){
							//��Ŀ�ı��۽��Ϊ0���߱��۽���������Ŀ�����ߵ�ǰ��¼�û�Ϊadmin
								 if(qt.getTotalprice() == 0 ||qt.getTotalprice() != totalprice || "admin".equals(user.getName())) {
								 %>
										<input name="btnAdd" type="button" class="button1" id="btnAdd"
											value="�ֽ���Ŀ" onClick="buildproject('only')";>
										&nbsp;&nbsp;&nbsp;
										<input name="btnAdd" type="button" class="button1" id="btnAdd"
											value="�����ֽ�" onClick="buildproject('batch')";>
										&nbsp;&nbsp;&nbsp;
								 <%
								 }
								 if(user.getTicketid().matches("\\d\\d\\d\\d1\\d\\d\\d")) {
								 %>
									
										<input name="btnAdd" type="button" class="button1" id="btnAdd"
											value="����޸ı���" onClick=addproject();>
										&nbsp;&nbsp;&nbsp;
								 <%
								 }
							  
							}
						}
						%>
					
			<input name="btnAdd" type="button" class="button1" id="btnAdd"
				value="����" onClick="goBack();">
		</div>

	</body>
</html>
