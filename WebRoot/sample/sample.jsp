<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("gbk");

String pno="";
int number=1;
int listSize=0;
int sno =0;
String command=request.getParameter("command");
	if(command !=null){
	pno =request.getParameter("pno");
	int pnoL=pno.length();
		if(pnoL<10){
		out.print("<script type='text/javascript'>");
		out.print("alert('输入的快递号的长度要大于10个字符，否则不能准确定位！！！');");
		out.print("</script>");
		}
		List pnoList =new ArrayList();
		pnoList.add("vpno");
		List list =DaoFactory.getInstance().getSimpleDao().getPackageNo(pnoList,pno);
		listSize=list.size();
		System.out.println(listSize);
		//查看样品原来是否已经有值存在
		List rows=DaoFactory.getInstance().getSimpleDao().getSampleSno(pno);
		if(rows.size()>0){
		List column =(List)rows.get(0);
		System.out.println(column.size());
		if(column.size()>0){
			String snoStr =column.get(0).toString();
			//System.out.println(snoStr);
			//System.out.println(snoStr.substring(snoStr.indexOf("-")+1,snoStr.length()));
			sno =Integer.parseInt(snoStr.substring(snoStr.indexOf("-")+1,snoStr.length()));
			//System.out.println(sno);
			
			}
		}
		number=Integer.parseInt(request.getParameter("number"));
}

 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>增加样品</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link rel="stylesheet" href="../css/drp.css">
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
</script>
	<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
	<style type="text/css" bogus="1"> 
.txt{ 
color:#005aa7; 
border-bottom:1px solid #005aa7; /* 下划线效果 */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* 背景色透明 */ 
} 
</style> 
<script type="text/javascript">
	function onIsEmpty(obj){
		var pno =document.getElementById("pno").value;
		if(pno == ""){
		alert("请输入样品编号！！");
		return false;
		}
		if(obj.value<=0){
		alert("请输入样品的数量！！");
		return false;
		}
		var form1=document.getElementById("form1");
		form1.action="sample.jsp";
		form1.submit();
	}
	
	function checkForm(obj){
		if(obj==0){
		alert("没有此快递号,请重新输入！！");
		return false;
		}
		
		var parentLab=document.getElementsByName("plane");
		for(var i=0;i<parentLab.length;i++){
			if(parentLab[i].value ==""){
				alert("请输入样品名称！！！");
				return false;
			}
		}
	}
	
	function clildLab(str,planid){
		$("#speichorot"+str)[0].options.length=0;
		jQuery.ajax({
			url:'child_lab.jsp?planid='+planid,
			type:'POST',
			synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
			dataType: 'xml',//这里可以不写，但千万别写text或者html!!!   
			success:function(xml){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
				$(xml).find('select').each(function(){
					var option1 = "<OPTION value='";   
					var option2 = "'>";   
					var option3 = "</OPTION>"; 
					var text = $(this).children("text").text(); //获取文本框的值
					var value = $(this).children("value").text(); //获取内容的值
				//	alert(option1 + value + option2 + text + option3);
					$("#speichorot"+str).append(option1 + value + option2 + text + option3); 
				});
			}
		})
	}
</script>
  </head>
  
  <body> 
<form action="sample_post.jsp" method="post" name ="form1" id ="form1" onSubmit="return checkForm('<%=listSize%>');">
    	<table border="0" align="center" width="900">
    		<tr>
    		    <input type="hidden" name="command" value="search" />
    			<td>包裹编号：<input type="text" id ="pno" name ="pno" size="40" value="<%=pno%>">&nbsp;&nbsp;样品数量：<input type="text" name ="number" id ="number"  size="20" value="<%=number %>" onBlur="onIsEmpty(this);">
				<script>   
				$("#pno").autocomplete("vpno_ajax.jsp",{
					delay:10,
					minChars:1,
					matchSubset:1,
					matchContains:1,
					cacheLength:5,
					matchContains: true,   
					scrollHeight: 250, 
					width:250,
					autoFill:false
				});    
				</script>  
    			</td>
    		</tr>
    	</table>
    	
    	<input type="hidden" name ="pno" id ="pno" value="<%=pno %>">
    	<table id ="mytable" border="0" align="center" width="900">
    		<tr>
    			<th>样品流水号</th>
    			<th>样品名称</th>
    			<th>型号</th>
    			<th>报告编号</th>
    			<th colspan="2">保存位置</th>
    		</tr>
    		<%
    				pno=pno+"-";
					for(int i=1;i<=number;i++) {
					 %>
					<tr>
						<td>
							<div align="center">
								<input type="text" id="sno<%=i%>" value="<%=pno+(sno+i)%>"" name="sno" size="25" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="sname<%=i%>" name="sname" size="25">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="smodel<%=i %>" name="smodel" size="25">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="sid<%=i%>" name="sid" size="25" >
							</div>
						</td>
							<td>
								<!-- <input type="text" id="speichorot<%=i%>" name="speichorot" size="25"> -->
								<select name="plane" id="plane<%=i %>" style="width: 160px" onChange="clildLab('<%=i%>',this.value);">
									<option label="">---请选择存放地址---</option>
									<%
									List rows =DaoFactory.getInstance().getSimpleDao().getParentLab();
										for(int j=0;j<rows.size();j++){
											List columns =(List)rows.get(j);
											%>
											<option value="<%=columns.get(0)%>"><%=columns.get(1)%></option>
											<%
										}
									 %>
								</select>
			
						</td>
						<td>
							<select id="speichorot<%=i%>" name="speichorot" style="width: 160" >
							</select>
						</td>
					</tr>
					<%
					}
					 %>
					 <tr align="center">
					 	<td colspan="6">
					 		<input type="submit" value="样品入库">
					 	</td>
					 </tr>
    	</table>
    </form>
    </body>
</html>
