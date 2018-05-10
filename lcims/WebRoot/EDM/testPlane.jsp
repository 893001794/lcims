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
		<title>订单详细信息</title>
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
		    	retul+=yle+"、";
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
    	<th>所有测试项目</th>
    	<th>选中项目</th>
    </tr>
    	
 	
 	<tr>
	 	<td>
	 		<select size="6" style="width: 150px;height: 300px" name ="list1" ondblclick="moveOption(document.myform.list1, document.myform.list2)">
	    			<option value="PH" >PH</option>
	    			<option value="LAS" >LAS</option>
	    			<option value="动植物油" >动植物油</option>
	    			<option value="磷酸盐" >磷酸盐</option>
	    			<option value="氨氮" >氨氮</option>
	    			<option value="BOD" >BOD</option>
	    			<option value="COD" >COD</option>
	    			<option value="SS" >SS</option>
	    		<%if(itemNumber.equals("28.09.26")){%>
	    			<option value="总磷" >总磷</option>
	    			<option value="挥发酚" >挥发酚</option>
	    			<option value="石油类" >石油类</option>
	    			<option value="Cu" >Cu</option>
	    			<option value="Ni" >Ni</option>
	    			<option value="Zn" >Zn</option>
	    			<option value="Cd" >Cd</option>
	    			<option value="Pb" >Pb</option>
	    			<option value="六价铬" >六价铬</option>
	    			<option value="TCN" >TCN</option>
	    			<option value="色度" >色度</option>
	    			<option value="浊度" >浊度</option>
	    			<option value="溶解氧" >溶解氧</option>
	    			<option value="总氮" >总氮</option>
	    			<option value="硫化物" >硫化物</option>
	    			<option value="铬酸雾" >铬酸雾</option>
	    		<%} %>
	 		</select>
	 	</td>
	 	<td>
	 		<select style="width: 150px;height: 300px"  name="list2" id="planes" size="6" ondblclick="moveOption(document.myform.list2, document.myform.list1)">
  			</select>
	 	</td>
 	</tr>
 	<tr style="text-align: center;">
 		<td colspan="2"><input type="button" onclick="trans();" value="提交"></td>
 	</tr>
    </table>
    </form>
  </body>
</html>
