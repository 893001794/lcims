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
    <title>库存</title>
    
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
					alert("请选择需要删除的用户数据！");
					return;
				}
				if (window.confirm("是否确认删除选中的数据？")) {
					//执行删除
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
			alert("请选择需要修改的联系记录！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一份联系记录！");
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
						 产品名称
					</th >
					
					<th >
						规格型号
					</th >
					<th >
						大类
					</th >
					<th >
						小类
					</th >
					<th >
						单位
					</th >
					<th >
						单价
					</th >
					<th >
						操作
					</th >

		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12" style="text-align: right;"><!-- <input type="button" value="删除" onclick="deleteProject();"> -->&nbsp;&nbsp;<input type="button" value="修改" onclick="modifycontact();">&nbsp;&nbsp;<a href="addproduct.jsp">添加产品</a></th>
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
						<a href="addinventory.jsp?id=<%=column.get(0)%>&status=storing">入库</a>&nbsp;&nbsp;
						<a href="addinventory.jsp?id=<%=column.get(0)%>&status=outbound">出库</a>&nbsp;
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
