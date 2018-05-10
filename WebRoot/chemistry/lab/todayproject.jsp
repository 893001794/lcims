<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="java.text.SimpleDateFormat"%>
 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String start = request.getParameter("start");
String end = request.getParameter("end");
String rptime=request.getParameter("rptime");

int[] family;
String parttype="";

if (request.getParameter("parttype") != null && !"".equals(request.getParameter("parttype"))) {
		parttype =request.getParameter("parttype");
	}
List<Project> list = null;
if(command != null && "search".equals(command)) {
	list = ChemProjectAction.getInstance().getTodayProject(start,end,rptime,command,parttype);
} else {
	list = ChemProjectAction.getInstance().getTodayProject(start,end,rptime,command,parttype);
}
session.setAttribute("todayprojects",list);
 %>
 
<html>
<head>
<title>当天接单项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--
function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../../todayprojects";
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
 <form name=search id="search" method="post" action="todayproject.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search" >
            
            <tr>
		<td width="90%">
	      	<div id="mydiv">
	      			开始时间:
			<input name="start" type="text" id="start" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'start'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	      	&nbsp;&nbsp;
      	结束时间:
			<input name="end" type="text" id="end" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		&nbsp;&nbsp;
      	应出报告时间:
			<input name="rptime" type="text" id="rptime" size="20" maxlength="50" value="">
	      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'rptime'})" 
	      	src="../../javascript/date/skin/datePicker.gif" width="16" height="22" align="absmiddle">
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="n"  <%=parttype.equals("n")?"checked":"" %> />&nbsp;未完成&nbsp;
            		<input name="button" value="统计" type="submit" />
					<input name="export" value="导出到Excel" type="button" onclick="exportToExcel();" />
            	</div>
            		 <script>   
	    
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else obj.children[i].checked = true;   
						         }   
						         var search=document.getElementById("search");
						         search.action ="todayproject.jsp";
						         search.submit();
						     }   
						 </script>
						</td> 	
	</tr>
</table>
</form>
<p>&nbsp;</p>
  <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td align="center" valign="middle">项目等级</td>
      <td  align="center" valign="middle">报告编号</td>
      <td  align="center" valign="middle">报价编号</td>
      <td  align="center" valign="middle" width="500" style="width: 300">报告客户</td>
      <td  align="center" valign="middle">项目内容</td>
      <td  align="center" valign="middle">排单时间</td>
      <td  align="center" valign="middle">应出报告时间</td>
      <td  align="center" valign="middle">实际完成时间</td>
      <td  align="center" valign="middle">销售人员</td>
      <td  align="center" valign="middle">客服人员</td>
      <td  align="center" valign="middle">工程师</td>
      <td align="center" valign="middle">报告填数时间/人</td>
      <td align="center" valign="middle">报告审核时间/人</td>
	  <td  align="center" valign="middle">项目状态</td>
    </tr>
    
    <%
    for(int i=0;i<list.size();i++) {
    	Project p = list.get(i);
    	ChemProject cp = (ChemProject)p.getObj();
    	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
     %>
    
    <tr align=center valign=middle bgcolor="white"> 
      <td><%=p.getLevel() %></td>
      <td><%=p.getRid() %></td>
      <td><%=p.getPid() %>
       <td><%=cp.getClient() %>
      <td><%=p.getTestcontent() %></td>
      <td><%=cp.getCreatetime() %></td>
      <td><%=cp.getRptime() %></td>
      <td><%=cp.getEndtime()%></td>
      <td><%=qt.getSales() %></td>
      <td><%=cp.getServname() %></td>
      <td><%=cp.getEngineer() %></td>
      <td >
		<%=cp.getNucopletintime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getNucopletintime()) %>/<%=cp.getNucopletinuser()==null?"":cp.getNucopletinuser() %>
	</td>
					
	<td>
		<%=cp.getRpconfirmtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRpconfirmtime()) %>/<%=cp.getRpconfirmuser()==null?"":cp.getRpconfirmuser() %>
	</td>
      <td><%=cp.getStatus() %></td>
    </tr>
    
    <%
    }
     %>

  </table>
  <br>
  <br>
</body>
</html>
