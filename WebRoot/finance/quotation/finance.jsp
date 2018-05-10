<%@page import="com.lccert.oa.vo.Group"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../../../error.jsp" %>
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
<%@ include file="../../comman.jsp"  %>
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String dept = request.getParameter("area");

String month=request.getParameter("month");
String group="";
//if(command !=null){
 //group=request.getParameter("group");
//}
System.out.println(group);
String deptStr ="";
if(dept == null){
dept ="1";
}else if(dept.equals("1")){
deptStr="销售一部";
}else if(dept.equals("2")){
deptStr="销售二部";
}else if(dept.equals("3")){
deptStr="EMC";
}else if(dept.equals("G")){
deptStr="广州";
}else if(dept.equals("D")){
deptStr="东莞";
}
Group group2=new Group(); 
//if(group !=null && !group.equals("")){
//	group2=UserAction.getInstance().grouptById(Integer.parseInt(group));
//}
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
String acceptstart = request.getParameter("acceptstart");
String acceptend = request.getParameter("acceptend");
List<Quotation> list = new ArrayList<Quotation>();
float[] f;
f = FinanceQuotationAction.getInstance().getFinanceProject(command,acceptstart,acceptend,year,month,dept,group,list);
  session.setAttribute("financeQ",list);
  session.setAttribute("total",f);
 %>
 
<html>
<head>
<title>当天接单项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script src="../../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../../javascript/suggest.js"></script>
		<script src="../../javascript/orderscript.js"></script>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" href="../../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
<script language="javascript">

<!--
function showquotationlog(pid) {
	window.open("quotationlog.jsp?pid=" + pid);
}

function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../financeManage";
	}
}



function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}



 var req;
    function Change_Select(obj){//当第一个下拉框的选项发生改变时调用该函数
   // if(obj=="2"){
    //    var year =document.getElementById("year").value;
   //     var month =document.getElementById("month").value;
   // 	window.location.href="finance2.jsp?year="+year+"&month="+month+"&area="+obj;
   // }
      var companyid =1;
      var url = "group_sales.jsp?dept=" + encodeURI(encodeURI(obj)) + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("POST",url,true);
         //指定回调函数为callback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //回调函数
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//解析XML文档
        }else{
         // alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //解析返回xml的方法
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
      var xSel = xmlDoc.getElementsByTagName('select');
      //获得XML文档中的所有<select>标记
      var select_root = document.getElementById('group');
      //获得网页中的第二个下拉框
      select_root.options.length=0;
      select_root.add(new Option("全部", ""));
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //alert(xValue+"---"+xText);
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
        var option = new Option(xText, xValue);
        //根据每组value和text标记的值创建一个option对象
        
        try{
        	//alert(option);
        	
          select_root.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
        }
      	var ops = document.getElementById("group").options;
		for(var i=0;i<ops.length;i++) {
			if(ops[i].value.charCodeAt() == "<%=group%>".charCodeAt()){
				ops[i].selected = true;	
			}
		}
     
	
    }    
    
    function exportEMC(){
   // window.showModalDialog("../../emckis/order_manage.jsp","","dialogWidth:1200px;dialogHeight:1200px");
    window.location.href("../../emckis/order_manage.jsp");
    }  
    
     function payFinance(){
    window.location.href("payFinance.jsp");
    } 
      
</script>
</head>
<body onLoad="Change_Select('<%=dept%>');">
<br>
<h4 align="center">财务报价单统计</h4>
<form name ="search" id ="search" action="finance.jsp?command=search2" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
	<tr>
	<td>
	收单/收款
	<select name ="year" id ="year" onChange="searchsales();">
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
		</select>年
		<select name ="month" id ="month" onChange="searchsales();">
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
		</select>月
		<input name="acceptstart" type="text" id="acceptstart" size="20" maxlength="50" value="<%=acceptstart==null?"":acceptstart%>">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'acceptstart'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">

			<input name="acceptend" type="text" id="acceptend" size="20" maxlength="50" value="<%=acceptend==null?"":acceptend%>">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'acceptend'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;
		部门：
		&nbsp;&nbsp;
		<select name ="area" id ="area" onChange="Change_Select(this.value);">
			<%if(user.getCompany().equals("中山")){
			%>
			<option value="1" <%="1".equals(dept)?"selected":"" %>>销售一部</option>
			<option value="2" <%="2".equals(dept)?"selected":"" %>>销售二部</option>
			<option value="3" <%="3".equals(dept)?"selected":"" %>>EMC</option>
			<option value="D" <%="D".equals(dept)?"selected":"" %>>东莞</option>
			<%
			}
			if(user.getCompany().equals("广州")||user.getCompany().equals("中山")){
			%>
			<option value="G" <%="G".equals(dept)?"selected":"" %>>广州</option>
			<%
			} %>
		</select>
		&nbsp;&nbsp;
		组：
		<select name ="group" id ="group">
		</select>
	      	<input name="button" value="统计" type="submit" />
			&nbsp;&nbsp;
			<input name="export" value="导出到Excel" type="button" onClick="exportToExcel();" />
			&nbsp;&nbsp;
			<input name="export" value="管理EMC" type="button" onClick="exportEMC();" />
			<input name="export" value="收单未收款" type="button" onClick="payFinance();" />
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
			<td>
			</td>
			<td align="center" valign="middle"><%=f[1] %></td>
			<td align="center" valign="middle"><%=f[0] %></td>
		</tr>
	</table>
