<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.lab.LabAction"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="javax.mail.Folder"%>
<%
request.setCharacterEncoding("GBK");
String command = request.getParameter("command");
String group =request.getParameter("group");
String month=request.getParameter("month");
String  dept = request.getParameter("area");
//���
String year =request.getParameter("year");
if(year ==null ){
SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
year=sdf.format(new Date());
}

if(month ==null){
SimpleDateFormat sdf =new SimpleDateFormat("MM");
month=sdf.format(new Date());
}
if(dept == null){
dept ="2";
}


float[] f;
List list = new ArrayList();
UserForm user = (UserForm)session.getAttribute("user");
	boolean flag =user.getTicketid().matches("00010101");
    if(flag == true){
		//f=FinanceQuotationAction.getInstance().getFinanceProject2(year,month,command,list,"",dept,quostart,quoend,acceptstart,acceptend,paytimestart,paytimeend);
		f = FinanceQuotationAction.getInstance().getFinanceProject2(command,year,month,dept,group,list);
}else{
		f = FinanceQuotationAction.getInstance().getFinanceProject2(command,year,month,dept,group,list);
		//f = FinanceQuotationAction.getInstance().getFinanceProject2(year,month,command,list,"",dept,quostart,quoend,acceptstart,acceptend,paytimestart,paytimeend);

}
session.setAttribute("financequotation2",list);
session.setAttribute("total",f);
 %>
 
<html>
<head>
<title>����ӵ���Ŀ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../javascript/date/WdatePicker.js"></script>
<script language="javascript">
<!--
function showquotationlog(pid) {
	window.open("quotationlog.jsp?pid=" + pid);
}

function exportToExcel() {
	if(confirm("ȷ������?")) {
		window.self.location = "../../financequotation2";
	}
}



function DelOrder(r_info_id) {
		document.TheForm.action = "DealWithCenter.jsp?action=delorder&r_info_id=" + r_info_id;
		document.TheForm.submit();
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}



function searchsales(){
   var myform =document.getElementById("search");
	myform.action ="finance2.jsp";
	myform.submit();
	}
	
	var req;
    function Change_Select(obj){//����һ���������ѡ����ı�ʱ���øú���
     if(obj=="1"){
        var year =document.getElementById("year").value;
        var month =document.getElementById("month").value;
    	window.location.href="finance.jsp?year="+year+"&month="+month+"&area="+obj;
    }
      var companyid =1;
      var url = "group_sales.jsp?dept=" + encodeURI(encodeURI(obj)) + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("POST",url,true);
         //ָ���ص�����Ϊcallback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //�ص�����
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//����XML�ĵ�
        }else{
         // alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    //��������xml�ķ���
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
      var xSel = xmlDoc.getElementsByTagName('select');
      //���XML�ĵ��е�����<select>���
      var select_root = document.getElementById('group');
      //�����ҳ�еĵڶ���������
      select_root.options.length=0;
      select_root.add(new Option("ȫ��", ""));
      //ÿ�λ���µ����ݵ�ʱ���Ȱ�ÿ����������ܵĳ�����0
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //���ÿ��<select>����еĵ�һ����ǵ�ֵ,Ҳ����<value>��ǵ�ֵ
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //���ÿ��<select>����еĵڶ�����ǵ�ֵ,Ҳ����<text>��ǵ�ֵ
        var option = new Option(xText, xValue);
        //����ÿ��value��text��ǵ�ֵ����һ��option����
        
        try{
        	//alert(option);
        	
          select_root.add(option);//��option������ӵ��ڶ�����������
        }catch(e){
        }
        }
      	var ops = document.getElementById("group").options;
		for(var i=0;i<ops.length;i++) {
			if(ops[i].value.charCodeAt() == "<%=group%>".charCodeAt()){
				ops[i].selected = true;	
			}
		}
     
	
    }    
    
    function exportEMC(){
   // window.showModalDialog("../../emckis/order_manage.jsp","","dialogWidth:1200px;dialogHeight:1200px");
    window.location.href("../../emckis/order_manage.jsp");
    }
