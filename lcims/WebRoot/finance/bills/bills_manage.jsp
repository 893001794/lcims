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
	//��ȡ���
	Date date =new Date();
    year = new SimpleDateFormat("yyyy").format(date);
    }	
    
 //   System.out.println(year);
	//��ȡ����
	String selDep="";
	if(request.getParameter("dep") !=null){
	 selDep=new String (request.getParameter("dep").getBytes("ISO-8859-1"),"GBK");
	}
	
	//System.out.println(selDep);
	if(selDep == null || selDep.equals("")){
		if(user.getId()==54 || user.getId()==103 || user.getId()==130 || user.getId()==106){
		selDep ="����һ��" ;
		}if(user.getId()==105){
		selDep ="��ݸ" ;
		}
	}



//---------------2011-04-09ע��---------------
       String last = "";
		last="LCQ";
		
		if("���۶���".equals(selDep)) {
			last=last+"2";
			//str.append("2");//��ɽ���۶���
		}else if("����һ��".equals(selDep)) {
			last=last+"1";
		}else if("����".equals(selDep)) {
		last=last+"G";//
	} else if("��ݸ".equals(selDep)) {
		last=last+"D";
	} 
	
//---------------2011-04-09ע��---------------
		//System.out.println(last);
		//System.out.println("��ݣ�"+year);
		//System.out.println("�·ݣ�"+month);
		
	
	
	
%>

<html>
	<head>
		<title>�������</title>
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
					
						���:<select name ="year" id ="year" onchange="submitSelect();">
							<option value="2010"��<%=year.equals("2010")?"selected":"" %>>2010</option>
							<option value="2011" <%=year.equals("2011")?"selected":"" %>>2011</option>
							<option value="2012" <%=year.equals("2012")?"selected":"" %>>2012</option>
							<option value="2013" <%=year.equals("2013")?"selected":"" %>>2013</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						����:<select name ="dep" id ="dep"  onchange="submitSelect();">
						<%if(user.getId() ==54 || user.getId()== 103 || user.getId()==130 || user.getId() ==106){
						%>
						<option value="����һ��" selected="selected">����һ��</option>
						<%
						} if(user.getId() == 105 || user.getId()== 103 || user.getId()==130){
						%>
						<option value="��ݸ" <%=selDep.equals("��ݸ")?"selected":"" %>>��ݸ</option>
						<%
						}if(user.getId()== 103 || user.getId()==130 || user.getId() ==106){
						%>
						<option value="���۶���" <%=selDep.equals("���۶���")?"selected":"" %>>���۶���</option>
						<%
						} if(user.getId() == 141 || user.getId()== 103 || user.getId()==130){
						%>
					<option value="����" <%=selDep.equals("����")?"selected":"" %>>����</option>
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
				��Ŀ����
				</th>
				<th height="25" >
					1�·�
				</th>
				<th height="25" >
					2�·�
				</th>
				<th height="25" >
					3�·�
				</th>
				<th height="25" >
					4�·�
				</th>
				<th height="25" >
					5�·�
				</th>
				 <th height="25" >
					6�·�
				</th>
				<th height="25" >
					7�·�
				</th>
				<th height="25" >
					8�·�
				</th>
				<th height="25" >
					9�·�
				</th>
				<th height="25" >
					10�·�
				</th>
				<th height="25" >
					11�·�
				</th>
				<th height="25" >
					12�·�
				</th>
			</tr>
			<%
			List  monTotal=ItemAction.getInstance().getAllItemNumber();
			for(int i=0;i<monTotal.size();i++){
			Item it =(Item)monTotal.get(i);
			String str="";
			if(i == 0){
			str="���";
			}if(i == 1){
			str="���ӵ���";
			}if(i == 2){
			str="ʳƷ";
			}if(i == 3){
			str="����";
			}if(i == 4){
			str="������Ŀ";
			}if(i == 5){
			str="��ż���";
			}if(i ==6){
			str="������";
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
			str="�ܽ��:";
			}
			if(i == 1){
			str="δ�ս��:";
			}if(i == 2){
			str="����";
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
					ǩ��ͳ��������
				</th>
			</tr>
			<tr>
				<td width="3%" height="35" class=forumrow>
					<div align="center">
					ǩ����˾��
						
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						����ǩ����
					</div>
				</td>
				<td width="20%" class=forumrow>
					<div align="center">
						����ǩ����
					</div>
				</td>
				<td width="13%" class=forumrow>
					<div align="center">
						����ǩ����
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						����ǩ����
					</div>
				</td>
				<td width="10%" class=forumrow>
					<div align="center">
						����ǩ����
					</div>
				</td>
				<td width="7%" class=forumrow>
					<div align="center">
						����ǩ����
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
						��ɽ��ѧ
					</td>
				<% 	}else if(i==1){ %>
				<td width="10%" >
						��ɽ����
				</td>
				<% 	}else if(i==2){ %>
				<td width="10%" >
						��ݸ��˾
				</td>
				<% 	}else if(i==3){ %>
				<td width="10%" >
						���ݹ�˾
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
						�ϼ�
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