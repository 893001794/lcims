<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("gbk");
String pno =request.getParameter("pno");
List list =new ArrayList();
list.add("vpackageName");
list.add("vclient");
list.add("vpid");
list.add("vsid");
list.add("vreciptent");
list.add("dreceipt");
List row =DaoFactory.getInstance().getSimpleDao().getPackageNo(list,pno);
List columns=(List)row.get(0);
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'sample_package.jsp' starting page</title>
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
border-bottom:1px solid #005aa7; /* �»���Ч�� */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* ����ɫ͸�� */ 
} 
</style> 
  </head>
  
  <body onload="javascript:myform.ems.focus();"> 

    	<table border="0" align="center" width="900">
    		<tr>
    			
    		    <form action="sample_package.jsp?" style="text-align: center;" name="myform" method="post">
    		    <input type="hidden" name="command" value="search" />
    			<td>������ţ�</td>
    			<td><input type="text" name ="ems" size="40" value="<%=pno%>" readonly="readonly" style="background-color: #FFCC99"></td>
    			</form >
    		<form action="#" style="text-align: center;" name="form1" method="post">
    			<input type="hidden" name ="myems" id="myems" size="40" value="<%=pno%>" >
    			<td>�������ƣ�</td>
    			<td><input name="packageName" id ="packageName" size="40" value="<%=columns.get(0)%>" value="<%=pno%>" readonly="readonly" style="background-color: #FFCC99"></td>
    			
    		</tr>
    		<tr>
    		<td>�ļ���˾��</td>
    			<td>
    			<input name="client" type="text" id="client" size="40" value="<%=columns.get(1) %>"value="<%=pno%>" readonly="readonly" style="background-color: #FFCC99"/>
    			</td>
    			<td>&nbsp;</td>
    			<td>&nbsp;</td>
    		</tr>
    		<tr>
    		<td>���۵��ţ�</td>
    		<td>
    		<input type="text" size="40" name ="pid" id ="pid" value="<%=columns.get(2) %>" value="<%=pno%>" readonly="readonly" style="background-color: #FFCC99">
    		</td>
    		<td>��Ŀ��ţ�</td>
    		<td><input name ="sid" id ="sid" size="40" value="<%=columns.get(3) %>" value="<%=pno%>" readonly="readonly" style="background-color: #FFCC99"></td>
    		</tr>
    		<tr>
    		<td>�����ˣ�</td>
    		<td><input name ="sales" id ="sales" size="40" value="<%=columns.get(4) %>"></td>
    		<td>����ʱ�䣺</td>
    			<td>
		    		<input name="dreceipt" type="text" id="dreceipt" size="40" value="<%=columns.get(5) %>" readonly="readonly" style="background-color: #FFCC99"/>
				</td>
    		</tr>
    		<tr>
    		<td colspan="4" align="center"">
    			<input name="btnBack" class="button1" type="button" id="back"
					value="����" onClick="history.back();" />
    		</td>
    		</tr>
    		</form>
    	</table>
    
</html>
