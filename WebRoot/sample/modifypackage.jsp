<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
String strId=request.getParameter("id");
String client ="";
int id =0;
if(strId !=null){
	 id =Integer.parseInt(strId);
	//根据获取包裹信息
	List list =new ArrayList();
	list.add("vclient");
	List row=DaoFactory.getInstance().getSimpleDao().getPackageById(list,id);
	List colunm=(List)row.get(0);
	client =colunm.get(0).toString();
}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加报价单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/orderscript.js"></script>
		<script type="text/javascript">
			function trans(){
					var client=document.getElementById("client").value;
					  $.ajax({ //调用jquery ajax
						type:"POST",  //跳转方法为POST
						//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
						url:"/lcims/upSamplePack", //跳转了路径
						data:"client="+client+"&id=<%=id%>", //传输的值或参数
				        error: function(){alert("error!!");},  //如果路径错误或者参数有错的时候就弹出此窗口
						success: function(data){  //如果正确或拿到java里面传输过来的值
						    var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
						 	if(agent.attr('suc') == 'true'){ //得到名称为agent的xml对象里面suc元素，并且判断suc元素的值是否为true
						 	var userId=agent.attr('name'); //得到名称为xml对象里面的name对象
							alert("修改成功！");
							window.returnValue="true";
							//window.dialogArguments.location=window.dialogArguments;
							 //window.dialogArguments.window.location="user.do";
							self.close();
							}else{
							alert("修改失败");
							return false;
							}}
					});
					  
				} 
		</script>
	</head>
	<body class="body1">
		<form>
			<table width="500" height="10" align=" " >
    	<tr>
    		<td align="center"">
    			请输入客户名称:<input type="text"" size="40" name ="client" id="client" value="<%=client%>">
    			<input type="button" onclick="trans();" value="修改">
    		</td>
    	</tr>
 	
    </table>
    </form>
	</body>
</html>
