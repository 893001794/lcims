<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.impl.SalesOrderItemDaoImpl"%>
<%@page import="com.lccert.crm.vo.SalesOrderItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>

 
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");

List list = new ArrayList();
list =SalesOrderItemDaoImpl.getInstance().findAllOrderItem();
	int row=0;
	int rowCount=0;
 %>
 
<html>
<head>
<title>����ӵ���Ŀ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
</script>

<script type="text/javascript">   
    var xmlhttp; 
    //����һ��xml  
    function createXMLHTTPRequest(){   
        if(window.ActiveXObject){   
            xmlhttp =new ActiveXObject("Microsoft.XMLHttp");}   
        else if(window.XMLHTTPRequest){   
            xmlhttp = new XMLHTTPRequest();}   
        else  
            alert("������Ϣʧ��,�볢�����¿��������...");   
    }   
    function retrieveChilds()   
    {   
             //��ʼ��url,�������͸�action.   
        var url = "item?method=getchilds";   
        String parents=document.getElementById("").value;
        createXMLHTTPRequest();   
        xmlhttp.onreadystatechange = handleStateChange;   
        xmlhttp.open( "post", url, true );   
        xmlhttp.send("parent="+parents);      
    }   
    function handleStateChange(){   
    	alert(xmlhttp.readyState+"ajax��״̬");
        if( xmlhttp.readyState == 4 && xmlhttp.status == 200)   
        {   
           
        }   
    } 
     
</script> 
</head>
<body>
<br>
<h4 align="center">���񱨼۵�ͳ��</h4><br>
<table>
	<tr>
	<td width="15%">
							һ�����ࣺ
						</td>
						<td>
							<select name="parents" id="parents" style="width: 200px" onclick="a()">
							<option value="">��ѡ��һ������</option>
								
							</select>
						</td>
	<td width="15%">
							�������ࣺ
						</td>
						<td>
							<select name="childs" id="childs" style="width: 200px">
							<option value="">��ѡ��������ࣺ</option>
							</select>
						</td>
	</tr>
</table>
<br>
<br><br>
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
    <td align="center" valign="middle" >һ�����</td>
      <td  align="center" valign="middle">�������</td>
      <td  align="center" valign="middle" width="200px" style="width: 200px">������Ŀ</td>
       <td align="center" valign="middle" >��׼��</td>
        <td  align="center" valign="middle" >���۱���</td>
      <td  align="center" valign="middle" >��ͨ����</td>
      <td  align="center" valign="middle">�Ӽ�����</td>
      <td  align="center" valign="middle" >�ؼ�����</td>
    </tr>
 
<%

	for(int i=0;i<=list.size();i++){
		SalesOrderItem soi =(SalesOrderItem)list.get(i);
		
	
 %>
   
    
   <tr align=center valign=middle bgcolor="white"> 
     <%
     if(soi.getItem_number().length()<=2){
     rowCount=SalesOrderItemDaoImpl.getInstance().childs(soi.getItem_number());
     if(i == row){
     %>
     <td rowspan="<%=rowCount+1 %>"><%=soi.getItem_number() %></td>
     <%
     }
      row +=rowCount+1;
     }
     else{
     %>
   
     <td><%=soi.getItem_number() %></td>
      <td><%=soi.getName() %></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
     <%
     
     
     }
      %>
      
      
  </tr>
 
    
    <%
        
   }


     %>
       

  </table>

</body>
</html>
