<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@ include file="../comman.jsp"  %>
<%@page import="java.util.Map"%>
<%@page import="com.lccert.crm.chemistry.util.DynamicData"%>


<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
if(command != null && "add".equals(command)) {
	String invtype = request.getParameter("invtype");
	String invhead = request.getParameter("invhead");
	String suppliername = request.getParameter("suppliername");
	int supplierid = 0;
	supplierid = ApplicationAction.getInstance().getSupplierByName(suppliername);
	if(supplierid == 0) {
		out.println("受款单位不存在，请返回录入受款单位信息！");
		out.println("<br><a href='sup_add.jsp'>返回</a>");
		return;
	}
	
	String strprepaytime1 = request.getParameter("prepaytime1");
	Date prepaytime1 = null;
	if(strprepaytime1 != null && !"".equals(strprepaytime1)) {
		prepaytime1 = new SimpleDateFormat("yyy-MM-dd").parse(strprepaytime1);
	}
	
	String strprepaytime2 = request.getParameter("prepaytime2");
	Date prepaytime2 = null;
	if(strprepaytime2 != null && !"".equals(strprepaytime2)) {
		prepaytime2 = new SimpleDateFormat("yyy-MM-dd").parse(strprepaytime2);
	}
	
	String strprepaytime3 = request.getParameter("prepaytime3");
	Date prepaytime3 = null;
	if(strprepaytime3 != null && !"".equals(strprepaytime3)) {
		prepaytime3 = new SimpleDateFormat("yyy-MM-dd").parse(strprepaytime3);
	}
	
	String constractcode1 = request.getParameter("constractcode1");
	String constractcode2 = request.getParameter("constractcode2");
	String constractcode3 = request.getParameter("constractcode3");
	String constractcontent1 = request.getParameter("constractcontent1");
	String constractcontent2 = request.getParameter("constractcontent2");
	String constractcontent3 = request.getParameter("constractcontent3");
	String strconstractprice1 = request.getParameter("constractprice1");
	float constractprice1 = 0;
	if(!("".equals(strconstractprice1) || strconstractprice1 == null)) {
		constractprice1 = Float.parseFloat(strconstractprice1);
	}
	String strconstractprice2 = request.getParameter("constractprice2");
	float constractprice2 = 0;
	if(!("".equals(strconstractprice2) || strconstractprice2 == null)) {
		constractprice2 = Float.parseFloat(strconstractprice2);
	}
	String strconstractprice3 = request.getParameter("constractprice3");
	float constractprice3 = 0;
	if(!("".equals(strconstractprice3) || strconstractprice3 == null)) {
		constractprice3 = Float.parseFloat(strconstractprice3);
	}
	String strfirstpay = request.getParameter("firstpay");
	float firstpay = 0;
	if(!("".equals(strfirstpay) || strfirstpay == null)) {
		firstpay = Float.parseFloat(strfirstpay);
	}
	String strsecondpay = request.getParameter("secondpay");
	float secondpay = 0;
	if(!("".equals(strsecondpay) || strsecondpay == null)) {
		secondpay = Float.parseFloat(strsecondpay);
	}
	String strthirdpay = request.getParameter("thirdpay");
	float thirdpay = 0;
	if(!("".equals(strthirdpay) || strthirdpay == null)) {
		thirdpay = Float.parseFloat(strthirdpay);
	}
	String paymethod = request.getParameter("paymethod");
	String paytype = request.getParameter("paytype");
	String dept = request.getParameter("dept");
	int item = 0;
	String stritem = request.getParameter("item");
	if(stritem == null || "".equals(stritem)) {
		out.println("类型不可以为空，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	item = Integer.parseInt(stritem);
	String tags = request.getParameter("tags");
	
	String app_user = user.getName();
	
	ApplicationForm af = new ApplicationForm();
	af.setInv_type(invtype);
	af.setInv_head(invhead);
	
	af.setPrepay_time1(prepaytime1);
	af.setPrepay_time2(prepaytime2);
	af.setPrepay_time3(prepaytime3);
	af.setContract_code1(constractcode1);
	af.setContract_code2(constractcode2);
	af.setContract_code3(constractcode3);
	af.setContract_content1(constractcontent1);
	af.setContract_content2(constractcontent2);
	af.setContract_content3(constractcontent3);
	af.setContract_price1(constractprice1);
	af.setContract_price2(constractprice2);
	af.setContract_price3(constractprice3);
	af.setFirst_pay(firstpay);
	af.setSecond_pay(secondpay);
	af.setThird_pay(thirdpay);
	af.setPay_method(paymethod);
	af.setPay_type(paytype);
	af.setDept(dept);
	af.setItem(item);
	af.setTags(tags);
	
	Supplier sup = new Supplier();
	sup.setId(supplierid);
	
	af.setSup(sup);
	
	af.setApp_user(app_user);
	
	if(ApplicationAction.getInstance().addApplication(af)) {
		out.println("添加成功");
		out.println("<a href='app_main.jsp'>返回</a>");
		return;
	} else {
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
}

DynamicData dydata = new DynamicData();
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加申请表</title>
		<link rel="stylesheet" href="../css/style.css">
		<script type="text/javascript" src="../javascript/suggest.js"></script>
		<script type="text/javascript" src="../javascript/jquery-1.3.2.min.js" ></script>
		<script type="text/javascript" src="../javascript/mln.colselect.js"></script>
        <link href="../css/mln-main.css" rel="stylesheet" type="text/css" charset="utf-8" />
        <!-- 调用日期样式 -->
        <script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link href="../css/mln.colselect.css" rel="stylesheet" type="text/css">

		<%@ include file="searchallsupplier.jsp"%>
		<style>
		
		
<!-- /* Font Definitions */
@font-face {
	font-family: 宋体;
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
	font-family: "\@宋体";
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
	mso-fareast-font-family: 宋体;
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
	mso-fareast-font-family: 宋体;
	mso-font-kerning: 1.0pt;
}

span.MsoCommentReference {
	mso-style-noshow: yes;
	mso-ansi-font-size: 10.5pt;
	mso-bidi-font-size: 10.5pt;
}

p.MsoCommentSubject,li.MsoCommentSubject,div.MsoCommentSubject {
	mso-style-noshow: yes;
	mso-style-parent: 批注文字;
	mso-style-next: 批注文字;
	margin: 0cm;
	margin-bottom: .0001pt;
	mso-pagination: none;
	font-size: 10.5pt;
	mso-bidi-font-size: 12.0pt;
	font-family: "Times New Roman";
	mso-fareast-font-family: 宋体;
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
	mso-fareast-font-family: 宋体;
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
window.history.back();
}
</script>
	</head>

	<body lang=ZH-CN
		style='tab-interval: 21.0pt; text-justify-trim: punctuation' onload="getData()">
		<form id="form1" name="form1" method="post"
			action="app_add.jsp?command=add" autocomplete="off">
			<div align="center">
				<font size="6">
					添加请款申请表
				</font>
			</div>
			<div align=center>

				<table width="70%" height="468" border=1 cellpadding=0 cellspacing=0
					class=MsoNormalTable
					style='width: 98.3%; border-collapse: collapse; border: none; mso-border-alt: solid windowtext .25pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .25pt solid windowtext; mso-border-insidev: .25pt solid windowtext'>
					<tr
						style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 15.5pt'>
						<td width="26" rowspan=2
							style='width: 3.36%; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .25pt; background: #CCCCCC; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								票据
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td colspan=4
							style='width: 54.42%; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><span
									lang=EN-US> <o:p></o:p> </span> </span>票据类型
							</p>
						</td>
						<td colspan=4
							style='width: 42.22%; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.5pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								抬头
							</p>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 1; height: 15.75pt'>
						<td colspan=4
							style='width: 54.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 15.75pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								<span id="invtype"
									style="font-family: 宋体; mso-bidi-font-family: &amp; amp; amp; quot; Arial Unicode MS&amp;amp; amp; quot;; color: red">
									<input name="invtype" value="发票" type="checkbox" checked
										onClick="chooseOne(this);"> 发票 <input name="invtype"
										value="收据" type="checkbox" onClick="chooseOne(this);">
									收据</span>
							</p>
							<script>   
    
     function chooseOne(cb) {   
         var obj = document.getElementById("invtype");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
             else obj.children[i].checked = true;   
         }   
     }   
 </script>
						</td>
						<td colspan=4
							style='width: 42.22%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.75pt'>
							<input name="invhead" align="center" type="text" value="中山立创"
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
					</tr>
					<tr style='mso-yfti-irow: 2; height: 15.55pt'>
						<td width="26" rowspan=5
							style='width: 3.36%; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; background: #CCCCCC;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								请款说明
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td
							style='width: 15%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								受款单位
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input id="suppliername" type="text" name="suppliername"
								size="40" onkeyup="suggest(this.value,event,this);"
								onkeydown="return tabfix(this.value,event,this);"
								onblur="clearSuggest();"
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />

							<p class="nodisplay">
								<label>
									kIndex
								</label>
								<input class="nodisplayd" type="text" id="keyIndex" />
							</p>
							<p class="nodisplay">
								<label>
									rev
								</label>
								<input class="nodisplayd" type="text" id="sortIndex" />
							</p>

							<div id="results"></div>

						</td>
						<td colspan=4
							style='width: 42.22%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.75pt'>
							&nbsp;
						</td>
					</tr>
					<tr style='mso-yfti-irow: 3; height: 15.55pt'>
						<td width="131"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								预支付日期
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td width="211"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								合同编号
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								合同标的
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td width="144"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								合同总金额
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td 
							style='width: 15%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								本次支付额
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td width="131"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								支付比例
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td width="171"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								收货情况
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 4; height: 15.55pt'>
						<td 
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt;'>
							<input name="prepaytime1" id="prepaytime1" align="center" type="text" value=""
								/>
						      	<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'prepaytime1'})" 
						      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
						</td>
						<td width="211"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 15.55pt; overflow: hidden;'>
							<input name="constractcode1" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractcontent1" align="center" type="text"
								value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="144"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractprice1" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="131"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="firstpay" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="131"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
						</td>
						<td width="171"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 5; height: 15.55pt'>
						<td width="131"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="prepaytime2" id= "prepaytime2" align="center" type="text" value=""
								/>
								
								<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'prepaytime2'})" 
						      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
						</td>
						<td width="211"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractcode2" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractcontent2" align="center" type="text"
								value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="144"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractprice2" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="131"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 15.55pt'>
							<input name="secondpay" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="131"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
						</td>
						<td width="171"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 6; height: 15.55pt'>
						<td width="131"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="prepaytime3" id ="prepaytime3"　align="center" type="text" value=""
								/>
								<img onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'prepaytime3'})" 
						      	src="../javascript/date/skin/datePicker.gif" width="16" height="22" align="middle">
						</td>
						<td width="211"
							style='width: 18.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractcode3" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td colspan=2
							style='width: 24.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<input name="constractcontent3" align="center" type="text"
								value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="144"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 15.55pt'>
							<input name="constractprice3" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="131"
							style='width: 10.82%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 15.55pt'>
							<input name="thirdpay" align="center" type="text" value=""
								style="width: 100%; height: 100%; border: 0; background: yellow; text-align: center;" />
						</td>
						<td width="131"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
						</td>
						<td width="171"
							style='width: 9.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span lang=EN-US
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'><o:p>&nbsp;</o:p>
								</span>
							</p>
						</td>
					</tr>
					<tr style='mso-yfti-irow: 7; height: 15.55pt'>
						<td width="26" rowspan=5
							style='width: 3.36%; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; background: #CCCCCC;  height: 15.55pt'>
							<p class=MsoNormal align=center style='text-align: center'>
								<span
									style='font-size: 9.0pt; font-family: 宋体; mso-bidi-font-family: "Arial Unicode MS"'>请款信息<span
									lang=EN-US><o:p></o:p> </span> </span>
							</p>
						</td>
						<td width="131"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								支付方式
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p id="paymethods" align=center class=MsoNormal
								style='text-align: center'>
								<input name="paymethod" value="款到发货" type="checkbox" checked
									onclick="payMethod(this);">
								款到发货
								<input name="paymethod" value="货到即付" type="checkbox"
									onclick="payMethod(this);">
								货到即付
								<input name="paymethod" value="通知付款" type="checkbox"
									onclick="payMethod(this);">
								通知付款
								<input name="paymethod" value="每月结数" type="checkbox"
									onclick="payMethod(this);">
								每月结数
								<span lang=EN-US><o:p></o:p> </span>
							</p>
							<script>   
    
     function payMethod(cb) {   
         var obj = document.getElementById("paymethods");   
         for (i=0; i<obj.children.length; i++){   
             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
             else obj.children[i].checked = true;   
         }   
     }   
 </script>
						</td>
						<td width="144"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p align=center class=MsoNormal style='text-align: center'>
								支付类型
								<span lang=EN-US><o:p></o:p> </span>
							</p>
						</td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 15.55pt'>
							<p id="paytypes" align=center class=MsoNormal
								style='text-align: center'>
								<input name="paytype" value="现金" type="checkbox" checked
									onclick="payType(this);">
								现金
								<input name="paytype" value="基本" type="checkbox"
									onclick="payType(this);">
								基本
								<input name="paytype" value="一般" type="checkbox"
									onclick="payType(this);">
								一般
								<input name="paytype" value="个人" type="checkbox"
									onclick="payType(this);">
								个人
								<span lang=EN-US><o:p></o:p> </span>
							</p>
							<script>   
    
     function payType(cb) {   
         var obj2 = document.getElementById("paytypes");   
         for (i=0; i<obj2.children.length; i++){   
             if (obj2.children[i]!=cb)    obj2.children[i].checked = false;   
             //else    obj.children[i].checked = cb.checked;   
             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
             else obj2.children[i].checked = true;   
         }   
     }   
 </script>
						</td>
					</tr>

					
					<tr style='mso-yfti-irow: 10; height: 19.85pt'>
						<td width="131"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'>

								<span lang=EN-US><o:p>类型</o:p> </span>
							</p>
						</td>
						<td colspan=3
							style='width: 42.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 19.85pt'>
							<div id="item"></div>
		<script type="text/javascript">
			
