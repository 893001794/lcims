<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.Warnning"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%
	String sid = request.getParameter("sid").trim();
	String rid =ChemProjectAction.getInstance().getProjectRid(sid);
	String  str=DaoFactory.getInstance().getProjectDao().isChemOrPhy(rid);
	
	List<ChemLabTime> list=null;
	Project p=null;
	String outStr=""; //记录外包或TUV
	String samplename="";
	String createtime="";
	String createname="";
	String endtime="";
	String rpconfirmtime="" ;//审核时间
	String nucopletintime =""; //填写时间
	String rpconfirmuser=""; //审核人
	String nucopletinuser="" ; //审核人
	String ostime=""; //外包发出时间
	String oetime="" ; //外包实际完成的时间
	String oeStr =""; //记录实际回收时间
	String servname ="";
	String sendtime ="";
	if(str.equals("化学测试")||"化妆品".equals(str)||"环境".equals(str)){
	 p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
	 ChemProject cp = (ChemProject)p.getObj();
	 servname=cp.getServname();
	 list = cp.getList();
	 samplename=cp.getSamplename();
	 if(cp.getCreatetime() !=null){
	createtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getCreatetime());
	}
	
	rpconfirmuser=cp.getRpconfirmuser();
	nucopletinuser=cp.getNucopletinuser();
	 if(cp.getRpconfirmtime()!=null){
	rpconfirmtime= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRpconfirmtime());
	 }
	
	 if(cp.getNucopletintime()!=null){
	nucopletintime= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getNucopletintime());
	 }
	
	
	 createname=cp.getCreatename();
	 if(cp.getEndtime()!=null){
	 endtime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime());
	 }
	  if(cp.getSendtime()!=null){
	  sendtime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getSendtime());
	  }
	
	}else{
	p=ChemProjectAction.getInstance().getPhyProjectBySid(sid);
	 PhyProject cp = (PhyProject)p.getObj();
	list = cp.getList();
	samplename=cp.getSamplename();
	if(cp.getCreatetime() !=null){
	createtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getCreatetime());
	}
	createname=cp.getCreatename();
	if(cp.getEndtime()!=null){
	  endtime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime());
	}
	}
	
	
	
	
	if(p == null) {
		p = new Project();
	}
	
	
	if(list == null) {
		list = new ArrayList<ChemLabTime>();
	}
%>

