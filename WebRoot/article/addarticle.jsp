<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Article"%>
<%@page import="java.util.Map"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
//添加物品
request.setCharacterEncoding("GBK");
Article ar=new Article();
String articleP=request.getParameter("article");
String article=request.getParameter("articleName");
if(article !=null & !"".equals(article)){
if(articleP !=null & !"".equals(articleP)){
ar.setParentid(Integer.parseInt(articleP));
}
ar.setName(article);
boolean flag =DaoFactory.getInstance().getArticleDao().addArticle(ar);
if(flag =true){
out.println("<script type='text/javascript'>");
out.println("alert('添加成功！！！')");
out.println("</script>");
}else{
out.println("<script type='text/javascript'>");
out.println("alert('添加失败！！！')");
out.println("</script>");
}
}

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addarticle.jsp' starting page</title>
    	<script language="javascript">
	
		function goCheck(){
		var str=document.getElementsByName("flowtype");
		var article=document.getElementById("article").value;
		var objarray=str.length;
		var chestr="";
		for (i=0;i<objarray;i++)
		{
	       if(str[i].checked == true){
	       chestr+=str[i].value;
	       }
	}
	

	if(chestr=="二级分类" & article==""){
	alert("请选择大类物品名称"); 
	return false;
	}
	var myspanValue=document.getElementById("myspan").innerText;
	var articleValue=document.getElementById("articleName").value;
	if(articleValue==""){
	alert(myspanValue+"不能为空对象");
	return false;
	}
	var myform=document.getElementById("myform");
	myform.submit();
		
	}
	
	function refreshParent() { 
	window.opener.location.href = window.opener.location.href; 
	if (window.opener.progressWindow) 
	{ 
	window.opener.progressWindow.close(); 
	} 
	window.close(); 
}  


</script>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <form name ="myform" id="myform" action="article/addarticle.jsp" method="post">
  <table align="center" border="0">
  
  <tr>
  	<td colspan="2">
  	
  	<div id="mydiv">
					<input type="hidden" name ="testype">
						大类物品名称
						<input type="checkbox" name="flowtype" id ="flowtype1" checked="checked" value="一级分类" onClick="chooseOne(this);"/>
						|&nbsp; 小类物品名称
						<input type="checkbox" name="flowtype" id ="flowtype2" value="二级分类" onClick="chooseOne(this);"/>
					</div>
					
					 <script>   
    
     function chooseOne(cb) { 
     var obj = document.getElementById("mydiv");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
             else obj.children[i].checked = true;   
         }
          if(cb.value=="一级分类"){
         document.getElementById( "trPA").style.display= "none"; 
         document.getElementById("myspan").innerText="大类物品名称：";
         }   
         if(cb.value=="二级分类"){
          document.getElementById("myspan").innerText="小类物品名称：";
         document.getElementById( "trPA").style.display= "block"; 
         
         }  
      }
 </script>
  	</td>

  </tr>
  
  	<tr name="trPA"id="trPA" style="display: none;">
  	<td>
  		大类物品名称：
  	</td>
  	<td>
  	<select name="article" id ="article" style="width: 300px">
		<option value="">---请选择大类物品名称---</option>
		<%
		Map<String,String> map = DaoFactory.getInstance().getArticleDao().getAllParenArticle();
		for(String value:map.keySet()) {
		%>
		<option value="<%=value %>"><%=map.get(value)%></option>
								<%
		}
								%>
		</select>
  	<td>
  	<tr>
  		<td>
  		<span id ="myspan">大类物品名称</span>:
  		</td>
  		<td><input type="text" size="40" name ="articleName" value="">
  		</td>
  	</tr>
  	<tr>
  		<td>&nbsp;</td>
  		<td>&nbsp;</td>
  	</tr>
  	<tr>
  		<td colspan="2" align="center">
  			<input type="button" value="提交"  onclick="goCheck()" > &nbsp;&nbsp;
  			<input type="button" value="关闭"  onclick="refreshParent();">
  		</td>
  	</tr>
  </table>
  </form>
   
  </body>
</html>
