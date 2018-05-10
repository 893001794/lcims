<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
 <%@ include file="../../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String status = request.getParameter("status");
	if(status == null ){
		status="pc";
	}
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	String command = request.getParameter("command");
	pm =DaoFactory.getInstance().getPhyQuoteManageDao().getAllPhyQuote(pageNo,pageSize,status);
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>����ѧ��Ŀ</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	function addquotemanage(obj){
		if(obj=="pc"){
		window.self.location="phy_addcategory.jsp";
		}else if(obj=="pp"){
		window.self.location="phy_addproduct.jsp";
		}else if(obj =="ps"){
		window.self.location="phy_addstandard.jsp";
		}else if(obj=="psi"){
		window.self.location="phy_addserviceitem.jsp";
		}
	}
	function changeStatus() {
		with (document.getElementById("search")) {
			method = "post";
			action = "myproject.jsp";
			submit();
		}
	}
		
	function cancelproject(sid) {
		if(confirm("ȷ��ȡ����Ŀ?")) {
			window.self.location = "cancelproject.jsp?sid=" + sid;
		}
	}
	function showdialog(sid) {
		window.showModalDialog("../projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}
	function showproject(sid) {
		window.showModalDialog("../projectismethod.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}
	function showflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/flow_manage.jsp";
	}
	
	function modifphyquote(obj) {
		var url ="";
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ�����ݣ�");
			return;
		}
	//alert(document.getElementsByName("selectFlag")[j].value);
		if(obj =="pc"){
			url="phy_addcategory.jsp";
		}
		if(obj =="pp"){
			url="phy_addproduct.jsp";
		}
		if(obj =="ps"){
			url="phy_addstandard.jsp";
		}
		if(obj =="psi"){
			url="phy_addserviceitem.jsp";
		}
		window.self.location = url+"?id=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function addflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?pid=";
	}
	
	function deletephymanage(obj) {
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
				action = "delephyManage.jsp?status="+obj;
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	function topPage() {
		window.self.location = "myproject.jsp?pageNo=1&status=<%=status%>";
	}
	
	function previousPage() {
		window.self.location = "myproject.jsp?pageNo=<%=pm.getPreviousPageNo()%>&status=<%=status%>";
	}	
	
	function nextPage() {
		window.self.location = "myproject.jsp?pageNo=<%=pm.getNextPageNo()%>&status=<%=status%>";
	}
	
	function bottomPage() {
		window.self.location = "myproject.jsp?pageNo=<%=pm.getBottomPageNo()%>&status=<%=status%>";
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
							<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���ӵ������۹���&gt;&gt;��ӱ�����Ϣ</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="myproject.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<div name ="mydiv" id="mydiv">
							��Ʒ���
							<input type="checkbox" name="status" value="pc" onClick="chooseOne(this);"  <%=status.equals("pc")?"checked":"" %> />
							&nbsp;|&nbsp;
							��Ʒ
							<input type="checkbox" name="status" value="pp" onClick="chooseOne(this);"  <%=status.equals("pp")?"checked":"" %>/>
							&nbsp;|&nbsp;
							��׼
							<input type="checkbox" name="status" value="ps" onClick="chooseOne(this);"  <%=status.equals("ps")?"checked":"" %>/>
							&nbsp;|&nbsp;
							������Ŀ
							<input type="checkbox" name="status" value="psi" onClick="chooseOne(this);"  <%=status.equals("psi")?"checked":"" %>/>
						 <script>   
							     function chooseOne(cb) {   
							         var obj = document.getElementById("mydiv");   
							         for (i=0; i<obj.children.length; i++){   
							             if (obj.children[i]!=cb)obj.children[i].checked = false;   
							             //else    obj.children[i].checked = cb.checked;   
							             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
							             else obj.children[i].checked = true;   
							         }   
							         var search=document.getElementById("search");
							         //search.action ="searchquotation.jsp?command=search";
							         search.submit();
							     }   
							 </script>
							 </div>
					</td>
				</tr>

			</table>
			</form>
			<hr width="100%" align="center" size=0>
			<form name="userForm" id="userForm">
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
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						������
					</td>
					<td class="rd6" >
						Ӣ����
					</td>
				<%if(status.equals("pc")){
					%>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						������Ϣ
					</td>
					<%
				}else if(status.equals("pp")){
					%>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						������Ϣ
					</td>
					<td class="rd6" >
						��Ʒ���
					</td>
					<%
				}else if(status.equals("ps")){
					%>
					<td class="rd6" >
						��׼��
					</td>
					<td class="rd6" >
						����ʵ����
					</td>
					<td class="rd6" >
						��Ч��
					</td>
					<td class="rd6" >
						ʧЧʱ��
					</td>
					<%
				}else if(status.equals("psi")){
					%>
					<td class="rd6" >
						����ʵ����
					</td>
						<td class="rd6" >
						�����г�
					</td>
					<td class="rd6" >
						��׼
					</td>
					<td class="rd6" >
						������
					</td>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						��ƷҪ��
					</td>
					<%
				} %>
				</tr>
				<%
				List rows = pm.getList();
				for(int i=0;i<rows.size();i++) {
					List columns = (List)rows.get(i);
				 %>
				<tr>
					<%
					for(int j=0;j<columns.size();j++){
						if(j==0){
						%>
						<td class="rd8">
							<input type="checkbox" name="selectFlag" class="checkbox1"
								value="<%=columns.get(0) %>">
						</td>
						<%}else {
						%>
						<td class="rd8">
						<%=columns.get(j) %>
						</td>
						<%
						} %>
						<%
						}
						 %>
					
				</tr>
				
				<%
				}
				 %>
				
			</table>
			<table width="95%" height="30" border="0" align="center"
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
								&nbsp;	
							<input value ="���" class="button1" type="button" onClick="addquotemanage('<%=status%>');">		
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸� " onClick="modifphyquote('<%=status%>')">
							<%
						if(user.getTicketid().matches("11111111")) {
					%>
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="ɾ��" onClick="deletephymanage('<%=status%>')">
					<%
						}
					 %>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
