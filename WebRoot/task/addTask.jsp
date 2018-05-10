<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
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
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String type=request.getParameter("type");
	String strId=request.getParameter("id");
	//任务id
	int id=0;
	//产品名称
	String name="";
	//内容
	String content="";
	//周期
	int period=0;
	//优先级
	String priority ="";
	String status ="";
	if(strId !=null){
		List row =DaoFactory.getInstance().getInventoryDao().getProduct(Integer.parseInt(strId));
		List columns =(List)row.get(0);
		name=columns.get(1).toString();
		//System.out.println("大类:"+genera);
		content=columns.get(2).toString();
		period =Integer.parseInt(columns.get(3).toString());
		priority=columns.get(4).toString();
		status=columns.get(5).toString();
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
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script type="text/javascript" src="../javascript/jquery-1.3.2.min.js" ></script>
		<script type="text/javascript" src="../javascript/mln.colselect.js"></script>
        <link href="../css/mln-main.css" rel="stylesheet" type="text/css" charset="utf-8" />
        <!-- 调用日期样式 -->
        <script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link href="../css/mln.colselect.css" rel="stylesheet" type="text/css">
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
.hid {
	display: none;
}
</style>
<script type="text/javascript">
	function addproduct(obj){
		myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addTask_post.jsp?type="+obj;
		myform.submit();
	}
</script>
	</head>
	<body class="body1" onload="load();">
		<form method="post" name="quotationform" id="quotationform" action="addTask_post.jsp"
			onSubmit="return checkForm(this)">
			<input name="id" type="hidden" value="<%=id %>" />
			<table width="85%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<table width="85%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>库存管理&gt;&gt;添加产品信息</b>
					</td>
				</tr>
			</table>
			<hr width="85%" align="center" size=0>
			<div class="outborder">
				<table width="85%" cellpadding="5" cellspacing="5">
					
					<tr>
						<td>
							任务名称：
						</td>
						<td>
							<input name="name" id ="name" size="40" value="<%=name==null?"":name%>">
						</td>
						<td>
							周期：
						</td>
						<td width="33%">
							<input name="period" type="text" id="period" size="27" value="<%=period%>"/>
						</td>
					</tr>
					<tr>
						<td>
							申请人：
						</td>
						<td>
							<input name="applicant" id ="applicant" size="40" value="">
						</td>
						<td>
							&nbsp;&nbsp;
						</td>
						<td width="33%">
							&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td width="10%">任务内容</td>
						<td colspan="3"><textarea style="width: 800" id="content" name="content"><%=content%></textarea></td>
					</tr>
					<tr>
						<td> 
							是否完成： 
						</td>
						<td>
							<input name="status" type="radio"" id="status" size="40" value="n" checked="checked">否
							<input name="status" type="radio"" id="status" size="40" value="y" <%=status.equals("y")?"checked":"" %>>是
						</td>
						<td width="12%">
							优先级：
						</td>
						<td width="33%">
							<select name="priority" id="priority" style="width: 200px" onchange="Change_Select(this.value);">
								<option value="" selected="selected">---优先级---</option>
								<option value="Ⅰ" <%=priority.equals("Ⅰ")?"selected":"" %>>Ⅰ</option>
								<option value="Ⅱ" <%=priority.equals("Ⅱ")?"selected":"" %>>Ⅱ</option>
								<option value="Ⅲ" <%=priority.equals("Ⅲ")?"selected":"" %>>Ⅲ</option>
								<option value="Ⅳ" <%=priority.equals("Ⅳ")?"selected":"" %>>Ⅳ</option>
								<option value="Ⅴ" <%=priority.equals("Ⅴ")?"selected":"" %> >Ⅴ</option>
								<option value="Ⅵ" <%=priority.equals("Ⅵ")?"selected":"" %>>Ⅵ</option>
								<option value="Ⅶ" <%=priority.equals("Ⅶ")?"selected":"" %>>Ⅶ</option>
								<option value="Ⅷ" <%=priority.equals("Ⅷ")?"selected":"" %>>Ⅷ</option>
								<option value="Ⅸ" <%=priority.equals("Ⅸ")?"selected":"" %>>Ⅸ</option>
								<option value="Ⅹ" <%=priority.equals("Ⅹ")?"selected":"" %>>Ⅹ</option>
							</select>
						</td>
						
					</tr>
					<tr>
					
						<td colspan="4" style="text-align: center;">
						<%if(type ==null){
						%>
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="保存" onClick="addproduct('add');">
						<%
						}else{
						%>
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="修改" onClick="addproduct('<%=type%>')">
						<%
						} %>
						
					</td>
					</tr>
				</table>
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
