<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="com.lccert.crm.project.Project"%>

<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String subname = "";
	String status = "";
	String parttype="";
	String tuvtype ="";
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	if(request.getParameter("subname1") !=null && !"".equals(request.getParameter("subname1"))){
	subname =new String (request.getParameter("subname1").getBytes("ISO-8859-1"),"UTF-8");
	subname=request.getParameter("subname1");
	}
	
	if(request.getParameter("subname") !=null && !"".equals(request.getParameter("subname"))){
	subname=request.getParameter("subname");
	}
	if (request.getParameter("parttype") != null && !"".equals(request.getParameter("parttype"))) {
		parttype =request.getParameter("parttype");
	}else{
	parttype ="all";
	}
	//��ȡTUV���������ͨ���
	if (request.getParameter("tuvtype") != null && !"".equals(request.getParameter("tuvtype"))) {
		tuvtype =request.getParameter("tuvtype");
		
	}else{
	
	tuvtype ="pout";
	}
	session.setAttribute("outype",tuvtype);
	pm = ProjectChemImpl.getInstance().searchOutProject(pageNo,pageSize,subname,parttype,tuvtype);
	session.setAttribute("outproject",pm.getList());

 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���������Ŀ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
    	<script src="../javascript/jquery.autocomplete.js"></script>  
		<script type="text/javascript">
		function exportToExcel() {
			if(confirm("ȷ������?")) {
				window.self.location = "../outproject";
			}
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
	   window.self.location = "../chemistry/project/isoutproject.jsp?sid=" + document.getElementsByName("selectFlag")[j].value;
	}

	function topPage() {
		window.self.location = "outproject_manage.jsp?pageNo=1&subname1=<%=subname%>&parttype=<%=parttype%>&tuvtype=<%=tuvtype%>";
	}
	
	function previousPage() {
		window.self.location = "outproject_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&subname1=<%=subname%>&parttype=<%=parttype%>&tuvtype=<%=tuvtype%>";
	}	
	
	function nextPage() {
		window.self.location = "outproject_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&subname1=<%=subname%>&parttype=<%=parttype%>&tuvtype=<%=tuvtype%>";
	}
	
	function bottomPage() {
		window.self.location = "outproject_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&subname1=<%=subname%>&parttype=<%=parttype%>&tuvtype=<%=tuvtype%>";
	}
