<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
 <%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	//��ȡ�ֶ���
	List temp =new ArrayList();
	temp.add("s.id");
	temp.add("s.vsno");
	temp.add("s.vsid");
	temp.add("s.vsampleName");
	temp.add("s.vmodel");
	temp.add("s.vspeichorot");
	temp.add("s.voperator");
	temp.add("s.dcreatetime");
	temp.add("sp.vclient");
	String command=request.getParameter("command");
	List rows =null;
	if(command !=null){
	String pid =request.getParameter("pid");
	String sno =request.getParameter("sno");
	String client =request.getParameter("client");
	if(pid !=null && !"".equals(pid)){
		rows=DaoFactory.getInstance().getSimpleDao().getSampleByPid(temp,pid,"",null);
	}else if(sno !=null && !"".equals(sno)){
		rows=DaoFactory.getInstance().getSimpleDao().getSampleByPid(temp,"",sno,null);
	}else if(client !=null && !"".equals(client)){
		rows=DaoFactory.getInstance().getSimpleDao().getSampleByPid(temp,"",null,client);
	}
	}
	else{
		rows =DaoFactory.getInstance().getSimpleDao().getSample(temp);
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>������Ʒ</title>
		<link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
		<script type="text/javascript" src="../javascript/jquery-1.3.2.js"></script> 
		<script type="text/javascript" src="../javascript/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
		<script type="text/javascript">
		$(function() {
			   $("#myTable")
			    .tablesorter({widthFixed: true})
			    .tablesorterPager({container: $("#pager")});
			});
			
		function modifyproject() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
	
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ�����ݣ�");
			return;
		}
	   window.self.location = "modifySample.jsp?&id=" + document.getElementsByName("selectFlag")[j].value;
	}

function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	
	function modify(){
		var str="";
			for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
					if (document.getElementsByName("selectFlag")[i].checked) {
						str+=document.getElementsByName("selectFlag")[i].value+";";
					}
				}
					 window.self.location = "modifySample.jsp?id="+str;
		}

	function sampleStatus(obj){
		var str="";
			for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
					if (document.getElementsByName("selectFlag")[i].checked) {
						str+=document.getElementsByName("selectFlag")[i].value+";";
					}
				}
				//alert(str);
				window.showModalDialog("outbound.jsp?id="+str+"&status="+obj.value,"","dialogWidth:700px;dialogHeight:500px");
					// window.self.location = "outbound.jsp?id="+str+"&status="+obj.value;
	
	}		
	
	function printlabel(){
	var str="";
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
				if (document.getElementsByName("selectFlag")[i].checked) {
					str+=document.getElementsByName("selectFlag")[i].value+";";
				}
			}
			 window.self.location = "label.jsp?&id="+str;
	}
	
	function showdialog(sno) {
		window.showModalDialog("samplestatus.jsp?sno=" + sno,"","dialogWidth:900px;dialogHeight:500px");
	}
	
	function outdialog(sno){
	window.showModalDialog("outbound.jsp?sno=" + sno,"","dialogWidth:700px;dialogHeight:500px");
	}
</script>
	</head>

	<body>
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>&nbsp; 
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>��Ʒ����&gt;&gt;�鿴��Ʒ</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="search_sample.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">�����뱨���ţ�</font>
							<input id="pid" type="text" name="pid" size="40"  />
							<input type=submit name=Submit value=����>
							<script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
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
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">��������Ʒ��ţ�</font>
							<input id="sno" type="text" name="sno" size="40"  />
							<input type=submit name=Submit value=����>
					</td>
				</tr>
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">������ͻ����ƣ�</font>
							<input id="client" type="text" name="client" size="40"  />
							<input type=submit name=Submit value=����>
					</td>
				</tr>
			</table>
			</form>
			<hr width="100%" align="right" size=0>
			<form name="userForm" id="userForm">
			
			
			<table cellspacing="1" class="tablesorter" id="myTable">
   
    	<thead>
		<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<th >
						 ��Ʒ���
					</th >
					
					<th >
						 ��Ʒ����
					</th >
					<th >
						 ��Ʒ�ͺ�
					</th >
					<th >
						 ��Ŀ���
					</th >
					<th>
						�����ͻ�
					</th>
					<th >
						���λ��
					</th >
					<th >
						������
					</th >
					<th >
						׷��ʱ��
					</th >

		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12">&nbsp;</th>
			

		</tr>
	</tfoot>
	<tbody>
		
		<%
				for(int i=0;i<rows.size();i++) {
					List columns = (List)rows.get(i);
					
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=columns.get(0)%>">
							
					</td>
					<td >
							<%=columns.get(1)%>
					</td>
					
					<td >
							<%=columns.get(3)%>
					</td>
					<td>
							<%=columns.get(4)%>
					</td>
					<td>
						<%=columns.get(2)%>
					</td>
					<td>
						<%=columns.get(8)%>
					</td>
					<td>
						<%=columns.get(5)%>
					</td>
					<td>
						<%=columns.get(6) %>
					</td>
					<td>
					[<a href="javascript:showdialog('<%=columns.get(1) %>');">��ϸ</a>]
					</td>
					
		</tr>
				 <%
				 }
				  %>
	
</table>

	<hr width="100%" align="center" size=0>
	<br>
	<br>
	<br>
	<br>
			<table width="100%" height="138" border="0" align="right"
				cellpadding="0" cellspacing="0">
				<tr>
					<td nowrap class="rd19">
						<div id="pager" class="pager" align="right">
						<form>
						   <img src="../images/first.png" width="16" height="16" class="first"/>
						   <img src="../images/prev.png" width="16" height="16" class="prev"/>
						   <input type="text" class="pagedisplay"/>
						   <img src="../images/next.png" width="16" height="16" class="next"/>
						   <img src="../images/last.png" width="16" height="16" class="last"/>
						   <select class="pagesize">
						    <option selected="selected" value="10">10</option>
						    <option value="20">20</option>
						    <option value="30">30</option>
						    <option value="40">40</option>
						   </select>
						   <select onchange="sampleStatus(this);">
						   	<option value="���">���</option>
						   	<option value="����">����</option>
						   	<option value="�ĳ�">�ĳ�</option>
						   	<option value="����">����</option>
						   	<option></option>
						   </select>		
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸���Ŀ" onClick="modify()">
							&nbsp;
							<%
							//if(user.getTicketid().matches("\\d\\d\\d\\d1\\d\\d\\d")) {
					%>							
						<!-- 	<input name="btnModify" class="button1" type="button"
							id="btnModify" value="ɾ��" onClick="deleteProject()"> -->
					<%
					//	}
					 %>
					 <input name="btnprint" class="button1" type="button"
								id="btnprint" value="��ӡ��ǩ" onClick="printlabel();">
						</form>
					</div>
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>