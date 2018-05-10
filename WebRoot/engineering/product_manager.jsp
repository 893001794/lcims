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
	List<ProjectChem> list =null;
	String month=request.getParameter("month");
	//���
	String year =request.getParameter("year");
	String sale =request.getParameter("sale");
	if(sale !=null && !"".equals(sale)){
	sale =new String(sale.getBytes("ISO8859-1"),"GBK");
	if(user.getDept().equals("���̲�")&& user.getId() !=113){
	sale= user.getName();
	}
	}else{
	sale="";
	}
	
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date());
	}
	
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());
	}
	
	List listEngineer =FlowFinal.getInstance().getEngineer("���̲�");
	System.out.println(listEngineer.size());
	if (request.getParameter("parttype") != null && !"".equals(request.getParameter("parttype"))) {
		parttype =request.getParameter("parttype");
	}
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid");
		rid=request.getParameter("rid");
		list= ProjectChemImpl.getInstance().searchProjectManarge(year,month,sale,pid,rid,parttype,"product");
	} else {
		list = ProjectChemImpl.getInstance().searchProjectManarge(year,month,"","","",parttype,"product");
	}
	
	
	  session.setAttribute("projectxls",list);
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>����ѧ��Ŀ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<link rel="stylesheet" href="../css/jquery.tablesorter.pager.css" type="text/css" />
		<link rel="stylesheet" href="../images/blue/style.css" type="text/css" media="print, projection, screen" />   
		<script type="text/javascript" src="../javascript/jquery.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript" src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/jquery.tablesorter.pager.js"></script>
		<script type="text/javascript">
			$(function() {
				   $("table")
				    .tablesorter({widthFixed: true})
				    .tablesorterPager({container: $("#pager")});
				});
		
			function changeStatus() {
				with (document.getElementById("search")) {
					method = "post";
					action = "product_manager.jsp";
					submit();
				}
			}
	
			function showdialog(sid) {
					window.showModalDialog("../chemistry/projectstatus.jsp?start=enginer&&sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
				}
				
				function searchsales(){
			   var myform =document.getElementById("search");
				myform.action ="product_manager.jsp";
				myform.submit();
				}
			
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
			   window.self.location = "addproject.jsp?up=update&&rid=" + document.getElementsByName("selectFlag")[j].value;
			}
			
			function addflow() {
				window.parent.content.rows='20,0%,*';
				window.parent.frames[2].location = "../flow/addflow.jsp?pid=";
			}
			
			function deleteProject() {
			
				var count = 0;
				var j = 0;
				for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
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
					with (document.getElementById("userForm")) {
						method = "post";
						action = "addprojec_post.jsp?start=del&&startype=food&&rid=" +document.getElementsByName("selectFlag")[j].value
						submit();
					}
				}
			}
				
			function checkAll() {
				for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
					document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
				}
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
						<td class="p1" height="18" nowrap>&nbsp;
							
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���̲�����&gt;&gt;��Ʒ����</b>
						</td>
					</tr>
				</table>
				
			</div>
			<hr width="100%" align="center" size=0>
			<form name=search id="search" method="post"
							action="product_manager.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search">
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">�����뱨�۵��ţ�</font>
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
							<font color="red">�����뱨���ţ�</font>
							<input id="rid" type="text" name="rid" size="40" />
							<script>   
						        $("#rid").autocomplete("../vrid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>  
							<input type=submit name=Submit value=����>
							<input type="button" value="����xls" onClick="exportToExcel();">
					</td> 
				</tr>			
   <tr>
            	<td>
            	<div id="mydiv">
            		<input type="checkbox" name="parttype" onClick="chooseOne(this);"  value="n" <%=parttype.equals("n")?"checked":"" %>/>&nbsp;δ���&nbsp;
            		<input type="checkbox" name="parttype" onClick="chooseOne(this);"  value="y" <%=parttype.equals("y")?"checked":"" %>/>&nbsp;���&nbsp;
            		<script>   
						     function chooseOne(cb) {   
						     //alert("-----");
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }   
						         var search=document.getElementById("search");
						         search.action ="product_manager.jsp?command=search&parttypecb="+cb.value;
						         search.submit();
						     }   
						 </script>
					��ݣ�<select name ="year" id ="year" onChange="searchsales();">
							<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
							<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
							<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
							<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
							<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
						</select>
					�·ݣ�<select name ="month" id ="month" onChange="searchsales();">
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
					����ʦ��<select name="sale" id="sale" onChange="searchsales(this);" >
					<option value="">--ѡ����Ա--</option>
					<%
						for(int i=0;i<listEngineer.size();i++){
								String engineer =listEngineer.get(i).toString();
					%>
					<option  value="<%=engineer%>" <%=sale.equals(engineer)? "selected":""%>><%=engineer%></option>
					<%
						}
					%>
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
			
			<table cellspacing="1" class="tablesorter" id="myTable" name ="myTable">
   
    	<thead>
		<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<th >
						 ���Ա����
					</th >
					
					<th >
						 ��Ʒ����
					</th >
					<th >
						 ������Ŀ
					</th >
					<th >
						�ŵ�ʱ��
					</th >
					<th >
						Ӧ�����������
					</th >
					<th >
						���Ƶ���
					</th >
					<th  >
						ʵ�ʵ���
					</th >
					<th >
						��Ŀ������
					</th >
					
					
					<th  >
						��Ŀǩ����
					</th >
					<th >
						����
					</th >
					<th >
						����ʱ��
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
					ProjectChem p = list.get(i);
				 %>
				 	<tr>
			        <td>
			               <input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getRid()%>">
							
					</td>
					<td >
							<%=p.getRid()%>
					</td>
					
					<td >
							<%=p.getSamplename()%>
					</td>
					<td>
							<%=p.getProjectcontent()%>
					</td>
					<td>
						<%=p.getCreatetime() %>
					</td>
					<td>
						<%=p.getCompletetime()%>
					</td>
					<td>
						<%=p.getEstimate()==null?"":p.getEstimate() %>
					</td>
					<td>
						<%=p.getItestcount()==null?"":p.getItestcount() %>
					</td>
					<td>
						<%=p.getProjectleader()==null?"":p.getProjectleader() %>
					</td>
					<td>
						<%=p.getProjectissuer()==null?"":p.getProjectissuer() %>
					</td>
					<td>
					
					<%=p.getObject()%>
					</td>
					
					<td>
					 [<a href="javascript:showdialog('<%=p.getSid()%>');">����</a>]
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
						   			<%
						if(user.getTicketid().matches("\\d\\d\\d\\d\\d\\d1\\d")) {
					%>							
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸���Ŀ" onClick="modifyproject()">
					<%
						}
					 %>
							&nbsp;
							<%
							if(user.getTicketid().matches("\\d\\d\\d\\d1\\d\\d\\d")) {
					%>							
							<input name="btnModify" class="button1" type="button"
							id="btnModify" value="ɾ��" onClick="deleteProject()">
					<%
						}
					 %>
						</form>
					</div>
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>