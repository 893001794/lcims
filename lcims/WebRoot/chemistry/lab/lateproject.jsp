<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.vo.Synthesis"%>
 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
float latepercent = 0;
String start = request.getParameter("start");
String end = request.getParameter("end");
float latepercent0 = 0;  //总的迟单统计
float latepercent1 = 0;  //总的迟单统计
float lateStat = 0;  //总的迟单统计
float lateStatZ = 0;  //中山迟单统计
float lateStatD = 0 ; //东莞迟单统计
String seleYear =request.getParameter("seleyear");
String seleMonth =request.getParameter("selemonth");

String parttype ="";
String str ="";
if(request.getParameter("parttype")!=null && ! "".equals(request.getParameter("parttype"))){
	parttype=request.getParameter("parttype");
}else{
	parttype="late";
}

if(parttype.equals("late")){
str="迟单率";
}else{
str ="报告正确率";
}



Date date =new Date ();

if(seleYear == null || "".equals(seleYear)){
   seleYear = new SimpleDateFormat("yyyy").format(date); //获取年份
}if(seleMonth == null || "".equals(seleMonth)){
	seleMonth =new SimpleDateFormat("MM").format(date); //获取月份
}

int[] family;

List list = null;
if(command != null && "search".equals(command)) {
		//list = ChemProjectAction.getInstance().getLateProject(start,end,command,seleYear,seleMonth);
			list = ChemProjectAction.getInstance().getSynthesis(start,end,command,seleYear,seleMonth,parttype);
			family = LabAction.getInstance().getSynPercent(start,end,command,seleYear,seleMonth,parttype);
			//System.out.println(family);
			latepercent0=family[0];
			latepercent1=family[1];
			if(family[0]>0&&family[1]>0){
				latepercent = family[0] * 100 / family[1];
			}
			lateStat=family[2];
			lateStatZ=family[3];
			lateStatD=family[4];
	
} else {
	list = ChemProjectAction.getInstance().getSynthesis(start,end,command,seleYear,seleMonth,parttype);
	//list = ChemProjectAction.getInstance().getLateProject(start,end,command,seleYear,seleMonth);
	family = LabAction.getInstance().getSynPercent(start,end,command,seleYear,seleMonth,parttype);
	latepercent = family[0] * 100 / family[1];
}
session.setAttribute("lateprojects",list);
session.setAttribute("family",family);
 %>
 
<html>
<head>
<title>迟单项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--
function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../lateproject";
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
<h4 align="center">迟单预警</h4>
<form action="lateproject.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
<tr>
	<td colspan="3">
		<div id ="mydiv">
		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="late"  <%=parttype.equals("late")?"checked":"" %>/>&nbsp;<font style="font-size: 14px">迟单统计</font>&nbsp;
         <input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="precision" <%=parttype.equals("precision")?"checked":"" %>/>&nbsp;<font style="font-size: 14px">报告正确率</font>&nbsp;
         <font style="font-size: 14px">应出报告总数：<%=lateStat%></font>&nbsp; &nbsp;                
         <font style="font-size: 14px">应出中山报告总数：<%=lateStatZ%></font>&nbsp; &nbsp;                
         <font style="font-size: 14px">应出东莞报告总数：<%=lateStatD%></font>&nbsp; &nbsp;                
	<script>   
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else obj.children[i].checked = true;   
						         }   
						     }   
						 </script>
		</div>
	</td>
