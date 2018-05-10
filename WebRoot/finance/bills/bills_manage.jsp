<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
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
<%@page import="com.lccert.crm.quotation.BillsForm"%>
<%@page import="com.lccert.crm.quotation.BillsCountForm"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%@page import="java.util.Date"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String year=request.getParameter("year");
	//System.out.println(year);
	if(year ==null){
	//获取年份
	Date date =new Date();
    year = new SimpleDateFormat("yyyy").format(date);
    }	
    
 //   System.out.println(year);
	//获取部门
	String selDep="";
	if(request.getParameter("dep") !=null){
	 selDep=new String (request.getParameter("dep").getBytes("ISO-8859-1"),"GBK");
	}
	
	//System.out.println(selDep);
	if(selDep == null || selDep.equals("")){
		if(user.getId()==54 || user.getId()==103 || user.getId()==130 || user.getId()==106){
		selDep ="销售一部" ;
		}if(user.getId()==105){
		selDep ="东莞" ;
		}
	}



//---------------2011-04-09注释---------------
       String last = "";
		last="LCQ";
		
		if("销售二部".equals(selDep)) {
			last=last+"2";
			//str.append("2");//中山销售二部
		}else if("销售一部".equals(selDep)) {
			last=last+"1";
		}else if("广州".equals(selDep)) {
		last=last+"G";//
	} else if("东莞".equals(selDep)) {
		last=last+"D";
	} 
	
