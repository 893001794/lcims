<%@page import="com.lccert.crm.vo.Inventory"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	request.setCharacterEncoding("GBK");
	List  rows=DaoFactory.getInstance().getInventoryDao().getProduct();
 %>
<html>
  <head>
    <title>���</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
	<script type="text/javascript" src="../javascript/jquery-1.3.2.js"></script> 
	<script type="text/javascript" src="../javascript/jquery.tablesorter.js"></script>
	<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
	<script type="text/javascript">
			$(function() {
			   $("table")
			    .tablesorter({widthFixed: true})
			    .tablesorterPager({container: $("#pager")});
			});
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
						action = "addproduct_post.jsp?status=del&proudctId="+document.getElementsByName("selectFlag")[j].value
						submit();
					}
				}
			}
			
		function modifycontact() {
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
		var myfrom =document.getElementById("myform");
		//parent.location.href="addproduct.jsp?status=modify&proudctId=" +document.getElementsByName("selectFlag")[j].value;
		myform.action ="addproduct.jsp?status=modify&proudctId=" +document.getElementsByName("selectFlag")[j].value;
		myform.submit();
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
						 ��Ʒ����
					</th >
					
					<th >
						����ͺ�
					</th >
					<th >
						����
					</th >
					<th >
						С��
					</th >
					<th >
						��λ
					</th >
					<th >
						����
					</th >
					<th >
						����
					</th >

		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12" style="text-align: right;"><!-- <input type="button" value="ɾ��" onclick="deleteProject();"> -->&nbsp;&nbsp;<input type="button" value="�޸�" onclick="modifycontact();">&nbsp;&nbsp;<a href="addproduct.jsp">��Ӳ�Ʒ</a></th>
		</tr>
	</tfoot>
	<tbody>
		<%
				for(int i=0;i<rows.size();i++) {
					List  column =(List)rows.get(i);
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1"
							value="<%=column.get(0)%>">
					</td>
					<td style="font-size: 13px;width: 70">
							<%=column.get(1)%>
					</td>
					
					<td style="font-size: 13px">
							<%=column.get(2)%>
					</td>
					<td style="font-size: 13px">
							<%=column.get(3)%>
					</td>
					<td style="font-size: 13px">
							<%=column.get(4)%>
					</td>
					<td>
						<%=column.get(5)%>
					</td>
					<td>
						<%=column.get(6)%>
					</td>
					<td>
						<a href="addinventory.jsp?id=<%=column.get(0)%>&status=storing">���</a>&nbsp;&nbsp;
						<a href="addinventory.jsp?id=<%=column.get(0)%>&status=outbound">����</a>&nbsp;
					</td>
		</tr>
				 <%
				 }
				  %>
	
	</table>
	 <div id="pager" class="pager">
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
		</form>
	 </div>
	
</form>
  </body>
</html>
