<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
	
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
	if(qt == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	List<Project> list = ChemProjectAction.getInstance().getChemProjectByPid(pid,"");
 %>


<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=gbk">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="内部对账单.files/filelist.xml">
<link rel=Edit-Time-Data href="内部对账单.files/editdata.mso">
<link rel=OLE-Object-Data href="内部对账单.files/oledata.mso">

<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
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
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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

<SCRIPT language=javascript>

function printit()
{
	factory.execwb(7,1);
	//window.close();
}

</script>
<OBJECT id=factory height=0 width=0 classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2></OBJECT>
</head>

<body link=blue vlink=purple onload="printit()">

<table x:str border=0 cellpadding=0 cellspacing=0 width=648 style='border-collapse:
 collapse;table-layout:fixed;width:486pt'>
 <tr height=19 style='height:14.25pt'>
  <td colspan=9 rowspan=2 height=38 class=xl26 width=648 style='height:28.5pt;
  width:486pt'>内部对账单</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl27 width=72 style='height:28.5pt;width:54pt'>报价单号</td>
  <td colspan=2 rowspan=2 class=xl27 width=144 style='width:108pt'><%=qt.getPid() %></td>
  <td rowspan=2 class=xl27 width=72 style='width:54pt'>日期</td>
  <td colspan=2 rowspan=2 class=xl27 width=144 style='width:108pt'><%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %></td>
  <td rowspan=2 class=xl27 width=72 style='width:54pt'>业务人员</td>
  <td colspan=2 rowspan=2 class=xl27 width=144 style='width:108pt'><%=qt.getSales() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl27 width=72 style='height:28.5pt;border-top:
  none;width:54pt'>客户名称</td>
  <td colspan=8 rowspan=2 class=xl27 width=576 style='width:432pt'><%=qt.getClient() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt;border-top:none'>总金额</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=qt.getTotalprice() %></td>
  <td class=xl25 style='border-top:none;border-left:none'>开票金额</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=qt.getInvcount() %></td>
  <td class=xl25 style='border-top:none;border-left:none'>标准报价</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=qt.getStandprice() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl27 width=72 style='height:28.5pt;border-top:
  none;width:54pt'>开票抬头</td>
  <td colspan=3 rowspan=2 class=xl27 width=216 style='width:162pt'><%=qt.getInvhead() %></td>
  <td rowspan=2 class=xl27 width=72 style='border-top:none;width:54pt'>开票内容</td>
  <td colspan=4 rowspan=2 class=xl27 width=288 style='width:216pt'><%=qt.getInvcontent() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl25 style='height:14.25pt;border-top:none'>收款方式</td>
  <td colspan=3 class=xl27 width=216 style='border-left:none;width:162pt'><%=qt.getAdvancetype() %></td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'>已收预付款</td>
  <td colspan=3 class=xl27 width=216 style='border-left:none;width:162pt'><%=qt.getPreadvance() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=9 height=19 class=xl28 width=648 style='height:14.25pt;
  width:486pt'>　</td>
 </tr>
 
 <!--循环开始-->
 <%
 for(int i=0;i<list.size();i++) {
 	Project p = list.get(i);
 	ChemProject cp = new ChemProject();
  %>
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl25 style='height:14.25pt;border-top:none'>报告编号</td>
  <td colspan=2 class=xl25 style='border-left:none'><%=p.getRid()==null?"":p.getRid() %></td>
  <td class=xl25 style='border-top:none;border-left:none'>项目等级</td>
  <td colspan=2 class=xl25 style='border-left:none'><%=p.getLevel()==null?"":p.getLevel() %></td>
  <td class=xl25 style='border-top:none;border-left:none'>金额</td>
  <td colspan=2 class=xl25 style='border-left:none'><%=p.getPrice()==0?"":p.getPrice() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl27 width=144 style='height:14.25pt;
  width:108pt'>内部分包费</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=p.getInsubcost()==0?"":p.getInsubcost() %></td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'>分包方</td>
  <td colspan=3 class=xl27 width=216 style='border-left:none;width:162pt'>　</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl27 width=144 style='height:14.25pt;
  width:108pt'>外部分包费A</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=p.getSubcost()==0?"":p.getSubcost() %></td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'>分包方</td>
  <td colspan=3 class=xl27 width=216 style='border-left:none;width:162pt'><%=p.getSubcostnotes()==null?"":p.getSubcostnotes() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl27 width=144 style='height:14.25pt;
  width:108pt'>外部分包费B</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=p.getSubcost2()==0?"":p.getSubcost2() %></td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'>分包方</td>
  <td colspan=3 class=xl27 width=216 style='border-left:none;width:162pt'><%=p.getSubcostnotes2()==null?"":p.getSubcostnotes2() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl27 width=144 style='height:14.25pt;
  width:108pt'>合作分包费</td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'><%=p.getPreagcost()==0?"":p.getPreagcost() %></td>
  <td colspan=2 class=xl27 width=144 style='border-left:none;width:108pt'>分包方</td>
  <td colspan=3 class=xl27 width=216 style='border-left:none;width:162pt'><%=p.getAgname()==null?"":p.getAgname() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 rowspan=2 height=38 class=xl27 width=144 style='height:28.5pt;
  width:108pt'>业绩核算基数</td>
  <td colspan=3 rowspan=2 class=xl27 width=216 style='width:162pt'><%=p.getPpreacount()==0?"":p.getPpreacount() %></td>
  <td colspan=4 rowspan=4 class=xl29 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>　</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 rowspan=2 height=38 class=xl27 width=144 style='height:28.5pt;
  width:108pt'>业绩结算基数</td>
  <td colspan=3 rowspan=2 class=xl27 width=216 style='width:162pt'><%=qt.getAcount() %></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=9 height=19 class=xl28 width=648 style='height:14.25pt;
  width:486pt'>　</td>
 </tr>
 
 
 <%
 }
  %>
 
 <!--循环结束-->
 
 <tr height=19 style='height:14.25pt'>
  <td align="center" colspan=9 height=19 class=xl28 width=648 style='height:14.25pt;
  width:486pt'>项目结算(由财务部门填写）</td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 rowspan=4 height=76 class=xl27 width=144 style='height:57.0pt;
  width:108pt'>业绩核算</td>
  <td colspan=7 rowspan=4 class=xl41 width=504 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:378pt'>项目实收金额(<span
  style='mso-spacerun:yes'><%=qt.getPreacount() + qt.getSepay() + qt.getBalance() %></span>) -
  分包合计(<span style='mso-spacerun:yes'><%=qt.getPresubcost() %>
  </span>) - 特殊招待费(<span
  style='mso-spacerun:yes'><%=qt.getSpefund() %> </span>) - 其它应扣(<span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>)
  + 其它应补(<span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>)
  =<span style='mso-spacerun:yes'>&nbsp;</span></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 rowspan=2 height=38 class=xl27 width=144 style='height:28.5pt;
  width:108pt'>业绩最终结算</td>
  <td colspan=7 rowspan=2 class=xl27 width=504 style='width:378pt'>　</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 rowspan=2 height=38 class=xl27 width=144 style='height:28.5pt;
  width:108pt'>财务人员确认</td>
  <td colspan=2 rowspan=2 class=xl27 width=144 style='width:108pt'>　</td>
  <td colspan=2 rowspan=2 class=xl27 width=144 style='width:108pt'>业务人员确认</td>
  <td colspan=3 rowspan=2 class=xl27 width=216 style='width:162pt'>　</td>
 </tr>
 
 
</table>

</body>

</html>
