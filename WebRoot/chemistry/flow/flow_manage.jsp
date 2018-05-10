<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
 <%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	
	String start = request.getParameter("start");
	if("1".equals(start)){
	String rptime=request.getParameter("rptime");
	if(!"".equals(rptime) ||null==rptime){
	boolean flag =BarCodeAction.getInstance().getUpdateRptime(rptime,sid);
	
	}else{
	boolean flag =BarCodeAction.getInstance().getUpdateRptime(null,sid);
	}
	}
	
	
	
	
	String keywords = request.getParameter("keywords");
	String type = request.getParameter("type");
	List<Flow> list = null;
	
	
	String command = request.getParameter("command");
	if(command != null && "search".equals(command)) {
		if(!(keywords == null || "".equals(keywords))) {
			list = FlowAction.getInstance().searchFlow(keywords,type);
		}
	} else if (!(sid == null || "".equals(sid))) {
		list = FlowAction.getInstance().getFlowBySid(sid);
	}

%>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>未排单列表</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script type="text/javascript">
	
	function goBack() {
			window.history.back();
		}
	
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
			alert("请选择需要修改的流转单！");
			return;
		}
		if (count > 1) {
			alert("一次只能修改一份流转单！");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		window.self.location = "modifyflow.jsp?fid=" + fid;
	}
	
	function deleteFlow() {
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
				action = "deleteflow.jsp";
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}
	
	
	function printflow() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("请选择需要打印的流转单！");
			return;
		}
		if (count > 1) {
			alert("一次只能打印一份流转单！");
			return;
		}
		var fid = document.getElementsByName("selectFlag")[j].value;
		var flag = document.getElementsByName("isflag")[j].value;
		var str=fid.substring(3, 4);
		//alert(str);
	   if(str=="C"||str=="D" || str=="a" || str=="b" || str=="c" || str=="d"){
	   window.open("printflow.jsp?fid=" + fid);
	   	//ajax_print(fid);
	  }else{
	  window.open("printphyflow.jsp?fid=" + fid);
	  	//ajax_print(fid);
	  }
	   //window.open("printphyflow.jsp?fid=" + fid);
	 	 //}else if(flag == true){
		//window.open("printflow.jsp?fid=" + fid);
		//}else{
		//window.open("printflow1.jsp?fid=" + fid);
		//}
		//window.open("printflow.jsp?fid=" + fid,"", "height=0, width=0,top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no'");
		
	
	}
	
	function stop(Object,search){
	//alert(document.getElementById("start").value);
	    var myForm =document.getElementById("search");
		if("开始"==document.getElementById("start").value){
			myForm.action="flow_manage.jsp?start=1&sid="+Object;
			myForm.submit();
			return ;
		}else{
		//将一个父窗口传到子窗口中去myForm
		window.showModalDialog("updaterptime.jsp?sid="+Object,myForm,"dialogWidth:900px;dialogHeight:700px");

		
		}
		
		
	}
	
</script>

		<!-- -------------ajax打印流转单start------------------------- -->

		<script type="text/javascript">
    var req;
    
    function ajax_print(fid){
    var url = "printphyflow.jsp?fid=" + fid + "&timestampt=" + new Date().getTime();
    
     
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
         //指定回调函数为callback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //回调函数
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          	alert(req.responseText + "");
        }
        //else{
        //  alert("打印出错:" + req.statusText);
        //}
      }
    }
   
  </script>

		<!-- -------------ajax菜单联动end--------------------------- -->



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
						<b>化学项目管理&gt;&gt;管理流转单&gt;&gt;流转单列表</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=flow_manage.jsp?command=search>
							<font color="red">请输入报价单号：</font>
							<input type=text name=keywords size="25" value=>
							<input type="hidden" name="type" value="pid" />
							<input type=submit name=Submit value=搜索>
						</form>
					</td>

				</tr>

				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=flow_manage.jsp?command=search>
							<font color="red">请输入报告编号：</font>
							<input type=text name=keywords size="25" value=>
							<input type="hidden" name="type" value="rid" />
							<input type=submit name=Submit value=搜索>
						</form>
					</td>

				</tr>

			</table>

			<hr width="97%" align="center" size=0>
			<form name="userform" id="userform">
		</div>
		<input name="keywords" type="hidden" value="<%=keywords %>" />
		<input name="type" type="hidden" value="<%=type %>" />
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
					报价单编号
				</td>
				<td class="rd6">
					化妆品号
				</td>
				<td class="rd6">
					流转单编号
				</td>
				<td class="rd6">
					防伪码
				</td>
				<td class="rd6">
					流转单类型
				</td>
				<td class="rd6">
					实验室
				</td>
				<td class="rd6">
					排单人
				</td>
				<td class="rd6">
					排单时间
				</td>
			
				<td class="rd6">
					操作
				</td>
			</tr>

			<%
					if(list != null) {
					for(int i=0;i<list.size();i++) {
						Flow flow = list.get(i);
					String start1=ProjectChemImpl.getInstance().getProjectStart(flow.getSid());	
					String filingno=ProjectChemImpl.getInstance().getFilingno(flow.getRid());	
					boolean flag=FlowAction.getInstance().isDescribe(flow.getFid());
				 %>

			<tr>
				<td class="rd8">
					<input type="checkbox" name="selectFlag" class="checkbox1"
						value="<%=flow.getFid()%>">
						<input type="hidden" value="<%=flag %>" name="isflag">
				</td>
				<td class="rd8">
					<a href="../../quotation/detail.jsp?pid=<%=flow.getPid() %>"><%=flow.getPid() %></a>
				</td>
				<td class="rd8">
					<%=filingno%>
				</td>
				<td class="rd8">
					<a href="detail.jsp?fid=<%=flow.getFid() %>"><%=flow.getFid() %></a>
				</td>
				<td class="rd8">
					<%=flow.getSecurity() %>
				</td>
				<td class="rd8">
					<%=flow.getFlowtype() %>
				</td>
				<td class="rd8">
					<%=flow.getLab() %>
				</td>
				<td class="rd8">
					<%=flow.getPduser() %>
				</td>
				<td class="rd8">
					<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(flow.getPdtime()) %>
				</td>
			
				<td class="rd8">
				 [<a href="cancelflow.jsp?fid=<%=flow.getFid() %>">取消流转单</a>]
				<%
				if(flow.getStatus() != 5 && !"".equals(start1)) {
				%>
					
					 <input type="button" name ="start" id="start" value="<%=start1 %>" onclick="stop('<%=flow.getSid() %>',document)">
				<%
				}
				 %>
				</td>
			</tr>

			<%
					}
				}
				 %>

		</table>
		<table width="95%" height="30" border="0" align="center"
			cellpadding="0" cellspacing="0" class="rd1">
			<tr>
					<td nowrap class="rd19">
						<div align="right">
							<%
						if(user.getTicketid().matches("11111111")) {
					%>
							&nbsp;
							<input name="btnModify" class="button1" type="button"
								id="btnModify" value="删除" onClick="deleteFlow()">
					<%
						}
					 %>
						</div>
					</td>
				</tr>
		</table>

		
		<br>
	<div align="center">
	<input name="btnGoback" class="button1" type="button"
				id="btnGoback" value="返回" onClick="goBack()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="修改流转单" onClick="modifyflow()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="打印流转单" onClick="printflow()">
						
					</div>
	</body>
</html>
