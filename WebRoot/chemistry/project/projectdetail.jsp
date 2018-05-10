<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	ChemProject cp = (ChemProject)p.getObj();
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��Ŀ��ϸ��Ϣ</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script language="javascript">
		
		function goBack() {
		window.self.location="javascript:window.history.back();";
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
							<b>�ͷ�����&gt;&gt;�ŵ�</b>
				</td>
			</tr>
		</table>
		<%--<hr width="97%" align="center" size=0>

		<form name=search method=post action=addflow.jsp>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<font color="red">�������������۵��ţ�</font>
						<input type=text name=pid size="25" value=>

						<input type=submit name=Submit value=����>
					</td>
				</tr>
			</table>
		</form>
		--%>
		<hr width="97%" align="center" size=0>
		<form name="form1">
			<table cellpadding="5" cellspacing="0" style="margin-left: 10em">
				<tr>
					<td>
						�����ţ�
					</td>
					<td>
						<input name="pid" type="text" value="<%=p.getRid() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						��Ŀ���ͣ�
					</td>
					<td>
						<input name="pid" type="text" value="<%=p.getPtype() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					
				</tr>
				<tr>
					<td>
						����Ӧ��ʱ�䣺
					</td>
					<td>
						<input type="text" value="<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						�������ͣ�
					</td>
					<td>
						<input name="pid" type="text" value="<%=cp.getRptype() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					
					
				</tr>
				<tr>
					<td>
						�ͷ���Ա��
					</td>
					<td>
						<input type="text" value="<%=cp.getServname()==null?"":cp.getServname() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						������Ա��
					</td>
					<td>
						<input type="text" value="<%=qt.getSales()==null?"":qt.getSales() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						��Ŀ�ȼ���
					</td>
					<td>
						<input type="text" value="<%=p.getLevel()==null?"":p.getLevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						��ױƷ��ţ�
					</td>
					<td>
						<input type="text" value="<%=cp.getFilingNo()==null?"":cp.getFilingNo() %>" readonly="readonly" style="background-color: #F2F2F2" title="��ױƷ������ɵĹ���:ǰ2λ���������GD����㶫����3λ����4λ�ǻ�ױƷ�����ţ���ѡ��ױƷ��GT����GF��LCȷ������5֧��7�Ǳ�����ҵĬ����001�����ŵ�ʱ�����ֹ�¼�룬��8λ��11λ��ϵͳ���2015����12����16����ˮ��������00001"/>
					</td>
				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em;" width="881" height="273">
				<tr>
					<td>
						�ͻ����ƣ�
					</td>
					<td>
						<input size="80" value="<%=qt.getClient() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>
				
				<tr>
					<td>
						����ͻ����ƣ�
					</td>
					<td>
						<input size="80" value="<%=cp.getRpclient() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>

				<tr>
					<td>
						��Ʒ���ƣ�
					</td>
					<td>
						<input type="text" size="80" value="<%=cp.getSamplename()==null?"":cp.getSamplename() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>

				<tr>
					<td>
						��Ʒ����
					</td>
					<td>
						<input type="text" size="80" value="<%=cp.getSamplecount()==null?"":cp.getSamplecount() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						������Ʒ������
					</td>
					<td>
						<textarea name="sampledesc" cols="73" rows="4"  readonly="readonly" style="background-color: #F2F2F2;width: 84%"><%=cp.getSampledesc()==null?"":cp.getSampledesc() %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						������Ŀ��
					</td>
					<td>
						<input type="text" size="80" value="<%=p.getTestcontent()==null?"":p.getTestcontent() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>


			</table>
			

			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">

				<tr>
					<td width="24%">
						��ĿԤ����ע��
					</td>
					<td>
						<textarea name="warning" rows="3" cols="73" readonly="readonly" style="background-color: #F2F2F2;"><%=cp.getWarning()==null?"":cp.getWarning() %></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">

				<tr>
						<td width="24%">
						���������Ϣ��
					</td>
					<td>
						<textarea name="addappform" cols="73" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=cp.getAppform()==null?"":cp.getAppform() %></textarea>
					</td>
				</tr>
				
			</table>
			
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">

				<tr><td valign="top"><br></td><td valign="top"><br></td></tr><tr>
					<td width="24%">
						��ע��
					</td>
					<td>
						<textarea name="notes" cols="73" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=p.getNotes()==null?"":p.getNotes() %></textarea>
					</td>
				</tr>
			</table>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
