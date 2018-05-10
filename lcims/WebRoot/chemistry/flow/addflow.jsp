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
	String rptype ="";  //��Ʒ����
	Date rptime ;  //����Ӧ��ʱ��
	String warning ="";  //Ԥ��
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
		<title>�����ת��</title>
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
<style type="text/css">
/*�������ı���ɫ*/
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
		alert("���Է����ı�����Ϊ�գ�");
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
			//document.getElementById("").value += "(1)��";
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
	
	<!-- -------------ajax�˵���С������start------------------------- -->

<script type="text/javascript">
    var req;
    window.onload=function()
    {//ҳ�����ʱ�ĺ���
    	
    }
    
    function Change_Select(status,plan){//����һ���������ѡ����ı�ʱ���øú���
    var obj=document.getElementsByName('flowtype');  //ѡ������name="aihao"�Ķ��󣬷�������
  //ȡ�����������������ѭ��������ǲ��Ǳ�ѡ��
  var s='';
  var flag =false;
  for(var i=0; i<obj.length; i++){
    if(obj[i].checked) s+=obj[i].value;  //���ѡ�У���value��ӵ�����s��
    if (obj[i].checked == true){ 
    flag=true;
    }   
  }
  if(flag ==false){
  alert("��ѡ����ת������"); return ;
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
   
         //ָ���ص�����Ϊcallback
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
    //�ص�����
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//����XML�ĵ�
        }else{
          alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    //�ص�����
    function callback1(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage1();//����XML�ĵ�
        }else{
         alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    //�ص�����
    function callback2(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage2();//����XML�ĵ�
        }else{
          alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    //��������xml�ķ���
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
      var xSel1 = xmlDoc.getElementsByTagName('select1');
      //���XML�ĵ��е�����<select2>���
      var biginfo = document.getElementById('biginfo');
      //�����ҳ�еĵڶ���������
      biginfo.options.length=0;
      //ÿ�λ���µ����ݵ�ʱ���Ȱ�ÿ����������ܵĳ�����0
 
      for(var i=0;i<xSel1.length;i++){
        var xValue1 = xSel1[i].childNodes[0].firstChild.nodeValue;
        //���ÿ��<select>����еĵ�һ����ǵ�ֵ,Ҳ����<value>��ǵ�ֵ
        var xText1 = xSel1[i].childNodes[1].firstChild.nodeValue;
        //���ÿ��<select>����еĵڶ�����ǵ�ֵ,Ҳ����<text>��ǵ�ֵ
        
        var option = new Option(xText1, xValue1);
        //����ÿ��value��text��ǵ�ֵ����һ��option����
        
        try{
          biginfo.add(option);//��option������ӵ��ڶ�����������
        }catch(e){
        }
      }
    }        
    function parseMessage1(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
      //���XML�ĵ��е�����<select1>���
      var xSel2 = xmlDoc.getElementsByTagName('select2');
      
      //���XML�ĵ��е�����<select2>���
     var smallinfo = document.getElementById('smallinfo');
      //�����ҳ�еĵڶ���������
      smallinfo.options.length=0;
      //ÿ�λ���µ����ݵ�ʱ���Ȱ�ÿ����������ܵĳ�����0
     
      for(var i=0;i<xSel2.length;i++){
        var xValue2 = xSel2[i].childNodes[0].firstChild.nodeValue;
        //���ÿ��<select>����еĵ�һ����ǵ�ֵ,Ҳ����<value>��ǵ�ֵ
        var xText2 = xSel2[i].childNodes[1].firstChild.nodeValue;
        //���ÿ��<select>����еĵڶ�����ǵ�ֵ,Ҳ����<text>��ǵ�ֵ
        
        var option = new Option(xText2, xValue2);
        //����ÿ��value��text��ǵ�ֵ����һ��option����
        
        try{
          smallinfo.add(option);//��option������ӵ��ڶ�����������
        }catch(e){
        }
      }

    }        
    function parseMessage2(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
    //alert(xmlDoc);
      //���XML�ĵ��е�����<select1>���
      var xSel3 = xmlDoc.getElementsByTagName('select3');
      
    
      //���XML�ĵ��е�����<select2>���
     var planinfo = document.getElementById('planinfo');
      //�����ҳ�еĵڶ���������
      planinfo.options.length=0;
      //ÿ�λ���µ����ݵ�ʱ���Ȱ�ÿ����������ܵĳ�����0
     
      for(var i=0;i<xSel3.length;i++){
        var xValue3 = xSel3[i].childNodes[0].firstChild.nodeValue;
          
        //���ÿ��<select>����еĵ�һ����ǵ�ֵ,Ҳ����<value>��ǵ�ֵ
        var xText3 = xSel3[i].childNodes[1].firstChild.nodeValue;
        //���ÿ��<select>����еĵڶ�����ǵ�ֵ,Ҳ����<text>��ǵ�ֵ
      
        var option = new Option(xText3, xValue3);
        //����ÿ��value��text��ǵ�ֵ����һ��option����
        
        try{
          planinfo.add(option);//��option������ӵ��ڶ�����������
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
							<b>�ͷ�����&gt;&gt;�����ת��</b>
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
						���۵���ţ�
					</td>
					<td width="33%">
						<input name="pid" size="40" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getPid() %>" />
					</td>

					<td width="17%">
						�������ͣ�
					</td>
					<td width="33%">
						
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=rptype%>" name="rptype"/>
					</td>

				</tr>
				<tr>
					<td>
						Ӧ������ʱ�䣺
					</td>
					<td><input type="text" size="40" style="background-color: rgb(242, 242, 242);" readonly="readonly" value="<%=rptime%>"></td>
					<td>
						�����ţ�
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=rid%>" />
					</td>
				</tr>
				<tr>
					<td>
						��Ŀ����ʱ�䣺
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getBuildtime() %>" />
					</td>
					<td>
						��Ŀ�ȼ���
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
					�����ز⣺
					</td>
					<td>
					��<input type="radio" name="retest" id="retest" value="n" checked />
					��<input type="radio" name="retest" id="retest" value="y" />
					</td>
					<td width="17%">
					�Ƿ�������
					</td>
					<td>
					��<input type="radio" name="retest1" id="retest1" value="n" checked />
					��<input type="radio" name="retest1" id="retest1" value="y" />
					</td>
			</tr>
			<tr>
					
					
			</tr>
			<tr>
					<td width="17%">
						��ת������:
					</td>
					<td colspan="3">
					<div id="mydiv" style="text-align: left;">
						�Բ���ת��
						<input type="checkbox" name="flowtype" value="�Բ���ת��"  checked="checked"/>
						|&nbsp; �����ת��
						<input type="checkbox" name="flowtype" value="�����ת��" />
						<!-- 	|&nbsp; ����������ת��
						<input type="checkbox" name="flowtype" value="����������ת��"/>
						 -->
					</div>
					</td>
				</tr>
							
			</table>
			<br>
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						����ʵ���ң�
					</td>
					<td >
					<select style="width: 200px" name="lab" >
						<option value="EMC" selected="selected">EMC</option>
						<option value="������">������</option>
						<option value="���ӵ���">���ӵ���</option>
						<option value="��ݸ">��ݸ</option>
					</select>
						<!-- <input name="lab" type="text" size="50"/> -->
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
						<td width="17%">
						��ĿԤ����ע��
					</td>
					<td>
						<textarea name="warning" rows="3" cols="84" style="width: 80%"  ><%=warning==null?"":warning %></textarea>
					</td>
					
				</tr>
				
			</table>
						<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
						<td width="17%">
						ʵ���Ҳ��Է�����
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
						��ע��
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4" style="width: 80%" ><%=p.getNotes()==null?"":p.getNotes()%></textarea>
					</td>
				</tr>
				<tr>
						<td width="17%">
						���ñ�ע���ݣ�
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
					�����ز⣺
					</td>
					<td>
					��<input type="radio" name="retest" id="retest" value="n" checked />
					��<input type="radio" name="retest" id="retest" value="y" />
					</td>
					<td width="17%">
					�Ƿ�������
					</td>
					<td>
					��<input type="radio" name="retest1" id="retest1" value="n" checked />
					��<input type="radio" name="retest1" id="retest1" value="y" />
					</td>
					
			</tr>
			<tr>
					<td width="17%%">
						��ת������:
					</td>
					<td colspan="3">
					<div id="mydiv">
						�޻���ת��
						<input type="checkbox" name="flowtype" value="�޻���ת��" onClick="chooseOne(this)"/>
						|&nbsp; �л���ת��
						<input type="checkbox" name="flowtype" value="�л���ת��" onClick="chooseOne(this)"/>
						|&nbsp;ʳƷ��ת��
						<input type="checkbox" name="flowtype" value="ʳƷ��ת��" onClick="chooseOne(this)"/>
						|&nbsp; �����ת��
						<input type="checkbox" name="flowtype" value="�����ת��" onClick="chooseOne(this)"/>
						|&nbsp; ΢����
						<input type="checkbox" name="flowtype" value="΢������ת��" onClick="chooseOne(this)"/>
						<!--|&nbsp; ����������ת��
						<input type="checkbox" name="flowtype" value="����������ת��" onClick="chooseOne(this)"/>
						  -->
					</div>
					 <script>   
    
     function chooseOne(cb) {   
         var obj = document.getElementById("mydiv");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
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
						����ʵ���ң�
					</td>
					<td width="33%">
						<input name="lab" type="text" size="40"/>
					</td>
					<td width="17%">
						���Ե�����
					</td>
					<td width="33%">
						<input name="testcount" type="text" size="40"/>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						��׼Ԥ����ע��
					</td>
					<td>
						<select name ="warningS" id="warningS" style="100px" onchange="restriction();"> 
							<option value="" selected="selected">---��ѡ���׼Ԥ����Ϣ---</option>
							<option value="��������Ҫ����ȷ�ϣ�����Ԥ���ӳ���">��������Ҫ����ȷ�ϣ�����Ԥ���ӳ���</option>
							<option value="����������/ά��������Ԥ���ӳ���">����������/ά��������Ԥ���ӳ���</option>
							<option value="��ͬһʱ�䴦������ݽ϶࣬����Ԥ���ӳ���">��ͬһʱ�䴦������ݽ϶࣬����Ԥ���ӳ���</option>
							<option value="����Ʒ�Ѵ���/���帴�ӣ����Ľϳ�ʱ�䣬����Ԥ���ӳ���">����Ʒ�Ѵ���/���帴�ӣ����Ľϳ�ʱ�䣬����Ԥ���ӳ���</option>
							<option value="����ƷԪ�صĺ����ߣ����Ľϳ�ʱ��ȷ�ϣ�����Ԥ���ӳ���">����ƷԪ�صĺ����ߣ����Ľϳ�ʱ��ȷ�ϣ�����Ԥ���ӳ���</option>
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
							<option value="" selected="selected">---����---</option>
							<option value="00" >00</option>
							<option value="30" >30</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="17%">
						��ĿԤ����ע��
					</td>
					<td>
						<textarea name="warning" rows="3" cols="83"><%=warning==null?"":warning %></textarea>
					</td>
				</tr>
				
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
				
						<td width="8%">
							������Ʒ������
						</td>
						<td>
							<textarea name="sampledesc"  rows="4" style="width: 300px"><%=sampledesc==null?"":sampledesc%></textarea>
						</td>
						<td width="15%">�������ͣ�</td>
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
						���ò��Դ����嵥��
					</td>
					<td width="33%">
						<select id="biginfo" size="6" style="width: 300px"
							ondblclick="Change_Select(this.value,2)">
						</select>
						
					</td>
					
					<td >
						����С���嵥��
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
						���Է����嵥��
					</td>
					<td >
						<select id="planinfo" size="6" style="width: 300px"
							ondblclick="addInorganicPlan(this.value);">
							
						</select>
					</td>
					
						
						<td>
						���Է�����<input type="button" value="���" onclick="cleanList();">
					</td>
					<td>
						<textarea cols="40" rows="6" name="testPlan"
							id="testPlan" style="background-color: #F2F2F2"
							readonly="readonly"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						ʵ���Ҳ��Է�����
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
						���������Ϣ��
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4" ><%=appform ==null?"":appform%></textarea>
					</td>
				</tr>
				<tr>
					<td>
						���ñ�ע���ݣ�
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
					value="���" onclick="checkSubimt(1);">
			<%
			} else{
			%>
			<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="���" onclick="checkSubimt(2);">
			<%
			}
			%>
				
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
