<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="javax.mail.Folder"%>
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String quostart = request.getParameter("quostart");
String quoend = request.getParameter("quoend");
String acceptstart = request.getParameter("acceptstart");
String acceptend = request.getParameter("acceptend");
String paytimestart = request.getParameter("paytimestart");
String paytimeend = request.getParameter("paytimeend");
String month=request.getParameter("month");
String area =request.getParameter("area");
if(area == null){
area ="安规";
}
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



float[] f;
List<Quotation> list = new ArrayList<Quotation>();
UserForm user = (UserForm)session.getAttribute("user");
	boolean flag =user.getTicketid().matches("00010101");
    if(flag == true){

		f=FinanceQuotationAction.getInstance().getFinanceProject2(year,month,command,list,"",area,quostart,quoend,acceptstart,acceptend,paytimestart,paytimeend);
}else{
		
		f=FinanceQuotationAction.getInstance().getFinanceProject2(year,month,command,list,"",area,quostart,quoend,acceptstart,acceptend,paytimestart,paytimeend);

}
session.setAttribute("financequotation2",list);
session.setAttribute("total",f);
 %>
 
<html>
<head>
<title>当天接单项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--
function showquotationlog(pid) {
	window.open("quotationlog.jsp?pid=" + pid);
}

function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../financequotation2";
	}
}



function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}



function searchsales(){
   var myform =document.getElementById("search");
	myform.action ="financequotationexport2.jsp";
	myform.submit();
	}
//-->
</script>
</head>
<body>
<br>
<h4 align="center">财务报价单统计</h4>
<form name ="search" id ="search" action="financequotationexport2.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">

	<tr>
	<td>
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
		
		区域：<select name ="area" id ="area" onchange="searchsales();">
			<option value="安规" <%="安规".equals(area)?"selected":"" %>>安规</option>
			<option value="广州" <%="广州".equals(area)?"selected":"" %>>广州</option>
		</select>
		</td></tr>
		<tr><td>
		报价起始时间:
			<input name="quostart" type="text" id="quostart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'quostart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="quoend" type="text" id="quoend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'quoend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;
		收单起始时间:
			<input name="acceptstart" type="text" id="acceptstart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'acceptstart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="acceptend" type="text" id="acceptend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'acceptend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;
		收款起始日期:
			<input name="paytimestart" type="text" id="paytimestart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'paytimestart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="paytimeend" type="text" id="paytimeend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'paytimeend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
	      	
	      	
	      	<input name="button" value="统计" type="submit" />
			&nbsp;&nbsp;
			<input name="export" value="导出到Excel" type="button" onclick="exportToExcel();" />
	      	</td>
	</tr>
</table>
</form>

	<table align="center" width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
		<tr bgcolor="dddddd"> 
		
			<td align="center" valign="middle">报价起始时间</td>
			<td align="center" valign="middle">收单起始时间</td>
			<td align="center" valign="middle">签单额</td>
			<td align="center" valign="middle">业绩统计</td>
		</tr>
		<tr bgcolor="white"> 
			<td align="center" valign="middle">
			
			</td>
			<td align="center" valign="middle">
			
			</td>
			<td align="center" valign="middle"><%=f[1] %></td>
			<td align="center" valign="middle"><%=f[0] %></td>
		</tr>
	</table>

