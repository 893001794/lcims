<%@page import="com.lccert.crm.vo.TopLevel"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="com.lccert.crm.vo.TestChildParent"%>
<%@page import="com.lccert.crm.vo.TestPlan"%>
<%
	request.setCharacterEncoding("GBK");
	String flowtype=request.getParameter("flowtype");
	String planName=request.getParameter("planName");
	List list =new ArrayList();
	if(flowtype !=null && !"".equals(flowtype)){
	if(flowtype.equals("0")){
	flowtype="��������";
	}
	if(flowtype.equals("1")){
	flowtype="һ������";
	}
	if(flowtype.equals("2")){
	flowtype="��������";
	}
	if(flowtype.equals("3")){
	flowtype="��������";
	}
	String testype="";
	if(request.getParameter("code") !=null && !"".equals(request.getParameter("code"))){
		 testype=new 	String (request.getParameter("city").getBytes("ISO-8859-1"),"GBK");
		}else{
		 testype=request.getParameter("city");
		}

		if(testype !=null && !"".equals(testype)){
		if(flowtype.equals("��������")){
		list =ChemTestDaoImpl.getInstance().findChemTestChild(testype);
		}else 	if(flowtype.equals("һ������")){
		list =ChemTestDaoImpl.getInstance().findChemTestParent(testype);
		}
		}
		else if (planName !=null && !"".equals(planName)){
		list =ChemTestDaoImpl.getInstance().findChemTestPlan(planName);
		}
		
		else {
		if(flowtype.equals("��������")){
		list =ChemTestDaoImpl.getInstance().findChemTestChild();
		}else	if(flowtype.equals("��������")){
		list =ChemTestDaoImpl.getInstance().findChemTestPlan();
		}else 	if(flowtype.equals("һ������")){
		list =ChemTestDaoImpl.getInstance().findChemTestParent();
		}
		if(flowtype.equals("��������")){
		list =ChemTestDaoImpl.getInstance().findTopLevel();
		}
		}
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�����ת��</title>
<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>

<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" href="../css/style.css">
		<script type="text/javascript" src="../javascript/suggest.js"></script>
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />  
<script type="text/javascript">
	function checksubimt(){

	var check =document.getElementsByName("flowtype");
	
	var n =0;
	for(var i=0;i<check.length;i++){
	if(check[i].checked==true){
	n=n+1;
	
	}
	}
	 if(n<1){
	 alert("����Ҫѡ��һ�������Ŀ����");
	 }
	}

	
function isSelected(value) {
var cityName;
    var city = document.getElementById("city");
       //��ȡѡ�еĳ�������
       for(i=0;i<city.length;i++){
           if(city[i].selected==true){
            cityName = city[i].innerText;  //�ؼ���
           // alert("cityName:" + cityName);
           }
       }
       }
	
</script>


	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���̲�����&gt;&gt;��Ӳ�����Ŀ</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
		<form  action="searchchemtest.jsp" onsubmit='return checksubimt(this)' method="post">
			<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="15%">
						������Ŀ����:
					</td>
					<td >
					<div id="mydiv">
					<input type="hidden" name ="testype">
						��������
						<input type="checkbox" name="flowtype" value="��������" onclick="chooseOne(this)" />
						|
						һ������
						<input type="checkbox" name="flowtype" value="һ������" onclick="chooseOne(this)" />
						|&nbsp; ��������
						<input type="checkbox" name="flowtype" value="��������" onclick="chooseOne(this)"/>
						|&nbsp;��������
						<input type="checkbox" name="flowtype" value="��������" onclick="chooseOne(this)"/>
						&nbsp;&nbsp;<input type="submit" value="��ѯ">
						&nbsp;&nbsp;|&nbsp;&nbsp;
						<a href="addchemtest.jsp">���</a>
					</div>
						<script type="text/javascript">
							function chooseOne(cb) { 
						     var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
						             else obj.children[i].checked = true;   
						         }
						           if(cb.value=="��������"){
						         document.getElementById("div1").style.display= "none";
						          document.getElementById("div2").style.display= "block";  
						         }  
						         if(cb.value=="��������"){
						          document.getElementById("div1").style.display= "block"; 
						           document.getElementById("div2").style.display= "none"; 
						         }  
						           if(cb.value=="һ������"){
						          document.getElementById("div1").style.display= "block"; 
						           document.getElementById("div2").style.display= "none"; 
						         }  
						      }
						 </script>						
						
						<dir id="div1" style="display: none;">
						������Ŀ����&nbsp;&nbsp;
						<select onchange="isSelected(this.value);" id="city" name ="city"> 
						<option value="">----��ѡ�������Ŀ����----</option>
						<option value="�޻���ת��">�޻���ת��</option>
						<option value="�л���ת��" >�л���ת��</option>
						<option value="ʳƷ��ת��" >ʳƷ��ת��</option>
						<option value="�����ת��" >�����ת��</option>
						<option value="΢������ת��" >΢������ת��</option>
						</select> 
						</dir>
						
						<dir id="div2" style="display: none;">
						���Է�����&nbsp;&nbsp;
						<input name="planName" type="text" size="40"/>
						</dir>
					
   			</td>
				</tr>
							
			</table>
			<br>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				
				<tr>
					<%
					if(flowtype!=null&&flowtype.equals("��������")){
					%>
					<td class="rd6" >
						������Ŀ����
					</td>
					<td class="rd6" >
						����Ҫ������
					</td>
					<td class="rd6" >
						������Ŀ����
					</td>
					<td class="rd6" >
						�Ƿ���Ч
					</td>
					<td class="rd6" >
						����
					</td>
					<%
					}if (flowtype!=null&&flowtype.equals("һ������")){
					%>
					<td class="rd6" >
						������Ŀ����
					</td>
					<td class="rd6" >
						������Ŀ����
					</td>
					<td class="rd6" >
						�Ƿ���Ч
					</td>
					<td class="rd6" >
						����
					</td>
					<%
					}
					if(flowtype !=null && flowtype.equals("��������")){
					%>
					<td class="rd6" >
						������Ŀ����
					</td>
					<td class="rd6" >
						�Ƿ���Ч
					</td>
					<td class="rd6" >
						����
					</td>
					<%
					}if(flowtype!=null&&flowtype.equals("��������")){
					%>
					<td class="rd6" >
						������Ŀ����
					</td>
					<td class="rd6" >
						����Ҫ������
					</td>
					<td class="rd6" >
						���Է�������
					</td>
					<td class="rd6" >
						�Ƿ���Ч
					</td>
					<td class="rd6" >
						�Ƿ��CNSA��
					</td>
					<td class="rd6" >
						����
					</td>
					<%
					}
					%>
					
					
				</tr>
				<%
				for(int i=0;i<list.size();i++){
				if(flowtype.equals("һ������")){
				TestParents tp =(TestParents)list.get(i);
				%>
				<tr >
					<td class="rd8" style="text-align: left;">
						<%=tp.getName() %>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tp.getType() %>
					</td>
					<td class="rd8" style="text-align: left;">
					<%=tp.getStatus() %>
					</td>
					
					<td class="rd8" >
					<%
					if(flowtype.equals("һ������")){
					%>
					<a href="modiparent.jsp?status=<%=flowtype %>&id=<%=tp.getId()%>">�޸�</a>&nbsp;&nbsp;
					<%
					}
					 %>
						
						
					</td>		
				</tr>
				<%
				}else if (flowtype.equals("��������")){
				TopLevel tl =(TopLevel)list.get(i);
				%>
				<tr>
					<td class="rd8" style="text-align: left;">
					<%=tl.getName()%>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tl.getStatus()%>
					</td>
					<td class="rd8" >
					&nbsp;&nbsp;
					</td>
				</tr>
				<%
				}else if(flowtype.equals("��������")){
				TestChildParent tp =(TestChildParent)list.get(i);
				%>
				<tr>
					<td class="rd8" style="text-align: left;">
					<%=tp.getParentName() %>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tp.getChildName() %>
					</td>
					<td class="rd8" style="text-align: left;">
					<%=tp.getType() %>
					</td>
					<td class="rd8">
						<%=tp.getStatus() %>
					</td>
					
					<td class="rd8" >
						<a href="modichild.jsp?satuts=<%=flowtype%>&id=<%=tp.getId() %>">�޸�</a>&nbsp;&nbsp;
						
					</td>
							
				</tr>
				<%
				
				}else if(flowtype.equals("��������")){
				TestPlan tp =(TestPlan)list.get(i);
				
				%>
				<tr>
					
					<td class="rd8" style="text-align: left;">
					<%=tp.getParentName()%>
					</td>
					<td class="rd8" style="text-align: left;">
					<%=tp.getChildName()%>
					</td>
					<td class="rd8" style="text-align: left;">
						<%=tp.getPlanName()%>
					</td>
						<td class="rd8" style="text-align: left;">
					<%=tp.getStatus() %>
					</td>
						<td class="rd8" style="text-align: left;">
					<%=tp.getCnastatus() %>
					</td>
						<td class="rd8" >
						<a href="modiplan.jsp?satuts=<%=flowtype%>&id=<%=tp.getId() %>">�޸�</a>&nbsp;&nbsp;
					</td>
							
				</tr>
				<%
			}
			
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
