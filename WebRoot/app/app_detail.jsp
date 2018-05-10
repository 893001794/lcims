<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ include file="../comman.jsp"%>

<%
request.setCharacterEncoding("GBK");
String app_id = request.getParameter("app_id");
if(app_id == null || "".equals(app_id)) {
	response.sendRedirect("app_main.jsp");
	return;
}
String app_user = user.getName();

String command = request.getParameter("command");
if(command != null && "confirm".equals(command)) {
	ApplicationForm af = new ApplicationForm();
	af.setApp_id(app_id);
	af.setAuditman(app_user);
	if(ApplicationAction.getInstance().confirmApplication(af)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='app_main.jsp?command=noaudit;';");
		out.println("</script>");
		return;
	} else {
		out.println("���ʧ�ܣ��뷵�أ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
	
}

if(command != null && "pay".equals(command)) {
	ApplicationForm af = new ApplicationForm();
	af.setApp_id(app_id);
	af.setPay_man(app_user);
	if(ApplicationAction.getInstance().payConfirm(af)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='app_main.jsp?command=nopay;';");
		out.println("</script>");
		return;
	} else {
		out.println("֧��ȷ��ʧ�ܣ��뷵�أ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
}

if(command != null && "accept".equals(command)) {
	ApplicationForm af = new ApplicationForm();
	af.setApp_id(app_id);
	
	if(ApplicationAction.getInstance().acceptConfirm(af)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='app_main.jsp?command=noaccept;';");
		out.println("</script>");
		return;
	} else {
		out.println("��Ʊδ�յ����뷵�أ�");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;
	}
}


ApplicationForm af = ApplicationAction.getInstance().getAppById(app_id);
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�������ϸ��Ϣ</title>
		<style>
<!-- /* Font Definitions */
@font-face {
	font-family: ����;
	panose-1: 2 1 6 0 3 1 1 1 1 1;
	mso-font-alt: SimSun;
	mso-font-charset: 134;
	mso-generic-font-family: auto;
	mso-font-pitch: variable;
	mso-font-signature: 3 135135232 16 0 262145 0;
}

@font-face {
	font-family: "Arial Unicode MS";
	panose-1: 2 11 6 4 2 2 2 2 2 4;
	mso-font-charset: 134;
	mso-generic-font-family: swiss;
	mso-font-pitch: variable;
	mso-font-signature: -1 -369098753 63 0 4129279 0;
}

@font-face {
	font-family: "\@����";
	panose-1: 2 1 6 0 3 1 1 1 1 1;
	mso-font-charset: 134;
	mso-generic-font-family: auto;
	mso-font-pitch: variable;
	mso-font-signature: 3 135135232 16 0 262145 0;
}

@font-face {
	font-family: "\@Arial Unicode MS";
	panose-1: 2 11 6 4 2 2 2 2 2 4;
	mso-font-charset: 134;
	mso-generic-font-family: swiss;
	mso-font-pitch: variable;
	mso-font-signature: -1 -369098753 63 0 4129279 0;
}

/* Style Definitions */
p.MsoNormal,li.MsoNormal,div.MsoNormal {
	mso-style-parent: "";
	margin: 0cm;
	margin-bottom: .0001pt;
	text-align: justify;
	text-justify: inter-ideograph;
	mso-pagination: none;
	font-size: 10.5pt;
	mso-bidi-font-size: 12.0pt;
	font-family: "Times New Roman";
	mso-fareast-font-family: ����;
	mso-font-kerning: 1.0pt;
}

p.MsoCommentText,li.MsoCommentText,div.MsoCommentText {
	mso-style-noshow: yes;
	margin: 0cm;
	margin-bottom: .0001pt;
	mso-pagination: none;
	font-size: 10.5pt;
	mso-bidi-font-size: 12.0pt;
	font-family: "Times New Roman";
	mso-fareast-font-family: ����;
	mso-font-kerning: 1.0pt;
}

span.MsoCommentReference {
	mso-style-noshow: yes;
	mso-ansi-font-size: 10.5pt;
	mso-bidi-font-size: 10.5pt;
}

p.MsoCommentSubject,li.MsoCommentSubject,div.MsoCommentSubject {
	mso-style-noshow: yes;
	mso-style-parent: ��ע����;
	mso-style-next: ��ע����;
	margin: 0cm;
	margin-bottom: .0001pt;
	mso-pagination: none;
	font-size: 10.5pt;
	mso-bidi-font-size: 12.0pt;
	font-family: "Times New Roman";
	mso-fareast-font-family: ����;
	mso-font-kerning: 1.0pt;
	font-weight: bold;
}

p.MsoAcetate,li.MsoAcetate,div.MsoAcetate {
	mso-style-noshow: yes;
	margin: 0cm;
	margin-bottom: .0001pt;
	text-align: justify;
	text-justify: inter-ideograph;
	mso-pagination: none;
	font-size: 9.0pt;
	font-family: "Times New Roman";
	mso-fareast-font-family: ����;
	mso-font-kerning: 1.0pt;
}

span.GramE {
	mso-style-name: "";
	mso-gram-e: yes;
}

/* Page Definitions */
@page {
	mso-page-border-surround-header: no;
	mso-page-border-surround-footer: no;
}

@page Section1 {
	size: 595.3pt 841.9pt;
	margin: 1.0cm 1.0cm 1.0cm 1.0cm;
	mso-header-margin: 42.55pt;
	mso-footer-margin: 49.6pt;
	mso-paper-source: 0;
	layout-grid: 15.6pt;
}

div.Section1 {
	page: Section1;
}
-->
</style>

<script type="text/javascript">
function goBack() {
window.self.location = "app_main.jsp";
}

function pay() {
var isaudit = "<%=af.getIsaudit()%>";
if(isaudit == "n") {
alert("����û��ˣ��������!");
return;
}
window.self.location = "app_detail.jsp?command=pay&app_id=<%=af.getApp_id()%>";
}

function invaccept() {
window.self.location = "app_detail.jsp?command=accept&app_id=<%=af.getApp_id()%>";
}

function printapplication() {
window.open("printapplication.jsp?app_id=<%=af.getApp_id()%>");
}

function signApp() {
	window.self.location = "signApp.jsp?app_id=<%=af.getApp_id()%>";
}
</script>

	</head>

	<body lang=ZH-CN
		style='tab-interval: 21.0pt; text-justify-trim: punctuation'>
		<form id="form1" name="form1" method="post" action="app_detail.jsp?command=confirm">
			<input type="hidden" name="app_id" value="<%=af.getApp_id() %>">
			<div align="center">
				<h1>
					����������ϸ��Ϣ
				</h1>
			</div>
			<div align=center>

				<table width="70%" height="468" border=1 cellpadding=0 cellspacing=0
					class=MsoNormalTable
					style='width: 98.3%; border-collapse: collapse; border: none; mso-border-alt: solid windowtext .25pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .25pt solid windowtext; mso-border-insidev: .25pt solid windowtext'>
					<tr
						style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 15.5pt'>
						<td width="2%" rowspan=2
							style='width: 3.36%; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .25pt; background: #CCCCCC; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
					  </td>
						<td width="15%"
							style='width: 11.18%; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						
						<td colspan=3
							style='width: 54.42%; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							<%=af.getApp_id() %>
						</td>
						<td colspan=4
							style='width: 42.22%; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							<p class=MsoNormal align=center style='text-align: center'><font color="#ff0000"> 
								̧ͷ&nbsp;&nbsp;&nbsp;&nbsp;(&nbsp;&nbsp;<%="n".equals(af.getInv_accept())?"δ��":"����" %>&nbsp;&nbsp;)</font> 
							</p>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 1; height: 15.75pt'>
						
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								Ʊ������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<%=af.getInv_type() %>
						</td>
						
						<td colspan=4
							style='width: 42.22%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.75pt'>
						<%=af.getInv_head() %>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 2; height: 15.55pt'>
						<td width="2%" rowspan=5
							style='width: 3.36%; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; background: #CCCCCC; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								���˵��
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�ܿλ</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<%=af.getSup().getName() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								<font color="#ff0000"><span style="font-family: ����; color: red;">�����</span></font><span
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"; color: red'><span
									lang=EN-US><o:p></o:p> </span>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p><%=af.getApp_user() %></o:p>
								</span>
							</p>
					  </td>
						<td width="3%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p><%=new SimpleDateFormat("yyyy/MM/dd").format(af.getApp_time()) %></o:p>
								</span>
							</p>
					  </td>
					</tr>
					<tr style='mso-yfti-irow: 3; height: 15.55pt'>
						<td width="11.68%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								Ԥ֧������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td width="21%"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								��ͬ���</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								��ͬ���</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								��ͬ�ܽ��</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								����֧����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td width="3%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								֧������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�ջ����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
					</tr>
					<tr style='mso-yfti-irow: 4; height: 15.55pt'>
						<td width="11.68%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt;'>
						<%=af.getPrepay_time1()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time1()) %>
					  </td>
						<td width="21%"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 15.55pt; overflow: hidden;'>
						<%=af.getContract_code1() %>
					  </td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_content1() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_price1() %>
					  </td>
						<td width="13%"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getFirst_pay()==0?"":af.getFirst_pay() %>
					  </td>
						<td width="3%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p><%=af.getContract_price1()==0?"":new DecimalFormat("#.00").format(af.getFirst_pay()/af.getContract_price1()*100) + "%" %></o:p>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
					  </td>
					</tr>
					<tr style='mso-yfti-irow: 5; height: 15.55pt'>
						<td width="11.68%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getPrepay_time2()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time2()) %>
					  </td>
						<td width="21%"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_code2()==null?"":af.getContract_code2() %>
					  </td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_content2() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_price2()==0?"":af.getContract_price2() %>
					  </td>
						<td width="13%"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getSecond_pay()==0?"":af.getSecond_pay() %>
					  </td>
						<td width="3%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p><%=af.getContract_price2()==0?"":new DecimalFormat("#.00").format(af.getSecond_pay()/af.getContract_price2()*100) + "%" %></o:p>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
					  </td>
					</tr>
					<tr style='mso-yfti-irow: 6; height: 15.55pt'>
						<td width="11.68%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getPrepay_time3()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPrepay_time3()) %>
					  </td>
						<td width="21%"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_code3()==null?"":af.getContract_code3() %>
					  </td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_content3() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
						<%=af.getContract_price3()==0?"":af.getContract_price3() %>
					  </td>
						<td width="13%"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<%=af.getThird_pay()==0?"":af.getThird_pay() %>
					  </td>
						<td width="3%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p><%=af.getContract_price3()==0?"":new DecimalFormat("#.00").format(af.getThird_pay()/af.getContract_price3()*100) + "%" %></o:p>
								</span>
							</p>
					  </td>
						<td width="13%"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
					  </td>
					</tr>
					<tr style='mso-yfti-irow: 7; height: 15.55pt'>
						<td width="2%" rowspan=7
							style='width: 3.36%; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; background: #CCCCCC; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span
									style='font-size: 9.0pt; font-family: ����; mso-bidi-font-family: "Arial Unicode MS"'>�����Ϣ<span
									lang=EN-US><o:p></o:p>
								</span>
								</span>
							</p>
					  </td>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								֧����ʽ</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p id="paymethods" align=center class=MsoNormal style='text-align: center'>
								<input name="paymethod" value="�����" type="checkbox" onClick="paymethod(this);">
								�����
								<input name="paymethod" value="��������" type="checkbox" onClick="payMethod(this);">
								��������
								<input name="paymethod" value="֪ͨ����" type="checkbox" onClick="payMethod(this);">
								֪ͨ����
								<input name="paymethod" value="ÿ�½���" type="checkbox" onClick="payMethod(this);">
								ÿ�½���
								<span lang=EN-US><o:p></o:p> </span>
							</p>
							<script>   
    
     function payMethod(cb) {   
         var obj = document.getElementById("paymethods");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
             else obj.children[i].checked = true;   
         }   
     }   
 </script>
 <script type="text/javascript">
								var obj1 = document.getElementById("paymethods");
								for(var i=0;i<obj1.children.length;i++) {
									if(obj1.children[i].value.charCodeAt() == "<%=af.getPay_method()%>".charCodeAt()){
										obj1.children[i].checked = true;
									}
								}
						</script>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								֧������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.55pt'>
							<p id="paytypes" align=center class=MsoNormal style='text-align: center'>
								<input name="paytype" value="�ֽ�" type="checkbox" onClick="payType(this);">
								�ֽ�
								<input name="paytype" value="����" type="checkbox" onClick="payType(this);">
								����
								<input name="paytype" value="һ��" type="checkbox" onClick="payType(this);">
								һ��
								<input name="paytype" value="����" type="checkbox" onClick="payType(this);">
								����
								<span lang=EN-US><o:p></o:p> </span>
							</p>
							<script>   
    
     function payType(cb) {   
         var obj = document.getElementById("paytypes");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
             else obj.children[i].checked = true;   
         }   
     }   
 </script>
  <script type="text/javascript">
								var obj2 = document.getElementById("paytypes");
								for(var i=0;i<obj2.children.length;i++) {
									if(obj2.children[i].value.charCodeAt() == "<%=af.getPay_type()%>".charCodeAt()){
										obj2.children[i].checked = true;
									}
								}
						</script>
						</td>
					</tr>
					
					<tr style='mso-yfti-irow: 9; height: 19.85pt'>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal
								style='text-align: center; line-height: 12.0pt; mso-line-height-rule: exactly'><font color="#ff0000"> 
								������</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=7
							style='width: 84.98%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getFirst_pay()+af.getSecond_pay()+af.getThird_pay() %>
						</td>
					</tr>

					<tr style='mso-yfti-irow: 9; height: 19.85pt'>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal
								style='text-align: center; line-height: 12.0pt; mso-line-height-rule: exactly'><font color="#ff0000"> 
								�����е�ַ</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=7
							style='width: 84.98%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getSup().getBank() %>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 10; height: 19.85pt'>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�˻�����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getSup().getCreditname() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�����˻�</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getSup().getCreditcard() %>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 10; height: 19.85pt'>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								�����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getAuditman()==null?"":af.getAuditman() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								���ʱ��</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getAudit_time()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getAudit_time()) %>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 10; height: 19.85pt'>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								֧����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getPay_man()==null?"":af.getPay_man() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								֧��ʱ��</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getPay_time()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(af.getPay_time()) %>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 10; height: 19.85pt'>
						<td width="15%"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=af.getDept()==null?"":af.getDept() %>
						</td>
						<td width="22%"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'><font color="#ff0000"> 
								����</font> 
								<span lang=EN-US><o:p></o:p>
								</span>
							</p>
					  </td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt'>
							<%=ApplicationAction.getInstance().getItemById(af.getItem()) %>
						</td>
					</tr>
				</table>

			</div>

			<p class=MsoNormal
				style='line-height: 6.0pt; mso-line-height-rule: exactly'>
				<span lang=EN-US><o:p>&nbsp;</o:p>
				</span>
			</p>

			</div>
			
			<div align="center">
			 <input name="print" type="button" value="��ӡ" onClick="printapplication();">
				&nbsp;&nbsp;&nbsp;
				<input name="button" type="button" value="����" onClick="goBack();">
			</div>
		</form>
	</body>

</html>
