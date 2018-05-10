<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.dao.impl.SampleDaoImpl"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("gbk");
String strId =request.getParameter("id");
List row =null;
int id=0;
if(strId !=null){
	String startId =strId.substring(0,strId.indexOf(";"));
	id=Integer.parseInt(startId);
	List list =new ArrayList();
	list.add("vsno");
	list.add("vsid");
	list.add("vsampleName");
	list.add("vmodel");
	list.add("vspeichorot");
	
	row=DaoFactory.getInstance().getSimpleDao().getSampleById(list,id);
}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>更改样品</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<script src="../javascript/jquery.js"></script>
	<script src="../javascript/jquery.autocomplete.min.js"></script>
	<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
	<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
	<style type="text/css" bogus="1"> 
.txt{ 
color:#005aa7; 
border-bottom:1px solid #005aa7; /* 下划线效果 */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* 背景色透明 */ 
} 
</style> 
<script type="text/javascript">
	function onIsEmpty(obj){
		var pno =document.getElementById("pno").value;
		if(pno == ""){
		alert("请输入样品编号！！");
		return false;
		}
		if(obj.value<=0){
		alert("请输入样品的数量！！");
		return false;
		}
		var form1=document.getElementById("form1");
		form1.action="sample.jsp";
		form1.submit();
	}
	
	function checkForm(obj){
	if(obj == ""){
	alert("请输入样品编号！！");
	return false;
	}
	var form1=document.getElementById("form1");
		form1.action="sample_post.jsp";
		form1.submit();
	}
</script>
  </head>
  
  <body > 
<form action="modifysample_post.jsp?id=<%=id%>&strId=<%=strId %>" method="post" name ="form1" id ="form1">

    	<table id ="mytable" border="0" align="center" width="900">
    		<tr>
    			<th>样品编号</th>
    			<th>样品名称</th>
    			<th>型号</th>
    			<th>项目号</th>
    			<th>保存位置</th>
    		</tr>
    		
    		<%
					for(int i=0;i<row.size();i++) {
					List columns =(List)row.get(i);
					 %>
					<tr>
						<td>
							<div align="center">
								<input type="text" id="sno<%=i%>" value="<%=columns.get(0) %>" name="sno" size="25" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="sname" name="sname" size="25" value="<%=columns.get(2) %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="smodel" name="smodel" size="25" value="<%=columns.get(3) %>">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="sid" name="sid" size="13"  value="<%=columns.get(1) %>">
							</div>
						</td>
						<td>
							<div align="center">
								<div align="center">
								<input type="text" id="speichorot" name="speichorot" size="25" value="<%=columns.get(4) %>">
							</div>
							</div>
						</td>
						
					
					</tr>
					<%
					}
					 %>
					 <tr align="center">
					 	<td colspan="6">
					 		<input type="submit" value="修改">
					 	</td>
					 </tr>
    	</table>
    </form>
    </body>
</html>
