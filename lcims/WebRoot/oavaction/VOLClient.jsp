<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
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
	String condition1="";
	if(request.getParameter("condition1") !=null){
		condition1=request.getParameter("condition1");
	}
	String step="";
	if(request.getParameter("step") !=null){
		step=request.getParameter("step");
	}
	String followstate="";
	if(request.getParameter("followstate") !=null){
		followstate=request.getParameter("followstate");
	}

	String status= request.getParameter("status");
	String restart= "";
	String condition2="";
	String tracking="";
	String client="";
	String custom="";
	String content="";
	String start="";
	String end="";
	
	if(request.getParameter("restart") !=null &&!"".equals(request.getParameter("restart"))){
		restart=request.getParameter("restart");
		condition2= request.getParameter("condition2");
		start= request.getParameter("start");
		end= request.getParameter("end");
		
	}
		if(request.getParameter("tracking") !=null){
			tracking= request.getParameter("tracking");
		}
		if(request.getParameter("client") !=null){
			client= request.getParameter("client");
		}
		if(request.getParameter("custom") !=null){
				custom= request.getParameter("custom");
		}
		if(request.getParameter("content") !=null){
			content= request.getParameter("content");
		}
	if(status==null && condition1 !=null){
		condition1=new String (condition1.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && step !=null){
		step=new String (step.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && followstate !=null){
		followstate=new String (followstate.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && condition2 !=null){
		condition2=new String (condition2.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && tracking !=null){
		tracking=new String (tracking.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && client !=null){
		client=new String (client.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && custom !=null){
		custom=new String (custom.getBytes("ISO8859-1"),"GBK");
	}
	if(status==null && content !=null){
		content=new String (content.getBytes("ISO8859-1"),"GBK");
	}
	int pageNo = 1;
	int pageSize = 25;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	//�ж��Ƿ�Ϊ������Ա
	String ctsName = request.getParameter("ctsName");
	PageModel pm=new SearchFactory().getVOLClient().getVOLInfor(pageNo,pageSize,followstate,step,condition1,condition2,start,end,tracking,client,custom,content,ctsName);
	List rows =(List)pm.getList();
	//System.out.println(rows.size()+"--------------");
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
	<script type="text/javascript">
	function topPage() {
		window.self.location = "VOLClient.jsp?pageNo=1&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}
	
	function previousPage() {
		window.self.location = "VOLClient.jsp?pageNo=<%=pm.getPreviousPageNo()%>&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}	
	
	function nextPage() {
		window.self.location = "VOLClient.jsp?pageNo=<%=pm.getNextPageNo()%>&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}
	
	function bottomPage() {
		window.self.location = "VOLClient.jsp?pageNo=<%=pm.getBottomPageNo()%>&followstate=<%=followstate%>&step=<%=step%>&condition1=<%=condition1%>&restart=<%=restart%>&condition2=<%=condition2%>&start=<%=start%>&end=<%=end%>&tracking=<%=tracking%>&client=<%=client%>&custom=<%=custom%>&content=<%=content%>&ctsName=<%=ctsName%>";
	}
	
	function checkForm(){
		document.getElementById("condition1").value="��������ѯ";
		var radio=document.getElementById("restart");
		var condition2=document.getElementById("condition2").value;
		var start=document.getElementById("start").value;
		var end=document.getElementById("end").value;
		if(radio.checked==true){
			if(condition2 !="δ��ϵ"){
				if((start ==null || start =="")&&(end ==null || end =="")){
					alert("������'��'xxx'��'xxxʱ��ֵ");
					return false;
				}
			}
		}
		
		var myform=document.getElementById("quotationform");
		myform.submit();
	}
	
	function addcon(obj) {
		var str="";
		var url="";
		if(obj == "add"){
			str="���"
			url="contact_manage.html";
		}else if(obj == "mod"){
			str="�޸�"	
		}else if(obj == "dele"){
			str="ɾ��";
		}
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ"+str+"����ϵ��¼��");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ��ѡ��һ����¼��");
			return;
		}
		var custId = document.getElementsByName("selectFlag")[j].value;
			window.self.location = url+"?custId=" + custId;
	}
	</script>
	</head>

	<body>
		<form method="post" name="quotationform" id="quotationform" action="VOLClient.jsp?status=seach&&ctsName=<%=ctsName%>">
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
						<b>�ͻ�����ƽ̨&gt;&gt;�ͻ�����</b></em>
					</td>
				</tr>
			</table>
		
			<hr width="97%" align="center" size=0>
			<div>
			<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
				<tr>
					<td width="70%">
					�ͻ����ȣ�<select name ="step" id="step" onchange="condition(this.value);">
						<option value="" selected="selected">ȫ��</option>
						<option value="�ɽ�" <%=step.equals("�ɽ�")?"selected":"" %>>�ɽ��ͻ�</option>
						<option value="Ǳ��" <%=step.equals("Ǳ��")?"selected":"" %>>Ǳ�ڿͻ�</option>
					</select>&nbsp;&nbsp;
					<select name ="condition1" id="condition1" onchange="condition(this.value);">
						<option value="" selected="selected">ȫ��</option>
						<option value="����Ҫ�ط�" <%=condition1.equals("����Ҫ�ط�")?"selected":"" %>>����Ҫ�ط�</option>
						<option value="��5��Ҫ�ط�" <%=condition1.equals("��5��Ҫ�ط�")?"selected":"" %>>��5��Ҫ�ط�</option>
						<option value="�ѹ��ط�����" <%=condition1.equals("�ѹ��ط�����")?"selected":"" %>>�ѹ��ط�����</option>
						<option value="��5������ϵ" <%=condition1.equals("��5������ϵ")?"selected":"" %>>��5������ϵ</option>
						<option value="��������ѯ" <%=condition1.equals("��������ѯ")?"selected":"" %>>��������ѯ</option>
					</select>&nbsp;&nbsp;
					<script type="text/javascript">
						function condition(obj){
							if(obj != "��������ѯ"){
								var myform=document.getElementById("quotationform");
								myform.submit();
							}
						}
					</script>
					<input type="checkbox"" value="y" name ="restart" id ="restart" <%=restart.equals("y")?"checked":""%>>
					<select name="condition2" id="condition2">
						<option value="�ط�����" <%=condition2.equals("�ط�����")?"selected":"" %>>�ط�����</option>
						<option value="�����ϵ����" <%=condition2.equals("�����ϵ����")?"selected":"" %>>�����ϵ����</option>
						<option value="��������" <%=condition2.equals("��������")?"selected":"" %>>��������</option>
						<option value="�ռ�����" <%=condition2.equals("�ռ�����")?"selected":"" %> >�ռ�����</option>
						<!--  <option value="δ��ϵ" <%=condition2.equals("δ��ϵ")?"selected":"" %>>δ��ϵ</option>-->
					</select>
					&nbsp;&nbsp;
					��:
						<input name="start" type="text" id="start" size="20" maxlength="50" value="<%=start%>">
				      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'start'})" 
				      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
					����
						<input name="end" type="text" id="end" size="20" maxlength="50"value="<%=end%>">
				      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})" 
				      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
					&nbsp;&nbsp;
					���ٽ��ȣ�<select name ="tracking" id ="tracking">
						<option value="" selected="selected">---���ٽ���---</option>
						<option value="01 �½�����" <%=tracking.equals("01 �½�����")?"selected":"" %>>�½�����</option>
						<option value="02 ����������" <%=tracking.equals("02 ����������")?"selected":"" %>>����������</option>
						<option value="03 ���Űݷ�" <%=tracking.equals("03 ���Űݷ�")?"selected":"" %>>���Űݷ�</option>
						<option value="04  ��ϵ����" <%=tracking.equals("04  ��ϵ����")?"selected":"" %>>��ϵ����</option>
						<option value="05 ���۴�ȷ��" <%=tracking.equals("05 ���۴�ȷ��")?"selected":"" %>>���۴�ȷ��</option>
					</select>
					
					�ͻ�:
						<input name="client" type="text" id="client" size="25" maxlength="50" value="<%=client%>">
				      	
					�Զ����<select name ="custom" id ="custom">
						<option value="" selected="selected">---�Զ�����---</option>
						<option value="����" <%=custom.equals("����")?"selected":"" %>>����</option>
						<option value="��ַ" <%=custom.equals("��ַ")?"selected":"" %>>��ַ</option>
						<option value="�绰" <%=custom.equals("�绰")?"selected":"" %>>�绰</option>
						<option value="����" <%=custom.equals("����")?"selected":"" %>>����</option>
					</select>
					���ݣ�
					<input name="content" type="text" id="content" size="30" maxlength="50" value="<%=content%>">
					&nbsp;
					����״̬��<select name ="followstate" id="followstate" onchange="condition(this.value);">
						<option value="" selected="selected">ȫ��</option>
						<option value="��������" <%=followstate.equals("��������")?"selected":"" %>>��������</option>
						<option value="�̻�����" <%=followstate.equals("�̻�����")?"selected":"" %>>�̻�����</option>
					</select>&nbsp;&nbsp;
					<input type="button" onclick="checkForm();" value="�ύ" >
					</td>
				</tr>
			</table>
				<br>
				<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">CTS��ѯ</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
					<tr>
				      <td class="rd6"  align="center" valign="middle" width="200px" style="width: 200px">�ͻ�ȫ��</td>
				      <td class="rd6"  align="center" valign="middle">�绰</td>
				      <td class="rd6"  align="center" valign="middle">�ͻ����</td>
				      <td class="rd6"  align="center" valign="middle">������</td>
				      <td class="rd6"  align="center" valign="middle">�����ϵ����</td>
				      <td class="rd6"  align="center" valign="middle">�ط�����</td>
				      <td class="rd6"  align="center" valign="middle">���ٽ���</td>
				      <td class="rd6"  align="center" valign="middle">����</td>
				      <td class="rd6"  align="center" valign="middle">��ҵ</td>
				      <td class="rd6"  align="center" valign="middle">���ڸ�����</td>
				      <td class="rd6"  align="center" valign="middle">�ͻ���ϵ</td>
    				</tr>
    				<%
    				for(int i=0;i<rows.size();i++){
    					List columns =(List)rows.get(i);
    					%>
    					<tr>
    					<%
    					for(int j=0;j<columns.size();j++){
    						if(j<columns.size()-2){
    							if(j==1){
    							%>
    							<td class="rd8">
									<a href="contact_manage.html?custId=<%=columns.get(0)%>"><%=columns.get(1)%></a>
								</td>
    							<%
    							}else if(j>1){
    							%>
    							<td class="rd8"><%=columns.get(j)%></td>
    							<%
    							}
	    					}
    					}
    					%>
    					</tr>
    					<%
    				}
    				 %>
				</table>
			</div>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt"><%=pm.getTotalRecords()%> ����¼</font>&nbsp;
							<font color="#FFFFFF" size="2pt">��&nbsp; <%=pm.getTotalPages() %> &nbsp;ҳ</font>&nbsp;
							<font color="#FFFFFF" size="2pt">��ǰ��</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="��ҳ"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="��ҳ"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="��ҳ" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
								onClick="bottomPage()">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
