<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@page import="com.lccert.oa.vo.Customer"%>
<%@ include file="clientcommon.jsp"  %>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="java.util.List"%>
<%@ page errorPage="../error.jsp" %>

<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	List lists = null;
	
	ClientForm client = new ClientForm();
	//�ж��Ƿ��ϴ����ͻ��ĵ�ѡ��
	String reserve=request.getParameter("reserve");
	if(reserve ==null){
	reserve="";
	}
	
	UserForm userForm = (UserForm)session.getAttribute("user");
	String sales=userForm.getSales(); //ӵ�����۵�Ȩ��
	String serv=userForm.getServ();//ӵ�пͷ���Ȩ��
	//�õ����ص�Ҫ������ʾ���ı���
		String type = request.getParameter("type");
	//�õ�Ҫ����ͻ������Ƶ��ı���
		String keywords = request.getParameter("keywords");
		
		//�ж��Ƿ��������
		String applicant=request.getParameter("appli");
		if(applicant !=null){
			int id = 0;
			String strid = request.getParameter("id");
			if(strid != null && !"".equals(strid)) {
				id = Integer.parseInt(strid);
			}
			//��t_client���е�applicantId��Ϊ�����˵�id
			String applicantId=request.getParameter("applicantId");
			//System.out.println(Integer.parseInt(applicantId.trim())+"��������id---"+"�ͻ�id��"+id);
			client.setApplicant(Integer.parseInt(applicantId));
			client.setId(id);
			if(!ClientAction.getInstance().transferClient(client,1)) {
			out.println("<script type='text/javascript'>");
			out.println("alert('����ʧ�ܣ�')");
			out.println("</script>");
			return;
			}
			out.println("<script type='text/javascript'>");
			out.println("alert('����ɹ���')");
			out.println("</script>");
			
		}
	if (command != null && "search".equals(command)) {
			if(sales.equals("y") && serv.equals("n")){
			lists = ClientAction.getInstance().searchClient(type,keywords,userForm.getId(),reserve,user.getAgree(),userForm);
			}else{
			lists = ClientAction.getInstance().searchClient(type,keywords,0,reserve,user.getAgree(),userForm);
			}
	}else if(command != null && "reset".equals(command)){
			String status = request.getParameter("status");
			 keywords = request.getParameter("keywords");
			
			int str=0;
			if(status !=null && status.equals("1")){
			str=1;
			}
			if(status !=null && status.equals("2")){
			str=2;
			}
			if(status !=null && status.equals("3")){
			str=3;
			}
			if(status !=null && status.equals("4")){
			str=4;
			}
		lists=SearchFactory.getCustomer().userList(str,keywords);
	}else{
		lists = ClientAction.getInstance().searchClient(type,keywords,userForm.getId(),reserve,user.getAgree(),userForm);
		//if(lists.size()<=0){
		// lists = ClientAction.getInstance().searchClient(type,keywords,userForm.getId(),reserve,user.getAgree(),"plane",userForm);
		// 
		// }else{
		 //	for(int i=0;i<lists.size();i++){
				//ClientForm c=(ClientForm)lists.get(i);
				//client.setSalesid(0);
				//client.setId(c.getId());
				//client.setSales("");
			//	ClientAction.getInstance().transferClient(client,2);
			//}
		// }
	}
	
		//�ж��Ƿ�ͬ������
		
		String agree=request.getParameter("agree");
		if(agree !=null){
		int id = 0;
			String strid = request.getParameter("id");
			if(strid != null && !"".equals(strid)) {
				id = Integer.parseInt(strid);
			}
			//��t_client���е�applicantId��Ϊ�����˵�id
			String salesId=request.getParameter("salesId");
			user=UserAction.getInstance().getUserById(Integer.parseInt(salesId));
			//System.out.println(Integer.parseInt(applicantId.trim())+"��������id---"+"�ͻ�id��"+id);
			
			client.setId(id);
			int status=0;
			if(request.getParameter("status").equals("yes")){
			//��ͬ���ʱ��ͽ������˵�Id���뵽����id��ȥ
				client.setSalesid(Integer.parseInt(salesId));
				client.setSales(user.getName());
				status=2;
			}if(request.getParameter("status").equals("no")){
			//����ͬ���ʱ�򽫸������˵���գ���0������
				client.setApplicant(0);
		    	status=1;
			}
			if(!ClientAction.getInstance().transferClient(client,status)) {
			out.println("<script type='text/javascript'>");
			out.println("alert('ʧ�ܣ�')");
			out.println("</script>");
			}else{
			out.println("<script type='text/javascript'>");
			out.println("alert('�ɹ���')");
			out.println("</script>");
			}
			
		}
		

