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
		<title>化学项目排单</title>
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
/*工作区的背景色*/
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
				alert("样品名称不可为空!");
				return false;
			}
			if(document.form1.testcontent.value == "") {
				alert("测试项目不可为空!");
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
					<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>物品登记</b>
				</td>
			</tr>
		</table>


		<hr width="90%" align="center" size=0>

		<form name="form1" action="article_post.jsp?status=up&id=<%=id %>" method="post">
			<div class="">
				<table cellpadding="5" cellspacing="0" width="85%" align="center">
					<tr>
						<td width="18%">
							物品名称：
						</td>
						<td>
							<select name="article" style="width: 300px">
								<option value="">---请选择物品名称---</option>
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
							品牌：
						</td>
						<td >
						<input name="c1" size="40" value="<%=depot.getBrand() %>"  />
						</td>

					</tr>
					<tr>
						<td>
							规格型号：
						</td>
						<td >
								<input name="specification" size="40" value="<%=depot.getSpecification()==null?"":depot.getSpecification() %>" />
						</td>
						<td>
							数量：
						</td>
						<td>
							<input name="number" size="40" value="<%=depot.getNumber() %>"  />
						</td>
						

					</tr>

					<tr>
						<td> 
							物品金额： 
						</td>
						<td>
							<input name="price" size="40" value="<%=depot.getPrice()%>"    />
						</td>
						<td>
							供应商：
						</td>
						<td>
						<input name="client" type="text" id="client" size="40" value="<%=depot.getClient()==null?"":depot.getClient() %>"/>
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
						</td>
						
					</tr>
					<tr>
						<td> 
							计量单位： 
						</td>
						<td>
							<select name="c2" style="width: 300px">
								<%
								Map<String,String> classMap2 = DaoFactory.getInstance().getCategoryDao().getAllCategory(2);
								for(String value:classMap2.keySet()) {
								 %>
								<option value="<%=classMap2.get(value) %>"<%=classMap2.get(value).equals(depot.getUnitofaccount())?"selected":"" %>><%=classMap2.get(value) %></option>
								<%
								 }
								
								%>
							</select>
						</td>
						
							<td>
							使用状态：
							</td>
							<td>
							<select name="c3" style="width: 300px">
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
						<td>使用部门:</td>
						<td>
						<select name="dept" style="width: 300px">
								<%
								Map<String,String> deptMap = DaoFactory.getInstance().getDeptDao().getAllDept();
								for(String value:deptMap.keySet()) {
								 %>
								<option value="<%=value%>"><%=deptMap.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
							<td>存放位置</td>
							<td>
							<select name="c4" style="width: 300px">
								<%
								Map<String,String> classMap4 = DaoFactory.getInstance().getCategoryDao().getAllCategory(4);
								for(String value:classMap4.keySet()) {
								 %>
								<option value="<%=classMap4.get(value) %>"><%=classMap4.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
							
					</tr>
					
					<tr>
						<td>使用年限:</td>
						<td>
						<input name="usedate" type="text" id="usedate" size="40" value="<%=depot.getUserdate() %>" >
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'usedate'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
							</td>
							
							
							<td>
							经费来源：
							</td>
							<td>
							<select name="c5" style="width: 300px">
								<%
								Map<String,String> classMap5 = DaoFactory.getInstance().getCategoryDao().getAllCategory(5);
								for(String value:classMap5.keySet()) {
								 %>
								<option value="<%=classMap5.get(value) %>"  <%=classMap5.get(value).equals(depot.getFundstype())?"selected":"" %>><%=classMap5.get(value) %></option>
								<%
								 }
								
								%>
							</select>
							</td>
							
					</tr>
					<tr>
						<td>保管人:</td>
						<td>
						<input name="keeper" type="text" id="keeper" size="40"  value="<%=UserAction.getInstance().getUserById(depot.getKeepid()).getName() %>" />
						<!-- 调用ajax的方法；AutoComplete控件就是在用户在文本框输入前几个字母或是汉字的时候,该控件就能从存放数据的文或是数据库里将所有以这些字母开头的数据提示给用户,供用户选择,提供方便。  -->
						<script>   
						        $("#keeper").autocomplete("../sales_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
							</td>
						
							<td>
							复校准日期：
						</td>
						<td>
							<input name="nextcal" type="text" id="quotime" size="40" value="<%=depot.getNextcal() %>"/>
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'nextcal'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
					</tr>
					<tr>
						<td>  
							校准日期：  
						</td>
						<td>
							<input name="calibration" type="text" id="quotime" size="40" value="<%=depot.getCalibration() %>" />
							<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'calibration'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
								
						</td>
						<td> 
							合同编号： 
						</td>
						<td>
							<input name="contract" size="40" value="<%=depot.getContract() %>"    />
						</td>
					</tr>
					<tr>
					<td> 
							发票代码： 
						</td>
						<td>
							<input name="invoicecode" size="40" value="<%=depot.getInvoicecode() %>"    />
						</td>
						<td> 
							发票号码： 
						</td>
						<td>
							<input name="invoiceno" size="40" value="<%=depot.getInvoiceno() %>"    />
						</td>
					</tr>
					  <tr>
							<td>
								备注：
							</td>
							<td colspan="3">
								<textarea name="notes" cols="120" rows="6"><%=depot.getRemarks() %></textarea>
							</td>
						</tr>
				</table>
			</div>
		

				<hr width="90%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="submit" id="btnAdd"
						value="更改">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
		</form>
	</body>
</html>
