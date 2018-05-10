<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.kis.MoneyUtil"%>
<%@ include file="../comman.jsp"%>

<%
request.setCharacterEncoding("GBK");
String app_id = request.getParameter("app_id");
if(app_id == null || "".equals(app_id)) {
	response.sendRedirect("app_main.jsp");
	return;
}
ApplicationForm af = ApplicationAction.getInstance().getAppById(app_id);
 %>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=gbk">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List href="application.files/filelist.xml">
<link rel=Edit-Time-Data href="application.files/editdata.mso">
<title>LCTECH                                            HR-HK-001</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>系统管理员</o:Author>
  <o:LastAuthor>微软用户</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>627</o:TotalTime>
  <o:LastPrinted>2009-09-18T05:28:00Z</o:LastPrinted>
  <o:Created>2010-01-25T08:35:00Z</o:Created>
  <o:LastSaved>2010-01-25T08:35:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>141</o:Words>
  <o:Characters>804</o:Characters>
  <o:Company>LC</o:Company>
  <o:Lines>6</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>944</o:CharactersWithSpaces>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:PunctuationKerning/>
  <w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:SpaceForUL/>
   <w:BalanceSingleByteDoubleByteWidth/>
   <w:DoNotLeaveBackslashAlone/>
   <w:ULTrailSpace/>
   <w:DoNotExpandShiftReturn/>
   <w:AdjustLineHeightInTable/>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" LatentStyleCount="156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:SimSun;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:"Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;
	mso-font-charset:134;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1 -369098753 63 0 4129279 0;}
@font-face
	{font-family:"\@Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;
	mso-font-charset:134;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1 -369098753 63 0 4129279 0;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;}
p.MsoCommentText, li.MsoCommentText, div.MsoCommentText
	{mso-style-noshow:yes;
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;}
span.MsoCommentReference
	{mso-style-noshow:yes;
	mso-ansi-font-size:10.5pt;
	mso-bidi-font-size:10.5pt;}
