<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.List"%>
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
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	ChemProject cp = (ChemProject)p.getObj();
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�༭</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
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
							<b>��ⲿ����&gt;&gt;������Ŀ</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" method="post" action="labmodify_post.jsp">
			<input name="sid" type="hidden" value="<%=p.getSid() %>">
			<input name="oldwarning" type="hidden" value="<%=cp.getWarning() %>">
			<table cellpadding="5" cellspacing="0"  width="95%">
				<tr>
					<td width="18%">
						�����ţ�
					</td>
					<td width="33%">
						<input name="rid" type="text" value="<%=p.getRid() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td width="17%">
						��Ŀ���ͣ�
					</td>
					<td width="33%">
						<input name="ptype" type="text" value="<%=p.getPtype() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						����Ӧ��ʱ�䣺
					</td>
					<td>
						<input name="rptime" type="text" value="<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
					<td>
						�������ͣ�
					</td>
					<td>
						<input name="rptype" type="text" value="<%=cp.getRptype() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						��Ŀ�ȼ���
					</td>
					<td>
						<input name="level" type="text" value="<%=p.getLevel()==null?"":p.getLevel() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
			</table>
			<table cellpadding="5" cellspacing="5"  width="95%">
				<tr>
					<td width="17%">
						��Ʒ���ƣ�
					</td>
					<td>
						<input name="samplename" type="text" size="80" value="<%=cp.getSamplename()==null?"":cp.getSamplename() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>
				<tr>
					<td>
						��Ʒ����
					</td>
					<td>
						<input name="samplecount" type="text" size="80" value="<%=cp.getSamplecount()==null?"":cp.getSamplecount() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>
				</tr>
				<tr>
					<td>
						������Ʒ������
					</td>
					<td>
						<textarea name="sampledesc" cols="80" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=cp.getSampledesc()==null?"":cp.getSampledesc() %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						������Ŀ��
					</td>
					<td>
						<input name="testcontent" type="text" size="80" value="<%=p.getTestcontent()==null?"":p.getTestcontent() %>" readonly="readonly" style="background-color: #F2F2F2"/>
					</td>

				</tr>
			</table>
			
			<table cellpadding="5" cellspacing="5" width="95%" >
				<tr>
					<td width="17%">
						��Ŀ����ʦ��
					</td>
					<td width="33%">
						<select name="engineer" style="width: 300px">
						
						<%
						List<String> list = FlowFinal.getInstance().getEngineer("��ѧ���̲�");
       					 for(int i=0;i<list.size();i++) {
       					 	String engineer = list.get(i);
						 %>
							<option value="<%=engineer %>" <%=engineer.equals(cp.getEngineer())?"selected":"" %>>
								<%=engineer %>
							</option>
							
						<%
						}
						 %>
							
						</select>
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<!-- <td width="17%">
						��Ŀ���֣�
					</td>
					<td width="33%">
						<input name="workpoint" type="text" value="<%=cp.getWorkpoint()==null?"":cp.getWorkpoint() %>" />
					</td>
					 -->
				</tr>

			</table>
			

			<table cellpadding="5" cellspacing="5" width="95%" >
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
						����Ԥ����ע��
					</td>
					<td>
						<textarea name="warning" rows="3" cols="84"><%=cp.getWarning()==null?"":cp.getWarning() %></textarea>
					</td>
				</tr>

			</table>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnBack" class="button1" type="submit" id="btnBack"
					value="����" />
					&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
