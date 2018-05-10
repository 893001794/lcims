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
	String strid = request.getParameter("id");
	int id = Integer.parseInt(strid);
	Order order = OrderAction.getInstance().getOrderById(id);
	Set set =new HashSet();
	List<QuoItem> quoitems = order.getQuoitems();
	for(int i=0;i<quoitems.size();i++) {
		QuoItem quoitem = quoitems.get(i);
		set.add(quoitem.getChildId());
	}
		Iterator it=set.iterator();
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
	var retul="";
	var retul1="";
	var yles=document.getElementsByName("yle");
	var usernams=document.getElementsByName("usernam");
	for(var i=0;i<yles.length;i++){
    	var yle=yles[i].value;
    	if(yle !="" && yle!=null){
	    	retul+=yle+",";
	    }
    }
    retul1= document.getElementById("id").value;
    $.ajax({ //调用jquery ajax
		type:"POST",  //跳转方法为POST
		url:"/lcims/emdPrice", //跳转了路径
		data:"empida="+retul+"&userid="+retul1+"&pid=<%=order.getPid()%>", //传输的值或参数
        error: function(){alert("error!!");},  //如果路径错误或者参数有错的时候就弹出此窗口
		success: function(data){  //如果正确或拿到java里面传输过来的值
		    var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
		 	var flag=agent.attr('suc'); //得到名称为xml对象里面的name对象
		 	if(flag.indexOf(true) >-1){
			 	window.returnValue=<%=order.getId()%>;
		  		window.close();
		  	 }
		 	}
	});
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
    	<th>所有人员</th>
    	<th>取样员</th>
    </tr>
    <%
     while(it.hasNext()){
     	 String str=it.next().toString();
     	 int childId=0;
     	  if(str !=null && !"".equals(str)){
				childId=Integer.parseInt(str);
			}
     %>
    	<tr style="text-align: center; display: none;">
    		<td>
	    		<select>
	    		<option value="<%=childId %>" name ="yle" id="yle"><%=OrderAction.getInstance().getQuoItems(childId,"child")%></option>
	    		</select>
    		</td>
    		<td>
	    		<select>
	    		<%
	    			List list=UserAction.getInstance().getEdmQC();
	    			for(int i=0;i<list.size();i++){
	    				UserForm user =(UserForm)list.get(i);
	    		 %>
	    		<option value="<%=user.getId()%>" name ="usernam" id="usernam" ><%=user.getName()%></option>
	    		<%} %>
	    		</select>
    		</td>
    	</tr>
 	<% } %>
 	
 	<tr>
	 	<td>
	 		<select size="6" style="width: 150px;height: 300px" name ="list1" ondblclick="moveOption(document.myform.list1, document.myform.list2)">
	 			<%
	    			List list=UserAction.getInstance().getEdmQC();
	    			for(int i=0;i<list.size();i++){
	    				UserForm user =(UserForm)list.get(i);
	    			
	    		 %>
	    		<option value="<%=user.getId()%>" name ="userId" id="userId" ><%=user.getName()%></option>
	    		<%} %>
	 		</select>
	 	</td>
	 	<td>
	 		<select style="width: 150px;height: 300px" multiple name="list2" size="6" ondblclick="moveOption(document.myform.list2, document.myform.list1)">
  </select>
	 	</td>
 	</tr>
 	<tr style="display: none;">
 		<td colspan="2"><input type="text" name="id" id="id" size="40"/></td>
 	</tr>
 	<tr style="text-align: center;">
 		<td colspan="2"><input type="button" onclick="trans()" value="提交"></td>
 	</tr>
    </table>
    </form>
  </body>
</html>
