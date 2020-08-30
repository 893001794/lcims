<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.lccert.crm.quotation.FinanceQuotationUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	String sealupType = request.getParameter("sealupType");
	String sealupParam = request.getParameter("sealupParam");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = null;
	String pid = request.getParameter("pid");
	String price = request.getParameter("price");
	String client =request.getParameter("client");
	String type = request.getParameter("type");
	System.out.println(client+"-----");
	if(client !=null&&!"".equals(client)&&!"null".equals(client)){
		if(type == null  ) {
			client = new String(client.getBytes("iso-8859-1"),"GBK");
		}
	}
	//System.out.println(client+"---------");
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String status=request.getParameter("status");
	FinanceQuotationUtil fqu = new FinanceQuotationUtil();
	fqu.setPid(pid==null?"":pid);
	fqu.setPrice(price==null?"":price);
	fqu.setClient(client==null?"":client);
	fqu.setStart(start==null?"":start);
	fqu.setEnd(end==null?"":end);
	fqu.setStatus(status==null?"":status);
	fqu.setPageNo(pageNo);
	fqu.setPageSize(pageSize);
	UserForm user = (UserForm)session.getAttribute("user");
	//boolean flag =user.getTicketid().matches("00010101");
	String userName =user.getName();
	//System.out.println(userName+"-------");
	if(userName.equals("郑妙芳")){
	fqu.setStatus("LCQD");
	}
	
	if(sealupType !=null&& "1".equals(sealupType)){
	if(sealupParam!=null&&sealupParam!=""){
		if(sealupParam.equals("n")){
			sealupParam ="y";
		}else{
			sealupParam ="n";
		}
	}
	//System.out.println(sealup);
	Quotation qt =new Quotation();
	String pidStr = request.getParameter("pidStr");
	qt.setPid(pid);
	qt.setSealup(sealupParam);
	FinanceQuotationAction.getInstance().quotationSealUp(qt);
	}
	pm = FinanceQuotationAction.getInstance().searchQuotations(fqu,"");
	if (pm == null) {
		pm = new PageModel();
	}
%>

<html>
	<head>
		<title>报价清单</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../../css/css1.css" type="text/css"
			media="screen">
		<script language="javascript" type="text/javascript"
			src="../../javascript/date/WdatePicker.js"></script>
		<script language="JavaScript" type="text/JavaScript">
function delpay()
{
   if(confirm("确定要删除此吗？"))
     return true;
   else
     return false;	 
}

	function changeStatus() {
			var  myform =document.getElementById("form1");
			myform.method = "post";
			myform.action = "quotation_manage.jsp";
			myform.submit();
	}
	
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}
	function sealup(Object,sealup){
	//alert(document.getElementById("start").value);
	    var myForm =document.getElementById("form1");
	   // var sealup =document.getElementById("sealup").value;
			myForm.action="quotation_manage.jsp?sealupType=1&pid="+Object+"&sealupParam="+sealup;
			myForm.submit();
			return ;
			//}
		}
		
	function receipt(obj){
		var flag =false;
		var result="";
		var check = document.getElementsByName("selectFlag");
		for(var i=0;i<check.length;i++){
		if(check[i].checked==true){
			flag =true;
			result+=check[i].value+",";
		}
	    }
	    if(flag == false){
	   		alert("请选择开收据的报价单！！！");
	   	}else{
	   		//alert(result);
	   		//window.open("addMail2Client.jsp?ridStr="+result+"&vpid="+pid);  LCQE12110886
	   		if(obj=="0"){
	   		self.location="addreceipt.jsp?pid="+result;
	   		}else{
	   		self.location="quotationlog.jsp?pid="+result;
	   		}
	   		
	   	}
		//window.showModelessDialog("printorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
	}
