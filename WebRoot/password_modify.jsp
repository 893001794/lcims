<%@ page contentType="text/html; charset=GB18030" pageEncoding="GB18030"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.oa.db.ConnSqlServserDB"%>
 

<%
	String command = request.getParameter("command");
	String status=request.getParameter("status");
	UserForm user=new UserForm();
	user= (UserForm)session.getAttribute("user");
	if (command != null && command.equals("modify")) {
		String password = request.getParameter("newPassword");
		String cts=request.getParameter("cts");
		if(cts !=null && !"".equals(cts)){
		boolean falg =new ConnSqlServserDB().modiyPwd(password,user.getCtsname(),user.getDept());
		}else{
		UserAction.getInstance().modifyPassword(user.getUserid(),password);
		}
		user.setPassword(password);
		session.removeAttribute("user");
		session.setAttribute("user", user);
		if(status !=null && status.equals("1")){
			out.println("<script type='text/javascript'>");
			out.println("提示：修改密码成功！;");
			out.println("window.self.location = 'login.jsp';");
			out.println("</script>");
		}else{
		out.println("alert('提示：修改密码成功！')");
		}
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>修改密码</title>
		<link rel="stylesheet" href="css/drp.css">
		<script type="text/javascript">
	
	function modifyPasword(obj) {
		if (document.getElementById("v1").innerHTML != "") {
			alert("输入的密码与原密码不相同！");
			document.getElementById("oldPassword").focus();
			return;
		}
		if (document.getElementById("newPassword").value.length < 6) {
			alert("新密码不能小于6位字符！");
			document.getElementById("newPassword").focus();
			return; 
		}
		if (document.getElementById("affirmNewPassowrd").value.length < 6) {
			alert("确认新密码不能小于6位字符！");
			document.getElementById("affirmNewPassowrd").focus();
			return; 
		}
		if (document.getElementById("newPassword").value != document.getElementById("affirmNewPassowrd").value) {
			alert("新密码和确认新密码必须相同！");
			document.getElementById("affirmNewPassowrd").focus();
			return;
		}
		with (document.getElementById("userForm")) {
			method = "post";
			action = "password_modify.jsp?command=modify&status="+obj;
			submit();
		}
	}

	var xmlReq;
	function createXMLHttpRequest() {
		if(window.XMLHttpRequest) {
			xmlReq = new XMLHttpRequest();
		} else if(window.ActiveXObject) {
			xmlReq = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}

	function validate() {
	//alert("-------------------");
		createXMLHttpRequest();
		var oldPassword = document.getElementById("oldPassword");
		var str=document.getElementsByName("cts");  
		
           var objarray=str.length;   
           var chestr="";   
           for (i=0;i<objarray;i++) {   
       if(str[i].checked == true) {   
        			 chestr+=str[i].value;   
               }   
           }   
		//alert(chestr)
		var url = "servlet/passwordvalidate?oldPassword=" + oldPassword.value + "&cts="+chestr+"&timestampt=" + new Date().getTime();
		xmlReq.open("GET",url,true);
		xmlReq.onreadystatechange = callback;
		xmlReq.send(null);
	}

	function callback() {
		if(xmlReq.readystate == 4) {
			if(xmlReq.status == 200) {
				var responseId = document.getElementById("v1");
				responseId.innerHTML = xmlReq.responseText;
			}
		}
	}
	
</script>
	</head>

	<body class="body1">
		<form name="userForm">
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="51">
					<tr>
						<td class="p1" height="16" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="p1" height="35" nowrap>
							&nbsp&nbsp
							<img src="images/mark_arrow_02.gif" width="14" height="14">
							<b><strong>系统管理&gt;&gt;</strong>修改密码</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<table width="50%" height="91" border="0" cellpadding="0"
					cellspacing="0">
					<%
					if(user.getCtsname()!=null && !"".equals(user.getCtsname())){
					%>
					<tr>
						<td height="30" align="right">
						<input type="checkbox" name="cts" id="cts" value="cts">
						</td>
						<td>
						<font color="#FF0000">cts密码修改</font>
						</td>
					</tr>
					<%
					}
					 %>
					
					<tr>
						<td height="30">
							<div align="right">
								<font color="#FF0000">*</font>旧密码:
							</div>
						</td>
						<td>
							<input name="oldPassword" type="password" class="text1"
								id="oldPassword" size="25" onblur="validate()">
								<span id="v1"></span>
						</td>
					</tr>
					<tr>
						<td height="27">
							<div align="right">
								<font color="#FF0000">*</font>新密码:
							</div>
						</td>
						<td>
							<input name="newPassword" type="password" class="text1"
								id="newPassword" size="25">
						</td>
					</tr>
					<tr>
						<td height="34">
							<div align="right">
								<font color="#FF0000">*</font>确认密码:
							</div>
						</td>
						<td>
							<input name="affirmNewPassowrd" type="password" class="text1"
								id="affirmNewPassowrd" size="25">
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<p>
					<input name="btnModify" class="button1" type="button"
						id="btnModify" value="修改" onClick="modifyPasword(<%=status==null?"":status %>)">
					&nbsp; &nbsp;&nbsp;
				</p>
			</div>
		</form>
	</body>
</html>
