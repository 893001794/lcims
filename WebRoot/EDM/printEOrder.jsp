<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@ include file="../../comman.jsp"  %>
<%		
		request.setCharacterEncoding("GBK");
       String strid = request.getParameter("id");
	if (strid == null || "".equals(strid)) {
		response.sendRedirect("myorder.jsp");
		return;
	}
	int id = Integer.parseInt(strid);
	Order order = OrderAction.getInstance().getOrderById(id);
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
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.37"); 
  HKEY_Key="margin_left"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.37"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.37"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.37"); 
 } 
 catch(e){
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
	{mso-style-parent:style0;
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
	font-size:24.0pt;
	font-family:C39HrP24DmTt;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
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
</style>

</head>

<body onload='printit()'>
<table border=0 align='center' cellpadding=0 cellspacing=0 style='border-collapse:
 collapse;table-layout:auto;width:510pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:3872;width:91pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:4384;width:103pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:2688;width:63pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2464;width:58pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:3552;width:83pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:4416;width:104pt'>
 <col width=72 style='width:54pt'>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td colspan=3 rowspan=3 height=47 class=xl31 style='height:35.25pt;
  width:257pt'><div align="left">LC-WS-03环境</div></td>
  <td width=77 style='width:58pt;font-size: 1;'>1</td>
  <td colspan=3 rowspan=3 style='width:241pt'><div align="right" class=xl33>&nbsp;</div></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 style='height:9.0pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'><a name="Print_Area">　</a></td>
  <td class=xl28>　</td>
  <td class=xl27>　</td>
  <td class=xl27>　</td>
  <td class=xl27>　</td>
  <td class=xl28>　</td>
  <td class=xl27>　</td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
 
  <td>报价单编号</td>
  <td class=xl25><%=order.getPid()%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  
   <td height=19 style='height:14.25pt'>报告编号</td>
  <td class=xl25><%=order.getPid()%></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <!-- <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt' width="150px">送实验室时间</td>
  <td class=xl25 style="width: 200px">&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>应测试完成时间</td>
  <td class=xl24 style="width: 200px">&nbsp;</td>
  <td></td>
 </tr> -->
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt' width="150px">样品方式</td>
  <%
  String strPlan="";
  if(order.getSamplePlane() !=null){
  	if(order.getSamplePlane().equals("C")){
  	strPlan="采样";
  	}
  	if(order.getSamplePlane().equals("S")){
  	strPlan="送样";
  	}
  }
   %>
  <td class=xl25 style="width: 200px"><%=strPlan %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>样品编号</td>
  <td class=xl24 style="width: 200px"><%=order.getSampleNo() %></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>项目等级</td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  
  
   <td width="250px"> 应报告审核完成时间 </td>
  <td class=xl24 style="width: 200px">&nbsp;</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>报告类型 </td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width="200px">应出报告时间</td>
  <td class=xl24 style="width: 200px">&nbsp;</td>
  
  <td></td>
  
 </tr>
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 
  <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>防伪码</td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 
  <td></td>
 </tr>
 
 
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt'>环境测试项目</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=7 height=133 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:80pt;width:556pt'>

 <%
  List<QuoItem> quoitems = order.getQuoitems();
	for(int i=0;i<quoitems.size();i++){
		QuoItem quoitem = quoitems.get(i);
		out.print(quoitem.getItem().getName()+"("+OrderAction.getInstance().getQuoItems(quoitem.getPlaneId(),"plane")+")"+"<br>");
 }
  %>

  
  　</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20.0pt'>
  <td height=25 class=xl29 style='height:20.0pt'>测试样品描述</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=8 height=152 class=xl35 style='border-right:.5pt solid black;border-bottom:.5pt solid black;height:114.0pt;width:556pt'>&nbsp;　</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 class=xl30 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt' width=250px"">申请表补充信息</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td colspan=7 rowspan=11 height=209 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:156.75pt;width:556pt'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
  <td height=18 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>排单专员:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td width="200px">日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>报告审核:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td width="100px">日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>报告编写:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>报告打印:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
</table>

</body>

</html>