%>
    

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>���ҿͻ�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<script type="text/javascript">
	
	function addUser() {
		
		window.self.location = "addflow.jsp";	
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
	
		window.self.location = "modifyflow.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
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
				action = "flowlist.jsp?command=delete"
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
		window.self.location = "flowlist.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "flowlist.jsp?pageNo=";
	}	
	
	function nextPage() {
		window.self.location = "flowlist.jsp?pageNo=";
	}
	
	function bottomPage() {
		window.self.location = "flowlist.jsp?pageNo=";
	}
	

	//��ȡ��Ϣ
	function getClientName(obj){
	var myform =document.getElementById("search");
	myform.action="searchclient.jsp?command=reset&status="+obj;
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
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�ͻ�����&gt;&gt;����ͻ�</b>
						</td>
					</tr>
				</table>
				
				<hr width="100%" align="center" size=0>
				
				
				<table border="1" width="95%" cellspacing="0" cellpadding="0"  align="center">
					<tr>
						<td valign=middle width=100%>
						<form name=search method=post action=searchclient.jsp?command=search&reserve=<%=reserve %> >
						<input type="checkbox" name="reserve" onclick="choose(this);"  value="reserve" <%=reserve.equals("reserve")?"checked":"" %>/>&nbsp;�����ͻ�&nbsp;
            		<script>   
	    
						     function choose(cb) {  
							     if(cb.checked==true){
							     var search=document.getElementById("search");
							         search.action ="searchclient.jsp?reserve="+cb.value;
							         search.submit();
							     }
							         
						     }   
						 </script>
							<font color="red">������ͻ����ƣ�</font>
							<input type="hidden" name="type" value="name" />
							<input type=text name=keywords size="25" value="" />
							<input type=submit name=Submit value=����>
							<input type="button" name ="button" value="һ������" onclick="getClientName(1);">
						<input type="button" name ="button" value="��������" onclick="getClientName(2);">
						<input type="button" name ="button" value="���ݲ���" onclick="getClientName(3);">
						<input type="button" name ="button" value="��ݸ����" onclick="getClientName(4);">
						</form>
						</td>
					</tr>
					<tr>
						
					</tr>
					<!-- 
					<tr>
						<td valign=middle width=50%>
						<form name=search method=post action=searchclient.jsp?command=search&reserve=<%=reserve %> >
							<font color="red">������ͻ����룺</font>
							<input type="hidden" name="type" value="clientid" />
							<input type=text name=keywords size="25" value=>
							<input type=submit name=Submit value=����>
						</form>
						</td>
					</tr>
					
					 -->
					</table>
			

			<hr width="95%" align="center" size=0>
			<form name="userform" id="userform">	
			</div>
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="30%" class="rd19">
						<font color="#FFFFFF" size="2pt">��ѯ���</font>
					</td>
										
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" width="5%">
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6">
						�ͻ����
					</td>
					<td class="rd6">
						�ͻ�����
					</td>
					<td class="rd6">
						�ͻ�����
					</td>
					
					<td class="rd6">
						��������
					</td>
					<%
					if(!reserve.equals("")){
					%>
					
					<td class="rd6">
						����
					</td>
					<%
					}
					 %>
					
					
				</tr>
				<%
				if(lists != null) {
				if(command !=null && command.equals("reset")){
				for(int i=0;i<lists.size();i++) {
						Customer customer = (Customer)lists.get(i);
				 %>
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="">
					</td>
					<td class="rd8">
						 
					</td>
					<td class="rd8">
						 
					</td>
					<td class="rd8">
						<%=customer.getNamefull()==null?"":customer.getNamefull()%>
					</td>
					
					<td class="rd8">
						<%=customer.getNowman()==null?"":customer.getNowman()%>
					</td>
										
				</tr>
				<%
				}
				}else{
				
					for(int i=0;i<lists.size();i++) {
						 client = (ClientForm)lists.get(i);
						  user=UserAction.getInstance().getUserById(client.getApplicant());
				 %>
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=client.getClientid() %>">
					</td>
					<td class="rd8">
						<a href="clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=client.getClientid() %></a>
					</td>
					<td class="rd8">
						<%=client.getPassword() %>
					</td>
					<td class="rd8">
						<%=client.getName() %>
					</td>
					
					<td class="rd8">
						<%=UserAction.getInstance().getNameById(client.getSalesid()) %>
					</td>
					<td class="rd8">
					<%
					//�ж��Ƿ��й��ϡ������ͻ�����ѡ��͸ÿͻ�û�������ڸ���
					if(!reserve.equals("") && client.getApplicant()==0){
					%>
					<a href="searchclient.jsp?appli=applicant&applicantId=<%=userForm.getId()%>&id=<%=client.getId()%>" onclick="">����</a>
						<%
						}
						//�жϸÿͻ�Ӧ������������������Ҹ��û��Ƿ���ͬ�⽫��ְ���۵Ŀͻ�ת��ĳһ�����۸�����Ȩ��
						 if(client.getApplicant()!=0 && userForm.getAgree().equals("y")){
						%>
						<%=user.getName()%>��������ÿͻ�
							<a href="searchclient.jsp?status=yes&agree=agree&salesId=<%=client.getApplicant()%>&id=<%=client.getId()%>" value="yes">ͬ��</a>
							<a href="searchclient.jsp?status=no&agree=agree&salesId=<%=client.getApplicant()%>&id=<%=client.getId()%>" value="no">��ͬ��</a>
						</td>
						<%
						}
					 %>
										
				</tr>
				<%
					}
					}
				}
				 %>
			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				
			</table>

		
		
	</body>
</html>
