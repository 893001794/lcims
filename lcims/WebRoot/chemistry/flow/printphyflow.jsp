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
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ContactForm"%>
<%		
		request.setCharacterEncoding("GBK");
        String fid = request.getParameter("fid");
        Flow flow = FlowAction.getInstance().getFlowByFid(fid);
        System.out.println(flow.getSid());
        Project p = ChemProjectAction.getInstance().getPhyProjectBySid(flow.getSid());
        Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
      //  System.out.println(qt.getClient()+"----");
        ClientForm cl=ClientAction.getInstance().getClientByName(qt.getClient());
       // System.out.println(cl.getContactid()+"----");
        //��ȡ�ͻ���ϵ����
       ContactForm cont = ClientAction.getInstance().getContactById(cl.getContactid());
       
       //��ȡ��������
       List list =ProjectAction.getInstance().getAllProjectByPid(p.getPid());
        
        PhyProject cp = (PhyProject)p.getObj();
        String testPlan ="";
        String type =cp.getRptype();
      if(type.equals("���ı���")){
	testPlan=flow.getTestplanC();
	
	}
	else if(type.equals("Ӣ�ı���")){
	testPlan=flow.getTestplanE();
	}
        String icode = "*" + flow.getFid().substring(3, 13) + "*";
        String str1 = "";
        String str2 = "";
        
        if("�����ת��".equals(flow.getFlowtype())) {
        	str1 = "���������Ŀ";
        	str2 = "���";
        } else if("����������ת��".equals(flow.getFlowtype())) {
        	str1 = "����������Ŀ";
        	str2 = "����";
        }else if("�Բ���ת��".equals(flow.getFlowtype())){
        str1= "�Բ���ת��";
        str2="�Բ�";
        }
%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<SCRIPT language=javascript>
var HKEY_Root,HKEY_Path,HKEY_Key; 
HKEY_Root="HKEY_CURRENT_USER"; 
HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"; 


//������ҳ��ӡ��ҳüҳ�ź�ҳ�߾�
function PageSetup_Null() { 
 try 
 { 
  var Wsh=new ActiveXObject("WScript.Shell"); 
  HKEY_Key="header"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="footer"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"&w&bҳ�룬&p/&P &b&d"); 
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
    alert("������ActiveX�ؼ�");
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
	font-family:����;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;
	mso-style-name:����;
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
	font-family:����;
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
	font-family:����;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-char-type:none;
	display:none;}
-->
</style>

</head>

<body >
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
  <td colspan=3 rowspan=3 style='width:241pt'><div align="right" class=xl33><%=icode %></div></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 style='height:9.0pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'><a name="Print_Area">��</a></td>
  <td class=xl28>��</td>
  <td class=xl27>��</td>
  <td class=xl27>��</td>
  <td class=xl27>��</td>
  <td class=xl28>��</td>
  <td class=xl27>��</td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
 
  <td>���۵����</td>
  <td class=xl25><%=flow.getPid() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  
   <td height=19 style='height:14.25pt'>������</td>
  <td class=xl25><%=flow.getRid() %></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt' width="150px">��ʵ����ʱ��</td>
  <td class=xl25 style="width: 200px"><%=flow.getPdtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(flow.getPdtime()) %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <%
   String   t1   = cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getRptime()) ;
 //  System.out.println(t1+":Ӧ�������ʱ��");
		   long   l1   =   0; 
	      

	        SimpleDateFormat   sdf   =   new   SimpleDateFormat( "yyyy-MM-dd HH:mm:ss"); 
	        
	        try   { 
	        l1   =   sdf.parse(t1).getTime(); 
	        } 
	        catch   (java.text.ParseException   pe)   { 
	                pe.printStackTrace(); 
	        } 
	        //����ǰ��ʱ��
	        String a=   t1.substring(t1.indexOf(":")-2, t1.indexOf(":"));
	         String peuthi="";
	      	if(new Integer(a)>12){
	      	   peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 240*60)*1000));
	      	}else{
	         peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 210*60)*1000));
	      	}
	       // String peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 720*60)*1000));
	        //һСʱǰ��ʱ��
	        String oneHour = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 60*60)*1000));
	    
  
   %>
  <td>Ӧ�������ʱ��</td>
  <td class=xl24 style="width: 200px"><%=peuthi%></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>��Ŀ�ȼ�</td>
  <td class=xl26><%=p.getLevel()==null?"":p.getLevel() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  
  
   <td width="250px"> Ӧ����������ʱ�� </td>
  <td class=xl24 style="width: 200px"><%=oneHour%></td>
  <td></td>
 </tr>

 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>�������� </td>
  <td class=xl26><%=cp.getRptype()==null?"":cp.getRptype() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width="200px">Ӧ������ʱ��</td>
  <td class=xl24 style="width: 200px"><%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getRptime()) %></td>
  
  <td></td>
 </tr>
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 
 
