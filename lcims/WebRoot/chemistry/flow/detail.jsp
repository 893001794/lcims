<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	request.setCharacterEncoding("GBK");
	String fid = request.getParameter("fid");
	String sidStr=request.getParameter("sid");
	String type =request.getParameter("type");
	if(fid == null || "".equals(fid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Flow flow = FlowAction.getInstance().getFlowByFid(fid); 
	if(flow == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ChemProjectAction.getInstance().getChemProjectBySid(flow.getSid(),""); 
	ChemProject cp = (ChemProject)p.getObj();
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>��ת����ϸ��Ϣ</title>
<style type="text/css">
/*�������ı���ɫ*/
.body1 {
	background-color: #fffff5;
}
		
.outborder
{
    border: solid 1px;
}
</style>

		<script language="javascript">
		function goBack() {
			window.self.location = "../project/searchproject.jsp";
		}
		
		function addflow() {
			window.self.location = "addflow.jsp?sid=<%=sidStr%>&type=<%=type%>";
		}
		function modifyflow() {
			window.self.location = "modifyflow.jsp?fid=<%=flow.getFid()%>";
		}
		
		
		function printflow(fid) {
			//window.open("printflow.jsp?fid=" + fid,"", "height=0, width=0,top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no'");
			window.open("printflow.jsp?fid="+fid);
			//ajax_print(fid);
		}
		
			

    var req;
    
    function ajax_print(fid){
      var url = "printflow.jsp?fid=" + fid + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
         //ָ���ص�����Ϊcallback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //�ص�����
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
        	var respstr = req.responseText;
        }else{
          alert("��ӡ����:" + req.statusText);
        }
      }
    }
</script>
	</head>

	<body class="body1">
		<form name="form1">
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�ͷ�����&gt;&gt;�����ת��
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
		<div class="outborder">
			<table cellpadding="5" cellspacing="0" width="95%">
				<tr>
					<td width="17%">
						���۵���ţ�
					</td>
					<td width="33%">
						<input name="pid" size="40" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getPid() %>" />
					</td>

					<td width="17%">
						�������ͣ�
					</td>
					<td width="33%">
						
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=cp.getRptype() %>" />
					</td>

				</tr>
				<tr>
					<td>
						Ӧ������ʱ�䣺
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>" />
					</td>
					<td>
						�����ţ�
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getRid()%>" />
					</td>
				</tr>
				<tr>
					<td>
						��Ŀ����ʱ�䣺
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime()) %>" />
					</td>
					<td>
						��Ŀ�ȼ���
					</td>
					<td>
						<input type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=p.getLevel() %>" />
					</td>
				</tr>
			</table>
			
		</div>
			<div class="outborder">
			<table cellpadding="5" cellspacing="0" width="95%">
				<tr>
					<td width="17%">
						��ת�����ࣺ
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getFlowtype() %>"/>
					</td>
				</tr>
				
				<tr>
					<td>
						����ʵ���ң�
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getLab() %>"/>
					</td>
				</tr>
				<tr>
					<td>
						���Ե�����
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getTestcount() %>"/>
					</td>
				</tr>
				
			</table>
			
			<table cellpadding="5" cellspacing="0" width="95%">
				
				<tr>
					<td width="17%">
						��ĿԤ����ע��
					</td>
					<td>
						<textarea rows="3" cols="76" readonly="readonly"  style="background-color: #F2F2F2"><%=cp.getWarning()==null?"":cp.getWarning() %></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5">
				<tr>
					<td width="17%">
						������Ʒ������
					</td>
					<td>
						<textarea cols="73" rows="4" readonly="readonly"  style="background-color: #F2F2F2"><%=cp.getSampledesc() %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						���������Ϣ��
					</td>
					<td>
						<textarea cols="73" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=cp.getAppform() %></textarea>
					</td>
				</tr>
				
			
				<tr>
					<td>
						���Է�����
					</td>
					<td>
					<%if(cp.getRptype().equals("���ı���")) {
					%>
					<textarea cols="76" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getTestplanC()%></textarea>
					<%
					}else if(cp.getRptype().equals("Ӣ�ı���")) {
					%>
					<textarea cols="76" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getTestplanE()%></textarea>
					<%
					}%>
						
					</td>
					
				</tr>
			</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="���������ת��" onclick="addflow()">
					&nbsp;&nbsp;&nbsp;
				<input type="button" value="��ӡ��ת��" onClick="printflow('<%=flow.getFid()%>');"/>
				&nbsp;&nbsp;&nbsp;
				<!-- <input type="button" value="�޸���ת��" onClick="modifyflow();"/> -->
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="����" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
