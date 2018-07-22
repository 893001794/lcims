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

	if(userName.equals("֣�")){
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
<title>����ӵ���Ŀ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--
function showquotationlog(pid) {
	window.open("quotationlog.jsp?pid=" + pid);
}

function exportToExcel() {
	if(confirm("ȷ������?")) {
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
<h4 align="center">���񱨼۵�ͳ��</h4>
<form action="financequotationexport.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	<tr>
		<td width="70%">
		������ʼʱ��:
			<input name="quostart" type="text" id="quostart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'quostart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="quoend" type="text" id="quoend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'quoend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;
		�յ���ʼʱ��:
			<input name="acceptstart" type="text" id="acceptstart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'acceptstart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="acceptend" type="text" id="acceptend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'acceptend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		�տ���ʼ����:
			<input name="paytimestart" type="text" id="paytimestart" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'paytimestart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="paytimeend" type="text" id="paytimeend" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'paytimeend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;
		<%
		if(!user.getName().equals("֣�")){
		
		 %>
		֧���ְ���A���ڣ�<select name ="dsubcosttime" id ="dsubcosttime">
			<option value="" selected="selected">��ѡ���·�</option>
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
		֧���ְ���B���ڣ�<select name ="dsubcosttime2" id ="dsubcosttime2">
			<option value="" selected="selected">��ѡ���·�</option>
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
		��������֧�����ڣ�<select name ="dagtime" id ="dagtime">
			<option value="" selected="selected">��ѡ���·�</option>
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
		����Ӵ���֧�����ڣ�<select name ="spefundtime" id ="spefundtime">
			<option value="" selected="selected">��ѡ���·�</option>
			<option value="" selected="selected">��ѡ���·�</option>
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
		
		֧���ְ���A/B/�������ڣ�<select name ="counttime" id ="counttime">
			<option value="" selected="selected">��ѡ���·�</option>
			<option value="" selected="selected">��ѡ���·�</option>
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
		 <%if(!userName.equals("֣�")){%>
					������
							<select name="status" style="width: 100px" onchange="changeStatus()">
							<option value="">
									ȫ��
							</option>
								<option value="LCQ1">
									��ɽ����һ
								</option>
								<option value="LCQ2">
									��ɽ���۶�
								</option>
								<option value="LCQG">
									����
								</option>
								<option value="LCQD">
									��ݸ
								</option>
							</select>
					
					<%}  %>
			<input name="button" value="ͳ��" type="submit" />
			&nbsp;&nbsp;
			<input name="export" value="������Excel" type="button" onclick="exportToExcel();" />
		</td>
	</tr>
</table>
</form>

	<table align="center" width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
		<tr bgcolor="dddddd"> 
		
			<td align="center" valign="middle">������ʼʱ��</td>
			<td align="center" valign="middle">�յ���ʼʱ��</td>
			<td align="center" valign="middle">ǩ����</td>
			<td align="center" valign="middle">ҵ��ͳ��</td>
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
    	<td align="center" valign="middle">����ʱ��(�յ�����)</td>
      <td align="center" valign="middle">���۵���</td>
       <td align="center" valign="middle">����챨�ۺ�</td>
      <td  align="center" valign="middle">����</td>
      <td  align="center" valign="middle">����</td>
      <td  align="center" valign="middle" width="200px" style="width: 200px">�ͻ�����</td>
      <td  align="center" valign="middle">��Ŀ����</td>
      <td  align="center" valign="middle">���۽��</td>
      <td  align="center" valign="middle">Ʊ����ʽ</td>
	  <td  align="center" valign="middle">�Ƿ��տ�</td>
	  <td  align="center" valign="middle">�տʽ</td>
	  <td  align="center" valign="middle">�տ�����</td>
	  <td  align="center" valign="middle">���ս��</td>
	  <td  align="center" valign="middle">δ�ս��</td>
	  <td  align="center" valign="middle">Ԥ���ְ���</td>
	  <td  align="center" valign="middle">ʵ�ʷְ���</td>
	  <td  align="center" valign="middle">Ԥ��������</td>
	  <td  align="center" valign="middle">ʵ�ʻ�����</td>
	  <td  align="center" valign="middle">����Ӵ���</td>
	  <td  align="center" valign="middle">˰��</td>
	  <td  align="center" valign="middle">����</td>
	  <td  align="center" valign="middle">��ע</td>
	    <td  align="center" valign="middle">�տע</td>
	  <td  align="center" valign="middle">ҵ��С��</td>
	  <td  align="center" valign="middle">ҵ��ϵ��</td>
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
		if("��ɽ".equals(sales.getCompany())) {
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
      //amountRece Ϊ���ս��
      Float amountRece=qt.getPreadvance()+qt.getSepay()+qt.getBalance();
      Float sun =0.0f;
      //���"ʵ�����ⲿ�ְ���==0"����"ʵ���ܻ���������==0"
      if(qt.getSubcost() ==0 && qt.getAgcost()==0){
      //��ҵ��С��=�����տ�+�����տ�+β���տ-Ԥ�����ⲿ�ְ���-Ԥ���ܻ���������-ʵ������Ӵ���-˰��
      sun =amountRece-qt.getPresubcost()-qt.getPreagcost()-qt.getSpefund()-qt.getTax();
      }
      //���"ʵ�����ⲿ�ְ���!=0"����"ʵ���ܻ���������==0"
      else if(qt.getSubcost() !=0 && qt.getAgcost()==0){
       //��ҵ��С��=�����տ�+�����տ�+β���տ-ʵ�����ⲿ�ְ���-Ԥ���ܻ���������-ʵ������Ӵ���-˰��
      sun =amountRece-qt.getSubcost()-qt.getPreagcost()-qt.getSpefund()-qt.getTax();
      }
      //���"ʵ�����ⲿ�ְ���==0"����"ʵ���ܻ���������!=0"
      else if(qt.getSubcost() ==0 && qt.getAgcost()!=0){
      //��ҵ��С��=�����տ�+�����տ�+β���տ-Ԥ�����ⲿ�ְ���-ʵ���ܻ���������-ʵ������Ӵ���-˰��
      sun =amountRece-qt.getPresubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax();
      }
      //���"ʵ�����ⲿ�ְ���!=0"����"ʵ���ܻ���������!=0"
      else if(qt.getSubcost() !=0 && qt.getAgcost()!=0){
      //��ҵ��С��=�����տ�+�����տ�+β���տ-ʵ�����ⲿ�ְ���-ʵ���ܻ���������-ʵ������Ӵ���-˰��
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