/*
			var json = {"Items":[
			{"name":"耗材","topid":"0","colid":"1","value":"耗材","fun":function(){}},
			{"name":"固定资产","topid":"1","colid":"2","value":"固定资产","fun":function(){}},
			{"name":"日常支出","topid":"1","colid":"3","value":"日常支出","fun":function(){}},
			{"name":"工程建设","topid":"2","colid":"4","value":"工程建设","fun":function(){}}
			]};
*/

			<%
			String item = dydata.getItem();
			%>
			var str = "<%=item%>";
			
			var ob = eval(str);
			
			$("#item").mlnColsel(ob,{
				title:"请选择",
				value:"-1",
				width:400
			});
			
		</script>
						</td>
						<td width="144"
							style='width: 10.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 19.85pt'>
							<p align=center class=MsoNormal style='text-align: center'>

								<span lang=EN-US><o:p>部门</o:p> </span>
							</p>
						</td>
						<td colspan=3
							style='width: 31.32%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt; height: 19.85pt'>
							<select name="dept"
								style="width: 100%; font-size: 13 px;">
								<%
								Map<String,String> map = dydata.getDept();
								for(String value:map.keySet()) {
								 %>
								<option value="<%=map.get(value) %>"><%=map.get(value) %></option>
								<%
								 }
								%>
							</select>
						</td>
					</tr>
					
					<tr style='mso-yfti-irow: 9; height: 19.85pt'>
						<td width="131"
							style='width: 11.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 19.85pt'>
							<p align=center class=MsoNormal
								style='text-align: center; line-height: 12.0pt; mso-line-height-rule: exactly'>

								<span lang=EN-US><o:p>备注</o:p> </span>
							</p>
						</td>
						<td colspan=7
							style='width: 84.98%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .25pt; mso-border-left-alt: solid windowtext .25pt; mso-border-alt: solid windowtext .25pt;  height: 19.85pt'>
							<textarea name="tags" rows="1" style="width: 100%;height: 100%"></textarea>
						</td>
					</tr>
				</table>

			</div>

			<p class=MsoNormal
				style='line-height: 6.0pt; mso-line-height-rule: exactly'>
				<span lang=EN-US><o:p>&nbsp;</o:p> </span>
			</p>

			</div>
			<br>
			<div align="center">
				<input name="Submit" type="submit" value="保存">
				&nbsp;&nbsp;&nbsp;
				<input name="button" type="button" value="返回" onclick="goBack();">
			</div>
		</form>
	</body>

</html>
