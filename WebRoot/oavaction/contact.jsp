<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	request.setCharacterEncoding("GBK");
	String custId = request.getParameter("custId");
	if(custId == null || "".equals(custId)) {
		out.println("��ѡ���¼��");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	int id =0;
	id =Integer.parseInt(custId);
	List rows =new SearchFactory().getVOLClient().getContact(id,"cust");
 %>
<html>
  <head>
   
    
    <title>��ϵ��ʷ��¼</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		 <link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />   
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		    <script src="../javascript/jquery.autocomplete.js"></script> 
		   
		<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
		<script type="text/javascript" src="../javascript/jquery.js"></script> 
		<script type="text/javascript" src="../javascript/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
		<script type="text/javascript">
			function deleteProject() {
				//alert(document.getElementsByName("selectFlag").length);
				var count = 0;
				var j = 0;
				for (var i = 0; i < document.getElementsByName("selectFlag").length;i++) {
					if (document.getElementsByName("selectFlag")[i].checked) {
						j = i;
						count++;
					}
				}
				if (count>1) {
					alert("��ѡ����Ҫɾ�����û����ݣ�");
					return;
				}
				if (window.confirm("�Ƿ�ȷ��ɾ��ѡ�е����ݣ�")) {
					//ִ��ɾ��
					with (document.getElementById("myform")) {
						method = "post";
						action = "addContact_post.jsp?status=del&contactId=" +document.getElementsByName("selectFlag")[j].value
						submit();
					}
				}
			}
			
		function modifycontact(obj) {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ���ϵ��¼��");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ����ϵ��¼��");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		//var myfrom =document.getElementById("myform");
		parent.location.href="contact_manage.html?status=modify&contactId=" +document.getElementsByName("selectFlag")[j].value+"&custId="+obj;
		//myform.submit();
	}
		</script>

  </head>
  
  <body>
  <form action="" method="post" name ="myform" id="myform">
   <table cellspacing="1" class="tablesorter" id="myTable">
   
    	<thead>
		<tr>
		<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
					<th >
						 ��ϵ����
					</th >
					
					<th >
						ʱ��
					</th >
					<th >
						 ��ϵ��
					</th >
					<th >
						��¼����
					</th >
					<th >
						��ϵʱ��
					</th >
					<th >
						��ϵ���
					</th >
					<th  >
						���۴���
					</th >
					<th >
						�ͻ����
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
					List colunms =(List)rows.get(i);
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1"
							value="<%=colunms.get(0)%>">
					</td>
					<td style="font-size: 13px;width: 70">
							<%=colunms.get(1)!=null?colunms.get(1).toString().substring(0,10):""%>
					</td>
					
					<td style="font-size: 13px">
							<%=colunms.get(2)%>
					</td>
					<td style="font-size: 13px">
							<%=colunms.get(3)%>
					</td>
					<td style="font-size: 13px">
							<%=colunms.get(4)%>
					</td>
					<td>
						
					</td>
					<td>
						
					</td>
					<td style="font-size: 13px">
						<%=colunms.get(5)%>
					</td>
					<td style="font-size: 13px">
						<%=colunms.get(6)%>
					</td>
		</tr>
				 <%
				 }
				  %>
	
	</table>
		<br>
	<table width="100%" height="138" border="0" align="right" cellpadding="0" cellspacing="0">
	  <tr>
		 <td nowrap class="rd19">
			 <div id="pager" class="pager" align="right">
				<input name="btnModify" class="button1" type="button" id="btnModify" value="�޸���Ŀ" onClick="modifycontact('<%=custId%>')">
							&nbsp;
				<!--
				 <input name="btnModify" class="button1" type="button" id="btnModify" value="ɾ��" onClick="deleteProject()">
				 -->
			 </div>
		 </td>
	  </tr>
	</table>
</form>
  </body>
</html>
