<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page errorPage="../error.jsp"%>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="java.util.Set"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	request.setCharacterEncoding("GBK");
	String idStr =request.getParameter("id");
	List columns =new ArrayList();
	String lab ="";
	String market ="" ; // 有效性
	String standard="";
	int id =0;
	if(idStr !=null && !"".equals(idStr)){
		id =Integer.parseInt(idStr.trim());
		List rows =DaoFactory.getInstance().getPhyQuoteManageDao().getPhyInfor(id,"psi");
		columns=(List)rows.get(0);
		if(columns.get(4)!=null && !"".equals(columns.get(4))){
			//获取标准
			String []standardIdStr =columns.get(4).toString().split(",");
			for(int i=0;i<standardIdStr.length;i++){
				int standardId=Integer.parseInt(standardIdStr[i].trim());
				//System.out.println(standardIdStr[i].trim()+"------------");
				List column=(List)DaoFactory.getInstance().getPhyQuoteManageDao().getPhyInfor(standardId,"ps").get(0);
				standard+=standardId+":"+column.get(2)+";"+"\n";
			}
		}
		if(columns.get(2)!=null){
			lab=columns.get(2).toString();
		}
		if(columns.get(3)!=null){
			market=columns.get(3).toString();
		}
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加电子电器信息</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
			
		<link rel="stylesheet" href="../../css/style.css">
		<link rel="stylesheet" type="text/css"
			href="../../css/jquery.autocomplete.css" />
		<script src="../../javascript/jquery.js"></script>
		<script src="../../javascript/jquery.autocomplete.min.js"></script>
		<script src="../../javascript/jquery.autocomplete.js"></script>
		
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
	width: 700px;
}
.hid {
	display: none;
}
</style>
		<script type="text/javascript">
	    function clientCheck(){
	    var client=document.getElementById("client");
	   // alert(client+"客户名称是否存在");
	    validateclient(client);
	    }
	    
      function ajaxChange(){
	    Change_Select();
	    servinfo();
	    }
	    
	  function checkForm(TheForm) {
		if (TheForm.quotime.value == "") {
			alert ("报价日期不能为空！");
			TheForm.quotime.focus();
			return(false);
		}
		if (TheForm.completetime.value == "") {
			alert ("客户要求时间不能为空！");
			TheForm.completetime.focus();
			return(false);
		}
		if (TheForm.estimatesPoints.value == "") {
			alert ("估计测试点数不能为空！");
			TheForm.estimatesPoints.focus();
			return(false);
		}

		return(true);
	}
	
	function modifymoney(){
	var quotype=document.getElementById("quotype").value;
	if(quotype=="sup" || quotype=="add" || quotype=="flu"){
	var modifymoneytype=0;
	if(quotype =="sup"){
	modifymoneytype=1;
	}
	if(quotype =="add"){
	modifymoneytype=2;
	}
	if(quotype =="flu"){
	modifymoneytype=3;
	}
	self.location.href="../finance/quotation/adjustpid.jsp?type="+modifymoneytype;
	}
	}

	function addservice(obj,id){
		
		var nameCH=document.getElementById("nameCH").value;
		var price =document.getElementById("price").value;
		var market =document.getElementById("market").value;
		var lab =document.getElementById("lab").value;
		var standard =document.getElementById("testStandard").value;
		var circle =document.getElementById("circle").value;
		if(nameCH ==null || nameCH==""){
			alert("请输入中文名！！！");
			return false;
		}
		if(price ==null || price ==""){
			alert("请输入报价金额！！！");
			return false;
		}
		if(market == null || market ==""){
			alert("请选择服务市场");
			return false; 
		}
		if(lab == null || lab==""){
			alert("请选择服务实验室！！！");
			return false;
		}
		if(standard == null || standard ==""){
			alert("请输入标准！！！");
			return false;
		}
		if(circle ==null || circle==""){
			alert("请输入周期,并且周期为数字！！！");
			return false;
		}
		myform =document.getElementById("quotationform");
		myform.method="post";
		if(obj == 1){
		myform.action="phy_addserviceitem_post.jsp?status=1&id="+id;
		}else{
		myform.action="phy_addserviceitem_post.jsp?id="+id;
		}
		myform.submit();
	}
		</script>

	</head>

	<body class="body1">
		<form method="post" name="quotationform" id="quotationform"
			onSubmit="return checkForm(this)">
			<input name="command" type="hidden" value="add" />
			<input name ="confirmUserId" id ="confirmUserId" type ="hidden" value="">
			<input name="totalprice" id="totalprice" type="hidden" value="" />
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>电子电器管理&gt;&gt;添加服务项目</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="1100" cellpadding="5" cellspacing="5">
					<tr>
						<td >
							中文名：
						</td>
						<td width="33%">
						<%if(columns.size()>0){
						%>
						<input type="text" size="40" id ="nameCH" name ="nameCH"  value="<%=columns.get(0)==null?"":columns.get(0)%>">
						<%
						}else{
						%>
						<input type="text" size="40" id ="nameCH" name ="nameCH"  value="">
						<%
						} %>
						</td>
						<td>
							英文名：
						</td>
						<td >
						<%if(columns.size()>0){
						%>
							<input type="text" size="40" id ="nameEN" name ="nameEN"  value="<%=columns.get(1)==null?"":columns.get(1)%>">
						<%
						}else{
						%>
							<input type="text" size="40" id ="nameEN" name ="nameEN"  value="">
						<%
						} %>
						</td>
					</tr>
					<tr>
						<td > 
							报价金额： 
						</td>
						<td width="33%">
						<%if(columns.size()>0){
						%>
							<input name="price" type="text" id="price" size="40"  value="<%=columns.get(6)==null?"":columns.get(6)%>"/>
						<%
						}else{
						%>
							<input name="price" type="text" id="price" size="40"  value=""/>
						<%
						} %>
						</td>
						<td > 
							周期： 
						</td>
						<td>
							<%if(columns.size()>0){
						%>
							<input name="circle" type="text" id="circle" size="40"  value="<%=columns.get(7)==null?"":columns.get(7) %>"/>
						<%
						}else{
						%>
							<input name="circle" type="text" id="circle" size="40"  value=""/>
						<%
						} %>
							
						</td>
					</tr>
					<tr style="display: block;" id ="trpid">
						<td> 
							服务市场： 
						</td>
						<td width="33%">
							<select name="market" id ="market">
							<!-- 获取实验室信息-->
								<option value ="" selected="selected">---请选择服务市场---</option>
								<option value ="欧洲" <%=market.equals("欧洲")?"selected":"" %>>欧洲</option>
								<option value ="澳洲" <%=market.equals("澳洲")?"selected":"" %>>澳洲</option>
								<option value ="美洲" <%=market.equals("美洲")?"selected":"" %>>美洲</option>
								<option value ="其他" <%=market.equals("其他")?"selected":"" %>>其他</option>
							</select>
						</td>
						<td>
							服务实验室： 
						</td>
						<td>
							<select name="lab" id ="lab">
							<!-- 获取实验室信息 -->
								<option value ="" selected="selected">---请选择实验室---</option>
								<%
								List rows =DaoFactory.getInstance().getPhyQuoteManageDao().getAllLab();
								for(int i =0;i<rows.size();i++){
									List column =(List)rows.get(i);
								%>
									<option value ="<%=column.get(0)%>" <%=lab.equals(column.get(0))?"selected":"" %>><%=column.get(1)%></option>
								<%
								}
								 %>
							</select>
						</td>
					</tr>
						<tr style="display: block;" id ="trpid">
						<td >限制度：</td>
						<td colspan="3">
						<%if(columns.size()>0){
						%>
							<textarea rows="1" cols="3" name ="restrictitem"  id="restrictitem" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"><%=columns.get(5)==null?"":columns.get(5)%></textarea>
						<%
						}else{
						%>
							<textarea rows="1" cols="3" name ="restrictitem"  id="restrictitem" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"></textarea>
						<%
						} %>
						</td>
					</tr>
					<tr style="display: block;" id ="trpid">
						<td >样品要求：</td>
						<td colspan="3">
						<%if(columns.size()>0){
						%>
							<textarea rows="1" cols="3" name ="demand"  id="demand" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"><%=columns.get(8)==null?"":columns.get(8)%></textarea>
						<%
						}else{
						%>
							<textarea rows="1" cols="3" name ="demand"  id="demand" style="width:76%;overflow-y:auto;resize: none;overflow-x:visible;overflow-y:visible;"></textarea>
						<%
						} %>
						</td>
					</tr>
						<tr>
							<td>
								标准：
							</td>
							<td colspan="3">
								<input name="standard" id="standard" type="text" size="103"
									value="" />
									<script>   
						        $("#standard").autocomplete("standard_ajax.jsp",{
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
							<TD>&nbsp;</TD>
							<TD colspan="3">
							<textarea name="testStandard" id="testStandard" cols="3" rows="6" style="width:730" readonly="readonly"><%=standard%></textarea>
							</TD>
						</tr>
				</table>
			</div>
			<div align="center">
			<%if(idStr ==null){ %>
				<input name="btnAdd" class="button1" type="button" id="btnAdd" value="保存并返回本页" onClick="addservice(1,'<%=id%>');">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnAdd" class="button1" type="button" id="btnAdd" value="保存" onClick="addservice(0,'<%=id%>');">
					<%}else{
					%>
					<input name="btnAdd" class="button1" type="button" id="btnAdd" value="修改" onClick="addservice(0,'<%=id%>');">
					<%
					} %>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="window.history.back()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