<tr height=19 style='height:14.25pt'>
  <td width="200px">����ʵ����</td>
  <td class=xl24 style="width: 200px"><%=flow.getLab()==null?"":flow.getLab()%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
    <td height=19 style='height:14.25pt'>�ͻ����</td>
  <td class=xl26><%=cl.getShortname()==null?"":cl.getShortname() %></td>
  <td></td>
 </tr>
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>��ϵ�˵绰</td>
 <td><%=cont.getTel() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td width="200px">�ͻ���ϵ��</td>
  <td class=xl24 style="width: 200px"><%=cp.getContact()==null?"":cp.getContact()%></td>
  <td></td>
 </tr>
<tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt'><%=str1 %></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=3 height=38 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:38pt;width:556pt'><%=p.getTestcontent()%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20.0pt'>
  <td height=25 class=xl29 style='height:20.0pt'>������Ʒ����</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=6 height=57 class=xl35 style='border-right:.5pt solid
   black;border-bottom:.5pt solid black;height:57.0pt;width:556pt'><%="��Ʒ���ƣ�"+cp.getSamplename()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"��Ʒ�ͺţ�"+cp.getSamplemodel()+"<br>"+"���ѹ��"+cp.getRatedvoltage()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"�������"+cp.getRatedcurrent()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"����ʣ�"+cp.getRatedpower()+"<br>"+"������"+cp.getOther()%>��</td>
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
  <tr height=25 style='mso-height-source:userset;height:20.0pt'>
  <td height=25 class=xl29 style='height:20.0pt'>���Ա�׼</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=3 height=57 class=xl35 style='border-right:.5pt solid black;border-bottom:.5pt solid black;height:57.0pt;width:556pt'><%=cp.getTestStandard()%>��</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 class=xl30 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 
  <tr height=25 style='mso-height-source:userset;height:20.0pt'>
  <td height=25 class=xl29 style='height:20.0pt'>���Է���</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=7 rowspan=3 height=38 class=xl35 style='border-right:.5pt solid black;border-bottom:.5pt solid black;height:38.0pt;width:556pt'><%=testPlan%>��</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=10 colspan=7 class=xl30 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:20pt'>
  <td height=25 class=xl29 style='height:20pt' width=250px"">��ע</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:14.25pt'>
  <td colspan=7 rowspan=3 height=57 class=xl35 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:57.75pt;width:556pt'><%=flow.getNotes()%>��</td>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 <tr height=18 style='height:14.25pt'>
 </tr>
 
 <tr height=18 style='height:14.25pt'>
  <td height=18 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>�ŵ�רԱ:</td>
  <td colspan=2 style='mso-ignore:colspan'><%=cp.getServname()%></td>
  <td width="200px">����ʱ��:</td>
  <td colspan=2 style='mso-ignore:colspan'><%=new SimpleDateFormat("yyyy-MM-dd").format(flow.getPdtime())%></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>����רԱ:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td width="200px">����ʱ��:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>�����д:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td width="100px">����ʱ��:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>�������:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>����ʱ��:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'>�����ӡ:</td>
  <td colspan=2 style='mso-ignore:colspan'>_________________</td>
  <td>����ʱ��:</td>
  <td colspan=2 style='mso-ignore:colspan'>______________</td>
  <td></td>
 </tr>
</table>
</body>

</html>

<%--
        
        if("�޻���ת��".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/wuji.xls",flow)) {
        		response.getWriter().write("�޻���ת����ӡ�ɹ�!");
        		return;
        	}
        } else if("�л���ת��".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/youji.xls",flow)) {
        		response.getWriter().write("�л���ת����ӡ�ɹ�!");
        		return;
        	}
        } else if("ʳƷ��ת��".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/shipin.xls",flow)) {
        		response.getWriter().write("ʳƷ��ת����ӡ�ɹ�!");
        		return;
        	}
        } else if("�����ת��".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/waibao.xls",flow)) {
        		response.getWriter().write("�����ת����ӡ�ɹ�!");
        		return;
        	}
        } else if("����������ת��".equals(flow.getFlowtype())) {
        	if(PrintFlowAction.getInstance().Printflow(path + "/flowreport/jigou.xls",flow)) {
        		response.getWriter().write("����������ת����ӡ�ɹ�!");
        		return;
        	}
        } else {
        	response.getWriter().write("��ӡʧ�ܣ�");
        }
        
--%>