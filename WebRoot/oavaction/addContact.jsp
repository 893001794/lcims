<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@page import="java.util.Date"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String custId = request.getParameter("custId");
	String status = request.getParameter("status");
	String sayWords ="";
	String contactDate="";
	String contactId="";
	if(status !=null){
		if(status.equals("modify")){
		 contactId = request.getParameter("contactId");
		System.out.println(contactId+":contactId");
		List row=new SearchFactory().getVOLClient().getContact(Integer.parseInt(contactId),"");
		List coulmn=(List)row.get(0);
		sayWords=coulmn.get(4).toString();
		contactDate=coulmn.get(1).toString();
		}
	}
		int id =0;
	if(custId == null || "".equals(custId)) {
		out.println("请选择记录！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
	id =Integer.parseInt(custId);
	//System.out.println(id);
	List rows =new SearchFactory().getVOLClient().getCustomer(id);
	//System.out.println(rows.size());
	List columns =(List)rows.get(0);
 %>
<html>
  <head>
    <title>添加联系记录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
	<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
	<script type="text/javascript">
		function modifyContact(obj){
			var myform =document.getElementById("myform");
			myform.action="addContact_post.jsp?status=modify&contactId="+obj;
			myform.submit();
		}
	</script>
  </head>
  
  <body>
  	<form action="addContact_post.jsp?status=add" method="post" name ="myform" id="myform">
   	  <table cellpadding="5" cellspacing="0" width="95%">
   	  	<input type="hidden" name ="custId" id="custId" value="<%=custId%>">
  		<input type="hidden" name ="xsdb" id="xsdb" value="<%=user.getName()%>">
		<tr>
			<td>
				客户简称：
			</td>
			<td>
				<input  name="nameshort" id="nameshort" size="40" type="text" value="<%=columns.get(0)==null?"":columns.get(0)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
			<td>
				联系人：
			</td>
			<td>
				<input  name="keyman" id="keyman" size="40" type="text" value="<%=columns.get(1)==null?"":columns.get(1)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
			
		<tr>
			<td>
				电话：
			</td>
			<td>
				<input  name="tel" id="tel" size="40" type="text" value="<%=columns.get(2)==null?"":columns.get(2)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
			<td>
				传真：
			</td>
			<td>
				<input  name="fax" id="fax" size="40" type="text" value="<%=columns.get(3)==null?"":columns.get(3)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
		</tr>
		<tr>
			
			<td>
				邮件：
			</td>
			<td>
				<input  name="email" id="email" size="40" type="text" value="<%=columns.get(4)==null?"":columns.get(4)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
			<td>
				手机：
			</td>
			<td>
				<input  name="add1" id="add1" size="40" type="text" value="<%=columns.get(5)==null?"":columns.get(5)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
		</tr>
		<tr>
			<td td width="150">
				跟进销售：
			</td>
			<td>
				<input  name="nowman" id="nowman" size="40" type="text" value="<%=columns.get(6)==null?"":columns.get(6)%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
			<td width="150">
				联系日期：
			</td>
			<td >
				<input  readonly="readonly"  name="contatdate" id="contatdate" size="40" type="text" value="<%=contactDate==""?new SimpleDateFormat("yyyy-MM-dd").format(new Date()):contactDate%>" readonly="readonly" style="background-color: #F2F2F2"  />
			</td>
		</tr>
		<tr>
			<td td width="150">
				内容记录：
			</td>
			<td colspan="3">
				<textarea name ="saywords" id="saywords" rows="5" cols="3" style="width: 870px"><%=sayWords%></textarea>
			</td>
		</tr>
		<tr align="center"">
			<td colspan="4">
				<%
				if(status!=null){
				 %>
				 <input type="button"" value="修改" onclick="modifyContact('<%=contactId%>');">
				 <%
				}else{
				%>
				<input type="submit" value="添加">
				 <%
				}
				 %>
				
			</td>
		</tr>
		</table>
	</form>
  </body>
</html>
