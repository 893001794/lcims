<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.impl.SalesOrderItemDaoImpl"%>
<%@page import="com.lccert.crm.vo.SalesOrderItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%@ include file="../comman.jsp"  %>
 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
List list =new ArrayList ();
String itemNumber="";
if(command!=null && !"".equals(command)){
 itemNumber=request.getParameter("itemName");
 list=SalesOrderItemDaoImpl.getInstance().findItemByItemNumber(itemNumber);
}

 %>
 
<html>
<head>
<title>����ӵ���Ŀ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">


<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script type="text/javascript" src="../javascript/suggest.js"></script>
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   

<script type="text/javascript">   
 var xmlHttp ;

function createXmlHttpResquest(){
try{
    xmlHttp=new ActiveXObject('Msxml2.XMLHTTP');
} catch(e){
	try{
    	xmlHttp=new ActiveXObject('Microsoft.XMLHTTP');//IE����
	}catch(e){
       	try{
       		xmlHttp=new XMLHttpRequest();//ns��firefox����
       	}catch(e){
       		xmlHttp = false;
       	}
	}
}
}
    function retrieveChilds(object)   
    {   
   var parents;
  // alert(parents);
   createXmlHttpResquest();
   if(object ==1){
  
   parents= document.getElementById("parents").value;
   xmlHttp.onreadystatechange = handleServerResponse;
   }else{
   parents= document.getElementById("childs").value;
   xmlHttp.onreadystatechange = handleServerResponse2;
   }
   xmlHttp.open("GET", "/lcims/ajaxItem?parents="+parents+"&stutas="+object,true);
   xmlHttp.setRequestHeader( "Content-Type ",   "application/x-www-form-urlencoded ");         
	//��Ҫ����ʱ������Է�ֹ�������⣬ȷ��ÿ���ύ��URL��ͬ  
	xmlHttp.send(null);
    }
    function handleServerResponse(){ 
 		 if (xmlHttp.status == 200)//���سɹ�
        {
            document.getElementById("spUserName").innerHTML = xmlHttp.responseText;//responseXML 
        } 
	
    }
    
    function handleServerResponse2(){ 
 		 if (xmlHttp.status == 200)//���سɹ�
        {
            document.getElementById("spUserName2").innerHTML = xmlHttp.responseText;//responseXML 
        } 
	
    }
    
    function check(object){
  //  var parent =document.getElementById(object).value;
    document.getElementById("itemName").value=object.value;
    var myform=document.getElementById("myform");
    myform.submit();
        }
</script> 
</head>
<body>
<br>
<h4 align="center">���۲�ѯ��</h4><br>
<form name ="myform" id ="myform" action="saleorder_manage.jsp?command=command" method="post">
<table>
	<tr>
	<td>
		<input type="hidden" name ="itemName" >
	</td>
	<td width="8%">
							һ�����ࣺ
						</td>
						<td>
							<select name="parents" id="parents" style="width: 200px" onchange="retrieveChilds(1);">
							<option value="">��ѡ��һ������</option>
								<%
								List temp =SalesOrderItemDaoImpl.getInstance().getparent();
								for(int i=0;i<temp.size();i++) {
								Item item =(Item)temp.get(i);
								%>
								<option value="<%=item.getItemNumber()%>"><%=item.getItemNumber()%>&nbsp;&nbsp;<%=item.getName()%></option>
								<%
								 }
								%>
							</select>
						</td>
	<td width="8%">
							�������ࣺ
						</td>
						
						<td>
						 	<span id="spUserName" style="color:red;">&nbsp;</span>
						</td>
	<td width="8%">
							 �������ࣺ
						</td>
						
						<td>
						 	<span id="spUserName2" style="color:red;">&nbsp;</span>
						</td>		
	</tr>
</table>

<br>
<br><br>
<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					
					<td class="rd6" >
						������Ŀ����/����
					</td>
					<td class="rd6" >
						��׼���۽��
					</td>
					<td class="rd6" >
						���۱��۽��
					</td>
					<td class="rd6" >
						���Ʊ��۽��
					</td>
					<td class="rd6" >
						���
					</td>
					<td class="rd6" >
						��ͨ����
					</td>
					<td class="rd6" >
						�Ӽ�����
					</td>
					<td class="rd6" >
						�ؼ�����
					</td>
					<td class="rd6" >
						����
					</td>
				</tr>
			
				<%
				for (int i=0;i<list.size();i++){
				SalesOrderItem sitem =(SalesOrderItem)list.get(i);
				%>
				<tr>
					
					<td class="rd8">
						<%=itemNumber%>
						<%=sitem.getName() %>
					</td>
					<td class="rd8">
						<%=sitem.getSaleprice() %>
						
					</td>
					<td class="rd8">
						<%=sitem.getStandprice() %>
					</td>
					<td class="rd8">
						<%=sitem.getControlprice() %>
					</td>
					<td class="rd8">
						<%=sitem.getCategory() %>
					</td>
					<td class="rd8">
						<%=sitem.getNormalPeriod() %>
					</td>
					<td class="rd8">
						<%=sitem.getUrgentPeriod() %>
					</td>
					<td class="rd8">
						<%=sitem.getAbsolutPeriod() %>
					</td>
					<%
					if(user.getName().equals("������[Hadi]")||user.getName().equals("admin")){
					
					%>
					<td class="rd8">
						<a href="searchsaleorder.jsp?itemNumber=<%=itemNumber%>">�޸�</a>
					</td>
					<%
					}
					 %>
							
				</tr>
				
				<%
				}
				 %>
			</table>
			<table width="95%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						
					</td>
					
				</tr>
			</table>
</form>
</body>
</html>
