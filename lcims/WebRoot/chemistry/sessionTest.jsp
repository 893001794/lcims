<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String command = request.getParameter("command");
String keywords = request.getParameter("keywords");
if(command !=null && keywords.indexOf("ZS")>-1){
	session.setAttribute("tester",keywords);
	session.setMaxInactiveInterval(15);
	System.out.println("成功創建session"+session.getId());
}	
String tester=(String)session.getAttribute("tester");

if(tester ==null ){
System.out.println("tester过期");
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'sessionTest.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
    <form name=form1 method=post action="chemistry/sessionTest.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td align=left valign=middle width=50%>
						输入栏：
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="提交"/>
					</td>
					
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
		</form>
  </body>
</html>
