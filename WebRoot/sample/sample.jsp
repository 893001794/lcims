<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("gbk");

String pno="";
int number=1;
int listSize=0;
int sno =0;
String command=request.getParameter("command");
	if(command !=null){
	pno =request.getParameter("pno");
	int pnoL=pno.length();
		if(pnoL<10){
		out.print("<script type='text/javascript'>");
		out.print("alert('����Ŀ�ݺŵĳ���Ҫ����10���ַ���������׼ȷ��λ������');");
		out.print("</script>");
		}
		List pnoList =new ArrayList();
		pnoList.add("vpno");
		List list =DaoFactory.getInstance().getSimpleDao().getPackageNo(pnoList,pno);
		listSize=list.size();
		System.out.println(listSize);
		//�鿴��Ʒԭ���Ƿ��Ѿ���ֵ����
		List rows=DaoFactory.getInstance().getSimpleDao().getSampleSno(pno);
		if(rows.size()>0){
		List column =(List)rows.get(0);
		System.out.println(column.size());
		if(column.size()>0){
			String snoStr =column.get(0).toString();
			//System.out.println(snoStr);
			//System.out.println(snoStr.substring(snoStr.indexOf("-")+1,snoStr.length()));
			sno =Integer.parseInt(snoStr.substring(snoStr.indexOf("-")+1,snoStr.length()));
			//System.out.println(sno);
			
			}
		}
		number=Integer.parseInt(request.getParameter("number"));
}

 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>������Ʒ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link rel="stylesheet" href="../css/drp.css">
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
</script>
	<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
	<style type="text/css" bogus="1"> 
.txt{ 
color:#005aa7; 
border-bottom:1px solid #005aa7; /* �»���Ч�� */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* ����ɫ͸�� */ 
} 
</style> 
<script type="text/javascript">
	function onIsEmpty(obj){
		var pno =document.getElementById("pno").value;
		if(pno == ""){
		alert("��������Ʒ��ţ���");
		return false;
		}
		if(obj.value<=0){
		alert("��������Ʒ����������");
		return false;
		}
		var form1=document.getElementById("form1");
		form1.action="sample.jsp";
		form1.submit();
	}
	
	function checkForm(obj){
		if(obj==0){
		alert("û�д˿�ݺ�,���������룡��");
		return false;
		}
		
		var parentLab=document.getElementsByName("plane");
		for(var i=0;i<parentLab.length;i++){
			if(parentLab[i].value ==""){
				alert("��������Ʒ���ƣ�����");
				return false;
			}
		}
	}
	
	function clildLab(str,planid){
		$("#speichorot"+str)[0].options.length=0;
		jQuery.ajax({
			url:'child_lab.jsp?planid='+planid,
			type:'POST',
			synch:true,//(Ĭ��: true) Ĭ�������£����������Ϊ�첽���������Ҫ����ͬ�������뽫��ѡ������Ϊ false��ע�⣬ͬ��������ס��������û�������������ȴ�������ɲſ���ִ�С�
			dataType: 'xml',//������Բ�д����ǧ���дtext����html!!!   
			success:function(xml){//����ɹ���ص���������������������������������������ݣ�����״̬//
				$(xml).find('select').each(function(){
					var option1 = "<OPTION value='";   
					var option2 = "'>";   
					var option3 = "</OPTION>"; 
					var text = $(this).children("text").text(); //��ȡ�ı����ֵ
					var value = $(this).children("value").text(); //��ȡ���ݵ�ֵ
				//	alert(option1 + value + option2 + text + option3);
					$("#speichorot"+str).append(option1 + value + option2 + text + option3); 
				});
			}
		})
	}
</script>
  </head>
  
  <body> 
<form action="sample_post.jsp" method="post" name ="form1" id ="form1" onSubmit="return checkForm('<%=listSize%>');">
    	<table border="0" align="center" width="900">
    		<tr>
    		    <input type="hidden" name="command" value="search" />
    			<td>������ţ�<input type="text" id ="pno" name ="pno" size="40" value="<%=pno%>">&nbsp;&nbsp;��Ʒ������<input type="text" name ="number" id ="number"  size="20" value="<%=number %>" onBlur="onIsEmpty(this);">
				<script>   
				$("#pno").autocomplete("vpno_ajax.jsp",{
					delay:10,
					minChars:1,
					matchSubset:1,
					matchContains:1,
					cacheLength:5,
					matchContains: true,   
					scrollHeight: 250, 
					width:250,
					autoFill:false
				});    
				</script>  
    			</td>
    		</tr>
    	</table>
    	
    	<input type="hidden" name ="pno" id ="pno" value="<%=pno %>">
    	<table id ="mytable" border="0" align="center" width="900">
    		<tr>
    			<th>��Ʒ��ˮ��</th>
    			<th>��Ʒ����</th>
    			<th>�ͺ�</th>
    			<th>������</th>
    			<th colspan="2">����λ��</th>
    		</tr>
    		<%
    				pno=pno+"-";
					for(int i=1;i<=number;i++) {
					 %>
					<tr>
						<td>
							<div align="center">
								<input type="text" id="sno<%=i%>" value="<%=pno+(sno+i)%>"" name="sno" size="25" readonly="readonly"
									style="background-color: #FFCC99">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="sname<%=i%>" name="sname" size="25">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="smodel<%=i %>" name="smodel" size="25">
							</div>
						</td>
						<td>
							<div align="center">
								<input type="text" id="sid<%=i%>" name="sid" size="25" >
							</div>
						</td>
							<td>
								<!-- <input type="text" id="speichorot<%=i%>" name="speichorot" size="25"> -->
								<select name="plane" id="plane<%=i %>" style="width: 160px" onChange="clildLab('<%=i%>',this.value);">
									<option label="">---��ѡ���ŵ�ַ---</option>
									<%
									List rows =DaoFactory.getInstance().getSimpleDao().getParentLab();
										for(int j=0;j<rows.size();j++){
											List columns =(List)rows.get(j);
											%>
											<option value="<%=columns.get(0)%>"><%=columns.get(1)%></option>
											<%
										}
									 %>
								</select>
			
						</td>
						<td>
							<select id="speichorot<%=i%>" name="speichorot" style="width: 160" >
							</select>
						</td>
					</tr>
					<%
					}
					 %>
					 <tr align="center">
					 	<td colspan="6">
					 		<input type="submit" value="��Ʒ���">
					 	</td>
					 </tr>
    	</table>
    </form>
    </body>
</html>
