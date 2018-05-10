<%@page import="com.lccert.crm.vo.Fincome"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	String vpid = request.getParameter("vpid");
	String client = request.getParameter("client");
	String startDpaytime = request.getParameter("startDpaytime");
	String endDayTiem = request.getParameter("endDayTiem");
	String startCreatetime = request.getParameter("startCreatetime");
	String endCreatetime = request.getParameter("endCreatetime");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	Fincome fincome =new Fincome();
	PageModel pm = null;
	fincome.setPageNo(pageNo);
	fincome.setPageSize(pageSize);
	fincome.setVpid(vpid);
	fincome.setClient(client);
	fincome.setStartDpaytime(startDpaytime);
	fincome.setEndDayTiem(endDayTiem);
	fincome.setStartCreatetime(startCreatetime);
	fincome.setEndCreatetime(endCreatetime);
	pm = DaoFactory.getInstance().getFincome().searchFincomes(fincome);
	if (pm == null) {
		pm = new PageModel();
	}
	session.setAttribute("fincome",fincome);
%>

<html>
	<head>
		<title>收入申请表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css" media="screen">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<script type="text/javascript">
			function exportToExcel() {
				if(confirm("确定导出?")) {
					window.self.location = "../finComeExport";
				}
			}
		</script>
	</head>
	<body  topmargin=0>
		<form name="form1" id ="form1" method="post" action="fincome_manage.jsp?type=1">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th height="25">
						报价单号
					</th>
					<th>
						客户名称
					</th>
					<th>
						收款日期
					</th>
					<th>
						录入日期
					</th>
					<th>
						&nbsp;
					</th>
				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=vpid type="text" id="vpid" size="18" maxlength="50" value="">
					</td>
					<td>
						<input name=client type="text" id="client" size="20" maxlength="100" value="">
						<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
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
						<input type="text" id ="startDpaytime"  name ="startDpaytime" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'startDpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">至
						<input type="text" id ="endDayTiem"  name ="endDayTiem" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'endDayTiem'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
					</td>
					<td>
					
						<input type="text" id ="startCreatetime"  name ="startCreatetime" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'startCreatetime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">至
						<input type="text" id ="endCreatetime"  name ="endCreatetime" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'endCreatetime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
					</td>
					<td>
						<input type="submit" name="Submit" value="查询">&nbsp;
						<input name="export" value="导出到Excel" type="button" onClick="exportToExcel();" />
					</td>
				</tr>
			</table>
		</form>
	<table width="130%" border="0" cellpadding="0" cellspacing="1" 
		align="center" >
		<tr height="22" valign="middle" align="center">
			<th height="25" colspan="27">
				申请清单搜索结果
			</th>
		</tr>
		<tr >
			<td ><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
			<td height="25" class=forumrow>
				<div align="center" >
					ID
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px ;">
					操作
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 70px">
					收款日期
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 150px">
					客户名称
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 20px">
					年份
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 15px">
					月份
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					报价单号
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px">
					所属部门
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px">
					销售人员
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px">
					化学
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					安全
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width:60px">
					光性能
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					EMC联营
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width:60px">
					EMC暗室
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					大客户部
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					环境部
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					财务部
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 60px">
					广州公司
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 60px">
					小计
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					账号名称
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					票据类型
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					票据号码
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 100px ;">
					备注
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 60px">
					省份
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px ;">
					地区
				</div>
			</td>
			
		</tr>

		<%
			List<Fincome> list = pm.getList();
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					fincome = list.get(i);
		%>
		<tr >
			<td height="25">
					<input type="checkbox" name="selectFlag" class="checkbox1"
						value="<%=fincome.getId()%>">
				</td>
			<td height="25" align="center">
					<%=i%>
			</td>
			
			<td align="center">
					 <a href="editfincome.jsp?id=<%=fincome.getId()%>" style="color: blue">修改</a>
			</td>
			<td height="25" align="center">
					<%=fincome.getDpaytime()==null?"&nbsp;":fincome.getDpaytime()%></font>
			</td>
			<td align="center">
					<%=fincome.getClient() ==null?"&nbsp;":fincome.getClient()%>
			</td >
			<td align="center">
				<%=fincome.getVpyear() ==null?"&nbsp;":fincome.getVpyear()%>
			</td>
			<td align="center">
					<%=fincome.getVpmonth()==null?"&nbsp;":fincome.getVpmonth()%>
			</td>
			<td align="center">
					<%=fincome.getVpid()==null?"&nbsp;":fincome.getVpid()%>
			</td>
			<td align="center"> 
					<%=fincome.getDept()==" "?"&nbsp;":fincome.getDept()%>
			</td>
			<td align="center">
					<%=fincome.getSales()==null?"&nbsp;":fincome.getSales()%>
			</td>
			<td align="center">
					<%= fincome.getChem()!=null && fincome.getChem()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getChem()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getSafe()!=null && fincome.getSafe()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getSafe()):"&nbsp;"%>
			</td align="center">
			<td align="center">
					<%= fincome.getOp()!=null && fincome.getOp()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getOp()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getEmc()!=null && fincome.getEmc()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getEmc()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getDr()!=null && fincome.getDr()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getDr()):"&nbsp;"%>
			</td>
			<td>
				<div align="center">
					<%= fincome.getVip()!=null && fincome.getVip()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getVip()):"&nbsp;"%>
				</div>
			</td>
			<td align="center">
					<%= fincome.getEq()!=null && fincome.getEq()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getEq()):"&nbsp;&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getFinance()!=null && fincome.getFinance()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getFinance()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getGz()!=null && fincome.getGz()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getGz()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getTotal()!=null && fincome.getTotal()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getTotal()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getAccount()==null?"&nbsp;":fincome.getAccount()%>
			</td>
			<td align="center">
					<%= fincome.getEinvtype()==null?"&nbsp;": fincome.getEinvtype()%>
			</td>
			<td align="center">
					<%=fincome.getEinvno()==null?"&nbsp;":fincome.getEinvno()%>
			</td>
			<td align="center">
					<%=fincome.getRemarks()==null?"&nbsp;":fincome.getRemarks()%>
			</td>
			
			<td align="center">
					<%= fincome.getProvince()==null?"&nbsp;":fincome.getProvince()%>
			</td>
			<td align="center">
					<%=fincome.getCity()==null?"&nbsp;":fincome.getCity()%>
			</td>
			
		</tr>
		<%
		}
		}
		%>
		<tr style="background-color: #E0F8E0">
			<td height="25" colspan="27" align="left">
				<div align="center">
					记录总条数：<%=pm.getTotalRecords()%>
					当前页/总页数:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
					<a
						href="fincome_manage.jsp?pageNo=1&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">首页</a>
					<a
						href="fincome_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">上一页</a>
					<a
						href="fincome_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">下一页</a>
					<a
						href="fincome_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">末页</a>
				</div>
			</td>
		</tr>
	</table>
</body>