p.MsoCommentSubject, li.MsoCommentSubject, div.MsoCommentSubject
	{mso-style-noshow:yes;
	mso-style-parent:批注文字;
	mso-style-next:批注文字;
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;
	font-weight:bold;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:none;
	font-size:9.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:宋体;
	mso-font-kerning:1.0pt;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
 /* Page Definitions */
 @page
	{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:1.0cm 1.0cm 1.0cm 1.0cm;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:普通表格;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
table.MsoTableGrid
	{mso-style-name:网格型;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	border:solid windowtext 1.0pt;
	mso-border-alt:solid windowtext .5pt;
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-border-insideh:.5pt solid windowtext;
	mso-border-insidev:.5pt solid windowtext;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:none;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=ZH-CN style='tab-interval:21.0pt;text-justify-trim:punctuation'>

<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal style='line-height:28.0pt;mso-line-height-rule:exactly;
layout-grid-mode:char;mso-layout-grid-align:none'><b style='mso-bidi-font-weight:
normal'><span lang=EN-US style='font-size:18.0pt;font-family:"Arial Unicode MS"'>LCTECH</span></b><span
lang=EN-US style='font-size:18.0pt'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><b
style='mso-bidi-font-weight:normal'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;</span></b><span
style='mso-spacerun:yes'>&nbsp;</span></span><span lang=EN-US style='font-size:
12.0pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>　AD-R-042<o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span lang=EN-US style='font-size:18.0pt'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><b style='mso-bidi-font-weight:normal'><span
style='font-size:15.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman"'>　　　　　　请</span></b><b style='mso-bidi-font-weight:
normal'><span style='font-size:15.0pt'> </span></b><b style='mso-bidi-font-weight:
normal'><span style='font-size:15.0pt;font-family:宋体;mso-ascii-font-family:
"Times New Roman";mso-hansi-font-family:"Times New Roman"'>款</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt'> </span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;font-family:
宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>申</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt'> </span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;font-family:
宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>请</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt'> </span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;font-family:
宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>表（非</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt'> </span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;font-family:
宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>业</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt'> </span></b><span
class=GramE><b style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;
font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>务</span></b></span><b style='mso-bidi-font-weight:normal'><span
style='font-size:15.0pt'> </span></b><b style='mso-bidi-font-weight:normal'><span
style='font-size:15.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman"'>类）</span></b><b style='mso-bidi-font-weight:
normal'><span lang=EN-US style='font-size:18.0pt'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><span lang=EN-US style='font-size:10.0pt;font-family:"Arial Unicode MS"'>
　　　　　
No.<%=af.getApp_id() %>
</span><b style='mso-bidi-font-weight:normal'><span lang=EN-US
style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></b></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width="98%"
 style='width:98.3%;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .25pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .25pt solid windowtext;mso-border-insidev:.25pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:15.5pt'>
  <td width="3%" rowspan=2 style='width:3.36%;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .25pt;background:#CCCCCC;padding:0cm 5.4pt 0cm 5.4pt;
  height:15.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="54%" colspan=4 style='width:54.42%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>□
  报价单<span lang=EN-US>.</span>订购单 □ 口头报价 □ 网上报价 <span lang=EN-US>- </span>采购<span
  lang=EN-US> (<span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>) <o:p></o:p></span></span></p>
  </td>
  <td width="42%" colspan=4 style='width:42.22%;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>□
  入库单<span lang=EN-US> - </span>验收<span lang=EN-US> (<span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>) </span>保管<span lang=EN-US> (<span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>)<o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:15.75pt'>
  <td width="54%" colspan=4 style='width:54.42%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>□
  全额支付 □ 预付款 □ 进度款 □ 尾款 □ 垫付<span lang=EN-US> (<span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span>)<o:p></o:p></span></span></p>
  </td>
  <td width="42%" colspan=4 style='width:42.22%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>
 <%="发票".equals(af.getInv_type())?"■ 发票 □ 收据":"□ 发票 ■ 收据" %>
  <span lang=EN-US>–&nbsp;</span>抬头<span lang=EN-US> (<span
  style='mso-spacerun:yes'>&nbsp;<%=af.getInv_head() %>&nbsp;</span>)
  </span><%="y".equals(af.getInv_accept())?"■":"□" %> 已收<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:15.55pt'>
  <td width="3%" rowspan=5 style='width:3.36%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;background:#CCCCCC;padding:0cm 5.4pt 0cm 5.4pt;
  height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>请款说明<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>受款单位<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="42%" colspan=3 style='width:42.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getSup().getName() %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>请款人<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="10%" style='width:10.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getApp_user() %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>请款日期<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="9%" style='width:9.6%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=new SimpleDateFormat("yy/MM/dd").format(af.getApp_time()) %></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:15.55pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>预支付日期<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" style='width:18.0%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>合同编号<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="24%" colspan=2 style='width:24.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>合同标的<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>合同总金额<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="10%" style='width:10.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>本次支付额<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>支付比例<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="9%" style='width:9.6%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>收货情况<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:15.55pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getPrepay_time1()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time1()) %></o:p></span></p>
  </td>
  <td width="18%" style='width:18.0%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_code1() %></o:p></span></p>
  </td>
  <td width="24%" colspan=2 style='width:24.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_content1()==null?"":af.getContract_content1() %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_price1()==0?"":new DecimalFormat("#.00").format(af.getContract_price1()) %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getFirst_pay()==0?"":new DecimalFormat("#.00").format(af.getFirst_pay()) %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=new DecimalFormat("#.00").format(af.getFirst_pay()/af.getContract_price1()*100) %><%=af.getContract_price1()==0?"":"%" %></o:p></span></p>
  </td>
  <td width="9%" style='width:9.6%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:15.55pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getPrepay_time2()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time2()) %></o:p></span></p>
  </td>
  <td width="18%" style='width:18.0%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_code2()==null?"":af.getContract_code2() %></o:p></span></p>
  </td>
  <td width="24%" colspan=2 style='width:24.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_content2()==null?"":af.getContract_content2() %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_price2()==0?"":new DecimalFormat("#.00").format(af.getContract_price2()) %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getSecond_pay()==0?"":new DecimalFormat("#.00").format(af.getSecond_pay()) %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_price2()==0?"":new DecimalFormat("#.00").format(af.getSecond_pay()/af.getContract_price2()*100) + "%" %></o:p></span></p>
  </td>
  <td width="9%" style='width:9.6%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:15.55pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getPrepay_time3()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time3()) %></o:p></span></p>
  </td>
  <td width="18%" style='width:18.0%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_code3()==null?"":af.getContract_code3() %></o:p></span></p>
  </td>
  <td width="24%" colspan=2 style='width:24.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_content3()==null?"":af.getContract_content3() %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_price3()==0?"":new DecimalFormat("#.00").format(af.getContract_price3()) %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getThird_pay()==0?"":new DecimalFormat("#.00").format(af.getThird_pay()) %></o:p></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getContract_price3()==0?"":new DecimalFormat("#.00").format(af.getThird_pay()/af.getContract_price3()*100) + "%" %></o:p></span></p>
  </td>
  <td width="9%" style='width:9.6%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:15.55pt'>
  <td width="3%" rowspan=5 style='width:3.36%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;background:#CCCCCC;padding:0cm 5.4pt 0cm 5.4pt;
  height:15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>请款信息<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>支付方式<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="42%" colspan=3 style='width:42.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><%="款到发货".equals(af.getPay_method())?"■":"□" %>
  款到发货 <%="货到即付".equals(af.getPay_method())?"■":"□" %> 货到即付 <%="通知付款".equals(af.getPay_method())?"■":"□" %> 通知付款 <%="每月结数".equals(af.getPay_method())?"■":"□" %> 每月结数<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>支付类型<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="31%" colspan=3 style='width:31.32%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  15.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><%="现金".equals(af.getPay_type())?"■":"□" %>
  现金 <%="基本".equals(af.getPay_type())?"■":"□" %> 基本 <%="一般".equals(af.getPay_type())?"■":"□" %> 一般 <%="个人".equals(af.getPay_type())?"■":"□" %> 个人<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8;height:24.0pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  24.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>申请金额<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" style='width:18.0%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  24.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:12.0pt;
  font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=new DecimalFormat("#.00").format(af.getFirst_pay()+af.getSecond_pay()+af.getThird_pay()) %></o:p></span></b></p>
  </td>
  <td width="10%" style='width:10.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  24.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>金额大写<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="56%" colspan=5 style='width:56.0%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  24.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:12.0pt;
  font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>
  <%String str = af.getFirst_pay()+af.getSecond_pay()+af.getThird_pay() + ""; %>
  <%=MoneyUtil.toChinese(str) + "整" %></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9;height:19.85pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  19.85pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:12.0pt;
  mso-line-height-rule:exactly'><span style='font-size:9.0pt;font-family:宋体;
  mso-bidi-font-family:"Arial Unicode MS"'>开户行地址<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  19.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getSup().getBank() %></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10;height:19.85pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  19.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>账户名称<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="42%" colspan=3 style='width:42.74%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  19.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getSup().getCreditname() %></o:p></span></b></p>
  </td>
  <td width="10%" style='width:10.9%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  19.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>银行账户<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="31%" colspan=3 style='width:31.32%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  19.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p><%=af.getSup().getCreditcard() %></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>情况说明<b
  style='mso-bidi-font-weight:normal'><span lang=EN-US><o:p></o:p></span></b></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:9.0pt;
  font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:9.0pt;
  font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>签名：
  <span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>日<b
  style='mso-bidi-font-weight:normal'><span lang=EN-US><o:p></o:p></span></b></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;height:21.25pt'>
  <td width="3%" rowspan=4 style='width:3.36%;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .25pt;mso-border-alt:
  solid windowtext .25pt;background:#CCCCCC;padding:0cm 5.4pt 0cm 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>审批意见<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>部门意见<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:
  "Arial Unicode MS"'>签名：<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>年<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>月<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13;height:21.25pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>主管意见<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:
  "Arial Unicode MS"'>签名：<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>年<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>月<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:14;height:21.25pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>财务意见<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>签名：<span
  lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>年<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>月<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:15;height:21.25pt'>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>财务备注<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:16;mso-yfti-lastrow:yes;height:21.25pt'>
  <td width="3%" style='width:3.36%;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .25pt;mso-border-alt:solid windowtext .25pt;
  mso-border-bottom-alt:solid windowtext .5pt;background:#CCCCCC;padding:0cm 5.4pt 0cm 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" style='width:11.68%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:"Arial Unicode MS"'>支付情况<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="84%" colspan=7 style='width:84.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .25pt;
  mso-border-alt:solid windowtext .25pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  21.25pt'>
  <p class=MsoNormal><span style='font-size:9.0pt;font-family:宋体;mso-bidi-font-family:
  "Arial Unicode MS"'>已于<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日经<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>支付款项
  出纳：<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>日期：<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>审核：<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>日期：<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><o:p></o:p></span></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=26 style='border:none'></td>
  <td width=85 style='border:none'></td>
  <td width=132 style='border:none'></td>
  <td width=80 style='border:none'></td>
  <td width=101 style='border:none'></td>
  <td width=80 style='border:none'></td>
  <td width=79 style='border:none'></td>
  <td width=80 style='border:none'></td>
  <td width=70 style='border:none'></td>
 </tr>
 <![endif]>
</table>

</div>

<p class=MsoNormal style='line-height:6.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>
