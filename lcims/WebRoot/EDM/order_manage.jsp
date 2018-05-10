<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
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
	List<Order> list = null;
	String command = request.getParameter("command");
	String status=request.getParameter("status");
	String client = request.getParameter("client");
	String pid = request.getParameter("pid");
	String parttype = request.getParameter("parttype");
	if(status !=null && !"".equals(status)){
	//��t_quotation���н�authorization��Ϊy�ͽ���ʱ��¼����ӵ�acthorizer�ֶ���
	if(QuotationAction.getInstance().updateAuthorizationPid(user.getName(),pid) == true){
	response.sendRedirect("order_manage.jsp?command=search&pid="+pid+"&client="+client+"&parttype="+parttype+"");
	return ;
	}
	}else{
	
	if (command != null && "search".equals(command)) {
		int clientid = 0;
		if(client != null && !"".equals(client)) {
			ClientForm cf = ClientAction.getInstance().getClientByName(client);
			if(cf != null) {
				clientid = cf.getId();
			}
		}
		pm = OrderAction.getInstance().searchOrder(pageNo,pageSize,pid,null,clientid,parttype);
	} else {
		pm = OrderAction.getInstance().getAllOrders(pageNo,pageSize,null,null,null,null,null);
	}
	
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
		window.open("putongyouzhangn.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	function printEFlow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ��ӡ����ת����");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ�ܴ�ӡһ����ת����");
			return;
		}
		window.open("printEOrder.jsp?id=" + document.getElementsByName("selectFlag")[j].value);
		//window.showModelessDialog("printflow.jsp?fid=LCZC11080039A-001","","dialogWidth:900px;dialogHeight:700px");
		//window.showModelessDialog("printEOrder.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" + pid);
	}
	
	function addOrder() {
		
		window.self.location = "addorder.jsp";	
	}
	
	function modifyOrder() {
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
	
		window.self.location = "modifyorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
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
		window.self.location = "order_manage.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>";
	}	
	
	function nextPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getNextPageNo()%>";
	}
	
	function bottomPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>";
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
						<td width="522" class="p1" height="17" nowrap>
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���۹���&gt;&gt;�����۵�</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=order_manage.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
							<font color="red">�����뱨�۵��ţ�&nbsp;&nbsp;</font>
							<input type=text name=pid size="40" value="" />
							
							
							<input type=submit name=Submit value=����>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">������ͻ����ƣ�&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=����>
							<script>   
						        $("#client").autocomplete("../myclient_ajax.jsp",{
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
							<input type="checkbox" name="parttype" value="all" onClick="chooseOne(this);Change_Select(this);" checked/>
							|&nbsp; δ���
							<input type="checkbox" name="parttype" value="no" onClick="chooseOne(this);Change_Select(this);"/>
							|&nbsp;�����
							<input type="checkbox" name="parttype" value="yes" onClick="chooseOne(this);Change_Select(this);"/>
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
						     }   
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
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">�����б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr style="text-align: center;" >
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						���۵����
					</td>
					<td class="rd6" width="250px" style="text-align: center;" >
						�ͻ�����
					</td>
					<td class="rd6" >
						�ͻ�Ҫ��ʱ��
					</td>
					<td class="rd6" >
						����
					</td>
					<td class="rd6" >
						��׼���
					</td>
					<td class="rd6" >
						���۽��
					</td>
					<td class="rd6" >
						��������
					</td>
					<td class="rd6">
						״̬
					</td>
					<td class="rd6">
						����
					</td>
				</tr>
				
				<%
				list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Order order = list.get(i);
					String authoriz=QuotationAction.getInstance().getAuthorizationPid(order.getPid());
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=order.getId() %>">
					</td>
					<td class="rd8">
						<a href="orderdetail.jsp?id=<%=order.getId() %>"><%=order.getPid() %></a>
					</td>
					<td class="rd8" width="500px">
						<%=order.getClient().getName() %>
					</td>
					<td class="rd8">
						<%=order.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(order.getCompletetime()) %>
					</td>
					<td class="rd8">
					<%
					String sales="";
					if(order.getSales() ==null){
					order =new Order();
					
					}else{
					sales=order.getSales().getName();
					} %>
						<%=sales%>
					</td>
					<td class="rd8">
						<%=order.getStandprice() %>
					</td>
					<td class="rd8">
						<!-- <%=order.getInvcount()%>-->
					</td>
					<td class="rd8"  >
						<%=order.getQuotime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(order.getQuotime()) %>
					</td>
					<td class="rd8" width="10%">
						<font color="<%="n".equals(order.getStatus())?"red":"green" %>"><%="n".equals(order.getStatus())?"δ���":"�����" %></font>
						<font color="<%="y".equals(authoriz)?"#7B68EE":"" %>"><%="y".equals(authoriz)?"����Ȩ":"" %></font>
					</td>
					<td class="rd8" width="4%">
					<%
						if("n".equals(order.getStatus()) && user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {
			 		%>
						<a href="orderdetail.jsp?id=<%=order.getId() %>">���</a>
					<%
						}else if("y".equals(order.getStatus())&&"n".equals(authoriz)&& (user.getId()==55 ||user.getId()==59 ||user.getId()==64||user.getId()==54||user.getId()==103)){
					 %>
					 	<a href="order_manage.jsp?status=authorization&pid=<%=order.getPid() %>">��Ȩ</a>
					 <%
					 }
					 	
					  %>
					 
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
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸�" onClick="modifyOrder()">
						</div>
					</td>
				</tr>
			</table>
			<br>
	<div align="center">
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="��ӡ����" onClick="printorder()">&nbsp;&nbsp;
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="��ӡ��ת��" onClick="printEFlow()">
					</div>
		
	</body>
</html>