<html>
	<head>
		<meta content="text/html; charset=GB18030">
		<meta http-equiv="cache-control" content="no-cache, must-revalidate">
		<title>项目进度查询</title>
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

		
	</head>

	<body class="body1">  
	
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h1>
							项目进度
						</h1> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<div class="outborder">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="20%">
					
						报告编号<span style="color: red"><%=p.getQuotytp()==null?"":p.getQuotytp()%></span>：
					</td>
					<td width="20%">
						<input name="rid" type="text" size="15"
							style="background-color: #F2F2F2" readonly="readonly"
							value="<%=p.getRid()==null?"":p.getRid()%>" />
					</td>
					<td width="17%">
						项目等级：
					</td>
					<td >
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getLevel()==null?"":p.getLevel()%>" />
					</td>
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						测试项目：
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>" />
					</td>
				</tr>

				<tr>
					<td>
						样品名称：
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=samplename%>" />
					</td>
				</tr>

			</table>
			</div>
			<div align="center"><h4>项目状态</h4></div>
			<div class="outborder">
				
			<table align="center" border="1" cellspacing=5 cellpadding=5 width="95%">
				<tr bgcolor="#01DF01">
					<th>状态</th>
					<th>时间</th>
					<th>操作人</th>
				</tr>
				<tr>
					<td width="20%">
						项目接收时间：
					</td>
					<td style="background: yellow;">
						<%=p.getBuildtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime())%>
					</td>
					<td>
						<!--  p.getBuildname()==null?"":p.getBuildname()-->
						<%=servname%>
					</td>
				</tr>
				<tr>
					<td>
						排单时间：
					</td>
					<td style="background: yellow;">
						<%=createtime%>
					</td>
					<td>
						<%=servname%>
					</td>
				</tr>
				<%
				if(p.getIsout().equals("y")){
				
				if(p.getType().equals("机构合作")){
				outStr="TUV外包";
				}else {
				outStr="外包";
				oeStr="外包实际回数时间";
				}
				
				%>
				<tr>
					<td>
					<%=outStr%>发出时间:
					</td>
					<td style="background: yellow;">
					<%=p.getOstime()==null?"&nbsp;":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getOstime())%>
					</td>
					<td>
					&nbsp;
					</td>
				</tr>
				<%
				}
				
				 %>
					<tr>
					<td>
						填写时间：
					</td>
					<td style="background: yellow;">
						<%=nucopletintime%>
					</td>
					<td>
						<%=nucopletinuser==null?"&nbsp;":nucopletinuser%>
					</td>
				</tr>
				<tr>
					<td>
						审核时间：
					</td>
					<td style="background: yellow;">
						<%=rpconfirmtime%>
					</td>
					<td>
						<%=rpconfirmuser==null?"&nbsp;":rpconfirmuser%>
					</td>
				</tr>
				<tr>
				<%
			if(p.getIsout().equals("y") && !p.getType().equals("机构合作") ){
				
				
				%>
				<td>
						<%=oeStr %>：
					</td>
					<td style="background: yellow;">
						<%=p.getOetime()==null?"&nbsp;":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getOetime())%>
					</td>
					<td>
					&nbsp;
					</td>
				<%
				}
				//else{
				%>
				</tr>
				<tr>
				<td>
						报告完成时间：
					</td>
					<td style="background: yellow;">
					<%
					if(p.getIsout().equals("y") && p.getType().equals("机构合作")){
					endtime=p.getOetime()==null?"&nbsp;":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getOetime()) ;
					}
					 %>
						<%=endtime%>
					</td>
					<td>
					&nbsp;
					</td>
				<%
			//	}
				 %>
					
				</tr>
				<tr>
					<td>
						报告发出时间：
					</td>
					<td style="background: yellow;">
						<%=sendtime%>
					</td>
					<td>
					&nbsp;
					</td>
				</tr>
				</table>
				</div>
		<div align="center"><h4>实验室状态</h4></div>
			<div class="outborder">
			<table align="center" border="2" cellspacing=5 cellpadding=5 width="95%">
				<%
					for(int i=0;i<list.size();i++) {
						ChemLabTime clt = list.get(i);
				 %>
				
				<tr>
					<td>
						<%=clt.getStatus() %>：
					</td>
					<td style="background: yellow;">
						<%=clt.getTime()==null?"&nbsp;":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(clt.getTime()) %>
					</td>
				
				</tr>

				<%} %>
				
				
			</table>
			</div>
			<div align="center"><h4>项目预警</h4></div>
			<div class="outborder">
			<table align="center" border="2" cellspacing=5 cellpadding=5 width="95%">
				<tr bgcolor="#01DF01">
					<td>项目预警备注</td>
					<td>预警时间</td>
				</tr>
				<%
				List<Warnning> wms = ChemProjectAction.getInstance().getAllWarningBySid(p.getSid());
				for(int i=0;i<wms.size();i++) {
					Warnning w = wms.get(i);
				 %>
				 <tr>
				 	<td>
				 		<%=w.getWarn() %>
				 	</td>
				 	<td>
				 		<%=w.getWarntime()==null?"&nbsp;":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(w.getWarntime()) %>
				 	</td>
				 </tr>
				<%} %>
				
			</table>
			</div>
			<p>&nbsp;</p>
		<hr width="97%" align="center" size=0>
		<div align="center">
		<input type="button" value="关闭" onclick="window.close();">
		</div>
		
	</body>
</html>
