<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.quotation.BillsForm"%>
<%@page import="com.lccert.crm.quotation.BillsCountForm"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%
	request.setCharacterEncoding("GBK");
	String start=request.getParameter("start");
	String salesId=request.getParameter("sales").trim();
	String str="";
	if(start.equals("InTotal")){
	str ="本月订单金额";
	}
	if(start.equals("InunDe")){
	str ="本月未结金额";
	}
	if(start.equals("HiDe")){
	str ="历史欠款";
	}
	if(start.equals("InHiReDe")){
	str ="本月收历史欠款";
	}
	List temp =null;
	String sales="";
	if(salesId !=null ){
	sales=UserAction.getInstance().getNameById(Integer.parseInt(salesId));
	temp =UserAction.getInstance().getUserBySuperiorid(Integer.parseInt(salesId));
	}
	List list =new ArrayList();
	
	
%>

<html>
	<head>
		<title><%=str %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css"
			media="screen">
		<script language="JavaScript" type="text/JavaScript">
	function showdialog(start) {
	window.self.location = "showbills_manage.jsp?start=" + start;
		//window.showModalDialog("showbills_manage.jsp?start=" + start,"","dialogWidth:1000px;dialogHeight:700px");
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="post"
			action="quotation_confirm.jsp">

		</form>
		<table width="98%" border="1" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					统计<%=str %>信息
				</th>
			</tr>
			
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					报价单号
						
					</div>
				</td>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					客户名称
						
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						销售名称
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						报价金额
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						已收预付款
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						二次收款
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						实收尾款额
					</div>
				</td>
			</tr>
			<%
			
			//if(sales !=null && !"".equals(sales) && start !=null && !"".equals(start) && temp !=null){
			//for(int j=0;j<temp.size();j++){
			//UserForm user =(UserForm)temp.get(j);
			// list=QuotationAction.getInstance().getStatisticsInfor(user.getName(),start);
			//for(int i=0;i<list.size();i++){
							//Quotation q=(Quotation)list.get(i);
							%>
							<!-- 
						<tr>
							
						</tr>
						 -->
							<%
						//}
					
			//}
	
	//}
	 if(sales !=null && !"".equals(sales) && start !=null && !"".equals(start)){
	 list=QuotationAction.getInstance().getStatisticsInfor(sales,start);
	 for(int i=0;i<list.size();i++){
							Quotation q=(Quotation)list.get(i);
							%>
						<tr>
							<td><%=q.getPid()%></td>
							<td width="25%"><%=q.getClient()%></td>
							<td><%=q.getSales()%></td>
							<td><%=q.getTotalprice()%></td>
							<td><%=q.getPreadvance() %></td>
							<td><%=q.getSepay()%></td>
							<td><%=q.getBalance()%></td>
						</tr>
							<%
						}
						}
						
			 %>	
			
		</table>