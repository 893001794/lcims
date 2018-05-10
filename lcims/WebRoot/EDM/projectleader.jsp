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
    $.ajax({ //����jquery ajax
		type:"POST",  //��ת����ΪPOST
		url:"/lcims/emdPrice", //��ת��·��
		data:"empida="+retul+"&userid="+retul1+"&pid=<%=order.getPid()%>", //�����ֵ�����
        error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
		success: function(data){  //�����ȷ���õ�java���洫�������ֵ
		    var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
		 	var flag=agent.attr('suc'); //�õ�����Ϊxml���������name����
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
    	<th>������Ա</th>
    	<th>ȡ��Ա</th>
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
 		<td colspan="2"><input type="button" onclick="trans()" value="�ύ"></td>
 	</tr>
    </table>
    </form>
  </body>
</html>
