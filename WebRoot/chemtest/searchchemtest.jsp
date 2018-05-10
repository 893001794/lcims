<%@page import="com.lccert.crm.vo.TopLevel"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="com.lccert.crm.vo.TestChildParent"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>
<%
	request.setCharacterEncoding("GBK");
	String flowtype=request.getParameter("flowtype");
	String planName=request.getParameter("planName");
	List list =new ArrayList();
	if(flowtype !=null && !"".equals(flowtype)){
	if(flowtype.equals("0")){
	flowtype="顶级分类";
	}
	if(flowtype.equals("1")){
	flowtype="一级分类";
	}
	if(flowtype.equals("2")){
	flowtype="二级分类";
	}
	if(flowtype.equals("3")){
	flowtype="三级分类";
	}
	String testype="";
	if(request.getParameter("code") !=null && !"".equals(request.getParameter("code"))){
		 testype=new 	String (request.getParameter("city").getBytes("ISO-8859-1"),"GBK");
		}else{
		 testype=request.getParameter("city");
		}

		if(testype !=null && !"".equals(testype)){
		if(flowtype.equals("二级分类")){
		list =ChemTestDaoImpl.getInstance().findChemTestChild(testype);
		}else 	if(flowtype.equals("一级分类")){
		list =ChemTestDaoImpl.getInstance().findChemTestParent(testype);
		}
		}
		else if (planName !=null && !"".equals(planName)){
		list =ChemTestDaoImpl.getInstance().findChemTestPlan(planName);
		}
		
		else {
		if(flowtype.equals("二级分类")){
		list =ChemTestDaoImpl.getInstance().findChemTestChild();
		}else	if(flowtype.equals("三级分类")){
		list =ChemTestDaoImpl.getInstance().findChemTestPlan();
		}else 	if(flowtype.equals("一级分类")){
		list =ChemTestDaoImpl.getInstance().findChemTestParent();
		}
		if(flowtype.equals("顶级分类")){
		list =ChemTestDaoImpl.getInstance().findTopLevel();
		}
		}
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加流转单</title>
<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>

<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script type="text/javascript" src="../javascript/suggest.js"></script>
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />  
<script type="text/javascript">
	function checksubimt(){

	var check =document.getElementsByName("flowtype");
	
	var n =0;
	for(var i=0;i<check.length;i++){
	if(check[i].checked==true){
	n=n+1;
	
	}
	}
	 if(n<1){
	 alert("至少要选择一项测试项目种类");
	 }
	}

	
function isSelected(value) {
var cityName;
    var city = document.getElementById("city");
       //获取选中的城市名称
       for(i=0;i<city.length;i++){
           if(city[i].selected==true){
            cityName = city[i].innerText;  //关键点
           // alert("cityName:" + cityName);
           }
       }
       }
	
</script>


	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>工程部管理&gt;&gt;添加测试项目</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
		<form  action="searchchemtest.jsp" onsubmit='return checksubimt(this)' method="post">
			<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="15%">
						测试项目种类:
					</td>
					<td >
					<div id="mydiv">
					<input type="hidden" name ="testype">
						顶级分类
						<input type="checkbox" name="flowtype" value="顶级分类" onclick="chooseOne(this)" />
						|
						一级分类
						<input type="checkbox" name="flowtype" value="一级分类" onclick="chooseOne(this)" />
						|&nbsp; 二级分类
						<input type="checkbox" name="flowtype" value="二级分类" onclick="chooseOne(this)"/>
						|&nbsp;三级分类
						<input type="checkbox" name="flowtype" value="三级分类" onclick="chooseOne(this)"/>
						&nbsp;&nbsp;<input type="submit" value="查询">
						&nbsp;&nbsp;|&nbsp;&nbsp;
						<a href="addchemtest.jsp">添加</a>
					</div>
						<script type="text/javascript">
							function chooseOne(cb) { 
						     var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else obj.children[i].checked = true;   
						         }
						           if(cb.value=="三级分类"){
						         document.getElementById("div1").style.display= "none";
						          document.getElementById("div2").style.display= "block";  
						         }  
						         if(cb.value=="二级分类"){
						          document.getElementById("div1").style.display= "block"; 
						           document.getElementById("div2").style.display= "none"; 
						         }  
						           if(cb.value=="一级分类"){
						          document.getElementById("div1").style.display= "block"; 
						           document.getElementById("div2").style.display= "none"; 
						         }  
						      }
						 </script>						
						
						<dir id="div1" style="display: none;">
						测试项目类型&nbsp;&nbsp;
						<select onchange="isSelected(this.value);" id="city" name ="city"> 
						<option value="">----请选择测试项目类型----</option>
						<option value="无机流转单">无机流转单</option>
						<option value="有机流转单" >有机流转单</option>
						<option value="食品流转单" >食品流转单</option>
						<option value="外包流转单" >外包流转单</option>
						<option value="微生物流转单" >微生物流转单</option>
						</select> 
						</dir>
						
						<dir id="div2" style="display: none;">
						测试方法：&nbsp;&nbsp;
						<input name="planName" type="text" size="40"/>
						</dir>
					
   			</td>
				</tr>
							
			</table>
			<br>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				
				<tr>
					<%
					if(flowtype!=null&&flowtype.equals("二级分类")){
					%>
					<td class="rd6" >
						测试项目名称
					</td>
					<td class="rd6" >
						测试要求名称
					</td>
					<td class="rd6" >
						测试项目类型
					</td>
					<td class="rd6" >
						是否有效
					</td>
					<td class="rd6" >
						操作
					</td>
					<%
					}if (flowtype!=null&&flowtype.equals("一级分类")){
					%>
					<td class="rd6" >
						测试项目名称
					</td>
					<td class="rd6" >
						测试项目类型
					</td>
					<td class="rd6" >
						是否有效
					</td>
					<td class="rd6" >
						操作
					</td>
					<%
					}
					if(flowtype !=null && flowtype.equals("顶级分类")){
					%>
					<td class="rd6" >
						测试项目名称
					</td>
					<td class="rd6" >
						是否有效
					</td>
					<td class="rd6" >
						操作
					</td>
					<%
					}if(flowtype!=null&&flowtype.equals("三级分类")){
					%>
					<td class="rd6" >
						测试项目名称
					</td>
					<td class="rd6" >
						测试要求名称
					</td>
					<td class="rd6" >
						测试方法名称
					</td>
					<td class="rd6" >
						是否有效
					</td>
					<td class="rd6" >
						是否带CNSA章
					</td>
					<td class="rd6" >
						操作
					</td>
					<%
					}
					%>
					
					
				</tr>
				<%
				for(int i=0;i<list.size();i++){
				if(flowtype.equals("一级分类")){
				TestParents tp =(TestParents)list.get(i);
				%>
				<tr >
					<td class="rd8" style="text-align: left;">
						<%=tp.getName() %>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tp.getType() %>
					</td>
					<td class="rd8" style="text-align: left;">
					<%=tp.getStatus() %>
					</td>
					
					<td class="rd8" >
					<%
					if(flowtype.equals("一级分类")){
					%>
					<a href="modiparent.jsp?status=<%=flowtype %>&id=<%=tp.getId()%>">修改</a>&nbsp;&nbsp;
					<%
					}
					 %>
						
						
					</td>		
				</tr>
				<%
				}else if (flowtype.equals("顶级分类")){
				TopLevel tl =(TopLevel)list.get(i);
				%>
				<tr>
					<td class="rd8" style="text-align: left;">
					<%=tl.getName()%>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tl.getStatus()%>
					</td>
					<td class="rd8" >
					&nbsp;&nbsp;
					</td>
				</tr>
				<%
				}else if(flowtype.equals("二级分类")){
				TestChildParent tp =(TestChildParent)list.get(i);
				%>
				<tr>
					<td class="rd8" style="text-align: left;">
					<%=tp.getParentName() %>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tp.getChildName() %>
					</td>
					<td class="rd8" style="text-align: left;">
					<%=tp.getType() %>
					</td>
					<td class="rd8">
						<%=tp.getStatus() %>
					</td>
					
					<td class="rd8" >
						<a href="modichild.jsp?satuts=<%=flowtype%>&id=<%=tp.getId() %>">修改</a>&nbsp;&nbsp;
						
					</td>
							
				</tr>
				<%
				
				}else if(flowtype.equals("三级分类")){
				TestPlan tp =(TestPlan)list.get(i);
				
				%>
				<tr>
					
					<td class="rd8" style="text-align: left;">
					<%=tp.getParentName()%>
					</td>
					<td class="rd8" style="text-align: left;">
					<%=tp.getChildName()%>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tp.getPlanName()%>
					</td>
						<td class="rd8" style="text-align: left;">
					<%=tp.getStatus() %>
					</td>
						<td class="rd8" style="text-align: left;">
					<%=tp.getCnastatus() %>
					</td>
						<td class="rd8" >
						<a href="modiplan.jsp?satuts=<%=flowtype%>&id=<%=tp.getId() %>">修改</a>&nbsp;&nbsp;
					</td>
							
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
	</body>
</html>
