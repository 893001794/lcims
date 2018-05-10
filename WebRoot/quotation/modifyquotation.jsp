<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page errorPage="../error.jsp"%>
<%@ include file="../comman.jsp"  %>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Map"%>

<%
	if(!"admin".equals(user.getUserid())) {
		response.sendRedirect("../client/error.html");
		return;
	}
 %>

<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("myquotation.jsp");
		return;
	}
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
	
	if("�����".equals(qt.getEconfrim())) {
		response.sendRedirect("detail.jsp?pid=" + pid);
		return;
	}
	
	if(qt == null) {
		response.sendRedirect("myquotation.jsp");
		return;
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�޸Ķ���</title>
		<link rel="stylesheet" href="../css/style.css">
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

		<script language="javascript">
		function modify() {
			with (document.getElementById("form1")) {
				method="post";
				action="modifyquotation_post.jsp";
				submit();
			}
		}
		function goBack() {
		window.self.location="myquotation.jsp";
	}
	
	function getinvprice(invprice) {
		if(invprice.value == "") {
			invprice.value = document.getElementById("totalprice").value;
		}
	}
	
	function getinvhead(invhead) {
		if(invhead.value == "") {
			invhead.value = document.getElementById("client").value;
		}
	}
	
	function getinvcontent(invcontent) {
		if(invcontent.value == "") {
			var content = "����" + document.getElementById("pid").value;
			invcontent.value = content;
		}
	}
	
	function changeSelect(invtype) {
		if(invtype.value.match("����")) {
			//document.getElementById("invhead").readOnly=true;
			//document.getElementById("invhead").style.background="#F2F2F2";
			document.getElementById("invhead").value = "";
			document.getElementById("invhead").style.display="none";
			
			//document.getElementById("invcontent").readOnly=true;
			//document.getElementById("invcontent").style.background="#F2F2F2";
			document.getElementById("invcontent").value = "";
			document.getElementById("invcontent").style.display="none";
			
			//document.getElementById("invcount").readOnly=true;
			//document.getElementById("invcount").style.background="#F2F2F2";
			document.getElementById("invcount").value = "";
			document.getElementById("invcount").style.display="none";
			
			document.getElementById("invmethod").options[0].selected=true;
			
		} else {
			//document.getElementById("invhead").readOnly=false;
			//document.getElementById("invhead").style.background="#FFFFFF";
			
			//document.getElementById("invcontent").readOnly=false;
			//document.getElementById("invcontent").style.background="#FFFFFF";
			
			//document.getElementById("invcount").readOnly=false;
			//document.getElementById("invcount").style.background="#FFFFFF";
			document.getElementById("invhead").style.display="";
			document.getElementById("invcontent").style.display="";
			document.getElementById("invcount").style.display="";
			
		}
	}
	
		function changeMethod(invmethod) {
		if(invmethod.value.match("����Ŀ")) {
			document.getElementById("invtype").value = "ȫ��";
			document.getElementById("invcount").value = "";
			document.getElementById("invhead").value = "";
			document.getElementById("invcontent").value = "";
			document.getElementById("invoice").style.display="none";
			
		} else {
			document.getElementById("invoice").style.display="";
		}
	}

</script>




		<script language="javascript">
	function CheckForm(TheForm) {

		if (TheForm.priceid.value == "") {
			alert ("����۵���ţ�");
			TheForm.rtime.focus();
			return(false);
		}

		if (TheForm.sales.value == "") {
			alert ("����д������Ա��");
			TheForm.sales.focus();
			return(false);
		}

		if (TheForm.client.value == "-1") {
			alert ("��ѡ��ͻ����ƣ�");
			TheForm.client.focus();
			return(false);
		}
		
	return(true);
	}
</script>

		<!-- -------------ajax�˵�����start------------------------- -->

		<script type="text/javascript">
    var req;
    window.onload=function()
    {//ҳ�����ʱ�ĺ���
    	Change_Select();
    }
    
    function Change_Select(){//����һ���������ѡ����ı�ʱ���øú���
      var company = document.getElementById('company').value;
      var url = "addquotation_sales.jsp?company=" + encodeURI(encodeURI(company)) + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
         //ָ���ص�����Ϊcallback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //�ص�����
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//����XML�ĵ�
        }else{
          alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    //��������xml�ķ���
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
      var xSel = xmlDoc.getElementsByTagName('select');
      //���XML�ĵ��е�����<select>���
      var select_root = document.getElementById('sales');
      //�����ҳ�еĵڶ���������
      select_root.options.length=0;
      //ÿ�λ���µ����ݵ�ʱ���Ȱ�ÿ����������ܵĳ�����0
      
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //���ÿ��<select>����еĵ�һ����ǵ�ֵ,Ҳ����<value>��ǵ�ֵ
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //���ÿ��<select>����еĵڶ�����ǵ�ֵ,Ҳ����<text>��ǵ�ֵ
        
        var option = new Option(xText, xValue);
        //����ÿ��value��text��ǵ�ֵ����һ��option����

        try{
          select_root.add(option);//��option������ӵ��ڶ�����������
        }catch(e){
        }
      }
      var ops = document.getElementById("sales").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=qt.getSales()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
     
    }        
  </script>

		<!-- -------------ajax�˵�����end--------------------------- -->


		<script language="javascript">
		
		
		
		function goBack() {
		window.history.back();
		}
