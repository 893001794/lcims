<%@page import="com.lccert.crm.dao.impl.ArticleDaoImpl"%>
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
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Depot"%>
 <%@ include file="../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String status = "";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	//String command = request.getParameter("command");
	//if (command != null && "search".equals(command)) {
		//pid = request.getParameter("pid");
		//pm =DaoFactory.getInstance().getDepotDao().searchAllDepot(pageNo,pageSize);
	//} else {
		pm =DaoFactory.getInstance().getDepotDao().searchAllDepot(pageNo,pageSize);
	//}
	
	
	
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>����ѧ��Ŀ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
		
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
	
	function printproject(){
	var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ��ӡ���ݵ����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ�ܴ�ӡһ�����ݣ�");
			return;
		}
	//alert(document.getElementsByName("selectFlag")[j].value);
		window.self.location = "printarticle.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function modifyproject() {
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
		window.self.location = "modifyarticle.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function addflow() {
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?pid=";
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
		//alert(document.getElementsByName("selectFlag")[i].value);
				action = "article_post.jsp?status=del&id="+document.getElementsByName("selectFlag")[i].value;
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
		window.self.location = "article_manage.jsp?pageNo=1&pid=<%=pid%>";
	}
	
	function previousPage() {
		window.self.location = "article_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=pid%>";
	}	
	
	function nextPage() {
		window.self.location = "article_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&status=<%=status%>";
	}
	
	function bottomPage() {
		window.self.location = "article_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=pid%>";
	}
	
function showdialog(url,name,iWidth,iHeight)
{
var url; //ת����ҳ�ĵ�ַ;
var name; //��ҳ���ƣ���Ϊ��;
var iWidth; //�������ڵĿ��;
var iHeight; //�������ڵĸ߶�;
var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
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
							<b>��Ʒ����&gt;&gt;������Ʒ</b>
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
						
							<font color="red">�����뱨�۵��ţ�</font>
							<input id="pid" type="text" name="pid" size="40"  />
							<input type=submit name=Submit value=����>
							<script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
						            delay:10,
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
				</tr>
			</table>
			</form>
			
			
			
			
			<hr width="100%" align="center" size=0>
			<form name="userForm" id="userForm">
			<input name="pid" type="hidden" value="<%=pid %>" />
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right">&nbsp;&nbsp;|&nbsp;&nbsp;<a href="article.jsp">�����Ʒ�б�</a></div>
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
						�ʲ����
					</td>
					<td class="rd6" >
						��Ʒ����
					</td>
					<td class="rd6" >
						��Ʒ���
					</td>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						ʹ������
					</td>
					<td class="rd6" width="6%" >
						������Դ
					</td>
					<td class="rd6" >
						��Ʊ
					</td>
					
					<td class="rd6" >
						��Ӧ��
					</td>
					
				</tr>
				
				<%
				List<Depot> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Depot depot = list.get(i);
				 %>
				
				<tr>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=depot.getId()%>">
					</td>
					<td class="rd8">
						<%=depot.getDid() %>
					</td>
					<td class="rd8">
						<%=DaoFactory.getInstance().getArticleDao().getNameById(depot.getAid()) %>
					</td>
					<td class="rd8">
						<%=depot.getPrice() %>
					</td>
					<td class="rd8">
						<%=depot.getNumber()%>
					</td>
					<td class="rd8">
						<%=depot.getUserdate() %>
					</td>
					<td class="rd8">
						<%=depot.getFundstype()%>
					</td>
					<td class="rd8">
						<%=depot.getInvoicecode()%>/<%=depot.getInvoiceno() %>
					</td>
					<td>
						<%=depot.getClient() %>
					</td>
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
														
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸���Ŀ" onClick="modifyproject();">
								
								<input name="btnPrint" class="button1" type="button"
								id="btnPrint" value="��ӡ" onClick="printproject();">
							<%
						if(user.getTicketid().matches("11111111")|| user.getId()==169) {
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
	</body>
</html>
