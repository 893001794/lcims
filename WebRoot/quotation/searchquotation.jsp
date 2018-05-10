<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@ include file="../comman.jsp"  %>

<%
	if(!(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")||user.getName().equals("�ຣɺ"))) {
		response.sendRedirect("../client/error.html");
		return;
	}
 %>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	
	String saleid=request.getParameter("saleid");
	String userName="";
	if(user !=null){
		
		String dept=user.getDept();
	System.out.println(dept);
		if(dept.indexOf("����")>-1){
			userName=user.getName();
		}else{
			userName="";
		}
	}
	List<Quotation> list = new ArrayList<Quotation>();
	String parttype = request.getParameter("parttype");
	if(parttype==null){
	 parttype="all";
	 }
	if (command != null && "search".equals(command)) {
		String pid = request.getParameter("pid");
		String rid = request.getParameter("rid");
		String client = request.getParameter("client");
		System.out.println(pid);
		if(rid != null && !"".equals(rid)) {
			pid=QuotationAction.getInstance().getPidByRid(rid);
			if(!"".equals(userName)){
				boolean flase=QuotationAction.getInstance().getQuotypeByConditions(pid,userName);
				if(flase==true){
				QuotationAction.getInstance().getPidByRid(rid,client,parttype,list);
				}
			}else{
				QuotationAction.getInstance().getPidByRid(rid,client,parttype,list);
			}
			
		}
		 else if(pid !=null&&!"".equals(pid)){
			if(!"".equals(userName)){
				boolean flag=QuotationAction.getInstance().getQuotypeByConditions(pid,userName);
				if(flag==true){
					QuotationAction.getInstance().searchQuotation(pid,client,parttype,list);
				}
			}else{
					QuotationAction.getInstance().searchQuotation(pid,client,parttype,list);
			}
		}
		else if(client !=null&&!"".equals(client)){
			if(!"".equals(userName)){
				boolean flag=QuotationAction.getInstance().getQuotypeByClient(client,userName);
				if(flag==true){
					QuotationAction.getInstance().searchQuotation(pid,client,parttype,list);
				}
			}else{
					QuotationAction.getInstance().searchQuotation(pid,client,parttype,list);
			}
		}
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>��ѯ����</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
		<link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />   
		<script type="text/javascript" src="../javascript/jquery.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript" src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
		<script type="text/javascript">
	$(function() {
		   $("#myTable")
		    .tablesorter({widthFixed: true})
		    .tablesorterPager({container: $("#pager")});
		});
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" +pid);
	}
	function showquotation(pid) {
		window.open("quotationlog.jsp?command=search&pid="+pid+"/&type=1&pageNo=1");
	}
	
	function addUser() {
		
		window.self.location = "addquotation.jsp";	
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
	
	function deleteQuotation() {
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
				action = "deletequotation.jsp"
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
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
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���۹���&gt;&gt;��ѯ����</b>
						</td>
					</tr>
				</table>
				
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=searchquotation.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
						
							<font color="red">�����뱨�۵��ţ�</font>
							<input type=text name=pid size="40" value="" />
							<input type=submit name=Submit value=����>
						
						</td>
					</tr>
					<tr>
						<td width="50%">
						
							<font color="red">�����뱨���ţ�</font>
							<input type=text name=rid size="40" value="" />
							<input type=submit name=Submit value=����>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">����ͻ����ƣ�&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=����>
							 <script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
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
				<tr>
					<td >
						<div id="mydiv">
							ȫ��
							<input type="checkbox" name="parttype" value="all" <%=parttype.equals("all")?"checked":"" %> onClick="chooseOne(this);Change_Select(this);"/>
							|&nbsp; δ���
							<input type="checkbox" name="parttype" value="no" <%=parttype.equals("no")?"checked":"" %> onClick="chooseOne(this);Change_Select(this);"/>
							|&nbsp;�����
							<input type="checkbox" name="parttype" value="yes" <%=parttype.equals("yes")?"checked":"" %> onClick="chooseOne(this);Change_Select(this);"/>
						</div>
						
						 <script>   
	    
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }   
						          var search=document.getElementById("search");
						          search.submit(); 
						     }   
						 </script>
						</td>
				</tr>
					
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>
			<form name="userform" id="userform">
			<table cellspacing="1" class="tablesorter" id="myTable">
			<thead>
				<tr>
					<th>
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()" width="10%">
					</th>
					<th >
						���۵����
					</th>
					<th >
						�ͻ�����
					</th>
					<th>
						��Ŀ����
					</th>
					<th>
						���۽��
					</th>
					<th>
						�����
					</th>
					<th>
						���ս��
					</th>
					
					<th>
						�տ�Ʊ��
					</th>
					<th>
						Ԥ���ְ���
					</th>
					<th>
						Ԥ��������
					</th>
					<th>
						����
					</th>
					<th>
						������Ŀ
					</th>
					<th>
						״̬
					</th>
					<th>
						������Ŀ
					</th>
				</tr>
			</thead>
			<tfoot>
		<tr>
			<th colspan="12">&nbsp;</th>
			

		</tr>
	</tfoot>
		<tbody>
				<%
				if(list != null&&list.size()>0) {
					for(int i=0;i<list.size();i++) {
						Quotation qt = list.get(i);
				 %>
			
				<tr>
					<td >
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=qt.getPid() %>">
					</td>
					
					<td >
						<a href="detail.jsp?pid=<%=qt.getPid() %>"><%=qt.getPid() %></a>
					</td>
					<td >
						<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client == null) {
								client = new ClientForm();
							}
						 %>
						
						<span class="short"><a href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient() %></a></span>
						
					</td>
					<td >
						<span class="short"><%=qt.getProjectcontent() %></span>
					</td>
					<td >
						<%=qt.getTotalprice() %>
					</td>
					<td >
						<%=qt.getFluSum() %>
					</td>
					<td >
						<%=qt.getPreadvance() + qt.getSepay() + qt.getBalance() %>
					</td>
					<td >
						<%=qt.getPaynotes()%>
					</td>
					<td >
						<%=qt.getPresubcost() %>
					</td>
					<td >
						<%=qt.getPreagcost() %>
					</td>
					<td >
						<%=qt.getSales() %>
					</td>
					<td >
						<%=qt.getProjectcount() %>
					</td>
					<td >
						<%=qt.getStatus() %>
					</td>	
					<td >
						[<a href="javascript:showdialog('<%=qt.getPid() %>');">�鿴</a>]
						[<a href="javascript:showquotation('<%=qt.getPid()%>');">�տ����</a>]
					</td>				
				</tr>
				<%
				}
				}
				 %>	
				 </tbody>
		</table>
		<br>
			<table width="100%" height="138" border="0" align="right"
				cellpadding="0" cellspacing="0">
				<tr>
					<td nowrap class="rd19">
						<div id="pager" class="pager" align="right">
						<form>
						   <img src="../images/first.png" width="16" height="16" class="first"/>
						   <img src="../images/prev.png" width="16" height="16" class="prev"/>
						   <input type="text" class="pagedisplay"/>
						   <img src="../images/next.png" width="16" height="16" class="next"/>
						   <img src="../images/last.png" width="16" height="16" class="last"/>
						   <select class="pagesize">
						    <option selected="selected" value="10">10</option>
						    <option value="20">20</option>
						    <option value="30">30</option>
						    <option value="40">40</option>
						   </select>
						</form>
					</div>
					</td>
				</tr>
			</table>
		</form>
		
	</body>
</html>
