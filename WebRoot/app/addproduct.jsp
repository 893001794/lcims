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
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String status=request.getParameter("status");
	String proudctId=request.getParameter("proudctId");
	//����
	int genera=0;
	//С��
	int group =0;
	//��Ʒ����
	String product="";
	//��λ
	String unit="";
	//���
	String standard ="";
	//�ο���
	float price =0f;
	//Ԥ����
	String warning="";
	//��Ӧ��
	String suppliername="";
	//�Ƿ�Ϊ�̶��ʲ�
	String assets ="";
	if(proudctId !=null){
		List row =DaoFactory.getInstance().getInventoryDao().getProduct(Integer.parseInt(proudctId));
		List columns =(List)row.get(0);
		genera=Integer.parseInt(columns.get(3).toString());
		//System.out.println("����:"+genera);
		group=Integer.parseInt(columns.get(4).toString());
		//System.out.println("С��:"+group);
		product=columns.get(0).toString();
		unit=columns.get(5).toString();
		standard=columns.get(6).toString();
		price=Float.parseFloat(columns.get(1).toString());
		warning=columns.get(7).toString();
		assets=columns.get(8).toString();
		suppliername=columns.get(2).toString();
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��ӱ��۵�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script type="text/javascript" src="../javascript/jquery-1.3.2.min.js" ></script>
		<script type="text/javascript" src="../javascript/mln.colselect.js"></script>
        <link href="../css/mln-main.css" rel="stylesheet" type="text/css" charset="utf-8" />
        <!-- ����������ʽ -->
        <script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link href="../css/mln.colselect.css" rel="stylesheet" type="text/css">

		<%@ include file="searchallsupplier.jsp"%>
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
.hid {
	display: none;
}
</style>
<script type="text/javascript">
	var req;
	function load(){
	var genera=document.getElementById("genera").value;
	Change_Select(genera);
	}
    function Change_Select(obj){//����һ���������ѡ����ı�ʱ���øú���
      var url = "group_sales.jsp?itemNumber=" +obj + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("POST",url,true);
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
         // alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    //��������xml�ķ���
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
      var xSel = xmlDoc.getElementsByTagName('select');
      //���XML�ĵ��е�����<select>���
      var select_root = document.getElementById('group');
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
	     var ops = document.getElementById("group").options;
			for(var i=0;i<ops.length;i++) {
				if(ops[i].value==<%=group%>){
					ops[i].selected = true;	
				}
			}
		
	    }   
    
	    function checkForm(TheForm) {
		if (TheForm.product.value == "") {
			alert ("��Ʒ������Ϊ�գ�");
			TheForm.quotime.focus();
			return(false);
		}
		if (TheForm.standard.value == "") {
			alert ("�����Ϊ�գ�");
			TheForm.completetime.focus();
			return(false);
		}
		if (TheForm.unit.value == "") {
			alert ("��λ����Ϊ�գ�");
			TheForm.estimatesPoints.focus();
			return(false);
		}
		return(true);
	}   
	
	function addproduct(obj){
		var product =document.getElementById("product");
		var standard =document.getElementById("standard");
		var  unit=document.getElementById("unit");
		var  warning=document.getElementById("warning");
		if(product.value ==null || product.value==""){
			alert ("��Ʒ������Ϊ�գ�");
			product.focus();
			return false;
		}
		if(standard.value ==null || standard.value==""){
			alert ("�����Ϊ�գ�");
			standard.focus();
			return false;
		}
		if(unit.value ==null || unit.value==""){
			alert("�������׼������");
			unit.focus();
			return false;	
		}
		if(warning.value ==null || warning.value==""){
			alert("����Ԥ����������");
			unit.focus();
			return false;	
		}
		
		myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addproduct_post.jsp?status="+obj+"&proudctId=<%=proudctId%>";
		myform.submit();
	}
</script>
	</head>
	<body class="body1" onload="load();">
		<form method="post" name="quotationform" id="quotationform" action="addinventory_post.jsp"
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
							<b>������&gt;&gt;��Ӳ�Ʒ��Ϣ</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>

						<td width="12%">
							���ࣺ
						</td>
						<td width="33%">
							<select name="genera" id="genera" style="width: 300px" onchange="Change_Select(this.value);">
								<%
								Map<String,String> map =DaoFactory.getInstance().getInventoryDao().getCategory();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=value%>" <%=genera==Integer.parseInt(value)?"selected":"" %>><%=map.get(value)%></option>
								<%
								 }
								%>
							</select>
						</td>
						<td>
							С�ࣺ
						</td>
						<td>
						<select name="group" id="group" style="width: 300px">
						</select>
						</td>
					</tr>
					<tr>
						<td>
							��Ʒ����
						</td>
						<td>
							<input name="product" id ="product" size="40" value="<%=product==null?"":product%>">
						</td>
						<td>
							��λ��
						</td>
						<td width="33%">
							<input name="unit" type="text" id="unit" size="40" value="<%=unit==null?"":unit%>"/>
						</td>

					</tr>
					<tr>
						<td>
							���
						</td>
						<td>
							<input name="standard" type="text" id=""standard"" size="40" value="<%=standard==null?"":standard%>">
						</td>
						<td width="10%">
							�ο��ۣ�
						</td>
						<td>
							<input name="price" type="text" id="price" size="40" value="<%=price%>" />
						</td>
						
					</tr>
					<tr>
						<td width="10%">
							Ԥ����:
						</td>
						<td>
							<input id ="warning"  name ="warning" size="40" value="<%=warning==null?"":warning%>" >
						</td>
						<td>
							��Ӧ�̣�
						</td>
						<td>
							<input id="suppliername" type="text" name="suppliername"
								size="40" onkeyup="suggest(this.value,event,this);"
								onkeydown="return tabfix(this.value,event,this);"
								onblur="clearSuggest();" value="<%=suppliername==null?"":suppliername%>"/>
							<p class="nodisplay">
								<label>
									kIndex
								</label>
								<input class="nodisplayd" type="text" id="keyIndex" />
							</p>
							<p class="nodisplay">
								<label>
									rev
								</label>
								<input class="nodisplayd" type="text" id="sortIndex" />
							</p>

							<div id="results"></div>
						</td>
					</tr>
					<tr>
						<td> 
							�Ƿ�̶��ʲ��� 
						</td>
						<td>
							<input name="assets" type="radio"" id="assets" size="40" value="n" checked="checked">��
							<input name="assets" type="radio"" id="assets" size="40" value="y" <%=assets.equals("y")?"checked":"" %>>��
						</td>
						<td width="10%"> 
							 &nbsp;
						</td>
						<td>
							&nbsp;
						</td>
						
					</tr>
					<tr>
					
						<td colspan="4" style="text-align: center;">
						<%if(status ==null){
						%>
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="���沢���ر�ҳ" onClick="addproduct(1)">
						&nbsp;
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="����" onClick="addproduct(0);">
						<%
						}else{
						%>
						<input name="btnAdd" class="button1" type="button" id="btnAdd"
							value="�޸�" onClick="addproduct('<%=status%>')">
						<%
						} %>
						
					</td>
					</tr>
				</table>
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
