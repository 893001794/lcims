<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@ include file="../comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = new PageModel();
	int salesid = user.getId();
	List list = null;
	String pid="";
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		String parttype = request.getParameter("parttype");
		 pid = request.getParameter("pid");
		pm = QuotationAction.getInstance().getAllSample(pageNo,pageSize,pid);
		}else{
		 pm = QuotationAction.getInstance().getAllSample(pageNo,pageSize,"");
		}
	
   
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���۱��۵�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	
	function printorder() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ��ӡ�Ķ�����");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ�ܴ�ӡһ�ݶ�����");
			return;
		}
		window.showModelessDialog("printorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" + pid);
	}
	
	function addOrder() {
		
		window.self.location = "modifypackage.jsp";	
	}
	
	

	function topPage() {
		window.self.location = "sampleRegistration.jsp.jsp?pageNo=1&command=<%=command%>&pid=<%=pid%>";
	}
	
	function previousPage() {
		window.self.location = "sampleRegistration.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&pid=<%=pid%>";
	}	
	
	function nextPage() {
		window.self.location = "sampleRegistration.jsp?pageNo=<%=pm.getNextPageNo()%>&command=<%=command%>&pid=<%=pid%>";
	}
	
	function bottomPage() {
		window.self.location = "sampleRegistration.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=<%=command%>&pid=<%=pid%>";
	}
	
<%---------------------������ݵ�EXCEL�ĵ�start---------------------%>
	
	<%---���ȫ��δ�����Ŀ��EXCEL�ĵ�---%>
	function nofinishex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---������սӵ���ϸ��EXCEL�ĵ�---%>
	function todayex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---���ȫ��δ��ɷְ���TUV��Ŀ��EXCEL�ĵ�---%>
	function notuvex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---�����ݸδ�����Ŀ��EXCEL�ĵ�---%>
	function dgnoex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---����ٵ����ٵ�Ԥ����EXCEL�ĵ�---%>
	function warnex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---����Ѿ���ɵ�����δ������EXCEL�ĵ�---%>
	function nosendex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
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
						<td width="1150" class="p1" height="17" nowrap>
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>LC-WS-CM-016
						</td>
						<td width="522" class="p1" height="17" nowrap>
							<b>�汾�ţ�1.0
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=sampleRegistration.jsp?command=search >
				<table width="973" border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em;" height="70">
					<tr>
						<td width="50%">
						
							<font color="red">�����뱨�۵��ţ�</font>
							
							<input type=submit name=Submit value=����>
						
						</td>
						
					</tr>
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>

			<table width="100%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��Ʒ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="100%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" width="50">
						�ֹ�˾
					</td>
					<td class="rd6" >
						�ͻ���˾����
					</td>
					<td class="rd6" >
						�Ӱ�����
					</td>
					<td class="rd6" >
						������Ʒ
					</td>
					<td class="rd6" >
						������Ŀ
					</td>
					<td class="rd6" >
						������
					</td>
					<td class="rd6" >
						��������
					</td>
					<td class="rd6" width="50">
						���Ե���
					</td>
					<td class="rd6">
						��ʵ����ʱ��
					</td>
					<td class="rd6">
						Ӧ������ʱ��
					</td>
					<td class="rd6">
						���۵���
					</td>
					<td class="rd6">
						���۽��
					</td>
					<td class="rd6">
						����״̬
					</td>
					<td class="rd6">
						�������
					</td>
					<td class="rd6">
						��Ʊ����
					</td>
					<td class="rd6">
						������Ա
					</td>
					<td class="rd6">
						��ע
					</td>
					<td class="rd6">
						���淢������
					</td>
				</tr>
				
				<%
				list = pm.getList();
				for(int i =0;i<list.size();i++){
				Project p=new Project();
				ChemProject cp =new ChemProject();
				Flow f=new Flow();
				p =(Project)list.get(i);
				Quotation qu =(Quotation)p.getObj();
				cp =(ChemProject)p.getObjcp();
				f=(Flow)p.getObjf();
				 %>
				
				<tr>
					
					<td class="rd8">
						<%=qu.getCompany() %>
					</td>
					<td class="rd8">
						<%=qu.getClient() %>
					</td>
					<td class="rd8">
						<%=p.getBuildtime() ==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime() ) %>
					</td>
					<td class="rd8">
						<%=cp.getSamplename() %>
					</td>
					<td class="rd8">
						<%=qu.getProjectcontent()%>
					</td>
					<td class="rd8">
						<%=p.getRid() %>
					</td>
					<td class="rd8">
						<%=p.getLevel() %>
					</td>
					<td class="rd8">
						<%=f.getTestcount() %>
					</td>
					<td class="rd8">
						<%=cp.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getCreatetime()) %>
					</td>
					<td class="rd8">
						<%=qu.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qu.getCompletetime()) %>
					</td>
					<td class="rd8">
						<%=qu.getPid()%>
					</td>
					<td class="rd8">
						<%=qu.getTotalprice()%>
					</td>
					<td class="rd8">
						<%=qu.getAdvancetype()%>
					</td>
					<td class="rd8">
						<%=qu.getPreadvance()%>
					</td>
					<td class="rd8">
						<%=qu.getInvtime()%>
					</td>
					<td class="rd8">
						<%=qu.getSales()%>
					</td>
					<td class="rd8">
						<%=qu.getTag()%>
					</td>
					<td class="rd8">
					<%=cp.getSendtime() ==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getSendtime()) %>
					</td>

				
				</tr>
				
				<%
				}
			
				 %>
				
				
			</table>
			<table width="100%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;��&nbsp; <%=pm.getTotalPages() %> &nbsp;ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">��ǰ��</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="��ҳ"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="��ҳ"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="��ҳ" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
								onClick="bottomPage()">
							
							
						</div>
					</td>
				</tr>
			</table>
			
			<br>
	<div align="center">
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="��ӡ����" onClick="printorder()">
	</div>
	<div align="center">
		��Ч���ڣ�
	</div>
		
	</body>
</html>
