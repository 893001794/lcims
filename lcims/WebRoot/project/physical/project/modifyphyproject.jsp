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
		<title>��Ŀ����</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<style type="text/css">
/*�������ı���ɫ*/
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
							<b>���ӵ�������&gt;&gt;�޸���Ŀ</b>
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
							���۵���ţ�
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=p.getPid()==null?"":p.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							���۵����ͣ�
						</td>
						<td width="33%">
							<%
						String strquo = "";
						if("new".equals(qt.getQuotype())) 
							strquo = "�±��۵�";
						else if("add".equals(qt.getQuotype()))
							strquo = "�����زⱨ�۵�";
						else if("mod".equals(qt.getQuotype()))
							strquo = "�޸ı��汨�۵�";
						 %>
							<input name="quotype" size="40" type="text"
								value="<%=strquo %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>

					</tr>
					<tr>
						<td>
							��Ŀ��ţ�
						</td>
						<td>
							<input name="sid" size="40" type="text" value="<%=p.getSid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							��Ŀ���ͣ�
						</td>
						<td width="33%">
							<input name="ptype" size="40" type="text"
								value="<%=p.getPtype() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td>
							�ͻ����ƣ�
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							������Ŀ��
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
							�����ţ�
						</td>
						<td width="33%">
							<input name="rid" id="rid" type="text" value="<%=p.getRid() %>"
								size="40" />
						</td>
						<td width="17%">
							����ʦ��
						</td>
						<td width="33%">
							<select name="engineer" style="width: 300px">
								<%
								List<String> list = FlowFinal.getInstance().getEngineer("���ӵ�����");
		       					 for(int i=0;i<list.size();i++) {
		       					 //����ʦ
		       					 String engineer="";
		       					 engineer=list.get(i);
		       					 //�ж�List���������Ƿ��������+Ӣ��
		       					 if(engineer.indexOf("[")>-1){
		       					 //��������ȡ������������
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
							�������ͣ�
						</td>
						<td width="33%">
							<select name="rptype" id="rptype" style="width: 300px">
								<option value="���ı���">
									���ı���
								</option>
								<option value="Ӣ�ı���">
									Ӣ�ı���
								</option>
								<option value="˫�ﱨ��">
									˫�ﱨ��
								</option>
								<option value="��������">
									��������
								</option>
								<option value="����������">
									����������
								</option>
								<option value="����">
									����
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
							����Ӧ��ʱ�䣺
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
							��Ŀ�ȼ���
						</td>
						<td>
							<select name="level" id="level" style="width: 300px">
								<option value="��ͨ" selected="selected">
									0��-��ͨ
								</option>
								<option value="�Ӽ�">
									1��-�Ӽ�
								</option>
								<option value="�ؼ�">
									2��-�ؼ�
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
							�ͷ���Ա��
						</td>
						<td>
							<select name="servname" id="servname" style="width: 300px">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								//����ʦ
		       					 String servname="";
		       					 servname=map.get(value);
		       					 //�ж�List���������Ƿ��������+Ӣ��
		       					 if(servname.indexOf("[")>-1){
		       					 //��������ȡ������������
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
							�ͻ���ϵ�ˣ�
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
							����ͻ����ƣ�
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
								��Ʒ���ƣ�
							</td>
							<td>
								<input name="samplename" type="text" size="80" value="<%=pp.getSamplename() %>" />
							</td>

						</tr>

						<tr>
							<td>
								��Ʒ����
							</td>
							<td>
								<input name="samplecount" type="text" size="80" value="<%=pp.getSamplecount() %>" />
							</td>
						</tr>
						<!--
						<tr>
							  <td>
								��Ʒ���
							</td>
							<td>
								<input name="samplecategory" type="text" size="80" value="<%=pp.getSamplecategory() %>" />
							</td>
						</tr>
						-->
						<tr>
							<td>
								��Ʒ�ͺţ�
							</td>
							<td>
								<textarea name="samplemodel" id ="samplemodel" cols="80" rows="2"  value=""><%=pp.getSamplemodel()==null?"":pp.getSamplemodel() %></textarea>
							</td>
						</tr>
						<tr>
							<td>
								���ѹ��
							</td>
							<td>
								<input name="ratedvoltage" type="text" size="80" value="<%=pp.getRatedvoltage()==null?"":pp.getRatedvoltage()%>" />
							</td>
						</tr>
						<tr>
							<td>
								�������
							</td>
							<td>
								<input name="ratedcurrent" type="text" size="80" value="<%=pp.getRatedcurrent()==null?"":pp.getRatedcurrent() %>" />
							</td>
						</tr>
						
						<tr>
							<td>
								����ʣ�
							</td>
							<td>
								<input name="ratedpower" type="text" size="80" value="<%=pp.getRatedpower()==null?"":pp.getRatedpower() %>" />
							</td>
						</tr>
						
						<tr>
							<td>
								������
							</td>
							<td>
								<input name="other" type="text" size="80" value="<%=pp.getOther()==null?"":pp.getOther() %>" />
							</td>
						</tr>
						<tr>
							<td>
								��Դ���ͣ�
							</td>
							<td>
								<input name="lightsourcetype" type="text" size="80" value="<%=pp.getLightsourcetype()==null?"":pp.getLightsourcetype() %>" />
							</td>
						</tr>
						
						<tr>
							<td>
								���Ա�׼��
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
								��ע��
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
						value="�޸�">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onClick="goBack()" />
				</div>
				<p>
					&nbsp;

				</p>
		</form>
	</body>
</html>