//---------------2011-04-09注释---------------
		//System.out.println(last);
		//System.out.println("年份："+year);
		//System.out.println("月份："+month);
		
	
	
	
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
	function showdialog(start) {
	window.self.location = "showbills_manage.jsp?start=" + start;
		//window.showModalDialog("showbills_manage.jsp?start=" + start,"","dialogWidth:1000px;dialogHeight:700px");
	}
	
	
	function showPriceDialog(obj,obj1) {
	window.showModalDialog("showprice_manage.jsp?status=onlyItem&itemNumber=" +obj+"&last=<%=last%>&year=<%=year%>&month="+obj1,"","dialogWidth:1000px;dialogHeight:700px");
	}
	
	function showAllDialog(obj,obj1) {
	window.showModalDialog("showprice_manage.jsp?status1="+obj+"&status=allItem&last=<%=last%>&year=<%=year%>&month="+obj1,"","dialogWidth:1000px;dialogHeight:700px");
	}
	
	function submitSelect(){
	var year=document.getElementById("year").value;
	var dep=document.getElementById("dep").value;
	var myform =document.getElementById("form1");
	myform.action="bills_manage.jsp?year="+year+"&dep="+dep;
	myform.submit();
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" method="post"
			action="#">

		
		<table width="98%" border="0" cellpadding="2" cellspacing="0"
			align="center">
				<tr valign="middle" align="center">
					<td>
					
						年份:<select name ="year" id ="year" onchange="submitSelect();">
							<option value="2010"　<%=year.equals("2010")?"selected":"" %>>2010</option>
							<option value="2011" <%=year.equals("2011")?"selected":"" %>>2011</option>
							<option value="2012" <%=year.equals("2012")?"selected":"" %>>2012</option>
							<option value="2013" <%=year.equals("2013")?"selected":"" %>>2013</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						部门:<select name ="dep" id ="dep"  onchange="submitSelect();">
						<%if(user.getId() ==54 || user.getId()== 103 || user.getId()==130 || user.getId() ==106){
						%>
						<option value="销售一部" selected="selected">销售一部</option>
						<%
						} if(user.getId() == 105 || user.getId()== 103 || user.getId()==130){
						%>
						<option value="东莞" <%=selDep.equals("东莞")?"selected":"" %>>东莞</option>
						<%
						}if(user.getId()== 103 || user.getId()==130 || user.getId() ==106){
						%>
						<option value="销售二部" <%=selDep.equals("销售二部")?"selected":"" %>>销售二部</option>
						<%
						} if(user.getId() == 141 || user.getId()== 103 || user.getId()==130){
						%>
					<option value="广州" <%=selDep.equals("广州")?"selected":"" %>>广州</option>
						<%
						
						}
						%>
							
						</select>
					</td>
				</tr>
			</table>
			<br>
			<br>
		<table width="98%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
			<th height="25" >
				项目类型
				</th>
				<th height="25" >
					1月份
				</th>
				<th height="25" >
					2月份
				</th>
				<th height="25" >
					3月份
				</th>
				<th height="25" >
					4月份
				</th>
				<th height="25" >
					5月份
				</th>
				 <th height="25" >
					6月份
				</th>
				<th height="25" >
					7月份
				</th>
				<th height="25" >
					8月份
				</th>
				<th height="25" >
					9月份
				</th>
				<th height="25" >
					10月份
				</th>
				<th height="25" >
					11月份
				</th>
				<th height="25" >
					12月份
				</th>
			</tr>
			<%
			List  monTotal=ItemAction.getInstance().getAllItemNumber();
			for(int i=0;i<monTotal.size();i++){
			Item it =(Item)monTotal.get(i);
			String str="";
			if(i == 0){
			str="玩具";
			}if(i == 1){
			str="电子电器";
			}if(i == 2){
			str="食品";
			}if(i == 3){
			str="其他";
			}if(i == 4){
			str="安规项目";
			}if(i == 5){
			str="电磁兼容";
			}if(i ==6){
			str="光性能";
			}
			%>
			<tr  valign="middle" align="center">
			<td><%=str %></td>
			<%
			String m="";
			for(int j=1;j<=12;j++){
				if(j<10){
					m="0"+j;
				}else{
					m=j+"";
				}
				
				
					if(Math.round(QuotationAction.getInstance().getMonTotal(it.getItemNumber(),selDep,year, m,user.getId())) >0){
				%>
				<td>[<a href="javascript:showPriceDialog('<%=it.getItemNumber() %>','<%=j%>');"><%=Math.round(QuotationAction.getInstance().getMonTotal(it.getItemNumber(),selDep,year, m,user.getId())) %></a>]</td>
				<%
				}else{
				%>
				<td><%=Math.round(QuotationAction.getInstance().getMonTotal(it.getItemNumber(),selDep,year, m,user.getId())) %></td>
				<%
				}
			}
		%>
		</tr>
		<%
		}
		//getMonPrice
				%>
				
				<tr><td colspan="13" height="50">	<hr width="100%" align="center" size=0></td></tr>
				
				<%for(int i=0;i<3;i++){
			String str="";
			if(i == 0){
			str="总金额:";
			}
			if(i == 1){
			str="未收金额:";
			}if(i == 2){
			str="利润：";
			}
			%>
			
			<tr height="22" valign="middle" align="center">
			<td><%=str %></td>
				<%
			String m="";
			for(int j=1;j<=12;j++){
				if(j<10){
					m="0"+j;
				}else{
					m=j+"";
				}
				%>
				<td>
				<%
				int  status=0;
				float inTotal =0f;
				float inunDe =0f;
				float profit=0f;
				int publicToTal=0;
				List totalPric=QuotationAction.getInstance().getMonPrice(selDep,year,m);
				inTotal=Float.parseFloat(totalPric.get(0).toString());
				inunDe=Float.parseFloat(totalPric.get(1).toString());
				profit=Float.parseFloat(totalPric.get(2).toString());
				
				if(i == 0){
				status=1;
				publicToTal=Math.round(inTotal);
				}
				if(i == 1){
				status=2;
				publicToTal=Math.round(inunDe);
				}
				if(i == 2){
				status=3;
				publicToTal=Math.round(profit);
				}
				
				if(publicToTal>0){
				%>
				[<a href="javascript:showAllDialog(<%=status%>,'<%=m %>');"><%=publicToTal%></a>]
				<%
				}else{
				%>
				<%=publicToTal%>
				<%}
				%>
				</td>
				<%
			}
		%>
			</tr>
			<%
			} 
			%>
		</table>
		<br><br>
		<table width="98%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="10">
					签单统计总数量
				</th>
			</tr>
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					签单公司名
						
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						昨天签单数
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						昨天签单额
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						今天签单数
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						今天签单额
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						本月签单数
					</div>
				</td>
				<td width="7%" class=forumrow>
					<div align="center">
						本月签单额
					</div>
				</td>
			</tr>
			<%
				List list =QuotationAction.getInstance().getBills();
				for(int i=0;i<list.size();i++){
					BillsForm bill=(BillsForm)list.get(i);
					
				%>
				<tr style="text-align: center;">
					<%if(i==0){
					%>
					<td width="10%" >
						中山化学
					</td>
				<% 	}else if(i==1){ %>
				<td width="10%" >
						中山安规
				</td>
				<% 	}else if(i==2){ %>
				<td width="10%" >
						东莞公司
				</td>
				<% 	}else if(i==3){ %>
				<td width="10%" >
						广州公司
				</td>
				<% 	} %>
				<%
					if(i==0){
					%>
					<td>
						 [<a href="javascript:showdialog('yesDateLCQ1');"><%=bill.getYesDateLCQ() %></a>]
					</td>
					<td>
					[<a href="javascript:showdialog('yesMoneyLCQ1');"><%=bill.getYesMoneyLCQ() %></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowDateLCQ1');"><%=bill.getNowDateLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMoneyLCQ1');"><%=bill.getNowMoneyLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMonthLCQ1');"><%=bill.getNowMonthLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMMoneyLCQ1');"><%=bill.getNowMMoneyLCQ()%></a>]
						
					</td>
					<% 	} %>
				<%
					if(i==1){
					%>
					<td>
						 [<a href="javascript:showdialog('yesDateLCQ2');"><%=bill.getYesDateLCQ() %></a>]
					</td>
					<td>
					[<a href="javascript:showdialog('yesMoneyLCQ2');"><%=bill.getYesMoneyLCQ() %></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowDateLCQ2');"><%=bill.getNowDateLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMoneyLCQ2');"><%=bill.getNowMoneyLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMonthLCQ2');"><%=bill.getNowMonthLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMMoneyLCQ2');"><%=bill.getNowMMoneyLCQ()%></a>]
						
					</td>
					<% 	} %>
				
				<%
					if(i==2){
					%>
					<td>
						 [<a href="javascript:showdialog('yesDateLCQD');"><%=bill.getYesDateLCQ() %></a>]
					</td>
					<td>
					[<a href="javascript:showdialog('yesMoneyLCQD');"><%=bill.getYesMoneyLCQ() %></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowDateLCQD');"><%=bill.getNowDateLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMoneyLCQD');"><%=bill.getNowMoneyLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMonthLCQD');"><%=bill.getNowMonthLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMMoneyLCQD');"><%=bill.getNowMMoneyLCQ()%></a>]
						
					</td>
					<% 	} %>
				<%
					if(i==3){
					%>
					<td>
						 [<a href="javascript:showdialog('yesDateLCQG');"><%=bill.getYesDateLCQ() %></a>]
					</td>
					<td>
					[<a href="javascript:showdialog('yesMoneyLCQG');"><%=bill.getYesMoneyLCQ() %></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowDateLCQG');"><%=bill.getNowDateLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMoneyLCQG');"><%=bill.getNowMoneyLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMonthLCQG');"><%=bill.getNowMonthLCQ()%></a>]
						
					</td>
					<td>
					[<a href="javascript:showdialog('nowMMoneyLCQG');"><%=bill.getNowMMoneyLCQ()%></a>]
						
					</td>
					<% 	} %>
					
				</tr>
				<tr style="text-align: center;">
				
				
				<%
				}
				List temp =QuotationAction.getInstance().getBillsCount();
				for(int i=0;i<temp.size();i++){
				BillsCountForm billC=(BillsCountForm)temp.get(i);
			 %>
			 <td height="25">
						合计
			 <td height="25">
						<%=billC.getSumYD()%>
			</td>
			 <td height="25">
						<%=billC.getSumYM()%>
			</td>
			
			 <td height="25">
						<%=billC.getSumND()%>
			</td>
			
			 <td height="25">
						<%=billC.getSumNM()%>
			</td>
			 <td height="25">
						<%=billC.getSumNMon()%>
			</td>
			 <td height="25">
						<%=billC.getSumNMM()%>
			</td>
			
			
				<%
				}
				
			 %>
			</tr>
		</table>
		</form>
</body>
</html>