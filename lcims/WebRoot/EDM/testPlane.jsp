<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%	
	String itemNumber=request.getParameter("itemNumber");
 %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>������ϸ��Ϣ</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/orderscript.js"></script>
	<script language="javascript">
	function trans(){
		var retul ="";
		var planes =document.myform.list2;
		for(var i=0;i<planes.length;i++){
	    	var yle=planes[i].value;
	    	if(yle !="" && yle!=null){
		    	retul+=yle+"��";
		    }
   		 }
		 window.returnValue=retul;
		 window.close();
	}
	
	function moveOption(e1, e2){
	 try{
	  for(var i = 0; i < e1.options.length; i++){
	   if(e1.options[i].selected){
	    var e = e1.options[i];
	    e2.options.add(new Option(e.text, e.value));
	    e1.remove(i);
	    i = i - 1;
	   }
	  }
	  document.myform.id.value=getvalue(document.myform.list2);
	 }
	 catch(e){}
	}
	
	function getvalue(geto){
	 var allvalue = "";
	 for(var i = 0; i < geto.options.length; i++){
	  allvalue += geto.options[i].value + ",";
	 }
	 return allvalue;
	}
</script>


  </head>
  
  <body>
  <form action="#" method="post" name ="myform">
    <table width="400" align="center" border="1">
    <tr>
    	<th>���в�����Ŀ</th>
    	<th>ѡ����Ŀ</th>
    </tr>
    	
 	
 	<tr>
	 	<td>
	 		<select size="6" style="width: 150px;height: 300px" name ="list1" ondblclick="moveOption(document.myform.list1, document.myform.list2)">
	    			<option value="PH" >PH</option>
	    			<option value="LAS" >LAS</option>
	    			<option value="��ֲ����" >��ֲ����</option>
	    			<option value="������" >������</option>
	    			<option value="����" >����</option>
	    			<option value="BOD" >BOD</option>
	    			<option value="COD" >COD</option>
	    			<option value="SS" >SS</option>
	    		<%if(itemNumber.equals("28.09.26")){%>
	    			<option value="����" >����</option>
	    			<option value="�ӷ���" >�ӷ���</option>
	    			<option value="ʯ����" >ʯ����</option>
	    			<option value="Cu" >Cu</option>
	    			<option value="Ni" >Ni</option>
	    			<option value="Zn" >Zn</option>
	    			<option value="Cd" >Cd</option>
	    			<option value="Pb" >Pb</option>
	    			<option value="���۸�" >���۸�</option>
	    			<option value="TCN" >TCN</option>
	    			<option value="ɫ��" >ɫ��</option>
	    			<option value="�Ƕ�" >�Ƕ�</option>
	    			<option value="�ܽ���" >�ܽ���</option>
	    			<option value="�ܵ�" >�ܵ�</option>
	    			<option value="����" >����</option>
	    			<option value="������" >������</option>
	    		<%} %>
	 		</select>
	 	</td>
	 	<td>
	 		<select style="width: 150px;height: 300px"  name="list2" id="planes" size="6" ondblclick="moveOption(document.myform.list2, document.myform.list1)">
  			</select>
	 	</td>
 	</tr>
 	<tr style="text-align: center;">
 		<td colspan="2"><input type="button" onclick="trans();" value="�ύ"></td>
 	</tr>
    </table>
    </form>
  </body>
</html>
