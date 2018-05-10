<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%
	String command = request.getParameter("command");
	String kw = "请读入报告条形码";
	String err = "";
	String fid = "";
	String flowtype = "";
	String retest = "";
	String isfinish = "";
	boolean sound = true;
	String keywords="";
	if (command != null && "add".equals(command)) {
		Project chp = (Project) session.getAttribute("project");
		ChemProject chemp = new ChemProject();
		Flow flow0 = (Flow)session.getAttribute("flow");
		if(flow0 != null) {
			fid = flow0.getFid();
			flowtype = flow0.getFlowtype();
			if("y".equals(flow0.getRetest())) {
				retest = "重测";
			}
		}
		
		if(chp != null) {
			chemp = (ChemProject)chp.getObj();
		}
		 keywords = request.getParameter("keywords").trim();
	
		
		if (keywords.length() == 10) { //&&并且根据keywords查找数据库
			Flow flow = BarCodeAction.getInstance().getFlowByFid(keywords);
			keywords = keywords.substring(0,9);
			Project cp1 = ChemProjectAction.getInstance().searchChemProjectByRid(keywords);
		
			if (cp1 != null && flow != null) {
				session.setAttribute("flow",flow);
				session.setAttribute("project", cp1);
				session.setMaxInactiveInterval(10);
				kw = "成功读取流转单号，请在10秒内读取项目状态条形码!";
				sound = false;
			} else {
				err = "无效流转单号!";
			}
		} else if(flow0 != null && "n".equals(chemp.getIsfinish())) {
			 if ("X0".equals(keywords)) {//制备开始时间
					if("无机流转单".equals(flowtype)) {
						if (chp == null) {
							err = "错误：尚未读取报告号,或登记间隔时间过长！";
						} else if(BarCodeAction.getInstance().getstatus(retest + "无机制备开始时间",chemp.getList())){
							err = "错误：" + retest + "无机制备开始时间重复登记!";
						} else {
							if(BarCodeAction.getInstance().updateTime(retest + "无机制备开始时间",chp.getRid(),chp.getSid(),fid,1,"")) {
							    BarCodeAction.getInstance().getUpdateStatus("无机制备开始时间",chp.getSid());
								kw = retest + "无机制备开始时间登记成功！";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().searchChemProjectByRid(chp.getRid()));
							} else {
								err = "读取错误，请重新读取！";
							}
						}
					}
		}
					 
%> 
<%
		} else if (keywords.length() >= 12) {
			if("LC".equals(keywords.substring(0,2))) {
				Project project = ChemProjectAction.getInstance().searchChemProjectByRid(keywords);
				if(project != null) {
					chemp = (ChemProject)project.getObj();
				}
				if (project == null) {
					err = "错误：无效报告号！";
				} else if(chemp.getSendtime() != null){
					err = "错误：" + retest + "报告发出时间重复登记!";
				} else {
					if(BarCodeAction.getInstance().updateTime("dsendtime",project.getRid(),project.getSid(),fid,4,"")) {
						kw = retest + "报告发出时间登记成功！";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().searchChemProjectByRid(project.getRid()));
					} else {
						err = "读取错误，请重新读取！";
					}
				}
			}
		} else {
			if(chp == null) {
				err = "错误：尚未读取报告号,或登记间隔时间过长！";
			} else if("y".equals(chemp.getIsfinish())) {
				err = "错误：报告已经完成或者取消，不可以再录入！";
			}
		}
	}
	

	Project p = (Project) session.getAttribute("project");
	if(p == null) {
		p = new Project();
	}
	ChemProject cp = (ChemProject)p.getObj();
	if(cp == null) {
		cp = new ChemProject();
	}
	List<ChemLabTime> list = cp.getList();
	
	if(list == null) {
		list = new ArrayList<ChemLabTime>();
	}
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>项目进度查询</title>
		<link rel="stylesheet" href="../css/drp.css">


<script type="text/javascript">
    window.onload=function(){//页面加载时的函数
    	document.form1.keywords.focus();
    	<%if(!("".equals(err))) {%>
    		alert("<%=err%>");
    	<%}%>
    }
  </script>



		
	</head>

	<body class="body1">  
	
	<%
		if(sound) {
	%>
	
		<bgsound src="Readagain.wav" loop="1" id="bgs" />
	<%
	}
	%>
	
   
	 
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h2>
							条形码录入
						</h2> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action="samplebarcode.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td align=left valign=middle width=50%>
						输入栏：
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="提交"/>
					</td>
					
				</tr>
				<tr>
					<td align=left valign=middle width=50%>
						<div>
							<font size="5"><strong><u></u>
							</strong>
							</font>
						</div>
					</td>
				</tr>
			</table>


			<hr width="97%" align="center" size=0>
			
		
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						快递条形码：
					</td>
					<td width="20%">
						<input name="rid" type="text" size="30"
							style="background-color: #F2F2F2" readonly="readonly" value="<%=keywords %>"/>
					</td>
					<td>
							客户：
						</td>
					<td>
					<input name="client" type="text" id="client" size="40"
								onchange="validateclient(this);" />
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:10,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>
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
							readonly="readonly" value="" />
					</td>
				</tr>

				<tr>
					<td>
						样品名称：
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="" />
					</td>
				</tr>
				<tr>
					<td>
						备注：
					</td>
					<td>
						<textarea name="notes" cols="80" rows="4" readonly="readonly" style="background-color: #F2F2F2"></textarea>
					</td>
				</tr>

			</table>
			<div id ="div1" style="display: none;">
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="20%">
						项目接收时间：
					</td>
					<td style="background: yellow;">
					
					</td>
				</tr>
				<tr>
					<td>
						排单时间：
					</td>
					<td style="background: yellow;">
						
					</td>
				</tr>
				
		

				<tr>
					<td>
						报告完成时间：
					</td>
					<td style="background: yellow;">
						
					</td>
				</tr>
				<tr>
					<td>
						报告发出时间：
					</td>
					<td style="background: yellow;">
						
					</td>
				</tr>
			</table>
			</div>
			<br>
			<br>
			<br>
		</form>
	</body>
</html>
