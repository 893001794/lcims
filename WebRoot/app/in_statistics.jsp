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
	//�·�
	String month=request.getParameter("month");
	//���
	String year =request.getParameter("year");
	//����
	String quarter =request.getParameter("quarter");
	if(quarter==null){
	quarter="";
	}
	//����
	String area =request.getParameter("area");
	if(area==null){
	area="";
	}
	//״̬
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
			alert("��ѡ����Ҫ�޸ĵ���ϵ��¼��");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ����ϵ��¼��");
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
					��ݣ�
					<select name ="year" id ="year" onchange="searchsales();">
						<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
						<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
						<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
						<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
						<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
					</select>
					���ȣ�
					<select name ="quarter" id ="quarter" onchange="searchsales();">
						<option value="" selected="selected">---��ѡ�񼾶�---</option>
						<option value="1" <%="1".equals(quarter)?"selected":""%>>��һ����</option>
						<option value="2" <%="2".equals(quarter)?"selected":""%>>�ڶ�����</option>
						<option value="3" <%="3".equals(quarter)?"selected":""%>>��������</option>
						<option value="4" <%="4".equals(quarter)?"selected":""%>>���ļ���</option>
					</select>
					�·ݣ�
					<select name ="month" id ="month" onchange="searchsales();">
						<option value="" selected="selected">ȫ��</option>
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
					����
					<select name ="area" id ="area" onchange="searchsales();">
						<option value="" selected="selected">ȫ��</option>
						<option value="��ɽ" <%="��ɽ".equals(area)?"selected":""%>>��ɽ</option>
						<option value="��ݸ" <%="��ݸ".equals(area)?"selected":""%>>��ݸ</option>
					</select>
					״̬��
					<select name ="status" id ="status" onchange="searchsales();">
						<option value="" selected="selected">ȫ��</option>
						<option value="���" <%="���".equals(status)?"selected":""%>>���</option>
						<option value="����" <%="����".equals(status)?"selected":""%>>����</option>
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
						 ��Ʒ����
					</th >
					<th >
						����
					</th >
					<th >
						 �����
					</th >
					<th >
						��ʷ����
					</th >
					<th >
						��Ӧ��
					</th >
					<th >
						״̬
					</th >
					<th  >
						��ע
					</th >
					<th >
						��/���ʱ��
					</th >
		</tr>
	</thead>
	<tfoot>
		<tr>
			<th colspan="12" style="text-align: right;"><input type="button" value="ɾ��" onclick="deleteProject();">&nbsp;&nbsp;<input type="button" value="�޸�" onclick="modifycontact();">&nbsp;&nbsp;<a href="product.jsp">��Ʒ��ϸ</a></th>
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