<p>&nbsp;</p>
  <table align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td align="center" valign="middle">所属年份</td>
      <td align="center" valign="middle">所属月份</td>
       <td  align="center" valign="middle">销售</td>
       <td  align="center" valign="middle">所在组</td>
      <td  align="center" valign="middle">排单人员</td>
      <td  align="center" valign="middle" width="400px">客户名称</td>
      <td align="center" valign="middle">报价单号</td>
       <td align="center" valign="middle">被冲红报价号</td>
      <td  align="center" valign="middle">项目类型</td>
      <td  align="center" valign="middle">项目名称</td>
      <td  align="center" valign="middle">收款日期</td>
      <td  align="center" valign="middle">收款方式</td>
      <td  align="center" valign="middle">票据形式</td>
      <td  align="center" valign="middle">报价金额</td>
      <td  align="center" valign="middle">已收金额</td>
	  <td  align="center" valign="middle">未收金额</td>
	  <td  align="center" valign="middle">备注</td>
	  <td  align="center" valign="middle">预估分包费+机构费</td>
	  <td  align="center" valign="middle">预估特殊接待费</td>
	  <td  align="center" valign="middle">税金</td>
	  <td  align="center" valign="middle">其他费用</td>
	  <td  align="center" valign="middle">本月收款比例</td>
	  <td  align="center" valign="middle">本月收款金额</td>
	  <td  align="center" valign="middle">本月扣机构费+分包费</td>
	  <td  align="center" valign="middle">本月扣特殊接待费</td>
	  <td  align="center" valign="middle">本月扣税金</td>
	  <td  align="center" valign="middle">本月扣其他费用</td>
	  <td  align="center" valign="middle">坏账扣款</td>
	  <td  align="center" valign="middle">业绩小计</td>
	  <td  align="center" valign="middle">是否结案</td>
	  <td  align="center" valign="middle">结案日期</td>
    </tr>
 	 <%
 	 DecimalFormat df=new DecimalFormat("#.00");  
    for(int i=0;i<list.size();i++) {
    	Quotation qt = list.get(i);
    	String str="";
    	UserForm sales = UserAction.getInstance().getUserByName(qt.getSales());
     %>
    <tr align=center valign=middle bgcolor="white"> 
    	<td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy").format(qt.getConfirmtime())%></td>
    	<td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("MM").format(qt.getConfirmtime())%></td>
    	<td><%=qt.getSales() %></td>
    	<%
    	//if(group2.getGROUP_NAME()==null&& qt.getGroupId()!=null ){
    	//	group2=UserAction.getInstance().grouptById(qt.getGroupId());
    	//(group2!=null&&getGROUP_NAME()!=null)?group2.getGROUP_NAME():""
    	//}
    	 %>
    	<td>&nbsp;</td>
      	<td><%=qt.getCreatename()==null?"":qt.getCreatename()%></td>
      	<td ><%=qt.getClient() %></td>
    	<td><a href="javascript:showquotationlog('<%=qt.getPid() %>');"><%=qt.getPid() %></a></td>
    	<td><%=qt.getOldPid() %></td>
    	
      <td>&nbsp;</td>
       <td><%=qt.getProjectcontent()==null?"":qt.getProjectcontent() %></td>
       <td width="100px"><%=qt.getPaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(qt.getPaytime()) %></td>
      <td><%=qt.getCreditcard()==null?"":qt.getCreditcard() %></td>
      <td><%=qt.getInvtype() %></td>
      <td><%=str%><%=df.format(qt.getTotalprice()) %></td>
      <td><%=df.format(qt.getPreadvance() + qt.getSepay() + qt.getBalance())%></td>
      <%
      	if(qt.getQuotype().equals("flu")){
    	%>
    	 <td><%=0.0%></td>
    	<%
    	}else{
    	%>
    	 <td><%=df.format(qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance()))%></td>
    	<%
    	}
    	
       %>
      <td><%=qt.getObject()==null?"":qt.getObject() %></td>
      <td><%=qt.getPresubcost()+qt.getPreagcost()%></td>
      <td><%=qt.getPrespefund() %></td>
      <td><%=qt.getInvtype().equals("收据")?"0":df.format(qt.getTotalprice()*0.08)%></td>
      <td><%=df.format(qt.getOthercost())%></td>
     <%
      float scale=(qt.getPreadvance() + qt.getSepay() + qt.getBalance())/qt.getTotalprice();//收款比例
      if(qt.getTotalprice()==0){
      	scale=0.0f;
      }
      %>
      <td><%=df.format(scale*100)%>%</td>
      <td><%=df.format(qt.getPreadvance() + qt.getSepay() + qt.getBalance()) %></td>
      <td><%=df.format((qt.getPresubcost()+qt.getPreagcost())*scale)%></td>
      <td><%=df.format(qt.getPrespefund()*scale)%></td>
      <td><%=qt.getInvtype().equals("收据")?"0":df.format(qt.getTotalprice()*0.08*scale)%></td>
      <td><%=df.format(qt.getOthercost())%></td>
      <td><%=qt.getBadDebt()==null?"":qt.getBadDebt()%></td>
      <%
   		 Float sun =0.0f;
   		 Float taxes=qt.getTotalprice()*0.08f*scale;
   		 Float amountRece=qt.getPreadvance()+qt.getSepay()+qt.getBalance();//已收金额
   		 
   		  //杂费金额比例=(预计分包费+机构费)*收款比例-特殊接待费*收款比例*其他费用
		 Float othercost=(qt.getPresubcost()+qt.getPreagcost())*scale+qt.getPrespefund()*scale+qt.getOthercost();//已收款金额
		  //坏账额
		 Float badDebt=Float.parseFloat(qt.getBadDebt()==null||qt.getBadDebt().equals("")?"0.0":qt.getBadDebt());
		 //业绩小计=已收金额-税金比例-杂费金额比例-坏账
		 sun=amountRece-taxes-othercost-badDebt;
      %>
      <td><%=df.format(sun)%></td>
      <td><%=qt.getFinish()!=null?"结案":"进行中"%></td>
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
