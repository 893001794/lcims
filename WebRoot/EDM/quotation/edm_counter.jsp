<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("GBK");

String ems="";
String command=request.getParameter("command");
if(command !=null){
ems =request.getParameter("ems");
}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'sample_package.jsp' starting page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<script src="../javascript/jquery.js"></script>
	<script src="../javascript/jquery.autocomplete.min.js"></script>
	<link rel="stylesheet" type="text/css"
			href="../css/jquery.autocomplete.css" />
	<script language="javascript" type="text/javascript"
			src="../javascript/date/WdatePicker.js"></script>
	<style type="text/css" bogus="1"> 
.txt{ 
color:#005aa7; 
border-bottom:1px solid #005aa7; /* �»���Ч�� */ 
border-top:0px; 
border-left:0px; 
border-right:0px; 
background-color:transparent; /* ����ɫ͸�� */ 
} 
</style> 
<script type="text/javascript">
		function statistics(){
		var myform=document.getElementById("myform");//��ȡ��
		//�����ı���
		var ypnbg=document.getElementById("myform").ypnbg.value;//������c1
		var flowrate=document.getElementById("myform").flowrate.value;//����c2
		var sPressures=document.getElementById("myform").sPressures.value;//��ѹc3
		var bTemperature=document.getElementById("myform").bTemperature.value;//��ǰ��c4
		var sTemperature=document.getElementById("myform").sTemperature.value;//����c5
		var moisture=document.getElementById("myform").moisture.value;//��ʪ��c6
		var samplingTime=document.getElementById("myform").samplingTime.value;//����ʱ��c7
		var area=document.getElementById("myform").area.value;//���c8
		var aPressure=document.getElementById("myform").aPressure.value;//����ѹc9
		var measuredS02=document.getElementById("myform").measuredS02.value;//ʵ��S02 c12
		var oContentS02=document.getElementById("myform").oContentS02.value;//������c13
		var sCOExcessS02=document.getElementById("myform").sCOExcessS02.value;//��׼����ϵ��c14
		var measuredNO =document.getElementById("myform").measuredNO.value;//ʵ��NO c17
		var oContentN0=document.getElementById("myform").oContentN0.value;//������ c18
		var sCOExcessN0=document.getElementById("myform").sCOExcessN0.value;//��׼����ϵ�� c19
		//�����ı���
		var flowmeter=(ypnbg/2)*(ypnbg/2)*3.14/1000*60*flowrate; //������������ h1
		document.getElementById("myform").flowmeter.value=Math.round(flowmeter *10)/10;
		var dynamic=flowrate*flowrate*1.34/2; //��ѹ h2
		document.getElementById("myform").dynamic.value=dynamic;
		var total=dynamic/1000+parseFloat(sPressures); //ȫѹ h3
		document.getElementById("myform").total.value=Math.round(total*100)/100;
		var aTemperature=flowmeter*(-5)/20 ; //��ǰѹ h4
		document.getElementById("myform").aTemperature.value=Math.round(aTemperature*100)/100;
		var wVolume=flowmeter*samplingTime ; //����������� h5
		document.getElementById("myform").wVolume.value=Math.round(wVolume*10)/10;
		var sCVolume=samplingTime*0.05*Math.round(flowmeter*10)/10*Math.sqrt((parseFloat(aPressure)+parseFloat(Math.round(aTemperature*100)/100))*1000/(parseFloat(bTemperature)+parseFloat(273)));
		document.getElementById("myform").sCVolume.value=Math.round(sCVolume);
		var wFlow=area*flowrate*3600; // �������� h7
		document.getElementById("myform").wFlow.value=wFlow;
		var sCFlow=wFlow*(1-moisture)*(parseFloat(aPressure)+parseFloat(sPressures))/101.325*273/(273+parseFloat(sTemperature)); // ������� h8
		document.getElementById("myform").sCFlow.value=Math.round(sCFlow);
		var mOPCoefficientS02=20.9/(20.9-oContentS02); //ʵ�����ϵ�� h12  ����2
		document.getElementById("myform").mOPCoefficientS02.value=Math.round(mOPCoefficientS02*100)/100;
		var eConcentrationS02=measuredS02*mOPCoefficientS02/sCOExcessS02 ; //����Ũ�� h13
		document.getElementById("myform").eConcentrationS02.value=Math.round(eConcentrationS02);
		var N0x=measuredNO*1.53; //N0x h17  ����1λС��
		document.getElementById("myform").N0x.value=Math.round(N0x);
		var mOPCoefficientN0=Math.round(20.9/(20.9-oContentN0)*100)/100 ; //ʵ�����ϵ��  h18  ����2
		document.getElementById("myform").mOPCoefficientN0.value=mOPCoefficientN0;
		var eConcentrationN0=N0x*mOPCoefficientN0/sCOExcessN0; //����Ũ�� h19
		document.getElementById("myform").eConcentrationN0.value=Math.round(eConcentrationN0*10)/10;
		}