//-->
</script>
</head>
<body onLoad="Change_Select('<%=dept%>');">
<input id=xlsName" name="xlsName" value="" type="hidden""> 
<br>
<h4 align="center">���񱨼۵�ͳ��</h4>
<form name ="search" id ="search" action="finance2.jsp?command=search" method="post">
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">

	<tr>
	<td>
	�յ�/�տ�<select name ="year" id ="year" onchange="searchsales();">
			<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
			<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
			<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
			<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
			<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
			<option value="2015" <%=("2015").equals(year)?"selected":"" %>>2015</option>
			<option value="2016" <%=("2016").equals(year)?"selected":"" %>>2016</option>
			<option value="2017" <%=("2017").equals(year)?"selected":"" %>>2017</option>
			<option value="2018" <%=("2018").equals(year)?"selected":"" %>>2018</option>
			<option value="2019" <%=("2019").equals(year)?"selected":"" %>>2019</option>
			<option value="2020" <%=("2020").equals(year)?"selected":"" %>>2020</option>
		</select>��
		<select name ="month" id ="month" onchange="searchsales();">
			<option value="01" <%="01".equals(month)?"selected":""%>>1</option>
			<option value="02" <%="02".equals(month)?"selected":""%>>2</option>
			<option value="03" <%="03".equals(month)?"selected":""%>>3</option>
			<option value="04" <%="04".equals(month)?"selected":""%>>4</option>
			<option value="05" <%="05".equals(month)?"selected":""%>>5</option>
			<option value="06" <%="06".equals(month)?"selected":""%>>6</option>
			<option value="07" <%="07".equals(month)?"selected":""%>>7</option>
			<option value="08" <%="08".equals(month)?"selected":""%>>8</option>
			<option value="09" <%="09".equals(month)?"selected":""%>>9</option>
			<option value="10" <%="10".equals(month)?"selected":""%>>10</option>
			<option value="11" <%="11".equals(month)?"selected":""%>>11</option>
			<option value="12" <%="12".equals(month)?"selected":""%>>12</option>
		</select>��
		
			&nbsp;&nbsp;
		���ţ�
		<select name ="area" id ="area" onChange="Change_Select(this.value);">
			<option value="1" <%="1".equals(dept)?"selected":"" %>>����һ��</option>
			<option value="2" <%="2".equals(dept)?"selected":"" %>>���۶���</option>
			<option value="G" <%="G".equals(dept)?"selected":"" %>>����</option>
			<option value="D" <%="D".equals(dept)?"selected":"" %>>��ݸ</option>
		</select>
		&nbsp;&nbsp;
		�飺
		<select name ="group" id ="group">
		</select>
	      	<input name="button" value="ͳ��" type="submit" />
			&nbsp;&nbsp;
			<input name="export" value="������Excel" type="button" onclick="exportToExcel();" />
	      	</td>
	</tr>
</table>
</form>

	<table align="center" width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
		<tr bgcolor="dddddd"> 
			<td align="center" valign="middle">ǩ����</td>
			<td align="center" valign="middle">���տ�</td>
		</tr>
		<tr bgcolor="white"> 
			<td align="center" valign="middle"><%=f[1] %></td>
			<td align="center" valign="middle"><%=f[0] %></td>
			
		</tr>
	</table>

