<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.text.DecimalFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 10;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = null;
	String pid = request.getParameter("pid");
	FinanceQuotationUtil fqu = new FinanceQuotationUtil();
	fqu.setPid(pid==null?"":pid); 
	fqu.setPageNo(pageNo);
	fqu.setPageSize(pageSize);
	pm = FinanceQuotationAction.getInstance().searchQuotations(fqu,null);
 %>

<html>
<head>
<title>审核订单</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<link rel="stylesheet" href="../css/css1.css" type="text/css" media="screen">
<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
<script language="JavaScript" type="text/JavaScript">
function delpay()
{
   if(confirm("确定要删除此吗？"))
     return true;
   else
     return false;	 
}
</script>
</head>

<body text="#000000" topmargin=0>

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
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>客服管理&gt;&gt;审核项目</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>
			<form name=search method=post action="quotation_confirm.jsp" autocomplete="off">

				<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=project_finance_manage.jsp
							autocomplete="off">
							<input type="hidden" name="command" value="search" />
							<font color="red">请输入报价单号：</font>
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=搜索>
							 <script>   
						        $("#pid").autocomplete("../pid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>   
							<input type="hidden" name=type size="25" value="all" />

						</form>
					</td>
				</tr>

			</table>
			</form>


			<hr width="97%" align="center" size=0>
		</div>



<table width="98%" border="0" cellpadding="2" cellspacing="0" align="center" class=TableBorder> 
<tr height="22" valign="middle" align="center"> 
    <th height="25" colspan="9">报价清单搜索结果</th>
  </tr>
  <tr> 
    <td width="3%" height="25" class=forumrow><div align="center">ID</div></td>
    <td width="10%" class=forumrow><div align="center">报价单号</div></td>
    <td width="20%" class=forumrow> <div align="center">客户名称</div></td>
    <td width="13%" class=forumrow> <div align="center">客户要求时间</div></td>
    <td width="10%" class=forumrow> <div align="center">报价金额(元)</div></td>
    <td width="7%" class=forumrow><div align="center">收款方式</div></td>
    <td width="7%" class=forumrow> <div align="center">销售代表</div></td>
    <td width="10%" class=forumrow> <div align="center">状态</div></td>
    <td width="10%" class=forumrow> <div align="center">操作</div></td>
  </tr>
  
  <%
  	List<Quotation> list = pm.getList();
  	for(int i=0;i<list.size();i++) {
  		Quotation qt = list.get(i);
  %>
  
   <tr>
    <td height="25"><div align="center">
    <%=i+1 %>
    </div></td>
    <td height="25"><div align="center">
   <%=qt.getPid() %>
	</div></td>
    <td><div align="center">
	<%=qt.getClient() %>
    </div></td>
    <td><div align="center">
    <%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime()) %>
    </div></td>
    <td><div align="right">
    <%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>
    </div></td>
    <td><div align="center">
    <%=qt.getAdvancetype() %>
    </div></td>
    <td><div align="center">
    <%=qt.getSales() %>
    </div></td>
    <td><div align="center">
    <font color="red"><%=qt.getAudit() %></font>
    </div></td>
        <td><div align="center">
    <%
    if("未审核".equals(qt.getAudit())) {
     %>    
    <a href="confirm.jsp?pid=<%=qt.getPid() %>" style="color: blue">审核</a>
    <%
    }
     %>
    </div></td>
  </tr>
	<%
	}
	 %>
   <tr style="background-color: #E0F8E0">
     <td height="25" colspan="10" align="left"><div align="center">记录总条数：<%=pm.getTotalRecords() %> 当前页/总页数:<%=pm.getPageNo() %>/<%=pm.getTotalPages() %>
	  <a href="project_confirm.jsp?pageNo=1&pid=<%=fqu.getPid() %>" class="red">首页</a>
	  <a href="project_confirm.jsp?pageNo=<%=pm.getPreviousPageNo() %>&pid=<%=fqu.getPid() %>" class="red">上一页</a>
	   <a href="project_confirm.jsp?pageNo=<%=pm.getNextPageNo() %>&pid=<%=fqu.getPid() %>" class="red">下一页</a>
	    <a href="project_confirm.jsp?pageNo=<%=pm.getBottomPageNo() %>&pid=<%=fqu.getPid() %>" class="red">末页</a> 
	    </div>
	    </td>
   </tr>
</table>

