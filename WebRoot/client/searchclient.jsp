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
	//判断是否勾上储备客户的单选框
	String reserve=request.getParameter("reserve");
	if(reserve ==null){
	reserve="";
	}
	
	UserForm userForm = (UserForm)session.getAttribute("user");
	String sales=userForm.getSales(); //拥有销售的权利
	String serv=userForm.getServ();//拥有客服的权利
	//得到隐藏的要用来显示的文本框
		String type = request.getParameter("type");
	//得到要输入客户的名称的文本框
		String keywords = request.getParameter("keywords");
		
		//判断是否申请操作
		String applicant=request.getParameter("appli");
		if(applicant !=null){
			int id = 0;
			String strid = request.getParameter("id");
			if(strid != null && !"".equals(strid)) {
				id = Integer.parseInt(strid);
			}
			//将t_client表中的applicantId改为申请人的id
			String applicantId=request.getParameter("applicantId");
			//System.out.println(Integer.parseInt(applicantId.trim())+"：申请人id---"+"客户id："+id);
			client.setApplicant(Integer.parseInt(applicantId));
			client.setId(id);
			if(!ClientAction.getInstance().transferClient(client,1)) {
			out.println("<script type='text/javascript'>");
			out.println("alert('申请失败！')");
			out.println("</script>");
			return;
			}
			out.println("<script type='text/javascript'>");
			out.println("alert('申请成功！')");
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
	
		//判断是否同意申请
		
		String agree=request.getParameter("agree");
		if(agree !=null){
		int id = 0;
			String strid = request.getParameter("id");
			if(strid != null && !"".equals(strid)) {
				id = Integer.parseInt(strid);
			}
			//将t_client表中的applicantId改为申请人的id
			String salesId=request.getParameter("salesId");
			user=UserAction.getInstance().getUserById(Integer.parseInt(salesId));
			//System.out.println(Integer.parseInt(applicantId.trim())+"：申请人id---"+"客户id："+id);
			
			client.setId(id);
			int status=0;
			if(request.getParameter("status").equals("yes")){
			//当同意的时候就将申请人的Id填入到销售id中去
				client.setSalesid(Integer.parseInt(salesId));
				client.setSales(user.getName());
				status=2;
			}if(request.getParameter("status").equals("no")){
			//当不同意的时候将该申请人的清空，以0来代替
				client.setApplicant(0);
		    	status=1;
			}
			if(!ClientAction.getInstance().transferClient(client,status)) {
			out.println("<script type='text/javascript'>");
			out.println("alert('失败！')");
			out.println("</script>");
			}else{
			out.println("<script type='text/javascript'>");
			out.println("alert('成功！')");
			out.println("</script>");
			}
			
		}
		

%>
    

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>查找客户</title>
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
			alert("请选择需要修改的用户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条用户数据！");
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
			alert("请选择需要删除的用户数据！");
			return;
		}
		if (window.confirm("是否确认删除选中的数据？")) {
			//执行删除
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
	

	//获取信息
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
							<b>客户管理&gt;&gt;管理客户</b>
						</td>
					</tr>
				</table>
				
				<hr width="100%" align="center" size=0>
				
				
				<table border="1" width="95%" cellspacing="0" cellpadding="0"  align="center">
					<tr>
						<td valign=middle width=100%>
						<form name=search method=post action=searchclient.jsp?command=search&reserve=<%=reserve %> >
						<input type="checkbox" name="reserve" onclick="choose(this);"  value="reserve" <%=reserve.equals("reserve")?"checked":"" %>/>&nbsp;储备客户&nbsp;
            		<script>   
	    
						     function choose(cb) {  
							     if(cb.checked==true){
							     var search=document.getElementById("search");
							         search.action ="searchclient.jsp?reserve="+cb.value;
							         search.submit();
							     }
							         
						     }   
						 </script>
							<font color="red">请输入客户名称：</font>
							<input type="hidden" name="type" value="name" />
							<input type=text name=keywords size="25" value="" />
							<input type=submit name=Submit value=搜索>
							<input type="button" name ="button" value="一部查重" onclick="getClientName(1);">
						<input type="button" name ="button" value="二部查重" onclick="getClientName(2);">
						<input type="button" name ="button" value="广州查重" onclick="getClientName(3);">
						<input type="button" name ="button" value="东莞查重" onclick="getClientName(4);">
						</form>
						</td>
					</tr>
					<tr>
						
					</tr>
					<!-- 
					<tr>
						<td valign=middle width=50%>
						<form name=search method=post action=searchclient.jsp?command=search&reserve=<%=reserve %> >
							<font color="red">请输入客户代码：</font>
							<input type="hidden" name="type" value="clientid" />
							<input type=text name=keywords size="25" value=>
							<input type=submit name=Submit value=搜索>
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
						<font color="#FFFFFF" size="2pt">查询结果</font>
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
						客户编号
					</td>
					<td class="rd6">
						客户密码
					</td>
					<td class="rd6">
						客户名称
					</td>
					
					<td class="rd6">
						负责销售
					</td>
					<%
					if(!reserve.equals("")){
					%>
					
					<td class="rd6">
						操作
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
					//判断是否有勾上“储备客户”单选框和该客户没有销售在跟进
					if(!reserve.equals("") && client.getApplicant()==0){
					%>
					<a href="searchclient.jsp?appli=applicant&applicantId=<%=userForm.getId()%>&id=<%=client.getId()%>" onclick="">申请</a>
						<%
						}
						//判断该客户应经被销售申请跟进并且该用户是否有同意将离职销售的客户转给某一个销售跟进的权限
						 if(client.getApplicant()!=0 && userForm.getAgree().equals("y")){
						%>
						<%=user.getName()%>销售申请该客户
							<a href="searchclient.jsp?status=yes&agree=agree&salesId=<%=client.getApplicant()%>&id=<%=client.getId()%>" value="yes">同意</a>
							<a href="searchclient.jsp?status=no&agree=agree&salesId=<%=client.getApplicant()%>&id=<%=client.getId()%>" value="no">不同意</a>
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
