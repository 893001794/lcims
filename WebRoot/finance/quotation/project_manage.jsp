<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	String pid = request.getParameter("pid");
	String client =request.getParameter("client");
	String term="";
	int status=0;
	List inforList=null;
	if(command !=null && !"".equals(command)){
	//System.out.println(pid+"----"+client);
		if(pid !=null && client ==""){
		term =pid;
		}else if(pid =="" && client !=null){
		term=client;
		status=1;
		}else{
			out.println("<script type='text/javascript'>");
			out.println("alert('必须输入一个查询条件！！！');");
			out.println("</script>");
			return;
		}
		inforList=DaoFactory.getInstance().getProjectPrice().projectInfor(term,status);
	}else{
		inforList =new ArrayList();
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>财务的项目统计</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
 
	</head>

	<body class="body1">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>报价管理&gt;&gt;管理报价单</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=project_manage.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
							<font color="red">请输入报价单号：&nbsp;&nbsp;</font>
							<input type=text name=pid size="40"/>
							<input type=submit name=Submit value=搜索>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">请输入客户名称：&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=搜索>
							<script>   
						        $("#client").autocomplete("../../myclient_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
						</td>
				</tr>
					
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>

			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">项目统计列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr style="text-align: center;" >
					<td class="rd6" >
						日期
					</td>
					<td class="rd6" width="250px" style="text-align: center;" >
						报价单号
					</td>
					<td class="rd6" width="250px" style="text-align: center;" >
						客户
					</td>
					<td class="rd6" >
						收款部门
					</td>
					<td class="rd6" >
						已收款
					</td>
					<td class="rd6" >
						化学测试
					</td>
					<td class="rd6" >
						电子电器安全测试
					</td>
					<td class="rd6" >
						EMC测试
					</td>
					<td class="rd6" >
						光性能测试
					</td>
					<td class="rd6">
						能效测试
					</td>
					<td class="rd6">
						小计
					</td>
				</tr>
				
				<%
				if(inforList.size()>0){
					for(int i=0;i<inforList.size();i++){
					List columns =(List)inforList.get(i);
						float chemTest=0;
						float safeTest=0;
						float emcTest=0;
						float optTest=0;
						float energyTest=0;
						List temp =new ArrayList();
						temp.add("化学测试");
						temp.add("电子电器安全测试");
						temp.add("EMC测试");
						temp.add("光性能测试");
						temp.add("能效测试");
						for(int j=0;j<temp.size();j++){
							String type =temp.get(j).toString();
							float testPrice=DaoFactory.getInstance().getProjectPrice().getProjectPrice(columns.get(1).toString(),type);
							if(testPrice>0){
								chemTest= j==0?testPrice:chemTest;
								safeTest= j==1?testPrice:safeTest;
								emcTest= j==2?testPrice:emcTest;
								optTest= j==3?testPrice:optTest;
							}
						}
				 %>
				
				<tr>
					<td class="rd8" width="8%">
						<%=columns.get(0)!=null?columns.get(0).toString().substring(0,10):""%>
					</td>
					<td class="rd8" width="10%">
						<%=columns.get(1)%>
					</td>
					<td class="rd8">
						<%=columns.get(2)%>
					</td>
					<td class="rd8">
						<%=columns.get(3)%>
					</td>
					<td class="rd8">
						<%=columns.get(4)%>
					</td>
					<td class="rd8">
						<%=chemTest%>
					</td>
					<td class="rd8">
						<%=safeTest%>
					</td>
					<td class="rd8">
						<%=emcTest%>
					</td>
					<td class="rd8">
						<%=optTest%>
					</td>
					<td class="rd8">
						<%=energyTest%>
					</td>
					<td class="rd8">
						<%=columns.get(5)%>
					</td>
					
				</tr>
				
				<%
				}
				}
				 %>
			</table>
			<br>
	</body>
</html>