</script>
		<%--@ include file="date.jsp" --%>
	</head>

	<body text="#000000" topmargin=0>
		<body text="#000000" topmargin=0>
		<form name="form1" id ="form1" method="post" action="quotation_manage.jsp?type=1">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th height="25">
						报价单号
					</th>
					<th>
						报价金额
					</th>
					<th>
						客户名称
					</th>
					<th>
						开始时间
					</th>
					<th>
						结束时间
					</th>
					<th>
						区域
					</th>

					<th>
						&nbsp;
					</th>

				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=pid type="text" id="pid" size="20" maxlength="50"
							value="">
					</td>
					<td>
						<input name=price type="text" id="price" size="20" maxlength="50"
							value="">
					</td>
					<td>
						<input name=client type="text" id="client" size="20"
							maxlength="50" value="">
					</td>
					<td>
						<input name="start" type="text" id="start" size="20"
							maxlength="50" value="">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'start'})"
							src="../../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</td>

					<td>
						<input name="end" type="text" id="end" size="20" maxlength="50"
							value="">
						<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'end'})"
							src="../../javascript/date/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</td>
<%if(!userName.equals("郑妙芳")){%>
					<td>地区：
							<select name="status" style="width: 100px" onchange="changeStatus()">
							<option value="">
									全部
							</option>
								<option value="LCQ1">
									中山销售一
								</option>
								<option value="LCQ2">
									中山销售二
								</option>
								<option value="LCQG">
									广州
								</option>
								<option value="LCQD">
									东莞
								</option>
							</select>
							
					</td>
					<%}  %>
					<td>
						<input type="submit" name="Submit" value="提交">
						<%if(user.getId()!=233){
						%>
							<input type="button" onclick="receipt('0');" value="开收据">
							<input type="reset" name="Submit2" value="重置">
							<input type="button" onclick="receipt('1');" value="收款批量录入">
						<%
						} %>
						
					</td>
					
				</tr>
			</table>
		</form>
		<table width="100%" border="0" cellpadding="2" cellspacing="0"
			align="center" class=TableBorder>
			<tr height="22" valign="middle" align="center">
				<th height="25" colspan="16">
					报价清单搜索结果
				</th>
			</tr>
			<tr>
				<td><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
				<td height="25" class=forumrow>
					<div align="center">
						ID
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						报价单号
					</div>
				</td>
				<td class=forumrow width="6%">
					<div align="center">
						EMC项目号
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						客户名称
					</div>
				</td>
				<!--  <td class=forumrow>
					<div align="center">
						报价日期
					</div>
				</td>-->
				<td class=forumrow>
					<div align="center">
						报价金额(元)
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						已收金额(元)
					</div>
				</td>
				<td  class=forumrow >
					<div align="center">
						未收金额(元)
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						收款方式
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						销售代表
					</div>
				</td>
				<!-- <td class=forumrow>
					<div align="center">
						公司
					</div>
				</td>-->
				<td class=forumrow>
					<div align="center">
						收单日期
					</div>
				</td>
				<td class=forumrow width="6%">
					<div align="center">
						票据类型
					</div>
				</td>
				<td class=forumrow width="6%">
					<div align="center">
						票据编号
					</div>
				</td>
				<td class=forumrow>
					<div align="center">
						状态
					</div>
				</td>
				<td class=forumrow width="9%">
					<div align="center">
						操作
					</div>
				</td>
			</tr>

			<%
				List<Quotation> list = pm.getList();
				
				if (list != null) {
					for (int i = 0; i < list.size(); i++) {
						Quotation qt = list.get(i);
						System.out.println("封存======"+qt.getSealup());
						String sealupStr="封存";
						if(qt.getSealup() !=null && qt.getSealup() !=""){
							if(qt.getSealup().equals("y")){
							sealupStr="解封";
							}
						}
						//System.out.println(qt.getId());
						//String start1=ProjectChemImpl.getInstance().getProjectStart(flow.getSid());	
			%>

			<tr>
				<td height="25">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=qt.getPid()%>/<%=qt.getTotalprice()%>">
					</td>
				<td height="25">
					<div align="center">
						<%=i%>
					</div>
				</td>
				<td height="25">
					<div align="center">
						<a href="quotationdetail.jsp?pid=<%=qt.getPid()%>"><font
							color="red"><%=qt.getPid()%></font>
						</a>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getOldPid()==null?"":qt.getOldPid()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getClient()%>
					</div>
				</td>
				<!-- <td>
					<div align="center">
						<%=qt.getCreatetime() == null ? ""
							: new SimpleDateFormat("yyyy-MM-dd HH:mm")
									.format(qt.getCreatetime())%>
					</div>
				</td> -->
				<td>
					<div align="right">
						<%=qt.getTotalprice() == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(qt
									.getTotalprice())%>
					</div>
				</td>
				<td>
					<div align="right">
						<%
						
						float preprice = qt.getPreadvance() + qt.getSepay() + qt.getBalance();
						 %>
						<%=preprice == 0 ? "0.00"
							: new DecimalFormat("##,###,###,###.00").format(preprice)%>
					</div>
				</td>
				<td >
					<div align="right">
						<%
							float noPay =qt.getTotalprice()-preprice;
						%>
						<%=noPay == 0 ? "0.00" : new DecimalFormat("##,###,###,###.00").format(noPay)%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getAdvancetype() == null ? "" : qt
							.getAdvancetype()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=qt.getSales()%>
					</div>
				</td>
				<!--  <td>
					<div align="center">
						<%=qt.getCompany()%>
					</div>
				</td>-->
				<td>
					<div align="center">
						<%=qt.getConfirmtime() == null ? ""
							: new SimpleDateFormat("yyyy-MM-dd HH:mm")
									.format(qt.getConfirmtime())%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=(qt.getPaynotes()==null||"".equals(qt.getPaynotes()))?"":qt.getPaynotes()%>
					</div>
				</td>
				<td>
					<div align="center">
						<%=(qt.getInvcode()==null||"".equals(qt.getInvcode()))?"":qt.getInvcode()%>
					</div>
				</td>
				<td>
					<div align="center">
						<font color="red"><%=qt.getStatus()%></font>
					</div>
				</td>
				<td>
					<div align="center">
					
						<%
							if (qt.getAcount() == 0) {
						%>



						<a
							href="quotationlog.jsp?pid=<%=qt.getPid()%>/,&pageNo=<%=pm.getPageNo()%>&type=1"
							style="color: blue">登记款项</a>
						<%
							} else {
						%>
						<a href="quotationdetail.jsp?pid=<%=qt.getPid()%>&type=1"
							style="color: blue">查看</a>
						<%
							}
						%>
						
						<%if(user.getName().equals("余海珊")||user.getId()==110||user.getId()==103){
					%>
					
					<a href="quotationlog.jsp?pid=<%=qt.getPid()%>/,&pageNo=<%=pm.getPageNo()%>&type=modi"
							style="color: blue">修改</a>
					<%
					}
					else if(user.getId()!=233){%>
				<input type="button" name ="sealup" id="sealup" value="<%=sealupStr%>" onclick="sealup('<%=qt.getPid()%>','<%=qt.getSealup()%>')">
					<%
					}
					 %>
						<%--<input type="button" name ="sealup" id="sealup" value="<%=sealupStr%>" onclick="sealup('<%=qt.getPid()%>','<%=qt.getSealup()%>')">--%>
						<%
						if(qt.getSealup().equals("n")){%>
						<a href="#" onclick="sealup('<%=qt.getPid()%>','<%=qt.getSealup()%>')" style="color: green"><%=sealupStr%></a>
						<%}else{%>
						<a href="#" onclick="sealup('<%=qt.getPid()%>','<%=qt.getSealup()%>')" style="color: red"><%=sealupStr%></a>
						<%
							}
						%>
					 <!--  <a
							href="../../cashcount/editfincome.jsp?pid=<%=qt.getPid()%>"
							style="color: blue">修改入账</a>-->

					</div>
					
				</td>
			</tr>
			<%
			}
			}
			%>
			<tr style="background-color: #E0F8E0">
				<td height="25" colspan="16" align="left">
					<div align="center">
						记录总条数：<%=pm.getTotalRecords()%>
						当前页/总页数:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a
							href="quotation_manage.jsp?pageNo=1&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=fqu.getClient()%>&status=<%=fqu.getStatus()%>"
							class="red">首页</a>
						<a
							href="quotation_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=client%>&start=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&status=<%=fqu.getStatus()%>"
							class="red">上一页</a>
						<a
							href="quotation_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=client%>&start=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&status=<%=fqu.getStatus()%>"
							class="red">下一页</a>
						<a
							href="quotation_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&pid=<%=fqu.getPid()%>&price=<%=fqu.getPrice()%>&client=<%=client%>&start=<%=fqu.getStart()%>&end=<%=fqu.getEnd()%>&status=<%=fqu.getStatus()%>"
							class="red">末页</a>
					</div>
				</td>
			</tr>
		</table>