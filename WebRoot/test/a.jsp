<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="java.io.PrintWriter"%>


 
<%
request.setCharacterEncoding("GBK");

 %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html;charset=gb2312">
<meta name="keywords" content="վ��,��ҳ��Ч,��ҳ��Ч����,js��Ч,js�ű�,�ű�,������,zzjs,zzjs.net,www.zzjs.net,վ����Ч ��" />
<meta name="description" content="www.zzjs.net,վ����Ч����վ���ر�js��Ч�������롣����������js��Ч���ṩ����������������,����վ����Ч��" />
<title>��ҳ��Ч ��QQ���䵯����ѡ���ռ��˵�Ч�� վ����Ч����ӭ����</title>
<style type="text/css">
.black_overlay{display: none;position: absolute;top: 0%;left: 0%;width: 100%;height: 100%;background-color:#FFFFFF;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}
.white_content{display: none;position: absolute;top: 25%;left: 25%;width: 50%;height: 50%;padding: 16px;border: 16px solid orange;margin:-32px;background-color: white;z-index:1002;overflow: auto;}
</style>
<script language="javascript" type="text/javascript">
function moveselect(obj,target,all){
 if (!all) all=0
 if (obj!="[object]") obj=eval("document.all."+obj)
 target=eval("document.all."+target)
 if (all==0)
 {
   while (obj.selectedIndex>-1){
   //alert(obj.selectedIndex)
   mot=obj.options[obj.selectedIndex].text
   mov=obj.options[obj.selectedIndex].value
   obj.remove(obj.selectedIndex)
   var newoption=document.createElement("OPTION");
   newoption.text=mot
   newoption.value=mov
   target.add(newoption)
   }
 }//��ӭ����վ����Ч�������ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
 else
 {
  //alert(obj.options.length)
  for (i=0;i<obj.length;i++)
   {
   mot=obj.options[i].text
   mov=obj.options[i].value
   var newoption=document.createElement("OPTION");
   newoption.text=mot
   newoption.value=mov
   target.add(newoption)
   }
obj.options.length=0
 }
}
function dakai(){
document.getElementById('light').style.display='block';
document.getElementById('fade').style.display='block'
}
function guanbi(){
//�����ϰ��ұ�select��ֵ�����ı�����
var yuanGong=document.getElementById("yuanGong")
yuanGong.value=""//���������䣬��ÿ��ѡ��Ľ��׷��
var huoQu=document.getElementById("D2")
for(var k=0;k<huoQu.length;k++)
yuanGong.value=yuanGong.value + huoQu.options[k].value + " "//�����" "�м�Ϊ�ո�Ϊ�ַ���ķָ��������Ըĳɱ��
document.getElementById('light').style.display='none';
document.getElementById('fade').style.display='none'
}//��ӭ����վ����Ч�������ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
</script>
</head>
<body>
<a href="http://www.zzjs.net/">վ����Ч��</a>,վ���ر��ĸ�������ҳ��Ч�͹����롣zzjs.net��վ��js��Ч��<hr>
<!--��ӭ����վ����Ч����������վ�ռ�����������js��Ч���ṩ�����������أ���ַ��www.zzjs.net��zzjs@msn.com,��.net������վ-->
<input type="text" id="yuanGong" onclick="dakai()" size="50">
<div id="light" class="white_content">
<table border="1" width="350" id="table4" bordercolor="#CCCCCC" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF" cellpadding="3" cellspacing="0">
  <tr>
    <td width="150" height="200" align="center" valign="middle">
      �ò���Ա��
      <select size="12" name="D1" ondblclick="moveselect(this,'D2')" multiple="multiple" style="width:140px">
        <option value="Ա��1">Ա��1</option>
        <option value="Ա��2">Ա��2</option>
        <option value="Ա��3">Ա��3</option>
      </select>
    </td>
    <td width="50" height="200" align="center" valign="middle">
      <input type="button" value="<<" name="B3" onclick="moveselect('D2','D1',1)" /><br />
      <input type="button" value="<" name="B5" onclick="moveselect('D2','D1')" /><br />
      <input type="button" value=">" name="B6" onclick="moveselect('D1','D2')" /><br />
      <input type="button" value=">>" name="B4" onclick="moveselect('D1','D2',1)" /><br />
    </td>
    <td width="150" height="200" align="center" valign="middle">
      δ���ֲ���Ա��
      <select size="12" name="D2" id="D2" ondblclick="moveselect(this,'D1')" multiple="multiple" style="width:140px">
        <option value="Ա��4">Ա��4</option>
        <option value="Ա��5">Ա��5</option>
      </select>
    </td>
  </tr>
</table>
<a href="javascript:void(0)" onclick="guanbi()">ȷ��</a>
<input type="button" name="button" onclick="guanbi()" value="Ҳ����ʹ�ð�ť��ȷ��" />
</div>
<div id="fade" class="black_overlay"></div>
</body>
</html>