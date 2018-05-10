<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
 <%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	
	String start = request.getParameter("start");
	if("1".equals(start)){
	String rptime=request.getParameter("rptime");
	if(!"".equals(rptime) ||null==rptime){
	boolean flag =BarCodeAction.getInstance().getUpdateRptime(rptime,sid);
	
	}else{
	boolean flag =BarCodeAction.getInstance().getUpdateRptime(null,sid);
	}
	}
	
	
	
	
	String keywords = request.getParameter("keywords");
	String type = request.getParameter("type");
	List<Flow> list = null;
	
	
	String command = request.getParameter("command");
	if(command != null && "search".equals(command)) {
		if(!(keywords == null || "".equals(keywords))) {
			list = FlowAction.getInstance().searchFlow(keywords,type);
		}
	} else if (!(sid == null || "".equals(sid))) {
		list = FlowAction.getInstance().getFlowBySid(sid);
	}

%>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>δ�ŵ��б�</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script type="text/javascript">
	
	function goBack() {
			window.history.back();
		}
	
	function modifyflow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ���ת����");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ����ת����");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		window.self.location = "modifyflow.jsp?fid=" + fid;
	}
	
	function deleteFlow() {
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("��ѡ����Ҫɾ�����û����ݣ�");
			return;
		}
		if (window.confirm("�Ƿ�ȷ��ɾ��ѡ�е����ݣ�")) {
			//ִ��ɾ��
			with (document.getElementById("userForm")) {
				method = "post";
				action = "deleteflow.jsp";
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}
	
	
	function printflow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ��ӡ����ת����");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ�ܴ�ӡһ����ת����");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		var flag = document.getElementsByName("isflag")[j].value;
		var str=fid.substring(3, 4);
		//alert(str);
	   if(str=="C"||str=="D" || str=="a" || str=="b" || str=="c" || str=="d"){
	   window.open("printflow.jsp?fid=" + fid);
	   	//ajax_print(fid);
	  }else{
	  window.open("printphyflow.jsp?fid=" + fid);
	  	//ajax_print(fid);
	  }
	   //window.open("printphyflow.jsp?fid=" + fid);
	 	 //}else if(flag == true){
		//window.open("printflow.jsp?fid=" + fid);
		//}else{
		//window.open("printflow1.jsp?fid=" + fid);
		//}
		//window.open("printflow.jsp?fid=" + fid,"", "height=0, width=0,top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no'");
		
	
	}
	
	function stop(Object,search){
	//alert(document.getElementById("start").value);
	    var myForm =document.getElementById("search");
		if("��ʼ"==document.getElementById("start").value){
			myForm.action="flow_manage.jsp?start=1&sid="+Object;
			myForm.submit();
			return ;
		}else{
		//��һ�������ڴ����Ӵ�����ȥmyForm
		window.showModalDialog("updaterptime.jsp?sid="+Object,myForm,"dialogWidth:900px;dialogHeight:700px");

		
		}
		
		
	}
	
