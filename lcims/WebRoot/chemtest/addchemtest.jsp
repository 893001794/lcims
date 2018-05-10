<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.vo.TestChildParent"%>

<%
	request.setCharacterEncoding("GBK");
	String satuts=request.getParameter("satuts");
	List list1 =new ArrayList ();
	if(satuts!=null & !"".equals(satuts)){
	if(satuts.equals("二级分类")){
		list1 =ChemTestDaoImpl.getInstance().findChemTestChild();
		}else	if(satuts.equals("三级分类")){
		list1 =ChemTestDaoImpl.getInstance().findChemTestPlan();
		}else 	if(satuts.equals("一级分类")){
		list1 =ChemTestDaoImpl.getInstance().findChemTestParent();
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

		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		
</script>

		<script type="text/javascript">
		//检查文本框是否为空对象
		function checkSubimt(obj) {
		var love = document.getElementsByName("flowtype");
//选择是否有复选框被选择，有则打印
		var n = 0;
		for ( var i = 0; i < love.length; i++) {
		if (love[i].checked == true) {
		n = n + 1;
		document.getElementById("testype").value=love[i].value;
		var chemtestName =document.getElementById("chemtestName").value;
		var chemtestype =document.getElementById("chemtestype").value;
		var chemtestParent=document.getElementById("chemtestParent").value;
		var describe1C=document.getElementById("describe1C").value;
		var describe2C=document.getElementById("describe2C".value)
		var describe3C=document.getElementById("describe1C").vaule;
		var describe1E =document.getElementById("describe1E").value;
		var describe2E=document.getElementById("describe2E").value;
		var describe3E=document.getElementById("describe1E").value;
		
		//不管是一级还是其他分类都要判断测试项目是否为空对象 
		if(chemtestName ==""){
		alert("测试项目不能为空");
		return false;
		}
		//不管是一级还是其他分类都要判断测试分类是否为空对象 
		if(love[i].value=="一级分类"){
			if(chemtestype ==""){
			alert("测试项目类别不能为空");
			return false
			}
		}
		
		if(love[i].value=="三级分类"){
		//三级判断测试项目中文或英文描述是否为空对象 
		if(describe1E =="" && describe1C ==""){
		alert("测试项目的中文描述或英文描述其中一个不能为空");
		return false;
		}
	
		
		//三级判断测试要求 中文或英文描述是否为空对象 
		else if(describe2E =="" && describe2C ==""){
		alert("测试要求的中文描述或英文描述其中一个不能为空");
		return false;
		}
		//三级判断测试方法中文或英文描述是否为空对象 
		else if(describe3E =="" && describe3C ==""){
		alert("测试方法的中文描述或英文描述其中一个不能为空");
		return false;
		}
		
		
		}
		}
		
	
		
		}
		
	   //判断至少有一项被选择
		if (n < 1 || m < 1) {
		alert('请填写信息,至少选择一项 ！');
		return false;
		} else {
		
		return true;
		}




		
	

		

		}
		
	</script>
	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>《&nbsp; 
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>工程部管理&gt;&gt;添加工程测试</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
		<form  action="addchemtest_post.jsp" onsubmit='return checkSubimt(this)' method="post">
			<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
						测试项目种类:
					</td>
					<td >
					<div id="mydiv">
					<input type="hidden" name ="testype">
						顶级分类
						<input type="checkbox" name="flowtype" value="顶级分类" onClick="chooseOne(this);" checked="checked"/>
						|&nbsp;一级分类
						<input type="checkbox" name="flowtype" value="一级分类" onClick="chooseOne(this);"/>
						|&nbsp; 二级分类
						<input type="checkbox" name="flowtype" value="二级分类" onClick="chooseOne(this);"/>
						|&nbsp;三级分类
						<input type="checkbox" name="flowtype" value="三级分类" onClick="chooseOne(this);"/>
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
         document.getElementById("type").style.display="block";
         document.getElementById("parentid").style.display="block";
         document.getElementById( "div1").style.display= "none"; 
         document.getElementById( "div2").style.display= "none"; 
         document.getElementById( "div3").style.display= "none"; 
         document.getElementById( "myTestDiv").style.display= "block"; 
         }   
         if(cb.value=="二级分类"){
         document.getElementById("type").style.display="block";
         document.getElementById("parentid").style.display="none";
         document.getElementById( "div1").style.display= "block"; 
         document.getElementById( "div2").style.display= "none"; 
         document.getElementById( "div3").style.display= "none"; 
         document.getElementById( "myTestDiv").style.display= "none"; 
         }  
         
           if(cb.value=="三级分类"){
         document.getElementById("type").style.display="block";
         document.getElementById( "div1").style.display= "none"; 
         document.getElementById("parentid").style.display="none";
         document.getElementById( "div2").style.display= "block"; 
         document.getElementById( "div3").style.display= "block"; 
          document.getElementById( "myTestDiv").style.display= "none"; 
         }    
         if(cb.value=="顶级分类"){
         document.getElementById("type").style.display="none";
         document.getElementById("parentid").style.display="none";
         document.getElementById( "div1").style.display= "none"; 
         document.getElementById( "div2").style.display= "none"; 
         document.getElementById( "div3").style.display= "none"; 
          document.getElementById( "myTestDiv").style.display= "none"; 
         }
         
      }
 </script>
					</td>
				</tr>
							
			</table>
			<br>
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						分类名称描述：
					</td>
					<td width="33%">
						<input name="chemtestName" type="text" size="40"/>
					</td>
					
				</tr>
				<tr id="type" style="display: none;">
				<td width="17%">
						类别：
					</td>
					<td width="33%">
						<select name ="chemtestype" style="width: 250px">
							<option value="">请选择测试项目类型</option>
							<option value="无机流转单" >无机流转单</option>
							<option value="有机流转单" >有机流转单</option>
							<option value="食品流转单" >食品流转单</option>
							<option value="外包流转单" >外包流转单</option>
							<option value="微生物流转单" >微生物流转单</option>
						</select>
					</td>
				</tr>
				<tr id ="parentid" style="display: none;">
					<td>一级项目的id</td>
					<td><input name ="parentid" id ="parentid" value="" size="40"><font color="red">id与id之间用,隔开</font></td>
				</tr>
				<tr>
					<td width="17%">
						是否有效：
					</td>
					<td width="33%">
						<select name ="chemteststatus" style="width: 150px">
							<option value="y" selected="selected">y</option>
							<option value="n">n</option>
						</select>
					</td>
				</tr>
			</table>
			
			<div id ="div1" style="display: none">
			<table>
				<tr>
					<td>测试项目(一级分类)：</td>
					<td>
					<select name ="chemtestParent"> 
					<%
					List list =ChemTestDaoImpl.getInstance().findChemTestParent();
					for(int i=0;i<list.size();i++){
					
					TestParents tp =(TestParents)list.get(i);
					%>
					<option value="<%=tp.getId() %>"><%=tp.getName() %>&nbsp;&nbsp;<%=tp.getType() %></option>
					<%
					}
					 %>
					 	</select>
					</td>
				</tr>
			</table>
			</div>
			
			<div id ="div3" style="display: none">
			<table>
				<tr>
					<td>测试要求(二级分类)</td>
					<td>
					<select name="chemtestchild"> 
					<%
					 list =ChemTestDaoImpl.getInstance().findChemTestChild();
					for(int i=0;i<list.size();i++){
					TestChildParent tp =(TestChildParent)list.get(i);
					%>
					<option value="<%=tp.getId() %>"><%=tp.getChildName() %>&nbsp;&nbsp;<%=tp.getType() %></option>
					<%
					}
					 %>
					 	</select>
					</td>
				</tr>
			</table>
			</div>
			<div id ="div2" style="display:none; ">
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="18%">是否带CNAS章： 
					</td>
					<td>
						<select name ="isCNAS" style="width: 150px">
							<option value="y" selected="selected">y</option>
							<option value="n">n</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="18%">测试项目中文描述： 
					</td>
					<td>
						<textarea name="describe1C" rows="3" cols="76" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试要求中文描述： 
					</td>
					<td>
						<textarea name="describe2C" cols="73" rows="4" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试方法中文描述： 
					</td>
					<td>
						<textarea name="describe3C" cols="73" rows="4" ></textarea>
					</td>
				</tr>
				<tr>
					<td width="18%">测试项目英文描述： 
					</td>
					<td>
						<textarea name="describe1E" rows="3" cols="76" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试要求英文描述： 
					</td>
					<td>
						<textarea name="describe2E" cols="73" rows="4" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试方法英文描述： 
					</td>
					<td>
						<textarea name="describe3E" cols="73" rows="4" ></textarea>
					</td>
				</tr>
			</table>
			</div>
			<div id ="myTestDiv" style="display: none;">
				1	电子电气产品
				2	玩具及儿童用品
				3	纺织品
				4	皮革
				5	鞋类
				6	食品接触材料
				7	木制品
				8	涂料/胶粘剂
				9	金属
				10	包装材料
				13	化妆品
				16	环境
			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="添加" >
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
