<%@page import="com.lccert.crm.user.UserForm"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.vo.Depot"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="java.text.DecimalFormat"%>


<%		
		request.setCharacterEncoding("GBK");
			String id =request.getParameter("id");
	Depot depot=DaoFactory.getInstance().getDepotDao().searchDepot(Integer.parseInt(id));
%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<SCRIPT language=javascript>
var HKEY_Root,HKEY_Path,HKEY_Key; 
HKEY_Root="HKEY_CURRENT_USER"; 
HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"; 


//设置网页打印的页眉页脚和页边距
function PageSetup_Null() { 
 try 
 { 
  var Wsh=new ActiveXObject("WScript.Shell"); 
  HKEY_Key="header"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="footer"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"&w&b页码，&p/&P &b&d"); 
  HKEY_Key="margin_bottom"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_left"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.3"); 
 } 
 catch(e){
    alert("不允许ActiveX控件");
 } 
} 


function printit()
{
		PageSetup_Null();
		factory.execwb(6,6);
		window.close();
}

</script>
<OBJECT id=factory height=0 width=0 classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2></OBJECT>

<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}

tr
	{mso-height-source:auto;
	mso-ruby-visibility:none;}
col
	{mso-width-source:auto;
	mso-ruby-visibility:none;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;
	mso-style-name:常规;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:0px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.5pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	mso-number-format:"General Date";
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	border-top:1.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	text-align:left;
	border-top:1.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	vertical-align:top;}
.xl31
	{
	mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:right;
	white-space:normal;
	}
.xl34
	{mso-style-parent:style0;
	font-size:24.0pt;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	vertical-align:top;
	padding-top:3pt;
	padding-left:3pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	vertical-align:top;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
ruby
	{ruby-align:left;}
rt
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-char-type:none;
	display:none;}
-->

table{
     border-collapse: collapse;/* 边框合并属性  */
	 width:200px;
}
th{
     border: 1px solid #000000;
}
td{
     border: 1px solid #000000;
}

#test tr.last td{border:0px solid blue;}
</style>

</head>

<body onload='printit()'>

	
	
	
	
	
	
	
	<table style="width:510pt; " align="center" border="0">
 <tr height=8 style='mso-height-source:userset;height:6.0pt;'>
   <td colspan="6" style="border: 1px solid #ffffff" align="center">&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <font class="xl31">物品登记表</font>   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
  <font  style="text-align: right;" class="xl33"><%=depot.getDid() %></font>  
 </td>
 </tr>
	</table>
