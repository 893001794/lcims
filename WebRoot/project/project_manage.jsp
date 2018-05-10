<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>

<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	List<Project> list = new ArrayList<Project>();
	Quotation qt = null;
	String pid = null;
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid").trim();
		if(!(pid == null || "".equals(pid))) {
			list = ProjectAction.getInstance().getAllProjectByPid(pid);
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
		}
	}
	
	
	if(qt == null) {
		qt = new Quotation();
	}
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>��Ŀ����</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script type="text/javascript">
	
	function buildproject() {
		
		window.self.location = "buildproject.jsp?command=search&pid=<%=pid%>";	
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
	
		

	function showdialog(sid) {
		window.showModalDialog("../chemistry/projectstatus.jsp?sid=" + sid,"","dialogWidth:900px;dialogHeight:700px");
	}

	function AllChecked(obj,parm){
	
	var check = document.getElementsByName(parm);
	//alert(check);
	for(var i=0;i<check.length;i++){
	     if(obj.checked){
	      check[i].checked=true;
	     }
	     else{
	      check[i].checked=false;
	     }
	    } 
	   }
	function pdfToClient(parm,pid,client){
	//alert(pid);
		var flag =false;
		var result="";
		var check = document.getElementsByName(parm);
		for(var i=0;i<check.length;i++){
		if(check[i].checked==true){
			flag =true;
			result+=check[i].value+",";
		}
	    }
	    if(flag == false){
	   		alert("��ѡ��Ҫ���͵ı��棡����");
	   	}else{
	   		///alert(result);
	   		window.open("addMail2Client.jsp?ridStr="+result+"&vpid="+pid);
	   		//window.open("../pdfEmail?ridStr="+result+"&client="+client);
	   	}
	}
</script>

	</head>

	<body class="body1">

		

		<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">���۵����</font>
				</td>
				<td width="49%" class="rd6">
					<font size="3pt" style="font-weight: bolder">�ͻ�����</font>
			</tr>
			<tr align="center">
				<td class="rd8"><%=qt.getPid()==null?"":qt.getPid() %></td>
				<%
					ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
					if(client == null) client = new ClientForm();
				%>
				<td class="rd8"><a href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient()==null?"":qt.getClient() %></a></td>
			</tr>
		</table>
		<p>
			&nbsp;
		</p>

		<form name="userform" id="userform" >
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">��Ŀ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6">
						<input type="checkbox" name="ifAll" id="ifAll"
							onClick="AllChecked(this,'selectFlag')">
					</td>
					<td class="rd6">
						������
					</td>
					<td class="rd6">
						��ױƷ���
					</td>
					<td class="rd6">
						��Ŀ����
					</td>
					<td class="rd6">
						������Ŀ
					</td>
					<td class="rd6">
						��������
					</td>
					<td class="rd6">
						����Ӧ��ʱ��
					</td>
					<td class="rd6">
						���ӵ�����ʱ��
					</td>
					<td class="rd6">
						��Ŀ�ȼ�
					</td>
					<td class="rd6">
						��Ŀ����
					</td>
					
					<td class="rd6">
						�ĵ�
					</td>
				</tr>

				<%
				String draft="n";
				String filingNo="";
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						Project p = list.get(i);
						String rptype = "";
						String rptime = "";
						if(!("��ѧ����".equals(p.getPtype())||"��ױƷ".equals(p.getPtype())||"����".equals(p.getPtype()))) {
							PhyProject pp = (PhyProject)p.getObj();
						} else {
							ChemProject cp = (ChemProject)p.getObj();
							filingNo=cp.getFilingNo();
							rptype = cp.getRptype();
							draft=cp.getDraft();
							if(draft =="" || draft ==null){
							draft="n";
							}
							if(cp.getRptime() != null) {
								rptime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime());
							}
					}
				 %>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=p.getRid()%>-<%=rptype %>">
					</td>

					<td class="rd8">
						<a href="../chemistry/project/projectdetail.jsp?sid=<%=p.getSid() %>"><%=p.getRid() %></a>
					</td>
					<td class="rd8">
						<%=filingNo%>
					</td>
					<td class="rd8">
						<%=p.getPtype() %>
					</td>
					<td class="rd8">
						<%=p.getTestcontent() %>
					</td>
					<td class="rd8">
						<%=rptype %>
					</td>
					<td class="rd8">
						<%=rptime %>
					</td>
					<td class="rd8">
						<%=p.getGranttime()==null?"":p.getGranttime() %>
					</td>
					<td class="rd8">
						<%=p.getLevel()==null?"":p.getLevel() %>
					</td>
					<td class="rd8">
						<a href="javascript:showdialog('<%=p.getSid() %>');">�鿴</a>
					</td>
					<%if(user.getDept().indexOf("����")!=-1 || user.getDept().indexOf("�ͷ�")!=-1 || user.getId() == 103) {
					//System.out.println(ProjectChemImpl.getInstance().getEndTimeByRid(p.getRid()));
					if(ProjectChemImpl.getInstance().getEndTimeByRid(p.getRid())!=null && !"".equals(ProjectChemImpl.getInstance().getEndTimeByRid(p.getRid()))){
					%>
					<td class="rd8">
					<%
					String fileType ="";
					String typePDF="";
					//����vpid�����۵�����ȡQuotation �Ķ����ڻ�ȡ�ͻ�����
					//�����û����ƻ�ȡ�ͻ��ĸ�������
					ClientForm cf=ClientAction.getInstance().getClientByName(qt.getClient());
					//�������ڸÿͻ��Ǿʹ���һ������
					String payStatus="";
					if(cf == null ){
					cf=new ClientForm();
					}
					//System.out.println(cf.getPay()+"------------------");
					//���˿ͻ��ĸ��ʽ����"�½�"��ʱ��
					if(cf.getPay().equals("�½�")){
					//���ݸñ��۵���ȡ�ñ��۵��ϸ��µ����һ��۵��Ƿ񸶿�
					payStatus=QuotationAction.getInstance().getPayStatusByTime(qt.getClient());
					}else if(cf.getPay() !=null && !"".equals(cf.getPay())){
					//ֱ�ӻ�ȡ��ǰ���۵��Ƿ񸶿����
					payStatus=qt.getPaystatus();
				//	System.out.println(payStatus);
					}
					//���ֿ���ɽ�����ۺͶ�ݸ������
					String paytype ="";
					String company =user.getCompany();
					//�������ɽ������һ��Ҫ���ʺ��������pdf�ĵ�
					if(company.equals("��ɽ")){
					paytype ="y";
					}else{
					paytype ="y";
					}
					if(payStatus ==null || "".equals(payStatus)){
					payStatus="y";
					}
					if(user.getDept().indexOf("����")!=-1 && payStatus.equals(paytype) || user.getId()==103){
					fileType ="pdf";
					if(rptype.equals("���ı���")){
						fileType+="-C";
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&filetype=<%=fileType.substring(0, fileType.indexOf("-"))%>"><%=fileType%></a>
						<%
						//�жϸñ����Ƿ��вݸ�棬���������ʾ�ݸ��
						if(draft.equals("y")){
						
						%>
							<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&draft=DRAFT&filetype=<%=fileType.substring(0, fileType.indexOf("-"))%>"><%="draft-C"%></a>
						<%
						}
						}else if (rptype.equals("Ӣ�ı���")){
						fileType+="-E";
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&filetype=<%=fileType.substring(0, fileType.indexOf("-"))%>"><%=fileType%></a>
							<%
							if(draft.equals("y")){
							
							%>
								<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&draft=DRAFT&filetype=<%=fileType.substring(0, fileType.indexOf("-"))%>"><%="draft-E"%></a>
							<%
							}
						}
					 %>
						<%if(rptype.equals("˫�ﱨ��")){
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&filetype=<%=fileType%>"><%=fileType+"-C" %></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&filetype=<%=fileType%>"><%=fileType+"-E" %></a>
						<%
						if(draft.equals("y")){
						
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&draft=DRAFT&filetype=<%=fileType%>"><%="draft-C"%></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&draft=DRAFT&filetype=<%=fileType%>"><%="draft-E"%></a>
						<%
						}
						} 
						
					}else if (user.getDept().indexOf("�ͷ�")!=-1){
					
					fileType ="doc";
					typePDF="pdf";
					if(rptype.equals("���ı���")){
						fileType+="-C";
						typePDF+="-C";
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&filetype=<%=fileType.substring(0, fileType.indexOf("-"))%>"><%=fileType%></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&filetype=<%=typePDF.substring(0, typePDF.indexOf("-"))%>"><%=typePDF%></a>
						<%
						}else if (rptype.equals("Ӣ�ı���")){
						fileType+="-E";
						typePDF+="-E";
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&filetype=<%=fileType.substring(0, fileType.indexOf("-"))%>"><%=fileType%></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&filetype=<%=typePDF.substring(0, typePDF.indexOf("-"))%>"><%=typePDF%></a>
						<%
						}
					 %>
						<%if(rptype.equals("˫�ﱨ��")){
						%>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&filetype=<%=fileType%>"><%=fileType+"-C" %></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&filetype=<%=fileType%>"><%=fileType+"-E" %></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-C" %>&filetype=<%=typePDF%>"><%=typePDF+"-C" %></a>
						<a href="../fileDown?rid=<%=p.getRid()+"-E" %>&filetype=<%=typePDF%>"><%=typePDF+"-E" %></a>
					<%
						} 
					}
					%>
					
					</td>
					
					<%
					}
					}
					%>

				</tr>

				<%
				}
				}
				
				 %>


			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						
					</td>
					
				</tr>
			</table>

		</form>
		<div align="center">
			<input name="btnAdd" type="button" class="button1" id="btnAdd" value="�ر�" onClick="window.close();">
		</div>
		<%
		//System.out.println(user.getProjecttype());
		if(user.getProjecttype().equals("y")){
		%>
		<div align="center">
			<input name="btnAdd" type="button" class="button1" id="btnAdd" value="��������ͻ�" onClick="pdfToClient('selectFlag','<%=pid%>','<%=qt.getClient()%>');">
		</div>
		
		<%} %>
	</body>
</html>
