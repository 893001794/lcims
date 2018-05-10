<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.Warnning"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid").trim();
	String status = request.getParameter("status");
	if(request.getParameter("search") !=null && "search".equals(request.getParameter("search"))){
	
	//下拉列表
	String kw="";
	if(status!= null && !"".equals(status)) {
	//if(!status.equals("客户自取") && ! status.equals("邮寄")){
	//status=new String (status.getBytes("ISO-8859-1"), "GBK");
	//}else{
	ProjectAction.getInstance().updateProject("dsendtime",sid,status);
	kw = "报告发出时间登记成功！";
	//}
	//else if(status.equals("邮寄")){
	//ProjectAction.getInstance().updateProject("masendtime",sid,status);
	//}
	}
	}
	
	
	
	Project p = ChemProjectAction.getInstance().getChemProjectBySid1(sid,"");
	
	if(p == null) {
		p = new Project();
	}
	
	//根据vpid（报价单）获取Quotation 的对像，在获取客户名称
	Quotation qt=QuotationAction.getInstance().getQuotationByPid(p.getPid());
	//根据用户名称获取客户的付款类型
	ClientForm cf=ClientAction.getInstance().getClientByName(qt.getClient());
	//当不存在该客户是就创建一个对象
	String payStatus="";
	if(cf == null ){
	cf=new ClientForm();
	}
	//当此客户的付款方式等于"月结"的时候
	if(cf.getPay().equals("月结")){
	//根据该报价单获取该报价单上个月的最后一款报价单是否付款
	payStatus=QuotationAction.getInstance().getPayStatusByTime(qt.getClient());
	}else if(cf.getPay() !=null && !"".equals(cf.getPay())){
	//直接获取但前报价单是否付款完成
	payStatus=qt.getPaystatus();
	}
	
	//System.out.println(payStatus+"：获取该报价单是否已经付款了");
	ChemProject cp = (ChemProject)p.getObj();
	List<ChemLabTime> list = cp.getList();
	
	if(list == null) {
		list = new ArrayList<ChemLabTime>();
	}
	
%>

<html>
	<head>
		<meta content="text/html; charset=gbk">
		<meta http-equiv="cache-control" content="no-cache, must-revalidate">
		<title>项目进度查询</title>
<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>
<script type="text/javascript">
	function changeStatus() {
		with (document.getElementById("search")) {
		//window.showModalDialog("../projectismethod.jsp?sid=<%=sid%>","","dialogWidth:900px;dialogHeight:700px");
		window.close();submit();
		}
	}
	
	function printexpress(){
	 var statusType =document.getElementById("status").value;
	 window.showModalDialog("../delivery/addelivery.jsp?sid=<%=sid%>&status="+statusType,"","dialogWidth:1000px;dialogHeight:500px");
	}
</script>
		
	</head>

	<body class="body1">  
	
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h1>
							项目进度
						</h1> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<div class="outborder">
		<form name="search" id="search" method="post"
							action="projectismethod.jsp?search=search">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="13%">
						报告编号：
					</td>
					<td width="15%">
						<input name="rid" type="text" size="15"
							style="background-color: #F2F2F2" readonly="readonly"
							value="<%=p.getRid()==null?"":p.getRid()%>" />
					</td>
					<td width="13%">
						项目等级：
					</td>
					
					<td >
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getLevel()==null?"":p.getLevel()%>" />
					</td>
					<td width="13%">
						报告类型：
					</td>
					
					<td align="right">
					
							<input type="hidden" name="command" value="search">
							<input type="hidden" name="sid" value="<%=sid %>">
							<%
						//	System.out.println(cp.getIsmethod());
								if(cp.getIsmethod() !=null){
								%>
								
						<select disabled="true" name="status" style="width: 100px" onchange="changeStatus(<%=sid %>)"  style="background-color: #F2F2F2"
							readonly="readonly">
								<option value="<%=cp.getIsmethod() %>">
									<%=cp.getIsmethod() %>
								</option>
								
							</select>
							
						<%
						}
						//未付清款
						 else if(payStatus.equals("n")){
						%>
						
							<select name="status"  style="width: 100px,"  onchange="changeStatus('<%=sid%>')" value="<%=cp.getIsmethod() %>">
								<option value="">
									未发
								</option>
								<option value="销售自取">
									销售自取
								</option>
							</select>
						<%
						}else{
						String disabled="";
						
						//System.out.println(disabled);
							 %>
						<select name="status"  style="width: 100px,"  onchange="changeStatus('<%=sid%>')" value="<%=cp.getIsmethod() %>">
								<option value="">
									未发
								</option>
								<option value="客户自取">
									客户自取
								</option>
								<!-- 打印快递单 -->
								<option value="快递">
									快递
								</option>
								<!--不打印快递单 -->
								<option value="邮寄">
									邮寄
								</option>
								<option value="销售自取">
									销售自取
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("status").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.indexOf("<%=status%>")== 0 && "<%=status%>".indexOf(ops[i].value) == 0){
										ops[i].selected = true;	
									}
								}
						</script>
						<%
						}
						 %>
						 <input type="button" onclick="printexpress();" value="打印快递单">
					</td>
				
				</tr>
					
						<%
						if(payStatus.equals("n")){
					%>
					<tr>
						<td colspan="6" align="right"><span><font style="color: red;">还没有付款</font></span></td>
						
					</tr>
					
					<%
						}
						 %>
			</table>
