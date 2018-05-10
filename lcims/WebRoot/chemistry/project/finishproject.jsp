<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.vo.FinishProject"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>

<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	PageModel pm = null;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	String sales = request.getParameter("sales");
	if(sales != null && !"".equals(sales)) {
		sales = new String(sales.getBytes("iso-8859-1"),"GBK"); 
	} else {
		sales = "";
	}
	//判断公司名称
	String client = request.getParameter("client");
	if(client != null && !"".equals(client)) {
		client = new String(client.getBytes("iso-8859-1"),"GBK"); 
	} else {
		client = "";
	}
	
	String paystatus = request.getParameter("paystatus");
	if(paystatus == null) {
		paystatus = "";
	}
	String status = request.getParameter("status");
	if(status == null) {
		status = "";
	}
	
	pm = ProjectAction.getInstance().searchProjects(pageNo,pageSize,sales,paystatus,status,client);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>已完成项目</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	
	
	
	function modifyflow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要添加流转单的项目！");
			return;
		}
		if (count > 1) {
			alert("一次只能选择一个项目！");
			return;
		}
	
		window.parent.content.rows='20,0%,*';
		window.parent.frames[2].location = "../flow/addflow.jsp?rid=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	
	
	
	
	function deleteUser() {
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("请选择需要删除的用户数据！");
			return;
		}
		if (window.confirm("是否确认删除选中的数据？")) {
			//执行删除
			with (document.getElementById("userForm")) {
				method = "post";
				action = "quotationlist.jsp?command=delete"
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	function topPage() {
		window.self.location = "finishproject.jsp?pageNo=1&sales=<%=sales%>&paystatus=<%=paystatus%>&status=<%=status%>&client=<%=client%>";
	}
	
	function previousPage() {
		window.self.location = "finishproject.jsp?pageNo=<%=pm.getPreviousPageNo()%>&sales=<%=sales%>&paystatus=<%=paystatus%>&status=<%=status%>&client=<%=client%>";
	}	
	
	function nextPage() {
		window.self.location = "finishproject.jsp?pageNo=<%=pm.getNextPageNo()%>&sales=<%=sales%>&paystatus=<%=paystatus%>&status=<%=status%>&client=<%=client%>";
	}
	
	function bottomPage() {
		window.self.location = "finishproject.jsp?pageNo=<%=pm.getBottomPageNo()%>&sales=<%=sales%>&paystatus=<%=paystatus%>&status=<%=status%>&client=<%=client%>";
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
						<b>销售管理&gt;&gt;未发出报告</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>




			<form name="form1" method="get" action="finishproject.jsp">
  <table width="95%" border="0" cellpadding="0" cellspacing="0" align="center" class=TableBorder>
    <tr height="22" valign="middle" class="rd6"> 
      <th width="25%">销售人员</th>
      <th width="15%">付款状态 </th>
      <th width="25%">项目状态</th>
      <th width="25%">客户公司名称</th>
      <th width="20%" height="25">&nbsp;</th>
      <th width="13%">&nbsp;</th>
    
    </tr>
    <tr height="22" valign="middle" align="center" class="rd8"> 
      <td>
      	<select name="sales" id="sales" style="width: 150px">
      		<option value="" selected>所有</option>
			<%
			Map<String,String> map = FlowFinal.getInstance().getAllSales();
			for(String value:map.keySet()) {
			 %>
			<option value="<%=map.get(value) %>" <%=map.get(value).equals(sales)?"selected":"" %>><%=map.get(value) %></option>
			<%
			 }
			%>
		</select>
	</td>
      <td>
      	<select name="paystatus" id="paystatus" style="width: 150px">
			<option value="" selected>全部</option>
			<option value="n" selected>未付</option>
			<option value="y">已付</option>
		</select>
		<script type="text/javascript">
					var ops2 = document.getElementById("paystatus").options;
					for(var i=0;i<ops2.length;i++) {
						if(ops2[i].value.indexOf("<%=paystatus%>")==0 && "<%=paystatus%>".indexOf(ops2[i].value) == 0){
							ops2[i].selected = true;	
						}
					}
		</script>
      </td>
      
      <td>
      	<select name="status" style="width: 150px" onchange="changeStatus()">
								<option value="">
									全部
								</option>
								<option value="1">
									立项
								</option>
								<option value="2">
									排单
								</option>
								<option value="3">
									流转单
								</option>
								<option value="4">
									测试
								</option>
								<option value="5">
									测试完成
								</option>
								<option value="6">
									重测
								</option>
								<option value="9">
									结案
								</option>
								<option value="10">
									发证
								</option>
							</select>
							
		<td>
	      						<input id="client" type="text" name="client" size="40" />
								 <script>   
							        $("#client").autocomplete("../../client_ajax.jsp",{
							            delay:10,
							            minChars:1,
							            matchSubset:1,
							            matchContains:1,
							            cacheLength:10,
							            matchContains: true,   
							            scrollHeight: 250, 
							            width:250,
							            autoFill:false
							        });    
							     </script>
			</td>
			<td>
			<script type="text/javascript">
					var ops = document.getElementById("status").options;
					for(var i=0;i<ops.length;i++) {
						if(ops[i].value.indexOf("<%=status%>")==0 && "<%=status%>".indexOf(ops[i].value) == 0){
							ops[i].selected = true;	
						}
					}
			</script>
							
	  </td>
   
      <td>
      <input type="submit" name="Submit" value="提交">&nbsp;&nbsp;<input type="reset" name="Submit2" value="重置">
       </td>
    </tr>
  </table>
</form>


			<hr width="100%" align="center" size=0>
		</div>
		
		<form name="userform" id="userform">

			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">查询列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6">
						<input type="checkbox" name="ifAll" id="ifAll"
							onClick="checkAll()">
					</td>
					<td class="rd6">
						报价单编号
					</td>
					<td class="rd6">
					关联报价单
					</td>
					<td class="rd6">
						报告编号
					</td>
					<td class="rd6">
						客户名称
					</td>
					<td class="rd6">
						报告类型
					</td>
					<td class="rd6">
						报价金额
					</td>
					<td class="rd6">
						是否收款
					</td>
					<td class="rd6">
						销售
					</td>
					<td class="rd6">
						状态
					</td>
					
				</tr>

		<%
			List<FinishProject> list = pm.getList();
			for(int i=0;i<list.size();i++) {
				FinishProject fp = list.get(i);
				List temp =fp.getObj();
				Quotation qu =new Quotation();
				float totalpay =fp.getPrice();
				if(temp.size()>0){
				 qu=(Quotation)temp.get(0);
				 
				 
						String quotype =qu.getQuotype();
						if(quotype.equals("flu") ){
						totalpay=totalpay-qu.getInvcount();
						}
						if(quotype.equals("add") ){
						totalpay=totalpay+qu.getInvcount();
						}if(quotype.equals("mod") ){
						totalpay=totalpay+qu.getInvcount();
						}
				}
				
		%>

				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=fp.getRid() %>">
					</td>
					<td class="rd8">
						<a href="../../quotation/detail.jsp?pid=<%=fp.getPid() %>"><%=fp.getPid() %></a>
					</td>
					<td class="rd8">
					<%=temp.size()>0?qu.getPid():""%>
					</td>
					<td class="rd8">
						<a href="projectdetail.jsp?sid=<%=fp.getSid() %>"><%=fp.getRid() %></a>
					</td>
					<td class="rd8">
						<%=fp.getClient() %>
					</td>
					<td class="rd8">
						<%=fp.getRptype() %>
					</td>
					<td class="rd8">
						<%=totalpay%>
					</td>
					<td class="rd8">
						<%=fp.getPaystatus() %>
					</td>
					<td class="rd8">
						<%=fp.getSales() %>
					</td>
					<td class="rd8">
						<%=fp.getStatus() %>
					</td>
					
				</tr>

			<%
				}
			 %>

			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp; <%=pm.getTotalPages() %> &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">当前第</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">页</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="首页"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="上页"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="下页" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="尾页"
								onClick="bottomPage()">
						</div>
					</td>
					
				</tr>
			</table>

		</form>

	</body>
</html>
