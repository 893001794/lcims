<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	String eitem="";
	if(user.getDept().equals("��ѧ���̲�")){
	eitem="��Ʒ";
	}
	String command = request.getParameter("command");
	List<Project> list = null;
	Quotation qt = null;
	if (command != null && "search".equals(command)) {
		String type = request.getParameter("type");
		String keywords = request.getParameter("keywords");
		String rid =request.getParameter("rid");
		if(rid !=null && !"".equals(rid)){
		keywords=ProjectChemImpl.getInstance().getPidByRid(rid);
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"",rid,"",eitem);
			qt = QuotationAction.getInstance().getQuotationByPid(keywords);
		}
		else if(!(keywords == null || "".equals(keywords))) {
			pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,keywords,"","",eitem);
			qt = QuotationAction.getInstance().getQuotationByPid(keywords);
		}
	} else {
		pm = ChemProjectAction.getInstance().searchChemProjects(pageNo,pageSize,"","","",eitem);
	}
	
	list = pm.getList();
	
	if(qt == null) {
		qt = new Quotation();
	}
	

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>�����ת��</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	
	
	
	function modifyflow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�����ת������Ŀ��");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ��ѡ��һ����Ŀ��");
			return;
		}
	
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?rid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	
	
	
	
	function deleteUser() {
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
				action = "quotationlist.jsp?command=delete"
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
		window.self.location = "searchproject.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "searchproject.jsp?pageNo=<%=pm.getPreviousPageNo()%>";
	}	
	
	function nextPage() {
		window.self.location = "searchproject.jsp?pageNo=<%=pm.getNextPageNo()%>";
	}
	
	function bottomPage() {
		window.self.location = "searchproject.jsp?pageNo=<%=pm.getBottomPageNo()%>";
	}
	
	function buil(){
		var flag =false;
		var result="";
		var check = document.getElementsByName("selectFlag");
		for(var i=0;i<check.length;i++){
		if(check[i].checked==true){
			flag =true;
			result+=check[i].value+",";
		}
	    }
	    if(flag == false){
	   		alert("��ѡ��Ҫ�ŵĵ�������");
	   	}else{
	   		window.self.location="../flow/addflow.jsp?command=search&type=batch&sid="+result;
	   		
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
					<td width="522" class="p1" height="17" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>��ѧ��Ŀ����&gt;&gt;�����ת��</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>



	<form name=search method=post action=searchproject.jsp?command=search autocomplete="off">
			<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 13em">
					<tr>
						<td valign=middle width=50%>
					
							<font color="red">�����뱨�۵��ţ�</font>
							<input id="keywords" type="text" name="keywords" size="40" />
							<input type=submit name=Submit value=����>
							<script>   
						        $("#keywords").autocomplete("../../pid_ajax.jsp",{
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
							<input type="hidden" name=type size="25" value="pid" />
							
							
							
						
						</td>
					</tr>
					
					
					
					<tr>
						<td valign=middle width=50%>
					
							<font color="red">�����뱨���ţ�</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=����>
							 <script>   
						        $("#rid").autocomplete("../../vrid_ajax.jsp",{
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
					</td>
					</tr>
					
				</table>

</form>
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
				<td class="rd8"><%=qt.getPid()==null?"":qt.getPid()%></td>
				<%
					ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
					if(client == null) client = new ClientForm();
				%>
				<td class="rd8"><a href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient()==null?"":qt.getClient() %></a></td>
			</tr>
		</table>
		<p>
			&nbsp;
		</p>
		
		<form name="userform" id="userform">

			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
					<td width="27%" nowrap class="rd16">
						<div align="right"><input type="button" onclick="buil();" value="��������">
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
						���۵����
					</td>
					<td class="rd6">
						������
					</td>
					<td class="rd6" >
						��ױƷ���
					</td>
					<td class="rd6">
						��Ŀ����
					</td>
					<td class="rd6">
						��������
					</td>
					<td class="rd6">
						Ӧ���ʱ��
					</td>
					<td class="rd6">
						��Ŀ�ȼ�
					</td>
					<td class="rd6">
						״̬
					</td>
					<td class="rd6">
						��ת���б�
					</td>
				</tr>

				<%
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						ChemProject cp = (ChemProject)p.getObj();
				 %>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid()%>/<%=p.getRid()%>">
					</td>
					<td class="rd8">
						<a href="../../quotation/detail.jsp?pid=<%=p.getPid() %>"><%=p.getPid() %></a>
					</td>
					<td class="rd8">
						<a href="projectdetail.jsp?sid=<%=p.getSid() %>"><%=p.getRid() %></a>
					</td>
					<td class="rd8">
						<%=p.getFilingNo()==null?"":p.getFilingNo()  %>
					</td>
					<td class="rd8">
						<%=p.getPtype() %>
					</td>
					<td class="rd8">
						<%=cp.getRptype() %>
					</td>
					<td class="rd8">
						<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>

					<td class="rd8">
						<%=p.getLevel() %>
					</td>
					<td class="rd8">
						<%=cp.getStatus() %>
					</td>
					<td class="rd8">
					<%if(!(user.getId()==231||user.getId()==114||user.getId()==77)){
					%>
					[<a href="../flow/addflow.jsp?type=null&sid=<%=p.getSid()%>,">���</a>]&nbsp;
					<%
					}%>
					[<a href="../flow/flow_manage.jsp?sid=<%=p.getSid() %>">�鿴</a>]
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
							<font color="#FFFFFF" size="2pt">&nbsp;��&nbsp;<%=pm.getTotalPages() %> &nbsp;ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

		</form>

	</body>
</html>
