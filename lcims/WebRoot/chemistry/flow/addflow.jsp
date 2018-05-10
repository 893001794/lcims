<%@page import="com.lccert.crm.vo.TopLevel"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="java.util.Date"%>
<%
	request.setCharacterEncoding("GBK");
	String sidStr = request.getParameter("sid");
	//System.out.println(sidStr);
	String type =request.getParameter("type");
	String[] sidLeng =sidStr.split(",");
	String sid="";
	String rid ="";
	if(sidLeng.length<1){
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
	}else{
		if(type!=null&&type.equals("batch")){
			sid=sidLeng[0].substring(0,sidLeng[0].indexOf("/"));
			for(int i=0;i<sidLeng.length;i++){
				rid+=sidLeng[i].substring(sidLeng[i].indexOf("/")+1,sidLeng[i].length())+",";
			}
		}else{
			sid=sidLeng[0];
		}
	}
	String ptype=request.getParameter("ptype");
	if (sid == null || "".equals(sid)) {
		response.sendRedirect("../project/searchproject.jsp");
		return;		
	}
	Project p ;
	ChemProject cp;
	PhyProject pp ;
	String rptype ="";  //样品类型
	Date rptime ;  //报告应出时间
	String warning ="";  //预警
	String appform  =""; //
	String sampledesc="";
	
	List list =ChemTestDaoImpl.getInstance().findTopLevel();
	if(ptype!=null &&! "".equals(ptype)&&ptype.equals("phy")){
	 p=ChemProjectAction.getInstance().getPhyProjectBySid(sid);
	 pp = (PhyProject)p.getObj();
	 rptype=pp.getRptype();
	 rptime=pp.getRptime();
	 rid =p.getRid();
	// System.out.println(rid);
	// System.out.println(rptime+rptype);
	}else{
	
	p=ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
//	System.out.print(type);
	if(type !=null&&!type.equals("batch")){
		rid =p.getRid();
	}
	cp = (ChemProject)p.getObj();
	rptype=cp.getRptype();
	rptime=cp.getRptime();
	warning=cp.getWarning();
	appform=cp.getAppform();
	sampledesc=cp.getSampledesc();
	}
	if(p == null ) {
		response.sendRedirect("../project/searchproject.jsp");
		return;
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加流转单</title>
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>

		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("appform").value += temp;
			document.getElementById("appform").value += "\n";
		}
		function checkSubimt(obj) {
		
		var testplanValue=document.getElementById("testPlan").value;
		if(testplanValue ==""){
		alert("测试方法文本框不能为空？");
		return ;
		}else{
		var myform ;
		if(obj ==1){
		myform=document.getElementById("form1");
		myform.action="addphyflow_post.jsp";
		}else{
		myform=document.getElementById("form1");
		}
		myform.submit();
		}
		}
		function addInorganicPlan(temp2) {
			//document.getElementById("").value += "(1)→";
			document.getElementById("testPlan").value+= temp2;
			
			var a=document.getElementById("testPlan").value;
			var startIndex=a.lastIndexOf("|")+1; 
			var endIndex=a.length;
			

			
			//alert(a.substring(0,5);
			//alert(a.length()));
			document.getElementById("testPlan").value+= ";";
			document.getElementById("testPlan").value+= "\n";
			var SubString=a.substr(startIndex,endIndex);
			document.getElementById("testPlans").value+= SubString;
			document.getElementById("testPlans").value+= ";";
			document.getElementById("testPlans").value+= "\n";
			
		}
		
		
		function cleanList(){
		document.getElementById("testPlan").value="";
		document.getElementById("testPlans").value="";
		}
		
	</script>
	
	<!-- -------------ajax菜单大小项联动start------------------------- -->

