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
	temp.add("id");
	temp.add("vems");
	temp.add("vpno");
	temp.add("vclient");
	temp.add("dreceipt");
	String command=request.getParameter("command");
	List rows =null;
	rows =DaoFactory.getInstance().getSimpleDao().getSamplePackage(temp);
	//System.out.println(rows.size());
	
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>������Ʒ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
		<link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />   
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.js"></script> 
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/jquery.js"></script> 
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
		var str=document.getElementsByName("selectFlag")[j].value;
			//alert( document.getElementsByName("selectFlag")[j].value);
	  // window.self.location = "sample_package.jsp?&id=" + document.getElementsByName("selectFlag")[j].value;dialogWidth:900px
	  var win =window.showModalDialog("modifypackage.jsp?id="+str, "packag", "dialogHeight:10px, dialogWidth:800px");//�����Ӵ��ڣ����һ�ȡ��ֻ���ڵ�ֵ]
	  if(win=="true"){
	  window.location.reload(); 
	  }
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
			
					 //window.self.location = "modifySample.jsp?id="+str;
		}

	function sampleStatus(obj){
		var str="";
			for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
					if (document.getElementsByName("selectFlag")[i].checked) {
						str+=document.getElementsByName("selectFlag")[i].value+";";
					}
				}
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
							<b>��Ʒ����&gt;&gt;�鿴����</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="search_sample.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<!--  
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">��������Ŀ��ţ�</font>
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
			</table>
			-->
			</form>
			<hr width="100%" align="right" size=0>
			<form name="userForm" id="userForm">
			
			
			<table cellspacing="1" class="tablesorter" id="myTable" name="myTable">
   
    	<thead>
		<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<th >
						��ݺ�
					</th >
					
					<th >
						 �������
					</th >
					<th >
						�ļ���˾
					</th >
					<th >
						�ռ�ʱ��
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
							<%=columns.get(2)%>
					</td>
					<td>
							<%=columns.get(3)%>
					</td>
					<td>
						<%=columns.get(4)%>
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
						   <input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸���Ŀ" onClick="modifyproject()">
						</tr>
			</table>
			
		</form>
	</body>
</html>