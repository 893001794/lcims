<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp" %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��Ӷ���</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
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

		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script language="javascript">
		function addproject() {
			with (document.getElementById("projectform")) {
			method="post";
			action="addquotation_post.jsp";
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
      encodeURIComponent(company)
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
    }        
  </script>

<!-- -------------ajax�˵�����end--------------------------- -->


	</head>

	<body class="body1">
		<form method="post" name="projectform" id="projectform"
			onSubmit="return CheckForm(this)">
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
						<b>&gt;&gt;���۹���&gt;&gt;¼�붩��</b>
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
							<input name="pid" type="text" id="pid" size="40" />
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
						</td>
						
					</tr>

					<tr>
						<td>
							�ֹ�˾��
						</td>
						<td>
							<select name="company" id="company" style="width: 300px" onchange="Change_Select();">
								<option value="��ɽ" selected="selected">
									��ɽ
								</option>
								<option value="����">
									����
								</option>
								<option value="��ݸ">
									��ݸ
								</option>
							</select>
						</td>
						<td>
							������Ա��
						</td>
						<td>
							<select name="sales" id="sales" style="width: 300px">
							
							</select>
						</td>

					</tr>
					<tr>
						
						<td width="17%">
							�ͻ����ƣ�
						</td>
						<td width="33%">
							<input id="client" type="text" name="client" size="40" />
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
						<td>
							��Ŀ���ƣ�
						</td>
						<td>
							<input type="text" id="projectcontent" name="projectcontent"
								size="40" />
						</td>
					</tr>
					<tr>
						
						<td>
							�ͻ�Ҫ��ʱ�䣺
						</td>
						<td width="33%">
							<input name="completetime" type="text" id="completetime"
								 size="40" />
							<img onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'completetime'})" src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
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
							<input name="standprice" id="standprice" type="text" size="40" />
						</td>
						<td width="17%">
							��Ŀ�ܽ�
						</td>
						<td width="33%">
							<input name="totalprice" id="totalprice" type="text" size="40" />
						</td>
					</tr>
					<tr>
						<td>
							��Ŀ�տʽ��
						</td>
						<td>
							<select name="advancetype" style="width: 300px">
								<option value="�½�">
									�½�
								</option>
								<option value="ȫ��Ԥ��">
									ȫ��Ԥ��
								</option>
								<option value="����Ԥ��">
									����Ԥ��
								</option>
								<option value="��ɺ�ȫ��">
									��ɺ�ȫ��
								</option>
								<option value="��ݴ���">
									��ݴ���
								</option>
								<option value="Ԥ�����">
									Ԥ�����
								</option>
								<option value="����">
									����
								</option>
							</select>
						</td>
						<td>
							��Ʊ��ʽ��
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
						</td>
					</tr>
					</table>
					<table id="invoice" width="95%" cellpadding="5" cellspacing="5">
					<tr>
					<td>
						Ʊ�����ͣ�
					</td>
					<td>
						<select name="invtype" style="width: 300px" >
							<option value="ȫ��" selected>ȫ��</option>
							<option value="������������">������������</option>
							<option value="�迪">�迪</option>
							<option value="�վ�">�վ�</option>
						</select>
					</td>
					<td width="17%">
							��Ʊ�ܽ�
						</td>
						<td width="33%">
							<input name="invcount" id="invcount" type="text" size="40" onfocus="getinvprice(this);" />
						</td>
					</tr>
					<tr>
						<td width="17%">
							��Ʊ̧ͷ��
						</td>
						<td width="33%">
							<input name="invhead" id="invhead" type="text" size="40" onfocus="getinvhead(this);" />
						</td>
						<td width="17%">
							��Ʊ���ݣ�
						</td>
						<td width="33%">
							<input name="invcontent" id="invcontent" type="text" size="40" onfocus="getinvcontent(this);" />
						</td>
					</tr>
				</table>
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							����Ӵ���Ԥ��
						</td>
						<td width="33%">
							<input name="prespefund" id="prespefund" type="text" size="40" />
						</td>
						<td width="17%">
							��ע��
						</td>
						<td width="33%">
							<input name="tag" type="text" size="40" />
						</td>
						
					</tr>
				</table>

			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="������Ŀ" onClick="addproject()">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onClick="goBack()" />
			</div>
		</form>
	</body>
</html>
