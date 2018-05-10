<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	ChemProject cp = (ChemProject)p.getObj();
	List<Flow> list = FlowAction.getInstance().getFlowBySid(sid);
	
	

%>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ת���б�</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script type="text/javascript">
	function goBack() {
			window.history.back();
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
		//ajax_print(fid);
		window.open("printflow.jsp?fid=" + fid);
	}
	
</script>

		<!-- -------------ajax��ӡ��ת��start------------------------- -->

		<script type="text/javascript">
    var req;
    
    function ajax_print(fid){
      var url = "printflow.jsp?fid=" + fid + "&timestampt=" + new Date().getTime();
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
        }else{
          alert("��ӡ����:" + req.statusText);
        }
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
						<b>��ѧ��Ŀ����&gt;&gt;��ת���б�</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>

			<form name="userform" id="userform">
		</div>
		
		<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">������</font>
				</td>
			</tr>
			<tr align="center">
				<td class="rd8"><%=p.getRid() %></td>
			</tr>
		</table>
		<p>
			&nbsp;
		</p>

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
					��ת�����
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

			</tr>

			<%
					if(list != null) {
					for(int i=0;i<list.size();i++) {
						Flow flow = list.get(i);
				 %>

			<tr>
				<td class="rd8">
					<input type="checkbox" name="selectFlag" class="checkbox1"
						value="<%=flow.getFid()%>">
				</td>
				<td class="rd8">
					<a href="detail.jsp?fid=<%=flow.getFid() %>"><%=flow.getFid() %></a>
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
						<input name="btnModify" class="button1" type="button"
							id="btnModify" value="��ӡ��ת��" onClick="printflow()">
						&nbsp;&nbsp;
						
					</div>

				</td>

			</tr>
		</table>

		<div align="center">
	<input name="btnModify" class="button1" type="button"
							id="btnModify" value="����" onClick="goBack()">
		</div>
	</body>
</html>
