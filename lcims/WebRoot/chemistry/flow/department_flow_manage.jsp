<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.vo.FlowTest"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>
 <%@ page errorPage="../../error.jsp" %>
 <%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	System.out.println("pageNoStr:"+pageNoStr);
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	
	}
	System.out.println("pageNo:"+pageNo);
	String fidNo = request.getParameter("fidNo");
	String fidTestName = request.getParameter("fidTestName");
	if(fidNo ==null){
		fidNo="";
	}
	if(fidTestName ==null){
		fidTestName="";
	}
	PageModel pm = DaoFactory.getInstance().getFlowTest().findAllInPage(fidNo,fidTestName,pageNo,pageSize);
	if(pm==null){
		pm=new PageModel();
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>实验室流转单列表</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script src="../../javascript/jquery.js"></script>
		<script type="text/javascript">
			function changCount(id){
				var count =$("#testCount"+id).val();
				jQuery.ajax({
					url:"/lcims/ajaxClass", //跳转了路径
					data:"method=changeFlowTestCount&id="+id+"&count="+count, //传输的值或参数
					type:'POST',
					synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
					success: function(data){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
						var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
					 	if(agent.attr('suc') == 'false'){ //得到名称为agent的xml对象里面suc元素，并且判断suc元素的值是否为true
						 	alert("修改测试点失败，请管理员！");
							return false;
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){ 
						alert("XMLHttpRequest:"+XMLHttpRequest);
						alert("textStatus:"+textStatus);
						alert("errorThrown:"+errorThrown);
					}
				})
			}
		</script>
	</head>

	<body class="body1">

		<div align="center">
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="35">
				<tr>
					<td class="p1" height="18" nowrap>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td width="522" class="p1" height="17" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>化学项目管理&gt;&gt;实验室流转单&gt;&gt;流转单列表</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=department_flow_manage.jsp?command=search>
							<font color="red">&nbsp;请输流转单号：&nbsp;</font>
							<input type=text name=fidNo size="25" >
							<input type=submit name=Submit value=搜索>
						</form>
					</td>

				</tr>

				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=department_flow_manage.jsp?command=search>
							<font color="red">大项目测试名称：</font>
							<input type=text name=fidTestName size="25"  >
							<input type=submit name=Submit value=搜索>
						</form>
					</td>

				</tr>

			</table>

			<hr width="97%" align="center" size=0>
			<form name="userform" id="userform">
		</div>
		<table width="95%" height="20" border="0" align="center"
			cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="30%" class="rd19">
					<font color="#FFFFFF" size="2pt">查询列表</font>
				</td>


			</tr>
		</table>
		<table width="95%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="table1">
			<tr>
				<td class="rd6" width="5%">
					<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
				</td>
				<td class="rd6">
					流转单编号
				</td>
				<td class="rd6">
					流转单大项编号
				</td>
				<td class="rd6">
					流转单大项名称
				</td>
				<td class="rd6">
					测试点数
				</td>
			</tr>

			<%
				List<FlowTest> list = pm.getList();
					if(list != null) {
						for(int i=0;i<list.size();i++) {
							FlowTest flowTest = list.get(i);
			%>
							<tr>
								<td class="rd8">
									<input type="checkbox" name="selectFlag" class="checkbox1"
										value="<%=flowTest.getFid()%>">
								</td>
								<td class="rd8">
									<%=flowTest.getFid() %>
								</td>
								<td class="rd8">
									<%=flowTest.getFidTestNo() %>
								</td>
								<td class="rd8">
									<%=flowTest.getFidTestName()%>
								</td>
								<td class="rd8">
									<input type="text" value="<%=flowTest.getCount()%>" id="testCount<%=flowTest.getId()%>">
									<input type="button" onclick="changCount('<%=flowTest.getId()%>');" value="修改">
								</td>
							</tr>
				<%
						}
					}
				 %>
			<tr style="background-color: #E0F8E0">
				<td height="25" colspan="12" align="left">
					<div align="center">
						记录总条数：<%=pm.getTotalRecords()%>
						当前页/总页数:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a
							href="department_flow_manage.jsp?pageNo=1&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">首页</a>
						<a
							href="department_flow_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">上一页</a>
						<a
							href="department_flow_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">下一页</a>
						<a
							href="department_flow_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">末页</a>
					</div>
				</td>
			</tr>
		</table>
	</body>
</html>
