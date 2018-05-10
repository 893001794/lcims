<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="com.lccert.crm.vo.ProjectChem"%>
 <%@ include file="../comman.jsp"  %>
<%
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pid = "";
	String rid = "";
	String status = "";
	String parttype="";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	if (request.getParameter("parttype") != null && !"".equals(request.getParameter("parttype"))) {
		parttype =request.getParameter("parttype");
	}
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid");
			pm = ProjectChemImpl.getInstance().searchProjectManarge(pageNo,pageSize,pid,rid,parttype,"food");
	} else {
		pm = ProjectChemImpl.getInstance().searchProjectManarge(pageNo,pageSize,"","",parttype,"food");
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>����ѧ��Ŀ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
		
	function changeStatus() {
		with (document.getElementById("search")) {
			method = "post";
			action = "myproject.jsp";
			submit();
		}
	}
	
function showdialog(sid) {
		window.showModalDialog("../chemistry/projectstatus.jsp?start=enginer&&sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
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

	function topPage() {
		window.self.location = "product_manager.jsp?pageNo=1&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function previousPage() {
		window.self.location = "product_manager.jsp?pageNo=<%=pm.getPreviousPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}	
	
	function nextPage() {
		window.self.location = "product_manager.jsp?pageNo=<%=pm.getNextPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
	
	function bottomPage() {
		window.self.location = "product_manager.jsp?pageNo=<%=pm.getBottomPageNo()%>&status=<%=status%>&pid=<%=pid%>&rid=<%=rid%>";
	}
</script>
	</head>

	<body class="body1">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
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
							<b>���̲�����&gt;&gt;ʳƷ����</b>
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
							<input type=submit name=Submit value=����>
					</td>
				</tr>			
   <tr>
            	<td>
            	<div id="mydiv">
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="projectName" <%=parttype.equals("projectName")?"checked":"" %> />&nbsp;��Ŀ����&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="dcompletetime"  <%=parttype.equals("dcompletetime")?"checked":"" %> />&nbsp;Ӧ����������&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="ridOrder" <%=parttype.equals("finish")?"checked":"" %>/>&nbsp;��������&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="NFinish" <%=parttype.equals("NFinish")?"checked":"" %>/>&nbsp;δ���&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);" value="Projectleader" <%=parttype.equals("Projectleader")?"checked":"" %>/>&nbsp;����������&nbsp;
            		<input type=submit name=Submit value=�ύ>
            	</div>
            		 <script>   
	    
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }   
						     }   
						 </script>
						 	
            	</td>
            </tr>
			</table>
			</form>
			
			
			
			
			<hr width="100%" align="center" size=0>
			<form name="userForm" id="userForm">
			<input name="pid" type="hidden" value="<%=pid %>" />
			<input name="rid" type="hidden" value="<%=rid %>" />
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						 ���Ա����
					</td>
					
					<td class="rd6" >
						 ��Ʒ����
					</td>
					<td class="rd6" >
						 ������Ŀ
					</td>
					<td class="rd6" >
						�ŵ�ʱ��
					</td>
					<td class="rd6" >
						Ӧ�����������
					</td>
					<td class="rd6" >
						���Ƶ���
					</td>
					<td class="rd6" >
						ʵ�ʵ���
					</td>
					<td class="rd6" >
						��Ŀ������
					</td>
					
					
					<td class="rd6" >
						��Ŀǩ����
					</td>
					<td class="rd6" >
						����
					</td>
					<td class="rd6">
						����ʱ��
					</td>
				</tr>
				
				<%
				
				List<ProjectChem> list = pm.getList();
				for(int i=0;i<list.size();i++) {
					ProjectChem p = list.get(i);
					if("����������".equals(p.getObject1())&& "".equals(rid)&& "".equals(pid)){
					
					
					}
					else{
					
				 %>
				<tr>
				
				<tr style="text-align: center;">
					<td class="rd8" >
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getRid()%>">
						
					</td>
					<td class="rd8">
							<%=p.getRid()%>
					</td>
					
					<td class="rd8" width="100px">
							<%=p.getSamplename()%>
					</td>
					<td class="rd8" width="200px">
							<%=p.getProjectcontent()%>
					</td>
					<td class="rd8">
						<%=p.getCreatetime() %>
					</td>
					<td class="rd8">
						<%=p.getCompletetime()%>
					</td>
					<td class="rd8">
						<%=p.getEstimate()==null?"":p.getEstimate() %>
					</td>
					<td class="rd8">
						<%=p.getItestcount()==null?"":p.getItestcount() %>
					</td>
					<td class="rd8">
						<%=p.getProjectleader()==null?"":p.getProjectleader() %>
					</td>
					<td class="rd8">
						<%=p.getProjectissuer()==null?"":p.getProjectissuer() %>
					</td>
					<td class="rd8">
					
					<%=p.getObject()%>
					</td>
					
					<td class="rd8">
					 [<a href="javascript:showdialog('<%=p.getSid()%>');">����</a>]
					</td>			
				</tr>
				<%
				}
				}
				 %>
				
			</table>
			<table width="95%" height="138" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;��&nbsp; <%=pm.getTotalPages() %> &nbsp;ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">��ǰ��</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="��ҳ"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="��ҳ"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="��ҳ" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
								onClick="bottomPage()">
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
							
					
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>