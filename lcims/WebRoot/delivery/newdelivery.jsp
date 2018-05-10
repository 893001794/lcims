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
<%@page import="java.math.BigDecimal"%>
<%@page import="com.lccert.crm.user.UserForm"%>

<%
	request.setCharacterEncoding("GBK");
	String sid =request.getParameter("sid");
	String consignA =request.getParameter("consignA");
	String consigneeC=request.getParameter("consigneeC");
	String recipient=request.getParameter("recipient");
	String contactTEL =request.getParameter("contactTEL");
	String contactAdd=request.getParameter("contactAdd");
	String totalprice=request.getParameter("totalprice");
	String userName =request.getParameter("username");
	String status=request.getParameter("status");
	status=new String (status.getBytes("ISO-8859-1"), "GBK");
		String bigTotalprice="";
	if(totalprice != null && !"".equals(totalprice)){
	bigTotalprice=ChangeToBig.changeToBig(totalprice);
	bigTotalprice=bigTotalprice.substring(0,bigTotalprice.length()-4);
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
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.5"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.72"); 
 
  
 } 
 catch(e){
   // alert("不允许ActiveX控件");
 } 
} 

function printorder()
{
		PageSetup_Null();
		factory.execwb(6,6);
	
		//factory.ExecWB(7,1)  ;             //打印预览 
      //  factory.ExecWB(8,1) ;              //打印页面设置 
       // factory.printing.printer = "OKi5530" //设置默认打印机
       
     
    
		//window.close();  //关闭页面
		window.opener=null;
       window.open('','_self');
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
		<table width="750" border="0" align="left" cellpadding="0"
			cellspacing="0" height="415">
			<tr height="48.7">
				<td width="161" style="vertical-align: bottom;">&nbsp;&nbsp;&nbsp;&nbsp; <%=userName%></td>
				<td  colspan="2" style="vertical-align: bottom">&nbsp;&nbsp;&nbsp;&nbsp;0760-22833366</td>
				<td colspan="3"></td>
				<td width="145" style="padding-bottom:10px">小榄</td>
			</tr>
			<tr height="33.3">
				<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;立创检测</td>
				<td width="58.8" style="vertical-align: bottom;"><%=freightcollect%></td>
				<td width="55.8" style="vertical-align: bottom;"></td>
				<td width="65.8" style="vertical-align: bottom;"><%=monthly%></td>
				<td width="145" style="vertical-align: bottom;padding-right:50px;" align="left">&nbsp;&nbsp;<%=bigTotalprice%></td>
				
			</tr>
			<tr height="20.6"  >
				<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;广东省中山市小榄镇广源路段</td>
				<td  colspan="3"></td>
				<td width="145"></td>
			</tr>
			<tr height="20.6">
				<td width="161" style="vertical-align: bottom;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=recipient%></td>
				<td  colspan="2" style="vertical-align: bottom;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=contactTEL%></td>
				<td colspan="3"></td>
				<td width="145">&nbsp;&nbsp;&nbsp;&nbsp;<%=price==0.00?"":price%></td>
			</tr>
			<tr height="30.4">
				<td  colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=consigneeC%></td>
				<td colspan="3"></td>
				<td width="145"></td>
			</tr>
			<tr height="40"><!--height="29.6"  -->
				<td colspan="3" style="vertical-align: bottom;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=contactAdd%></td>
				<td colspan="3"></td>
				<td width="145" style="vertical-align: bottom;" align="left"></td>
			</tr>
			<tr height="3"><!--height="33.3"  -->
				<td colspan="3"></td>
				<td colspan="3"></td>
				<td  width="145" style="vertical-align: bottom;" align="left"></td>
			</tr>
			
			
			
			<tr height="59">
				<td width="161">&nbsp;<%=consignA%></td>
				<td width="166"></td>
				<td width="126"></td>
				<td colspan="3"></td>
				<td width="145"></td>
			</tr>
			<tr height="59">
				<td width="161" align="right"></td>
				<td width="166"></td>
				<td width="126"></td>
				<td colspan="3"></td>
				<td width="145"></td>
			</tr>
			<tr height="20">
				<%
				SimpleDateFormat sdf=new SimpleDateFormat("dd/MM");
				 %>
				<td width="161" style="vertical-align: top;" align="right"><font size="2"><%=sdf.format(new Date())%>&nbsp;&nbsp;</font></td>
				<td width="166"></td>
				<td width="126"></td>
				<td colspan="3"></td>
				<td width="145"></td>
			</tr>
			<tr height="39">
				<td width="161" align="right"></td>
				<td width="166"></td>
				<td width="126"></td>
				<td colspan="3"></td>
				<td width="145"></td>
			</tr>
		</table>
	</body>
</html>
