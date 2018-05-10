<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>

<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	//System.out.println(sid+":sid");
	if(sid == null || "".equals(sid)) {
		response.sendRedirect("project_manage.jsp");
		return;
	}
	String ptype = new String(request.getParameter("ptype").getBytes("ISO-8859-1"),"UTF-8");
	Project p = null;
	if(!("��ѧ����".equals(ptype)||"��ױƷ".equals(ptype)||"����".equals(ptype))) {
		p = PhyProjectAction.getInstance().getProjectBySid(sid);
	} else {

		p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	}
	if(p == null) {
		response.sendRedirect("project_manage.jsp");
		return;
	}
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	String contact = "";
	String rptype = "";
	Date rptime = null;
	String engineer = "";
	String servname = "";
	String status = "";
	 
	if(!("��ѧ����".equals(ptype)||"��ױƷ".equals(ptype)||"����".equals(ptype))) {
		PhyProject pp = (PhyProject)p.getObj();
		contact = pp.getContact();
		rptype = pp.getRptype();
		rptime = pp.getRptime();
		engineer = pp.getEngineer();
		servname = pp.getServname();
		status = pp.getStatus();
	} else {
		ChemProject cp = (ChemProject)p.getObj();
		contact = cp.getContact();
		rptype = cp.getRptype();
		rptime = cp.getRptime();
		engineer = cp.getEngineer();
		servname = cp.getServname();
		status = cp.getStatus();
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>����������</title>
		<link rel="stylesheet" href="..//css/drp.css">
		<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>

		<script language="javascript">
		
		function goBack() {
		window.self.location="project_manage.jsp?command=search&pid=<%=p.getPid()%>";
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("addappform").value += temp;
			document.getElementById("addappform").value += "\n";
		}
		function addInorganic(temp0) {
			document.getElementById("inorganic").value += temp;
			document.getElementById("inorganic").value += "\n";
		}
		function addInorganicDetail(temp1) {
			document.getElementById("inorganicdetail").value += temp1;
			document.getElementById("inorganicdetail").value += "\n";
		}
		function addOrganic(temp2) {
			document.getElementById("organic").value += temp2;
			document.getElementById("organic").value += "\n";
		}
		function addOrganicDetail(temp3) {
			document.getElementById("organicdetail").value += temp3;
			document.getElementById("organicdetail").value += "\n";
		}
		function addfood(temp4) {
			document.getElementById("food").value += temp4;
			document.getElementById("food").value += "\n";
		}
	</script>

	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">

		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>&nbsp; 
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;�������&gt;&gt;��Ŀ����Ǽ�</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" method="post" action="projectlog_post.jsp">
		<input type="hidden" name ="ptype" id ="ptype" value="<%=ptype %>">
			<input name="sid" value="<%=p.getSid() %>" type="hidden" />
			<div class="outborder" align="center">
				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							���۵���ţ�
						</td>
						<td>
							<input name="pid" type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getPid() %>" />
						</td>

						<td width="99">
							��Ŀ���ͣ�
						</td>
						<td width="451">

							<input type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getPtype() %>" />
						</td>

					</tr>
					<tr>
						<td>
							��Ŀ�ȼ���
						</td>
						<td>
							<input type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getLevel()==null?"":p.getLevel() %>" />
						</td>
						<td>
							������Ա��
						</td>
						<td>
							<input name="sales" type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSales() %>" />
						</td>
					</tr>

					<tr>

						<td>
							�ͻ����ƣ�
						</td>
						<td>
							<input size="60" height="20" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getClient() %>" />
						</td>
						<td width="100">
							�ͻ���ϵ�ˣ�
						</td>
						<td width="449">
							<input size="60" height="20" readonly="readonly"
								value="<%=contact%>" style="background-color: #F2F2F2" />
						</td>
					</tr>
					<tr>
						<td>
							�����ţ�
						</td>
						<td>
							<input name="rid" type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2" value="<%=p.getRid() %>" />
						</td>
						<td>
							�������ͣ�
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2" value="<%=rptype %>" />
						</td>
					</tr>
					<tr>
						<td width="100">
							����Ӧ��ʱ�䣺
						</td>
						<td width="449">
							<input size="60" height="20" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=rptime==null?"":rptime %>" />
						</td>
						<td>
							��Ŀ����ʦ��
						</td>
						<td>
							<input size="60" height="20" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=engineer %>" />
						</td>

					</tr>
					<tr>
						<td>
							�ͷ���Ա��
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2" value="<%=servname %>" />
						</td>
						<td>
							��Ŀ״̬��
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2" value="<%=status %>" />
						</td>
					</tr>
					<tr>
						<td>
							�ŵ���Ա��
						</td>
						<td>
							<input type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getBuildname() %>" />
						</td>
						<td>
							����ʱ�䣺
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2"
								value="<%=p.getBuildtime() %>" />
						</td>
					</tr>
				</table>

				
			</div>
			<div class="outborder" align="center">
				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="116">
							����Ŀ��
						</td>
						<td width="168">
							<input name="price" style="background-color: #F2F2F2"
								type="text" readonly="readonly" size="60" height="20"
								value="<%=p.getPrice() %>" />
						</td>
						<td width="116">
							ʵ��ҵ����
						</td>
						<td width="168">
							<input name="assist" type="text" size="60" height="20" value="<%=p.getAssist()>0?p.getAssist():p.getPrice()%>" />
						</td>
						
					</tr>
					<tr>
						<td width="132">
								�ⲿ�ְ���AԤ�ƣ�
							</td>
							<td width="263">
								<input name="presubcost" type="text" size="60" height="20"
									value="<%=p.getPresubcost() %>" />
							</td>
						<td>
							�ⲿ�ְ�����A���ƣ�
						</td>
						<td>
							<input name="subname" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								<%=(p.getSubname()==null||"".equals(p.getSubname()))?"":("value='" + p.getSubname() + "' readonly='readonly' style='background-color: #F2F2F2'") %>
								 />
						</td>
						
					</tr>
					<tr>
						<td>
							ʵ���ⲿ�ְ���A��
						</td>
						<td>
							<input name="subcost" type="text"  size="60" height="20"
								<%=p.getSubcost()==0?"":("value='" + p.getSubcost() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
						<td>
							�ⲿ�ְ���A֧�����ڣ�
						</td>
						<td>
							<input name="subcosttime" type="text"  size="60" height="20"
								<%=p.getSubcosttime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + p.getSubcosttime() + "' readonly='readonly' style='background-color: #F2F2F2'") %>
							 />
						</td>
						
					</tr>
					<tr>
						<td>
							�ⲿ�ְ���A֧��Ʊ�ݣ�
						</td>
						<td>
							<input name="subcostnotes" type="text"  size="60" height="20"
								<%=(p.getSubcostnotes()==null||"".equals(p.getSubcostnotes()))?"":("value='" + p.getSubcostnotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
						<td width="132">
							�ⲿ�ְ���BԤ�ƣ�
						</td>
						<td width="263">
							<input name="presubcost2" type="text" size="60" height="20"
								value="<%=p.getPresubcost2() %>" />
						</td>
					</tr>
					<tr>
						<td>
							�ⲿ�ְ�����B���ƣ�
						</td>
						<td>
							<input name="subname2" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								<%=(p.getSubname2()==null||"".equals(p.getSubname2()))?"":("value='" + p.getSubname2() + "' readonly='readonly' style='background-color: #F2F2F2'") %>
								 />
						</td>
						<td>
							ʵ���ⲿ�ְ���B��
						</td>
						<td>
							<input name="subcost2" type="text"  size="60" height="20"
								<%=p.getSubcost2()==0?"":("value='" + p.getSubcost2() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
					</tr>
					<tr>
						<td>
							�ⲿ�ְ���B֧�����ڣ�
						</td>
						<td>
							<input name="subcosttime2" type="text"  size="60" height="20"
								<%=p.getSubcosttime2()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + p.getSubcosttime2() + "' readonly='readonly' style='background-color: #F2F2F2'") %>
							 />
						</td>
						<td>
							�ⲿ�ְ���B֧��Ʊ�ݣ�
						</td>
						<td>
							<input name="subcostnotes2" type="text"  size="60" height="20"
								<%=(p.getSubcostnotes2()==null||"".equals(p.getSubcostnotes2()))?"":("value='" + p.getSubcostnotes2() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
					</tr>

					<tr>
						<td>
							�ڲ��ְ��ѣ�
						</td>
						<td>
							<input name="insubcost" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getInsubcost() %>" />
						</td>
						<td>
							�ڲ��ְ�˵����
						</td>
						<td>
							<input name="insubtag" type="text"  size="60" height="20"
								<%=(p.getInsubtag()==null||"".equals(p.getInsubtag()))?"":("value='" + p.getInsubtag() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder" align="center">
				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							��������Ԥ�ƣ�
						</td>
						<td>
							<input name="preagcost" type="text"  size="60" height="20"
								value="<%=p.getPreagcost() %>" />
						</td>
						<td>
							ʵ�ʻ������ã�
						</td>
						<td>
							<input name="agcost" type="text"  size="60" height="20"
								<%=p.getAgcost()==0?"":("value='" + p.getAgcost() + "' readonly='readonly' style='background-color: #F2F2F2'") %>
								/>
						</td>
					</tr>
					<tr>
						<td>
							�������ƣ�
						</td>
						<td>
							<input name="agname" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getAgname()==null?"":p.getAgname() %>" />
						</td>
						<td>
							����֧�����ڣ�
						</td>
						<td>
							<input name="agtime" type="text"  size="60" height="20"
								<%=p.getAgtime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + p.getAgtime() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
					</tr>
					<tr>
						<td>�������ñ�ע</td>
						<td>
						<textarea name="agremarks" rows="3" cols="80"><%=p.getAgremarks()==null?"":p.getAgremarks() %></textarea>
						</td>
					</tr>
					<tr>
						<td>
							�ͻ��Խɣ�
						</td>
						<td>
							<input name="clientpay" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%="y".equals(p.getClientpay())?"��":"��" %>" />
						</td>
						<td>
							����֧��Ʊ�ݣ�
						</td>
						<td>
							<input name="agnotes" type="text"  size="60" height="20"
								<%=(p.getAgnotes()==null||"".equals(p.getAgnotes()))?"":("value='" + p.getAgnotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>

					</tr>
					<tr>
						<td>
							�������ã�
						</td>
						<td>
							<input name="otherscost" type="text"  size="60" height="20"
							<%=p.getOtherscost()==0?"":("value='" + p.getOtherscost() + "' readonly='readonly' style='background-color: #F2F2F2'") %>	
							 />
						</td>
						<td>
							�������ñ�ע��
						</td>
						<td>
							<input name="otherstag" type="text"  size="60" height="20"
								<%=(p.getOtherstag()==null||"".equals(p.getOtherstag()))?"":("value='" + p.getOtherstag() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
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
			<div class="outborder" align="center" <%=dis %>>
				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							��Ʊ��ͷ��
						</td>
						<td>
							<input type="text" height="20" name="invhead"
								readonly="readonly"
								style="background-color: rgb(242, 242, 242);" size="60"
								value="<%=p.getInvhead() %>" />
						</td>
						<td>
							��Ʊ���ݣ�
						</td>
						<td>
							<input name="invcontent" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getInvcontent() %>" />
						</td>
					</tr>
					<tr>
						<td width="116">
							��Ʊ��
						</td>
						<td width="168">
							<input name="preinvprice" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getPreinvprice() %>" />
						</td>
						<td width="132">
							��Ʊʵ�ʽ�
						</td>
						<td width="263">
							<input name="invprice" type="text"  size="60" height="20"
								<%=p.getInvprice()==0?"":("value='" + p.getInvprice() + "' readonly='readonly' style='background-color: #F2F2F2'") %>
								 />
						</td>
					</tr>
					<tr>
						<td>
							����Ʊ��ʽ��
						</td>
						<td>
							<input type="text" height="20" name="invtype"
								readonly="readonly"
								style="background-color: rgb(242, 242, 242);" size="60"
								value="<%=p.getInvtype() %>" />
						</td>
						<td>
							<br>
						</td>
						<td>
							&nbsp;
							<br>
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							����Ŀҵ�����������
						</td>
						<td width="33%">
							<input name="ppreacount" type="text" size="40" readonly='readonly' style='background-color: #F2F2F2'
							 value="<%=p.getPpreacount()==0?"":p.getPpreacount() %>"	
							 />
						</td>
						<td width="17%">
							����Ŀҵ�����������
						</td>
						<td width="33%">
							<input name="pacount" type="text" size="40"
								<%=p.getPacount()==0?"":("value='" + p.getPacount() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="����Ǽ�">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
	</body>
</html>
