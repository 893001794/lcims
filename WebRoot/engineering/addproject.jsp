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
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid");

	//ystem.out.println(rid);
	String up =request.getParameter("up");
	Quotation qt = null;
	Flow f = null;
	
	if (rid == null || "".equals(rid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;		
	}
	f = FlowAction.getInstance().getFlowByPid(rid);
	qt = QuotationAction.getInstance().getQuotationByPid(f.getPid());
	
	
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(f.getSid(),"");
	System.out.println(p);
	if(p == null ) {
		response.sendRedirect("../project/searchproject.jsp");
		return;
	}
	ChemProject cp = (ChemProject)p.getObj();
	//ChemProject cp=ChemProjectAction.getInstance().getItem(pid);
	if(qt ==null){
		qt=new Quotation();
	}
	if(cp ==null){
	cp =new ChemProject();
	}
	int estimate=0;
	estimate=OrderAction.getInstance().getEstimateSpoints(f.getPid());
	List listEngineer =FlowFinal.getInstance().getEngineer("工程部");
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>化学项目排单</title>
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
		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		function addAppform(temp) {
			document.getElementById("appform").value += temp;
			document.getElementById("appform").value += "\n";
		}
		
		function showrid() {
		window.open("../../project/showrid.jsp","","dialogWidth:800px;dialogHeight:600px");
	}
	
		function checkForm(object) {
			if(document.form1.rid.value == "") {
				alert("报告编号不可为空!");
				return false;
			}
			var form1=document.getElementById("form1");
			if(object == 1){
			form1.action="addprojec_post.jsp?start=update";
			}else{
			form1.action="addprojec_post.jsp?start=add";
			}
			form1.submit();
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
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>工程部管理&gt;&gt;添加工程测试</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>


		<form name="form1" action="#" method="post">
			
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
						<td>
							报价单编号：
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=f.getPid()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						
					</tr>
					
					<tr>
						<td>
							测试项目的名称：
						</td>
						<td>
							<input name="projectcontent" size="40" type="text"
								value="<%=qt.getProjectcontent()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							测试项目的编号：
						</td>
						<td>
						<%if(f==null){
						%>
						<input name="sid" size="40" type="text"
								value="" readonly="readonly"
								style="background-color: #F2F2F2" />
						<%
						}else{
						%>
						<input name="sid" size="40" type="text"
								value="<%=f.getSid() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						<%
						}
						 %>
						</td>
					</tr>
					<tr>
						<td>
							报告客户的名称：
						</td>
						<td>
							<input name=rpclient size="40"
								value="<%=cp.getRpclient() == null ?"":cp.getRpclient()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							样品名称：
							
						</td>
						<td>
						<input name="vsamplename" size="40" type="text" value="<%=cp.getSamplename() == null ?"":cp.getSamplename()%>"
						readonly="readonly" style="background-color: #F2F2F2"/>
						</td>
					</tr>
					<%
						String vprojectleader="";
						String projectissuer="";
						String oldWarning ="";
						int itestcount=0;
						List list=ProjectChemImpl.getInstance().getProjectUser(f.getPid());
						if(list.size() !=0){
						 vprojectleader=list.get(0).toString();
						 projectissuer=list.get(1).toString();
						 itestcount=new Integer(list.get(2).toString());
						 oldWarning =list.get(3).toString();
						}
						 %>
					<tr>
						<td>
							估计测试的点数：
						</td>
						<td>
							<input name=estimate size="40"
								value="<%=estimate%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							实际测试的点数：
							
						</td>
						<td>
				
						<input name="itestcount" size="40" type="text" value="<%=itestcount %>"/>
					
						</td>
					</tr>
					<tr>
						<td>
							排单时间：
						</td>
						<td>
							<input name="dcreatetime" size="40"
								value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(f.getPdtime()) == null ?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(f.getPdtime())%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							应出报告的时间：
						</td>
						<td>
							<input name="dcompletetime" size="40"
								value="<%=cp.getRptime()==null?"":cp.getRptime()%>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
					
					<tr>
						
						<td width="17%">
							测试报告号：
						</td>
						<td width="33%">
						<%if(f==null){
						%>
						<input name="rid" size="40" type="text"
								value="" readonly="readonly"
								style="background-color: #F2F2F2" />
						
						<%}else{ %>
						<input name="rid" size="40" type="text"
								value="<%=f.getRid().trim()%>" readonly="readonly"
								style="background-color: #F2F2F2" />
						<%
						 }
						 %>
							
						</td>
							<td>
							样品类型：
						</td>
						<td>
							<input name="traytype" size="40" value="<%=cp.getItem()==null?"":cp.getItem() %>" readonly="readonly" style="background-color: #F2F2F2"/>
						</td>

					</tr>
					
					<tr>
						<td>
							项目负责人:
						</td>
						<td>
						
						
						项目负责人：<select name="projectleader" id="projectleader" style="width: 150px">
					<option value="">--选择组员--</option>
					<%
						for(int i=0;i<listEngineer.size();i++){
								String engineer =listEngineer.get(i).toString();
					%>
					<option  value="<%=engineer%>" ><%=engineer%></option>
					<%
						}
					%>
					</select>
					   </td>
						<td>
							项目审核人:
						</td>
						<td>
						<select name="projectissuer" id="projectissuer" style="width: 150px">
							<option value="">--选择组员--</option>
					<%
						for(int i=0;i<listEngineer.size();i++){
								String engineer =listEngineer.get(i).toString();
					%>
					<option  value="<%=engineer%>" ><%=engineer%></option>
					<%
						}
					%>
						</select>
					   </td>
					
					</tr>
					<tr>
						<td>项目预警内容：</td>
						<td colspan="3"><textarea name="warning" rows="3" cols="80" style="width: 80%"  ><%=oldWarning%></textarea></td>
					</tr>
					
					<tr>
						<td colspan="3"><input  type="hidden" name ="oldwarning" value="<%=oldWarning%>" /></td>
					</tr>
				</table>
			</div>
			<br>
				<hr width="97%" align="center" size=0>
				<div align="center">
				<%if(up.equals("update")){
				
				%>
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="修改" onclick="checkForm(1)">
					&nbsp;&nbsp;&nbsp;
				
				<% }else{%>
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="添加" onclick="checkForm(2)">
					&nbsp;&nbsp;&nbsp;
				
				<% }%>
					
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
				<p>
					&nbsp;

				</p>
				
		</form>
	</body>
</html>
