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
	String id =request.getParameter("id");
	String statusStr =request.getParameter("status");
	//���Id
	String inventoryId =request.getParameter("inventoryId");
	//ɾ�����޸�
	String type =request.getParameter("type");
	String status="";
	String earea="" ; //����
	String number =""; //����
	String remark ="" ; //��ע
	String productName=""; //��Ʒ����
	String productPrice=""; //��Ʒ�۸�
	String client=""; //�ͻ�����
	int productId=0;
	if(id !=null){
		productId =Integer.parseInt(id);
	}
	//��ȡ�����Ϣ
	if(inventoryId !=null){
		List inventoryRow=DaoFactory.getInstance().getInventoryDao().getInventory(Integer.parseInt(inventoryId));
		List inventoryColumn=(List)inventoryRow.get(0);
		productId=Integer.parseInt(inventoryColumn.get(0)+"");
		earea=inventoryColumn.get(1)+"";
		number=inventoryColumn.get(2)+"";
		productPrice=inventoryColumn.get(3)+"";
		client=inventoryColumn.get(4)+"";
		status=inventoryColumn.get(5)+"";
		remark=inventoryColumn.get(6)+"";
	}
	if(statusStr ==null){
		statusStr="";
	}
		if(statusStr.equals("storing")){
			status="���";
		}else if(statusStr.equals("outbound")){
			status="����";
		}
	List row=DaoFactory.getInstance().getInventoryDao().getProduct(productId);
	List column =(List)row.get(0);
	productName=column.get(0).toString();
	if(inventoryId ==null){
		productPrice =column.get(1).toString();
		client=column.get(2).toString();
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
    }   
	    function checkForm(obj) {
		if (document.getElementById("number").value == "") {
			alert ("��������Ϊ�գ�");
			document.getElementById("number").focus();
			return(false);
		}
		myform =document.getElementById("quotationform");
		myform.method="post";
		myform.action="addinventory_post.jsp?type="+obj+"&inventoryId=<%=inventoryId%>";
		//alert(window.dialogArguments);
		myform.submit();
		window.close();
	}   
</script>
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="addinventory_post.jsp"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="id" id ="id" type ="hidden" value="<%=productId%>">
			<input name ="status" id ="status" type ="hidden" value="<%=status%>">
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
							<b>������&gt;&gt;��ӿ��</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td>
							��Ʒ����
						</td>
						<td>
							<input name="product" id ="product" size="40" value="<%=productName%>">
						</td>
						<td width="15%">
							����
						</td>
						<td>
							<select name="earea" id="earea" style="width: 300px">
								<option value="��ɽ" selected="selected">��ɽ</option>
								<option value="��ݸ" <%=earea.equals("��ݸ")?"selected":"" %>>��ݸ</option>
							</select>
						</td>
					</tr>
					<%if(statusStr.equals("storing")){ %>
					<tr>
						<td width="10%"> 
							���ۣ� 
						</td>
						<td>
							<input name="price" type="text" id="price" size="40" value="<%=productPrice%>"/>
						</td>
						<td>
							��Ӧ�̣�
						</td>
						<td>
							<input id="suppliername" type="text" name="suppliername"
								size="40" onkeyup="suggest(this.value,event,this);"
								onkeydown="return tabfix(this.value,event,this);"
								onblur="clearSuggest();" value="<%=client ==null?"":client%>"/>
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
					<%} %>
					<tr>
						<td>
							<%=status%>������
						</td>
						<td>
							<input name="number" type="text" id="number" size="40" value="<%=number%>">
						</td>
						<td>��ע:
						</td>
						<td width="33%">
						<textarea rows="3" cols="3" style="width: 300px" name="remark" id ="remark">remark</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
						<%if(inventoryId ==null){
						%>
							<input type="button" onclick="checkForm('add')" value="���">
						<%
						}else{
						%>
							<input type="button" onclick="checkForm('modi')" value="�޸�">
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
