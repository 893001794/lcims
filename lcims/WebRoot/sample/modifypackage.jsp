<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
String strId=request.getParameter("id");
String client ="";
int id =0;
if(strId !=null){
	 id =Integer.parseInt(strId);
	//���ݻ�ȡ������Ϣ
	List list =new ArrayList();
	list.add("vclient");
	List row=DaoFactory.getInstance().getSimpleDao().getPackageById(list,id);
	List colunm=(List)row.get(0);
	client =colunm.get(0).toString();
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
		<script src="../javascript/Calendar.js"></script>
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script src="../javascript/orderscript.js"></script>
		<script type="text/javascript">
			function trans(){
					var client=document.getElementById("client").value;
					  $.ajax({ //����jquery ajax
						type:"POST",  //��ת����ΪPOST
						//url:"http://www.pingan.com/cms-tmplt/insurance/validateNetsWorkNumber.do",
						url:"/lcims/upSamplePack", //��ת��·��
						data:"client="+client+"&id=<%=id%>", //�����ֵ�����
				        error: function(){alert("error!!");},  //���·��������߲����д��ʱ��͵����˴���
						success: function(data){  //�����ȷ���õ�java���洫�������ֵ
						    var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
						 	if(agent.attr('suc') == 'true'){ //�õ�����Ϊagent��xml��������sucԪ�أ������ж�sucԪ�ص�ֵ�Ƿ�Ϊtrue
						 	var userId=agent.attr('name'); //�õ�����Ϊxml���������name����
							alert("�޸ĳɹ���");
							window.returnValue="true";
							//window.dialogArguments.location=window.dialogArguments;
							 //window.dialogArguments.window.location="user.do";
							self.close();
							}else{
							alert("�޸�ʧ��");
							return false;
							}}
					});
					  
				} 
		</script>
	</head>
	<body class="body1">
		<form>
			<table width="500" height="10" align=" " >
    	<tr>
    		<td align="center"">
    			������ͻ�����:<input type="text"" size="40" name ="client" id="client" value="<%=client%>">
    			<input type="button" onclick="trans();" value="�޸�">
    		</td>
    	</tr>
 	
    </table>
    </form>
	</body>
</html>
