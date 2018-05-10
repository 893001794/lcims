<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addselect.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	function checkText(){
		var category=document.getElementById("category").value;
		if(category == "" || category==null){
			alert("类别名称不能为空");
			return ;
		}
//	window.showModalDialog("addcatgory_post.jsp?category=" + category,a,"dialogWidth:600px;dialogHeight:400px");
	//window.close();
	document.getElementById("myform").submit();
	}
	
	function goBack() {
		window.self.location="addnotes.jsp";
	}
</script>
  </head>
  
  <body>
	<form action="note/addcatgory_post.jsp" method="post" name ="myform" id="myform">
	<table width="95%" border="0" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td align="center">
						<b><h2>
								增加公告类别名称
							</h2> </b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<br>
			<br>
	<table width="95%" border="0" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td align="center">
						请输入分类名称：<input type="text" size="50" name ="category" id="category">
					</td>
				</tr>
				<br>
				<br>
				<tr>
					<td align="center">
						<input type="button" value="添加" onclick="checkText()">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
					</td>
					
				</tr>
			</table>
		
		
	</form>
  </body>
</html>
