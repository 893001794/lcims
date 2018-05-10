<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="java.util.Map"%>
<%@ include file="../../comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	String pid="";
	String rid="";
	String parttype = "";
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	
	
	//��ȡ�û�id 
	int userid ;
	String sales="";
	String saleid="";
	saleid=request.getParameter("saleid");
	if(saleid !=null && !"".equals(saleid)){
	userid=Integer.parseInt(saleid.trim());
	sales=UserAction.getInstance().getNameById(Integer.parseInt(saleid.trim()));
	}else{
	userid=user.getId();
	sales= user.getName();
	}
	//������ҳ�Ķ���
	PageModel pm = new PageModel();
	List temp =new ArrayList();
	String command = request.getParameter("command");
	
	//��ȡ����������
	List salesName=UserAction.getInstance().getUserBySuperiorid(user.getId());
	
	//����id��ѯ���Ƿ����ϼ�
	String superiorid =UserAction.getInstance().getSuperioridById(userid);
	List<Project> list = null;
	if (command != null && "search".equals(command)) {
	     parttype=request.getParameter("parttypecb");
		 pid= request.getParameter("pid");
		 rid= request.getParameter("rid");
	}
	String phystatus=request.getParameter("phystatus");
	if(phystatus !=null){
	phystatus=new String(phystatus.getBytes("ISO8859-1"),"GBK");
	}
	pm=PhyProjectAction.getInstance().searchMyPhyProject(pageNo,pageSize,sales,pid,rid,parttype,phystatus);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>������Ŀ��ϸ</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		
	<script language="JavaScript" type="text/JavaScript">
	
	function showsaledialog(start) {

		window.showModalDialog("totalsaleinfo.jsp?sales=<%=userid%>&start="+ start,"","dialogWidth:900px;dialogHeight:700px");
	}
	function showdialog(pid) {
		window.open("../../project/project_manage.jsp?command=search&pid="+pid);
	}
	
	function addUser() {
		
		window.self.location = "addquotation.jsp";	
	}
	
	function modifyUser() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ��û����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ���û����ݣ�");
			return;
		}
	
		window.self.location = "modifyquotation.jsp?pid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteUser() {
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("��ѡ����Ҫɾ�����û����ݣ�");
			return;
		}
		if (window.confirm("�Ƿ�ȷ��ɾ��ѡ�е����ݣ�")) {
			//ִ��ɾ��
			with (document.getElementById("userForm")) {
				method = "post";
				action = "quotationlist.jsp?command=delete"
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
		window.self.location = "myproject.jsp?pageNo=1";
	}
	
	function previousPage() {
	var id =document.getElementById("sale").value;
		window.self.location = "myproject.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=search&saleid="+id+"&parttypecb=<%=parttype%>";
	}	
	
	function nextPage() {
	var id =document.getElementById("sale").value;
		window.self.location = "myproject.jsp?pageNo=<%=pm.getNextPageNo()%>&command=search&saleid="+id+"&parttypecb=<%=parttype%>";
	}
	
	function bottomPage() {
	var id =document.getElementById("sale").value;
		window.self.location = "myproject.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=search&saleid="+id+"&parttypecb=<%=parttype%>";
	}
	
<%---------------------������ݵ�EXCEL�ĵ�start---------------------%>
	
	<%---���ȫ��δ�����Ŀ��EXCEL�ĵ�---%>
	function nofinishex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---������սӵ���ϸ��EXCEL�ĵ�---%>
	function todayex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---���ȫ��δ��ɷְ���TUV��Ŀ��EXCEL�ĵ�---%>
	function notuvex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---�����ݸδ�����Ŀ��EXCEL�ĵ�---%>
	function dgnoex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---����ٵ����ٵ�Ԥ����EXCEL�ĵ�---%>
	function warnex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---����Ѿ���ɵ�����δ������EXCEL�ĵ�---%>
	function nosendex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}	
	
	
	function searchsales(obj){
	var id =obj.value;
	var myform =document.getElementById("search");
	myform.action ="myproject.jsp?command=search&saleid="+id+"&parttypecb=<%=parttype%>";
	myform.submit();
	}
	
	
	function  phystatus(obj){
	var phystatus =obj.value;
	var myform =document.getElementById("search");
	var id=document.getElementById("sale").value;
	myform.action ="myproject.jsp?command=search&saleid="+id+"&parttypecb=<%=parttype%>&phystatus="+phystatus;
	myform.submit();
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
							<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���ӵ�������&gt;&gt;�ҵ���Ŀ</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=myproject.jsp?command=search&parttypecb=<%=parttype%>>
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
						
							<font color="red">�����뱨�۵��ţ�</font>
							<input type=text name=pid size="40" value="" />
							<input type=submit name=Submit value=����>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">���䱨���ţ�&nbsp;&nbsp;</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=����>
							<script>   
						        $("#rid").autocomplete("../../vrid_ajax.jsp",{
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
					<td >
						<div id="mydiv">
						
						ȫ��
							<input type="checkbox" name="parttype" value="" onClick="chooseOne(this);" <%=parttype.equals("") || parttype==null ?"checked":""%>/>
					
							
							|&nbsp; δ���
							<input type="checkbox" name="parttype" value="n" onClick="chooseOne(this);" <%=parttype.equals("n")?"checked":""%>/>
							|&nbsp;	���
							<input type="checkbox" name="parttype" value="y" onClick="chooseOne(this);" <%=parttype.equals("y")?"checked":""%>/>&nbsp;	&nbsp;	&nbsp;
							&nbsp;	
							
					 <select   onchange="phystatus(this);">
					 <option value="">---��ѡ��״̬---</option>
					  <%
					  int classId =0;
					  if(user.getDept().equals("�ͷ�")){
					  classId =1;
					  }else if(user.getDept().equals("���ӵ���")){
					  classId =2;
					  }else{
					  classId =0;
					  }
					  
					 Map<String,String> startusTypeList =PhyProjectAction.getInstance().getPhyStatusType(classId);
					 String str="";
					 for(String value:startusTypeList.keySet()){
					 %>
					 <option value="<%=startusTypeList.get(value)%>" <%=startusTypeList.get(value).equals(phystatus)?"selected":""%>><%=startusTypeList.get(value) %></option>
					 <%
					 }
					  %>
					 </select>
							&nbsp;&nbsp;&nbsp;
							<%
																if(salesName.size()>0){
															%>
		
					��Ա��<select name="sale" id="sale" onchange="searchsales(this);" >
					<option value="">--ѡ����Ա--</option>
					<%
						for(int i=0;i<salesName.size();i++){
								UserForm sa =(UserForm)salesName.get(i);
					%>
					<option  value="<%=sa.getId()%>" <%=userid == sa.getId()? "selected":""%>><%=sa.getName()%></option>
					<%
						}
					%>
					</select>
				<%
					}
				%>
						</div>
						
						 <script>   
	    
						     function chooseOne(cb) {   
						     		var cb= cb.value;
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }   
						         
						         var search=document.getElementById("search");
						         search.action ="myproject.jsp?command=search&parttypecb="+cb;
						         search.submit();
						     }   
						 </script>
						</td>
				</tr>
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>

			<table width="100%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">δ�����Ŀ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="100%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						������
					</td>
					<td class="rd6">
						��Ŀ״̬
					</td>
					<td class="rd6">
						�Ƿ����
					</td>
					<td class="rd6">
						����
					</td>
					<td class="rd6" >
						�ȼ�
					</td>
					<td class="rd6" >
						��Ŀ����
					</td>
					<td class="rd6" >
						�ŵ�ʱ��
					</td>
					<td class="rd6" >
						����Ӧ��ʱ��
					</td>
					<td class="rd6" >
						�ͷ���Ա
					</td>
					<td class="rd6" >
						������Ա
					</td>
					<td class="rd6" width="10%">
						��Ʒ����
					</td>
					<!-- <td class="rd6" >
						��Ʒ�ͺ�
					</td>
					 -->
					<td class="rd6">
						��Ŀ������
					</td>
					
				</tr>
				
				<%
									list = pm.getList();
										for(int i=0;i<list.size();i++) {
											Project p =list.get(i);
											PhyProject pp =(PhyProject)p.getObj();
								%>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getRid()%>">
					</td>
						<td class="rd8">
						<%=p.getRid()%>
					</td>
					<td class="rd8">
						<%=pp.getStatus()==null?"":pp.getStatus() %>
					</td>
					<td class="rd8">
						<%=pp.getIsfinish()%>
					</td>	
					<td class="rd8">
						[<a href="javascript:showdialog('<%=p.getPid()%>');">�鿴</a>]
					</td>		
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel()%>
					</td>
					<td class="rd8">
						<%=p.getTestcontent()%>
						
						
						
					</td>
					<td class="rd8">
						<span class="short"><%=pp.getCreatetime()==null?"":pp.getCreatetime()%></span>
					</td>
					<td class="rd8">
						<%=pp.getRptime()==null?"":pp.getRptime()%>
					</td>
					<td class="rd8">
						<%=pp.getServname()==null?"":pp.getServname() %>
					</td>
						<td class="rd8">
						<%=p.getSales()==null?"":p.getSales()%>
					</td>
					
					<td class="rd8">
						<%=pp.getSamplename()==null?"":pp.getSamplename() %>
					</td>
					<!--  
					
					<td class="rd8">
						<%=pp.getSamplemodel()==null?"":pp.getSamplemodel() %>
					</td>
					-->
					<td class="rd8">
						<%=pp.getEngineer()==null?"":pp.getEngineer()%>
					</td>
							
				</tr>
				
				<%
				}
				 %>
				
				
			</table>
			<table width="100%" height="30" border="0" align="center"
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
							&nbsp;
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="���" onClick="addUser()">
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸�" onClick="modifyUser()">
						</div>
					</td>
				</tr>
			</table>
			
		
	</body>
</html>