<p>&nbsp;</p>
  <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
    <td align="center" valign="middle" rowspan="2">所属时期</td>
      <td  align="center" valign="middle" rowspan="2">销售</td>
      <td  align="center" valign="middle" width="200px" style="width: 200px" rowspan="2">客户名称</td>
       <td align="center" valign="middle" rowspan="2">报价单号</td>
        <td  align="center" valign="middle" rowspan="2">项目名称</td>
      <td  align="center" valign="middle" rowspan="2">票据形式</td>
      <td  align="center" valign="middle" colspan="5">收款情况</td>
      <td  align="center" valign="middle" colspan="3">费用明细</td>
      <td  align="center" valign="middle" colspan="9">本月计提</td>
    </tr>
    <tr bgcolor="dddddd"> 
      <td  align="center" valign="middle">报价金额</td>
	  <td  align="center" valign="middle">已收金额</td>
	  <td  align="center" valign="middle">未收金额</td>
	  <td  align="center" valign="middle">备注</td>
	  <td  align="center" valign="middle">机构支付费用备注</td>
	  <td  align="center" valign="middle">预估分包费</td>
	  <td  align="center" valign="middle">特殊接待费</td>
	  <td  align="center" valign="middle">税金</td>
	  <td  align="center" valign="middle">本月收款比例</td>
	  <td  align="center" valign="middle">本月分包比例</td>
	  <td  align="center" valign="middle">本月收款金额</td>
	  <td  align="center" valign="middle">本月应扣税金</td>
	  <td  align="center" valign="middle">本月计提分包费</td>
	  <td  align="center" valign="middle">本月计提特殊接待费</td>
	  <td  align="center" valign="middle">业绩小计</td>
	  <td  align="center" valign="middle">业绩系数</td>
	  <td  align="center" valign="middle">实计业绩</td>
	  <td  align="center" valign="middle">结案时间</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Quotation qt = list.get(i);
    	UserForm sales = UserAction.getInstance().getUserByName(qt.getSales());
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy.MM").format(qt.getConfirmtime())%></td>
      <td><%=qt.getSales() %></td>
      <td width="400px"><%=qt.getClient() %></td>
      <td><a href="javascript:showquotationlog('<%=qt.getPid() %>');"><%=qt.getPid() %></a></td>
      <td><%=qt.getProjectcontent() %></td>
      <td><%=qt.getPaynotes()==null?"":qt.getPaynotes()%></td>
      <td><%=qt.getProjectPrice()%></td>
      <td><%=qt.getPreadvance()+ qt.getSepay() + qt.getBalance() %></td>
      <td><%=qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance())%></td>
      <td width="100px"><%=qt.getTag()==null?"":qt.getTag()%></td>
      <td width="100px"><%=qt.getObject()==null?"":qt.getObject()%></td>
      <td><%=qt.getPresubcost()==0?"":qt.getPresubcost() %></td>
      <td><%=qt.getSpefund()==0?"":qt.getSpefund()%></td>
      
      <td>
      <%
      String tax="";
      String monthTax="";
      String payNotes="";
      if(qt.getPaynotes()!=null){
      payNotes=qt.getPaynotes();
      }
      if(payNotes.equals("发票")){
      	tax=FinanceQuotationAction.getInstance().getFourToFive1(qt.getTotalprice()*0.08);
      }%>
      <%=tax%>
      
      </td>
      <%
      //本月收款比例=已收金额/报价金额
        Float b =qt.getPreadvance() + qt.getSepay() + qt.getBalance();
      	Float c =b/qt.getTotalprice();
      	if(payNotes.equals("发票")){
      	tax=FinanceQuotationAction.getInstance().getFourToFive1(qt.getTotalprice()*0.08);
      	monthTax=FinanceQuotationAction.getInstance().getFourToFive1((qt.getPreadvance()+ qt.getSepay() + qt.getBalance())*0.08);
      }
       %>
      <td><%=FinanceQuotationAction.getInstance().getFourToFive(c) %></td>
      <td><%=FinanceQuotationAction.getInstance().getFourToFive(c)%></td>
      <td><%=FinanceQuotationAction.getInstance().getFourToFive(b) %></td>
      <td><%=monthTax%></td>
      <td><%=FinanceQuotationAction.getInstance().getFourToFive(qt.getPresubcost()*c)%></td>
      <td><%=FinanceQuotationAction.getInstance().getFourToFive(qt.getSpefund()*c)%></td>
      <td><%=FinanceQuotationAction.getInstance().getFourToFive1(b-qt.getTotalprice()*0.08 *c-qt.getPresubcost()*c-qt.getSpefund()*c)%></td>
      <td><%=qt.getAdvarceFactor()+","+qt.getSepayFactor()+","+qt.getBalanceFactor() %></td>
      <td>222</td>
	  <td><%=qt.getFinish()==null?"":qt.getFinish()%></td>
    </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
