<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.vo.TestChildParent"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>

<%
	request.setCharacterEncoding("GBK");
	
	String id=request.getParameter("id");
	//System.out.println(id+"------------");
	TestPlan tp =new TestPlan();
	tp =ChemTestDaoImpl.getInstance().findPlanById(Integer.parseInt(id));
	TestChildParent tcp=ChemTestDaoImpl.getInstance().findChildById(tp.getChildId());
	
	
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
			<br>
			<%
			String status=request.getParameter("satuts");
			status = new String(status.getBytes("ISO-8859-1"), "GBK");   
			 %>
			<form method="post" action="addchemtest_post.jsp?testype=<%=status %>&type=modi&id=<%=id %>" >
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						分类名称描述：
					</td>
					<td width="33%">
						<input name="chemtestName" type="text" size="40" value="<%=tp.getPlanName()%>"<%=tp.getPlanName() ==null?"":tp.getPlanName() %>/>
					</td>
					<td width="17%">
						
					</td>
					<td width="33%">
						
					</td>
				</tr>
				<tr>
					<td width="17%">
						是否有效：
					</td>
					<td width="33%">
						<select name ="chemteststatus" style="width: 150px">
						<option value="y" selected="selected">y</option>
							<%
						if(tp.getStatus().equals("n")) {
							%>
							<option value="<%=tp.getStatus() %>" <%=tp.getStatus()!=null?"selected":"" %>><%=tp.getStatus()%></option>
							<%
							}else{
							%>
							<option value="n">n</option>
							<%
							}
							%>
						</select>
					</td>
					
				</tr>
				
				<tr>
					<td width="18%">是否带CNAS章： 
					</td>
					<td>
						<select name ="isCNAS" style="width: 150px">
							<option value="y" selected="selected">y</option>
							<%
						if(tp.getCnastatus().equals("n")) {
							%>
							<option value="<%=tp.getCnastatus() %>" <%=tp.getCnastatus()!=null?"selected":"" %>><%=tp.getCnastatus()%></option>
							<%
							}else{
							%>
							<option value="n">n</option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				
			</table>
			<table>
				<tr>
					<td>测试要求(二级分类)</td>
					<td>
					<select name="chemtestchild"> 
					<%
					
					 List list =ChemTestDaoImpl.getInstance().findChemTestChild(tcp.getType());
					
					for(int i=0;i<list.size();i++){
					TestChildParent tpc =(TestChildParent)list.get(i);
					if(tp.getChildName().equals(tpc.getChildName())){
					%>
					<option value="<%=tpc.getId() %>"<%=tpc.getChildName()==null?"":"selected" %>><%=tpc.getChildName() %>&nbsp;&nbsp;<%=tpc.getType()%></option>
					<%
					}else{
					%>
					<option value="<%=tpc.getId() %>"><%=tpc.getChildName() %>&nbsp;&nbsp;<%=tpc.getType()%></option>
					<%
					}
					
					}
					 %>
					 	</select>
					</td>
				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
					<td width="18%">测试项目中文描述： 
					</td>
					<td>
						<textarea name="describe1C" rows="3" cols="76" ><%=tp.getDescribe1C()==null?"":tp.getDescribe1C()%></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试要求中文描述： 
					</td>
					<td>
						<textarea name="describe2C" cols="73" rows="4" ><%=tp.getDescribe2C()==null?"":tp.getDescribe2C()%></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试方法中文描述： 
					</td>
					<td>
						<textarea name="describe3C" cols="73" rows="4" ><%=tp.getDescribe3C()==null?"":tp.getDescribe3C()%></textarea>
					</td>
				</tr>
				<tr>
					<td width="18%">测试项目英文描述： 
					</td>
					<td>
						<textarea name="describe1E" rows="3" cols="76" ><%=tp.getDescribe1E()==null?"":tp.getDescribe1E()%></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试要求英文描述： 
					</td>
					<td>
						<textarea name="describe2E" cols="73" rows="4"><%=tp.getDescribe2E()==null?"":tp.getDescribe2E()%></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						测试方法英文描述： 
					</td>
					<td>
						<textarea name="describe3E" cols="73" rows="4" ><%=tp.getDescribe3E()==null?"":tp.getDescribe3E()%></textarea>
					</td>
				</tr>
			</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="修改" >
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
		
		</form>
	</body>
</html>
