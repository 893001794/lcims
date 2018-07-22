<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.chemistry.util.TimeTest"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
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
	String uid = request.getParameter("uid");
	String parttype = request.getParameter("parttype");
	String month=request.getParameter("month");
	//年份
	String year =request.getParameter("year");
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date());
	}
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());

}
	int clientid = 0;
//System.out.println(status);
	if(status !=null && !"".equals(status)){
	//在t_quotation表中将authorization改为y和将当时登录人添加到acthorizer字段中
	if(QuotationAction.getInstance().updateAuthorizationPid(user.getName(),pid) == true){
	response.sendRedirect("order_manage.jsp?command=search&pid="+pid+"&uid="+uid+"&client="+client+"&parttype="+parttype+"");
	return ;
	}
	}else if(command !=null){
		if(client != null && !"".equals(client)) {
			ClientForm cf = ClientAction.getInstance().getClientByName(client);
			if(cf != null) {
				clientid = cf.getId();
			}
		}
		pm = OrderAction.getInstance().getAllOrders(pageNo,pageSize,"",pid,uid,clientid,year,month);
	}
	else{
	pm = OrderAction.getInstance().getAllOrders(pageNo,pageSize,"EMC",pid,uid,clientid,year,month);
	session.setAttribute("financeEMC",pm.getList());
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
		window.showModelessDialog("printorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
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
	
		window.self.location = "modiorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
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
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&year=<%=year%>&month=<%=month%>";
	}	
	
	function nextPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&year=<%=year%>&month=<%=month%>";
	}
	
	function bottomPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&year=<%=year%>&month=<%=month%>";
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
	
