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
	//在t_quotation表中将authorization改为y和将当时登录人添加到acthorizer字段中
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
		<title>销售报价单</title>
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
			alert("请选择需要打印的订单！");
			return;
		}
		if (count > 1) {
			alert("一次只能打印一份订单！");
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
			alert("请选择需要打印的流转单！");
			return;
		}
		if (count > 1) {
			alert("一次只能打印一份流转单！");
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
			alert("请选择需要修改的用户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条用户数据！");
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
			alert("请选择需要删除的用户数据！");
			return;
		}
		if (window.confirm("是否确认删除选中的数据？")) {
			//执行删除
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
	
<%---------------------输出数据到EXCEL文档start---------------------%>
	
	<%---输出全部未完成项目到EXCEL文档---%>
	function nofinishex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出当日接单明细到EXCEL文档---%>
	function todayex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出全部未完成分包及TUV项目到EXCEL文档---%>
	function notuvex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出东莞未完成项目到EXCEL文档---%>
	function dgnoex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出迟单及迟单预警到EXCEL文档---%>
	function warnex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出已经完成但报告未发出到EXCEL文档---%>
	function nosendex() {
		if (window.confirm("是否确认输出数据？")) {
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
							<b>报价管理&gt;&gt;管理报价单</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=order_manage.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
							<font color="red">请输入报价单号：&nbsp;&nbsp;</font>
							<input type=text name=pid size="40" value="" />
							
							
							<input type=submit name=Submit value=搜索>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">请输入客户名称：&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=搜索>
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
							全部
							<input type="checkbox" name="parttype" value="all" onClick="chooseOne(this);Change_Select(this);" checked/>
							|&nbsp; 未审核
							<input type="checkbox" name="parttype" value="no" onClick="chooseOne(this);Change_Select(this);"/>
							|&nbsp;已审核
							<input type="checkbox" name="parttype" value="yes" onClick="chooseOne(this);Change_Select(this);"/>
						</div>
						
						 <script>   
	    
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
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
						<font color="#FFFFFF" size="2pt">订单列表</font>
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
						报价单编号
					</td>
					<td class="rd6" width="250px" style="text-align: center;" >
						客户名称
					</td>
					<td class="rd6" >
						客户要求时间
					</td>
					<td class="rd6" >
						销售
					</td>
					<td class="rd6" >
						标准金额
					</td>
					<td class="rd6" >
						报价金额
					</td>
					<td class="rd6" >
						报价日期
					</td>
					<td class="rd6">
						状态
					</td>
					<td class="rd6">
						操作
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
						<font color="<%="n".equals(order.getStatus())?"red":"green" %>"><%="n".equals(order.getStatus())?"未审核":"已审核" %></font>
						<font color="<%="y".equals(authoriz)?"#7B68EE":"" %>"><%="y".equals(authoriz)?"已受权":"" %></font>
					</td>
					<td class="rd8" width="4%">
					<%
						if("n".equals(order.getStatus()) && user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {
			 		%>
						<a href="orderdetail.jsp?id=<%=order.getId() %>">审核</a>
					<%
						}else if("y".equals(order.getStatus())&&"n".equals(authoriz)&& (user.getId()==55 ||user.getId()==59 ||user.getId()==64||user.getId()==54||user.getId()==103)){
					 %>
					 	<a href="order_manage.jsp?status=authorization&pid=<%=order.getPid() %>">授权</a>
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
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp; <%=pm.getTotalPages() %> &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">当前第</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">页</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="首页"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="上页"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="下页" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="尾页"
								onClick="bottomPage()">
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改" onClick="modifyOrder()">
						</div>
					</td>
				</tr>
			</table>
			<br>
	<div align="center">
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="打印订单" onClick="printorder()">&nbsp;&nbsp;
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="打印流转单" onClick="printEFlow()">
					</div>
		
	</body>
</html>
