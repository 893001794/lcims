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

 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String quostart = request.getParameter("quostart");
String quoend = request.getParameter("quoend");
String acceptstart = request.getParameter("acceptstart");
String acceptend = request.getParameter("acceptend");
String paytimestart = request.getParameter("paytimestart");
String paytimeend = request.getParameter("paytimeend");
String dsubcosttime=request.getParameter("dsubcosttime");
String dsubcosttime2=request.getParameter("dsubcosttime2");
String counttime =request.getParameter("counttime");
String dagtime=request.getParameter("dagtime");
String spefundtime=request.getParameter("spefundtime");

float[] f;
List<Quotation> list = new ArrayList<Quotation>();
UserForm user = (UserForm)session.getAttribute("user");
	//boolean flag =user.getTicketid().matches("00010101");
	String userName =user.getName();
	String status=request.getParameter("status");

	if(userName.equals("郑妙芳")){
	status="LCQD";
	}
	//else if(flag == true){
	//status="LCQG";
	//}
	f = FinanceQuotationAction.getInstance().getFinanceProject(quostart,quoend,acceptstart,acceptend,paytimestart,paytimeend,dsubcosttime,dsubcosttime2,dagtime,spefundtime,counttime,command,list,status);
    session.setAttribute("financequotation",list);
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
		window.self.location = "../../financequotation";
	}
}