<script type="text/javascript">
    var req;
    window.onload=function()
    {//页面加载时的函数
    	
    }
    
    function Change_Select(status,plan){//当第一个下拉框的选项发生改变时调用该函数
    var obj=document.getElementsByName('flowtype');  //选择所有name="aihao"的对象，返回数组
  //取到对象数组后，我们来循环检测它是不是被选中
  var s='';
  var flag =false;
  for(var i=0; i<obj.length; i++){
    if(obj[i].checked) s+=obj[i].value;  //如果选中，将value添加到变量s中
    if (obj[i].checked == true){ 
    flag=true;
    }   
  }
  if(flag ==false){
  alert("请选择流转单种类"); return ;
  }
  if(status !=1 && plan == 2){
    var url = "getinfo1.jsp?type=" + s + "&timestampt=" + new Date().getTime()+"&parentId="+status;
  }
  else if (plan == 1){
   var url = "getinfo2.jsp?type=" + s + "&timestampt=" + new Date().getTime()+"&parentId="+status;
  }else{
      var url = "getinfo.jsp?type="+ s + "&timestampt=" + new Date().getTime()+"&topLevel="+status;
}
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
   
         //指定回调函数为callback
          if(status !=1 && plan == 2){
        req.onreadystatechange = callback1;
        }
        else if (plan == 1){
          req.onreadystatechange = callback2;
        }
        else{
          req.onreadystatechange = callback;
        }
        req.send(null);
      }
    }
    //回调函数
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//解析XML文档
        }else{
          alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //回调函数
    function callback1(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage1();//解析XML文档
        }else{
         alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //回调函数
    function callback2(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage2();//解析XML文档
        }else{
          alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //解析返回xml的方法
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
      var xSel1 = xmlDoc.getElementsByTagName('select1');
      //获得XML文档中的所有<select2>标记
      var biginfo = document.getElementById('biginfo');
      //获得网页中的第二个下拉框
      biginfo.options.length=0;
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
 
      for(var i=0;i<xSel1.length;i++){
        var xValue1 = xSel1[i].childNodes[0].firstChild.nodeValue;
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText1 = xSel1[i].childNodes[1].firstChild.nodeValue;
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
        
        var option = new Option(xText1, xValue1);
        //根据每组value和text标记的值创建一个option对象
        
        try{
          biginfo.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
      }
    }        
    function parseMessage1(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
      //获得XML文档中的所有<select1>标记
      var xSel2 = xmlDoc.getElementsByTagName('select2');
      
      //获得XML文档中的所有<select2>标记
     var smallinfo = document.getElementById('smallinfo');
      //获得网页中的第二个下拉框
      smallinfo.options.length=0;
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
     
      for(var i=0;i<xSel2.length;i++){
        var xValue2 = xSel2[i].childNodes[0].firstChild.nodeValue;
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText2 = xSel2[i].childNodes[1].firstChild.nodeValue;
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
        
        var option = new Option(xText2, xValue2);
        //根据每组value和text标记的值创建一个option对象
        
        try{
          smallinfo.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
      }

    }        
    function parseMessage2(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
    //alert(xmlDoc);
      //获得XML文档中的所有<select1>标记
      var xSel3 = xmlDoc.getElementsByTagName('select3');
      
    
      //获得XML文档中的所有<select2>标记
     var planinfo = document.getElementById('planinfo');
      //获得网页中的第二个下拉框
      planinfo.options.length=0;
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
     
      for(var i=0;i<xSel3.length;i++){
        var xValue3 = xSel3[i].childNodes[0].firstChild.nodeValue;
          
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText3 = xSel3[i].childNodes[1].firstChild.nodeValue;
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
      
        var option = new Option(xText3, xValue3);
        //根据每组value和text标记的值创建一个option对象
        
        try{
          planinfo.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
      }

    }        
  </script>
	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>客服管理&gt;&gt;添加流转单</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
		<form name="form1" method="post" action="addflow_post.jsp">
		<input name="sidStr" type="hidden" value="<%=sidStr%>"/>
		<input name="oldwarning" type="hidden" value="<%=warning%>" />
		<div class="outborder">
			<table cellpadding="5" cellspacing="0" width="95%">
				<tr>
					<td width="17%">
						报价单编号：
					</td>
					<td width="33%">
						<input name="pid" size="40" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getPid() %>" />
					</td>

					<td width="17%">
						报告类型：
					</td>
					<td width="33%">
						
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=rptype%>" name="rptype"/>
					</td>

				</tr>
				<tr>
					<td>
						应出报告时间：
					</td>
					<td><input type="text" size="40" style="background-color: rgb(242, 242, 242);" readonly="readonly" value="<%=rptime%>"></td>
					<td>
						报告编号：
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=rid%>" />
					</td>
				</tr>
				<tr>
					<td>
						项目接收时间：
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getBuildtime() %>" />
					</td>
					<td>
						项目等级：
					</td>
					<td>
						<input name="level" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getLevel() %>" />
					</td>
				</tr>
			</table>
			
		</div>	
		<%
		if(ptype!=null &&! "".equals(ptype)&&ptype.equals("phy")){
		%>
	<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%">
					补充重测：
					</td>
					<td>
					否<input type="radio" name="retest" id="retest" value="n" checked />
					是<input type="radio" name="retest" id="retest" value="y" />
					</td>
					<td width="17%">
					是否退样：
					</td>
					<td>
					否<input type="radio" name="retest1" id="retest1" value="n" checked />
					是<input type="radio" name="retest1" id="retest1" value="y" />
					</td>
			</tr>
			<tr>
					
					
			</tr>
			<tr>
					<td width="17%">
						流转单种类:
					</td>
					<td colspan="3">
					<div id="mydiv" style="text-align: left;">
						自测流转单
						<input type="checkbox" name="flowtype" value="自测流转单"  checked="checked"/>
						|&nbsp; 外包流转单
						<input type="checkbox" name="flowtype" value="外包流转单" />
						<!-- 	|&nbsp; 机构合作流转单
						<input type="checkbox" name="flowtype" value="机构合作流转单"/>
						 -->
					</div>
					</td>
				</tr>
							
			</table>
			<br>
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						测试实验室：
					</td>
					<td >
					<select style="width: 200px" name="lab" >
						<option value="EMC" selected="selected">EMC</option>
						<option value="光性能">光性能</option>
						<option value="电子电器">电子电器</option>
						<option value="东莞">东莞</option>
					</select>
						<!-- <input name="lab" type="text" size="50"/> -->
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
						<td width="17%">
						项目预警备注：
					</td>
					<td>
						<textarea name="warning" rows="3" cols="84" style="width: 80%"  ><%=warning==null?"":warning %></textarea>
					</td>
					
				</tr>
				
			</table>
						<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
						<td width="17%">
						实验室测试方法：
					</td>
					<td>
						<textarea cols="76" rows="6" name="testPlan"
							id="testPlan" cols="80" style="width: 80%"></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
						<td width="17%">
						备注：
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4" style="width: 80%" ><%=p.getNotes()==null?"":p.getNotes()%></textarea>
					</td>
				</tr>
				<tr>
						<td width="17%">
						常用备注内容：
					</td>
					<td>
						<select size="6" style="width: 80%" 
							ondblclick="addAppform(this.value);">

							<%
							List<String> app = FlowFinal.getInstance().getAllAppForm();
							for(int i=0;i<app.size();i++) {
								String strapp = app.get(i);
						 %>

							<option value="<%=strapp %>">
								<%=strapp %>
							</option>
							<%
							}
						 %>


						</select>
					</td>
				</tr>
			</table>
			
		<%
				}else{
				%>
				
				<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
					补充重测：
					</td>
					<td>
					否<input type="radio" name="retest" id="retest" value="n" checked />
					是<input type="radio" name="retest" id="retest" value="y" />
					</td>
					<td width="17%">
					是否退样：
					</td>
					<td>
					否<input type="radio" name="retest1" id="retest1" value="n" checked />
					是<input type="radio" name="retest1" id="retest1" value="y" />
					</td>
					
			</tr>
			<tr>
					<td width="17%%">
						流转单种类:
					</td>
					<td colspan="3">
					<div id="mydiv">
						无机流转单
						<input type="checkbox" name="flowtype" value="无机流转单" onClick="chooseOne(this)"/>
						|&nbsp; 有机流转单
						<input type="checkbox" name="flowtype" value="有机流转单" onClick="chooseOne(this)"/>
						|&nbsp;食品流转单
						<input type="checkbox" name="flowtype" value="食品流转单" onClick="chooseOne(this)"/>
						|&nbsp; 外包流转单
						<input type="checkbox" name="flowtype" value="外包流转单" onClick="chooseOne(this)"/>
						|&nbsp; 微生物
						<input type="checkbox" name="flowtype" value="微生物流转单" onClick="chooseOne(this)"/>
						<!--|&nbsp; 机构合作流转单
						<input type="checkbox" name="flowtype" value="机构合作流转单" onClick="chooseOne(this)"/>
						  -->
					</div>
					 <script>   
    
     function chooseOne(cb) {   
         var obj = document.getElementById("mydiv");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
             else obj.children[i].checked = true;   
         }   
     }   
 </script>
					</td>
				</tr>
							
			</table>
			<br>
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						测试实验室：
					</td>
					<td width="33%">
						<input name="lab" type="text" size="40"/>
					</td>
					<td width="17%">
						测试点数：
					</td>
					<td width="33%">
						<input name="testcount" type="text" size="40"/>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						标准预警备注：
					</td>
					<td>
						<select name ="warningS" id="warningS" style="100px" onchange="restriction();"> 
							<option value="" selected="selected">---请选择标准预警信息---</option>
							<option value="因数据需要复测确认，本单预计延迟至">因数据需要复测确认，本单预计延迟至</option>
							<option value="因仪器故障/维护，本单预计延迟至">因仪器故障/维护，本单预计延迟至</option>
							<option value="因同一时间处理的数据较多，本单预计延迟至">因同一时间处理的数据较多，本单预计延迟至</option>
							<option value="因样品难处理/基体复杂，消耗较长时间，本单预计延迟至">因样品难处理/基体复杂，消耗较长时间，本单预计延迟至</option>
							<option value="因样品元素的含量高，消耗较长时间确认，本单预计延迟至">因样品元素的含量高，消耗较长时间确认，本单预计延迟至</option>
						</select>
						<script type="text/javascript">
							function restriction(){
								if(document.getElementById("warningS").value!=""){
									document.getElementById("warning").disabled=true;
								}else{
									document.getElementById("warning").disabled=false;
								}
							}
							
						</script>
						<input name="date" type="text" id="date" size="13" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH',el:'date'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						<select name ="time" id ="time">
							<option value="" selected="selected">---分钟---</option>
							<option value="00" >00</option>
							<option value="30" >30</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="17%">
						项目预警备注：
					</td>
					<td>
						<textarea name="warning" rows="3" cols="83"><%=warning==null?"":warning %></textarea>
					</td>
				</tr>
				
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
				
						<td width="8%">
							测试样品描述：
						</td>
						<td>
							<textarea name="sampledesc"  rows="4" style="width: 300px"><%=sampledesc==null?"":sampledesc%></textarea>
						</td>
						<td width="15%">测试类型：</td>
						<td width="30%">
							<select id="topLevel" size="6" style="width: 300px"
								ondblclick="Change_Select(this.value,3)">
								
							<%
							for(int i=0;i<list.size();i++){
							TopLevel tl =(TopLevel)list.get(i);
							%>
							<option value="<%=tl.getId()%>"><%=tl.getName()%></option>
							<%
							}
							 %>
							</select>
							
						</td>
					</tr>
				<tr>
					<td width="17%">
						常用测试大项清单：
					</td>
					<td width="33%">
						<select id="biginfo" size="6" style="width: 300px"
							ondblclick="Change_Select(this.value,2)">
						</select>
						
					</td>
					
					<td >
						测试小项清单：
					</td>
					<td >
						<select id="smallinfo" size="6" style="width: 300px"
							ondblclick="Change_Select(this.value,1)">
							
						</select>
					</td>
					<td>
						 	<span id="spUserName" style="color:red;">&nbsp;</span>
						</td>

				</tr>

				<tr>
					
					<td >
						测试方法清单：
					</td>
					<td >
						<select id="planinfo" size="6" style="width: 300px"
							ondblclick="addInorganicPlan(this.value);">
							
						</select>
					</td>
					
						
						<td>
						测试方法：<input type="button" value="清空" onclick="cleanList();">
					</td>
					<td>
						<textarea cols="40" rows="6" name="testPlan"
							id="testPlan" style="background-color: #F2F2F2"
							readonly="readonly"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						实验室测试方法：
					</td>
					<td>
						<textarea cols="40" rows="6" name="testPlans"
							id="testPlans" ></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						申请表补充信息：
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4" ><%=appform ==null?"":appform%></textarea>
					</td>
				</tr>
				<tr>
					<td>
						常用备注内容：
					</td>
					<td>
						<select size="6" style="width: 580px"
							ondblclick="addAppform(this.value);">

							<%
							List<String> app = FlowFinal.getInstance().getAllAppForm();
							for(int i=0;i<app.size();i++) {
								String strapp = app.get(i);
						 %>

							<option value="<%=strapp %>">
								<%=strapp %>
							</option>
							<%
							}
						 %>


						</select>
					</td>
				</tr>
			</table>
			</div>
				
				<%
		
		}
		 %>
			


			<hr width="97%" align="center" size=0>
			<div align="center">
			<%
			
			if(ptype !=null && ptype.equals("phy")){
			%>
			<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="添加" onclick="checkSubimt(1);">
			<%
			} else{
			%>
			<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="添加" onclick="checkSubimt(2);">
			<%
			}
			%>
				
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
