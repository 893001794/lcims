<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.text.DecimalFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	UserForm user = (UserForm)session.getAttribute("user");
	List<Project> list = new ArrayList<Project>();
	Quotation qt = new Quotation();
	String pid = null;
	if (command != null && "search".equals(command)) {
		pid = request.getParameter("pid").trim();
		if(!(pid == null || "".equals(pid))) {
			list = ProjectAction.getInstance().getAllProjectByPid(pid);
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
		}
	}
	
%>

<html>
<head>
<title>项目管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<link rel="stylesheet" href="../../css/css1.css" type="text/css" media="screen">
<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
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
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>项目管理&gt;&gt;项目列表</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>
			<form name=search method=post action="project_manage.jsp?command=search" autocomplete="off">

				<table width=100% border=0 cellspacing=5 cellpadding=5
					style="margin-left: 13em">
					<tr>
						<td valign=middle width=50%>
							<font color="red">请输入报价单号：</font>
							<input id="pid" type="text" name="pid" size="40" />
							<input type=submit name=Submit value=搜索>
							<%
							
							if(!user.getName().equals("郑妙芳")){
							
							%>
							 <script>   
						        $("#pid").autocomplete("../../pid_ajax.jsp",{
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
<%} %>
						</td>

					</tr>
					
				</table>
			</form>


			<hr width="97%" align="center" size=0>
			<form name="userform" id="userform">
		</div>

<table width="98%" border="1" cellpadding="2" cellspacing="0" align="center" class=TableBorder> 
<tr > 
    <th style="background-color: #088A4B;font-size: 15px">报价单编号</th>
    <th style="background-color: #088A4B;font-size: 15px">客户名称</th>
  </tr>
  <tr align="center">
  	<td style="background-color: #E6E6E6;font-size: 15px"><%=qt.getPid()==null?"":qt.getPid() %></td>
  	<td style="background-color: #E6E6E6;font-size: 15px"><%=qt.getClient()==null?"":qt.getClient() %></td>
  </tr>
  </table>
<p>&nbsp;</p>
<table width="98%" border="1" cellpadding="2" cellspacing="0" align="center" class=TableBorder> 
<tr height="22" valign="middle" align="center"> 
    <th height="25" colspan="11">项目搜索结果</th>
  </tr>
  <tr> 
    <td  height="25" class=forumrow><div align="center">ID</div></td>
    <td  class=forumrow><div align="center">内部对账单号</div></td>
    <td  class=forumrow><div align="center">报告编号</div></td>
    <td  class=forumrow> <div align="center">项目类型</div></td>
    <td  class=forumrow> <div align="center">应出报告时间</div></td>
    <td class=forumrow> <div align="center">分项目金额(元)</div></td>
    <td  class=forumrow><div align="center">分公司</div></td>
    <td  class=forumrow><div align="center">立项人员</div></td>
    <td  class=forumrow> <div align="center">项目等级</div></td>
    <td  class=forumrow> <div align="center">状态</div></td>
    <td  class=forumrow> <div align="center">操作</div></td>
  </tr>
  
  <%
  	for(int i=0;i<list.size();i++) {
  		Project p = list.get(i);
		String status = "";
		Date rptime = null;
		if(!("化学测试".equals(p.getPtype())||"化妆品".equals(p.getPtype()))) {
			PhyProject pp = (PhyProject)p.getObj();
			rptime = pp.getRptime();
			status = pp.getStatus();
		} else {
			ChemProject cp = (ChemProject)p.getObj();
			rptime = cp.getRptime();
			status = cp.getStatus();
		}
   %>
  
   <tr>
    <td height="25"><div align="center">
    <%=i+1 %>
    </div></td>
    <td height="25"><div align="center">
   <a href="projectdetail.jsp?sid=<%=p.getSid() %>&ptype=<%=URLEncoder.encode(p.getPtype(),"UTF-8") %>"><font color="red"><%=p.getSid() %></font></a>
	</div></td>
    <td height="25"><div align="center">
   <%=p.getRid() %>
	</div></td>
    <td><div align="center">
	<%=p.getPtype() %>
    </div></td>
    <td><div align="center">
    <%=rptime %>
    </div></td>
    <td><div align="right">
    <font color="red"><%=p.getPrice()==0?"0.00":new DecimalFormat("##,###,###,###.00").format(p.getPrice()) %></font>
    </div></td>
    <td><div align="center">
    <%=qt.getCompany() %>
    </div></td>
    <td><div align="center">
    <%=p.getBuildname() %>
    </div></td>
    <td><div align="center">
    <%=p.getLevel()==null?"":p.getLevel() %>
    </div></td>
    <td><div align="center">
    <font color="red"><%=status %></font>
    </div></td>
        <td><div align="center">
        
        <%
        if(p.getPacount() == 0) {
         %>
        
    <a href="projectlog.jsp?sid=<%=p.getSid() %>&ptype=<%=URLEncoder.encode(p.getPtype(),"UTF-8") %>" style="color: blue">实际</a>
    
    	<%
    	} else {
    	 %>
    <a href="projectdetail.jsp?sid=<%=p.getSid() %>&ptype=<%=p.getPtype() %>" style="color: blue">查看</a>
    	 <%
    	 }
    	  %>
    </div></td>
  </tr>
  
  <%
  }
   %>

   <tr style="background-color: #E0F8E0">
     <td height="25" colspan="11" align="left"><div align="center">记录总条数： 当前页/总页数
	  <a href="" class="red">首页</a>
	  <a href="" class="red">上一页</a>
	   <a href="" class="red">下一页</a>
	    <a href="" class="red">末页</a> 
	    </div>
	    </td>
   </tr>
   <tr style="background-color: #E0F8E0">
	     <td height="25" colspan="15" align="left"><div align="center">
	     	<a href="javascript:history.go(-2);">返回</a>
	    </td>
   </tr>
</table>
