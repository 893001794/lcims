<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String strid = request.getParameter("id");
	if(strid == null || "".equals(strid)) {
		response.sendRedirect("myorder.jsp");
		return;
	}
	int id = Integer.parseInt(strid);
	String status = request.getParameter("status");
	//System.out.println(status+":status");
 %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META   HTTP-EQUIV="Pragma"   CONTENT="no-cache">   
  		<META   HTTP-EQUIV="Cache-Control"   CONTENT="no-cache">   
  		<META   HTTP-EQUIV="Expires"   CONTENT="0">
  		<base   target="_self"/>
		<title>��ӡ����</title>
<script type="text/javascript">
	function printorder(obj) {
		var yinzhang = 'y';
		var standprice = 'y';
		var chengpin = 'y';
		for(var i=0;i<userform.yinzhang.length;i++) {
			if(userform.yinzhang[i].checked) {
				yinzhang = userform.yinzhang[i].value;
			}
			if(userform.standprice[i].checked) {
				standprice = userform.standprice[i].value;
			}
			if(userform.chengpin[i].checked) {
				chengpin = userform.chengpin[i].value;
			}
		}
		var str = "";
		var url = "";
		if(chengpin == 'y') {
			if(status !=null){
			str += "��ͨ";
			}else{
			str += "��Ʒ";
			}
			url += "chengpin";
		}else {
			str += "��ͨ";
			url += "putong";
		}
		if(yinzhang == 'y') {
			str += "��ӡ��";
			url += "youzhang";
		}else {
			str += "��ӡ��";
			url += "wuzhang";
		}
		if(standprice == 'y') {
			str += "�б�׼��";
			url += "y";
		}else {
			str += "�ޱ�׼��";
			url += "n";
			
		}
		window.self.location = "../orderprint/" + url + ".jsp?id=<%=id%>";
		window.close();
		
	}
</script>
<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}
</style>
	</head>

	<body class="body1">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>��ӡ����&gt;&gt;�״�ʽ</b>
						</td>
					</tr>
				</table>
				
			</div>
			
			<hr width="100%" align="center" size=0>
			<form name="userform" id="userform">
			
			<table width="50%" border="0" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				
				<tr>
					<td class="rd8">
						����<input type="radio" name="yinzhang" id="yinzhang" class="checkbox1" value="y" checked="checked">
					</td>
					<td class="rd8">
						�б�׼��<input type="radio" name="standprice" id="standprice" class="checkbox1" value="y" checked="checked">
					</td>
					<td class="rd8">
						��Ʒ<input type="radio" name="chengpin" id="chengpin" class="checkbox1" value="y" checked="checked">
					</td>
					
				</tr>
				<tr>
					<td class="rd8">
						����<input type="radio" name="yinzhang" id="yinzhang" class="checkbox1" value="n">
					</td>
					<td class="rd8">
						�ޱ�׼��<input type="radio" name="standprice" id="standprice" class="checkbox1" value="n">
					</td>
					<td class="rd8">
						��ͨ<input type="radio" name="chengpin" id="chengpin" class="checkbox1" value="n">
					</td>
				</tr>
			</table>
		</form>
		<p>&nbsp;</p>
		<div align="center">
			<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="��ӡ" onClick="printorder('<%=status%>');" />
								&nbsp;&nbsp;&nbsp;
			<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="�ر�" onClick="window.close();" />
						</div>
	</body>
</html>
