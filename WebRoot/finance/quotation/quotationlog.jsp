<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	//String pid = request.getParameter("pid");
	String pidStr = request.getParameter("pid");
	String uiNo = request.getParameter("ui");
	//System.out.println(pidStr);
	String pidStr1="";
	float sumPrice =0.0f;
	float chem=0.0f; //��ѧ��Ŀ�ܱ��۵�������������ҳ�桰
	float safe=0.0f; //��ȫ��Ŀ�ܱ��۵�������������ҳ�桰
	float op=0.0f; //��ѧ��Ŀ�ܱ��۵�������������ҳ�桰
	float emc=0.0f; //��ѧ��Ŀ�ܱ��۵�������������ҳ�桰
	//System.out.println(pidStr.split(",").length+"---");
	if(pidStr.split(",").length<=0){
	return;
	}else{
		for(String value:pidStr.split(",")){
				if(value.indexOf("/")==-1)return;
				pidStr1+=value.substring(0,value.indexOf("/"))+",";
				//sumPrice+=Float.parseFloat(value.substring(value.indexOf("/")+1,value.length()));
		}
	}
	String [] pidLenght=pidStr1.split(",");
	String pid=pidLenght[0];
	Order order =new Order();
	String str ="";
	String type =request.getParameter("type");   //����
	String pageNo = request.getParameter("pageNo");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("quotation_manage.jsp");
		return;
	}
	//------------------------------------------------------------------------------------------
		String lockType = request.getParameter("lockType");
		String lock = request.getParameter("lock");
		if(lockType !=null&& "1".equals(lockType)){
			if(lock!=null&&lock!=""){
				if(lock.equals("n")){
				lock ="y";
				}else{
				lock ="n";
				}
			}
			Quotation q =new Quotation();
			//System.out.println(q);
			q.setPid(pid);
			q.setLock(lock);
			FinanceQuotationAction.getInstance().quotationLock(q);
		}
	//------------------------------------------------------------------------------------------
	Quotation qt;
	if(QuotationAction.getInstance().getQuotationByPid(pid) ==null && "".equals(QuotationAction.getInstance().getQuotationByPid(pid))){
	qt = new Quotation();
	}else{
	qt= QuotationAction.getInstance().getQuotationByPid(pid);
    int id = OrderAction.getInstance().getOrderByPid(pid);
    int status=0;
    order = OrderAction.getInstance().getOrderById(id);
	
	}
	
	//--------------------------------------------------
	if(lockType !=null&& "1".equals(lockType)){
		//�յ�ȷ��
		if(qt.getConfirmtime()==null ||(qt.getConfirmtime()!=null &&"".equals(qt.getConfirmtime()==null ) )){
			QuotationAction.getInstance().confirmQuotation(pid,user.getName());
		}
	}
	//--------------------------------------------------
	
	float subtotal =0f;
	String creditcard="";
	String uiValue="";
	int cashierType=0;
	if(uiNo!=null && !"".equals(uiNo)){
		List row=DaoFactory.getInstance().getCashier().cashierInfor(uiNo);
		if(row.size()>0){
			cashierType=1;
			List cloums=(List)row.get(0);
			subtotal=Float.parseFloat(cloums.get(0).toString());
			creditcard=cloums.get(1).toString();
			uiValue=cloums.get(2).toString();
		}
	}
	
	List<Project> list = ProjectAction.getInstance().getAllProjectByPid(pid);
	int companyid=0;
	if(qt.getCompany().equals("��ɽ")){
	companyid=1;
	}else if (qt.getCompany().equals("����")){
	companyid=2;
	}else if (qt.getCompany().equals("��ݸ")){
	companyid=3;
	}
	
	String lockStr="����";
	if(qt.getLock() !=null && qt.getLock() !=""){
		if(qt.getLock().equals("y")){
			lockStr="����";
		}
	}
	
	ClientForm cf =ClientAction.getInstance().getClientByName(qt.getClient());
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>���۵�����</title>
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
		function getAcount(acount) {
			if(acount.value == "") {
				acount.value = "<%=qt.getPreadvance()+qt.getSepay()+qt.getBalance()-qt.getSubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax()%>";
			}
		}
		
		function printstatement() {
			window.open("printstatement.jsp?pid=<%=qt.getPid()%>");
		}
		function goBack() {
		window.self.location="quotation_manage.jsp?pageNo=<%=pageNo%>";
		}
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
		
		function flush(){
		var form1=document.getElementById("form1");
		form1.action ="quotationlog.jsp"
		form1.submit();
		}
		
		function addtextarea(){
			//Ԥ�տ�ʱ��
			var paytime=document.getElementById("paytime").value;
			//Ԥ�տ��˺�
			var creditcard=document.getElementById("creditcard").value;
			//Ԥ�տ���
			var preadvance=document.getElementById("preadvance").value;
			//�����տ�ʱ��
			var sepaytime=document.getElementById("sepaytime").value;
			//�����տ��˺�
			var sepayacount=document.getElementById("sepayacount").value;
			//�����տ���
			var sepay=document.getElementById("sepay").value;
			//β���տ�ʱ��
			var balancetime=document.getElementById("balancetime").value;
			//β���տ��˺�
			var balanceacount=document.getElementById("balanceacount").value;
			//β���տ���
			var balance=document.getElementById("balance").value;
			var textAreaV="";
			if(preadvance !=""){
				textAreaV+="1:"+paytime+"�յ��˺�Ϊ"+creditcard+"��"+preadvance+"Ԫ"+"\n";
			}
			if(sepay !=""){
				textAreaV+="2:"+sepaytime+"�յ��˺�Ϊ"+sepayacount+"��"+sepay+"Ԫ"+"\n";
			}
			if(balance !=""){
				textAreaV+="3:"+balancetime+"�յ��˺�Ϊ"+balanceacount+"��"+balance+"Ԫ";
			}
			if(document.getElementById("collRemarks").value==""){
				document.getElementById("collRemarks").value=textAreaV;
			}
			
		}
		function lock1(Object,lock){
			 var myForm =document.getElementById("form1");
	   // var lock =document.getElementById("lock").value;
			myForm.action="quotationlog.jsp?lockType=1&type=1&pid="+Object+"/,&lock="+lock;
			myForm.submit();
			return ;
		}
		
		function fincome(chem,safe,op,emc) {
			var vpid =document.getElementById("pid").value;
				vpid=vpid.substring(0,vpid.length-1);
			with (document.getElementById("form1")) {
				method="post";
				action="../../cashcount/fincome.jsp?pid="+vpid+"&chem="+chem+"&safe="+safe+"&op="+op+"&emc="+emc;
				submit();
			}
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
					<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�������&gt;&gt;����Ǽ�</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1" id="form1" method="post" action="quotationlog_post.jsp" onsubmit="return addtextarea();" >
			<input name="pageNo" value="<%=pageNo %>" type="hidden"/>
			<input type="hidden" value="<%=pidStr%>" id="pidStr" name ="pidStr">
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							���۵���ţ�
						</td>
						<td width="33%">
							<input id="pid" name="pid" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=pidStr1%>" />
						</td>

						<td width="17%">
							�ֹ�˾��
						</td>
						<td width="33%">

							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany() %>" />
						</td>

					</tr>
					<%
					//System.out.println(qt.getPid().indexOf("LCQE"));
					if(qt.getPid().indexOf("LCQE")>-1){
					%>
					<tr>
						<td width="17%">
							��ˮ�˺ţ�
						</td>
						<td width="33%">
							<input name="UI" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=order.getUI()%>" />
						</td>

						<td width="17%">
							�������۵��ţ�
						</td>
						<td width="33%">

							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=order.getOldPid()%>" />
						</td>
					</tr>
					<%
					} %>
					<tr>
						
						
						<td>
							����ʱ�䣺
						</td>
						<td>
							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCreatetime()) %>" />
						</td>
						<td>
							������Ա��
						</td>
						<td>
							<input name="sales" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSales() %>" />
						</td>
					
					</tr>

					<tr>
						<td width="116">
							���۽�
						</td>
						<td width="168">
							<input name="totalprice" type="text" readonly="readonly"
								size="40" style="background-color: yellow"
								value="<%=str%><%=qt.getTotalprice() %>" />
						</td>
						<td width="100">
							Ӧ���ʱ�䣺
						</td>
						<td width="611">
							<input style="background-color: #F2F2F2" readonly="readonly"
								size="40" value="<%=qt.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime())%>" />
						</td>
					</tr>

					<tr>
						<td>
							�ͻ����ƣ�
						</td>
						<td>
							<input style="background-color: #F2F2F2" readonly="readonly"
							 name ="client"	size="40" value="<%=qt.getClient() %>" />
						</td>
						
						<td>
							��Ŀ���ƣ�
						</td>
						<td>
							<input type="text" style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getProjectcontent() %>" />
						</td>
					</tr>
					<tr>

						<td>
							�տʽ��
						</td>
						<td>
							<input name="advancetype" value="<%=qt.getAdvancetype()==null?"":qt.getAdvancetype() %>"
								type="text" size="40" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>
						
					</tr>
					<tr>
					<td>����˵����</td>
						<td colspan="3">
						<input name="advancetype" value="<%=order.getDetail()==null?"":order.getDetail()%>"
								type="text" size="125" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>
					</tr>
				</table>
			</div>
			
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">

					<tr>
						<td width="17%">
							����Ԥ���
						</td>
						<td width="33%">
						
							<%
							String read="";
							String stype="";
							if(type==null){
							type="";
							}
							//System.out.println(type+"---------"+pidStr.split(",").length);
							if(!type.equals("modi")&&pidStr.split(",").length>1){
							 read="readonly='readonly'";
							 stype ="style='background-color: #F2F2F2'";
							}
							String va="value='" + new DecimalFormat("###########.00").format(qt.getPreadvance()) + "'"+ read +stype;
							%>
							<input name="preadvance" id="preadvance" type="text" size="40"
								<%=va%> />
								
						</td>
						<td width="17%">
							Ԥ�����տ����ڣ�
						</td>
						<td>
							<input name=paytime id ="paytime" type="text" size="40" 
								<%=qt.getPaytime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getPaytime()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td width="132">
							�տ��˺ţ�
						</td>
						<td width="263">
						<%
						if(qt.getCreditcard()==null||"".equals(qt.getCreditcard())||type.equals("modi")){
						%>
						<select name="creditcard" style="width: 300px">		
						<option value="">��ѡ���տ��ʺ�</option>	
						<%
							Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
							for(String value:banks.keySet()) {
									if(banks.get(value).equals(qt.getCreditcard())){
									 %>
										<option value="<%=banks.get(value)%>"<%=banks.get(value)!=null?"selected":""%>><%=banks.get(value) %></option>
								<%
									 }	else {
									  %>
									  <option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
									  <%
									 }
							 }	
								 //������ӵą���
								if("�ֽ�".equals(qt.getCreditcard())){
								%>
								<option value="�ֽ�" selected="selected">�ֽ�</option>		
								<%
								}else{
								%>
								<option value="�ֽ�">�ֽ�</option>		
								<%
								}
								if("��۹���".equals(qt.getCreditcard())){
							%>
							<option value="��۹���" selected="selected">��۹��˻�</option>		
							<%
							}else{
							%>
							<option value="��۹���">��۹���</option>		
							<%
							}	
								if("���˽��".equals(qt.getCreditcard())){
							%>
							<option value="���˽��" selected="selected">���˽��</option>		
							<%
							}else{
							%>
							<option value="���˽��">���˽��</option>		
							<%
							}
							
							if("�ͻ��Խɻ���".equals(qt.getCreditcard())){
							%>
							<option value="�ͻ��Խɻ���" selected="selected">�ͻ��Խɻ���</option>		
							<%
							}
							if("����˻�".equals(qt.getCreditcard())){
							%>
							<option value="����˻�" selected="selected">����˻�</option>		
							<%
							}
							if("�������ջ�����".equals(qt.getCreditcard())){
							%>
							<option value="�������ջ�����" selected="selected">�������ջ�����</option>		
							<%
							}
								  %>
							</select>
						<%	}else{
								  %>
								<input name="creditcard" id="creditcard" type="text" size="40" <%=("value='" + qt.getCreditcard() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> 					
								 <%
								 }
							 %>
						
							
								
						</td>
						<td>
							Ԥ�����տ�Ʊ�ݣ�
						</td>
						<td>
					
					<select name="paynotes"  style="width: 290px">
					
					 <option value="" selected="selected">��ѡ���տ�Ʊ��</option>
					 <%
					 		String paynotes=qt.getInvtype();
					 		if(qt.getPaynotes() !=null &&!qt.getPaynotes().equals("")){
					 		paynotes=qt.getPaynotes() ;
					 		}
					 		if("��Ʊ".equals(paynotes)){
							%>
							<option value="��Ʊ" selected="selected">��Ʊ</option>		
							<%
							}
							if("��ʽ��Ʊ".equals(paynotes)){
							%>
						<option value="��ʽ��Ʊ" selected="selected">��ʽ��Ʊ</option>
						<%
							}else{
						%>
						<option value="��ʽ��Ʊ">��ʽ��Ʊ</option>
						<%
						}
						if("��ͨ��Ʊ".equals(paynotes)){
							%>
							<option value="��ͨ��Ʊ" selected="selected">��ͨ��Ʊ</option>		
							<%
							}else{
							%>
						<option value="��ͨ��Ʊ">��ͨ��Ʊ</option>
						  <%
						  }
							if("ר�÷�Ʊ".equals(paynotes)){
							%>
							<option value="ר�÷�Ʊ" selected="selected">ר�÷�Ʊ</option>		
							<%
							}else{
							%>
						<option value="ר�÷�Ʊ">ר�÷�Ʊ</option>
						  <%
						  }
							if("�վ�".equals(paynotes)){
							%>
							<option value="�վ�" selected="selected">�վ�</option>		
							<%
							}else{
							%>
							 <option value="�վ�">�վ�</option>
							<%
							}
							%>
					</select>
					
							<!--  <input name="paynotes" type="text" size="40" <%=(qt.getPaynotes()==null||"".equals(qt.getPaynotes()))?"":("value='" + qt.getPaynotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />-->
								
						</td>
					</tr>
					
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							�����տ��
						</td>
						<td width="33%">
							<input name="sepay" id="sepay" type="text" size="40"
								<%=qt.getSepay()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getSepay()) + "'"+ read +stype) %> />
								
						</td>
						<td width="17%">
							�����տ����ڣ�
						</td>
						<td>
							<input name="sepaytime" id="sepaytime" type="text" size="40" 
								<%=qt.getSepaytime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSepaytime()) + "'"+ read +stype) %> />
								
						</td>
						
					</tr>
					<tr>
						<td width="17%">
							�����տ��˺ţ�
						</td>
						<td width="33%">
						<%if(qt.getSepayacount()==null||"".equals(qt.getSepayacount())||type.equals("modi")){
	
						%>
					<select name="sepayacount" id ="sepayacount" style="width: 300px">	
					<option value="" selected="selected">��ѡ���տ��ʺ�</option>	
						<%
							Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
							for(String value:banks.keySet()) {
									if(banks.get(value).equals(qt.getBalanceacount())){
									 %>
										<option value="<%=banks.get(value)%>"<%=banks.get(value)!=null&&qt.getCreditcard().equals(banks.get(value))?"selected":""%>><%=banks.get(value) %></option>
								<%
									 }	else {
									  %>
									  <option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
									  <%
									 }
							 }	
								 //������ӵą���
								 if("����8833".equals(qt.getSepayacount())){
									%>
									<option value="����8833" selected="selected">����8833</option>		
									<%
									}else{
									%>
									<option value="����8833">����8833</option>		
									<%
									}
								if("�ֽ�".equals(qt.getSepayacount())){
								%>
								<option value="�ֽ�" selected="selected">�ֽ�</option>		
								<%
								}else{
								%>
								<option value="�ֽ�">�ֽ�</option>		
								<%
								}
								if("��۹���".equals(qt.getSepayacount())){
							%>
							<option value="��۹���" selected="selected">��۹��˻�</option>		
							<%
							}else{
							%>
							<option value="��۹���">��۹���</option>		
							<%
							}	
								if("���˽��".equals(qt.getSepayacount())){
							%>
							<option value="���˽��" selected="selected">���˽��</option>		
							<%
							}else{
							%>
							<option value="���˽��">���˽��</option>		
							<%
							}
							
							if("�ͻ��Խɻ���".equals(qt.getSepayacount())){
							%>
							<option value="�ͻ��Խɻ���" selected="selected">�ͻ��Խɻ���</option>		
							<%
							}
							if("����˻�".equals(qt.getSepayacount())){
							%>
							<option value="����˻�" selected="selected">����˻�</option>		
							<%
							}
							if("�������ջ�����".equals(qt.getSepayacount())){
							%>
							<option value="�������ջ�����" selected="selected">�������ջ�����</option>		
							<%
							}
								  %>
							</select>
						<%	}else{
								  %>
								<input name="sepayacount" type="text" size="40" <%=("value='" + qt.getSepayacount() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								 <%
								 }
								 
							 %>
							
								
						</td>
						<td>
							�����տ�Ʊ�ݣ�
						</td>
						<td>
					<select name="sepaynotes"  style="width: 290px">
					    <option value="" selected="selected">��ѡ���տ�Ʊ��</option>	
					    		
					   <%
					   	String sepaynotes="";
					   	if(qt.getSepaynotes()!=null&& !"".equals(qt.getSepaynotes())){
					   	sepaynotes=qt.getSepaynotes();
					   	}
					  	 if("��Ʊ".equals(sepaynotes)){
							%>
							<option value="��Ʊ" selected="selected">��Ʊ</option>		
							<%
							}
						 if("��ʽ��Ʊ".equals(sepaynotes)){
							%>
						<option value="��ʽ��Ʊ" selected="selected">��ʽ��Ʊ</option>
						<%
						}else{
						%>
						<option value="��ʽ��Ʊ">��ʽ��Ʊ</option>
						<%
						}
						if("��ͨ��Ʊ".equals(sepaynotes)){
							%>
							<option value="��ͨ��Ʊ" selected="selected">��ͨ��Ʊ</option>		
							<%
							}else{
							%>
						<option value="��ͨ��Ʊ">��ͨ��Ʊ</option>
						  <%
						  }
							if("ר�÷�Ʊ".equals(sepaynotes)){
							%>
							<option value="ר�÷�Ʊ" selected="selected">ר�÷�Ʊ</option>		
							<%
							}else{
							%>
						<option value="ר�÷�Ʊ">ר�÷�Ʊ</option>
						  <%
						  }
							if("�վ�".equals(sepaynotes)){
							%>
							<option value="�վ�" selected="selected">�վ�</option>		
							<%
							}else{
							%>
							 <option value="�վ�">�վ�</option>
							<%
							}
							%>
					</select>
							<!--  <input name="sepaynotes" type="text" size="40" <%=(qt.getSepaynotes()==null||"".equals(qt.getSepaynotes()))?"":("value='" + qt.getSepaynotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />-->
								
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							Ӧ��β���
						</td>
						<td width="33%">
							<input name="prebalance" id="prebalance" type="text" size="40" 
								<%=qt.getPrebalance()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getPrebalance()) + "'"+ read +stype) %> />
								
						</td>
						<td width="17%">
							ʵ��β���
						</td>
						<td width="33%">
							<input name="balance" id="balance" type="text" size="40" 
								<%=qt.getBalance()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getBalance()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td>
							β���տ��˺ţ�
						</td>
						<td>
						
						<%if(qt.getBalanceacount()==null||"".equals(qt.getBalanceacount())||type.equals("modi")){
	
						%>
					<select name="balanceacount" id ="balanceacount"  style="width: 300px">		
					<option value="">��ѡ���տ��ʺ�</option>	
						<%
							Map<String,String> banks = FlowFinal.getInstance().getBank(companyid,user.getDept(),user.getId());
							for(String value:banks.keySet()) {
									if(banks.get(value).equals(qt.getBalanceacount())){
									 %>
										<option value="<%=banks.get(value)%>"<%=banks.get(value)!=null&&qt.getCreditcard().equals(banks.get(value))?"selected":""%>><%=banks.get(value) %></option>
								<%
									 }	else {
									  %>
									  <option value="<%=banks.get(value)%>"><%=banks.get(value) %></option>
									  <%
									 }
							 }	
								 //������ӵą���
								 if("����8833".equals(qt.getBalanceacount())){
									%>
									<option value="����8833" selected="selected">����8833</option>		
									<%
									}else{
									%>
									<option value="����8833">����8833</option>		
									<%
									}
								if("�ֽ�".equals(qt.getBalanceacount())){
								%>
								<option value="�ֽ�" selected="selected">�ֽ�</option>		
								<%
								}else{
								%>
								<option value="�ֽ�">�ֽ�</option>		
								<%
								}
								if("��۹���".equals(qt.getBalanceacount())){
							%>
							<option value="��۹���" selected="selected">��۹��˻�</option>		
							<%
							}else{
							%>
							<option value="��۹���">��۹���</option>		
							<%
							}	
								if("���˽��".equals(qt.getBalanceacount())){
							%>
							<option value="���˽��" selected="selected">���˽��</option>		
							<%
							}else{
							%>
							<option value="���˽��">���˽��</option>		
							<%
							}
							
							if("�ͻ��Խɻ���".equals(qt.getBalanceacount())){
							%>
							<option value="�ͻ��Խɻ���" selected="selected">�ͻ��Խɻ���</option>		
							<%
							}
							if("����˻�".equals(qt.getBalanceacount())){
							%>
							<option value="����˻�" selected="selected">����˻�</option>		
							<%
							}
							if("�������ջ�����".equals(qt.getBalanceacount())){
							%>
							<option value="�������ջ�����" selected="selected">�������ջ�����</option>		
							<%
							}
								  %>
							</select>
						<%	}else{
								  %>
								<input name="balanceacount" type="text" size="40" <%=("value='" + qt.getBalanceacount() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								 <%
								 }
								 
							 %>
							
								
							
						</td>
						<td>
							β���տ����ڣ�
						</td>
						<td>
							<input name="balancetime" id="balancetime" type="text" size="40" 
								<%=qt.getBalancetime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getBalancetime()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
					<td width="116">
							�տע��
						</td>
						<td width="593" colspan="3">
						<!-- onfocus="addtextarea();" -->
							<textarea name="collRemarks" id ="collRemarks" rows="6" cols="120" onfocus="addtextarea();"><%=qt.getCollRemarks()==null?"":qt.getCollRemarks()%></textarea>
						</td>
					</tr>
					<tr>

						<td>
							��Ŀ�˿��
						</td>
						<td>
							<input name="refund" type="text" size="40" 
								<%=qt.getRefund()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getRefund()) + "'"+ read +stype) %> />
						</td>
						<td>
							β���տ�Ʊ�ݣ�
						</td>
						<td>
						<select name="balancenotes"  style="width: 290px">
						
					    <option value="" selected="selected">��ѡ���տ�Ʊ��</option>		
					  <%
					  		String balancenotes="";
					  		if(qt.getBalancenotes() !=null&&!"".equals(qt.getBalancenotes())){
					  		balancenotes=qt.getBalancenotes();
					  		}
					  		 if("��Ʊ".equals(balancenotes)){
							%>
							<option value="��Ʊ" selected="selected">��Ʊ</option>		
							<%
							}
							if("��ʽ��Ʊ".equals(balancenotes)){
							%>
							<option value="��ʽ��Ʊ" selected="selected">��ʽ��Ʊ</option>
							<%
							}else{
							%>
							<option value="��ʽ��Ʊ">��ʽ��Ʊ</option>
							<%
							}
							if("��ͨ��Ʊ".equals(balancenotes)){
							%>
							<option value="��ͨ��Ʊ" selected="selected">��ͨ��Ʊ</option>		
							<%
							}else{
							%>
						<option value="��ͨ��Ʊ">��ͨ��Ʊ</option>
						  <%
						  }
							if("ר�÷�Ʊ".equals(balancenotes)){
							%>
							<option value="ר�÷�Ʊ" selected="selected">ר�÷�Ʊ</option>		
							<%
							}else{
							%>
						<option value="ר�÷�Ʊ">ר�÷�Ʊ</option>
						  <%
						  }
							if("�վ�".equals(balancenotes)){
							%>
							<option value="�վ�" selected="selected">�վ�</option>		
							<%
							}else{
							%>
							 <option value="�վ�">�վ�</option>
							<%
							}
							%>
						</select>
							<!-- <input name="balancenotes" type="text" size="40" <%=(qt.getBalancenotes()==null||"".equals(qt.getBalancenotes()))?"":("value='" + qt.getBalancenotes() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> -->
								
						</td>
					</tr>

					<tr>
						<td width="116">
							��Ŀ�˿�˵����
						</td>
						<td width="593">
							<textarea name="refunddesc" rows="6" cols="40"><%=qt.getRefunddesc()==null?"":qt.getRefunddesc() %></textarea>
						</td>
					</tr>
				</table>
			</div>
			<%
			//if(user.getId()!=158){
			 %>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							����Ӵ���Ԥ�㣺
						</td>
						<td width="33%">
							<input name="prespefund" type="text" size="40" 
								value="<%=qt.getPrespefund()==0?"":new DecimalFormat("###########.00").format(qt.getPrespefund()) %>" />
								
						</td>
						<td width="17%">
							ʵ������Ӵ��ѣ�
						</td>
						<td width="33%">
							<input name="spefund" type="text" size="40" 
								<%=qt.getSpefund()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getSpefund()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td>
							����Ӵ���֧����ʽ��
						</td>
						<td>
						<%
						if(qt.getSpefundtype()==null||"".equals(qt.getSpefundtype())||type.equals("modi")){
						%>
						<select name="spefundtype" style="width: 300px">		
						<option value="" selected="selected">��ѡ������Ӵ���֧����ʽ</option>
						<option value="�ֽ�">�ֽ�</option>									
						<option value="����3079">����3079</option>									
						<option value="����1050">����1050</option>	
						<option value="����6647">����6647</option>	
						<option value="����5919">����5919</option>									
															

						</select>
						<%	}else{
								  %>
								<input name="spefundtype" type="text" size="40" <%=("value='" + qt.getSpefundtype() + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								 <%
								 }
							 %>
						
							
							<!-- <input name="spefundtype" type="text" size="40" 
								<%=(qt.getSpefundtype()==null||"".equals(qt.getSpefundtype()))?"":("value='" + qt.getSpefundtype() + "' readonly='readonly' style='background-color: #F2F2F2'") %> /> -->
								
						</td>
						<td>
							����Ӵ���֧�����ڣ�
						</td>
						<td>
							<input name="spefundtime" type="text" size="40" 
								<%=qt.getSpefundtime()==null?"onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSpefundtime()) + "'"+ read +stype) %> />
								
						</td>
					</tr>
					<tr>
						<td>
							����Ӵ���֧����ע��
						</td>
						<td>
							<textarea name="spefunddesc" rows="6" cols="40"><%=qt.getSpefunddesc()==null?"":qt.getSpefunddesc() %></textarea>
						</td>
					</tr>
				</table>
			</div>
			<%
			//} 
			%>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="116">
							��Ʊ��ʽ��
						</td>
						<td width="168">
							<select name="invtype" style="width: 300px">
								<option value="ר�÷�Ʊ" <%=qt.getInvtype().equals("ר�÷�Ʊ")?"selected":"" %>>
									ר�÷�Ʊ
								</option>
								<%--<option value="��Ʊ" <%=qt.getInvtype().equals("��Ʊ")?"selected":"" %>>
										��Ʊ
								</option>--%>
								<option value="��ͨ��Ʊ" <%=qt.getInvtype().equals("��ͨ��Ʊ")?"selected":"" %> >
									��ͨ��Ʊ
								</option>
								<option value="��ʽ��Ʊ" <%=qt.getInvtype().equals("��ʽ��Ʊ")?"selected":"" %> >
									��ʽ��Ʊ
								</option>
								<option value="�վ�"  <%=qt.getInvtype().equals("�վ�")?"selected":"" %>>
									�վ�
								</option>
							</select>
							<!--	
							<input name="invtype" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvtype()==null?"":qt.getInvtype() %>"/>
								
								  -->
						</td>
						<td width="17%">
							Ʊ�ݱ�ţ�
						</td>
						<td width="33%">
							<input name="invcode" type="text" size="40" 
								<%=(qt.getInvcode()==null||"".equals(qt.getInvcode()))?"":("value='" + qt.getInvcode() + "'") %> />
								
						</td>
						
					</tr>
					<tr>
						<td width="132">
							��Ʊ�ܽ�
						</td>
						<td width="263">
							<input name="invcount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly" value="<%=str%><%=qt.getInvcount()==0?"":new DecimalFormat("###########.00").format(qt.getInvcount()) %>"/>
						</td>
						<td width="132">
							ʵ�ʿ�Ʊ��
						</td>
						<td width="263">
							<input name="invprice" type="text" size="40" 
								<%=qt.getInvprice()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getInvprice()) + "'") %> />
									
						</td>
					</tr>
					<tr>
						<td width="17%">
							Ʊ��̧ͷ��
						</td>
						<td width="33%">
							<input name="invhead" type="text" size="40"
								 value="<%=qt.getInvhead()==null?"":qt.getInvhead() %>"/>
						</td>
						<td>
							Ʊ�����ڣ�
						</td>
						<td>
							<input name="invtime" size="40" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
								<%=qt.getInvtime()==null?"":("value='" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getInvtime()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						
						<td width="17%">
							Ʊ�����ݣ�
						</td>
						<td width="33%">
							<input name="invcontent" type="text" size="40"
								 value="<%=qt.getInvcontent()==null?"":qt.getInvcontent() %>"/>
						</td>
						<td width="17%">
							˰��:
						</td>
						<td width="33%">
						<%
						float sun=0.0f;
							if(qt.getPreadvance()!=0 && qt.getInvtype().indexOf("��Ʊ")>-1){
							sun +=qt.getPreadvance()*0.08;
							}
							if(qt.getSepay()!=0 && qt.getInvtype().indexOf("��Ʊ")>-1){
							sun +=qt.getSepay()*0.08;
							}
							if(qt.getPrebalance()!=0 && qt.getInvtype().indexOf("��Ʊ")>-1){
						
							sun +=qt.getPrebalance()*0.08;
							}
						 %>
						 <input name="tax" type="text" size="40" value="<%=sun%>" style="background-color: #F2F2F2" readonly="readonly"/>	
						</td>
					</tr>
					<tr>
						<td width="17%">
							��ע:
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40"
								 value="<%=qt.getTag()==null?"":qt.getTag() %>"/>	
						</td>
						<td width="17%">
							��������:
						</td>
						<td width="33%">
						
							<!-- <input name="othercost" type="text" size="40" value="<%=qt.getSumOtherscost()==0?"":qt.getSumOtherscost() %>"/>-->	
							 <input name="othercost" type="text" size="40" value="<%=qt.getOthercost()==0?"":qt.getOthercost() %>"/>	

						</td>
					</tr>
				</table>
			</div>
			
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							ҵ�����������
						</td>
						<td width="33%">
							<input name="preacount" type="text" size="40" readonly='readonly' style='background-color: #F2F2F2'
								value='<%=qt.getPreacount()==0?"":new DecimalFormat("###########.00").format(qt.getPreacount())%>'  />
								
						</td>
						<td width="17%">,
						</td>
						<td width="33%">
							<input name="acount" type="text" size="40" readonly='readonly' onFocus="getAcount(this)" 
								<%=qt.getAcount()==0?"":("value='" + new DecimalFormat("###########.00").format(qt.getAcount()) + "' readonly='readonly' style='background-color: #F2F2F2'") %> />
								
						</td>
					</tr>
					<tr>
						<td width="17%">
							���˿ۿ
						</td>
						<td width="33%">
							<input name="badDebt" type="text" size="40"  value='<%=qt.getBadDebt()==null?"":qt.getBadDebt()%>'  />
						</td>
						<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;
						</td>
					</tr>
				</table>
				<p>
					<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5" border="1">
					<tr bgcolor="#A9F5F2">
					 <td>������</td>
					 <td>��Ŀ</td>
					 <td>����Ӧ��ʱ��</td>
					 <td>����Ŀ���</td>
					 <td>ʵ�ʷְ���A</td>
					 <td>ʵ�ʷְ���B</td>
					 <td>ҵ���������</td>
					 <td>ҵ���������</td>
					 <td>����</td>
					</tr>
				<%
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					Date rptime = null;
					System.out.println(p.getPtype());
					if(!("��ѧ����".equals(p.getPtype())||"��ױƷ".equals(p.getPtype())||"����".equals(p.getPtype()))) {
					//if(!("��ѧ����".equals(p.getPtype())||!"��ױƷ".equals(p.getPtype()))) {
						PhyProject pp = (PhyProject)p.getObj();
						rptime = pp.getRptime();
						if(p.getPtype().indexOf("������")>-1){
							op+=p.getPrice();
						}else if(p.getPtype().indexOf("��ȫ")>-1){
							safe+=p.getPrice();
						}else if(p.getPtype().indexOf("EMC")>-1){
							emc+=p.getPrice();
						}
					} else {
						ChemProject cp = (ChemProject)p.getObj();
						rptime = cp.getRptime();
						chem+=p.getPrice();
					}
					
				 %>
					<tr>
						<td><%=p.getRid() %></td>
						<td><%=p.getPtype()%></td>
						<td><%=rptime %></td>
						<td><%=p.getPrice() %></td>
						<td><%=p.getSubcost()%></td>
						<td><%=p.getSubcost2()%></td>
						<td><%=p.getPpreacount() %></td>
						<td><%=p.getPacount() %></td>
						<td><a href="../project/projectlog.jsp?sid=<%=p.getSid() %>&ptype=<%=URLEncoder.encode(p.getPtype(),"UTF-8") %>" style="color: blue">����Ŀ����</a></td>
					</tr>
				<%
				}
				 %>
				</table>
			</div>
				<br>
				<br>
				<!-- 2013-2-23�����һ��div�����������div -->
				<div class="outborder">
					<table width="100%">
					<tr>
						<td width="73%">
								<table width="100%"  cellpadding="5" cellspacing="5" border="1">
									<tr bgcolor="#A9F5F2">
											<td  >
												��Ŀ��
											</td>
											<td>
												ҵ��
											</td>
											<td >
												Ԥ���ְ���
											</td>
											<td>
												������
											</td>
											<td >
												��ַ�
											</td>
											
										</tr>
										
										<%
										
										//С��
										float Sassist=0f;
										float Spresubcost=0f;
										float Spreeagcost=0f;
										float Service=0f;
										List temp =new ArrayList();
										List ZOList=new ArrayList();
										float nu0=0;
										float nu1=1;
										float nu2=0.3f;
										float nu3=0.7f;
										float nu4=0.4f;
										float nu5=0.6f;
										float nu6=0.35f;
										float nu7=0.65f;
										
										//��ѧ����C�����ӵ�����ȫ����S��EMC����E�������ܲ���P����Ч����N
										temp.add("��ѧ����");
										temp.add("���ӵ�����ȫ����");
										temp.add("�����ܲ���");
										temp.add("EMC����");
										temp.add("��Ч����");
										float Z=0.0f;
										List ZList=new ArrayList();//��Ч����
										
										List CIList=new ArrayList();//��ѧ��������;
										List SIList=new ArrayList();//��ȫ��������
										List EIList=new ArrayList();//EMC��������
										List PIList=new ArrayList();//���ܳ�������
										List NIList=new ArrayList();//��Ч��������
										
										List COList=new ArrayList();//��ѧ��������
										List SOList=new ArrayList();//��ȫ��������
										List POList=new ArrayList();//������������
										List EOList=new ArrayList();//EMC��������
										List NOList=new ArrayList();//��Ч��������
										
										List ZIList=new ArrayList();
										float Z1=0f;
										float A=0f;
										float S=0f;
										//float a1=0f;
										for(int i=0;i<temp.size();i++){
											String ptype=temp.get(i).toString();
											List inforList=DaoFactory.getInstance().getProjectPrice().cashier(pid,ptype); //5��3��
											if(inforList !=null && inforList.size()>0){
												List cloums=(List)inforList.get(0);
												Z1+=Float.parseFloat(cloums.get(0).toString());
												//System.out.println(Z1+"---Z1");
												A+=Float.parseFloat(cloums.get(1).toString());
												S+=Float.parseFloat(cloums.get(2).toString());
											}
										//a1=Float.parseFloat(cloums.get(0).toString());
										}
										
										for(int i=0;i<temp.size();i++){
											String ptype=temp.get(i).toString();
											List inforList=DaoFactory.getInstance().getProjectPrice().cashier(pid,ptype); //5��3��
											if(inforList !=null && inforList.size()>0){
												List cloums=(List)inforList.get(0);
										//Z1+=Float.parseFloat(cloums.get(0).toString());
										//------------------------------------------------------------
												for(int j=0;j<15;j++){
													//��ѧʹ�õĹ�ʽ
													if(pid.indexOf("LCQ1")>-1){
													//��ѧ�ĵ�һ��
														if(i==0){
															if(j<3){
																CIList.add(nu1);
																COList.add(nu0);
															}else if(j==5){
																CIList.add(nu2);
																COList.add(-nu3);
															}else if(j==8){
																CIList.add(nu4);
																COList.add(-nu5);
															}else if(j==11){
																CIList.add(nu6);
																COList.add(-nu7);
															}else if(j>11){
																CIList.add(nu0);
																COList.add(nu0);
															}else {
																CIList.add(nu0);
																COList.add(-nu1);
															}
														}
														if(i==1){
															if(j>2&&j<5){
																SIList.add(nu1);
																SOList.add(-nu1);
															}else if(j==5){
																SIList.add(nu3);
																SOList.add(nu0);
															}else{
																SIList.add(nu0);
																SOList.add(nu0);
															}
														}
														if(i==2){
															if(j>5&&j<8){
																PIList.add(nu1);
																POList.add(-nu1);
															}else if(j==8){
																PIList.add(nu5);
																POList.add(nu0);
															}else{
																PIList.add(nu0);
																POList.add(nu0);
															}
														}
														if(i==3){
															if(j>8&&j<11){
																EIList.add(nu1);
																EOList.add(-nu1);
															}else if(j==11){
																EIList.add(nu7);
																EOList.add(nu0);
															}else{
																EIList.add(nu0);
																EOList.add(nu0);
															}
														}
														if(i==4){
															NIList.add(nu0);
															NOList.add(nu0);
														}
													}
													if(pid.indexOf("LCQ2")>-1){
													//��ѧ�ĵ�һ��
														if(i==0){
															if(j<2){
																CIList.add(nu1);
																COList.add(-nu1);
															}else if(j==2){
																CIList.add(nu7);
																COList.add(nu0);
															}else {
																CIList.add(nu0);
																COList.add(nu0);
															}
														}
														if(i==1){
															if(j<2){
																SIList.add(nu0);
																SOList.add(-nu1);
															}else if(j==2){
																SIList.add(nu6);
																SOList.add(-nu7);
															}else if(j>2&&j<6){
																SIList.add(nu1);
																SOList.add(nu0);
															}else if(j>5&&j<8){
																SIList.add(nu0);
																SOList.add(-nu1);
															}else if(j==8){
																SIList.add(nu4);
																SOList.add(-nu5);
															}else if(j>8&&j<11){
																SIList.add(nu0);
																SOList.add(-nu1);
															}else if(j==11){
																SIList.add(nu6);
																SOList.add(-nu7);
															}else{
																SIList.add(nu0);
																SOList.add(nu0);
															}
														}
														if(i==2){
															if(j>5&&j<8){
																PIList.add(nu1);
																POList.add(-nu1);
															}else if(j==8){
																PIList.add(nu5);
																POList.add(nu0);
															}else{
																PIList.add(nu0);
																POList.add(nu0);
															}
														}
														if(i==3){
															if(j>8&&j<11){
															EIList.add(nu1);
															EOList.add(-nu1);
															}else if(j==11){
															EIList.add(nu7);
															EOList.add(nu0);
															}else{
															EIList.add(nu0);
															EOList.add(nu0);
															}
														}
														if(i==4){
															NIList.add(nu0);
															NOList.add(nu0);
														}
													}
																
													if(pid.indexOf("LCQG")>-1){
													//��ѧ�ĵ�һ��
														if(i==0){
															if(j<2){
															CIList.add(nu1);
															COList.add(-nu1);
															}else if(j==2){
															CIList.add(nu7);
															COList.add(nu0);
															}else {
															CIList.add(nu0);
															COList.add(nu0);
															}
														}
														if(i==1){
															if(j>2&&j<5){
															SIList.add(nu1);
															SOList.add(-nu1);
															}else if(j==5){
															SIList.add(nu3);
															SOList.add(nu0);
															}else{
															SIList.add(nu0);
															SOList.add(nu0);
															}
														}
														if(i==2){
															if(j<2){
															PIList.add(nu0);
															POList.add(-nu1);
															}else if(j==2){
															PIList.add(nu6);
															POList.add(-nu7);
															}else if(j>2&&j<5){
															PIList.add(nu0);
															POList.add(-nu1);
															}else if(j==5){
															PIList.add(nu2);
															POList.add(-nu3);
															}else if(j>5&&j<9){
															PIList.add(nu1);
															POList.add(nu0);
															}else if(j>8&&j<11){
															PIList.add(nu0);
															POList.add(-nu1);
															}else if(j==11){
															PIList.add(nu6);
															POList.add(-nu7);
															}else{
															PIList.add(nu0);
															POList.add(nu0);
															}
														}
														if(i==3){
															if(j>8&&j<11){
															EIList.add(nu1);
															EOList.add(-nu1);
															}else if(j==11){
															EIList.add(nu7);
															EOList.add(nu0);
															}else{
															EIList.add(nu0);
															EOList.add(nu0);
															}
														}
														if(i==4){
															NIList.add(nu0);
															NOList.add(nu0);
														}
											}
												
										}
								
										//------------------------------------------------------------
										%>
									<tr align="left">
										<td>
											<%=ptype%>
										</td>
										<%
										if(inforList.size()>0){
											for(int j=0; j<cloums.size();j++){
													float S1=0f;
													float S2=0f;
													float acount=qt.getAcount(); //��ҵ��
													float tax=0f; //��˰��
													if(qt.getInvtype()!=null&& qt.getInvtype().indexOf("��Ʊ")>-1){
														tax=qt.getTotalprice()*0.08f;
													}
													//System.out.println(Float.parseFloat(cloums.get(0).toString()));
													float G=Float.parseFloat(cloums.get(0).toString())/Z1;//ҵ��+˰��
													float prespefund=qt.getPrespefund() ; //����Ӵ���
													float presubcost=Float.parseFloat(cloums.get(1).toString());//�ְ�
													float preagcost=Float.parseFloat(cloums.get(2).toString());//����
													//S2=Z+tax+prespefund+presubcost+preagcost+
													//��Ŀҵ��
													Z=G*(qt.getTotalprice()-A-S-prespefund-tax);
													//��ѧ
													if(j>0){
													ZList.add(cloums.get(j));
													}
												%>
												<td>
												<%=cloums.get(j)%>
												</td>
												<%
											}
											ZList.add(Z);
											if(i==0){
											ZIList.add(CIList);
											ZOList.add(COList);
											}
											if(i==1){
											ZIList.add(SIList);
											ZOList.add(SOList);
											}
											
											if(i==2){
											ZIList.add(PIList);
											ZOList.add(POList);
											}
											if(i==3){
											ZIList.add(EIList);
											ZOList.add(EOList);
											}
											if(i==4){
											ZIList.add(NIList);
											ZOList.add(NOList);
											}
										}
									
										Sassist+=Float.parseFloat(cloums.get(0).toString());
										Spresubcost+=Float.parseFloat(cloums.get(1).toString());
										Spreeagcost+=Float.parseFloat(cloums.get(2).toString());
										Service+=Z;
																							
										 %>
										 <td>
										 	<%=Z==0.0?0:Z%>
										 </td>
										
									</tr>
													<%
											}
									}
										 %>
										 <tr>
										 	<td>
												С��
											</td>
											<td>
												<%=Sassist%>
											</td>
											<td >
												<%=Spresubcost%>
											</td>
											<td>
												<%=Spreeagcost%>
											</td>
											<td >
												<%=Service%>
											</td>
										 </tr>
									</table>
						</td>
						<td>
								<%
								for(int i=0;i<ZList.size();i++){
									//System.out.print(ZList.get(i)+"--");
								}
								for(int i=0;i<ZOList.size();i++){
									List cloums =(List)ZOList.get(i);
									for(int j=0;j<cloums.size();j++){
									//	System.out.print(cloums.get(j)+"**");
									}
									//System.out.println();
								}
								
								 %>
								<table width="100%" cellpadding="5" cellspacing="5" border="1">
									<tr bgcolor="#A9F5F2">
											
											<td>
												����
											</td>
											<td>
												����
											</td>
											<td>
												�˻�Ӧ����
											</td>
										</tr>
										<%
										//System.out.println("Prespefund:"+qt.getPrespefund());
										//System.out.println("tax:"+sun);
									float ICashier=0.0f;
									float ICashierStr=0.0f; //�˻�Ӧ��
									float ZICashierStr=0.0f; //���˻�Ӧ��
									float OCashier=0.0f;
									float ZICashier=0.0f;
									float ZOCashier=0.0f;
									float a=0f;
									float b=0f;
									float c=0f;
									for(int i=0;i<ZIList.size();i++){
									ICashier=0;
									OCashier=0;
									//System.out.println(ZIList.size());
											List cloums =(List)ZIList.get(i);
											List cloums1 =(List)ZOList.get(i);
											for(int j=0;j<cloums.size();j++){
												//ZList.size()
												a=Float.parseFloat(ZList.get(j).toString());
												b=Float.parseFloat(cloums.get(j).toString());
												//c=Float.parseFloat(cloums1.get(j).toString());
												ICashier+=a*b;
											}
											
											for(int j=0;j<cloums1.size();j++){
												//ZList.size()
												a=Float.parseFloat(ZList.get(j).toString());
												//b=Float.parseFloat(cloums.get(j).toString());
												c=Float.parseFloat(cloums1.get(j).toString());
												//ICashier+=a*b;
												OCashier+=a*c;
												//System.out.print(ICashier+"-j-");
											}
											ZICashier+=ICashier;
											ZOCashier+=OCashier;
											
											float acount=qt.getAcount(); //��ҵ��
											float tax=qt.getTotalprice()*0.08f; //��˰��
											if((qt.getPid().indexOf("LCQ1")>-1&&i==0)||(qt.getPid().indexOf("LCQ2")>-1&&i==1)||(qt.getPid().indexOf("LCQG")>-1&&i==2)||(qt.getPid().indexOf("LCQE")>-1&&i==3)){
											if(qt.getInvtype() !=null && qt.getInvtype().indexOf("��Ʊ")>-1){
											ICashierStr=ICashier+qt.getPrespefund()+(qt.getTotalprice()*0.08f);
												}else{
												ICashierStr=ICashier+qt.getPrespefund();
												}
											}else{
												ICashierStr=ICashier;
											}
												ZICashierStr+=ICashierStr;
											
										%>
										<tr>
												 <td>
												 	<%=ICashier%>
												 </td>
										
												 <td>
												 	<%=OCashier%>
												 </td>
												  <td>
												 	<%=ICashierStr%>
												 </td>
											</tr>
										<%} %>
										<tr>
												 <td>
												 	<%=ZICashier%>
												 </td>
										
												 <td>
												 	<%=ZOCashier%>
												 </td>
												 <td>
												 	<%=ZICashierStr%>
												 </td>
											</tr>
									</table>
						</td>
					</tr>
					</table>
				</div>
			</div>
			
			<hr width="97%" align="center" size=0>
			<div align="center">
			<%if(user.getId()!=233){
						%>
				<input name="btnModify" class="button1" type="button"
				id="btnModify" value="��ӡ�ڲ����˵�" onClick="printstatement()">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="�������">
				&nbsp;
				
				<input type="button" name ="lock" id="lock" value="<%=lockStr%>" onClick="lock1('<%=qt.getPid()%>','<%=qt.getLock()%>')">&nbsp;&nbsp;
				<%
				}
				 %>
				 
				<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="fincome('<%=chem%>','<%=safe%>','<%=op%>','<%=emc%>')" />
				<input name="btnBack" class="button1" type="button" id="btnBack" value="����" onClick="goBack()" />
			</div>
			<p>&nbsp;</p>
		</form>
	</body>
</html>
