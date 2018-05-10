<%@page import="com.lccert.crm.vo.TopLevel"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.dao.impl.ChemProjectDaoImplMySql"%>
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%
	request.setCharacterEncoding("GBK");
	String fid = request.getParameter("fid");
	if (fid == null || "".equals(fid)) {
		response.sendRedirect("../project/searchproject.jsp");
		return;		
	}
	
	Flow flow = FlowAction.getInstance().getFlowByFid(fid); 
	if(flow == null ) {
		response.sendRedirect("../project/searchproject.jsp");
		return;
	}
	
	Project p =null;
	String rid =flow.getRid();

	String  str=DaoFactory.getInstance().getProjectDao().isChemOrPhy(rid);
	List list =ChemTestDaoImpl.getInstance().findTopLevel();
	String warning ="";
	String rptype="";
	Date rptime;
	String sampledesc="";
	String appform="";
	ChemProject cproject=null;
	if(str.equals("化学测试")||str.equals("化妆品")||str.equals("环境")){
		p = ChemProjectAction.getInstance().getChemProjectBySid(flow.getSid(),"");
		ChemProject cp= (ChemProject)p.getObj();
		cproject=(ChemProject)p.getObj();
		sampledesc=cp.getSampledesc();
		warning =cp.getWarning();
		rptype=cp.getRptype();
		rptime=cp.getRptime();
		appform=cp.getAppform();
	}else{
		p = ChemProjectAction.getInstance().getPhyProjectBySid(flow.getSid());
		PhyProject cp = (PhyProject)p.getObj();
		warning =new ChemProjectDaoImplMySql().getWarning(flow.getSid());
		rptype=cp.getRptype();
		rptime=cp.getRptime();
		sampledesc=cp.getSamplecount();
	appform=flow.getNotes();
	}
	
	
	if(p == null ) {
		response.sendRedirect("../project/searchproject.jsp");
		return;
	} 
	
	

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>修改流转单</title>
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
		function addInorganic(temp0) {
			document.getElementById("testparent").value += temp0;
			document.getElementById("testparent").value += ";";
		}
		function addInorganicDetail(temp1) {
			//document.getElementById("testchild").value += "(1)→";
			document.getElementById("testchild").value += temp1;
		}
		
		function addInorganicPlan(temp2) {
			//document.getElementById("").value += "(1)→";
			document.getElementById("testPlan").value += temp2;
			
			var a=document.getElementById("testPlan").value;
			var startIndex=a.lastIndexOf("|")+1; 
			var endIndex=a.length;
			

			
			//alert(a.substring(0,5);
			//alert(a.length()));
			document.getElementById("testPlan").value += ";";
			document.getElementById("testPlan").value += "\n";
			
			var SubString=a.substr(startIndex,endIndex);
			
			document.getElementById("testPlans").value += SubString;
			document.getElementById("testPlans").value += ";";
			document.getElementById("testPlans").value += "\n";
			
		}
		
		
		function cleanList(){
		document.getElementById("testPlan").value="";
		document.getElementById("testPlans").value="";
		}
		function check(obj){
		if(document.getElementById("testPlan").value==""){
		alert("测试方法不能为空");
		return false;
		}else{
		if(obj ==2){
		myform=document.getElementById("form1");
		myform.action="modifyphyflow_post.jsp";
		}else{
		myform=document.getElementById("form1");
		}
		myform.submit();
		}		
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
      //alert(xSel3.length);
    
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

<!-- -------------ajax菜单联动end--------------------------- -->
	
	

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
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;化学项目管理&gt;&gt;流转单管理&gt;&gt;修改流转单</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
		<form name="form1" method="post" action="modifyflow_post.jsp">
			<input name="fid" type="hidden" value="<%=flow.getFid() %>" />
			<input name="sid" type="hidden" value="<%=flow.getSid() %>" />
			<input name="oldwarning" type="hidden" value="<%=warning %>" />
			<input name="oldflowtype" type="hidden" value="<%=flow.getFlowtype() %>" />
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
							readonly="readonly" value="<%=rptype%>"  name="ptyp"/>
					</td>

				</tr>
				<tr>
					<td>
						应出报告时间：
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=rptime%>" />
					</td>
					<td>
						报告编号：
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getRid()==null?cproject.getFilingNo():p.getRid()%>" />
					</td>
				</tr>
				<tr>
					<td>
						项目接收时间11：<%=cproject.getFilingNo() %>
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
						<input type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getLevel() %>" />
					</td>
				</tr>
			</table>
			
		</div>	
		
		<%
		if(str.equals("化学测试")||str.equals("环境")||str.equals("化妆品")){
		%>
		
		<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
					补充重测：
					</td>
					<td>
					否<input type="radio" name="retest" id="retest1" value="n"  checked/>
					是<input type="radio" name="retest" id="retest2" value="y" />
					</td>
					<script type="text/javascript">
							var rt1 = document.getElementById("retest1");
							var rt2 = document.getElementById("retest2");
							if(rt1.value == "<%=flow.getRetest()%>") {
								rt1.checked = true;
							} else {
								rt2.checked = true;
							}
						</script>
						<td width="17%">
					是否退样：
					</td>
					<td>
					否<input type="radio" name="retest5" id="retest3" value="n" checked />
					是<input type="radio" name="retest5" id="retest4" value="y" />
					<script type="text/javascript">
							var rt3 = document.getElementById("retest3");
							var rt4 = document.getElementById("retest4");
							alert('<%=flow.getAddsamples()%>');
							if(rt3.value == "<%=flow.getAddsamples()%>") {
								rt3.checked = true;
							} else {
								rt4.checked = true;
							}
						</script>
					</td>
					
			</tr>
			
			<tr>
					<td width="17%%">
						流转单种类:
					</td>
					<td colspan="5">
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
						<!--  |&nbsp; 机构合作流转单
						<input type="checkbox" name="flowtype" value="机构合作流转单" onClick="chooseOne(this)"/>
						-->
					</div>
					<script type="text/javascript">
								var obj = document.getElementById("mydiv");
								for(var i=0;i<obj.children.length;i++) {
									if(obj.children[i].value.charCodeAt() == "<%=flow.getFlowtype()%>".charCodeAt()){
										obj.children[i].checked = true;
										Change_Select(obj.children[i]);
									}
								}
						</script>
					
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
						<input name="lab" type="text" size="40" value="<%=flow.getLab()==null?"":flow.getLab() %>"/>
					</td>
					<td width="17%">
						测试点数：
					</td>
					<td width="33%">
						<input name="testcount" type="text" size="40" value="<%=flow.getTestcount() %>"/>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
					<td width="17%">
						项目预警备注：
					</td>
					<td>
						<textarea name="warning" rows="3" cols="76" ><%=warning==null?"":warning %></textarea>
					</td>
				</tr>
				
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
			<%
			String testplan="";
					if(rptype.equals("英文报告")||rptype.equals("不出报告")){
					testplan=flow.getTestplanE();
					}else if(rptype.equals("中文报告") ||rptype.equals("双语报告")||rptype.equals("不出报告") ){
					testplan=flow.getTestplanC();
					}
					//System.out.println(testplan);
					//获取方法的Id
					String[] planList=new String [0];
					if(testplan != null && !"".equals(testplan)){
					planList=testplan.split(";");
					
					}
					//System.out.println(planList+":----");
					
%>
				<tr>
					<td>
						测试样品描述：
					</td>
					<td>
						<textarea name="sampledesc" cols="73" rows="4" ><%=sampledesc==null?"":sampledesc %></textarea>
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
						测试大项清单：
					</td>
					<td width="33%">
						<select id="biginfo" size="6" style="width: 500px"
							ondblclick="Change_Select(this.value,2)">
							<%
							for(int i=0;i<planList.length;i++){
							String parentName="";
							if(planList[i] !=null && !"".equals(planList[i])){
							//System.out.println(planList[i].substring(planList[i].indexOf(":")+1,planList[i].indexOf("|")));
							 parentName=planList[i].substring(planList[i].indexOf(":")+1,planList[i].indexOf("|"));
							}
							
							%>
							
							<option><%=flow.getTestparent()==null?"":flow.getTestparent().trim() %></option>
							<%}
							 %>
							
						</select>
						
					</td>
					
					<td >
					测试小项清单：
					</td>
					<td >
						<select id="smallinfo" size="6" style="width: 400px"
							ondblclick="Change_Select(this.value,1)">
							<%
							for(int i=0;i<planList.length;i++){
							String childName="";
							if(planList[i] !=null && !"".equals(planList[i])){
								 childName=planList[i].substring(planList[i].indexOf("|")+1,planList[i].lastIndexOf("|"));
						}
							%>
							<option>
							
							<%=childName.trim() %>
							</option>
							<%} %>
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
							<%
					for(int i=0;i<planList.length;i++){
					
					String planName="";
					//根据方法的id去查找方法的名称
					if(planList[i] !=null && !"".equals(planList[i])){
					 String id =planList[i].substring(0,planList[i].indexOf(":"));
					 planName=FlowFinal.getInstance().getNameById(Integer.parseInt(id.trim()));
					}
				%>
							<option>
							
							<%=planName== null ?"":planName.trim() %>
							</option>
								<% }%>
						</select>
					
					</td>
					
						
					
						<td>
						测试方法：<input type="button" value="清空" onclick="cleanList();">
					</td>
					<td>
						<textarea cols="40" rows="6" name="testPlan"
							id="testPlan" style="background-color: #F2F2F2"
							readonly="readonly"><%=testplan == null ?"":testplan.trim() %></textarea>
					</td>
				</tr>
					
				<tr>
					
					<td>
					实验室测试方法：
					</td>
					<td>
						<textarea cols="40" rows="6" name="testPlans"
							id="testPlans" ><%=flow.getDescribe().trim()%></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td>
						申请表补充信息：
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4"><%=appform==null?"":appform %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						备注内容：
					</td>
					<td>
						<select size="6" style="width: 600px"
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
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="修改" onclick="check(1);">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		<%
		}else{
		%>
		<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
					补充重测：
					</td>
					<td>
					否<input type="radio" name="retest" id="retest1" value="n"  checked/>
					是<input type="radio" name="retest" id="retest2" value="y" />
					</td>
					<script type="text/javascript">
							var rt1 = document.getElementById("retest1");
							var rt2 = document.getElementById("retest2");
							if(rt1.value == "<%=flow.getRetest()%>") {
								rt1.checked = true;
							} else {
								rt2.checked = true;
							}
						</script>
						<td width="17%">
					是否退样：
					</td>
					<td>
					否<input type="radio" name="retest5" id="retest3" value="n" checked />
					是<input type="radio" name="retest5" id="retest4" value="y" />
					<script type="text/javascript">
							var rt3 = document.getElementById("retest3");
							var rt4 = document.getElementById("retest4");
							
							if(rt3.value == "<%=flow.getAddsamples()%>") {
								rt3.checked = true;
							} else {
								rt4.checked = true;
							}
						</script>
					</td>
			</tr>
		
			<tr>
					<td width="17%" >
						流转单种类:
					</td>
					<td colspan="5" >
					<div id="mydiv">
					&nbsp; 自测流转单
						<input type="checkbox" name="flowtype" value="自测流转单"  checked="checked"/>
						|&nbsp; 外包流转单
						<input type="checkbox" name="flowtype" value="外包流转单" onClick="chooseOne(this);Change_Select(1,'');"/>
						<!--  |&nbsp; 机构合作流转单
						<input type="checkbox" name="flowtype" value="机构合作流转单" onClick="chooseOne(this);Change_Select(1,'');"/>
						-->
					</div>
					<script type="text/javascript">
								var obj = document.getElementById("mydiv");
								for(var i=0;i<obj.children.length;i++) {
									if(obj.children[i].value.charCodeAt() == "<%=flow.getFlowtype()%>".charCodeAt()){
										obj.children[i].checked = true;
										Change_Select(obj.children[i]);
									}
								}
						</script>
					
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
						<input name="lab" type="text" size="40" value="<%=flow.getLab()==null?"":flow.getLab() %>"/>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
					<td>
						项目预警备注：
					</td>
					<td>
						<textarea name="warning" rows="3" cols="76" ><%=warning==null?"":warning %></textarea>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td>
						实验室测试方法：
						<%
						String testPlan ="";
					if(rptype.equals("中文报告")){
						testPlan=flow.getTestplanC();
						}
						else if(rptype.equals("英文报告")){
						testPlan=flow.getTestplanE();
						}
									 %>
					</td>
					<td>
						<textarea cols="76" rows="6" name="testPlan"
							id="testPlan" ><%=testPlan %></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td>
						申请表补充信息：
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4"><%=appform==null?"":appform %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						常用备注内容：
					</td>
					<td>
						<select size="6" style="width: 600px"
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
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="修改" onclick="check(2);">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		<%
		}
		 %>
	
		
		
		
			


			
			
		</form>
	</body>
</html>
