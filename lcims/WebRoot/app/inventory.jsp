<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.vo.Inventory"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	request.setCharacterEncoding("GBK");
	
	String product=request.getParameter("product");
	List rows =new ArrayList();
	if(product !=null){
		rows=DaoFactory.getInstance().getInventoryDao().getInventory(product);
	}else{
		rows=DaoFactory.getInstance().getInventoryDao().getInventory(null);
	}
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
  <table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
							<font color="red">请输入产品名称：&nbsp;&nbsp;</font>
							<input type=text name=product size="40"  />
							<input type=submit name=Submit value=搜索>
						
						</td>
					</tr>
					
		</table>
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
						 类别
					</th >
					<th >
						单位
					</th >
					<th >
						单价
					</th >
					<th >
						中山库存&nbsp;|&nbsp;东莞库存
					</th >
					<th  >
						中山上次领用时间&nbsp;|&nbsp;东莞上次领用时间
					</th >
					<!-- <th >
						中山累计领用量&nbsp;|&nbsp;东莞累计领用量
					</th > -->
					<th >
						中山历史单价&nbsp;|&nbsp;东莞历史单价
					</th >
					<th >
						预警量
					</th >

		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12" style="text-align: right;"><a href="in_statistics.jsp">库存统计</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="product.jsp">产品出入库</a></th>
		</tr>
	</tfoot>
	<tbody>
		<%
				for(int i=0;i<rows.size();i++) {
					Inventory inventory =(Inventory)rows.get(i);
				 %>
				 	<tr>
			       <td>
			               <input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1"
							value="<%=inventory.getPid()%>">
					</td>
					<td style="font-size: 13px;width: 20%">
							<%=inventory.getName()%>
					</td>
					
					<td style="font-size: 13px">
							<%=inventory.getStandardNo()%>
					</td>
					<td style="font-size: 13px">
							<%=inventory.getCategory()%>
					</td>
					<td style="font-size: 13px">
							<%=inventory.getUnit()%>
					</td>
					<td style="font-size: 13px;">
						<%=inventory.getPrice() %>
					</td>
					<td style="font-size: 13px;">
						<%=inventory.getInventoryNumber()-inventory.getTOTAL()%>&nbsp;|&nbsp;<%=inventory.getInventoryNumber1()-inventory.getTOTAL1()%>
					</td>
					<td style="font-size: 13px">
						<%=inventory.getLastTime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(inventory.getLastTime())%>&nbsp;|&nbsp;<%=inventory.getLastTime1()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(inventory.getLastTime1())%>
					</td>
					<!--<td style="font-size: 13px">
						<%=inventory.getTOTAL()%>&nbsp;|&nbsp;<%=inventory.getTOTAL1()%>
					</td>-->
					<td style="font-size: 13px">
						<%=inventory.getHistoryprice()%>&nbsp;|&nbsp;<%=inventory.getHistoryprice1()%>
					</td>
					<td style="font-size: 13px">
						<%=inventory.getWarning()%>
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