function exportEMC() {
	if(confirm("确定导出EMC?")) {
		window.self.location = "../financeEMC";
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
				
				<form name=search id ="search" method=post action=order_manage.jsp?command=search >
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
							<font color="red">请输入流水账号：&nbsp;&nbsp;</font>
							<input type=text name=uid size="40" value="" />
							<input type=submit name=Submit value=搜索>
						</td>
					</tr>
					<tr>
						<td width="50%">
							<font color="red">请输入客户名称：&nbsp;&nbsp;</font>
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
					年份：<select name ="year" id ="year" onchange="searchsales();">
							<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
							<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
							<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
							<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
							<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
							<option value="2015" <%=("2015").equals(year)?"selected":"" %>>2015</option>
							<option value="2016" <%=("2016").equals(year)?"selected":"" %>>2016</option>
							<option value="2017" <%=("2017").equals(year)?"selected":"" %>>2017</option>
							<option value="2018" <%=("2018").equals(year)?"selected":"" %>>2018</option>
							<option value="2019" <%=("2019").equals(year)?"selected":"" %>>2019</option>
							<option value="2020" <%=("2020").equals(year)?"selected":"" %>>2020</option>
						</select>
						月份：<select name ="month" id ="month" onchange="searchsales();">
							<option value="01" <%="01".equals(month)?"selected":""%>>1</option>
							<option value="02" <%="02".equals(month)?"selected":""%>>2</option>
							<option value="03" <%="03".equals(month)?"selected":""%>>3</option>
							<option value="04" <%="04".equals(month)?"selected":""%>>4</option>
							<option value="05" <%="05".equals(month)?"selected":""%>>5</option>
							<option value="06" <%="06".equals(month)?"selected":""%>>6</option>
							<option value="07" <%="07".equals(month)?"selected":""%>>7</option>
							<option value="08" <%="08".equals(month)?"selected":""%>>8</option>
							<option value="09" <%="09".equals(month)?"selected":""%>>9</option>
							<option value="10" <%="10".equals(month)?"selected":""%>>10</option>
							<option value="11" <%="11".equals(month)?"selected":""%>>11</option>
							<option value="12" <%="12".equals(month)?"selected":""%>>12</option>
						</select>
						<script type="text/javascript">
							function searchsales(){
							   var myform =document.getElementById("search");
								myform.action ="order_manage.jsp";
								myform.submit();
							}
						</script>
						&nbsp;&nbsp;
						<input name="export" value="导出EMC" type="button" onclick="exportEMC();" />
					</td>
				</tr>
					
				</table>
				</form>
				<hr width="130%" align="center" size=0>
			</div>

			<table width="130%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<%
					if(user.getName().equals("欧婉雯")||user.getId()==103){
					%>
					<td width="27%" nowrap  class="r19" align="left" height="33px;">
						
						<font color="#FFFFFF" size="2pt"><a href="addorder.jsp" style="font-size: 15pt;text-align: left;">添加EMC报价单</a></font>
					</td>
					<%} %>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">&nbsp;</font>
					</td>
					
					
				</tr>
			</table>
			<table width="130%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr style="text-align: center;" >
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td  class ="rd6">
						EMC报价单编号
					</td>
					<td class="rd6" >
						二部报价单编号
					</td>
					<td class="rd6" width="15%" style="text-align: center;" >
						客户名称
					</td>
					<td class="rd6" >
						产品
					</td>
					<td class="rd6" >
						测试项目
					</td>
					<%--<td class="rd6" >
						收单时间
					</td>--%>
					<td class="rd6" >
						测试日期
					</td>
					<td class="rd6" >
						收单时间
					</td>
					<!-- 
					<td class="rd6" >
						上午开始时间
					</td>
					<td class="rd6" >
						上午结束时间
					</td>
					<td class="rd6" >
						下午开始时间
					</td>
					<td class="rd6" >
						下午结束时间
					</td>
					 
					<td class="rd6">
						测试(小时)
					</td>
					<td class="rd6">
						标准价
					</td>-->
					<td class="rd6">
						金额
					</td>
					<%if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")||user.getId()==103||user.getId()==254){ %>
					<td class="rd6">
						已收金额
					</td>
					<td class="rd6">
						未收金额
					</td>
					<%} %>
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
					float preprice=0.0f;//已收金额
					if(order.getStatus().equals("y")){
					Quotation qt=QuotationAction.getInstance().getQuotationByPid(order.getPid());
					preprice= qt.getPreadvance() + qt.getSepay() + qt.getBalance();
					}
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=order.getId()%>">
					</td>
					<td class="rd8">
						<a href="orderdetail.jsp?id=<%=order.getId() %>"><%=order.getPid() %></a>
					</td>
					<td class="rd8">
						<a href="orderdetail.jsp?id=<%=order.getId()%>"><%=order.getOldPid()==null?"":order.getOldPid()%></a>
					</td>
					<td class="rd8" width="10%" style="width: 10%">
						<%=order.getClient().getName()%>
					</td>
					<td class="rd8">
						<%=order.getProduct()%>
					</td>
					<td class="rd8" width="30%" style="width: 30%">
						<%=order.getProjectcontent() %>
					</td>
				<%--	<td class="rd8">
						<%=order.getCollection()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getCollection()):""%>
					</td>--%>
					<td class="rd8">
						<%=order.getTest()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getTest()):""%>
					</td>
					<td class="rd8"  >
						<%=order.getReceipt()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getReceipt()):""%>
					</td>
					<!-- 
					<td class="rd8"  >
						<%=order.getAmstart()%>
					</td>
					<td class="rd8"  >
						<%=order.getAmend()%>
					</td>
					<td class="rd8"  >
						<%=order.getPmstart()%>
					</td>
					<td class="rd8"  >
						<%=order.getPmend()%>
					</td>
					
					<td class="rd8" width="60" >
					<%
					//String timeStr=new TimeTest().TimeSerial(order.getAmstart(), order.getPmstart(),order.getAmend(), order.getPmend());
					
					 %>
						
					</td>
					<td class="rd8"  >
						<%=order.getStandprice()%>
					</td>-->
					<td class="rd8" width="1%">
					<%
						//float total=0f;
						//float f=Float.parseFloat(timeStr);
						//float standPrice =400;
						//if(order.getStandprice()>0){
						//	standPrice=order.getStandprice();
					//	}
					//		total=f*standPrice;
					 %>
					 <%=order.getTotalprice()%>
					 </td>
					<%if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")||user.getId()==103||user.getId()==254){
					%>
					 <td class="rd8" width="1%">
					 	<%=preprice == 0 ? "0.00": new DecimalFormat("##,###,###,###.00").format(preprice)%>
					 </td>
					<td class="rd8" width="1%">
						<%=order.getTotalprice()-preprice%>
					</td>
					 <%}%>
					 <td class="rd8" width="5%">
						<font color="<%="n".equals(order.getStatus())?"red":"green" %>"><%="n".equals(order.getStatus())?"未审核":"已审核" %></font>
						<font color="<%="y".equals(authoriz)?"#7B68EE":"" %>"><%="y".equals(authoriz)?"已受权":"" %></font>
					</td>
					<td class="rd8" width="4%">
					<%
						if("n".equals(order.getStatus()) && (user.getId()==103||user.getId()==188||user.getId()==138)) {
			 		%>
						<a href="orderdetail.jsp?id=<%=order.getId()%>">审核</a>
					<%
						}
					  %>
					 
					</td>
				</tr>
				
				<%
				}
				 %>
			</table>
			<table width="130%" height="30" border="0" align="center"
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
				id="btnModify" value="打印订单" onClick="printorder()">
						
					</div>
		
	</body>
</html>
