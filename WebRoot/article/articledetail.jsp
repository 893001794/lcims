<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.vo.Depot"%>
<%@page import="com.lccert.crm.user.UserAction"%>



<%
	request.setCharacterEncoding("GBK");
	String id =request.getParameter("id");
	Depot depot=DaoFactory.getInstance().getDepotDao().searchDepot(Integer.parseInt(id));
	
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��ѧ��Ŀ�ŵ�</title>
		<link rel="stylesheet" href="../css/drp.css">

		<script src="../javascript/orderscript.js"></script>
		<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.js"></script>
		
		<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}

. {
	border: solid 1px;
}
</style>
		<script language="javascript">
		
		function goBack() {
			window.history.back();
		}
		function addAppform(temp) {
			document.getElementById("appform").value += temp;
			document.getElementById("appform").value += "\n";
		}
		
		function showrid() {
		window.open("../../project/showrid.jsp","","dialogWidth:800px;dialogHeight:1200px","scrollbars=yes,resizable=yes");
	}
	
		function checkForm() {
			if(document.form1.samplename.value == "") {
				alert("��Ʒ���Ʋ���Ϊ��!");
				return false;
			}
			if(document.form1.testcontent.value == "") {
				alert("������Ŀ����Ϊ��!");
				return false;
			}
			document.form1.submit();
		}
		
	</script>

	</head>

	<body class="body1">
		<table width="85%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					.<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>��Ʒ�Ǽ�</b>
				</td>
			</tr>
		</table>


		<hr width="90%" align="center" size=0>

		<form name="form1" action="printarticle.jsp?id=<%=id %>" method="post">
			<div class="">
				<table cellpadding="5" cellspacing="0" width="85%" align="center">
					<tr>
						<td width="18%">
							��Ʒ���ƣ�
						</td>
						<td>
							<select name="article" style="width: 300px"  disabled="disabled">
								<%
								Map<String,String> map = DaoFactory.getInstance().getArticleDao().getAllArticle();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=value %>" <%=Integer.parseInt(value)==depot.getAid()?"selected":"" %>  ><%=map.get(value)%></option>
								<%
								 }
								%>
							</select>
						</td>
						<td width="15%">
							Ʒ�ƣ�
						</td>
						<td >
	                   <input name="c1" size="40" value="<%=depot.getBrand() %>" readonly="readonly"   />
						</td>

					</tr>
					<tr>
						<td>
							����ͺţ�
						</td>
						<td >
								<input name="specification" size="40" value="<%=depot.getSpecification()==null?"":depot.getSpecification() %>" readonly="readonly"   />
						</td>
						<td>
							������
						</td>
						<td>
							<input name="number" size="40" value="<%=depot.getNumber() %>"  readonly="readonly"  />
						</td>
						

					</tr>

					<tr>
						<td> 
							��Ʒ�� 
						</td>
						<td>
							<input name="price" size="40" value="<%=depot.getPrice()%>" readonly="readonly"/>
						</td>
						<td>
							��Ӧ�̣�
						</td>
						<td>
							<input name="client" type="text" id="client" size="40" value="<%=depot.getClient()==null?"":depot.getClient() %>" readonly="readonly" />
						</td>
						
					</tr>
					<tr>
						<td> 
							������λ�� 
						</td>
						<td>
							<select name="c2" style="width: 300px"  disabled="disabled">
								<%
								Map<String,String> classMap2 = DaoFactory.getInstance().getCategoryDao().getAllCategory(2);
								for(String value:classMap2.keySet()) {
								 %>
								<option value="<%=classMap2.get(value) %>" <%=classMap2.get(value).equals(depot.getUnitofaccount())?"selected":"" %>><%=classMap2.get(value) %></option>
								<%
								 }
								
								%>
							</select>
						</td>
						
							<td>
							ʹ��״̬��
							</td>
							<td>
							<select name="c3" style="width: 300px"  disabled="disabled">
								<%
								Map<String,String> classMap3 = DaoFactory.getInstance().getCategoryDao().getAllCategory(3);
								for(String value:classMap3.keySet()) {
								 %>
								<option value="<%=classMap3.get(value) %>" <%=classMap3.get(value).equals(depot.getUsestatus())?"selected":"" %> ><%=classMap3.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
						
					</tr>
					<tr>
						<td>ʹ�ò���:</td>
						<td>
						<select name="dept" style="width: 300px"  disabled="disabled">
								<option value="">---��ѡ����---</option>
								<%
								Map<String,String> deptMap = DaoFactory.getInstance().getDeptDao().getAllDept();
								for(String value:deptMap.keySet()) {
								 %>
								<option value="<%=value%>"  <%=Integer.parseInt(value)==depot.getDeptid()?"selected":"" %>><%=deptMap.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
							<td>���λ��</td>
							<td>
							<select name="c4" style="width: 300px"  disabled="disabled">
								<%
								Map<String,String> classMap4 = DaoFactory.getInstance().getCategoryDao().getAllCategory(4);
								for(String value:classMap4.keySet()) {
								 %>
								<option value="<%=classMap4.get(value) %>" <%=classMap4.get(value).equals(depot.getAperture())?"selected":"" %>><%=classMap4.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
							
					</tr>
					
					<tr>
						<td>ʹ������:</td>
						<td>
						<input name="usedate" type="text" id="usedate" size="40" value="<%=depot.getUserdate() %>" readonly="readonly"/>
							</td>
							
							
							<td>
							������Դ��
							</td>
							<td>
							<select name="c5" style="width: 300px"  disabled="disabled">
								<%
								Map<String,String> classMap5 = DaoFactory.getInstance().getCategoryDao().getAllCategory(5);
								for(String value:classMap5.keySet()) {
								 %>
								<option value="<%=classMap5.get(value) %>" <%=classMap5.get(value).equals(depot.getFundstype())?"selected":"" %>><%=classMap5.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
							
					</tr>
					<tr>
						<td>������:</td>
						<td>
						<input name="keeper" type="text" id="keeper" size="40" value="<%=UserAction.getInstance().getUserById(depot.getKeepid()).getName() %>"  readonly="readonly"/>
							</td>
						
							<td>
							��У׼���ڣ�
						</td>
						<td>
							<input name="nextcal" type="text" id="quotime" size="40" value="<%=depot.getNextcal() %>" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td> 
							У׼���ڣ� 
						</td>
						<td>
							<input name="calibration" type="text" id="quotime" size="40" value="<%=depot.getCalibration() %>" readonly="readonly"/>
							
								
						</td>
						<td>������ţ�</td>
					<td>
							<input name="invoiceno" size="40" value="<%=depot.getApplication()==null?"":depot.getApplication() %>"   readonly="readonly" />
						</td>
					</tr>
					<tr>
					<td>
						��ͬ���:
					</td>
					<td>
						<input name ="contract" size="40" value="<%=depot.getContract()==null?"":depot.getContract() %>"  readonly="readonly"  />
					</td>
					
					<td>���ձ��ţ�</td>
					<td>
							<input name="acceptance" size="40" value="<%=depot.getAcceptance()==null?"":depot.getAcceptance() %>"  readonly="readonly"  />
						</td>
					</tr>
					<tr>
	
						<td>
							��Ʊ���룺
						</td>
						<td>
							<input name="invoiceno" size="40" value="<%=depot.getInvoiceno()==null?"":depot.getInvoicecode() %>"  readonly="readonly"  />
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					  <tr>
							<td>
								��ע��
							</td>
							<td colspan="3">
								<textarea name="notes" cols="120" rows="6" readonly="readonly" ><%=depot.getRemarks() %></textarea>
							</td>
						</tr>
				</table>
			</div>
		

				<hr width="90%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="��ӡ">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onClick="goBack()" />
				</div>
		</form>
	</body>
</html>
