<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	request.setCharacterEncoding("GBK");
	String idStr =request.getParameter("id");
	List columns =new ArrayList();
	String lab ="";
	String market ="" ; // ��Ч��
	String standard="";
	int id =0;
	if(idStr !=null && !"".equals(idStr)){
		id =Integer.parseInt(idStr.trim());
		List rows =DaoFactory.getInstance().getPhyQuoteManageDao().getPhyInfor(id,"psi");
		columns=(List)rows.get(0);
		if(columns.get(4)!=null && !"".equals(columns.get(4))){
			//��ȡ��׼
			String []standardIdStr =columns.get(4).toString().split(",");
			for(int i=0;i<standardIdStr.length;i++){
				int standardId=Integer.parseInt(standardIdStr[i].trim());
				//System.out.println(standardIdStr[i].trim()+"------------");
				List column=(List)DaoFactory.getInstance().getPhyQuoteManageDao().getPhyInfor(standardId,"ps").get(0);
				standard+=standardId+":"+column.get(2)+";"+"\n";
			}
		}
		if(columns.get(2)!=null){
			lab=columns.get(2).toString();
		}
		if(columns.get(3)!=null){
			market=columns.get(3).toString();
		}
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӵ��ӵ�����Ϣ</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
			
		<link rel="stylesheet" href="../../css/style.css">
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
		<script src="../../javascript/jquery.autocomplete.js"></script>
		
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
	width: 700px;
}
.hid {
	display: none;
}
</style>
		<script type="text/javascript">
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"�ͻ������Ƿ����");
	    validateclient(client);
	    }
	    
      function ajaxChange(){
	    Change_Select();
	    servinfo();
	    }
	    
	  function checkForm(TheForm) {
		if (TheForm.quotime.value == "") {
			alert ("�������ڲ���Ϊ�գ�");
			TheForm.quotime.focus();
			return(false);
		}
		if (TheForm.completetime.value == "") {
			alert ("�ͻ�Ҫ��ʱ�䲻��Ϊ�գ�");
			TheForm.completetime.focus();
			return(false);
		}
		if (TheForm.estimatesPoints.value == "") {
			alert ("���Ʋ��Ե�������Ϊ�գ�");
			TheForm.estimatesPoints.focus();
			return(false);
		}

		return(true);
	}
	
	function modifymoney(){
	var quotype=document.getElementById("quotype").value;
	if(quotype=="sup" || quotype=="add" || quotype=="flu"){
	var modifymoneytype=0;
	if(quotype =="sup"){
	modifymoneytype=1;
	}
	if(quotype =="add"){
	modifymoneytype=2;
	}
	if(quotype =="flu"){
	modifymoneytype=3;
	}
	self.location.href="../finance/quotation/adjustpid.jsp?type="+modifymoneytype;
	}
	}

	function addservice(obj,id){
		
		var nameCH=document.getElementById("nameCH").value;
		var price =document.getElementById("price").value;
		var market =document.getElementById("market").value;
		var lab =document.getElementById("lab").value;
		var standard =document.getElementById("testStandard").value;
		var circle =document.getElementById("circle").value;
		if(nameCH ==null || nameCH==""){
			alert("������������������");
			return false;
		}
		if(price ==null || price ==""){
			alert("�����뱨�۽�����");
			return false;
		}
		if(market == null || market ==""){
			alert("��ѡ������г�");
			return false; 
		}
		if(lab == null || lab==""){
			alert("��ѡ�����ʵ���ң�����");
			return false;
		}
		if(standard == null || standard ==""){
			alert("�������׼������");
			return false;
		}
		if(circle ==null || circle==""){
			alert("����������,��������Ϊ���֣�����");
			return false;
		}
		myform =document.getElementById("quotationform");
		myform.method="post";
		if(obj == 1){
		myform.action="phy_addserviceitem_post.jsp?status=1&id="+id;
		}else{
		myform.action="phy_addserviceitem_post.jsp?id="+id;
		}
		myform.submit();
	}
		</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="confirmUserId" id ="confirmUserId" type ="hidden" value="">
			<input name="totalprice" id="totalprice" type="hidden" value="" />
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
							<b>���ӵ�������&gt;&gt;��ӷ�����Ŀ</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="1100" cellpadding="5" cellspacing="5">
					<tr>
						<td >
							��������
						</td>
						<td width="33%">
						<%if(columns.size()>0){
						%>
						<input type="text" size="40" id ="nameCH" name ="nameCH"  value="<%=columns.get(0)==null?"":columns.get(0)%>">
						<%
						}else{
						%>
						<input type="text" size="40" id ="nameCH" name ="nameCH"  value="">
						<%
						} %>
						</td>
						<td>
							Ӣ������
						</td>
						<td >
						<%if(columns.size()>0){
						%>
							<input type="text" size="40" id ="nameEN" name ="nameEN"  value="<%=columns.get(1)==null?"":columns.get(1)%>">
						<%
						}else{
						%>
							<input type="text" size="40" id ="nameEN" name ="nameEN"  value="">
						<%
						} %>
						</td>
					</tr>
					<tr>
						<td > 
							���۽� 
						</td>
						<td width="33%">
						<%if(columns.size()>0){
						%>
							<input name="price" type="text" id="price" size="40"  value="<%=columns.get(6)==null?"":columns.get(6)%>"/>
						<%
						}else{
						%>
							<input name="price" type="text" id="price" size="40"  value=""/>
						<%
						} %>
						</td>
						<td > 
							���ڣ� 
						</td>
						<td>
							<%if(columns.size()>0){
						%>
							<input name="circle" type="text" id="circle" size="40"  value="<%=columns.get(7)==null?"":columns.get(7) %>"/>
						<%
						}else{
						%>
							<input name="circle" type="text" id="circle" size="40"  value=""/>
						<%
						} %>
							
						</td>
					</tr>
					<tr style="display: block;" id ="trpid">
						<td> 
							�����г��� 
						</td>
						<td width="33%">
							<select name="market" id ="market">
							<!-- ��ȡʵ������Ϣ-->
								<option value ="" selected="selected">---��ѡ������г�---</option>
								<option value ="ŷ��" <%=market.equals("ŷ��")?"selected":"" %>>ŷ��</option>
								<option value ="����" <%=market.equals("����")?"selected":"" %>>����</option>
								<option value ="����" <%=market.equals("����")?"selected":"" %>>����</option>
								<option value ="����" <%=market.equals("����")?"selected":"" %>>����</option>
							</select>
						</td>
						<td>
							����ʵ���ң� 
						</td>
						<td>
							<select name="lab" id ="lab">
							<!-- ��ȡʵ������Ϣ -->
								<option value ="" selected="selected">---��ѡ��ʵ����---</option>
								<%
								List rows =DaoFactory.getInstance().getPhyQuoteManageDao().getAllLab();
								for(int i =0;i<rows.size();i++){
									List column =(List)rows.get(i);
								%>
									<option value ="<%=column.get(0)%>" <%=lab.equals(column.get(0))?"selected":"" %>><%=column.get(1)%></option>
								<%
								}
								 %>
							</select>
						</td>
					</tr>
						<tr style="display: block;" id ="trpid">
						<td >���ƶȣ�</td>
						<td colspan="3">
						<%if(columns.size()>0){
						%>
							<textarea rows="1" cols="3" name ="restrictitem"  id="restrictitem" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"><%=columns.get(5)==null?"":columns.get(5)%></textarea>
						<%
						}else{
						%>
							<textarea rows="1" cols="3" name ="restrictitem"  id="restrictitem" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"></textarea>
						<%
						} %>
						</td>
					</tr>
					<tr style="display: block;" id ="trpid">
						<td >��ƷҪ��</td>
						<td colspan="3">
						<%if(columns.size()>0){
						%>
							<textarea rows="1" cols="3" name ="demand"  id="demand" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"><%=columns.get(8)==null?"":columns.get(8)%></textarea>
						<%
						}else{
						%>
							<textarea rows="1" cols="3" name ="demand"  id="demand" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"></textarea>
						<%
						} %>
						</td>
					</tr>
						<tr>
							<td>
								��׼��
							</td>
							<td colspan="3">
								<input name="standard" id="standard" type="text" size="103"
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
							<TD colspan="3">
							<textarea name="testStandard" id="testStandard" cols="3" rows="6" style="width:730" readonly="readonly"><%=standard%></textarea>
							</TD>
						</tr>
				</table>
			</div>
			<div align="center">
			<%if(idStr ==null){ %>
				<input name="btnAdd" class="button1" type="button" id="btnAdd" value="���沢���ر�ҳ" onClick="addservice(1,'<%=id%>');">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnAdd" class="button1" type="button" id="btnAdd" value="����" onClick="addservice(0,'<%=id%>');">
					<%}else{
					%>
					<input name="btnAdd" class="button1" type="button" id="btnAdd" value="�޸�" onClick="addservice(0,'<%=id%>');">
					<%
					} %>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="window.history.back()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
