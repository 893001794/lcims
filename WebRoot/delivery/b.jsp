<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.chemistry.util.ChangeToBig"%>
<%@page import="java.text.DecimalFormat"%>

<%
	request.setCharacterEncoding("GBK");
	String sid =request.getParameter("sid");
	String consignA =request.getParameter("consignA");
	String consigneeC=request.getParameter("consigneeC");
	String recipient=request.getParameter("recipient");
	String contactTEL =request.getParameter("contactTEL");
	String contactAdd=request.getParameter("contactAdd");
	String totalprice=request.getParameter("totalprice");
	String status=request.getParameter("status");
	status=new String (status.getBytes("ISO-8859-1"), "GBK");
		String bigTotalprice="";
	if(totalprice != null && !"".equals(totalprice)){
	bigTotalprice=ChangeToBig.changeToBig(totalprice);
	}
	DecimalFormat df = new DecimalFormat("#.00");
	double price=0.00;
	if(totalprice != null && !"".equals(totalprice)){
	 price=Double.parseDouble(totalprice);
	}
	//将1000转换成壹仟的方法的
	 
	//付款方式
	String monthly="";//月付
	String freightcollect=""; // 到付
	String payment=request.getParameter("payment");
	if(payment !=null && ! "".equals(payment)){
	if(payment.equals("到付")){
	freightcollect="√";
	}
	else if (payment.equals("月结")){
	monthly="√";
	}
	}
	consignA = new String(consignA.getBytes("ISO-8859-1"), "GBK");
	
	String client="";  //客户名称
	String samplename=""; //样品名称
	String samplenameNo=""; //样品编号
	String samplenameType="";  //样品型号

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>成品有章无标准价</title>
		<SCRIPT language=javascript>
		//注册表路径 
var HKEY_Root,HKEY_Path,HKEY_Key; 
HKEY_Root="HKEY_CURRENT_USER"; 
HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"; 

//设置页眉页脚为空 

function PageSetup_Null() 
{ 
 try 
 { 
  var Wsh=new ActiveXObject("WScript.Shell"); //WScript 必选项。提供该对象的应用程序的名称。 Shell 必选项。要创建的对象的类型或类。
  HKEY_Key="header"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="footer"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="margin_bottom"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   //wsh.regwrite是增加或修改注册表键值 后面的是用于修改打印页眉值的正确的表达是：Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0")
  HKEY_Key="margin_left"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.85"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"1.0"); 
 
  
 } 
 catch(e){
   // alert("不允许ActiveX控件");
 } 
} 

function printorder()
{
		PageSetup_Null();
		//factory.execwb(6,6);
	
		//factory.ExecWB(7,1)  ;             //打印预览 
      //  factory.ExecWB(8,1) ;              //打印页面设置 
       // factory.printing.printer = "OKi5530"//设置默认打印机
      ///  factory.printing.paperSize = "A4"
        factory.execwb(6,6);
		window.close();  //关闭页面
}

</script>
		<OBJECT id=factory height=0 width=0 classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2></OBJECT>


		<style type="text/css">
.top {
	font-family: "黑体";
	font-size: 16px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	text-transform: capitalize;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}

.topone {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: "宋体";
	font-size: 9pt;
	color: #000000;
	text-align: left;
	line-height: 16px;
}

.topline {
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #000000;
}

.weizi1 {
	font-family: "宋体";
	font-size: 14px;
	color: #000000;
	text-align: left;
}

.weizi2 {
	font-family: "宋体";
	font-size: 10px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	vertical-align: top;
	line-height: 10px;
}

.weizi3 {
	font-family: "宋体";
	font-size: 14px;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}

.weizi4 {
	font-family: "宋体";
	font-size: 12px;
	font-weight: bolder;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: top;
	line-height: 15px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}

.weizi5 {
	font-family: "宋体";
	font-size: 13px;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
	line-height: 20px;
}

.weizi6 {
	font-family: "宋体";
	font-size: 13px;
	font-weight: bolder;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: top;
	line-height: 20px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}

.weizi7 {
	font-family: "宋体";
	font-size: 10px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	vertical-align: middle;
	line-height: 10px;
}

.table {
	border-top-width: 1px;
	border-right-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-right-style: solid;
	border-left-style: solid;
	border-top-color: #000000;
	border-right-color: #000000;
	border-left-color: #000000;
}

.table_2 {
	text-align: center;
	font-size: 11px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #000000;
	border-bottom-color: #000000;
}

.table_3 {
	text-align: center;
	font-size: 10px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}

.ren {
	text-decoration: none;
	font-family: "黑体";
	font-size: 15px;
	text-align: right;
}

.zi_1 {
	font-family: "宋体";
	font-size: 14px;
	color: #000000;
}

.zi_2 {
	font-family: "宋体";
	font-size: 14px;
	font-weight: bold;
	color: #000000;
	line-height: 30px;
}

.zi_3 {
	font-family: "宋体";
	font-size: 14px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	vertical-align: middle;
}

.zi_4 {
	font-family: "宋体";
	font-size: 14px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	text-indent: 10px;
}

.ziti_1 {
	font-family: "宋体";
	font-size: 14px;
	font-weight: bold;
	color: #000000;
	line-height: 30px;
}

.ziti_2 {
	font-family: "宋体";
	font-size: 14px;
	font-weight: bold;
	color: #000000;
	line-height: 30px;
}

.ziti3 {
	font-family: "宋体";
	font-size: 14px;
	color: #000000;
	text-align: left;
}

.dibu {
	font-size: 14px;
	font-weight: bolder;
	border-bottom-color: #000000;
	border-bottom-style: solid;
	border-bottom-width: thin;
}

.STYLE3 {
	font-size: 12px;
	font-weight: bold;
}

