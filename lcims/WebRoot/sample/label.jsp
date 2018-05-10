<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.PhyProject"%>


<%
	request.setCharacterEncoding("GBK");
	String strId =request.getParameter("id");
	int id =0;
	
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
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.15"); 
 
  
 } 
 catch(e){
   // alert("不允许ActiveX控件");
 } 
} 

function printorder()
{
		PageSetup_Null();
		factory.execwb(6,6);
		factory.printing.printer = "ZDesigner LP 2844"  //设置默认打印机
		window.close();  //关闭页面
}

</script>
		<OBJECT id=factory height=0 width=0
			classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2></OBJECT>
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
	text-align: right;
	width: 80px;
	text-align: center;
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
	<table width="410" border="0" align="center" cellpadding="0">
	<%
	List list =new ArrayList();
	list.add("s.vsno");
	list.add("s.vsid");
	list.add("s.vsampleName");
	list.add("s.vmodel");
	list.add("sp.vclient");
	list.add("sp.vems");
	//System.out.println(strId);
	if(strId !=null){
			String [] ids=strId.split(";");
			for(int i =0;i<ids.length;i++){
				id=Integer.parseInt(ids[i]);
				List row=DaoFactory.getInstance().getSimpleDao().getSampleById1(list,id);
				//System.out.println(row.size());
				List columns =(List)row.get(0);
				if(i >0){
				%>
				<tr>
					<td height="0.5"></td>
				</tr>
				<%
				}
				%>
				<tr><td>
				<table width="400" border="1" align="center" cellpadding="0"
			cellspacing="0"
			style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #000000;">
			<tr>
				<td height="25" class="weizi1">客户名称</td>
				<td height="25" class="ziti3">&nbsp;<%=columns.get(4)%></td>
			</tr>
			<tr>
				<td height="25" class="weizi1">
					样品名称
				</td>
				<td height="25" class="ziti3">&nbsp;<%=columns.get(2) %></td>
				
			</tr>
			<tr>
				<td height="25" class="weizi1">
					项目编号
				</td>
				<td height="25" >
					<%=columns.get(1)==null?" ":columns.get(1)%>
				</td>
			</tr>
			<tr>
				<td height="25" class="weizi1" >
					样品编号
				</td>
				<%
                 String icode = "*"+columns.get(0)+"*";				
				 %>
				<td height="45" style="font-size: 34px; font-family: 'C39HrP24DmTt'"><font style="color: white;">8</font><%=icode%></td>
				
			</tr>
			<tr>
				<td height="25" class="weizi1">
					样品型号
				</td>
				<td height="25" class="ziti3">&nbsp;<%=columns.get(3)%></td>
			</tr>
			
			<tr>
				<td height="25" class="weizi1">
					样品状态
				</td>
				<td height="25" class="ziti3">&nbsp;■待测 □在测 □已测 □留样 □补样</td>
			</tr>
		
		</table>
		</td></tr>
				<%
		}
	}
	 %>
		</table>
	</body>
</html>
