<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@ page errorPage="../../error.jsp"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="java.util.Date"%>

<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		response.sendRedirect("project_manage.jsp");
		return;
	}
	String ptype = new String(request.getParameter("ptype").getBytes("ISO-8859-1"),"UTF-8");
	Project p = null;
	if(!("��ѧ����".equals(ptype)||"��ױƷ".equals(ptype))) {
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
	 
	if(!("��ѧ����".equals(ptype)||"��ױƷ".equals(ptype))) {
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
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;�������&gt;&gt;��Ŀ������ϸ��Ϣ</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1">
			<div class="outborder" align="center">
				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							�ڲ����˵��ţ�
						</td>
						<td>
							<input name="pid" type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getSid() %>" />
						</td>
						<td>
							���۵���ţ�
						</td>
						<td>
							<input name="pid" type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getPid() %>" />
						</td>
					</tr>
					<tr>
						<td>
							��Ŀ�ȼ���
						</td>
						<td>
							<input type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getLevel() %>" />
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
								value="<%=contact %>"
								style="background-color: #F2F2F2" />
						</td>
					</tr>
					<tr>
						<td>
							�����ţ�
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
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
								readonly="readonly"
								value="<%=rptime==null?"":rptime %>" />
						</td>
						<td>
							��Ŀ����ʦ��
						</td>
						<td>
							<input size="60" height="20" style="background-color: #F2F2F2"
								readonly="readonly"
								value="<%=engineer %>" />
						</td>

					</tr>
					<tr>
						<td>
							�ͷ���Ա��
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2"
								value="<%=servname %>" />
						</td>
						<td>
							������Ա��
						</td>
						<td>
							<input name="rid" type="text" size="60" height="20"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSales() %>" />
						</td>

					</tr>
					<tr>
						<td>
							������Ա��
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
					<tr>
						<td>
							����ˣ�
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2"
								value="<%=p.getAuditman()==null?"":p.getAuditman() %>" />
						</td>
						<td>
							���ʱ�䣺
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2"
								value="<%=p.getAudittime()==null?"":p.getAudittime() %>" />
						</td>
					</tr>
					<tr>
						<td>
							��Ŀ״̬��
						</td>
						<td>
							<input type="text" size="60" height="20" readonly="readonly"
								style="background-color: #F2F2F2" value="<%=status %>" />
						</td>
					</tr>
				</table>

				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="10%">
							����Ҫ��
						</td>
						<td width="90%">
							<textarea name="textarea" cols="60" rows="6" readonly="readonly"
								style="background-color: #F2F2F2"><%=p.getTestcontent()==null?"":p.getTestcontent() %></textarea>
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
							<input name="price" style="background-color: #F2F2F2" type="text"
								readonly="readonly" size="60" height="20"
								value="<%=p.getPrice() %>" />
						</td>
						<td width="116">
							��������ͳ�ƣ�
						</td>
						<td width="168">
							<input name="assist" style="background-color: #F2F2F2" type="text"
								readonly="readonly" size="60" height="20"
								value="<%=p.getAssist()%>" />
						</td>

					</tr>
					<tr>
						<td width="132">
							�ⲿ�ְ���AԤ�ƣ�
						</td>
						<td width="263">
							<input name="presubcost" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getPresubcost() %>" />
						</td>
						<td>
							�ⲿ�ְ�����A���ƣ�
						</td>
						<td>
							<input name="subname" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getSubname()==null?"":p.getSubname() %>" />
						</td>

					</tr>
					<tr>
						<td>
							ʵ���ⲿ�ְ���A��
						</td>
						<td>
							<input name="subcost" type="text" size="60" height="20"
								readonly='readonly' style='background-color: #F2F2F2' value="<%=p.getSubcost()==0?"":p.getSubcost() %>" />
						</td>
						<td>
							�ⲿ�ְ���A֧�����ڣ�
						</td>
						<td>
							<input name="subcosttime" type="text" size="60" height="20"
								readonly='readonly' style='background-color: #F2F2F2'
								value="<%=p.getSubcosttime()==null?"":p.getSubcosttime()%>" />
						</td>

					</tr>
					<tr>
						<td>
							�ⲿ�ְ���A֧��Ʊ�ݣ�
						</td>
						<td>
							<input name="subcostnotes" type="text" size="60" height="20"
								readonly='readonly' style='background-color: #F2F2F2'
								value="<%=p.getSubcostnotes()==null?"":p.getSubcostnotes() %>" />
						</td>
						<td width="132">
							�ⲿ�ְ���BԤ�ƣ�
						</td>
						<td width="263">
							<input name="presubcost2" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
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
								value="<%=p.getSubname2()==null?"":p.getSubname2() %>"
								readonly='readonly' style='background-color: #F2F2F2' />
						</td>
						<td>
							ʵ���ⲿ�ְ���B��
						</td>
						<td>
							<input name="subcost2" type="text" size="60" height="20"
								value="<%=p.getSubcost2()==0?"":p.getSubcost2()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
					<tr>
						<td>
							�ⲿ�ְ���B֧�����ڣ�
						</td>
						<td>
							<input name="subcosttime2" type="text" size="60" height="20"
								value="<%=p.getSubcosttime2()==null?"":p.getSubcosttime2() %>"
								readonly='readonly' style='background-color: #F2F2F2' />
						</td>
						<td>
							�ⲿ�ְ���B֧��Ʊ�ݣ�
						</td>
						<td>
							<input name="subcostnotes2" type="text" size="60" height="20"
								readonly='readonly' style='background-color: #F2F2F2'
								value="<%=p.getSubcostnotes2()==null?"":p.getSubcostnotes2() %>" />
						</td>
					</tr>

					<tr>
						<td>
							�ڲ��ְ��ѣ�
						</td>
						<td>
							<input name="preadvance" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getInsubcost() %>" />
						</td>
						<td>
							�ڲ��ְ�˵����
						</td>
						<td>
							<input name="repaytime2" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getInsubtag()==null?"":p.getInsubtag() %>" />
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
							<input name="preadvance" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getPreagcost() %>" />
						</td>
						<td>
							ʵ�ʻ������ã�
						</td>
						<td>
							<input name="repaytime2" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getAgcost()==0?"":p.getAgcost() %>" />
						</td>
					</tr>
					<tr>
						<td>
							�������ƣ�
						</td>
						<td>
							<input name="preadvance" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getAgname()==null?"":p.getAgname() %>" />
						</td>
						<td>
							����֧�����ڣ�
						</td>
						<td>
							<input name="repaytime2" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getAgtime()==null?"":p.getAgtime() %>" />
						</td>
					</tr>
					<tr>
						<td>
							����֧��Ʊ�ݣ�
						</td>
						<td>
							<input name="preadvance" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getAgnotes()==null?"":p.getAgnotes() %>" />
						</td>

					</tr>
					<tr>
						<td>
							�������ã�
						</td>
						<td>
							<input name="preadvance" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getOtherscost()==0?"":p.getOtherscost() %>" />
						</td>
						<td>
							�������ñ�ע��
						</td>
						<td>
							<input name="repaytime2" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getOtherstag()==null?"":p.getOtherstag() %>" />
						</td>
					</tr>

				</table>

			</div>

			<div class="outborder" align="center">
				<table width="85%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							��Ʊ��ͷ��
						</td>
						<td>
							<input type="text" height="20" name="repaytime"
								readonly="readonly"
								style="background-color: rgb(242, 242, 242);" size="60"
								value="<%=p.getInvhead() %>" />
						</td>
						<td>
							��Ʊ���ݣ�
						</td>
						<td>
							<input name="preadvance" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getInvcontent() %>" />
						</td>
					</tr>
					<tr>
						<td width="116">
							��Ʊ��
						</td>
						<td width="168">
							<input name="totalprice" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getPreinvprice() %>" />
						</td>
						<td width="132">
							��Ʊʵ�ʽ�
						</td>
						<td width="263">
							<input name="paytime" type="text" readonly="readonly"
								style="background-color: #F2F2F2" size="60" height="20"
								value="<%=p.getInvprice()==0?"":p.getInvprice() %>" />
						</td>
					</tr>
					<tr>
						<td>
							����Ʊ��ʽ��
						</td>
						<td>
							<input type="text" height="20" name="repaytime"
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
							<input name="preacount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getPpreacount()==0?"":p.getPpreacount() %>" />
						</td>
						<td width="17%">
							����Ŀҵ�����������
						</td>
						<td width="33%">
							<input name="acount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=p.getPacount()==0?"":p.getPacount() %>" />
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
