
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.oa.impl.OaVacationTypeDaoImpl"%>
<%@page import="com.lccert.oa.vo.OaVacationType"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="com.lccert.crm.vo.ProjectChem"%>
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
 <%@ include file="../comman.jsp"  %>
<%
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String status = "";
	String parttype="";
	List<OaVacationType> list =new ArrayList();
	String month=request.getParameter("month");
	//���
	String year =request.getParameter("year");
	String userId =request.getParameter("userId");
	String dept =request.getParameter("dept");
	if(dept ==null){
	dept="";
	}
	
	//String sale =request.getParameter("sale");
	//if(sale !=null && !"".equals(sale)){
	//sale =new String(sale.getBytes("ISO8859-1"),"GBK");
	//if(user.getDept().equals("���̲�")){
	//sale= user.getName();
//	}
//	}else{
///	sale="";
	//}
	
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date());
	}
	
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());
	if(Integer.parseInt(month.substring(0,1)) ==0){
	month=month.substring(1,2);
	}
	}
	
	
	
	if (request.getParameter("parttype") != null && !"".equals(request.getParameter("parttype"))) {
		parttype =request.getParameter("parttype");
	}
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		rid=request.getParameter("rid");
		int monthI=Integer.parseInt(month);
		int yearI=Integer.parseInt(year);
		//int userI=Integer.parseInt(userId);
		list =DaoFactory.getInstance().getOaVacationTypeDao().getOaVacationInfor(monthI,yearI,userId,"");
	}
	
	
	  session.setAttribute("projectxls",list);
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���ڹ���</title>
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

		<script type="text/javascript">
		$(function() {
   $("#myTable")
    .tablesorter({widthFixed: true})
    .tablesorterPager({container: $("#pager")});
});
		
	function searchsales(){
	var year=document.getElementById("year").value;
	var month=document.getElementById("month").value;
	var userName=document.getElementById("userName").value;
	var dept =document.getElementById("dept").value;
   var myform =document.getElementById("search");
	myform.action ="vactiontype.jsp?year="+year+"&month="+month+"&userId="+userName+"&dept="+dept;
	myform.submit();
	}
	
		function modifyproject() {
		var count = 0;
		var str="";
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				str=document.getElementsByName("selectFlag")[i].value;
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
		//alert(str+"------");
	   //window.self.location = "addproject.jsp?up=update&&rid=" + document.getElementsByName("selectFlag")[j].value;
	     //window.open("attend.jsp","","toolbar=no,status=no,width=700,height=420,directories=no,scrollbars=yes,location=no,resizable=yes,menubar=no");
	    window.open("attend.jsp?str="+str,"","toolbar=no,height=420,width=880,left="+(window.screen.width-700)/2+",top="+(window.screen.height-420)/2+",location=no,directories=no,menubar=no,scrollbars=no,resizable=no,status=no");
	    
	  // window.showModalDialog("attend.jsp", "newwin", "dialogHeight=500px, dialogWidth=1200px,toolbar=yes,menubar=yes,resizable=yes");//�����Ӵ��ڣ����һ�ȡ��ֻ���ڵ�ֵ
	}

	
	function exportToExcel() {
	if(confirm("ȷ������?")) {
		window.self.location = "../projectxls";
	}
}
</script>
	</head>

	<body>
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���ڹ���&gt;&gt;���ڹ���</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="food_manager.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
   <tr>
            	<td>
            	<div id="mydiv">
            	
					��ݣ�<select name ="year" id ="year" onchange="searchsales();">
							<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
							<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
							<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
							<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
							<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
						</select>
					�·ݣ�<select name ="month" id ="month" onchange="">
							<option value="1" <%="1".equals(month)?"selected":""%>>1</option>
							<option value="2" <%="2".equals(month)?"selected":""%>>2</option>
							<option value="3" <%="3".equals(month)?"selected":""%>>3</option>
							<option value="4" <%="4".equals(month)?"selected":""%>>4</option>
							<option value="5" <%="5".equals(month)?"selected":""%>>5</option>
							<option value="6" <%="6".equals(month)?"selected":""%>>6</option>
							<option value="7" <%="7".equals(month)?"selected":""%>>7</option>
							<option value="8" <%="8".equals(month)?"selected":""%>>8</option>
							<option value="9" <%="9".equals(month)?"selected":""%>>9</option>
							<option value="10" <%="10".equals(month)?"selected":""%>>10</option>
							<option value="11" <%="11".equals(month)?"selected":""%>>11</option>
							<option value="12" <%="12".equals(month)?"selected":""%>>12</option>
						</select>
					���ţ�<select name="dept" id="dept" onchange="getUserName(this);" >
					<option value="">--ѡ����--</option>
					<%
					List row =DaoFactory.getInstance().getOaVacationTypeDao().getDept();
						for(int i=0;i<row.size();i++){
						 	List column =(List)row.get(i);
								 		%>
								 		<option value="<%=column.get(0) %>" <%=dept.equals(column.get(1))?"selected":""%>><%=column.get(1)%></option>
								 		<%
					%>
					
					<%
						}
					%>
					</select>
					
					
					<script type="text/javascript">
							function getUserName(ret){
								$.ajax({
								  type:"POST",  //��ת����ΪPOST
								  url: "/lcims/ouna", //��ת��·��ouna,
								  data: "parentId="+ret.value,
								  dataType: "xml",
								  error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
								 success: function(data){  //�����ȷ���õ�java���洫�������ֵ
								   var userName = $("#userName"); //��ȡ������
								   userName.empty(); //��������������ֵ
								   $("#userName").append("<option value =\"0\">---ѡ���û���---</option>");
								   $(data).find("province").each(function(){
							           var selectV=$(this).attr("id"); //��ȡxml���˵���ֵ
							           var selectT=$(this).attr("name"); //��ȡxml���˵���ֵ
							           $("#userName").append("<option value ="+selectV+">"+selectT+"</option>"); //һ���������ֵ
							         });
								  }
								});
							   
							}
							</script>

					
					Ա����<select name="userName" id="userName" onchange="searchsales();" >
					<option value="0">---ѡ���û���---</option>
					
					</select>
					
					
            	</div>
            		
						 	
            	</td>
            </tr>
			</table>
			</form>
			<hr width="100%" align="right" size=0>
			<form name="userForm" id="userForm">
			<input name="pid" type="hidden" value="<%=pid %>" />
			<input name="rid" type="hidden" value="<%=rid %>" />
			
			<table cellspacing="1" class="tablesorter" id="myTable">
   
    	<thead>
		<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<th >
						����
					</th >
					
					<th >
						����
					</th >
					<th >
						��������
					</th >
					<th >
						�Ӱ�����
					</th >
					<th >
						��ʼʱ��1
					</th >
					<th >
						����ʱ��1
					</th >
					<th  >
						��ʼʱ��2
					</th >
					<th >
						����ʱ��2
					</th >
					<th  >
						ԭ��
					</th >
					<th >
						���
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
				for(int i=0;i<list.size();i++) {
					OaVacationType ovt =list.get(i);
					SimpleDateFormat sdf=null;
					String date="";
					Date dateStr=new Date();
					if(ovt.getData_11()!=null&&!"".equals(ovt.getData_11())){
					//��ȡ���
					sdf=new SimpleDateFormat("yyyy��M��d��");
					dateStr=sdf.parse(year+"��"+ovt.getData_11()+" 00:00:00");
					sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					date=sdf.format(dateStr);
					}else{
					date=ovt.getData_5();
					}
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=ovt.getData_1()+"/"+date+"/"+ovt.getData_3()+"/"+ovt.getData_6()+"/"+ovt.getData_7()%>">
							
					</td>
					<td >
							<%=ovt.getBegin_user()%>
					</td>
					<td >
							<%=ovt.getData_1()%>
					</td>
					
					<td >
							<%=ovt.getData_3()%>
					</td>
					<td>
							<%=ovt.getData_11()%>
					</td>
					<td>
						<%=ovt.getData_5()%>
					</td>
					<td>
						<%=ovt.getData_6()%>
					</td>
					<td>
						<%=ovt.getData_111() %>
					</td>
					<td>
						<%=ovt.getData_112()%>
					</td>
					<td>
						<%=ovt.getData_7()%>
					</td>
					<td>
						<%=ovt.getData_8()%>
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
								id="btnModify" value="����" onClick="modifyproject()">&nbsp;
						</form>
					</div>
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>