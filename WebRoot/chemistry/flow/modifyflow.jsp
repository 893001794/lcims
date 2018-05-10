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
	if(str.equals("��ѧ����")||str.equals("��ױƷ")||str.equals("����")){
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
		<title>�޸���ת��</title>
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
		function addInorganic(temp0) {
			document.getElementById("testparent").value += temp0;
			document.getElementById("testparent").value += ";";
		}
		function addInorganicDetail(temp1) {
			//document.getElementById("testchild").value += "(1)��";
			document.getElementById("testchild").value += temp1;
		}
		
		function addInorganicPlan(temp2) {
			//document.getElementById("").value += "(1)��";
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
		alert("���Է�������Ϊ��");
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
      //alert(xSel3.length);
    
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

<!-- -------------ajax�˵�����end--------------------------- -->
	
	

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
					<b>&gt;&gt;��ѧ��Ŀ����&gt;&gt;��ת������&gt;&gt;�޸���ת��</b>
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
							readonly="readonly" value="<%=rptype%>"  name="ptyp"/>
					</td>

				</tr>
				<tr>
					<td>
						Ӧ������ʱ�䣺
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=rptime%>" />
					</td>
					<td>
						�����ţ�
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getRid()==null?cproject.getFilingNo():p.getRid()%>" />
					</td>
				</tr>
				<tr>
					<td>
						��Ŀ����ʱ��11��<%=cproject.getFilingNo() %>
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
						<input type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getLevel() %>" />
					</td>
				</tr>
			</table>
			
		</div>	
		
		<%
		if(str.equals("��ѧ����")||str.equals("����")||str.equals("��ױƷ")){
		%>
		
		<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
					�����ز⣺
					</td>
					<td>
					��<input type="radio" name="retest" id="retest1" value="n"  checked/>
					��<input type="radio" name="retest" id="retest2" value="y" />
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
					�Ƿ�������
					</td>
					<td>
					��<input type="radio" name="retest5" id="retest3" value="n" checked />
					��<input type="radio" name="retest5" id="retest4" value="y" />
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
						��ת������:
					</td>
					<td colspan="5">
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
						<!--  |&nbsp; ����������ת��
						<input type="checkbox" name="flowtype" value="����������ת��" onClick="chooseOne(this)"/>
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
						<input name="lab" type="text" size="40" value="<%=flow.getLab()==null?"":flow.getLab() %>"/>
					</td>
					<td width="17%">
						���Ե�����
					</td>
					<td width="33%">
						<input name="testcount" type="text" size="40" value="<%=flow.getTestcount() %>"/>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
					<td width="17%">
						��ĿԤ����ע��
					</td>
					<td>
						<textarea name="warning" rows="3" cols="76" ><%=warning==null?"":warning %></textarea>
					</td>
				</tr>
				
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
			<%
			String testplan="";
					if(rptype.equals("Ӣ�ı���")||rptype.equals("��������")){
					testplan=flow.getTestplanE();
					}else if(rptype.equals("���ı���") ||rptype.equals("˫�ﱨ��")||rptype.equals("��������") ){
					testplan=flow.getTestplanC();
					}
					//System.out.println(testplan);
					//��ȡ������Id
					String[] planList=new String [0];
					if(testplan != null && !"".equals(testplan)){
					planList=testplan.split(";");
					
					}
					//System.out.println(planList+":----");
					
%>
				<tr>
					<td>
						������Ʒ������
					</td>
					<td>
						<textarea name="sampledesc" cols="73" rows="4" ><%=sampledesc==null?"":sampledesc %></textarea>
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
						���Դ����嵥��
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
					����С���嵥��
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
						���Է����嵥��
					</td>
					<td >
					
						<select id="planinfo" size="6" style="width: 300px"
							ondblclick="addInorganicPlan(this.value);">
							<%
					for(int i=0;i<planList.length;i++){
					
					String planName="";
					//���ݷ�����idȥ���ҷ���������
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
						���Է�����<input type="button" value="���" onclick="cleanList();">
					</td>
					<td>
						<textarea cols="40" rows="6" name="testPlan"
							id="testPlan" style="background-color: #F2F2F2"
							readonly="readonly"><%=testplan == null ?"":testplan.trim() %></textarea>
					</td>
				</tr>
					
				<tr>
					
					<td>
					ʵ���Ҳ��Է�����
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
						���������Ϣ��
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4"><%=appform==null?"":appform %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						��ע���ݣ�
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
					value="�޸�" onclick="check(1);">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		<%
		}else{
		%>
		<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
					�����ز⣺
					</td>
					<td>
					��<input type="radio" name="retest" id="retest1" value="n"  checked/>
					��<input type="radio" name="retest" id="retest2" value="y" />
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
					�Ƿ�������
					</td>
					<td>
					��<input type="radio" name="retest5" id="retest3" value="n" checked />
					��<input type="radio" name="retest5" id="retest4" value="y" />
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
						��ת������:
					</td>
					<td colspan="5" >
					<div id="mydiv">
					&nbsp; �Բ���ת��
						<input type="checkbox" name="flowtype" value="�Բ���ת��"  checked="checked"/>
						|&nbsp; �����ת��
						<input type="checkbox" name="flowtype" value="�����ת��" onClick="chooseOne(this);Change_Select(1,'');"/>
						<!--  |&nbsp; ����������ת��
						<input type="checkbox" name="flowtype" value="����������ת��" onClick="chooseOne(this);Change_Select(1,'');"/>
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
						<input name="lab" type="text" size="40" value="<%=flow.getLab()==null?"":flow.getLab() %>"/>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				
				<tr>
					<td>
						��ĿԤ����ע��
					</td>
					<td>
						<textarea name="warning" rows="3" cols="76" ><%=warning==null?"":warning %></textarea>
					</td>
				</tr>
				
			</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td>
						ʵ���Ҳ��Է�����
						<%
						String testPlan ="";
					if(rptype.equals("���ı���")){
						testPlan=flow.getTestplanC();
						}
						else if(rptype.equals("Ӣ�ı���")){
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
						���������Ϣ��
					</td>
					<td>
						<textarea name="appform" cols="80" rows="4"><%=appform==null?"":appform %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						���ñ�ע���ݣ�
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
					value="�޸�" onclick="check(2);">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		<%
		}
		 %>
	
		
		
		
			


			
			
		</form>
	</body>
</html>
