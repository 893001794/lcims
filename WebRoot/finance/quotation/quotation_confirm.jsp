<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = null;
	String pid = request.getParameter("pid");
	FinanceQuotationUtil fqu = new FinanceQuotationUtil();
	String status=request.getParameter("status");
	fqu.setPid(pid==null?"":pid);
	fqu.setPageNo(pageNo);
	fqu.setPageSize(pageSize);
	fqu.setStatus(status);
	UserForm user = (UserForm)session.getAttribute("user");
	//boolean flag =user.getTicketid().matches("00010101");
	String userName =user.getName();

	if(userName.equals("郑妙芳")){
	fqu.setStatus("LCQD");

	}
	//else if(flag == true){
	//fqu.setStatus("LCQG");
	//}

	pm = FinanceQuotationAction.getInstance().searchQuotations(fqu,"");
	

	if (pm == null) {
		pm = new PageModel();
	}


%>

<html>
	<head>
		<title>财务审核</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../../css/css1.css" type="text/css"
			media="screen">
		<script language="JavaScript" type="text/JavaScript">
	function delpay() {
		if (confirm("确定要删除此吗？"))
			return true;
		else
			return false;
	}
	
	function detail(){
		//alert(first);
		self.location="confirmdialog.jsp";
		//window.open("confirmdialog.jsp");
	}
	function lock1(Object,lock){//加锁
		var myForm =document.getElementById("form1");
		// var lock =document.getElementById("lock").value;
		self.location="quotationlog.jsp?pid="+Object+"&type=1&pageNo=1";
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="post"
			action="quotation_confirm.jsp">
			<table width="98%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th width="20%" height="25">
						报价单号
					</th>
					<th width="20%" height="25">
						区域
					</th>
					<%--
      <th width="25%">客户名称</th>
      <th width="15%">收款方式 </th>
      <th width="25%">报告应出时间</th>
  --%>
					<th width="13%">
						&nbsp;
					</th>

				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=pid type="text" id="pid" size="20" maxlength="50">
					</td>
					<td>
						<%if(!userName.equals("郑妙芳")){%>
					地区：
							<select name="status" style="width: 100px" onchange="changeStatus()">
							<option value="">
									全部
							</option>
								<option value="LCQ1">
									中山销售一
								</option>
								<option value="LCQ2">
									中山销售二
								</option>
								<option value="LCQG">
									广州
								</option>
								<option value="LCQD">
									东莞
								</option>
							</select>
					
					<%}  %>
					</td>
					<%--
      <td><input name="client" type="text" id="client" size="20" maxlength="50" value=""></td>
      
      <td><select name="paytype" id="paytype">
		<option value="月结" >月结</option>
		<option value="全额预付" >全额预付</option>
		<option value="部分预付" >部分预付</option>
		<option value="完成后全付" >完成后全付</option>
		<option value="其他" >其他</option>
      </select></td>
      
      <td><input name="rptime" type="text" id="rptime" size="12" maxlength="12" readonly value=""> 
        <input name="button" type="button" onclick="popUpCalendar(this, form1.rptime, 'yyyy-mm-dd')" value="请选择日期"></td>
      --%>
					<td>
						<input type="button" onclick="detail()"  value="收单确认">
						<input type="submit" name="Submit" value="提交">
						
						<input type="reset" name="Submit2" value="重置">
					</td>
				</tr>
			</table>
		</form>
		<table width="98%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					报价清单搜索结果
				</th>
			</tr>
			<tr>
				<td width="3%" height="25" class=forumrow>
					<div align="center">
						ID
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						报价单号
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						客户名称
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						客户要求时间
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						报价金额(元)
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						已收金额(元)
					</div>
				</td>
				<td width="7%" class=forumrow>
					<div align="center">
						收款方式
					</div>
				</td>
				<td width="7%" class=forumrow>
					<div align="center">
						销售代表
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						状态
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						操作
					</div>
				</td>
			</tr>

			<%
				List<Quotation> list = pm.getList();
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						Quotation qt = list.get(i);
						String lockStr="加锁";
						if(qt.getLock() !=null && qt.getLock() !=""){
							if(qt.getLock().equals("y")){
								lockStr="解锁";
							}
						}
			%>

			<tr>
				<td height="25">
					<div align="center">
						<%=i%>
					</div>
				</td>
				<td height="25">
					<div align="center">
						<%=qt.getPid()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getClient()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getCompletetime() == null ? ""
							: new SimpleDateFormat("yyyy-MM-dd HH:mm")
									.format(qt.getCompletetime())%>
					</div>
				</td>
				<td>
					<div align="right">
						<%=qt.getTotalprice() == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(qt
									.getTotalprice())%>
					</div>
				</td>
				<td>
					<div align="right">
						<%=qt.getPreadvance() == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(qt
									.getPreadvance())%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getAdvancetype()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getSales()%>
					</div>
				</td>
				<td>
					<div align="center">
					<%
					if("未收到".equals(qt.getEconfrim())) {
					 %>
						<font color="red"><%=qt.getEconfrim()%></font>
					<%
					} else {
					 %>
					 <font color="green"><%=qt.getEconfrim()%></font>
					<%} %>
					</div>
				</td>
				<td>
				<%
				if("未收到".equals(qt.getEconfrim())) {
				 %>
					<div align="center">
						<a href="../../quotation/detail.jsp?pid=<%=qt.getPid()%>"
							style="color: blue">确认</a>
					</div>
				<%} %>

				</td>
			</tr>
			<%
				}
				}
			%>
			<tr style="background-color: #E0F8E0">
				<td height="25" colspan="10" align="left">
					<div align="center">
						记录总条数：<%=pm.getTotalRecords()%>
						当前页/总页数:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a href="quotation_confirm.jsp?pageNo=1&pid=<%=fqu.getPid()%>&status=<%=fqu.getStatus()%>"
							class="red">首页</a>
						<a
							href="quotation_confirm.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=fqu.getPid()%>&status=<%=fqu.getStatus()%>"
							class="red">上一页</a>
						<a
							href="quotation_confirm.jsp?pageNo=<%=pm.getNextPageNo()%>&pid=<%=fqu.getPid()%>&status=<%=fqu.getStatus()%>"
							class="red">下一页</a>
						<a
							href="quotation_confirm.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=fqu.getPid()%>…&status=<%=fqu.getStatus()%>"
							class="red">末页</a>
					</div>
				</td>
			</tr>
		</table>