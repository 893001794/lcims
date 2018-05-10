<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ page errorPage="../error.jsp"%>
<%
	if(!(user.getTicketid().matches("1\\d\\d\\d\\d\\d1\\d"))) {
		response.sendRedirect("../client/error.html");
		return;
	}
 %>
<%
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = QuotationAction.getInstance().getAllQuotations(pageNo,pageSize);
 %>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>管理订单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script type="text/javascript">
	
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" + pid);
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

	function topPage() {
		window.self.location = "quotation_manage.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "quotation_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>";
	}	
	
	function nextPage() {
		window.self.location = "quotation_manage.jsp?pageNo=<%=pm.getNextPageNo()%>";
	}
	
	function bottomPage() {
		window.self.location = "quotation_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>";
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
		<form name="userform" id="userform">
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
							<b>销售管理&gt;&gt;管理订单</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">查询列表</font>
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
						报价单编号
					</td>
					<td class="rd6" >
						客户名称
					</td>
					<td class="rd6" >
						项目名称
					</td>
					<td class="rd6" >
						报价金额
					</td>
					<td class="rd6" >
						已收金额
					</td>
					<td class="rd6" >
						预估分包费
					</td>
					<td class="rd6" >
						预估机构费
					</td>
					<td class="rd6" >
						销售
					</td>
					<td class="rd6" >
						立项数目
					</td>
					<td class="rd6">
						状态
					</td>
					<td class="rd6">
						所有项目
					</td>
				</tr>
				
				<%
				List<Quotation> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Quotation qt = list.get(i);
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=qt.getPid() %>">
					</td>
					
					<td class="rd8">
						<a href="detail.jsp?pid=<%=qt.getPid() %>"><%=qt.getPid() %></a>
					</td>
					<td class="rd8">
						<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client == null) {
								client = new ClientForm();
							}
						 %>
						
						<span class="short"><a href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient() %></a></span>
						
					</td>
					<td class="rd8">
						<span class="short"><%=qt.getProjectcontent() %></span>
					</td>
					<td class="rd8">
						<%=qt.getTotalprice() %>
					</td>
					<td class="rd8">
						<%=qt.getPreadvance() + qt.getSepay() + qt.getBalance() %>
					</td>
					<td class="rd8">
						<%=qt.getPresubcost() %>
					</td>
					<td class="rd8">
						<%=qt.getPreagcost() %>
					</td>
					
					<td class="rd8">
						<%=qt.getSales() %>
					</td>
					<td class="rd8">
						<%=qt.getProjectcount() %>
					</td>
					<td class="rd8">
						<%=qt.getStatus() %>
					</td>		
					<td class="rd8">
						[<a href="javascript:showdialog('<%=qt.getPid() %>');">查看</a>]
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
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="添加" onClick="addUser()">
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改" onClick="modifyUser()">
					<%
						if(user.getTicketid().matches("11111111")) {
					%>
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="删除" onClick="deleteQuotation()">
					<%
						}
					 %>
						</div>
					</td>
				</tr>
			</table>
			
		</form>
<%--
		<br>
		<form>
			<table width="80%" border="0" cellspacing="50" cellpadding="0"
					align="center">
				<tr>
					<td width="33%">
					<input type="button" value="输出全部未完成项目到EXCEL文件" style="height: 30px" onClick="nofinishex()"/>
					</td>
					<td width="33%">
					<input type="button" value="输出当日接单明细到EXCEL文件" style="height: 30px" onClick="todayex()"/>
					</td>
					<td >
					<input type="button" value="输出全部未完成分包及TUV项目到EXCEL文件" style="height: 30px" onClick="notuvex()"/>
					</td>
				</tr>
				<tr>
					<td >
					<input type="button" value="输出东莞未完成项目到EXCEL文件" style="height: 30px" onClick="dgnoex()"/>
					</td>
					<td>
					<input type="button" value="输出迟单及迟单预警到EXCEL文件" style="height: 30px" onClick="warnex()"/>
					</td>
					<td>
					<input type="button" value="输出已经完成但报告未发出的项目到EXCEL文件" style="height: 30px" style="height: 30px" onClick="nosendex()"/>
					</td>
				</tr>
			</table>
		</form>
--%>
	</body>
</html>
