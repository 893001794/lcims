<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Map"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String sidStr = request.getParameter("sid");
	Quotation qt = null;
	String[] sidLeng =sidStr.split(",");
	String sid="";
	if(sidLeng.length<1){
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
	}else{
		sid=sidLeng[0];
	}
	
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}
	qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	
	if(qt == null) {
		qt = new Quotation();
	}
	String type="";

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>化学项目排单</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script src="../../javascript/orderscript.js"></script>
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
		<script src="../../javascript/jquery.autocomplete.js"></script>
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>
		<script language="javascript">
		function goBack() {
			window.history.back();
		}
		function addAppform(temp) {
			document.getElementById("appform").value += temp;
			document.getElementById("appform").value += "\n";
		}
		function showrid() {
		window.open("../../project/showrid.jsp","","dialogWidth:800px;dialogHeight:1200px","scrollbars=yes,resizable=yes");
	}
	
		function checkForm(obj) {
			if(document.form1.samplename.value == "") {
				alert("样品名称不可为空!");
				return false;
			}
			if(document.form1.testcontent.value == "") {
				alert("测试项目不可为空!");
				return false;
			}
			var draftV="";
			if(obj=="new"){
			}else{
				if(document.getElementById("draftC").checked ==true){
					draftV=document.getElementById("draftC").value;
				
				}
			}
		document.form1.action="buildproject_post.jsp?draft="+draftV;
		document.form1.submit();
		}
		
	</script>

	</head>
	<body class="body1">
	<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>客服管理&gt;&gt;化学项目排单</b>
				</td>
			</tr>
		</table>
		<hr width="100%" align="center" size=0>
		<form name="form1" id ="form1" action="buildproject_post.jsp" method="post">
			<input type="hidden" name="id" value="<%=p.getId() %>" >
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
						<td>
							报价单编号：
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=p.getPid()==null?"":p.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							报价单类型：
						</td>
						<td width="33%">
						<%
						String strquo = "";
						if("new".equals(qt.getQuotype())) 
							strquo = "新报价单";
						else if("add".equals(qt.getQuotype()))
							strquo = "补充重测报价单";
						else if("mod".equals(qt.getQuotype()))
							strquo = "修改报告报价单";
						 %>
							<input name="quotype" size="40" type="text"
								value="<%=strquo %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>

					</tr>
					<tr>
						<td>
							项目编号：
						</td>
						<td>
							<input name="sid" size="40" type="text" value="<%=sidStr%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							项目类型：
						</td>
						<td width="33%">
							<input name="ptype" size="40" type="text"
								value="<%=p.getPtype() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td>
							客户名称：
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<%
							if(p.getPtype() !=null && p.getPtype().equals("化妆品")){
							%>
							<td>
								化妆品申请单id
							</td>
							<td>
								<input name="comappid" size="40" value="" />
							</td>
							<%}else{
							%>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
							<%}
						 %>
						
					</tr>
				</table>
			</div>
			<br>
			<div class="outborder">

				<%
			if(!"new".equals(qt.getQuotype())) {
			type="new";
			
			 %>
			  	<input name="samplename" type="hidden" size="80" value="sample" />
				<input name="testcontent" type="hidden" size="80" value="<%=p.getTestcontent() %>" />
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td>
							报告编号：
						</td>
						<td>
							<input name="rid" id="rid" type="text" value="" 
								size="40"/>
							<input name="show" type="button" value="选择关联报告"
								onclick="showrid();" />
						</td>
						<td width="17%">
							报告应出时间：
						</td>
						<td width="33%">
							<input name="rptime" type="text" id="rptime" size="40" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'rptime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>
						</tr>
					<tr>
						<td>
							项目等级：
						</td>
						<td>
							<select name="level" style="width: 300px">
								<option value="普通" selected="selected">
									0级-普通
								</option>
								<option value="加急">
									1级-加急
								</option>
								<option value="特急">
									2级-特急
								</option>
							</select>
						</td>
						<td>
							报告客户名称：
						</td>
						<td>
							<input name="rpclient" size="40" value="<%=qt.getRpclient()%>" readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
				</table>
				<%
				} else {
				 %>
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>

						<td>
							<div id="mydiv">
								自测
								<input type="checkbox" name="type" value="自测" checked
									onClick="chooseOne(this);" />
								|&nbsp; 机构合作
								<input type="checkbox" name="type" value="机构合作"
									onClick="chooseOne(this);" />

							</div>
							<input type="hidden" value="" name="checkboxVale" id ="checkboxVale">
							<script>   
							
					     function chooseOne(cb) {   
					         var obj = document.getElementById("mydiv"); 
							 var form1=document.getElementById("form1"); 
							 var  isout=document.getElementById("isout"); 
					         var a;
					         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb) {   
						             obj.children[i].checked = false;  
						              //a=obj.children[i].value;
						             } 
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else {
						             obj.children[i].checked = true;   
						             
						              for (j=0; j<form1.isout.length; j++){   
											          a=form1.isout[j].value;
											         if(a == "y"){
											             if(obj.children[i].value=="机构合作"){
							           					form1.isout[j].disabled=true;
							            				}else{
							            				 form1.isout[j].disabled=false;
							            				}
										             }   
								             }
						             
						        // alert(a);
						     		}   
						     	}
					     	}
 					</script>
						</td>
						
						<td>
							<div id="mydiv2">
								中山实验室
								<input type="checkbox" name="lab" value="中山实验室" checked
									onClick="chooseOne2(this);" />
								|&nbsp; 东莞实验室
								<input type="checkbox" name="lab" value="东莞实验室"
									onClick="chooseOne2(this);" />
							</div>
							<script>   
					     function chooseOne2(cb) {   
					         var obj = document.getElementById("mydiv2");   
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
					<tr>
						<td>
							外包： 
							否
							<input type="radio" name="isout" id="isout" value="n" checked >
							是
							<input type="radio" name="isout" id="isout" value="y" />
													</td>
						<td>
							散单
							<input type="radio" name="item" id="item" value="散单" checked onclick="draft(this.value);"/>
							食品
							<input type="radio" name="item" id="item" value="食品"  onclick="draft(this.value);"/>
							成品
							<input type="radio" name="item" id="item" value="成品" onclick="draft(this.value);" />
							非特化妆品
							<input type="radio" name="item" id="item" value="化妆品非" onclick="draft(this.value);" />
							特化妆品
							<input type="radio" name="item" id="item" value="化妆品特" onclick="draft(this.value);" />
							LC化妆品
							<input type="radio" name="item" id="item" value="化妆品LC" onclick="draft(this.value);" />
							环境
							<input type="radio" name="item" id="item" value="环境" onclick="draft(this.value);" />
							
							<script type="text/javascript">
								function draft(obj){
									var mydiv =document.getElementById("draft");
									var mydraft =document.getElementById("draftC");
									var filing =document.getElementById("filingNoTable");
									if(obj =="食品")	{
									mydraft.disabled=true;
									mydraft.checked=false;
									}	
									if(obj =="散单"||obj.indexOf("化妆品")||obj.indexOf("环境")>-1)	{
									mydraft.disabled=false;
									mydraft.checked=false;
									}	
									if(obj =="成品")	{
									mydraft.disabled=true;
									mydraft.checked=true;
									}	
									if(obj.indexOf("化妆品特")>-1||obj.indexOf("化妆品非")>-1){
										filing.style.display="block"; 
									}else{
										filing.style.display="none";
									}	
								}
									
							</script>
							&nbsp;草稿版&nbsp;<input type="checkbox" value="y" name="draftC" id ="draftC">
						</td>
					</tr>
				</table>
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td width="17%">
							报告类型：
						</td>
						<td width="33%">
							<select name="rptype" style="width: 300px">
								<option>
									中文报告
								</option>
								<option>
									英文报告
								</option>
								<option>
									双语报告
								</option>
								<option>
									不出报告
								</option>
								<option>
									其他
								</option>
							</select>
						</td>
						<td width="17%">
							报告应出时间：
						</td>
						<td width="33%">
							<input name="rptime" type="text" id="rptime" size="40" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'rptime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>

					</tr>

					<tr>
						<td>
							项目等级：
						</td>
						<td>
							<select name="level" style="width: 300px">
								<option value="普通" selected="selected">
									0级-普通
								</option>
								<option value="加急">
									1级-加急
								</option>
								<option value="特急">
									2级-特急
								</option>
							</select>
						</td>
						<td>
							客服人员：
						</td>
						<td>
							<select name="servname" style="width: 300px">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								if(user.getName().equals(map.get(value))){
								%>
								<option value="<%=map.get(value) %>"<%=map.get(value)!=null?"selected":""%>><%=map.get(value) %></option>
								<%
								}else{
								
								 %>
								<option value="<%=map.get(value) %>"><%=map.get(value) %></option>
								<%
								 }
								 }
								%>
							</select>
						</td>
					</tr>
				</table>






				<table cellpadding="5" cellspacing="5" width="95%">

					<tr>
						<td width="17%">
							客户联系人：
						</td>
						<td width="33%">
							<select name="contact" style="width: 300px">
								<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client != null) {
								List<ContactForm> contacts = ClientAction.getInstance().getContacts(client.getClientid());
								for(int i=0;i<contacts.size();i++) {
									ContactForm contact = contacts.get(i);
						 %>
								<option value="<%=contact.getContact() %>"><%=contact.getContact() %></option>
								<%
							 	}
							 }
						  %>

							</select>
						</td>
						<td width="17%">
							报告客户名称：
						</td>
						<td>
							<input name="client" type="text" id="client" size="40"
								onchange="validateclient(this);"  value="<%=qt.getRpclient() %>" readonly="readonly" style="background-color: #F2F2F2"  />
							<script>   
						        $("#client").autocomplete("../../client_ajax.jsp",{
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

					</tr>
				</table>
				<table cellpadding="5" cellspacing="5" width="95%" id="filingNoTable" style="display: none;">
					<tr>
						<td width="17%">
							备案企业编号：
						</td>
						<td width="33%">
							<input id="filingNo" name="filingNo" value="044" size="40" type="text" readonly="readonly" style="background-color: #F2F2F2" >
						</td>
						<td width="17%">
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>

					</tr>
				</table>
				</div>
				<div class="outborder">
					<table cellpadding="5" cellspacing="5" width="95%">

						<tr>
							<td width="17%">
								样品名称：
							</td>
							<td>
								<input name="samplename" type="text" size="80" value="<%=qt.getObject()==null?"":qt.getObject()%>" />
							</td>

						</tr>

						<tr>
							<td>
								样品量：
							</td>
							<td>
								<input name="samplecount" type="text" size="80" value="" />
							</td>
						</tr>

						<tr>
							<td>
								测试内容：
							</td>
							<td>
								<input name="testcontent" type="text" size="80"
									value="<%=p.getTestcontent()==null?qt.getProjectcontent():p.getTestcontent() %>" />
							</td>

						</tr>
						<%
				 }
				  %>
				  <tr>
							<td>
								备注：
							</td>
							<td>
								<textarea name="notes" cols="80" rows="6"></textarea>
							</td>
						</tr>
					</table>
					
				</div>


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="添加" onclick="checkForm('<%=type%>')">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack();" />
				</div>
				<p>
					&nbsp;

				</p>
				
		</form>
	</body>
</html>
