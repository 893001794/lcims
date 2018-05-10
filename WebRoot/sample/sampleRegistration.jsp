<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@ include file="../comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = new PageModel();
	int salesid = user.getId();
	List list = null;
	String pid="";
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		String parttype = request.getParameter("parttype");
		 pid = request.getParameter("pid");
		pm = QuotationAction.getInstance().getAllSample(pageNo,pageSize,pid);
		}else{
		 pm = QuotationAction.getInstance().getAllSample(pageNo,pageSize,"");
		}
	
   
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>销售报价单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	
	function printorder() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要打印的订单！");
			return;
		}
		if (count > 1) {
			alert("一次只能打印一份订单！");
			return;
		}
		window.showModelessDialog("printorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" + pid);
	}
	
	function addOrder() {
		
		window.self.location = "modifypackage.jsp";	
	}
	
	

	function topPage() {
		window.self.location = "sampleRegistration.jsp.jsp?pageNo=1&command=<%=command%>&pid=<%=pid%>";
	}
	
	function previousPage() {
		window.self.location = "sampleRegistration.jsp?pageNo=<%=pm.getPreviousPageNo()%>&command=<%=command%>&pid=<%=pid%>";
	}	
	
	function nextPage() {
		window.self.location = "sampleRegistration.jsp?pageNo=<%=pm.getNextPageNo()%>&command=<%=command%>&pid=<%=pid%>";
	}
	
	function bottomPage() {
		window.self.location = "sampleRegistration.jsp?pageNo=<%=pm.getBottomPageNo()%>&command=<%=command%>&pid=<%=pid%>";
	}
	
<%---------------------输出数据到EXCEL文档start---------------------%>
	
	<%---输出全部未完成项目到EXCEL文档---%>
	function nofinishex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出当日接单明细到EXCEL文档---%>
	function todayex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出全部未完成分包及TUV项目到EXCEL文档---%>
	function notuvex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出东莞未完成项目到EXCEL文档---%>
	function dgnoex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出迟单及迟单预警到EXCEL文档---%>
	function warnex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---输出已经完成但报告未发出到EXCEL文档---%>
	function nosendex() {
		if (window.confirm("是否确认输出数据？")) {
				window.self.location = "modifyproject.jsp";
		}
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
						<td width="1150" class="p1" height="17" nowrap>
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>LC-WS-CM-016
						</td>
						<td width="522" class="p1" height="17" nowrap>
							<b>版本号：1.0
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=sampleRegistration.jsp?command=search >
				<table width="973" border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em;" height="70">
					<tr>
						<td width="50%">
						
							<font color="red">请输入报价单号：</font>
							
							<input type=submit name=Submit value=搜索>
						
						</td>
						
					</tr>
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>

			<table width="100%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">样品列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="100%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" width="50">
						分公司
					</td>
					<td class="rd6" >
						客户公司名称
					</td>
					<td class="rd6" >
						接板日期
					</td>
					<td class="rd6" >
						测试样品
					</td>
					<td class="rd6" >
						测试项目
					</td>
					<td class="rd6" >
						报告编号
					</td>
					<td class="rd6" >
						服务类型
					</td>
					<td class="rd6" width="50">
						测试点数
					</td>
					<td class="rd6">
						送实验室时间
					</td>
					<td class="rd6">
						应出报告时间
					</td>
					<td class="rd6">
						报价单号
					</td>
					<td class="rd6">
						报价金额
					</td>
					<td class="rd6">
						付款状态
					</td>
					<td class="rd6">
						汇款日期
					</td>
					<td class="rd6">
						开票日期
					</td>
					<td class="rd6">
						销售人员
					</td>
					<td class="rd6">
						备注
					</td>
					<td class="rd6">
						报告发出日期
					</td>
				</tr>
				
				<%
				list = pm.getList();
				for(int i =0;i<list.size();i++){
				Project p=new Project();
				ChemProject cp =new ChemProject();
				Flow f=new Flow();
				p =(Project)list.get(i);
				Quotation qu =(Quotation)p.getObj();
				cp =(ChemProject)p.getObjcp();
				f=(Flow)p.getObjf();
				 %>
				
				<tr>
					
					<td class="rd8">
						<%=qu.getCompany() %>
					</td>
					<td class="rd8">
						<%=qu.getClient() %>
					</td>
					<td class="rd8">
						<%=p.getBuildtime() ==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime() ) %>
					</td>
					<td class="rd8">
						<%=cp.getSamplename() %>
					</td>
					<td class="rd8">
						<%=qu.getProjectcontent()%>
					</td>
					<td class="rd8">
						<%=p.getRid() %>
					</td>
					<td class="rd8">
						<%=p.getLevel() %>
					</td>
					<td class="rd8">
						<%=f.getTestcount() %>
					</td>
					<td class="rd8">
						<%=cp.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getCreatetime()) %>
					</td>
					<td class="rd8">
						<%=qu.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qu.getCompletetime()) %>
					</td>
					<td class="rd8">
						<%=qu.getPid()%>
					</td>
					<td class="rd8">
						<%=qu.getTotalprice()%>
					</td>
					<td class="rd8">
						<%=qu.getAdvancetype()%>
					</td>
					<td class="rd8">
						<%=qu.getPreadvance()%>
					</td>
					<td class="rd8">
						<%=qu.getInvtime()%>
					</td>
					<td class="rd8">
						<%=qu.getSales()%>
					</td>
					<td class="rd8">
						<%=qu.getTag()%>
					</td>
					<td class="rd8">
					<%=cp.getSendtime() ==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getSendtime()) %>
					</td>

				
				</tr>
				
				<%
				}
			
				 %>
				
				
			</table>
			<table width="100%" height="30" border="0" align="center"
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
			
			<br>
	<div align="center">
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="打印订单" onClick="printorder()">
	</div>
	<div align="center">
		生效日期：
	</div>
		
	</body>
</html>
