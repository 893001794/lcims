<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ChemTestDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.vo.TestParents"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.vo.TestChildParent"%>

<%
	request.setCharacterEncoding("GBK");
	String satuts=request.getParameter("satuts");
	List list1 =new ArrayList ();
	if(satuts!=null & !"".equals(satuts)){
	if(satuts.equals("��������")){
		list1 =ChemTestDaoImpl.getInstance().findChemTestChild();
		}else	if(satuts.equals("��������")){
		list1 =ChemTestDaoImpl.getInstance().findChemTestPlan();
		}else 	if(satuts.equals("һ������")){
		list1 =ChemTestDaoImpl.getInstance().findChemTestParent();
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

		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		
</script>

		<script type="text/javascript">
		//����ı����Ƿ�Ϊ�ն���
		function checkSubimt(obj) {
		var love = document.getElementsByName("flowtype");
//ѡ���Ƿ��и�ѡ��ѡ�������ӡ
		var n = 0;
		for ( var i = 0; i < love.length; i++) {
		if (love[i].checked == true) {
		n = n + 1;
		document.getElementById("testype").value=love[i].value;
		var chemtestName =document.getElementById("chemtestName").value;
		var chemtestype =document.getElementById("chemtestype").value;
		var chemtestParent=document.getElementById("chemtestParent").value;
		var describe1C=document.getElementById("describe1C").value;
		var describe2C=document.getElementById("describe2C".value)
		var describe3C=document.getElementById("describe1C").vaule;
		var describe1E =document.getElementById("describe1E").value;
		var describe2E=document.getElementById("describe2E").value;
		var describe3E=document.getElementById("describe1E").value;
		
		//������һ�������������඼Ҫ�жϲ�����Ŀ�Ƿ�Ϊ�ն��� 
		if(chemtestName ==""){
		alert("������Ŀ����Ϊ��");
		return false;
		}
		//������һ�������������඼Ҫ�жϲ��Է����Ƿ�Ϊ�ն��� 
		if(love[i].value=="һ������"){
			if(chemtestype ==""){
			alert("������Ŀ�����Ϊ��");
			return false
			}
		}
		
		if(love[i].value=="��������"){
		//�����жϲ�����Ŀ���Ļ�Ӣ�������Ƿ�Ϊ�ն��� 
		if(describe1E =="" && describe1C ==""){
		alert("������Ŀ������������Ӣ����������һ������Ϊ��");
		return false;
		}
	
		
		//�����жϲ���Ҫ�� ���Ļ�Ӣ�������Ƿ�Ϊ�ն��� 
		else if(describe2E =="" && describe2C ==""){
		alert("����Ҫ�������������Ӣ����������һ������Ϊ��");
		return false;
		}
		//�����жϲ��Է������Ļ�Ӣ�������Ƿ�Ϊ�ն��� 
		else if(describe3E =="" && describe3C ==""){
		alert("���Է���������������Ӣ����������һ������Ϊ��");
		return false;
		}
		
		
		}
		}
		
	
		
		}
		
	   //�ж�������һ�ѡ��
		if (n < 1 || m < 1) {
		alert('����д��Ϣ,����ѡ��һ�� ��');
		return false;
		} else {
		
		return true;
		}




		
	

		

		}
		
	</script>
	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>��&nbsp; 
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���̲�����&gt;&gt;��ӹ��̲���</b>
				</td>
			</tr>
		</table>
	
		<hr width="97%" align="center" size=0>
		<form  action="addchemtest_post.jsp" onsubmit='return checkSubimt(this)' method="post">
			<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<tr>
					<td width="17%%">
						������Ŀ����:
					</td>
					<td >
					<div id="mydiv">
					<input type="hidden" name ="testype">
						��������
						<input type="checkbox" name="flowtype" value="��������" onClick="chooseOne(this);" checked="checked"/>
						|&nbsp;һ������
						<input type="checkbox" name="flowtype" value="һ������" onClick="chooseOne(this);"/>
						|&nbsp; ��������
						<input type="checkbox" name="flowtype" value="��������" onClick="chooseOne(this);"/>
						|&nbsp;��������
						<input type="checkbox" name="flowtype" value="��������" onClick="chooseOne(this);"/>
					</div>
					
					 <script>   
    
     function chooseOne(cb) { 
     var obj = document.getElementById("mydiv");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
             else obj.children[i].checked = true;   
         }
          if(cb.value=="һ������"){
         document.getElementById("type").style.display="block";
         document.getElementById("parentid").style.display="block";
         document.getElementById( "div1").style.display= "none"; 
         document.getElementById( "div2").style.display= "none"; 
         document.getElementById( "div3").style.display= "none"; 
         document.getElementById( "myTestDiv").style.display= "block"; 
         }   
         if(cb.value=="��������"){
         document.getElementById("type").style.display="block";
         document.getElementById("parentid").style.display="none";
         document.getElementById( "div1").style.display= "block"; 
         document.getElementById( "div2").style.display= "none"; 
         document.getElementById( "div3").style.display= "none"; 
         document.getElementById( "myTestDiv").style.display= "none"; 
         }  
         
           if(cb.value=="��������"){
         document.getElementById("type").style.display="block";
         document.getElementById( "div1").style.display= "none"; 
         document.getElementById("parentid").style.display="none";
         document.getElementById( "div2").style.display= "block"; 
         document.getElementById( "div3").style.display= "block"; 
          document.getElementById( "myTestDiv").style.display= "none"; 
         }    
         if(cb.value=="��������"){
         document.getElementById("type").style.display="none";
         document.getElementById("parentid").style.display="none";
         document.getElementById( "div1").style.display= "none"; 
         document.getElementById( "div2").style.display= "none"; 
         document.getElementById( "div3").style.display= "none"; 
          document.getElementById( "myTestDiv").style.display= "none"; 
         }
         
      }
 </script>
					</td>
				</tr>
							
			</table>
			<br>
			<table cellpadding="5" cellspacing="5" width="95%">
			<tr>
					<td width="17%">
						��������������
					</td>
					<td width="33%">
						<input name="chemtestName" type="text" size="40"/>
					</td>
					
				</tr>
				<tr id="type" style="display: none;">
				<td width="17%">
						���
					</td>
					<td width="33%">
						<select name ="chemtestype" style="width: 250px">
							<option value="">��ѡ�������Ŀ����</option>
							<option value="�޻���ת��" >�޻���ת��</option>
							<option value="�л���ת��" >�л���ת��</option>
							<option value="ʳƷ��ת��" >ʳƷ��ת��</option>
							<option value="�����ת��" >�����ת��</option>
							<option value="΢������ת��" >΢������ת��</option>
						</select>
					</td>
				</tr>
				<tr id ="parentid" style="display: none;">
					<td>һ����Ŀ��id</td>
					<td><input name ="parentid" id ="parentid" value="" size="40"><font color="red">id��id֮����,����</font></td>
				</tr>
				<tr>
					<td width="17%">
						�Ƿ���Ч��
					</td>
					<td width="33%">
						<select name ="chemteststatus" style="width: 150px">
							<option value="y" selected="selected">y</option>
							<option value="n">n</option>
						</select>
					</td>
				</tr>
			</table>
			
			<div id ="div1" style="display: none">
			<table>
				<tr>
					<td>������Ŀ(һ������)��</td>
					<td>
					<select name ="chemtestParent"> 
					<%
					List list =ChemTestDaoImpl.getInstance().findChemTestParent();
					for(int i=0;i<list.size();i++){
					
					TestParents tp =(TestParents)list.get(i);
					%>
					<option value="<%=tp.getId() %>"><%=tp.getName() %>&nbsp;&nbsp;<%=tp.getType() %></option>
					<%
					}
					 %>
					 	</select>
					</td>
				</tr>
			</table>
			</div>
			
			<div id ="div3" style="display: none">
			<table>
				<tr>
					<td>����Ҫ��(��������)</td>
					<td>
					<select name="chemtestchild"> 
					<%
					 list =ChemTestDaoImpl.getInstance().findChemTestChild();
					for(int i=0;i<list.size();i++){
					TestChildParent tp =(TestChildParent)list.get(i);
					%>
					<option value="<%=tp.getId() %>"><%=tp.getChildName() %>&nbsp;&nbsp;<%=tp.getType() %></option>
					<%
					}
					 %>
					 	</select>
					</td>
				</tr>
			</table>
			</div>
			<div id ="div2" style="display:none; ">
			<table cellpadding="5" cellspacing="5" width="95%">
				<tr>
					<td width="18%">�Ƿ��CNAS�£� 
					</td>
					<td>
						<select name ="isCNAS" style="width: 150px">
							<option value="y" selected="selected">y</option>
							<option value="n">n</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="18%">������Ŀ���������� 
					</td>
					<td>
						<textarea name="describe1C" rows="3" cols="76" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						����Ҫ������������ 
					</td>
					<td>
						<textarea name="describe2C" cols="73" rows="4" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						���Է������������� 
					</td>
					<td>
						<textarea name="describe3C" cols="73" rows="4" ></textarea>
					</td>
				</tr>
				<tr>
					<td width="18%">������ĿӢ�������� 
					</td>
					<td>
						<textarea name="describe1E" rows="3" cols="76" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						����Ҫ��Ӣ�������� 
					</td>
					<td>
						<textarea name="describe2E" cols="73" rows="4" ></textarea>
					</td>
				</tr>
				<tr>
					<td> 
						���Է���Ӣ�������� 
					</td>
					<td>
						<textarea name="describe3E" cols="73" rows="4" ></textarea>
					</td>
				</tr>
			</table>
			</div>
			<div id ="myTestDiv" style="display: none;">
				1	���ӵ�����Ʒ
				2	��߼���ͯ��Ʒ
				3	��֯Ʒ
				4	Ƥ��
				5	Ь��
				6	ʳƷ�Ӵ�����
				7	ľ��Ʒ
				8	Ϳ��/��ճ��
				9	����
				10	��װ����
				13	��ױƷ
				16	����
			</div>


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="���" >
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
