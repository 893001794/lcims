<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.FlowTest"%>
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
<%@page import="java.util.Date"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../../comman.jsp"  %>
<%		
		request.setCharacterEncoding("GBK");
        String fid = request.getParameter("fid");
        Flow flow = FlowAction.getInstance().getFlowByFid(fid);
        Project p = ChemProjectAction.getInstance().getChemProjectBySid(flow.getSid(),"");
        ChemProject cp = (ChemProject)p.getObj();
        String icode = "*" + flow.getFid().substring(3, 13) + "*";
        String str1 = "";
        String str2 = "";
        
         if("无机流转单".equals(flow.getFlowtype())) {
        	str1 ="无机测试项目";
        	str2 = "无机";
        } else if("有机流转单".equals(flow.getFlowtype())) {
        	str1 = "有机测试项目";
        	str2 = "有机";
        } else if("食品流转单".equals(flow.getFlowtype())) {
        	str1 = "食品容器测试";
        	str2 = "食品";
        } else if("外包流转单".equals(flow.getFlowtype())) {
        	str1 = "外包测试项目";
        	str2 = "外包";
        } else if("机构合作流转单".equals(flow.getFlowtype())) {
        	str1 = "机构测试项目";
        	str2 = "机构";
        }else if("微生物流转单".equals(flow.getFlowtype())) {
        	str1 = "微生物测试项目";
        	str2 = "微生物";
        }
        
        //***-----------------东莞无机流转单采用的应急措施方案(bail-out)-----------------
        
        boolean flag =false;
        //是否采用应急措施,y表示采用应急措施，代表不采用应急措施
        String bailOut ="n";
        //获取立创的公司地域D东莞，Z中山，G广州
	 	String area=fid.substring(2, 3);
	 	//获取流转单类型(无机流转单A，有机流转单B，外包流转单D，食品流转单C，合作机构流转单)
	 	String flowType=fid.substring(fid.indexOf("-")-1, fid.indexOf("-"));
	 	//判断1、登录的帐户是否是东莞的同事，2、是否采用应急措施，3、是否为东莞地区，34、是否为无机流转单
	 	if(user.getCompanyid()== 3 && bailOut.equals("y") && area.equals("D") && flowType.equals("A")){
	 	flag=true;
	 	}
	 	//获取该流转单得所有测试项目
        List<FlowTest> flowTestList=DaoFactory.getInstance().getFlowTest().findAll(fid,"");
          //***-----------------东莞无机流转单采用的应急措施方案(bail-out)-----------------
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
  width:257pt'><div align="left">LC-WS-03<%=str2 %></div></td>
  <td width=77 style='width:58pt;font-size: 1;'>1</td>
  <td colspan=3 rowspan=3 style='width:241pt'>
  <div align="right" class=xl33>
  	<%=icode%>
  </div>
  
  </td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 style='height:9.0pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'><a name="Print_Area"></a></td>
  <td class=xl28>　</td>
  <td class=xl27>　</td>
  <td class=xl27>　</td>
  <td class=xl27>　</td>
  <td class=xl28>　</td>
  <td class=xl27>　</td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
 
  <td>报价单编号</td>
  <td class=xl25><%=flow.getPid() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  
   <td height=19 style='height:14.25pt'>报告编号</td>
  <td class=xl25>
	  <%
	  String vridStr="";
	  if(p.getFilingNo()==null||p.getFilingNo().equals("")){
		 vridStr= flow.getRid();
		  }else{
		  vridStr=p.getFilingNo();
	  	  } 
	  %>
	  <%=vridStr%>
  </td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt' width="150px">送实验室时间</td>
  <td class=xl25 style="width: 200px"><%=flow.getPdtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(flow.getPdtime()) %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <%
   String   t1   = cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getRptime()) ;
 //  System.out.println(t1+":应出报告的时间");
		   long   l1   =   0; 
	      

	        SimpleDateFormat   sdf   =   new   SimpleDateFormat( "yyyy-MM-dd HH:mm:ss"); 
	        
	        try   { 
	        l1   =   sdf.parse(t1).getTime(); 
	        } 
	        catch   (java.text.ParseException   pe)   { 
	                pe.printStackTrace(); 
	        } 
	        //半天前的时间
	        String a=   t1.substring(t1.indexOf(":")-2, t1.indexOf(":"));
	         String peuthi="";
	      	if(new Integer(a)>12){
	      	   peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 240*60)*1000));
	      	}else{
	         peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 210*60)*1000));
	      	}
	       // String peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 720*60)*1000));
	        //一小时前的时间
	        String oneHour =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 60*60)*1000));
	        
	        //获取应出报告时间
	        String rpt=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getRptime());
	        
	        
	        //***************----------------------------------------
	        //判断是否采用应急措施
	        if(flag == true){
	        //采用应急措施的方案flow.getPdtime()
	       String pdt= flow.getPdtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(flow.getPdtime());
	          long pdl=sdf.parse(pdt).getTime();
			   peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((pdl/1000+ 360*60)*1000));
			   oneHour="";
			   rpt="";
	        }
   %>
  <td>应测试完成时间</td>
  <td class=xl24 style="width: 200px"><%=peuthi%></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>项目等级</td>
  <td class=xl26><%=p.getLevel()==null?"":p.getLevel() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  
  
   <td width="250px"> 应报告审核完成时间 </td>
  <td class=xl24 style="width: 200px"><%=oneHour%></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>报告类型 </td>
  <td class=xl26><%=cp.getRptype()==null?"":cp.getRptype() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width="200px">应出报告时间</td>
  <td class=xl24 style="width: 200px"><%=rpt %></td>
  
  <td></td>
  
 </tr>
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 
  <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>防伪码</td>
  <td class=xl26><%=flow.getSecurity() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width="200px">是否退样：</td>
  <td class=xl24 style="width: 200px">
  <%
  String addsamples="否";
  if(flow.getAddsamples() !=null){
	  if(flow.getAddsamples().equals("y")){
	  addsamples="是";
	  }else {
	  addsamples="否";
	  }
  }
   %>
  	<%=addsamples %>
  </td>
  
  <td></td>
 </tr>
 
 
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=6 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>

 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt'><%=str1 %></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=6 height=113 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:80pt;width:556pt'>

 <%
  String child=flow.getDescribe();
  if(child !=null){
		String b []=child.split(";");
		for(int i=0;i<b.length;i++){
		out.print(b[i]+"<br>");
		}
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
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20.0pt'>
  <td height=25 class=xl29 style='height:20.0pt'>测试样品描述</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=4 height=112 class=xl35 style='border-right:.5pt solid black;border-bottom:.5pt solid black;
  height:74pt;width:556pt'><%=cp.getSampledesc().replaceAll("\\n","<br>") %>　</td>
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
  <td colspan=7 rowspan=5 height=10 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:88.25pt;width:556pt'><%=cp.getAppform().replaceAll("\\n","<br>") %>　</td>
 </tr>

 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
  <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt' width=250px">&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
  <tr height=16 style='height:14.25pt'>
  <td colspan=7 rowspan=8 height=10 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:114;width:556pt'> 
  <%
  	if(flowTestList !=null && flowTestList.size()>0){
  		for(FlowTest temp:flowTestList){
  			String fidTestNo = "*" + temp.getFidTestNo().substring(3, temp.getFidTestNo().length()) + "*";
  			%>
  			<div  class=xl33><%=fidTestNo%></div>
  			<%
  		}
  	}
   %>
  </td>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 <tr height=16 style='height:14.25pt'>
 </tr>
 

 <tr height=16 style='height:14.25pt'>
  <td height=16 style='height:14.25pt'>受理客服:</td>
  <td colspan=2 style='mso-ignore:colspan'><%=flow.getPduser()==null?"":flow.getPduser()%></td>
  <!--<td colspan=2 style='mso-ignore:colspan'>______<%=flow.getPduser()==null?"":flow.getPduser()%>______</td>  -->
  <td width="200px">日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'><%=new SimpleDateFormat("yyyy-MM-dd").format(flow.getPdtime())%></td>
  <td></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td height=16 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td height=16 style='height:14.25pt'>检验接收:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td width="100px">日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td height=16 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td height=16 style='height:14.25pt'>报告编写:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td height=16 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
  <tr height=16 style='height:14.25pt'>
  <td height=16 style='height:14.25pt'>报告审核:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
  </tr>
   <tr height=16 style='height:14.25pt'>
  <td height=16 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td height=16 style='height:14.25pt'>报告打印:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>日期时间:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>



</table>

</body>

</html>

<%--
        
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
        
--%>