</script>

		<!-- -------------ajax��ӡ��ת��start------------------------- -->

		<script type="text/javascript">
    var req;
    
    function ajax_print(fid){
    var url = "printphyflow.jsp?fid=" + fid + "&timestampt=" + new Date().getTime();
    
     
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
         //ָ���ص�����Ϊcallback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //�ص�����
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          	alert(req.responseText + "");
        }
        //else{
        //  alert("��ӡ����:" + req.statusText);
        //}
      }
    }
   
  </script>

		<!-- -------------ajax�˵�����end--------------------------- -->



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
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>��ѧ��Ŀ����&gt;&gt;������ת��&gt;&gt;��ת���б�</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=flow_manage.jsp?command=search>
							<font color="red">�����뱨�۵��ţ�</font>
							<input type=text name=keywords size="25" value=>
							<input type="hidden" name="type" value="pid" />
							<input type=submit name=Submit value=����>
						</form>
					</td>

				</tr>

				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=flow_manage.jsp?command=search>
							<font color="red">�����뱨���ţ�</font>
							<input type=text name=keywords size="25" value=>
							<input type="hidden" name="type" value="rid" />
							<input type=submit name=Submit value=����>
						</form>
					</td>

				</tr>

			</table>

			<hr width="97%" align="center" size=0>
			<form name="userform" id="userform">
		</div>
		<input name="keywords" type="hidden" value="<%=keywords %>" />
		<input name="type" type="hidden" value="<%=type %>" />
		<table width="95%" height="20" border="0" align="center"
			cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="30%" class="rd19">
					<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
				</td>


			</tr>
		</table>
		<table width="95%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="table1">
			<tr>
				<td class="rd6" width="5%">
					<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
				</td>
				<td class="rd6">
					���۵����
				</td>
				<td class="rd6">
					��ױƷ��
				</td>
				<td class="rd6">
					��ת�����
				</td>
				<td class="rd6">
					��α��
				</td>
				<td class="rd6">
					��ת������
				</td>
				<td class="rd6">
					ʵ����
				</td>
				<td class="rd6">
					�ŵ���
				</td>
				<td class="rd6">
					�ŵ�ʱ��
				</td>
			
				<td class="rd6">
					����
				</td>
			</tr>

			<%
					if(list != null) {
					for(int i=0;i<list.size();i++) {
						Flow flow = list.get(i);
					String start1=ProjectChemImpl.getInstance().getProjectStart(flow.getSid());	
					String filingno=ProjectChemImpl.getInstance().getFilingno(flow.getRid());	
					boolean flag=FlowAction.getInstance().isDescribe(flow.getFid());
				 %>

			<tr>
				<td class="rd8">
					<input type="checkbox" name="selectFlag" class="checkbox1"
						value="<%=flow.getFid()%>">
						<input type="hidden" value="<%=flag %>" name="isflag">
				</td>
				<td class="rd8">
					<a href="../../quotation/detail.jsp?pid=<%=flow.getPid() %>"><%=flow.getPid() %></a>
				</td>
				<td class="rd8">
					<%=filingno%>
				</td>
				<td class="rd8">
					<a href="detail.jsp?fid=<%=flow.getFid() %>"><%=flow.getFid() %></a>
				</td>
				<td class="rd8">
					<%=flow.getSecurity() %>
				</td>
				<td class="rd8">
					<%=flow.getFlowtype() %>
				</td>
				<td class="rd8">
					<%=flow.getLab() %>
				</td>
				<td class="rd8">
					<%=flow.getPduser() %>
				</td>
				<td class="rd8">
					<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(flow.getPdtime()) %>
				</td>
			
				<td class="rd8">
				 [<a href="cancelflow.jsp?fid=<%=flow.getFid() %>">ȡ����ת��</a>]
				<%
				if(flow.getStatus() != 5 && !"".equals(start1)) {
				%>
					
					 <input type="button" name ="start" id="start" value="<%=start1 %>" onclick="stop('<%=flow.getSid() %>',document)">
				<%
				}
				 %>
				</td>
			</tr>

			<%
					}
				}
				 %>

		</table>
		<table width="95%" height="30" border="0" align="center"
			cellpadding="0" cellspacing="0" class="rd1">
			<tr>
					<td nowrap class="rd19">
						<div align="right">
							<%
						if(user.getTicketid().matches("11111111")) {
					%>
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="ɾ��" onClick="deleteFlow()">
					<%
						}
					 %>
						</div>
					</td>
				</tr>
		</table>

		
		<br>
	<div align="center">
	<input name="btnGoback" class="button1" type="button"
				id="btnGoback" value="����" onClick="goBack()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="�޸���ת��" onClick="modifyflow()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="��ӡ��ת��" onClick="printflow()">
						
					</div>
	</body>
</html>