function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>
<body>
<br>
<h4 align="center">财务报价单统计</h4>
<form action="financequotationexport.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	<tr>
		<td width="70%">
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
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		收款起始日期:
			<input name="paytimestart" type="text" id="paytimestart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'paytimestart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="paytimeend" type="text" id="paytimeend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'paytimeend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;
		<%
		if(!user.getName().equals("郑妙芳")){
		
		 %>
		支付分包费A日期：<select name ="dsubcosttime" id ="dsubcosttime">
			<option value="" selected="selected">请选择月份</option>
			<option value="1" <%=("1").equals(dsubcosttime)?"selected":"" %>>1</option>
			<option value="2" <%=("2").equals(dsubcosttime)?"selected":"" %>>2</option>
			<option value="3" <%=("3").equals(dsubcosttime)?"selected":"" %>>3</option>
			<option value="4" <%=("4").equals(dsubcosttime)?"selected":"" %>>4</option>
			<option value="5" <%=("5").equals(dsubcosttime)?"selected":"" %>>5</option>
			<option value="6" <%=("6").equals(dsubcosttime)?"selected":"" %>>6</option>
			<option value="7" <%=("7").equals(dsubcosttime)?"selected":"" %>>7</option>
			<option value="8" <%=("8").equals(dsubcosttime)?"selected":"" %>>8</option>
			<option value="9" <%=("9").equals(dsubcosttime)?"selected":"" %>>9</option>
			<option value="10" <%=("10").equals(dsubcosttime)?"selected":"" %>>10</option>
			<option value="11" <%=("11").equals(dsubcosttime)?"selected":"" %>>11</option>
			<option value="12" <%=("12").equals(dsubcosttime)?"selected":"" %>>12</option>
		</select>
		支付分包费B日期：<select name ="dsubcosttime2" id ="dsubcosttime2">
			<option value="" selected="selected">请选择月份</option>
			<option value="1" <%=("1").equals(dsubcosttime2)?"selected":"" %>>1</option>
			<option value="2" <%=("2").equals(dsubcosttime2)?"selected":"" %>>2</option>
			<option value="3" <%=("3").equals(dsubcosttime2)?"selected":"" %>>3</option>
			<option value="4" <%=("4").equals(dsubcosttime2)?"selected":"" %>>4</option>
			<option value="5" <%=("5").equals(dsubcosttime2)?"selected":"" %>>5</option>
			<option value="6" <%=("6").equals(dsubcosttime2)?"selected":"" %>>6</option>
			<option value="7" <%=("7").equals(dsubcosttime2)?"selected":"" %>>7</option>
			<option value="8" <%=("8").equals(dsubcosttime2)?"selected":"" %>>8</option>
			<option value="9" <%=("9").equals(dsubcosttime2)?"selected":"" %>>9</option>
			<option value="10" <%=("10").equals(dsubcosttime2)?"selected":"" %>>10</option>
			<option value="11" <%=("11").equals(dsubcosttime2)?"selected":"" %>>11</option>
			<option value="12" <%=("12").equals(dsubcosttime2)?"selected":"" %>>12</option>
		</select>
		机构费用支付日期：<select name ="dagtime" id ="dagtime">
			<option value="" selected="selected">请选择月份</option>
			<option value="1" <%=("1").equals(dagtime)?"selected":"" %>>1</option>
			<option value="2" <%=("2").equals(dagtime)?"selected":"" %>>2</option>
			<option value="3" <%=("3").equals(dagtime)?"selected":"" %>>3</option>
			<option value="4" <%=("4").equals(dagtime)?"selected":"" %>>4</option>
			<option value="5" <%=("5").equals(dagtime)?"selected":"" %>>5</option>
			<option value="6" <%=("6").equals(dagtime)?"selected":"" %>>6</option>
			<option value="7" <%=("7").equals(dagtime)?"selected":"" %>>7</option>
			<option value="8" <%=("8").equals(dagtime)?"selected":"" %>>8</option>
			<option value="9" <%=("9").equals(dagtime)?"selected":"" %>>9</option>
			<option value="10" <%=("10").equals(dagtime)?"selected":"" %>>10</option>
			<option value="11" <%=("11").equals(dagtime)?"selected":"" %>>11</option>
			<option value="12" <%=("12").equals(dagtime)?"selected":"" %>>12</option>
		</select>
		特殊接待费支付日期：<select name ="spefundtime" id ="spefundtime">
			<option value="" selected="selected">请选择月份</option>
			<option value="" selected="selected">请选择月份</option>
			<option value="1" <%=("1").equals(spefundtime)?"selected":"" %>>1</option>
			<option value="2" <%=("2").equals(spefundtime)?"selected":"" %>>2</option>
			<option value="3" <%=("3").equals(spefundtime)?"selected":"" %>>3</option>
			<option value="4" <%=("4").equals(spefundtime)?"selected":"" %>>4</option>
			<option value="5" <%=("5").equals(spefundtime)?"selected":"" %>>5</option>
			<option value="6" <%=("6").equals(spefundtime)?"selected":"" %>>6</option>
			<option value="7" <%=("7").equals(spefundtime)?"selected":"" %>>7</option>
			<option value="8" <%=("8").equals(spefundtime)?"selected":"" %>>8</option>
			<option value="9" <%=("9").equals(spefundtime)?"selected":"" %>>9</option>
			<option value="10" <%=("10").equals(spefundtime)?"selected":"" %>>10</option>
			<option value="11" <%=("11").equals(spefundtime)?"selected":"" %>>11</option>
			<option value="12" <%=("12").equals(spefundtime)?"selected":"" %>>12</option>
		</select>
		
		支付分包费A/B/机构日期：<select name ="counttime" id ="counttime">
			<option value="" selected="selected">请选择月份</option>
			<option value="" selected="selected">请选择月份</option>
			<option value="1" <%=("1").equals(counttime)?"selected":"" %>>1</option>
			<option value="2" <%=("2").equals(counttime)?"selected":"" %>>2</option>
			<option value="3" <%=("3").equals(counttime)?"selected":"" %>>3</option>
			<option value="4" <%=("4").equals(counttime)?"selected":"" %>>4</option>
			<option value="5" <%=("5").equals(counttime)?"selected":"" %>>5</option>
			<option value="6" <%=("6").equals(counttime)?"selected":"" %>>6</option>
			<option value="7" <%=("7").equals(counttime)?"selected":"" %>>7</option>
			<option value="8" <%=("8").equals(counttime)?"selected":"" %>>8</option>
			<option value="9" <%=("9").equals(counttime)?"selected":"" %>>9</option>
			<option value="10" <%=("10").equals(counttime)?"selected":"" %>>10</option>
			<option value="11" <%=("11").equals(counttime)?"selected":"" %>>11</option>
			<option value="12" <%=("12").equals(counttime)?"selected":"" %>>12</option>
		</select>
		<%
		}
		 %>
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
			<%=quostart==null?new SimpleDateFormat("yyyy-MM-dd").format(new Date()):quostart %>
			--
			<%=quoend==null?new SimpleDateFormat("yyyy-MM-dd").format(new Date()):quoend %>
			</td>
			<td align="center" valign="middle">
			<%=acceptstart==null?"":acceptstart %>
			--
			<%=acceptend==null?"":acceptend %>
			</td>
			<td align="center" valign="middle"><%=f[1] %></td>
			<td align="center" valign="middle"><%=f[0] %></td>
		</tr>
	</table>