</script>
	</head>

	<body class="body1">
		<form name="form1" id="form1">
			<input type="hidden" name="id" value="<%=qt.getId() %>" />
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
						<b>&gt;&gt;���۹���&gt;&gt;�޸Ķ���</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							���۵���ţ�
						</td>
						<td width="33%">
							<input name="pid" type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getPid() %>" size="40" />
						</td>
						<td width="17%">
							���۵����ͣ�
						</td>
						<td width="33%">
							<select name="quotype" id="quotype" style="width: 300px" >
								<option value="new" selected="selected">
									�±��۵�
								</option>
								<option value="add">
									�����زⱨ�۵�
								</option>
								<option value="mod">
									�޸ı��汨�۵�
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("quotype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=qt.getQuotype()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>

						

					</tr>
					<tr>
						<td width="17%">
							�ֹ�˾��
						</td>
						<td width="33%">

							<select name="company" id="company" style="width: 300px"
								onchange="Change_Select();">
								<option value="��ɽ">
									��ɽ
								</option>
								<option value="����">
									����
								</option>
								<option value="��ݸ">
									��ݸ
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("company").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=qt.getCompany()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
						<td>
							������Ա��
						</td>
						<td>
							<select name="sales" id="sales" style="width: 300px">

							</select>
							<script type="text/javascript">
								
							</script>

						</td>
					</tr>
					<tr>
						<td width="17%">
							�ͻ����ƣ�
						</td>
						<td width="33%">
							<input id="client" type="text" name="client" size="40"
								value="<%=qt.getClient() %>" />
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
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
						<td width="17%">
							��Ŀ���ƣ�
						</td>
						<td width="33%">
							<input name="projectcontent" type="text" size="40"
								value="<%=qt.getProjectcontent() %>" />
						</td>
					</tr>
					<tr>
						<td width="17%">
							Ӧ���ʱ�䣺
						</td>
						<td width="33%">
							<input size="40" name="completetime"
								value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime()) %>" />
						</td>
						<td width="17%">
							&nbsp;
						</td>
						<td width="33%">
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							��Ŀ��׼���ۣ�
						</td>
						<td width="33%">
							<input name="standprice" type="text" size="40"
								value="<%=qt.getStandprice() %>" />
						</td>
						<td width="17%">
							��Ŀ�ܽ�
						</td>
						<td width="33%">
							<input name="totalprice" type="text" size="40"
								value="<%=qt.getTotalprice() %>" />
						</td>
					</tr>
					<tr>

						<td width="17%">
							��Ŀ�տʽ��
						</td>
						<td width="33%">
							<select name="advancetype" style="width: 300px">
								<%
								Map<String,String> advancetypes = FlowFinal.getInstance().getAdvancetype();
								for(String value:advancetypes.keySet()) {
								 %>
								<option value="<%=advancetypes.get(value) %>"><%=advancetypes.get(value) %></option>
								<%
								 }
								  %>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("advancetype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=qt.getAdvancetype()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
						<td>
							��Ʊ���ͣ�
						</td>
						<td>
							<select name="invmethod" id="invmethod" style="width: 300px" onchange="changeMethod(this)">
								<option value="����Ŀ" selected>
									����Ŀ
								</option>
								<option value="����Ŀ">
									����Ŀ
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("invmethod").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=qt.getInvmethod()%>".charCodeAt()){
										ops[i].selected = true;	
									}
								}
						</script>
						</td>
					</tr>
					</table>
					<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>

						<td width="17%">
							����Ʊ��ʽ��
						</td>
						<td width="33%">
							<select name="invtype" id="invtype" style="width: 300px" >
								<option value="ȫ��">
									ȫ��
								</option>
								<option value="������������">
									������������
								</option>
								<option value="�迪">
									�迪
								</option>
								<option value="�վ�">
									�վ�
								</option>
							</select>
							<script type="text/javascript">
								var ops = document.getElementById("invtype").options;
								for(var i=0;i<ops.length;i++) {
									if(ops[i].value.charCodeAt() == "<%=qt.getInvtype()%>".charCodeAt()){
										ops[i].selected = true;	
										changeSelect(document.getElementById("invtype"));
									}
								}
						</script>
						</td>
						<td width="17%">
							��Ʊ�ܽ�
						</td>
						<td width="33%">
							<input name="invcount" type="text" size="40"
								value="<%=qt.getInvcount() %>" />
						</td>
					</tr>
					<tr>

						<td width="17%">
							��Ʊ̧ͷ��
						</td>
						<td width="33%">
							<input name="invhead" type="text" size="40"
								value="<%=qt.getInvhead() %>" />
						</td>
						<td width="17%">
							��Ʊ���ݣ�
						</td>
						<td width="33%">
							<input name="invcontent" id="invcontent" type="text" size="40"
								value="<%=qt.getInvcontent() %>" />
						</td>
					</tr>
					</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							����Ӵ���Ԥ��
						</td>
						<td width="33%">
							<input name="prespefund" id="prespefund" type="text" size="40" value="<%=qt.getPrespefund() %>"/>
						</td>
						<td width="17%">
							��ע��
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" value="<%=qt.getTag() %>" />
						</td>
					</tr>
				</table>

			</div>

			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="�޸ı��۵�" onClick="modify()">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
		<script type="text/javascript">
			var ops1 = document.getElementById("invmethod");
			changeMethod(ops1);
			var ops2 = document.getElementById("invtype");
			changeSelect(ops2);
		</script>
	</body>
</html>