<p>&nbsp;</p>
  <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="999999">
    <tr bgcolor="dddddd"> 
      <td align="center" valign="middle">�������</td>
      <td align="center" valign="middle">�����·�</td>
       <td  align="center" valign="middle">����</td>
      <td  align="center" valign="middle">�ŵ���Ա</td>
      <td  align="center" valign="middle" width="400px">�ͻ�����</td>
      <td align="center" valign="middle">���۵���</td>
       <td align="center" valign="middle">����챨�ۺ�</td>
      <td  align="center" valign="middle">��Ŀ����</td>
      <td  align="center" valign="middle">��Ŀ����</td>
      <td  align="center" valign="middle">�տ�����</td>
      <td  align="center" valign="middle">�տʽ</td>
      <td  align="center" valign="middle">Ʊ����ʽ</td>
      <td  align="center" valign="middle">���۽��</td>
      <td  align="center" valign="middle">���ս��</td>
	  <td  align="center" valign="middle">δ�ս��</td>
	  <td  align="center" valign="middle">��ע</td>
	  <td  align="center" valign="middle">Ԥ���ְ���+������</td>
	  <td  align="center" valign="middle">Ԥ������Ӵ���</td>
	  <td  align="center" valign="middle">˰��</td>
	  <td  align="center" valign="middle">��������</td>
	  <td  align="center" valign="middle">�����տ����</td>
	  <td  align="center" valign="middle">�����տ���</td>
	  <td  align="center" valign="middle">���¿ۻ�����+�ְ���</td>
	  <td  align="center" valign="middle">���¿�����Ӵ���</td>
	  <td  align="center" valign="middle">���¿�˰��</td>
	  <td  align="center" valign="middle">���¿���������</td>
	  <td  align="center" valign="middle">���˿ۿ�</td>
	  <td  align="center" valign="middle">ҵ��С��</td>
	  <td  align="center" valign="middle">�Ƿ�᰸</td>
	  <td  align="center" valign="middle">�᰸����</td>
    </tr>
    <%
    	DecimalFormat df=new DecimalFormat("#.00");  
    	for(int j=0;j<list.size();j++){
    		List<Quotation> listQuotation=(List)list.get(0);
    		List listFloat =(List)list.get(1);
    		for(int i=0;i<listQuotation.size();i++) {
		    	Quotation qt = listQuotation.get(i);
		    	List cloums=(List)listFloat.get(i);
		    	//System.out.println(cloums.size()+"----------************");
		    	UserForm sales = UserAction.getInstance().getUserByName(qt.getSales());
		    	String str="";
		    	if(qt.getQuotype()!=null&&qt.getQuotype().equals("flu")){
		    	str="-";
		    	}
		     %>
		    <tr align=center valign=middle bgcolor="white"> 
		      <td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy").format(qt.getConfirmtime())%></td>
		      <td><%=qt.getConfirmtime()==null?"":new SimpleDateFormat("MM").format(qt.getConfirmtime())%></td>
		      <td><%=qt.getSales() %></td>
		      <td><%=qt.getCreatename()==null?"":qt.getCreatename()%></td>
		      <td width="400px"><%=qt.getClient() %></td>
		      <td><a href="javascript:showquotationlog('<%=qt.getPid() %>');"><%=qt.getPid() %></a></td>
		      <td><%=qt.getOldPid()==null ?"":qt.getOldPid()%></td>
		      <td>&nbsp;</td>
		      <td><%=qt.getProjectcontent() %></td>
		      <td width="100px"><%=qt.getPaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(qt.getPaytime()) %></td>
      		  <td><%=qt.getCreditcard()==null?"":qt.getCreditcard() %></td>
		      <td><%=qt.getQuotype() %></td>
		      <td><%=str%><%=df.format(qt.getTotalprice()) %></td>
      <td><%=df.format(qt.getPreadvance() + qt.getSepay() + qt.getBalance())%></td>
      <%
      	if(qt.getQuotype().equals("flu")){
    	%>
    	 <td><%=0.0%></td>
    	<%
    	}else{
    	%>
    	 <td><%=df.format(qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance()))%></td>
    	<%
    	}
       %>
      <td><%=qt.getObject()==null?"":qt.getObject() %></td>
      <td><%=qt.getPresubcost()+qt.getPreagcost()%></td>
      <td><%=qt.getPrespefund() %></td>
      <td><%=df.format(qt.getTotalprice()*0.08)%></td>
      <td><%=df.format(qt.getOthercost())%></td>
     <%
      float scale=(qt.getPreadvance() + qt.getSepay() + qt.getBalance())/qt.getTotalprice();//�տ����
      if(qt.getTotalprice()==0){
      	scale=0.0f;
      }
      %>
      <td><%=df.format(scale*100)%>%</td>
      <td><%=df.format(qt.getPreadvance() + qt.getSepay() + qt.getBalance()) %></td>
      <td><%=df.format((qt.getPresubcost()+qt.getPreagcost())*scale)%></td>
      <td><%=df.format(qt.getPrespefund()*scale)%></td>
      <td><%=df.format(qt.getTotalprice()*0.08*scale)%></td>
      <td><%=df.format(qt.getOthercost())%></td>
      <td><%=qt.getBadDebt()==null?"":qt.getBadDebt()%></td>
      <%
   		 Float sun =0.0f;
   		 Float taxes=qt.getTotalprice()*0.08f*scale;
   		 Float amountRece=qt.getPreadvance()+qt.getSepay()+qt.getBalance();//���ս��
   		 
   		  //�ӷѽ�����=(Ԥ�Ʒְ���+������)*�տ����-����Ӵ���*�տ����*��������
		 Float othercost=(qt.getPresubcost()+qt.getPreagcost())*scale+qt.getPrespefund()*scale+qt.getOthercost();//���տ���
		  //���˶�
		 Float badDebt=Float.parseFloat(qt.getBadDebt()==null||qt.getBadDebt().equals("")?"0.0":qt.getBadDebt());
		 if(qt.getPid().equals("LCQ216050854")){
   		 	System.out.println(amountRece+"*****"+othercost+"----"+taxes);
   		 }
		 //ҵ��С��=���ս��-˰�����-�ӷѽ�����-����
		 sun=amountRece-taxes-othercost-badDebt;
      %>
      <td><%=df.format(sun)%></td>
      <td><%=qt.getStatus()%></td>
      <td><%=qt.getFinish()==null?"":qt.getFinish()%></td>
    </tr>
		    <%
		   	}
    	}
     %>

  </table>
  <br>
  <br>
</body>
</html>
