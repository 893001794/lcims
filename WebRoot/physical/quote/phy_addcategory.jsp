<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	request.setCharacterEncoding("GBK");
	String idStr =request.getParameter("id");
	List columns =new ArrayList();
	String lab ="";
	String availability ="" ; // 有效性
	String standard="";
	int id =0;
	if(idStr !=null && !"".equals(idStr)){
		id =Integer.parseInt(idStr.trim());
		System.out.print(id);
		List rows =DaoFactory.getInstance().getPhyQuoteManageDao().getPhyInfor(id,"pc");
		columns=(List)rows.get(0);
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加电子电器信息</title>
<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
			
		<link rel="stylesheet" href="../../css/style.css">
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
		<script src="../../javascript/jquery.autocomplete.js"></script>
		
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
	width: 750px;
}
.hid {
	display: none;
}
</style>
		<script type="text/javascript">
	
	    
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"客户名称是否存在");
	    validateclient(client);
	    }
	    
      function ajaxChange(){
	    Change_Select();
	    servinfo();
	    }
	    
	    
	    function checkForm(TheForm) {

		if (TheForm.quotime.value == "") {
			alert ("报价日期不能为空！");
			TheForm.quotime.focus();
			return(false);
		}
		if (TheForm.completetime.value == "") {
			alert ("客户要求时间不能为空！");
			TheForm.completetime.focus();
			return(false);
		}
		if (TheForm.estimatesPoints.value == "") {
			alert ("估计测试点数不能为空！");
			TheForm.estimatesPoints.focus();
			return(false);
		}

		return(true);
	}
	
	function modifymoney(){
	var quotype=document.getElementById("quotype").value;
	if(quotype=="sup" || quotype=="add" || quotype=="flu"){
	var modifymoneytype=0;
	if(quotype =="sup"){
	modifymoneytype=1;
	}
	if(quotype =="add"){
	modifymoneytype=2;
	}
	if(quotype =="flu"){
	modifymoneytype=3;
	}
	self.location.href="../../finance/quotation/adjustpid.jsp?type="+modifymoneytype;
	}
	}
	
	function changetype(object){
	if(!(object.value.indexOf("new") ==0)){
	document.getElementById("trpid").style.display = "";
	}else{
	document.getElementById("trpid").style.display = "none";
	}
	}
	
	function addcategory(obj,id){
		var nameCH =document.getElementById("nameCH").value;
		
		if(nameCH ==null || nameCH==""){
			alert("请输入中文名！！！");
			return false;
		}
		
		myform =document.getElementById("quotationform");
		myform.method="post";
		if(obj == 1){
		myform.action="phy_addcategory_post.jsp?status=1&id="+id;
		}else{
		myform.action="phy_addcategory_post.jsp?id="+id;
		}
		myform.submit();
	}
		</script>

	</head>

	<body class="body1" >
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="confirmUserId" id ="confirmUserId" type ="hidden" value="">
			<input name="totalprice" id="totalprice" type="hidden" value="" />
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>电子电器管理&gt;&gt;添加产品类别</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="1100" cellpadding="5" cellspacing="5">
					<tr>

						<td width="200">
							中文名：
						</td>
						<td width="33%">
						<%if(columns.size()>0){
						%>
						<input type="text" size="40" id ="nameCH" name ="nameCH"  value="<%=columns.get(0)==null?"":columns.get(0) %>">
						<%
						}else{
						%>
						<input type="text" size="40" id ="nameCH" name ="nameCH"  value="">
						<%
						} %>
							  
						</td>
						<td>
							英文名：
						</td>
						<td >
						<%if(columns.size()>0){
						%>
						<input type="text" size="40" id ="nameEN" name ="nameEN"  value="<%=columns.get(1)==null?"":columns.get(1)%>">
						<%
						}else{
						%>
						<input type="text" size="40" id ="nameEN" name ="nameEN"  value="">
						<%
						} %>
							 
						  
							
						</td>
					</tr>
					<tr style="display: block;" id ="trpid">
						<td >描述：</td>
						<td colspan="3">
						<%if(columns.size()>0){
							%>
							<textarea rows="1" cols="3" name ="description"  id="description" style="width:76%" ><%=columns.get(2)==null?"":columns.get(2)%></textarea>
							<%
							}else{
							%>
							<textarea rows="1" cols="3" name ="description"  id="description" style="width:76%" ></textarea>
							<%
							} %>
						
						</td>
						
					</tr>
					<tr style="display: block;" id ="trpid">
						<td >销售信息：</td>
						<td colspan="3">
						<%if(columns.size()>0){
							%>
							<textarea rows="5" cols="3" name ="salesinformation"  id="salesinformation" style="width:76%" ><%=columns.get(3)==null?"":columns.get(3) %></textarea>
							<%
							}else{
							%>
							<textarea rows="5" cols="3" name ="salesinformation"  id="salesinformation" style="width:76%" ></textarea>
							<%
							} %>
						
						</td>
						
					</tr>
				</table>

			</div>


			<div align="center">
			<%if(idStr ==null){ %>
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存并返回本页" onClick="addcategory(1,'<%=id%>');">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="保存" onClick="addcategory(0,'<%=id%>');">
					<%}else{
					%>
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="修改" onClick="addcategory(0,'<%=id%>');">
					<%
					} %>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="window.history.back()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
