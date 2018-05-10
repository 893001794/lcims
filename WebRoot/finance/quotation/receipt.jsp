<%@page import="javax.mail.Folder"%>
<%@page import="com.lccert.crm.chemistry.util.ChangeToBig"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String recpitNo =request.getParameter("recpitNo");
List rows =DaoFactory.getInstance().getReceipt().getInfor(recpitNo);
List columns=new ArrayList();
String client;
String vcontent;
String fpreadvance;
String vreceiptpeople;
String dcreatetime;
String date ="";
String price="";
String bigTotalprice="";
String conent="";
String conent1="";
String conent2="";
if(rows.size()>0){

	columns =(List)rows.get(0);
	if(columns.get(1).toString().length()>0){
		List ConentList=new ChangeToBig().getValue(columns.get(1).toString());
		conent=ConentList.size()>0?ConentList.get(0).toString():conent;
		conent1=ConentList.size()>1?ConentList.get(1).toString():conent1;
		conent2=ConentList.size()>2?ConentList.get(2).toString():conent2;
	}
	//if(columns.get(2).toString().length()==1){
	//bigTotalprice+=bigStr.substring(0,bigStr.lastIndexOf("拾"))+"￥拾";
	//}else if(columns.get(2).toString().length()==2){
	//bigTotalprice+=bigStr.substring(0,bigStr.indexOf("佰"))+"￥佰";
//	}else if(columns.get(2).toString().length()==3){
	//System.out.println(bigStr.substring(0,bigStr.indexOf("仟"))+"￥  仟   "+"----");
	//bigTotalprice+=bigStr.substring(0,bigStr.indexOf("仟"))+"￥仟";
	//}else if(columns.get(2).toString().length()==4){
	//bigTotalprice+=bigStr.substring(0,bigStr.indexOf("万"))+"￥万";
	//}else if(columns.get(2).toString().length()==5){
	//bigTotalprice+=bigStr.substring(0,bigStr.indexOf("拾"))+"￥拾 ";
	//}else if(columns.get(2).toString().length()==6){
//	bigTotalprice+=bigStr.substring(0,bigStr.indexOf("佰"))+"￥佰";
	//}
	//保留2位小数
	price= new DecimalFormat("###########.00").format(Float.parseFloat(columns.get(2).toString()));
	//System.out.println(price);
	bigTotalprice+=ChangeToBig.changeToBig(price);
	char[] c=bigTotalprice.toCharArray(); 
	bigTotalprice="";
	
	for(int i=0;i<c.length;i++){
	//加空格
	bigTotalprice+=c[i]+"   ";
	//System.out.println(bigTotalprice[i]+"---");
	}
	//System.out.println(bigTotalprice);
	if(columns.get(4)!=null){
	date+=columns.get(4).toString().substring(0,4)+"&nbsp;年&nbsp;";
	date+=columns.get(4).toString().substring(5,7)+"&nbsp;月&nbsp;";
	date+=columns.get(4).toString().substring(8,10)+"&nbsp;日&nbsp;";
	}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'receipt.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:黑体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:楷体_GB2312;
	panose-1:2 1 6 9 3 1 1 1 1 1;}