</tr>
	<tr>
		<td width="85%">
		<font style="font-size: 14px">开始时间:</font>
			<input name="start" type="text" id="start" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'start'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="15" height="22" align="absmiddle">
      	<font style="font-size: 14px">结束时间:</font>
			<input name="end" type="text" id="end" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="15" height="22" align="absmiddle">
		<font style="font-size: 14px">年份：</font><select name ="seleyear" id ="seleyear">
      			<option value="2010" <%=seleYear.equals("2010")?"selected":"" %>>2010</option>
      			<option value="2011" <%=seleYear.equals("2011")?"selected":"" %>>2011</option>
      			<option value="2012" <%=seleYear.equals("2012")?"selected":"" %>>2012</option>
      			<option value="2013" <%=seleYear.equals("2013")?"selected":"" %>>2013</option>
      			<option value="2014" <%=seleYear.equals("2014")?"selected":"" %>>2014</option>
      			<option value="2015" <%=seleYear.equals("2015")?"selected":"" %>>2015</option>
      			<option value="2016" <%=seleYear.equals("2016")?"selected":"" %>>2016</option>
      			<option value="2017" <%=seleYear.equals("2017")?"selected":"" %>>2017</option>
      			<option value="2018" <%=seleYear.equals("2018")?"selected":"" %>>2018</option>
      			<option value="2019" <%=seleYear.equals("2019")?"selected":"" %>>2019</option>
      			<option value="2020" <%=seleYear.equals("2020")?"selected":"" %>>2020</option>
      		</select>
      		<font style="font-size: 14px">月份：</font><select name ="selemonth" id ="selemonth">
      			<option value="01" <%=seleMonth.equals("01")?"selected":"" %>>01</option>
      			<option value="02" <%=seleMonth.equals("02")?"selected":"" %>>02</option>
      			<option value="03" <%=seleMonth.equals("03")?"selected":"" %>>03</option>
      			<option value="04" <%=seleMonth.equals("04")?"selected":"" %>>04</option>
      			<option value="05" <%=seleMonth.equals("05")?"selected":"" %>>05</option>
      			<option value="06" <%=seleMonth.equals("06")?"selected":"" %>>06</option>
      			<option value="07" <%=seleMonth.equals("07")?"selected":"" %>>07</option>
      			<option value="08" <%=seleMonth.equals("08")?"selected":"" %>>08</option>
      			<option value="09" <%=seleMonth.equals("09")?"selected":"" %>>09</option>
      			<option value="10" <%=seleMonth.equals("10")?"selected":"" %>>10</option>
      			<option value="11" <%=seleMonth.equals("11")?"selected":"" %>>11</option>
      			<option value="12" <%=seleMonth.equals("12")?"selected":"" %>>12</option>
      		</select>
			<input name="button" value="统计" type="submit" />
			<input name="export" value="导出Excel" type="button" onclick="exportToExcel();" />
			<font style="font-size: 14px">&nbsp;&nbsp;&nbsp;&nbsp;迟单数/项目总数：<%=family[0]%>/<%=family[1]%></font>
		</td>
		<td width="6%">
			<font style="font-size: 14px"><%=str%>:</font>
		</td>
		<td width="3%"><font style="font-size: 14px"><%=latepercent%>%</font></td>
	</tr>
</table>
</form>
<p>&nbsp;</p>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td align="center" valign="middle">项目等级</td>
      <td  align="center" valign="middle">报告编号</td>
      <td  align="center" valign="middle">项目内容</td>
      <td  align="center" valign="middle">排单时间</td>
      <td  align="center" valign="middle">应出报告时间</td>
      <td  align="center" valign="middle">实际完成时间</td>
      <td  align="center" valign="middle">销售人员</td>
      <td  align="center" valign="middle">客服人员</td>
      <td  align="center" valign="middle">工程师</td>
	  <td  align="center" valign="middle">项目状态</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Synthesis sy= (Synthesis)list.get(i);
    	Quotation qt = QuotationAction.getInstance().getQuotationByPid(sy.getPid());
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=sy.getLevel()==null?"":sy.getLevel()%></td>
      <td><%=sy.getRid()%></td>
      <td><%=sy.getTestcontent()%></td>
      <td><%=sy.getCreatetime()%></td>
      <td><%=sy.getRptime()%></td>
      <td><%=sy.getSendtime()==null?"":sy.getSendtime()%></td>
      <td><%=qt.getSales()%></td>
      <td><%=sy.getServname()%></td>
      <td><%=sy.getEngineer()==null?"":sy.getEngineer()%></td>
      <td><%=sy.getStatus()==null?"":sy.getStatus()%></td>
    </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
