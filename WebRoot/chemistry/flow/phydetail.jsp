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
<%@page import="com.lccert.crm.dao.impl.ChemProjectDaoImplMySql"%>
<%@page import="com.lccert.crm.dao.ChemProjectDao"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%
	request.setCharacterEncoding("GBK");
	String fid = request.getParameter("fid");

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
	Project p = ChemProjectAction.getInstance().getPhyProjectBySid(flow.getSid()); 
	ChemProjectDaoImplMySql c=new ChemProjectDaoImplMySql();
	String warning =new ChemProjectDaoImplMySql().getWarning(p.getSid());
	PhyProject cp = (PhyProject)p.getObj();
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>流转单详细信息</title>
<style type="text/css">
/*工作区的背景色*/
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
			window.self.location = "addflow.jsp?ptype=phy&sid=<%=flow.getSid()%>";
		}
		
		function modifyflow() {
			window.self.location = "modifyflow.jsp?ptype=phy&fid=<%=flow.getFid()%>";
		}
		
		function printflow(fid) {
			//window.open("printflow.jsp?fid=" + fid,"", "height=0, width=0,top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no'");
			window.open("printphyflow.jsp?fid=" + fid);
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
         //指定回调函数为callback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //回调函数
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
        	var respstr = req.responseText;
          	alert(respstr);
        }else{
          alert("打印出错:" + req.statusText);
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
						<img src="../../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>化学项目管理&gt;&gt;管理流转单&gt;&gt;流转单详细信息</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
		<div class="outborder">
			<table cellpadding="5" cellspacing="0" width="95%">
				<tr>
					<td width="17%">
						报价单编号：
					</td>
					<td width="33%">
						<input name="pid" size="40" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getPid() %>" />
					</td>

					<td width="17%">
						报告类型：
					</td>
					<td width="33%">
						
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=cp.getRptype() %>" />
					</td>

				</tr>
				<tr>
					<td>
						应出报告时间：
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime()) %>" />
					</td>
					<td>
						报告编号：
					</td>
					<td>
						<input name="rid" type="text"  size="40" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getRid() %>" />
					</td>
				</tr>
				<tr>
					<td>
						项目接收时间：
					</td>
					<td>
						<input type="text" size="40" style="background-color: #F2F2F2"
							readonly="readonly"
							value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime()) %>" />
					</td>
					<td>
						项目等级：
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
						流转单种类：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getFlowtype() %>"/>
					</td>
					<td width="17%">
						样品名称：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=cp.getSamplename()%>"/>
					</td>
				</tr>
				
				<tr>
					<td>
						测试实验室：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=flow.getLab() %>"/>
					</td>
					<td width="17%">
						样品型号：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=cp.getSamplemodel()%>"/>
					</td>
				</tr>
				<tr>
					<td>
						额定电压：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=cp.getRatedvoltage()%>"/>
					</td>
					<td width="17%">
						额定电流：
					</td>
					<td>
						<input type="text" readonly="readonly" style="background-color: #F2F2F2" value="<%=cp.getRatedcurrent()%>"/>
					</td>
				</tr>
			</table>
			
			<table cellpadding="5" cellspacing="0" width="95%">
				
				<tr>
					<td width="17%">
						项目预警备注：
					</td>
					<td>
						<textarea rows="3" cols="76" readonly="readonly"  style="background-color: #F2F2F2"><%=warning==null?"":warning%></textarea>
					</td>
				</tr>
			</table>

			<table cellpadding="5" cellspacing="5">
				
				
				
			
				<tr>
					<td>
						实验室测试方法：
					</td>
					<td>
					<%if(cp.getRptype().equals("中文报告")) {
					%>
					<textarea cols="76" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getTestplanC()%></textarea>
					<%
					}else if(cp.getRptype().equals("英文报告")) {
					%>
					<textarea cols="76" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getTestplanE()%></textarea>
					<%
					}%>
						
					</td>
					
				</tr>
				<tr>
					<td>
						备注：
					</td>
					<td>
					
						<textarea cols="73" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=flow.getNotes()%></textarea>
					</td>
				</tr>
			</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="继续添加流转单" onclick="addflow()">
					&nbsp;&nbsp;&nbsp;
				<input type="button" value="打印流转单" onClick="printflow('<%=flow.getFid() %>');"/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="修改流转单" onClick="modifyflow();"/>
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
