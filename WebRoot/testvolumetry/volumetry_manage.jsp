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
<%
	request.setCharacterEncoding("GBK");
	
    double il=0;
	double m1=0;
	double m2=0;
	double m3=0;
	double m4=0;
	double m5=0;
	double m6=0;
	double m7=0;
	double h1=0;
	double h2=0;
	double h3=0;
	double h4=0;
	double h5=0;
	double h6=0;
	double h7=0;
	double x1=0;
	double x2=0;
	double x3=0;
	double x4=0;
	double x5=0;
	double x6=0;
	double x7=0;
	double n1 =0;
	double n2=0;
	double n3=0;
	double n4=0;
	double n5=0;
	double n6=0;
	double n7=0;
	//精度为.00
	DecimalFormat df =new DecimalFormat("0.00");
%>

<html>
	<head>
		<title>财务审核</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css"
			media="screen">
		<script language="JavaScript" type="text/JavaScript">
	function showdialog(start) {

		window.showModalDialog("show_volumetry.jsp?start=" + start,"","dialogWidth:900px;dialogHeight:700px");
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
					测试容量设计日程表
				</th>
			</tr>
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					进度点
						
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						最大容量M/天
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						当前停留量n
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						每小时处理量x
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						停留时间h
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						承受量
					</div>
				</td>
			</tr>
			<tr style="text-align: center;">
			<%
				n1 =ProjectAction.getInstance().findToDate("A1");
				m1=60;
				x1=10;
				h1=n1/x1;
				il =Math.ceil(m1-n1);
				
			 %>
			<td width="10%" >
				无机制备
			</td>	
			<td width="10%" >
				M=<%=m1 %>
			</td>	
			<td width="10%" >
				
				 [<a href="javascript:showdialog('A1');">N=<%=n1 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x1 %>
			</td>	
			<td width="10%" >
				H=<%=df.format(h1) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			<tr style="text-align: center;">
			<%
				n7 =ProjectAction.getInstance().findToDate("B1");
			    m7=60;
				x7=10;
				h7=n7/x7;
				il =Math.ceil(m7-n7);
				
			 %>
			<td width="10%" >
				有机制备
			</td>	
			<td width="10%" >
				M=<%=m7 %>
			</td>	
			<td width="10%" >
				[<a href="javascript:showdialog('B1');">N=<%=n7 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x7%>
			</td>	
			<td width="10%" >
				H=<%=df.format(h7) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			<tr style="text-align: center;">
			<%
				n2 =ProjectAction.getInstance().findToDate("A2");
				m2=100;
				x2=20;
				h2=n2/x2;
				il =Math.ceil(m2+(h1+h7)*x2-(n1+n7)-n2);
				
			 %>
			<td width="10%" >
				无机前处理
			</td>	
			<td width="10%" >
				M=<%=m2 %>
			</td>	
			<td width="10%" >
				[<a href="javascript:showdialog('A2');">N=<%=n2 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x2 %>
			</td>	
			<td width="10%" >
				H=<%=df.format(h2) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			<%
				n3 =ProjectAction.getInstance().findToDate("A3");
				m3=70;
				x3=12;
				h3=n3/x3;
				il =Math.ceil(m3+h2*x3-n2-n3);
				
			 %>
			<tr style="text-align: center;">
			<td width="10%" >
				ICP
			</td>	
			<td width="10%" >
				M=<%=m3 %>
			</td>	
			<td width="10%" >
			
				[<a href="javascript:showdialog('A3');">N=<%=n3 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x3 %>
			</td>	
			<td width="10%" >
				H=<%=df.format(h3) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			<tr style="text-align: center;">
			<%
				n4 =ProjectAction.getInstance().findToDate("B2");
				m4=120;
				x4=12;
				h4=n4/x4;
				il =Math.ceil(m4+(h1+h7)*x4-(n1+n7)-n4);
				
			 %>
			<td width="10%" >
				有机前处理
			</td>	
			<td width="10%" >
				M=<%=m4 %>
			</td>	
			<td width="10%" >
			
				[<a href="javascript:showdialog('B2');">N=<%=n4 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x4 %>
			</td>	
			<td width="10%" >
				H=<%=df.format(h4) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			<tr style="text-align: center;">
			<%
				n5 =ProjectAction.getInstance().findToDate("B3G1");
				m5=35;
				x5=2;
				h5=n5/x5;
				il =Math.ceil(m5+h4*x5-n4-n5);
				
			 %>
			<td width="10%" >
				GCMS1
			</td>	
			<td width="10%" >
				M=<%=m5 %>
			</td>	
			<td width="10%" >
			
				[<a href="javascript:showdialog('B3G1');">N=<%=n5 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x5 %>
			</td>	
			<td width="10%" >
				H=<%=df.format(h5) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			<tr style="text-align: center;">
			<%
				n6 =ProjectAction.getInstance().findToDate("B3G2");
				m6=25;
				x6=2;
				h6=n6/x6;
				il =Math.ceil(m6+h4*x6-n4-n6);
				
			 %>
			<td width="10%" >
				GCMS2
			</td>	
			<td width="10%" >
				M=<%=m6 %>
			</td>	
			<td width="10%" >
			
				[<a href="javascript:showdialog('B3G2');">N=<%=n6 %></a>]
			</td>	
			<td width="10%" >
				X=<%=x6 %>
			</td>	
			<td width="10%" >
				H=<%=df.format(h6) %>
			</td>	
			<td width="10%" >
				i=<%=il %>
			</td>	
			</tr>
			
		</table>