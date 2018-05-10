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
	//月份
	String month=request.getParameter("month");
	//年份
	String year =request.getParameter("year");
	//季度
	String quarter =request.getParameter("quarter");
	if(quarter==null){
	quarter="";
	}
	//区域
	String area =request.getParameter("area");
	if(area==null){
	area="";
	}
	//状态
	String status =request.getParameter("status");
	if(status==null){
	status="";
	}
	
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date());
	}
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());
	}
	List  rows=DaoFactory.getInstance().getInventoryDao().getInventory(year,month,quarter,area,status);
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
						action = "addinventory_post.jsp?type=del&inventoryId=" +document.getElementsByName("selectFlag")[j].value
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
			alert("请选择需要修改的联系记录！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一份联系记录！");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		//alert(fid);
		//var myfrom =document.getElementById("myform");
		window.showModalDialog("addinventory.jsp?type=modify&inventoryId="+fid+"&custId="+obj,"first","dialogWidth:900px;dialogHeight:500px");
		//parent.location.href="addinventory.jsp?type=modify&inventoryId="+fid+"&custId="+obj;
		//myform.submit();
	}
	
	function searchsales(){
	   var myform =document.getElementById("search");
		myform.action ="in_statistics.jsp";
		myform.submit();
	}
		</script>

  </head>
  <body>
  <form name=search id="search" method="post" action="in_statistics.jsp" autocomplete="off">
	<input type="hidden" name="command" value="search">
	<table width=100% border=0 cellspacing=5 cellpadding=5 style="margin-left: 13em">
  		<tr>
            <td>
            	<div id="mydiv">
					年份：
					<select name ="year" id ="year" onchange="searchsales();">
						<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
						<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
						<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
						<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
						<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
					</select>
					季度：
					<select name ="quarter" id ="quarter" onchange="searchsales();">
						<option value="" selected="selected">---请选择季度---</option>
						<option value="1" <%="1".equals(quarter)?"selected":""%>>第一季度</option>
						<option value="2" <%="2".equals(quarter)?"selected":""%>>第二季度</option>
						<option value="3" <%="3".equals(quarter)?"selected":""%>>第三季度</option>
						<option value="4" <%="4".equals(quarter)?"selected":""%>>第四季度</option>
					</select>
					月份：
					<select name ="month" id ="month" onchange="searchsales();">
						<option value="" selected="selected">全部</option>
						<option value="01" <%="01".equals(month)?"selected":""%>>1</option>
						<option value="02" <%="02".equals(month)?"selected":""%>>2</option>
						<option value="03" <%="03".equals(month)?"selected":""%>>3</option>
						<option value="04" <%="04".equals(month)?"selected":""%>>4</option>
						<option value="05" <%="05".equals(month)?"selected":""%>>5</option>
						<option value="06" <%="06".equals(month)?"selected":""%>>6</option>
						<option value="07" <%="07".equals(month)?"selected":""%>>7</option>
						<option value="08" <%="08".equals(month)?"selected":""%>>8</option>
						<option value="09" <%="09".equals(month)?"selected":""%>>9</option>
						<option value="10" <%="10".equals(month)?"selected":""%>>10</option>
						<option value="11" <%="11".equals(month)?"selected":""%>>11</option>
						<option value="12" <%="12".equals(month)?"selected":""%>>12</option>
					</select>
					区域：
					<select name ="area" id ="area" onchange="searchsales();">
						<option value="" selected="selected">全部</option>
						<option value="中山" <%="中山".equals(area)?"selected":""%>>中山</option>
						<option value="东莞" <%="东莞".equals(area)?"selected":""%>>东莞</option>
					</select>
					状态：
					<select name ="status" id ="status" onchange="searchsales();">
						<option value="" selected="selected">全部</option>
						<option value="入库" <%="入库".equals(status)?"selected":""%>>入库</option>
						<option value="出库" <%="出库".equals(status)?"selected":""%>>出库</option>
					</select>
            	</div>
            </td>
           </tr>
		</table>
	</form>
  <form action="" method="post" name ="myform" id="myform">
   <table cellspacing="1" class="tablesorter" id="myTable">
    	<thead>
		<tr>
		<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
					<th >
						 产品名称
					</th >
					<th >
						区域
					</th >
					<th >
						 库存量
					</th >
					<th >
						历史单价
					</th >
					<th >
						供应商
					</th >
					<th >
						状态
					</th >
					<th  >
						备注
					</th >
					<th >
						出/入库时间
					</th >
		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12" style="text-align: right;"><input type="button" value="删除" onclick="deleteProject();">&nbsp;&nbsp;<input type="button" value="修改" onclick="modifycontact();">&nbsp;&nbsp;<a href="product.jsp">产品明细</a></th>
		</tr>
	</tfoot>
	<tbody>
		<%
				for(int i=0;i<rows.size();i++) {
					List column =(List)rows.get(i);
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1"
							value="<%=column.get(0)%>">
					</td>
					<td style="font-size: 13px;width: 70">
					<%
						List row =DaoFactory.getInstance().getInventoryDao().getProduct(Integer.parseInt(column.get(1).toString()));
						List productColumn =(List)row.get(0);
					 %>
							<%=productColumn.get(0)%>
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
					<td style="font-size: 13px">
						<%=column.get(7)%>
					</td>
					<td style="font-size: 13px">
						<%=column.get(8)%>
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
