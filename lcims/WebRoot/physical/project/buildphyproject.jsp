<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@page import="java.util.Map"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	Quotation qt = null;
	if (sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;		
	}
	Project p = PhyProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;	
	}
	PhyProject pp = (PhyProject)p.getObj();
	qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
	//获取排单人员
	int orderId=OrderAction.getInstance().getOrderByPid(qt.getPid());
	Order order=OrderAction.getInstance().getOrderById(orderId);
	if(qt == null) {
		qt = new Quotation();
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>安规项目排单</title>
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
		window.open("../../project/showrid.jsp","","dialogWidth:800px;dialogHeight:600px");
	
	}
	
		function check(){
		var samplename =document.getElementById("samplename").value;
		var samplemodel=document.getElementById("samplemodel").value;
		var ratedvoltage=document.getElementById("ratedvoltage").value;
	//	var ratedcurrent=document.getElementById("ratedcurrent").value;
		var form1=document.getElementById("form1");
		if(samplename==""){
		alert("样品名称不能为空对象！！");
		return false ;
		}
		else if(samplemodel==""){
		alert("样品型号不能为空！！");
		return false;
		}
		else if(ratedvoltage==""){
		alert("额定电压不能为空！！");
		return false;
		}
		else{
		form1.submit();
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
					<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>电子电器管理&gt;&gt;安规项目排单</b>
				</td>
			</tr>
		</table>


		<hr width="100%" align="center" size=0>


		<form name="form1" action="buildphyproject_post.jsp" method="post">
			<input type="hidden" name="company" value="<%=qt.getCompany() %>">
			<input type="hidden" name="rid" value="<%=p.getRid()%>">
			<div class="outborder">
				<table cellpadding="5" cellspacing="0" width="95%">
					<tr>
						<td>
							报价单编号：
						</td>
						<td>
							<input name="pid" size="40" type="text"
								value="<%=p.getPid()==null?"":p.getPid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							报价单类型：
						</td>
						<td width="33%">
						<%
						String strquo = "";
						if("new".equals(qt.getQuotype())) 
							strquo = "新报价单";
						else if("add".equals(qt.getQuotype()))
							strquo = "补充重测报价单";
						else if("mod".equals(qt.getQuotype()))
							strquo = "修改报告报价单";
						 %>
							<input name="quotype" size="40" type="text"
								value="<%=strquo %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>

					</tr>
					<tr>
						<td>
							项目编号：
						</td>
						<td>
							<input name="sid" size="40" type="text" value="<%=p.getSid() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td width="17%">
							项目类型：
						</td>
						<td width="33%">
							<input name="ptype" size="40" type="text"
								value="<%=p.getPtype() %>" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>

					</tr>

					<tr>
						<td>
							客户名称：
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getClient()==null?"":qt.getClient() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
						<td>
							测试项目：
						</td>
						<td>
							<input name="client" size="40"
								value="<%=qt.getProjectcontent()==null?"":qt.getProjectcontent() %>"
								readonly="readonly" style="background-color: #F2F2F2" />
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div class="outborder">

			<%-- 
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>

						<td>
							<div id="mydiv">
								自测
								<input type="checkbox" name="type" value="自测" checked
									onClick="chooseOne(this);" />
								|&nbsp; 机构合作
								<input type="checkbox" name="type" value="机构合作"
									onClick="chooseOne(this);" />

							</div>

							<script>   
							
					     function chooseOne(cb) {   
					         var obj = document.getElementById("mydiv");   
					         for (i=0; i<obj.children.length; i++){   
					             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
					             //else    obj.children[i].checked = cb.checked;   
					             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
					             else obj.children[i].checked = true;   
					         }   
					     }   
 					</script>
						</td>
						
						<td>
							<div id="mydiv2">
								中山实验室
								<input type="checkbox" name="lab" value="中山实验室" checked
									onClick="chooseOne2(this);" />
								|&nbsp; 东莞实验室
								<input type="checkbox" name="lab" value="东莞实验室"
									onClick="chooseOne2(this);" />
							</div>
							<script>   
					     function chooseOne2(cb) {   
					         var obj = document.getElementById("mydiv2");   
					         for (i=0; i<obj.children.length; i++){   
					             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
					             //else    obj.children[i].checked = cb.checked;   
					             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
					             else obj.children[i].checked = true;   
					         }   
					     }   
 					</script>
						</td>
					</tr>
					<tr>
						<td>
							外包： 
							否
							<input type="radio" name="isout" id="isout" value="n" checked />
							是
							<input type="radio" name="isout" id="isout" value="y" />
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
		--%>
				<table cellpadding="5" cellspacing="5" width="95%">
					<tr>
						<td width="17%">
							报告类型：
						</td>
						<td width="33%">
							<select name="rptype" style="width: 300px">
								<option>
									中文报告
								</option>
								<option>
									英文报告
								</option>
								<option>
									双语报告
								</option>
								<option>
									不出报告
								</option>
								<option>
									其他
								</option>
							</select>
						</td>
						<td width="17%">
							报告应出时间：
						</td>
						<td width="33%">
							<input name="rptime" type="text" id="rptime" size="40" />
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',el:'rptime'})"
								src="../../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">

						</td>

					</tr>

					<tr>
						<td>
							项目等级：
						</td>
						<td>
							<select name="level" style="width: 300px">
								<option value="普通" selected="selected">
									0级-普通
								</option>
								<option value="加急">
									1级-加急
								</option>
								<option value="特急">
									2级-特急
								</option>
							</select>
						</td>
						<td>
							客服人员：
						</td>
						<td>
							<select name="servname" id="servname" style="width: 300px">
								<%
								Map<String,String> map = FlowFinal.getInstance().getServId();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=map.get(value) %>" <%=order.getService().getId()==Integer.parseInt(value)?"selected":"" %> ><%=map.get(value) %></option>
								<%
								 }
								%>
							</select>
						</td>
					</tr>
				</table>

				<table cellpadding="5" cellspacing="5" width="95%">

					<tr>
						<td width="17%">
							客户联系人：
						</td>
						<td width="33%">
							<select name="contact" style="width: 300px">
								<%
							ClientForm client = ClientAction.getInstance().getClientByName(qt.getClient());
							if(client != null) {
								List<ContactForm> contacts = ClientAction.getInstance().getContacts(client.getClientid());
								for(int i=0;i<contacts.size();i++) {
									ContactForm contact = contacts.get(i);
						 %>
								<option value="<%=contact.getContact() %>"><%=contact.getContact() %></option>
								<%
							 	}
							 }
						  %>

							</select>
						</td>
						<td width="17%">
							报告客户名称：
						</td>
						<td width="33%">
							<input name="rpclient" size="40" value="<%=qt.getClient() %>" />
						</td>
						

					</tr>
					
					<tr>
						<td width="17%">
							工程师：
						</td>
						<td width="33%">
							<select name="engineer" style="width: 300px">
								<%
								List<String> list = FlowFinal.getInstance().getEngineer("电子电器部");
		       					 for(int i=0;i<list.size();i++) {
		       					 	String engineer = list.get(i);
								 %>
									<option value="<%=engineer %>" <%=engineer.equals(pp.getEngineer())?"selected":"" %>>
										<%=engineer %>
									</option>
									
								<%
								}
								 %>
							</select>
						</td>
						<td width="17%">
							数据复制
						</td>
						<td width="33%">
							<input type="text" name ="copy" id ="copy" value="0">
						</td>
						

					</tr>
				</table>
				</div>
				<div class="outborder">
					<table cellpadding="5" cellspacing="5" width="95%">

						<tr>
							<td width="17%">
								样品名称：
							</td>
							<td>
								<input name="samplename" id ="samplename" type="text" size="80" value="" />
							</td>

						</tr>

						<tr>
							<td>
								样品量：
							</td>
							<td>
								<input name="samplecount" type="text" size="80" value="" />
							</td>
						</tr>
						<!--  
						<tr>
							<td>
								样品类别：
							</td>
							<td>
								<input name="samplecategory" type="text" size="80" value="" />
							</td>
						</tr>
						-->
						<tr>
							<td>
								样品型号：
							</td>
							<td>
								
								<textarea name="samplemodel" id ="samplemodel" cols="80" rows="2"></textarea>
							</td>
						</tr>
						<tr>
							<td>
								额定电压：
							</td>
							<td>
								<input name="ratedvoltage" id ="ratedvoltage" type="text" size="80" value="" />
							</td>
						</tr>
						<tr>
							<td>
								额定电流：
							</td>
							<td>
								<input name="ratedcurrent" id="ratedcurrent" type="text" size="80" value="" />
							</td>
						</tr>
						
						<tr>
							<td>
								额定功率：
							</td>
							<td>
								<input name="ratedpower" type="text" size="80" value="" />
							</td>
						</tr>
						
						<tr>
							<td>
								其他：
							</td>
							<td>
								<input name="other" type="text" size="80" value="" />
							</td>
						</tr>
						<tr>
							<td>
								光源类型：
							</td>
							<td>
								<input name="lightsourcetype" type="text" size="80" value="" />
							</td>
						</tr>
						
						
						<tr>
							<td>
								测试标准：
							</td>
							<td>
								<input name="standard" id="standard" type="text" size="80"
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
							<TD>
							<textarea name="testStandard" id="testStandard" cols="68" rows="6"></textarea>
							</TD>
						</tr>
						
					</table>
					<table cellpadding="5" cellspacing="5" width="95%">
						<tr>
							<td>
								备注：
							</td>
							<td>
								<textarea name="notes" cols="80" rows="6"></textarea>
							</td>
						</tr>
					</table>
					<p>
						&nbsp;
					</p>
				</div>


				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="添加" onclick="check();">
					&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
				<p>
					&nbsp;

				</p>
				
		</form>
	</body>
</html>
