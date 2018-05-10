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
<%@ page errorPage="../../error.jsp"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="java.util.Map"%>

<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	Quotation qt = null;
	if (sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;		
	}
	Project p = PhyProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}
	
	PhyProject pp = (PhyProject)p.getObj();
	
	qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	
	if(qt == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>项目立项</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>
		<script src="../../javascript/Calendar.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
		<script src="../../javascript/jquery.autocomplete.js"></script>
		<script language="javascript">
		function goBack() {
			window.history.back();
		}
		function addAppform(temp) {
			document.getElementById("appform").value += temp;
			document.getElementById("appform").value += "\n";
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
							<b>电子电器管理&gt;&gt;修改项目</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>


		<form name="form1" action="modifyphyproject_post.jsp" method="post">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<input type="hidden" name="oldrid" value="<%=p.getRid() %>">
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
							<input name="sid" size="40" type="text" value="<%=p.getSid() %>"
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
						<td>
							测试项目：
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getProjectcontent()==null?"":qt.getProjectcontent() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div class="outborder">

				
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td width="17%">
							报告编号：
						</td>
						<td width="33%">
							<input name="rid" id="rid" type="text" value="<%=p.getRid() %>"
								size="40" />
						</td>
						<td width="17%">
							工程师：
						</td>
						<td width="33%">
							<select name="engineer" style="width: 300px">
								<%
								List<String> list = FlowFinal.getInstance().getEngineer("电子电器部");
		       					 for(int i=0;i<list.size();i++) {
		       					 //工程师
		       					 String engineer="";
		       					 engineer=list.get(i);
		       					 //判断List集合里面是否存在中文+英文
		       					 if(engineer.indexOf("[")>-1){
		       					 //如果有则截取它的中文名称
		       					  engineer = engineer.substring(0,engineer.indexOf("["));
		       					 }
		       					String engineer1="";
		       					engineer1=pp.getEngineer();
		       					if(engineer1 !=null){
		       					if(engineer1.indexOf("[")>-1){
		       					engineer1=engineer1.substring(0,engineer1.indexOf("["));
		       					}
		       					}
								 %>
									<option value="<%=engineer %>" <%=engineer.equals(engineer1)?"selected":"" %>>
										<%=engineer %>
									</option>
									
								<%
								}
								 %>
							</select>
						</td>

					</tr>
				</table>
				
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td width="17%">
							报告类型：
						</td>
						<td width="33%">
							<select name="rptype" id="rptype" style="width: 300px">
								<option value="中文报告">
									中文报告
								</option>
								<option value="英文报告">
									英文报告
								</option>
								<option value="双语报告">
									双语报告
								</option>
								<option value="不出报告">
									不出报告
								</option>
								<option value="出机构报告">
									出机构报告
								</option>
								<option value="其他">
									其他
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("rptype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.indexOf("<%=pp.getRptype()%>")==0 && "<%=pp.getRptype()%>".indexOf(ops[i].value) == 0){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
						<td width="17%">
							报告应出时间：
						</td>
						<td width="33%">
							<input name="rptime" type="text" id="rptime" size="40"
								value="<%=pp.getRptime() %>" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',el:'rptime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>

					</tr>

					<tr>
						<td>
							项目等级：
						</td>
						<td>
							<select name="level" id="level" style="width: 300px">
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
							<script type="text/javascript">
								var ops = document.getElementById("level").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=p.getLevel()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
						<td>
							客服人员：
						</td>
						<td>
							<select name="servname" id="servname" style="width: 300px">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								//工程师
		       					 String servname="";
		       					 servname=map.get(value);
		       					 //判断List集合里面是否存在中文+英文
		       					 if(servname.indexOf("[")>-1){
		       					 //如果有则截取它的中文名称
		       					  servname = servname.substring(0,servname.indexOf("["));
		       					 }
		       					String servname1="";
		       					servname1=pp.getServname();
		       					if(servname1 !=null){
		       					if(servname1.indexOf("[")>-1){
		       					servname1=servname1.substring(0,servname1.indexOf("["));
		       					}
		       					}else{
		       					servname1="";
		       					}
								 %>
								<option value="<%=map.get(value) %>" <%=servname1.equals(servname)?"selected":"" %>><%=map.get(value) %></option>
								<%
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
									String str = "";
									if(pp.getContact() != null) {
										if(pp.getContact().equals(contact.getContact())) {
											str = "selected";
										}
									}
						 %>
								<option value="<%=contact.getContact() %>" <%=str %> ><%=contact.getContact() %></option>
								<%
							 	}
							 }
						  %>

							</select>
						</td>
						<td width="17%">
							报告客户名称：
						</td>
						<td width="33%">
							<input name="rpclient" size="40"
								value="<%=pp.getRpclient()==null?"":pp.getRpclient() %>" />
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
								<input name="samplename" type="text" size="80" value="<%=pp.getSamplename() %>" />
							</td>

						</tr>

						<tr>
							<td>
								样品量：
							</td>
							<td>
								<input name="samplecount" type="text" size="80" value="<%=pp.getSamplecount() %>" />
							</td>
						</tr>
						<!--
						<tr>
							  <td>
								样品类别：
							</td>
							<td>
								<input name="samplecategory" type="text" size="80" value="<%=pp.getSamplecategory() %>" />
							</td>
						</tr>
						-->
						<tr>
							<td>
								样品型号：
							</td>
							<td>
								<textarea name="samplemodel" id ="samplemodel" cols="80" rows="2"  value=""><%=pp.getSamplemodel()==null?"":pp.getSamplemodel() %></textarea>
							</td>
						</tr>
						<tr>
							<td>
								额定电压：
							</td>
							<td>
								<input name="ratedvoltage" type="text" size="80" value="<%=pp.getRatedvoltage()==null?"":pp.getRatedvoltage()%>" />
							</td>
						</tr>
						<tr>
							<td>
								额定电流：
							</td>
							<td>
								<input name="ratedcurrent" type="text" size="80" value="<%=pp.getRatedcurrent()==null?"":pp.getRatedcurrent() %>" />
							</td>
						</tr>
						
						<tr>
							<td>
								额定功率：
							</td>
							<td>
								<input name="ratedpower" type="text" size="80" value="<%=pp.getRatedpower()==null?"":pp.getRatedpower() %>" />
							</td>
						</tr>
						
						<tr>
							<td>
								其他：
							</td>
							<td>
								<input name="other" type="text" size="80" value="<%=pp.getOther()==null?"":pp.getOther() %>" />
							</td>
						</tr>
						<tr>
							<td>
								光源类型：
							</td>
							<td>
								<input name="lightsourcetype" type="text" size="80" value="<%=pp.getLightsourcetype()==null?"":pp.getLightsourcetype() %>" />
							</td>
						</tr>
						
						<tr>
							<td>
								测试标准：
							</td>
							<td>
							<input name="standard" id="standard" type="text" size="80"
									value="" />
									<script>   
						        $("#standard").autocomplete("standard_ajax.jsp",{
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
						<tr>
							<TD>&nbsp;</TD>
							<TD>
							<textarea name="testStandard" id="testStandard" cols="68" rows="6"><%=pp.getTestStandard()==null?"":pp.getTestStandard()%></textarea>
							</TD>
						</tr>

						</tr>

						<tr>
							<td>
								备注：
							</td>
							<td>
								<textarea name="notes" cols="80" rows="4"><%=p.getNotes()==null?"":p.getNotes() %></textarea>
							</td>
						</tr>
					</table>
					<p>
						&nbsp;
					</p>
				</div>


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="修改">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
				<p>
					&nbsp;

				</p>
		</form>
	</body>
</html>
