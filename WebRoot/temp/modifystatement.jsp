<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}
	
	Project p = ProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}
	
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	
	if(qt == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��Ŀ�ֽ�</title>
		<link rel="stylesheet" href="../css/drp.css">
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>

    <script src="../javascript/jquery.autocomplete.js"></script> 
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}


</style>

<script type="text/javascript">
function goBack() {
		window.history.back();
	}
	
	function showrid() {
		window.open("showrid.jsp","","dialogWidth:800px;dialogHeight:600px");
	}
	
	
	function changeSelect(invtype) {
		if(invtype.value.match("����")) {
			document.getElementById("invhead").readOnly=true;
			document.getElementById("invhead").style.background="#F2F2F2";
			document.getElementById("invhead").value = "";
			
			document.getElementById("invcontent").readOnly=true;
			document.getElementById("invcontent").style.background="#F2F2F2";
			document.getElementById("invcontent").value = "";
			
			document.getElementById("preinvprice").readOnly=true;
			document.getElementById("preinvprice").style.background="#F2F2F2";
			document.getElementById("preinvprice").value = "";
			
		} else {
			document.getElementById("invhead").readOnly=false;
			document.getElementById("invhead").style.background="#FFFFFF";
			
			document.getElementById("invcontent").readOnly=false;
			document.getElementById("invcontent").style.background="#FFFFFF";
			
			document.getElementById("preinvprice").readOnly=false;
			document.getElementById("preinvprice").style.background="#FFFFFF";
			
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
					<img src="../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;���۹���&gt;&gt;�޸���Ŀ���˵�</b>
				</td>
			</tr>
		</table>

		<hr width="97%" align="center" size=0>

		<form name="form1" action="modifystatement_post.jsp" method="post">
			<input type="hidden" name="sid" value="<%=p.getSid() %>">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>

						<td>
							���۵���ţ�
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=qt.getPid()==null?"":qt.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							���۵����ͣ�
						</td>
						<td>
							<input name="quotype" size="40" type="text"
								value="<%=qt.getQuotype()==null?"":"new".equals(qt.getQuotype())?"�±��۵�":"�����زⱨ�۵�" %>"
								readonly="readonly" style="background-color: #F2F2F2" />
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
						��Ŀ�ܽ�					</td>
					<td>
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>"/>				  </td>
					</tr>
				</table>
			</div>
<p>&nbsp;</p>
			<div class="outborder">
				<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						��Ŀ���ͣ�
					</td>
					<td width="33%">
						<select name="ptype" id="ptype" style="width: 300px">
							<option value="��ѧ����" selected>
								��ѧ����
							</option>
							<option value="�������">
								�������
							</option>
							<option value="EMC����">
								EMC����
							</option>
							<option value="�����ܲ���">
								�����ܲ���
							</option>
						</select>
						<script type="text/javascript">
								var ops = document.getElementById("ptype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=p.getPtype()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
					</td>
					<td width="17%">
							����ͻ����ƣ�
						</td>
						<td width="33%">
							<input id="rpclient" type="text" name="rpclient" size="40" />
							 <script>   
						        $("#rpclient").autocomplete("../client_ajax.jsp",{
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
				</table>
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="17%">
						����Ŀ��
					</td>
					<td width="33%">
						<input name="price" type="text" value="<%=p.getPrice() %>" size="40" />
					</td>
					<td width="17%">
						�ڲ��ְ���Ԥ�ƣ�
					</td>
					<td width="33%">
						<input name="insubcost" type="text" value="<%=p.getInsubcost() %>" size="40" />
					</td>
				</tr>
				<tr>
					<td>
						�ⲿ�ְ���AԤ�ƣ�
					</td>
					<td>
						<input name="presubcost1" type="text" value="<%=p.getPresubcost() %>" size="40" />
					</td>
					<td>
						�ⲿ�ְ�����A���ƣ�
					</td>
					<td>
						<select name="subname1" id="subname1" style="width: 300px">
							<option selected value="">��ѡ��</option>
							<option value="SGS">SGS</option>
							<option value="INTERTEK">INTERTEK</option>
							<option value="CTI">CTI</option>
							<option value="SMQ">SMQ</option>
							<option value="����">����</option>
						</select>
						<script type="text/javascript">
								var obj = document.getElementById("subname1");
								var str2 = "<%=p.getSubname()%>";
								for(var i=0;i<obj.children.length;i++) {
									var str1 = obj.children[i].value;
									if(str1.indexOf(str2)==0 && str2.indexOf(str1)==0){
										obj.children[i].selected = true;
									}
								}
						</script>
					</td>
				</tr>
				<tr>
					<td>
						�ⲿ�ְ���BԤ�ƣ�
					</td>
					<td>
						<input name="presubcost2" type="text" value="<%=p.getPresubcost2() %>" size="40" />
					</td>
					<td>
						�ⲿ�ְ�����B���ƣ�
					</td>
					<td>
						<select name="subname2" id="subname2" style="width: 300px">
							<option selected value="">��ѡ��</option>
							<option value="SGS">SGS</option>
							<option value="INTERTEK">INTERTEK</option>
							<option value="CTI">CTI</option>
							<option value="SMQ">SMQ</option>
							<option value="����">����</option>
						</select>
						<script type="text/javascript">
								var obj = document.getElementById("subname2");
								var str2 = "<%=p.getSubname2()%>";
								for(var i=0;i<obj.children.length;i++) {
									var str1 = obj.children[i].value;
									if(str1.indexOf(str2)==0 && str2.indexOf(str1)==0){
										obj.children[i].selected = true;
									}
								}
						</script>
					</td>
				</tr>
				<tr>
					<td>
						������������Ԥ�ƣ�
					</td>
					<td>
						<input name="preagcost" type="text" value="<%=p.getPreagcost() %>" size="40" />
					</td>
					<td>
						�����������ƣ�
					</td>
					<td>
						<select name="agname" id="agname" style="width: 300px">
							<option selected value="">��ѡ��</option>
							<option value="TUV SUD">TUV SUD</option>
							<option value="TUV RH">TUV RH</option>
							<option value="����">����</option>
						</select>
						<script type="text/javascript">
								var obj = document.getElementById("agname");
								var str2 = "<%=p.getAgname()%>";
								for(var i=0;i<obj.children.length;i++) {
									var str1 = obj.children[i].value;
									if(str1.indexOf(str2)==0 && str2.indexOf(str1)==0){
										obj.children[i].selected = true;
									}
								}
						</script>
					</td>
				</tr>
				
				</table>
				</div>
			
			
				<%
					String dis = "";
					if("����Ŀ".equals(qt.getInvmethod())) {
						dis = "style='display: none;'";
					}
				 %>
				
				<div class="outborder" <%=dis %>>
				 <p>&nbsp;</p>
				<table cellpadding="5" cellspacing="5" width="95%" >
				<tr>
					<td width="17%">
						��Ʊ��
					</td>
					<td width="33%">
						<input name="preinvprice" id="preinvprice" type="text" value="<%=p.getPreinvprice() %>" size="40" />
					</td>

					<td width="17%">
						����Ʊ��ʽ��
					</td>
					<td width="33%">
						<select name="invtype" id="invtype" style="width: 300px" onchange="changeSelect(this);">
							<option value="ȫ��" selected>
								ȫ��
							</option>
							<option value="������������">
								������������
							</option>
							<option value="����">
								����
							</option>
							<option value="�վ�">
								�վ�
							</option>
						</select>
						<script type="text/javascript">
							var ops = document.getElementById("invtype").options;
							var str2 = "<%=p.getInvtype()%>";
							for(var i=0;i<obj.children.length;i++) {
								var str1 = obj.children[i].value;
								if(str1.indexOf(str2)==0 && str2.indexOf(str1)==0){
									obj.children[i].selected = true;
								}
							}
						</script>
					</td>

				</tr>
				<tr>
					<td>
						��Ʊ��ͷ��
					</td>
					<td>
						<input name="invhead" id="invhead" type="text" value="<%=p.getInvhead()==null?"":p.getInvhead() %>" size="40" />
					</td>
					<td>
						��Ʊ���ݣ�
					</td>
					<td>
						<input name="invcontent" id="invcontent" type="text" value="<%=p.getInvcontent()==null?"":p.getInvcontent() %>" size="40" />
					</td>
				</tr>
			</table>
			</div>
				


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="�޸�">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onclick="goBack()" />
				</div>
				<p>
					&nbsp;
				</p>
		</form>
	</body>
</html>
