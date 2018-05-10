<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="../comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 30;
	String pageNoStr = request.getParameter("pageNo");
	String pid="";
	String cl="";
	String parttype = "all";
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	//获取用户id 
	int userid ;
	String sales="";
	String saleid="";
	saleid=request.getParameter("saleid");
	if(saleid !=null && !"".equals(saleid)&&!saleid.equals("null")){
	userid=Integer.parseInt(saleid.trim());
	sales=UserAction.getInstance().getNameById(Integer.parseInt(saleid.trim()));
	}else{
	userid=user.getId();
	sales= user.getName();
	}
	//创建分页的对象
	PageModel pm = new PageModel();
	
	List temp =new ArrayList();
	String command = request.getParameter("command");
	
	//获取下属的名称
	List salesName=UserAction.getInstance().getUserBySuperiorid(user.getId());
	
	//根据id查询他是否有上级
	String superiorid =UserAction.getInstance().getSuperioridById(userid);
	//if(superiorid ==null || "".equals(superiorid)){
	//temp=QuotationAction.getInstance().getSuperiorAchicrements(userid);
	//}else{
	//获取销售人员一些统计
	
	 temp =QuotationAction.getInstance().getPerAchicrements(sales);
	//}
	List<Quotation> list = null;
	if (command != null && "search".equals(command)) {
	     //parttype=request.getParameter("parttype");
	     parttype=request.getParameter("parttypecb");
	     
		 pid= request.getParameter("pid");
		 cl= request.getParameter("client");
		//pm = QuotationAction.getInstance().searchMyQuotation(pageNo,pageSize,sales,pid,client,parttype);
	//} else {
	//	pm = QuotationAction.getInstance().getAllQuotations(pageNo,pageSize,sales);
	}
	pm = QuotationAction.getInstance().searchMyQuotation(pageNo,pageSize,sales,pid,cl,parttype);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>我的订单</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
		
	<script language="JavaScript" type="text/JavaScript">
	function showsaledialog(start) {
		window.showModalDialog("totalsaleinfo.jsp?sales=<%=userid%>&start="+ start,"","dialogWidth:900px;dialogHeight:700px");
	}
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" + pid);
	}
	
	function addUser() {
		
		window.self.location = "addquotation.jsp";	
	}
	
	function modifyUser() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要修改的用户数据！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一条用户数据！");
			return;
		}
	
		window.self.location = "modifyquotation.jsp?pid=" + document.getElementsByName("selectFlag")[j].value;
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
		window.self.location = "myquotation.jsp?command=search&pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "myquotation.jsp?command=search&pageNo=<%=pm.getPreviousPageNo()%>&saleid=<%=saleid%>&parttypecb=<%=parttype%>";
	}	
	
	function nextPage() {
	var url="myquotation.jsp?command=search&pageNo=<%=pm.getNextPageNo()%>&saleid=<%=saleid%>&parttypecb=<%=parttype%>";
		window.self.location =url;
	}
	
	function bottomPage() {
		window.self.location = "myquotation.jsp?command=search&pageNo=<%=pm.getBottomPageNo()%>&saleid=<%=saleid%>&parttypecb=<%=parttype%>";
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
	
	
	function searchsales(obj){
	var id =obj.value;
	var myform =document.getElementById("search");
	myform.action ="myquotation.jsp?command=search&saleid="+id+"&parttypecb=<%=parttype%>";
	myform.submit();
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
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>销售管理&gt;&gt;我的订单</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=myquotation.jsp?command=search&parttypecb=<%=parttype%>>
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
						
							<font color="red">请输入报价单号：</font>
							<input type=text name=pid size="40" value="" />
							<input type=submit name=Submit value=搜索>
						
						</td>
						
					</tr>
					<tr>
					<td width="50%">
							<font color="red">请输客户名称：&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=搜索>
							<script>   
						        $("#client").autocomplete("../myclient_ajax.jsp",{
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
						
				</tr>
				<tr>
					<td >
						<div id="mydiv">
						
						全部
							<input type="checkbox" name="parttype" value="all" onClick="chooseOne(this);" <%=parttype.equals("all") || parttype==null ?"checked":""%>/>
					
							
							|&nbsp; 已付清未完成
							<input type="checkbox" name="parttype" value="no" onClick="chooseOne(this);" <%=parttype.equals("no")?"checked":""%>/>
							|&nbsp;	已完成未付清
							<input type="checkbox" name="parttype" value="yes" onClick="chooseOne(this);" <%=parttype.equals("yes")?"checked":""%>/>&nbsp;	&nbsp;	&nbsp;	
							
							<%
																if(salesName.size()>0){
															%>
		
					组员：<select name="sale" id="sale" onchange="searchsales(this);" >
					<option value="">--选择组员--</option>
					<%
						for(int i=0;i<salesName.size();i++){
								UserForm sa =(UserForm)salesName.get(i);
					%>
					<option  value="<%=sa.getId()%>" <%=userid == sa.getId()? "selected":""%>><%=sa.getName()%></option>
					<%
						}
					%>
					</select>
				<%
					}
				%>
						</div>
						
						 <script>   
	    
						     function chooseOne(cb) {   
						     		var cb= cb.value;
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else obj.children[i].checked = true;   
						         }   
						         
						         var search=document.getElementById("search");
						         search.action ="myquotation.jsp?command=search&parttypecb="+cb;
						         search.submit();
						     }   
						 </script>
						</td>
				</tr>
				<tr>
			
					<td>
						<%
							if(Float.parseFloat(temp.get(1).toString())!=0){
						%>
					本月订单金额：<font color="red">[<a href="javascript:showsaledialog('InTotal');"><%=temp.get(1)%></a>]</font>&nbsp;
					<%
						}  else{
					%>
					本月订单金额:<font color="red"><%=temp.get(1)%>&nbsp;</font>
						<%
							}
										if(Float.parseFloat(temp.get(2).toString())!=0){
						%>
					本月未结金额：<font color="red">[<a href="javascript:showsaledialog('InunDe');"><%=temp.get(2)%></a>]</font>&nbsp;
					<%
						}  else{
					%>
					本月未结金额：<font color="red"><%=temp.get(2)%>&nbsp;</font>
						<%
							}
										if(Float.parseFloat(temp.get(3).toString())!=0){
						%>
					历史欠款：<font color="red">[<a href="javascript:showsaledialog('HiDe');"><%=temp.get(3)%></a>]</font>&nbsp;
					<%
						} 
								 else{
					%>
					历史欠款：<font color="red"><%=temp.get(3)%>&nbsp;</font>
					<%
						}
									if(Float.parseFloat(temp.get(0).toString())!=0){
					%>
					本月收历史欠款：<font color="red">[<a href="javascript:showsaledialog('InHiReDe');"><%=temp.get(0)%></a>]</font>
					<%
						} else{
					%>
					本月收历史欠款：<font color="red"><%=temp.get(0)%></font>
						<%
							}
						%>
					
					</td>
					
					
					
				</tr>
					
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>

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
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td class="rd6" >
						报价单编号
					</td>
					<td class="rd6" >
						客户名称
					</td>
					<td class="rd6" >
						项目名称
					</td>
					<td class="rd6" >
						报价金额
					</td>
					<td class="rd6" >
						已收金额
					</td>
					<td class="rd6" >
						预估分包费
					</td>
					<td class="rd6" >
						预估机构费
					</td>
					<td class="rd6" >
						销售
					</td>
					<td class="rd6" >
						立项数目
					</td>
					<td class="rd6">
						状态
					</td>
					<td class="rd6">
						所有项目
					</td>
				</tr>
				
				<%
									list = pm.getList();
										for(int i=0;i<list.size();i++) {
											Quotation qt = list.get(i);
								%>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=qt.getPid()%>">
					</td>
					
					<td class="rd8">
						<a href="detail.jsp?pid=<%=qt.getPid()%>"><%=qt.getPid()%></a>
					</td>
					<td class="rd8">
						<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
											if(client == null) {
												client = new ClientForm();
											}
						%>
						
						<span class="short"><a href="../client/clientdetail.jsp?clientid=<%=client.getClientid() %>"><%=qt.getClient() %></a></span>
						
					</td>
					<td class="rd8">
						<span class="short"><%=qt.getProjectcontent() %></span>
					</td>
					<td class="rd8">
						<%=qt.getTotalprice() %>
					</td>
					<td class="rd8">
						<%=qt.getPreadvance() + qt.getSepay() + qt.getBalance() %>
					</td>
					<td class="rd8">
						<%=qt.getPresubcost() %>
					</td>
					<td class="rd8">
						<%=qt.getPreagcost() %>
					</td>
					<td class="rd8">
						<%=qt.getSales() %>
					</td>
					<td class="rd8">
						<%=qt.getProjectcount() %>
					</td>
					<td class="rd8">
						<%=qt.getStatus() %>
					</td>	
					<td class="rd8">
						[<a href="javascript:showdialog('<%=qt.getPid() %>');">查看</a>]
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
								id="btnPreviousPage" value=" &lt;  " title="上页<%=saleid%>"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="下页<%=saleid%>" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="尾页<%=saleid%>"
								onClick="bottomPage()">
							&nbsp;
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="添加" onClick="addUser()">
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="修改" onClick="modifyUser()">
						</div>
					</td>
				</tr>
			</table>
			
		
	</body>
</html>