.STYLE7 {
	font-size: 14px;
	font-weight: bold;
}

.STYLE8 {
	text-decoration: none;
	font-family: "宋体";
	font-size: 14px;
	text-align: right;
	font-weight: bold;
}

.STYLE9 {
	font-family: "黑体"
}

.end {
	font-size: 9px;
	font-weight: bold;
	font-family: "黑体";
}

.sp {
	text-indent: 2em;
}

.suojin1:first-letter {
	margin-left: -4em;
}

.suojin1 {
	width: 330px;
	padding-left: 40px;
}

.suojin2:first-letter {
	margin-left: -1em;
}

.suojin2 {
	width: 330px;
	padding-left: 40px;
}

.suojin3:first-letter {
	margin-left: -3em;
}

.suojin3 {
	width: 330px;
	padding-left: 30px;
}

.suojin4:first-letter {
	margin-left: -3em;
}

.suojin4 {
	width: 300px;
	padding-left: 30px;
}
</style>
	</head>

	<body onload="printorder();">
		<table width="680" border="0" align="left" cellpadding="0"
			cellspacing="0" height="374">
			<tr><!-- height =25 -->
				<td height="20"  colspan="4" style='text-align: left;vertical-align: middle'>&nbsp;&nbsp;</td>
				<td height="20"  width="65"  style='text-align: left;vertical-align: middle' >√</td>
				<td height="20" width="65">&nbsp;</td>
				<td height="20"  width="65">&nbsp;</td>
				<td  width="160" align="center" rowspan="2">&nbsp;&nbsp;<%=bigTotalprice %></td>
			</tr>
			<tr><!-- height =25 -->
				<td height="15"  colspan="4" style='text-align: left;vertical-align: middle'>&nbsp;&nbsp;</td>
				<td height="15"  width="65"  style='text-align: left;vertical-align: middle' >&nbsp;</td>
				<td height="15" width="65">&nbsp;</td>
				<td height="15"  width="65">&nbsp;</td>
			</tr>
			<tr>
				<td height="26" colspan="4" rowspan="2" style='text-align: center;vertical-align: middle'>
					&nbsp;&nbsp;
				</td>
				<td height="26"  width="65"><%=freightcollect %></td>
				<td height="26"  width="65">&nbsp;</td>
				<td height="26"  width="65">&nbsp;&nbsp;<%=monthly %></td>
				<td height="26"  width="160" style='text-align: center;vertical-align: middle'><%=price==0.00?"":price%></td>
				
			</tr>
			<!-- height =31 -->
			<tr>
				<td height="40"   width="65" colspan="3" align="center">&nbsp;</td>
				<td height="40" width="160" rowspan="2">&nbsp;</td>
				
			</tr>
			<tr>
			<!-- height=26 -->
				<td height="35"  colspan="2"  style='text-align:left;vertical-align: middle'>
					&nbsp;&nbsp;司徒惠燕
				</td>
				<td height="35"   colspan="2"  style='text-align: left;vertical-align: middle'>
					&nbsp;
				</td>
				<td height="35"  width="65" colspan="3">&nbsp;</td>
			</tr>
			<!-- height=40 -->
			<tr>
				<td height="50"  colspan="4" style='text-align: left;vertical-align: middle'>
					&nbsp;&nbsp;<%=consigneeC %>
				</td>
					<td height="50" class="ziti3" width="65">&nbsp;</td>
				<td height="50" class="ziti3" width="65">&nbsp;</td>
				<td height="50" class="ziti3" width="65">&nbsp;</td>
				<td height="50" class="ziti3" width="160" rowspan="2">&nbsp;</td>
			</tr>
			<!-- height=63 -->
			<tr>
				<td height="80"  colspan="4" style='text-align: left;vertical-align: middle'>
					&nbsp;&nbsp;<%=contactAdd %>
				</td>
				<td height="80" class="ziti3" width="65">&nbsp;</td>
				<td height="80" class="ziti3" width="65">&nbsp;</td>
				<td height="80" class="ziti3" width="65">&nbsp;</td>
			</tr>
			
			
			<tr>
				<td height="5" align="left" colspan="2" style='text-align:left;vertical-align: middle'>
						&nbsp;&nbsp;<%=recipient %>
				</td>
				<td height="5" align="center"  colspan="2" style='text-align: left;vertical-align: middle'>
						&nbsp;&nbsp;<%=contactTEL %>
				</td>
				<td height="5" class="ziti3" width="65">&nbsp;</td>
				<td height="5" class="ziti3" width="65">&nbsp;</td>
				<td height="5" class="ziti3" width="65">&nbsp;</td>
				<td height="5" class="ziti3" width="160" rowspan="2">&nbsp;</td>
			</tr>
			<!-- height=43 -->
			<tr>
				<td height="40"  colspan="2" >
					<%=consignA %>
				</td>
				<td height="40" class="ziti3" width="65" colspan="2">&nbsp;</td>
				<td height="40" class="ziti3" width="65" colspan="3">&nbsp;</td>
			</tr>
			<!-- height=43 -->						
			<tr>
				<td height="50" class="weizi1" colspan="2">
					
				</td>
				<td height="50" class="weizi1" >
					
				</td>
				<%
				SimpleDateFormat sdf=new SimpleDateFormat("MM/dd");
				 %>
				<td height="45" align="right"   width="65">&nbsp;</td>
				<td height="45" class="ziti3"   width="65" align="right"><%=sdf.format(new Date()) %></td>
				<td height="45" class="ziti3" width="65" colspan="2">&nbsp;</td>
				<td height="45" class="ziti3" width="160">&nbsp;</td>
			</tr>
		
		</table>
	</body>
</html>
