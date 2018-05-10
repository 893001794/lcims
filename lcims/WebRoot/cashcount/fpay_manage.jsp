<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.vo.Fpay"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	String supplier = request.getParameter("supplier");
	String remarks = request.getParameter("remarks");
	String person = request.getParameter("person");
	//String dpaytime = request.getParameter("dpaytime");
	String startDpaytime = request.getParameter("startDpaytime");
	String endDayTiem = request.getParameter("endDayTiem");
	Fpay pay =new Fpay();
	PageModel pm = null;
	pay.setPageNo(pageNo);
	pay.setPageSize(pageSize);
	pay.setSupplier(supplier);
	pay.setRemarks(remarks);
	pay.setPerson(person);
	pay.setStartDpaytime(startDpaytime);
	pay.setEndDayTiem(endDayTiem);
	pm = DaoFactory.getInstance().getFpay().searchFpays(pay);
	if (pm == null) {
		pm = new PageModel();
	}
	session.setAttribute("fPay",pay);
%>

<html>
	<head>
		<title>支出申请表</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css" media="screen">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<script language="JavaScript" type="text/JavaScript">
	function delpay()
	{
	   if(confirm("确定要删除此吗？"))
	     return true;
	   else
	     return false;	 
	}

	function changeStatus() {
			var  myform =document.getElementById("form1");
			myform.method = "post";
			myform.action = "quotation_manage.jsp";
			myform.submit();
	}
	
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}
	
	function exportToExcel() {
	if(confirm("确定导出?")) {
		window.self.location = "../fpayExport";
	}
}
</script>
		<%--@ include file="date.jsp" --%>
	</head>
	<body text="#000000" topmargin=0>
		<form name="form1" id ="form1" method="post" action="fpay_manage.jsp?">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th height="25">
						供应商
					</th>
					<th>
						销售
					</th>
					<th>
						备注
					</th>
					<th>
						支出日期
					</th>
					<th>
						&nbsp;
					</th>
				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=supplier type="text" id="supplier" size="35" maxlength="100" value="">
						<script>   
						        $("#supplier").autocomplete("../client_ajax.jsp",{
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
						<input name=person type="text" id="person" size="20" maxlength="50" value="">
					</td>
					<td>
						<input name=remarks type="text" id="remarks" size="20" maxlength="50" value="">
					</td>
					<td>
						<input type="text" id ="startDpaytime"  name ="startDpaytime" size="31" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'startDpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">至
						<input type="text" id ="endDayTiem"  name ="endDayTiem" size="31" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'endDayTiem'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
								
					</td>
					
					<td>
						<input type="submit" name="Submit" value="查询">
						&nbsp;&nbsp;
						<input name="export" value="导出到Excel" type="button" onClick="exportToExcel();" />
					</td>
				</tr>
			</table>
		</form>
		<table width="200%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th colspan="2">
					<a href="fpay.jsp" style="color: blue">新增</a>
				</th>
				<th height="25" colspan="27">
					申请清单搜索结果
				</th>
			</tr>
			<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<td height="25" class=forumrow>
					<div align="center">
						ID
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 100px">
						操作
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 70px">
						支付日期
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 70px">
						部门
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 200px">
						供应商
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 200px">
						摘要
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 80px">
						人员
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 50px">
						化学
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 50px">
						安全
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 50px">
						光性能
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width: 60px">
						EMC联营
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width:60px">
						EMC暗室
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width: 60px">
						大客户部
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width:60px">
						环境部
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width: 60px">
						总经办
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width: 60px">
						财务部
					</div>
				</td>
				<td class=forumrow >
					<div align="center"  style="width: 60px">
						行政部
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 60px">
						工程部
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 60px">
						小计
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 80px">
						账号名称
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 80px">
						票据类型
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 80px">
						发票号码
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 200px">
						备注
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 100px">
						一级科目
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 100px">
						二级科目
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 100px">
						三级科目
					</div>
				</td>
				<td class=forumrow>
					<div align="center" style="width: 100px">
						出差地区
					</div>
				</td>
				<td class=forumrow >
					<div align="center" style="width: 100px">
						招待客户
					</div>
				</td>
				
			</tr>

			<%
				List<Fpay> list = pm.getList();
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						Fpay fpay = list.get(i);
			%>
			<tr>
				<td height="25">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=fpay.getId()%>">
					</td>
				<td height="25">
					<div align="center">
						<%=i%>
					</div>
				</td>
				<td>
					<div align="center">
						 <a href="editfpay.jsp?id=<%=fpay.getId()%>" style="color: blue">修改</a>
					</div>
				</td>
				<td height="25">
					<div align="center">
						<%=fpay.getDpaytime()%></font>
					</div>
				</td>
				<td>
					<div align="center">
						<%=fpay.getDept()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=fpay.getSupplier()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=fpay.getSummay()%>
					</div>
				</td>
				<td>
					<div align="center"">
						<%=fpay.getPerson()%>
					</div>
				</td>
				<td>
					<div align="right">
						<%= fpay.getChem()!=null && fpay.getChem()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getChem()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getSafe()!=null && fpay.getSafe()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getSafe()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getOp()!=null && fpay.getOp()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getOp()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getEmc()!=null && fpay.getEmc()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getEmc()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getDr()!=null && fpay.getDr()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getDr()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getVip()!=null && fpay.getVip()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getVip()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getEq()!=null && fpay.getEq()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getEq()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getGmo()!=null && fpay.getGmo()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getGmo()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getFinance()!=null && fpay.getFinance()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getFinance()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getAdministration()!=null && fpay.getAdministration()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getAdministration()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getEngineering()!=null && fpay.getEngineering()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getEngineering()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getTotal()!=null && fpay.getTotal()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getTotal()):""%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getAccount()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getEinvtype()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getInvoiceno()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=fpay.getRemarks()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getOnelevelsub()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getTwolevelsub()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getThreelevelsub()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getTravel()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%= fpay.getEntertain()%>
					</div>
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
							href="fpay_manage.jsp?pageNo=1&supplier=<%=supplier%>&remarks=<%=remarks%>&person=<%=person%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>"
							class="red">首页</a>
						<a
							href="fpay_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&supplier=<%=supplier%>&remarks=<%=remarks%>&person=<%=person%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>"
							class="red">上一页</a>
						<a
							href="fpay_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&supplier=<%=supplier%>&remarks=<%=remarks%>&person=<%=person%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>"
							class="red">下一页</a>
						<a
							href="fpay_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&supplier=<%=supplier%>&remarks=<%=remarks%>&person=<%=person%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>"
							class="red">末页</a>
					</div>
				</td>
			</tr>
		</table>
</body>