</script>
	</head>

	<body class="body1">
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
							<b>�ͷ�����&gt;&gt;�������</b>
						</td>
					</tr>
				</table>
			</div>
			<hr width="100%" align="center" size=0>
			
			<form name=search id="search" method="post" action="outproject_manage.jsp" autocomplete="off">
				<input type="hidden" name="command" value="search" >
				<div id="tuvdiv">
            		<input type="checkbox" name="tuvtype" onclick="choose(this);"  value="tuv"  <%=tuvtype.equals("tuv")?"checked":"" %> />&nbsp;TUV���&nbsp;
            		<input type="checkbox" name="tuvtype" onclick="choose(this);"  value="pout" <%=tuvtype.equals("pout")?"checked":"" %>/>&nbsp;��ͨ���&nbsp;
            	</div>
            		 <script>   
	    
						     function choose(cb) {   
						         var obj = document.getElementById("tuvdiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }   
						         var search=document.getElementById("search");
						         search.action ="outproject_manage.jsp";
						         search.submit();
						     }   
						 </script>
						 
				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				
				<tr>
					<td valign=middle width=50%>
							<font color="red">������ֻ������ƣ�</font>
							<input id="subname" type="text" name="subname" size="40" value="<%=subname==null?"":subname %>"/>
							<input type=submit name=Submit value=����>
					</td>
				</tr>			
   <tr>
            	<td>
            	<div id="mydiv">
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="all" <%=parttype.equals("all")?"checked":"" %> />&nbsp;ȫ��&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="n"  <%=parttype.equals("n")?"checked":"" %> />&nbsp;δ���&nbsp;
            		<input type="checkbox" name="parttype" onclick="chooseOne(this);"  value="y" <%=parttype.equals("y")?"checked":"" %>/>&nbsp;���&nbsp;
            		<input type="button" value="����xls" onclick="exportToExcel();" >
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
						         var search=document.getElementById("search");
						         search.action ="outproject_manage.jsp";
						         search.submit();
						     }   
						 </script>
						 	
            	</td>
            </tr>
			</table>
			</form>
			
			
			
			
			<hr width="100%" align="center" size=0>
			
			
			<form name="userForm" id="userForm" action="outproject_manage.jsp" method="post">
			
			<table width="100%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<%
			//���ѡ������Ķ���ΪTUV��ʱ�����ʵһ��table������ʵ����table
			if(tuvtype.equals("tuv")){
			%>
			
			<tr>
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						���۵����
					</td>
					<td class="rd6" >
						��Ŀ�����
					</td>
					
					<td class="rd6" >
						TUV���
					</td>
					<td class="rd6" >
						�ͻ�����
					</td>
					<td class="rd6" >
						��������
					</td>
					<td class="rd6" >
						��Ʒ����
					</td>
					<td class="rd6" >
						������Ŀ
					</td>
					<td class="rd6" >
						�����Կͻ�����(����)
					</td>
					<td class="rd6" >
						TUV����������(����)
					</td>
					<td class="rd6" >
						�������ְ���
					</td>
					<td class="rd6">
						TUV���Է���
					</td>
					<td class="rd6">
						To TUV(40%)
					</td>
					<td class="rd6">
						o TUV(TUV���Է�+40%)
					</td>
					<td class="rd6">
						To ����
					</td>
				</tr>
				
				<%
				
				List list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Project p =(Project) list.get(i);
				
				 %>
				<tr>
				
				<tr style="text-align: center;">
					<td class="rd8" >
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid()%>">
						
					</td>
					<td class="rd8">
							<%=p.getPid()%>
					</td>
					<td class="rd8">
							<%=p.getRid()%>
					</td>
					<td class="rd8" width="100px">
					<%=p.getTuvno() == null ?"":p.getTuvno()%>
					</td>
					<td class="rd8" width="100px">
							<%=p.getClient()==null?"":p.getClient()%>
					</td>
					<td class="rd8" width="200px">
					  <%=p.getSales()==null?"":p.getSales() %>
					</td>
					<td class="rd8">
						<%=p.getSamplename()==null?"":p.getSamplename() %>
					</td>
					<td class="rd8">
						<%=p.getTuvpshort() ==null?"":p.getTuvpshort()%>
					</td>
					<td class="rd8">
						<%=p.getLcrealprice()%>
					</td>
					<td class="rd8">
						<%=p.getPrice()%>
					</td>
					<td class="rd8">
						<%=p.getSubcost2()%>
					</td>
				
					<td class="rd8">
						<%=p.getPresubcost()%>
					</td>	
					<td class="rd8">
					<%
					//TUV�����Ŀ����
					float tuvPrice=0.0f;
					//������
					float presubcost=0.0f;
					//�ж�һ���ַ��Ƿ���Ӣ����ĸ
					int countUp=ProjectChemImpl.getInstance().countstring(p.getPresubcost());
					if(countUp==0){
					presubcost=Float.parseFloat(p.getPresubcost());
					 }else{
					presubcost=Float.parseFloat(p.getPresubcost().substring(0, p.getPresubcost().indexOf(".")+2));
					 }
					if(p.getPresubcost() !=null ){
					
					}
					//TO TUV(40%)=��TUV����������-����������-TUV���Է��ã�*40%
					 tuvPrice=(p.getPrice()-p.getSubcost2()-presubcost)*0.4f;
					
					 %>
					<%=tuvPrice %>
					</td>	
					<td class="rd8">
					<%=tuvPrice+presubcost%>
					</td>	
					<td class="rd8">
					<%=p.getPrice()-tuvPrice-presubcost%>
					</td>		
				</tr>
			
			<%
			} 
			}else{
			%>
				<tr>
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						���۵����
					</td>
					<td class="rd6" >
						��Ŀ�����
					</td>
					
					<td class="rd6" >
						��Ŀ����
					</td>
					<td class="rd6" >
						Ӧ������ʱ��
					</td>
					<td class="rd6" >
						���ʱ��
					</td>
					<td class="rd6" >
						ʵ�ʽ��
					</td>
					<td class="rd6" >
						��������Ǽ�
					</td>
					<td class="rd6" >
						��Ʒ����
					</td>
					<td class="rd6" >
						��������
					</td>
					<td class="rd6" >
						�ְ�����
					</td>
					<td class="rd6">
						������ʱ��
					</td>
				</tr>
				
				<%
				
				List list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Project p =(Project) list.get(i);
				
				 %>
				<tr>
				
				<tr style="text-align: center;">
					<td class="rd8" >
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getSid()%>">
						
					</td>
					<td class="rd8">
							<%=p.getPid()%>
					</td>
					<td class="rd8">
							<%=p.getRid()%>
					</td>
					
					<td class="rd8" width="100px">
							<%=p.getTestcontent() ==null?"":p.getTestcontent()%>
					</td>
					<td class="rd8" width="200px">
					   <%=p.getOrtime() ==null?"":p.getOrtime()%>
					</td>
					<td class="rd8">
						<%=p.getBqtime()==null?"":p.getBqtime() %>
					</td>
					<td class="rd8">
						<%=p.getOeprice()%>
					</td>
					<td class="rd8">
						<%=p.getOstime() ==null?"":p.getOstime()%>
					</td>
					<td class="rd8">
						<%=p.getSamplename()==null?"":p.getSamplename() %>
					</td>
					<td class="rd8">
						<%=p.getSales()==null?"":p.getSales() %>
					</td>
					
					<td class="rd8">
					
					<%=p.getSubname() ==null?"":p.getSubname()%>
					</td>
					
					<td class="rd8">
					<%=p.getOetime()==null?"":p.getOetime() %>
					</td>		
				</tr>
				<%
				}
				}
				 %>
				
			</table>
		
			<table width="100%" height="138" border="0" align="center"
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
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸���Ŀ" onClick="modifyproject()">
					</td>
				</tr>
			</table>
			
		</form>
	</body>
</html>