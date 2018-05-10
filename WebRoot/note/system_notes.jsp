<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.user.UserForm"%> 
<%@ page errorPage="error.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.system.CategoryAction"%>
<%@page import="com.lccert.crm.system.Category"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@ include file="../comman.jsp"  %>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@page import="com.lccert.crm.system.Forum"%>

<%
    PageModel pm = null;
    PageModel pm1 = null;
     PageModel pm2 = null;
	String status = "";
	int pageNo = 1;
	int pageNo1 = 1;
	int pageSize = 75;
	String dept =user.getDept().substring(0,2);
	
	String StrPageNo = request.getParameter("pageNo");
	
	if(StrPageNo != null && !"".equals(StrPageNo)) {
		try {
			pageNo = Integer.parseInt(StrPageNo);
		} catch (NumberFormatException e) {
			pageNo = 1;
		}
	}
	
	String StrPageNo1 = request.getParameter("pageNo1");
	if(StrPageNo1 != null && !"".equals(StrPageNo1)) {
		try {
			pageNo1 = Integer.parseInt(StrPageNo1);
		} catch (NumberFormatException e) {
			pageNo1 = 1;
		}
	}
	String type =request.getParameter("type");
	String command = request.getParameter("command");
	if (command != null && "search".equals(command)) {
		 status = request.getParameter("status");
		pm = ForumAction.getInstance().getNotes(pageNo,pageSize,status);
	} else {
		pm = ForumAction.getInstance().getNotes(pageNo,pageSize,"");
	}
		pm1=DaoFactory.getInstance().getChemProjectDao().getChemProject(pageNo1,pageSize,user.getName(),dept,0,type);
	 
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>系统公告</title>
		<link rel="stylesheet" href="../css/drp.css">
		
		<style type="text/css">
		
		#short {
width:400px;
white-space:nowrap;
text-overflow:ellipsis; 
-o-text-overflow:ellipsis; 
overflow: hidden;
}
		
		
		</style>
		
		<script type="text/javascript">
	
	function addNotes() {
		
		window.self.location = "addnotes.jsp";	
	}
	
	function modifyNotes() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要修改的客户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条客户数据！");
			return;
		}
	
		window.self.location = "modifynotes.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteNotes() {
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
				action = "deletenotes.jsp"
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
		window.self.location = "system_notes.jsp?pageNo=1";
	}
	
	function previousPage(obj) {
	
	if(obj == 1){
		window.self.location = "system_notes.jsp?pageNo=<%=pm.getPreviousPageNo() %>&status=<%=status%>";
		}else{
		window.self.location = "system_notes.jsp?pageNo1=<%=pm1.getPreviousPageNo()%>&type=<%=type%>";
		}
	}	
	
	function nextPage(obj) {
	if(obj == 1){
		window.self.location = "system_notes.jsp?pageNo=<%=pm.getNextPageNo() %>&status=<%=status%>";
		}else{
		window.self.location = "system_notes.jsp?pageNo1=<%=pm1.getNextPageNo()%>&type=<%=type%>";
		}
	}
	
	function bottomPage(obj) {
	if(obj == 1){
		
		window.self.location = "system_notes.jsp?pageNo=<%=pm.getBottomPageNo() %>&status=<%=status%>";
		}else{
		
		window.self.location = "system_notes.jsp?pageNo1=<%=pm1.getBottomPageNo()%>&type=<%=type%>";
		}
	}
	
