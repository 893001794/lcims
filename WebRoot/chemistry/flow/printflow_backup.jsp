<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.flow.PrintFlowAction"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%		
		//request.setCharacterEncoding("GBK");
		response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String fid = request.getParameter("fid");
        
		fid = new String(fid.getBytes("ISO8859-1"),"GBK");
        
        Flow flow = FlowAction.getInstance().getFlowByFid(fid);
        
        String path = request.getRealPath("/");
        Project p = ChemProjectAction.getInstance().getChemProjectBySid(flow.getSid(),"");
        ChemProject cp = (ChemProject)p.getObj();
%>
<%-- 
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">

<SCRIPT language=javascript>

function printit()
{
  　if (confirm('确定打印吗？')) 
      {
          //factory.execwb(6,6);
          alert("打印成功！");
      }
     // window.close();
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
	text-align:center;}
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
  width:257pt'><div align="left">LC-WS-03<%=flow.getFlowtype().substring(0,2) %></div></td>
  <td width=77 style='width:58pt'></td>
  <td colspan=3 rowspan=3 class=xl33 style='width:241pt'><div align="right">*C10019005A*</div></td>
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
  <td height=19 style='height:14.25pt'>报告编号</td>
  <td class=xl25><%=flow.getRid() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>报价单编号</td>
  <td class=xl25><%=flow.getPid() %></td>
  <td></td>
 </tr>
 <tr height=19 style='height:10pt'>
  <td height=10 colspan=7 style='height:10pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>送实验室时间</td>
  <td class=xl24><%=cp.getCreatetime() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>应出报告时间</td>
  <td class=xl24><%=cp.getRptime() %></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>项目等级</td>
  <td class=xl26><%=cp.getLevel() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td>报告类型</td>
  <td class=xl26><%=cp.getRptype() %></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=4 height=76 class=xl30 style='height:57.0pt'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt'><%=flow.getFlowtype().substring(0,2) %>测试项目</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=7 height=133 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:99.75pt;width:556pt'><%=cp.getTestcontent() %>　</td>
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
  <td colspan=7 rowspan=8 height=152 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:114.0pt;width:556pt'><%=cp.getSampledesc() %>　</td>
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
  <td height=25 class=xl29 style='height:20pt'>申请表补充信息</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=11 height=209 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:156.75pt;width:556pt'><%=cp.getAppform() %>　</td>
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
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>排单专员:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'><%=new SimpleDateFormat("yyyy-MM-dd").format(flow.getPdtime())%></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>报告审核:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
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

 <tr height=0 style='display:none'>
  <td width=121 style='width:91pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=71 style='width:54pt'></td>
 </tr>

</table>

</body>

</html>
--%>
<%
        
        if("无机流转单".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/wuji.xls",flow)) {
        		response.getWriter().write("无机流转单打印成功!");
        		return;
        	}
        } else if("有机流转单".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/youji.xls",flow)) {
        		response.getWriter().write("有机流转单打印成功!");
        		return;
        	}
        } else if("食品流转单".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/shipin.xls",flow)) {
        		response.getWriter().write("食品流转单打印成功!");
        		return;
        	}
        } else if("外包流转单".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/waibao.xls",flow)) {
        		response.getWriter().write("外包流转单打印成功!");
        		return;
        	}
        } else if("机构合作流转单".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/jigou.xls",flow)) {
        		response.getWriter().write("机构合作流转单打印成功!");
        		return;
        	}
        } else {
        	response.getWriter().write("打印失败！");
        }
        
%>