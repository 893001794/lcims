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
	if(!(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")||user.getName().equals("余海珊"))) {
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
		if(dept.indexOf("销售")>-1){
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
		<title>查询订单</title>
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
			alert("请选择需要修改的用户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条用户数据！");
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
			alert("请选择需要删除的用户数据！");
			return;
		}
		if (window.confirm("是否确认删除选中的数据？")) {
			//执行删除
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
							<b>销售管理&gt;&gt;查询订单</b>
						</td>
					</tr>
				</table>
				
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=searchquotation.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
						
							<font color="red">请输入报价单号：</font>
							<input type=text name=pid size="40" value="" />
							<input type=submit name=Submit value=搜索>
						
						</td>
					</tr>
					<tr>
						<td width="50%">
						
							<font color="red">请输入报告编号：</font>
							<input type=text name=rid size="40" value="" />
							<input type=submit name=Submit value=搜索>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">请输客户名称：&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=搜索>
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
							全部
							<input type="checkbox" name="parttype" value="all" <%=parttype.equals("all")?"checked":"" %> onClick="chooseOne(this);Change_Select(this);"/>
							|&nbsp; 未完成
							<input type="checkbox" name="parttype" value="no" <%=parttype.equals("no")?"checked":"" %> onClick="chooseOne(this);Change_Select(this);"/>
							|&nbsp;已完成
							<input type="checkbox" name="parttype" value="yes" <%=parttype.equals("yes")?"checked":"" %> onClick="chooseOne(this);Change_Select(this);"/>
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
						报价单编号
					</th>
					<th >
						客户名称
					</th>
					<th>
						项目名称
					</th>
					<th>
						报价金额
					</th>
					<th>
						冲红金额
					</th>
					<th>
						已收金额
					</th>
					
					<th>
						收款票据
					</th>
					<th>
						预估分包费
					</th>
					<th>
						预估机构费
					</th>
					<th>
						销售
					</th>
					<th>
						立项数目
					</th>
					<th>
						状态
					</th>
					<th>
						所有项目
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
						[<a href="javascript:showdialog('<%=qt.getPid() %>');">查看</a>]
						[<a href="javascript:showquotation('<%=qt.getPid()%>');">收款情况</a>]
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