</script>


  </head>
  
  <body onload="javascript:myform.ems.focus();"> 
	<form action="#" name ="myform" id="myform">
    	<table border="0" align="center" width="900">
    		<tr>
    		<td>��������</td>
    			<td>
    			<input name="ypnbg" type="text" id="ypnbg" size="40" onfocus="getSales(this);" value=""/>
    			</td>
    			<td>������������:</td>
    			<td><input name="flowmeter" type="text" id="flowmeter" size="40" onfocus="getSales(this);" style="background-color: #F2F2F2"
							readonly="readonly"/></td>
    		</tr>
    		<tr>
    		<td>���٣�</td>
    		<td>
    		<input type="text" size="40" name ="flowrate" id ="flowrate" value="">
    		</td>
    		<td>��ѹ��</td>
    		<td><input name ="dynamic" id ="dynamic" size="40" style="background-color: #F2F2F2"
							readonly="readonly"></td>
    		</tr>
    		<tr>
    		<td>��ѹ��</td>
    		<td><input name ="sPressure" id ="sPressures" size="40" value=""></td>
    		<td>ȫѹ��</td>
    			<td>
		    		<input name="total" type="text" id="total" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		
    		<tr>
    		<td>��ǰ�£�</td>
    		<td><input name ="bTemperature" id ="bTemperature" size="40" value=""></td>
    		<td>��ǰѹ��</td>
    			<td>
		    		<input name="aTemperature" type="text" id="aTemperature" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		
    		<tr>
    		<td>���£�</td>
    		<td><input name ="sTemperature" id ="sTemperatures" size="40" value=""></td>
    		<td>�������������</td>
    			<td>
		    		<input name="wVolume" type="text" id="wVolume" size="40"  style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		
    		<tr>
    		<td>��ʪ����</td>
    		<td><input name ="moisture" id ="moisture" size="40" value=""></td>
    		<td>������������</td>
    			<td>
		    		<input name="sCVolume" type="text" id="sCVolume" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		
    		<tr>
    		<td>����ʱ�䣺</td>
    		<td><input name ="samplingTime" id ="samplingTime" size="40" value=""></td>
    		<td>����������</td>
    			<td>
		    		<input name="wFlow" type="text" id="wFlow" size="40"  style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		
    		<tr>
    		<td>�����</td>
    		<td><input name ="area" id ="area" size="40" value=""></td>
    		<td>���������</td>
    			<td>
		    		<input name="sCFlow" type="text" id="sCFlow" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		
    		<tr>
    		<td>����ѹ��</td>
    		<td><input name ="aPressure" id ="aPressure" size="40" value=""></td>
    		<td>&nbsp;</td>
    			<td>
		    		&nbsp;
				</td>
    		</tr>
    		<tr>
    			<td colspan="4"><font style="color: red;">S02</font></td>
    		</tr>
    		<tr>
    		<td>ʵ��S02��</td>
    			<td>
		    		<input name="measuredS02" type="text" id="measuredS02" size="40" value=""/>
				</td>
    		<td>ʵ�����ϵ����</td>
    			<td>
		    		<input name="mOPCoefficientS02" type="text" id="mOPCoefficientS02" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		<tr>
    		<td>��������</td>
    		<td><input name ="oContentS02" id ="oContentS02" size="40" value=""></td>
    		<td>����Ũ�ȣ�</td>
    			<td>
		    		<input name="eConcentrationS02" type="text" id="eConcentrationS02" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr><tr>
    		<td>��׼����ϵ����</td>
    		<td><input name ="sCOExcessS02" id ="sCOExcessS02" size="40" value=""></td>
    		<td>&nbsp;</td>
    		<td>
		    	&nbsp;
			</td>
    		</tr>
    		<tr>
    			<td colspan="4"><font style="color: red;">NOx</font></td>
    		</tr>
    		<tr>
    		<td>ʵ��NO��</td>
    		<td><input name ="measuredNO" id ="measuredNO" size="40" value=""></td>
    		<td>N0x��</td>
    			<td>
		    		<input name="N0x" type="text" id="N0x" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr><tr>
    		<td>��������</td>
    		<td><input name ="oContentN0" id ="oContentN0" size="40" value=""></td>
    		<td>ʵ�����ϵ����</td>
    			<td>
		    		<input name="mOPCoefficientN0" type="text" id="mOPCoefficientN0" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr><tr>
    		<td>��׼����ϵ����</td>
    		<td><input name ="sCOExcessN0" id ="sCOExcessN0" size="40" value=""></td>
    		<td>����Ũ�ȣ�</td>
    			<td>
		    		<input name="eConcentrationN0" type="text" id="eConcentrationN0" size="40" value="" style="background-color: #F2F2F2"
							readonly="readonly"/>
				</td>
    		</tr>
    		<tr align="center"">
    			<td colspan="4"><input type="button" onclick="statistics();" value="����"></td>
    		</tr>
    		</form>
    	</table>
    
</html>
