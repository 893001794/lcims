<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.impl.RecordDaoImpl"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.quotation.EdmAction"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%

	request.setCharacterEncoding("GBK");
	List folderL=new ArrayList();
	folderL.add("vecordname");
	List count =new ArrayList ();
	count.add("a");
	List condition=new ArrayList();
	String date=request.getParameter("date");
	SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMdd");
	if(date ==null){
		date=sdf.format(new Date());
	}
	//���
	String area =request.getParameter("area");
	if(area ==null){
	area="C";
	}
	//date =sdf.format(new Date(date));
	List rows =new RecordDaoImpl().getFolder(area,date,folderL);
	
%>

<html>
	<head>
		<title>����ͳ�Ʊ�</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" href="../css/css1.css" type="text/css"
			media="screen">
  <script language="JavaScript" type="text/JavaScript">
		function showdialog(start,year,month) {
			window.showModalDialog("show_edmqc.jsp?userId=" + start+"&year="+year+"&month="+month,"","dialogWidth:500px;dialogHeight:300px");
		}
		function searchsales(){
			//��ȡ�������ֵ
			var area =document.getElementById("area").value;
			var date =document.getElementById("date").value;
			//alert("�����������ֵ��"+area+"--���ڣ�"+date);
		    var myform =document.getElementById("form1");
			myform.action ="record.jsp";
			myform.submit();
		}
  </script>
	</head>

	<body text="#000000" topmargin=0>
		<form name="form1" id ="form1" method="post" action="edm_manage.jsp" >
		<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">

	<tr>
	<td>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		����/����
		<select name="area" id="area" style="width: 100px">
			<option value="C" selected="selected">
				��ɽ����һ
			</option>
			<option value="E" <%=area.equals("E")?"selected":"" %>>
				��ɽ���۶�
			</option>
			<option value="G" <%=area.equals("G")?"selected":"" %>>
				����
			</option>
			<option value="g" <%=area.equals("D")?"selected":"" %>>
				��ݸ
			</option>
		</select>
							
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		���ڣ�<input name="date" type="text" id="date" size="40"  value="<%=date==null?new SimpleDateFormat("yyyyMMdd").format(new Date()):date %>"/>
		<img onClick="WdatePicker({dateFmt:'yyyyMMdd',el:'date'})" src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="�ύ" onclick="searchsales();">				
				
		</td>
	</tr>
</table>
		<table width="100%" border="1" cellpadding="2" cellspacing="0"
			align="center">
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="<%=rows.size()+1%>">
					¼���ļ�ͳ��
				</th>
			</tr>
			<tr>
				<td height="35">
					<div align="center">
					�ļ�����
					</div>
				</td>
				<%
				if(rows.size()>0){
					for(int i =0;i<rows.size();i++){
					List column=(List)rows.get(i);
				%>
				<td align="center">
						<%=column.get(0) %>
				</td>
				<%
					}
				}
				 %>
			</tr>
			 <tr>
			 	<td >
					<div align="center">
					����
					</div>
				</td>
				<%
				for(int i =0;i<rows.size();i++){
					condition=(List)rows.get(i);
					List rows1 =new RecordDaoImpl().getCountFiles(area,date,count,condition.get(0).toString());
					for(int j =0;j<rows1.size();j++){
						List column=(List)rows1.get(j);
						%>
						<td align="center"">
								<%=column.get(0)%>
						</td>
						<%
					}
				}
				 %>
			</tr>
		</table>
	</form>
	</body>
</html>