@font-face
	{font-family:"\@黑体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@楷体_GB2312";
	panose-1:2 1 6 9 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{
	margin:0cm auto;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-link:"页眉 Char";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	layout-grid-mode:char;
	border:none;
	padding:0cm;
	font-size:9.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-link:"页脚 Char";
	margin:0cm;
	margin-bottom:.0001pt;
	layout-grid-mode:char;
	font-size:9.0pt;
	font-family:"Calibri","sans-serif";}
 /* Page Definitions */
 @page Section1
	{size:683.25pt 263.65pt;
	margin:17.0pt 36.0pt 17.0pt 36.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
.txt{ 
color:#000000; 
border-bottom:1px solid; /* 下划线效果 */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* 背景色透明 */ 
} 


</style>
<script type="text/javascript">
	//设置网页打印的页眉页脚和页边距
function PageSetup_Null() { 
 try 
 { 
  var Wsh=new ActiveXObject("WScript.Shell"); 
  HKEY_Key="header"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="footer"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="margin_bottom"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.65"); 
  HKEY_Key="margin_left"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.37"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.37"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
 } 
 catch(e){
   // alert("不允许ActiveX控件");
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
  </head>
  
  <body lang=ZH-CN style='text-justify-trim:punctuation' onload="printit()" >
<table  border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;' align="center">
 	<tr style="21.2px">
 		<td width="140" >&nbsp;</td>
 		<td width="400" align="center"><span style='font-size:22.0pt;font-family:黑体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收 款 收 据</span></td>
 		<td width="142"><span style='font-size:13.0pt;font-family:宋体'><strong>N0.<%=recpitNo%></strong></span></td>
 	</tr>
 	<tr style="10.6px">
 		<td width="140" >&nbsp;</td>
 		<td width="400" align="center">&nbsp;</td>
 		<td width="185"><span style='font-size:12.0pt;font-family:宋体'><%=date%></span></td>
 	</tr>
 </table>
<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none' width="712"  align="center">
 
 <tr style='height:25.5pt'>
  <td width=712 colspan=6 valign="bottom" style='width:534.15pt;border:solid black 1.5pt;
  border-bottom:none;padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=left style='text-align:left'><span style='font-size:
  14.0pt;font-family:楷体_GB2312'>　　 今收到<INPUT  style='font-size:14.0pt;font-family:楷体_GB2312' class=txt id=esample size=57
      name=esample value="&nbsp;&nbsp;<%=columns.get(0)%>"></span></p>
  </td>
 </tr>
 <tr style='height:25.5pt'>
  <td width=712 colspan=6 valign="bottom" style='width:534.15pt;border-top:none;
  border-left:solid black 1.5pt;border-bottom:none;border-right:solid black 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=left style='text-align:left;text-indent:8.0pt'><span
  style='font-size:14.0pt;font-family:楷体_GB2312'>交　来<INPUT style='font-size:14.0pt;font-family:楷体_GB2312' class=txt id=esample size=61
      name=esample value="&nbsp;&nbsp;<%=conent%>"></span></p>
  </td>
 </tr>
 <tr style='height:25.5pt'>
  <td width=712 colspan=6 valign="bottom" style='width:534.15pt;border-top:none;
  border-left:solid black 1.5pt;border-bottom:none;border-right:solid black 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
  style='font-size:14.0pt;font-family:楷体_GB2312'>&nbsp;</span><INPUT  style='font-size:14.0pt;font-family:楷体_GB2312' class=txt id=conent size=67 
      name=esample value="<%=conent1%>"></p>
  </td>
 </tr>
 
 <tr style='height:25.5pt'>
  <td width=712 colspan=6 valign="bottom" style='width:534.15pt;border-top:none;
  border-left:solid black 1.5pt;border-bottom:none;border-right:solid black 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
  style='font-size:14.0pt;font-family:楷体_GB2312'>&nbsp;</span><INPUT  style='font-size:14.0pt;font-family:楷体_GB2312' class=txt id=esample size=67 
      name=esample value="<%=conent2%>"></p>
  </td>
 </tr>
 <tr style='height:25.5pt'>
  <td  valign="bottom" colspan="6" style='width:770pt;border:none;border-left:solid black 1.5pt;
  border-right:solid black 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:left'><span
  style='font-size:16.0pt;font-family:楷体_GB2312'>金额<span lang=EN-US>(</span>大写<span
  lang=EN-US>)</span></span><u><span
  lang=EN-US style='font-size:14.0pt;font-family:楷体_GB2312'></span></u><u><span
  style='font-size:14.0pt;font-family:楷体_GB2312'>&nbsp;￥<%=bigTotalprice%></span></u></p>
  </td>
 </tr>
  <tr height=28>
  <td width=142 style='border:none;border-left:solid black 1.5pt;'>&nbsp;</td>
  <td width=71 style='border:none'>&nbsp;</td>
  <td width=71 style='border:none'>&nbsp;</td>
  <td width=71 style='border:none'>&nbsp;</td>
  <td width=71 style='border:none'>&nbsp;</td>
  <td width=285 style='border:none;border-right:solid black 1.5pt;'>&nbsp;</td>
 </tr>
 <tr style='height:39.7pt'>
 <td colspan=3 align="left" style='border-top:none;border-left:solid black 1.5pt;
  border-bottom:solid black 1.5pt;border-right:none;padding:0cm 5.4pt 0cm 5.4pt;
  height:39.7pt' >
  <p class=MsoNormal align="left"><span
  style='font-size:16.0pt;font-family:楷体_GB2312'>金额<span lang=EN-US>(</span>小写<span
  lang=EN-US>)</span></span><u><span
  lang=EN-US style='font-size:14.0pt;font-family:楷体_GB2312'></span></u><u><span
  style='font-size:14.0pt;font-family:楷体_GB2312'>&nbsp;￥<u><span lang=EN-US><%=price%>&nbsp;&nbsp;&nbsp;
  </span></u></span></p>
  </td>
 
  <td colspan=3  style='border-top:none;border-left: none;
  border-bottom:solid black 1.5pt;border-right:solid black 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:39.7pt'>
  <p class=MsoNormal style='text-indent:8.0pt'><span style='font-size:16.0pt;
  font-family:楷体_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;收款单位<span lang=EN-US>(</span>公章<span lang=EN-US>)</span></span></p>
  </td>
 </tr>
 <tr height=0>
  <td width=142 style='border:none'></td>
  <td width=71 style='border:none'></td>
  <td width=71 style='border:none'></td>
  <td width=71 style='border:none'></td>
  <td width=71 style='border:none'></td>
  <td width=285 style='border:none'></td>
 </tr>
</table>
<p class=MsoNormal align=left style='text-align:center'  ><span style='font-size:
12.0pt;font-family:宋体' align="center" >核准：<span lang=EN-US> &nbsp;&nbsp;&nbsp; </span>　<span
lang=EN-US>&nbsp; </span>　会计：<span lang=EN-US>&nbsp; &nbsp;&nbsp;&nbsp; </span>　<span
lang=EN-US>&nbsp; </span>　记账：<span lang=EN-US>&nbsp; &nbsp;&nbsp;&nbsp; </span>　<span
lang=EN-US>&nbsp; </span>　出纳：<span lang=EN-US>&nbsp; &nbsp;&nbsp;&nbsp; </span>　<span
lang=EN-US>&nbsp; </span>　经手人：<%=columns.get(3)%></span></p>

</div>

</body>
</html>