</form>
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						测试项目：
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>" />
					</td>
				</tr>

				<tr>
					<td>
						样品名称：
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=cp.getSamplename()==null?"":cp.getSamplename()%>" />
					</td>
				</tr>

			</table>
			</div>
			<div align="center"><h4>项目状态</h4></div>
			<div class="outborder">
				
			<table align="center" border="1" cellspacing=5 cellpadding=5 width="95%">
				<tr bgcolor="#01DF01">
					<th>状态</th>
					<th>时间</th>
					<th>操作人</th>
				</tr>
				<tr>
					<td width="20%">
						项目接收时间：
					</td>
					<td style="background: yellow;">
						<%=p.getBuildtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime())%>
					</td>
					<td>
						<%=p.getBuildname()==null?"":p.getBuildname() %>
					</td>
				</tr>
				<tr>
					<td>
						排单时间：
					</td>
					<td style="background: yellow;">
						<%=cp.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getCreatetime())%>
					</td>
					<td>
						<%=cp.getCreatename()==null?"":cp.getCreatename() %>
					</td>
				</tr>

				<tr>
					<td>
						报告完成时间：
					</td>
					<td style="background: yellow;">
						<%=cp.getEndtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime())%>
					</td>
					<td>
					&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						报告发出时间：
					</td>
					<td style="background: yellow;">
						<%=cp.getSendtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getSendtime())%>
					</td>
					<td>
					&nbsp;
					</td>
				</tr>
				</table>
				</div>
			<div align="center"><h4>实验室状态</h4></div>
			<div class="outborder">
			<table align="center" border="2" cellspacing=5 cellpadding=5 width="95%">
				<%
					for(int i=0;i<list.size();i++) {
						ChemLabTime clt = list.get(i);
				 %>
				
				<tr>
					<td>
						<%=clt.getStatus() %>：
					</td>
					<td style="background: yellow;">
						<%=clt.getTime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(clt.getTime()) %>
					</td>
					
				</tr>

				<%} %>
				
				
			</table>
			</div>
			<div align="center"><h4>项目预警</h4></div>
			<div class="outborder">
			<table align="center" border="2" cellspacing=5 cellpadding=5 width="95%">
				<tr bgcolor="#01DF01">
					<td>项目预警备注</td>
					<td>预警时间</td>
				</tr>
				<%
				List<Warnning> wms = ChemProjectAction.getInstance().getAllWarningBySid(p.getSid());
				for(int i=0;i<wms.size();i++) {
					Warnning w = wms.get(i);
				 %>
				 <tr>
				 	<td>
				 		<%=w.getWarn() %>
				 	</td>
				 	<td>
				 		<%=w.getWarntime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(w.getWarntime()) %>
				 	</td>
				 </tr>
				<%} %>
				
			</table>
			</div>
			<p>&nbsp;</p>
		<hr width="97%" align="center" size=0>
		<div align="center">
		<input type="button" value="关闭" onclick="window.close();">
		</div>
		
	</body>
</html>