<p>&nbsp;</p>
  <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
    	<td align="center" valign="middle">所属时期(收单日期)</td>
      <td align="center" valign="middle">报价单号</td>
       <td align="center" valign="middle">被冲红报价号</td>
      <td  align="center" valign="middle">销售</td>
      <td  align="center" valign="middle">部门</td>
      <td  align="center" valign="middle" width="200px" style="width: 200px">客户名称</td>
      <td  align="center" valign="middle">项目名称</td>
      <td  align="center" valign="middle">报价金额</td>
      <td  align="center" valign="middle">票据形式</td>
	  <td  align="center" valign="middle">是否收款</td>
	  <td  align="center" valign="middle">收款方式</td>
	  <td  align="center" valign="middle">收款日期</td>
	  <td  align="center" valign="middle">已收金额</td>
	  <td  align="center" valign="middle">未收金额</td>
	  <td  align="center" valign="middle">预估分包费</td>
	  <td  align="center" valign="middle">实际分包费</td>
	  <td  align="center" valign="middle">预估机构费</td>
	  <td  align="center" valign="middle">实际机构费</td>
	  <td  align="center" valign="middle">特殊接待费</td>
	  <td  align="center" valign="middle">税金</td>
	  <td  align="center" valign="middle">其他</td>
	  <td  align="center" valign="middle">备注</td>
	    <td  align="center" valign="middle">收款备注</td>
	  <td  align="center" valign="middle">业绩小计</td>
	  <td  align="center" valign="middle">业绩系数</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Quotation qt = list.get(i);
    	String str="";
    	/*if(qt.getQuotype().equals("flu")){
    	str="-";
    	}*/
    	UserForm sales = UserAction.getInstance().getUserByName(qt.getSales());
		String dept = "";
		if("中山".equals(sales.getCompany())) {
			dept = sales.getDept();
		} else {
			dept = sales.getCompany();
		}
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
    	<td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy.MM").format(qt.getConfirmtime())%></td>
    	<td><a href="javascript:showquotationlog('<%=qt.getPid() %>');"><%=qt.getPid() %></a></td>
    	<td><%=qt.getOldPid() %></td>
      <td><%=qt.getSales() %></td>
       <td><%=dept%></td>
      <td width="400px"><%=qt.getClient() %></td>
       <td><%=qt.getProjectcontent()==null?"":qt.getProjectcontent() %></td>
      <td><%=str%><%=qt.getTotalprice() %></td>
      <td><%=qt.getInvtype() %></td>
      <td><%=qt.getPreadvance()==0?"n":"y" %></td>
      <td><%=qt.getCreditcard() %></td>
      <td width="100px"><%=qt.getPaytime()==null?"":new SimpleDateFormat("MM-dd").format(qt.getPaytime()) %></td>
     
      <td><%=qt.getPreadvance() + qt.getSepay() + qt.getBalance()%></td>
      <%
      	if(qt.getQuotype().equals("flu")){
    	%>
    	 <td><%=0.0%></td>
    	<%
    	}else{
    	%>
    	 <td><%=qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance())%></td>
    	<%
    	}
       %>
     
      <td><%=qt.getPresubcost() %></td>
      <td><%=qt.getSubcost() %></td>
      <td><%=qt.getPreagcost() %></td>
      <td><%=qt.getAgcost() %></td>
      <td><%=qt.getSpefund() %></td>
      <td><%=qt.getTax() %></td>
      <td><%=qt.getOthercost()%></td>
      <td><%=qt.getObject() %></td>
       <td><%=qt.getCollRemarks() %></td>
      <%
      //amountRece 为已收金额
      Float amountRece=qt.getPreadvance()+qt.getSepay()+qt.getBalance();
      Float sun =0.0f;
      //如果"实际总外部分包费==0"并且"实际总机构合作费==0"
      if(qt.getSubcost() ==0 && qt.getAgcost()==0){
      //则业绩小计=（已收款+二次收款+尾次收款）-预计总外部分包费-预计总机构合作费-实际特殊接待费-税金
      sun =amountRece-qt.getPresubcost()-qt.getPreagcost()-qt.getSpefund()-qt.getTax();
      }
      //如果"实际总外部分包费!=0"并且"实际总机构合作费==0"
      else if(qt.getSubcost() !=0 && qt.getAgcost()==0){
       //则业绩小计=（已收款+二次收款+尾次收款）-实际总外部分包费-预计总机构合作费-实际特殊接待费-税金
      sun =amountRece-qt.getSubcost()-qt.getPreagcost()-qt.getSpefund()-qt.getTax();
      }
      //如果"实际总外部分包费==0"并且"实际总机构合作费!=0"
      else if(qt.getSubcost() ==0 && qt.getAgcost()!=0){
      //则业绩小计=（已收款+二次收款+尾次收款）-预计总外部分包费-实际总机构合作费-实际特殊接待费-税金
      sun =amountRece-qt.getPresubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax();
      }
      //如果"实际总外部分包费!=0"并且"实际总机构合作费!=0"
      else if(qt.getSubcost() !=0 && qt.getAgcost()!=0){
      //则业绩小计=（已收款+二次收款+尾次收款）-实际总外部分包费-实际总机构合作费-实际特殊接待费-税金
      sun =amountRece-qt.getSubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax();
      }
      %>
      <td><%=sun%></td>
      <td><%=qt.getAdvarceFactor()+","+qt.getSepayFactor()+","+qt.getBalanceFactor()%></td>
    </tr>
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
