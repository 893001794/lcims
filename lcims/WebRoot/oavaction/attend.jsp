<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	//�����ɵı��۵���
	String str= request.getParameter("str");
	str=new String(str.getBytes("iso-8859-1"),"GBK");
	//System.out.println(str+"--------------");
	//String userName =str.substring(0,str.indexOf("/"));
	//String StartEndTime=str.substring(str.indexOf("/")+1,str.length());
	
		List temp =new ArrayList();
		String s2 = str;
		  int pos = 0;
		  //int cnt2 = 0;
		  int start=0;
		  while (pos < s2.length()) {
		   pos = s2.indexOf('/', pos);
		   if (pos == -1) {
		    break;
		   } else {
		   // cnt2++;
		   // System.out.println(pos);
			temp.add(str.substring(start,pos));
		   
		    pos++;
		    start=pos;
		   }
		  }
	String userName =temp.get(0).toString();
	String StartEndTime=temp.get(1).toString();
	String date="";
	if(StartEndTime !=null&& !"".equals(StartEndTime)){
	if(StartEndTime.length()>12){
	date=StartEndTime.substring(0,StartEndTime.indexOf(" "));
	}else{
	date=StartEndTime;
	}
}
	//�����û����ƺ����ڵõ�sql servert 2008���ݿ���userid ��checktime
	List row =DaoFactory.getInstance().getOaVacationTypeDao().getSqlInfor(userName,date);
	System.out.println(row);
	String checkTime ="";
	String userId ="";
	for(int i=0;i<row.size();i++){
	List column =(List)row.get(i);
	userId=column.get(0).toString();
	System.out.println(userId+"-----------**********");
	checkTime+=column.get(1)+"&nbsp;";
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>���ڹ���</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
.hid {
	display: none;
}
</style>
	</head>

	<body>
		<form method="post" name="quotationform" id="quotationform" action="attend_post.jsp?userId=<%=userId%>">
			<em><input type="hidden" name="command" value="add"><input type="hidden" name="confirmUserId" id="confirmUserId" value="<%=userId%>"><input type="hidden" name="totalprice" id="totalprice" value=""></em>
			
			
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td><em>&nbsp; 
					</em></td>
				</tr>
			</table>
			<table table width="50%" cellpadding="5" cellspacing="5" align="center" >
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<em><img height="14" width="14" src="../images/mark_arrow_02.gif"> 
							&nbsp; 
							<b>���ڹ���&gt;&gt;��ӿ���</b></em>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div>
				<table width="80%" cellpadding="5" cellspacing="5" align="center"" >
					<tr>
						<td width="10%"><em> 
							������ 
						</em></td>
						<td width="17%"><em><input name="userName" id="userName" size="25" value="<%=userName %>"></em></td>
						<td width="8%"><em>���ڣ�</em></td>
						<td width="17%" align="left">
							<em><input type="text" name="date" id="date" size="25" value="<%=date %>"><img height="22" align="middle" width="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'date',onpicked:a})" src="../javascript/date/skin/datePicker.gif"><script type="text/javascript">
								function a(){
								//alert("&dash;&dash;&dash;&dash;&dash;&dash;&dash;&dash;&dash;-"+$quotationform$);
								var myform =document.getElementById("quotationform");
								myform.action="attend.jsp?str=<%=userName%>/"+$dp.cal.getDateStr()+" 00:00:00";
								myform.submit();
								}
								</script></em>
							
								
						</td>
					</tr>
					<tr>
						<td><em> 
							ָ�ƻ��� 
						</em></td>
						<td colspan="2">
							<em><input name="checktime" id="checktime" size="42" value="<%=checkTime %>"></em>
						</td>
						<td><em> 
							���ͣ� 
							<%System.out.println(temp.get(2)); %>
								<select style="width: 120px;" name="attendType" id="attendType" > 
								<option value="999" size="40" <%=temp.get(2).equals("�� ��")?"selected":"" %>>������</option> 
								<option value="4" size="40" <%=temp.get(2).equals("�¡�����")?"selected":"" %>>�¡���</option> 
								<option value="5" size="40" <%=temp.get(2).equals("��������")?"selected":"" %>>������</option> 
								<option value="6" size="40" <%=temp.get(2).equals("��������")?"selected":"" %>>������</option> 
								<option value="7" size="40" <%=temp.get(2).equals("�顡����")?"selected":"" %>>�顡��</option> 
								<option value="8" size="40" <%=temp.get(2).equals("��������")?"selected":"" %>>������</option> 
								<option value="9" size="40" <%=temp.get(2).equals("ɥ������")?"selected":"" %>>ɥ����</option> 
								<option value="10" size="40" <%=temp.get(2).equals("�ꡡ����")?"selected":"" %>>�ꡡ��</option> 
								<option value="11" size="40" <%=temp.get(2).equals("�����")?"selected":"" %>>�����</option> 
							</select></em>
						</td>
					</tr>
					
					<tr>
						<td><em> 
							��ʼʱ�䣺 
						</em></td>
						<td align="left">
							<em><input type="text" name="starttime" id="starttime" size="25" value="<%=StartEndTime%>"> 
							<img height="22" align="middle" width="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',el:'starttime'})" src="../javascript/date/skin/datePicker.gif"></em>
						</td align="left">
						<td><em> 
							����ʱ�䣺 
						</em></td>
						<td>
							<em><input type="text" name="endtime" id="endtime" size="25" value="<%=temp.get(3)%>"><img height="22" align="middle" width="16" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',el:'endtime'})" src="../javascript/date/skin/datePicker.gif"></em>
							
						</td>
					</tr>
					
					<tr>
						<td><em> 
							ԭ�� 
						</em></td>
						<td colspan="3">
							<em><textarea rows="3" cols="5" style="width: 550px;" name="remarks" id="remarks"><%=str.substring(str.lastIndexOf("/")+1,str.length()) %></textarea></em>
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
		
				<em><input type="submit" name="btnAdd" class="button1" id="btnAdd" value="���"></em>
				&nbsp;&nbsp;&nbsp;&nbsp;
			
			</div>
		</form>
	</body>
</html>