<table border=1 align='center' id="test" 
style="width:510pt; border-top-width: 1px;border-bottom-width: 1px;border-right-width: 1px;border-left-width: 1px;border-top-style: solid;border-right-style: solid;
border-left-style: solid;border-top-color: #000000;border-right-color: #000000;border-left-color: #000000;border-bottom-style: solid;border-bottom-color: #000000;">

 <tr >
  <td  style='width: 5;border: 1px solid #000000;vertical-align: middle' rowspan="4" >基本信息</td>
  <td style='height:25.0pt;width: 70pt;text-align: center;vertical-align: middle' >资产编号</td>
  <td  style='height:9.0pt;width: 90pt;vertical-align: middle'  ><%=depot.getDid() %></td>
 <td style='height:25.0pt;width: 70pt;text-align: center;vertical-align: middle' >&nbsp;&nbsp;&nbsp;&nbsp;物品名称</td>
  <td style='height:9.0pt;width: 150pt;vertical-align: middle' colspan="3" ><%=DaoFactory.getInstance().getArticleDao().getNameById(depot.getAid()) %></td>
 </tr>
 <tr>
  <td style='height:25.0pt;width: 70pt;text-align: center;vertical-align: middle' >品牌</td>
  <td  style='height:9.0pt;width: 90pt;vertical-align: middle'  ><%=depot.getBrand() %></td>
 <td style='height:25.0pt;width: 70pt;text-align: center;vertical-align: middle' >&nbsp;&nbsp;&nbsp;&nbsp;规格型号</td>
  <td style='height:9.0pt;width: 90pt;vertical-align: middle' colspan="3" ><%=depot.getSpecification() %></td>
 </tr>
 <tr >
 <td style='height:25.0pt;text-align: center;vertical-align: middle' >物品金额</td>
 <td align="left" style="vertical-align: middle"><%=new DecimalFormat("##,###,###,###").format(depot.getPrice()) %></td>
 <td style="text-align: center;vertical-align: middle">数量</td>
 <td align="left" style="vertical-align: middle"><%=depot.getNumber() %></td>
 <td style="text-align: center;vertical-align: middle">计量单位</td>
 <td align="left" style="vertical-align: middle"><%=depot.getUnitofaccount() %></td>
 </tr>
 <tr>
 <td style='height:25.0pt;text-align: center;vertical-align: middle' >供应商</td>
 <td align="left" style="vertical-align: middle" colspan="5"><%=depot.getClient() %></td>

 </tr>

 
 
 <tr height=12 >
  <td   style='width: 5;border: 1px solid #000000;vertical-align: middle' rowspan="3" >使用情况</td>
  <td style="text-align: center;height:25.0pt;vertical-align: middle">使用部门</td>
  <td align="left" style="vertical-align: middle"><%=DaoFactory.getInstance().getDeptDao().getNameById(depot.getDeptid()) %></td>
  <td style="text-align: center;height:25.0pt;vertical-align: middle">使用状态</td>
  <td  style="text-align: center;vertical-align: middle" ><%=depot.getUsestatus() %></td>
  <td   align="center" style="vertical-align: middle">使用年限</td>
  <td   align="left" style="vertical-align: middle"><%=depot.getUserdate() %></td>
 </tr>
 <tr  >
  <td style="text-align: center;height:25.0pt;vertical-align: middle">存放位置</td>
  <td   align="left" style="vertical-align: middle"><%=depot.getAperture() %></td>
  <td   style="text-align: center;vertical-align: middle">保管人</td>
    <%
   UserForm user=null;
  if(UserAction.getInstance().getUserById(depot.getKeepid()) ==null){
   user=new UserForm();
  
  }else{
   user=UserAction.getInstance().getUserById(depot.getKeepid());
  }
   %>
  <td  align="center" style="vertical-align: middle"><%=user.getName()==null?"":user.getName()%></td>
  <td   style="text-align: center;vertical-align: middle">经费来源</td>
  <td  align="left" style="vertical-align: middle"><%=depot.getFundstype() %></td>
 </tr>
 <tr   >
 <td  style="text-align: center;height:25.0pt;vertical-align: middle">校准日期</td>
  <td   colspan="2" align="left" style="vertical-align: middle" ><%=depot.getCalibration() %></td>
  <td  style="text-align: center;vertical-align: middle">复校准日期</td>
  <td   colspan="2" align="left" style="vertical-align: middle" ><%=depot.getNextcal() %></td>
 </tr>
 
  <tr >
  <td   style='width: 5;border: 1px solid #000000;vertical-align: middle' rowspan="2" >附件</td>
   <td style='height:25.0pt;vertical-align: middle'  align="center">申请表编号</td>
  <td   colspan="2" align="left" style="vertical-align: middle" ><%=depot.getApplication() %></td>
  <td   style='height:9.0pt;text-align: center;vertical-align: middle' >合同编号</td>
  <td   style='height:9.0pt;vertical-align: middle' colspan="2" align="left"><%=depot.getContract() %></td>
 </tr>
 <tr  >
  <td style='height:25.0pt;vertical-align: middle'  align="center">验收表编号</td>
  <td   style='height:9.0pt;vertical-align: middle' colspan="2" align="left" ><%=depot.getAcceptance() %></td>
  <td   style='height:9.0pt;vertical-align: middle'align="center" >发票</td>
  <td   style='height:9.0pt;vertical-align: middle' colspan="2" align="left"><%=depot.getInvoicecode() %>/<%=depot.getInvoiceno() %></td>
 </tr>

  <tr >
  <td  style='width: 5;border: 1px solid #000000;vertical-align: middle' rowspan="2" >备注</td>
  <td style='height:50.0pt;vertical-align: middle' align="center" colspan="6" rowspan="2"><%=depot.getRemarks() %></td>
 </tr>
 <tr height=12 >
  
 </tr>
<tr height=12 >
  <td style='height:9.0pt;width: 5;vertical-align: middle' rowspan="15" >各部门确认</td>
  <td  style='height:9.0pt;vertical-align: middle' rowspan="3" align="center" >仓库专员</td>
  <td style='height:40.0pt;' colspan="5" align="left" rowspan="3">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
  <font style="vertical-align:text-bottom;">签名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</font>
  </td>
 </tr>
 <tr height=12 >
 </tr>
 
 <tr  >
 
 </tr>
 
 
 
 <tr >
 
  <td style='height:9.0pt;vertical-align: middle' rowspan="3" align="center" >财务主管</td>
   <td style='height:40.0pt;' colspan="5" align="left" rowspan="3">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
  <font style="vertical-align:text-bottom;">签名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</font>
  </td>
 </tr>
 <tr height=12 >
 </tr>
 <tr  >
 
 </tr>
 
 <tr >
 
  <td  style='height:9.0pt;vertical-align: middle' rowspan="3" align="center" >采购经理</td>
  <td style='height:40.0pt;' colspan="5" align="left" rowspan="3">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
  <font style="vertical-align:text-bottom;">签名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</font>
  </td>
 </tr>
 
 <tr height=12 >
 </tr>
 
 <tr>

 </tr>
 
 
  
 <tr height=12 >
  <td style='height:9.0pt;vertical-align: middle' rowspan="3" align="center" >使用部门</td>
 <td style='height:40.0pt;' colspan="5" align="left" rowspan="3">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
  <font style="vertical-align:text-bottom;">签名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</font>
  </td>
  </tr>
 <tr height=12 >
 </tr>
 <tr  >
 
 </tr>
 
 
 <tr >
  <td  style='height:9.0pt;vertical-align: middle' rowspan="3" align="center">总经办</td>
  <td style='height:40.0pt;' colspan="5" align="left" rowspan="3">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
  <font style="vertical-align:text-bottom;">签名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</font>
  </td>
 </tr>
 <tr height=12>
 </tr>
 <tr style="border:0px solid white;">
 
 </tr>
</table>

</body>

</html>
