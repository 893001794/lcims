<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
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
	
	String month=request.getParameter("month");
	String product=request.getParameter("product");
	//年份
	String year =request.getParameter("year");
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date());
	}
	
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());
	}
	List  rows =new ArrayList();
	rows=FinanceQuotationAction.getInstance().getEdmManage(year,month);
 %>
<html>
  <head>
    <title>库存</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="../../images/blue/style.css" type="text/css" media="print, projection, screen" />
<link rel="stylesheet" href="../../css/jquery.tablesorter.pager.css" type="text/css" />
<script type="text/javascript" src="../../javascript/jquery-1.3.2.js"></script> 
<script type="text/javascript" src="../../javascript/jquery.tablesorter.js"></script>
<script type="text/javascript" src="../../javascript/jquery.tablesorter.pager.js"></script>
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
			alert("请选择需要修改的联系记录！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一份联系记录！");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		//var myfrom =document.getElementById("myform");
		parent.location.href="contact_manage.html?status=modify&contactId=" +document.getElementsByName("selectFlag")[j].value+"&custId="+obj;
		//myform.submit();
	}
	
	function searchsales(){
	   var myform =document.getElementById("myform");
		myform.action ="edm_manage.jsp";
		myform.submit();
	}
	
	
		</script>

  </head>
  <body>
  <form action="edm_manage.jsp" method="post" name ="myform" id="myform">
  <table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<div id="mydiv">
					年份：
					<select name ="year" id ="year" onchange="searchsales();">
						<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
						<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
						<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
						<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
						<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
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
				</div>
			</td>
		</tr>
	</table>
   <table cellspacing="1" class="tablesorter" id="myTable">
    	<thead>
		<tr>
		<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
					<th >
						 报价单号
					</th >
					<th >
						客户名称
					</th >
					<th >
						 采样日期
					</th >
					<th >
						收款时间
					</th >
					<th >
						收款金额
					</th >
					<th >
						收款方式
					</th >
					<th  >
						开票时间
					</th >
					<!-- <th >
						中山累计领用量&nbsp;|&nbsp;东莞累计领用量
					</th > -->
					<th >
						开票号
					</th >
					<th >
						采样员
					</th >
		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12" style="text-align: right;">&nbsp;</th>
		</tr>
	</tfoot>
	<tbody>
		<%
				for(int i=0;i<rows.size();i++) {
					List columns =(List)rows.get(i);
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1"
							value="<%=columns.get(0)%>">
					</td>
					<td style="font-size: 13px;">
							<%=columns.get(0)%>
					</td>
					<td style="font-size: 13px;width: 20%">
							<%=columns.get(1)%>
					</td>
					<td style="font-size: 13px">
						<%=columns.get(7)==null?"":columns.get(7)%>
					</td>
					<td style="font-size: 13px">
							<%=columns.get(2)==null?"":columns.get(2)%>
					</td>
					<td style="font-size: 13px">
							<%=columns.get(3)%>
					</td>
					<td style="font-size: 13px;">
						<%=columns.get(4)==null?"":columns.get(4)%>
					</td>
					<td style="font-size: 13px;">
						<%=columns.get(5)==null?"":columns.get(5)%>
					</td>
					<td style="font-size: 13px">
						<%=columns.get(6)==null?"":columns.get(6)%>
					</td>
					<td style="font-size: 13px">
						<%=columns.get(8)==null?"":columns.get(8)%>
					</td>
		</tr>
				 <%
				 }
				  %>
	</table>
	 <div id="pager" class="pager">
		<form>
		   <img src="../../images/first.png" width="16" height="16" class="first"/>
		   <img src="../../images/prev.png" width="16" height="16" class="prev"/>
		   <input type="text" class="pagedisplay"/>
		   <img src="../../images/next.png" width="16" height="16" class="next"/>
		   <img src="../../images/last.png" width="16" height="16" class="last"/>
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