function changeStatus() {
		with (document.getElementById("userform")) {
			method = "post";
			action = "system_notes.jsp";
			submit();
		}
	}
	
	function showAllDialog() {
	window.showModalDialog("addressBook_manage.jsp" ,"","dialogWidth:1000px;dialogHeight:700px");
	}
	
	function showdialog(sid) {
		window.showModalDialog("../chemistry/projectstatus.jsp?sid="+sid,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	function reportInfor(obj){
		document.getElementById("type").value=obj;
		var userform =document.getElementById("userform");
		userform.action ="system_notes.jsp";
		userform.submit();
   }
</script>
	</head>

	<body class="body1">
		<form name="userform" id="userform">
		<input type="hidden" name="command" value="search">
		<input type="hidden" name="type">
		<br>
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					
					<tr align="center">
						<td >
							<h1><b>系统公告</b></h1>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
			
			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						
							<font color="red">&nbsp;&nbsp;&nbsp;公告类型：&nbsp;&nbsp;&nbsp;</font>
							<select name="status" style="width: 300px" onchange="changeStatus()">
								<option value="">
									公共
								</option>
								<%
							
										List  list =CategoryAction.getInstance().getCategory();
										for(int i=0;i<list.size();i++){
										Category cate=(Category)list.get(i);
										%>
										
										<option value="<%=cate.getId() %>">
									    <%=cate.getName() %>
								</option>
										<%
										}
										 %>
							</select>
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
						[<a href="javascript:showAllDialog()">通讯录</a>]
					</td>
				</tr>

			</table>
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">公告列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" width="2%">
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6">
						标题
					</td>
					<td class="rd6">
						内容
					</td>
					<td class="rd6">
						发帖人/时间
					</td>
					<td class="rd6" width="250px">
						操作
					</td>
				</tr>
				
				<%
					List<Forum> list1 = pm.getList();
					for(int i=0;i<list1.size();i++) {
						Forum fr = list1.get(i);
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=fr.getId() %>">
					</td>
					<td class="rd8">
					<%
					String str="";
					if(fr.getHead().length()>15){
					str=fr.getHead().substring(0,10);
					str+="...";
					}else{
					str=fr.getHead();
					}
					 %>
						<a href="notesdetail.jsp?id=<%=fr.getId() %>"><%=str%></a>&nbsp;
					
					<%
					if(i<3) {
					 %>
						<img src="../images/new00.gif" width="33" height="10" border="0">
					<%
					}
					 %>
					</td>
					<td class="rd8">
						<div id="short"><a href="notesdetail.jsp?id=<%=fr.getId() %>"><%=fr.getContent() %></a></div>
					</td>
					<td class="rd8">
						<%=fr.getCreatename() %>/<%=fr.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(fr.getCreatetime()) %>
					</td>
					<td class="rd8">
						<%if(fr.getImagepath() == null || "".equals(fr.getImagepath())){
						%>
						<a href="../uploadfile/uploadfile.jsp?id=<%=fr.getId() %>">上传</a>
						<%
						} %>
						
						<a href="../uploadfile/download.jsp?id=<%=fr.getId() %>">下载</a>
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
								onClick="previousPage(1)">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="下页" onClick="nextPage(1)">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="尾页"
								onClick="bottomPage(1)">
								
						<%
						if(user.getJob().indexOf("经理")>0||"admin".equals(user.getName()) || user.getId()==85) {
						 %>
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="添加" onClick="addNotes()">
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改" onClick="modifyNotes()">
							<input name="btnDelete" class="button1" type="button"
								id="btnDelete" value="删除" onClick="deleteNotes()">
								
						<%
						}
						 %>
								
						</div>
					</td>
				</tr>
			</table>
			<br><br><br>
			<%
			if(user.getLatelisttype().equals("y")){
				if(user.getLatelisttype().equals("y")&& dept.equals("客服")){
				dept="";
				}
				%>
				
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">项目状态列表栏</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"><input type="button" value="明天报告" onclick="reportInfor('tomorrow')">&nbsp;&nbsp;&nbsp;<input type="button" value="历史迟单" onclick="reportInfor('history')"><input type="button" value="今天已出报告" onclick="reportInfor('date')"></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
			<tr>
					
					<td class="rd6">
						报价单号
					</td>
					<td  class="rd6"  >
						报告号
					</td>
					<td class="rd6"  width="128px">
						应出报告时间
					</td>
					<td  class="rd6" width="80px">
						项目完成时间
					</td>
					<td class="rd6" width="90px">
						电子档发送时间
					</td>
					<td class="rd6" width="250px">
						客服
					</td>
					<td class="rd6" width="250px">
						销售
					</td>
					<td class="rd6" width="250px">
					客户名称
					</td>
					<td class="rd6" width="250px">
						项目状态
					</td>
					<td class="rd6" width="250px">
						状态
					</td>
										
				</tr>
				
				<%
				
				pm1=DaoFactory.getInstance().getChemProjectDao().getChemProject(pageNo1,pageSize,user.getName(),dept,0,type);
					List<ChemProject> list2 = pm1.getList();
					//System.out.println(list2.size());
					for(int i=0;i<list2.size();i++) {
						ChemProject cp = list2.get(i);
				 %>
				<tr>
					<td class="rd8">
					<span <%=cp.getPaystatus()!=null&&cp.getPaystatus().equals("n")?"style='color: black'":"style='color: green'"%> ><%=cp.getPid()%></span>
					</td>
					<td class="rd8" width="60px">
					<a href="javascript:showdialog('<%=cp.getSid()%>');"><%=cp.getRid()%></a>
					</td>
					<td class="rd8" width="128px">
					<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>
					<td class="rd8" width="80px">
					<%=cp.getEndtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime()) %>
					</td>
					<td class="rd8" width="80px">
					<%=cp.getGranttime()==null?"":cp.getGranttime() %>
					</td>
					<td class="rd8" width="50px">
						<%=cp.getServname() %>
					</td>
					<td class="rd8" width="50px">
						<%=cp.getSales() %>
					</td>
					<td class="rd8" width="250px">
					
						<span <%=cp.getPay()!=null&&cp.getPay().equals("月结")?"style='color: red'":""%> ><%=cp.getClient()%></span>
					</td>
					<td class="rd8">
						<%=cp.getStatus()%>
					</td>
					<%
						String hours="";
						String severityL="";
						String color="";
						Date eDate=null;
						DecimalFormat df = new DecimalFormat("0.00");
						//double d = 123.9078; 
						//double db = df.format(d);
						
						//long a=-3600;
						if(cp.getEndtime() ==null){
						eDate=new Date();
						}else{
						eDate=cp.getEndtime();
						}
						SimpleDateFormat d= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
						String nowtime=d.format(eDate);//按以上格式 将当前时间转换成字符串
						long result = 0;
						result = (d.parse(nowtime).getTime()-d.parse(cp.getRptime().toString()).getTime())/1000;
						String d1=df.format(result/3600);
						
						//long a =df.format(result/3600);
						
						
						
						//当前时间减去测试时间   这个的除以1000得到秒，相应的60000得到分，3600000得到小时
						  //System.out.println("当前时间减去测试时间="+result/3600+"小时");
						  if(cp.getEndtime() ==null){
						  if(result/3600>=2){
						  severityL="严重迟单";
						  %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>  
						  <%
						  }
						  else if(0<=result/60&result/60<120){
						  severityL="迟单";
						   %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>    
						 <% }
						  
						 else if(-120<=(result/60)&(result/60)<0){
						  //  System.out.println("当前时间减去测试时间="+result/60+"分钟");
						    severityL =result/60+"分后迟单";
						  //  System.out.println(severityL.substring(1,severityL.length()));
						     %>
						   <td class="rd8" style="color:blue">    
							<%=severityL.substring(1,severityL.length()) %>
						  </td>  
						  <% 
						  }
						  }
						  //如果测试完成时间不为Null，并且完成的时间小于应出报告的时间的时候
						  if(cp.getEndtime() !=null ){
						//  System.out.println(d.parse(cp.getEndtime().toString()).getTime());
						  //System.out.println(d.parse(cp.getEndtime().toString()).getTime());
						  
						  if(result/3600>=2){
						  severityL="严重迟单";
						  %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>  
						  <%
						  }
						  else if(d.parse(cp.getEndtime().toString()).getTime()< d.parse(cp.getRptime().toString()).getTime()){
						  severityL=cp.getStatus();
						  %>
						  <td class="rd8" style="color:black">    
							<%=severityL %>
						  </td>  
						  <% 
						  }
						  else if(0<=result/3600&result/3600<2){
						  severityL="迟单";
						   %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>    
						 <% }
						  else{
						   %>
						  <td class="rd8" style="color:black">    
							<%=severityL%>
						  </td>                                 
						  <%
						  }
						  }   
						  
						 %>
					 
							
				</tr>
				<%
				}
				 %>
				
				
				
				
				<%
				if(type ==null){
				pm2=DaoFactory.getInstance().getChemProjectDao().getChemProject(pageNo1,pageSize,user.getName(),dept,1,type);
				//System.out.println(pm);
					List<ChemProject> list3 = pm2.getList();
					//System.out.println(list3.size());
					for(int i=0;i<list3.size();i++) {
						ChemProject cp = list3.get(i);
				 %>
				
				<tr>
					
					<td class="rd8">
					<span <%=cp.getPaystatus()!=null&&cp.getPaystatus().equals("n")?"style='color: black'":"style='color: green'"%> ><%=cp.getPid()%></span>
					</td>
					<td class="rd8" width="10%">
					<a href="javascript:showdialog('<%=cp.getSid()%>');"><%=cp.getRid()%></a>
					</td>
					<td class="rd8" width="15%">
					<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>
					</td>
					<td class="rd8" width="15%">
					<%=cp.getEndtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime()) %>
					</td>
					<td class="rd8" width="80px">
						<%=cp.getGranttime()==null?"":cp.getGranttime()%>
						
					</td>
					<td class="rd8">
						<%=cp.getServname() %>
					</td>
					<td class="rd8">
						<%=cp.getSales() %>
					</td>
					<td class="rd8" width="20%">
						<span <%=cp.getPay()!=null&&cp.getPay().equals("月结")?"style='color: red'":""%> ><%=cp.getClient()%></span>
					</td>
					<td class="rd8">
						<%=cp.getStatus()%>
					</td>
					<%
						String hours="";
						String severityL="";
						String color="";
						Date eDate=null;
						if(cp.getEndtime() ==null){
						eDate=new Date();
						}else{
						eDate=cp.getEndtime();
						}
						SimpleDateFormat d= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
						String nowtime=d.format(eDate);//按以上格式 将当前时间转换成字符串
						long result = 0;
						result = (d.parse(nowtime).getTime()-d.parse(cp.getRptime().toString()).getTime())/1000;
						if(cp.getEndtime() ==null){
						//当前时间减去测试时间   这个的除以1000得到秒，相应的60000得到分，3600000得到小时
						  //System.out.println("当前时间减去测试时间="+result/3600+"小时");
						  if(result/3600>=2){
						  severityL="严重迟单";
						  %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>  
						  <%
						  }
						  //有问题的else if(0<=result/3600&result/3600<2){
						 else if(0<=result/60&result/60<7200){
						  severityL="迟单";
						   %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>    
						 <% }
						 else if(-120<=(result/60)&(result/60)<0){
						  //  System.out.println("当前时间减去测试时间="+result/60+"分钟");
						    severityL =result/60+"分后迟单";
						  //  System.out.println(severityL.substring(1,severityL.length()));
						     %>
						   <td class="rd8" style="color:blue">    
							<%=severityL.substring(1,severityL.length()) %>
						  </td>  
						  <% 
						  }
						  }
						  //如果测试完成时间不为Null，并且完成的时间小于应出报告的时间的时候
						  if(cp.getEndtime() !=null ){
						  if(result/3600>=2){
						  severityL="严重迟单";
						  %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>  
						  <%
						  }
						 else if(d.parse(cp.getEndtime().toString()).getTime()< d.parse(cp.getRptime().toString()).getTime()){
						  severityL=cp.getStatus();
						  %>
						  <td class="rd8" style="color:black">    
							<%=severityL %>
						  </td>  
						  <% 
						  }
						  else if(0<=result/3600&result/3600<2){
						  severityL="迟单";
						   %>
						   <td class="rd8" style="color:red">    
							<%=severityL %>
						  </td>    
						  <td class="rd8" style="color:black">    
							&nbsp;
						  </td> 
						 <% }
						  else{
						   %>
						  <td class="rd8" style="color:black">    
							<%=severityL%>
						  </td>  
						  <td class="rd8" style="color:black">    
							&nbsp;
						  </td>                                   
						  <%
						  }
						  }   
						 %>
				</tr>
				<%
				}
			}
				 %>
				
			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;共&nbsp; <%=pm1.getTotalPages() %> &nbsp;页</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">当前第</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm1.getPageNo()%></font>&nbsp;
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
								onClick="previousPage(2)">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="下页" onClick="nextPage(2)">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="尾页"
								onClick="bottomPage(2)">
								
						</div>
					</td>
				</tr>
			</table>
				
				
				<%				}	
			 %>
			
		</form>
		
	</body>
</html>
