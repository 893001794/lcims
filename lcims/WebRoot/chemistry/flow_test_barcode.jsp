<%@page import="com.lccert.crm.vo.FlowTest"%>
<%@page import="com.lccert.crm.vo.FlowTestStatus"%>
<%@page import="com.lccert.crm.chemistry.util.ByteArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>

<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%
	String command = request.getParameter("command");
	String kw = "请读入报告条形码";
	String err = "";
	String tester ="";//员工编号
	String vfidTestNo ="";//测试编号
	String vfidtestname ="";//测试项目
	String vfid=""; //流水单号
	String departmentNo="";//科室
	String departmentStr="";//科室
	String nowDate="";
	String count="";
	boolean sound = true;
	List chemLabTime =new ArrayList();
	if (command != null && "add".equals(command)) {
		FlowTestStatus flowTestStatus = (FlowTestStatus) session.getAttribute("flowTestStatus");
		String keywords = request.getParameter("keywords").trim();
		keywords=new ByteArrayList().getTranForm(keywords);
		tester=(String)session.getAttribute("tester");
		departmentNo=(String)session.getAttribute("departmentNo");
		keywords=new ByteArrayList().getTranForm(keywords);
		if(tester !=null &&!"".equals(tester)){
			if(keywords.indexOf("ZS")>-1) { //每读一次工序都要重新设置session
				//截取科室、操作人员WY1ZS09010
				departmentNo=keywords.substring(0,keywords.indexOf("ZS"));
				tester=keywords.substring(keywords.indexOf("ZS"),keywords.length());
				session.setAttribute("tester",tester);
				session.setAttribute("departmentNo",departmentNo);
				//session.setMaxInactiveInterval(15);
				kw = "成功读取员工编号，请在15秒内读取完该工序的流转单，否则要重新读取员工编号!";
				sound = false;
		   }else{
			   	if(keywords.length() >=12){
			   		if(tester==null){
			   			err = "错误：尚未读取员工编号,或登记间隔时间过长！";
				   		}else{
				   			boolean flag=false;
						//判断是否拆样室
						if(departmentNo.indexOf("C1")>-1||departmentNo.indexOf("C2")>-1){
						System.out.println(keywords);
							flag=DaoFactory.getInstance().getFlowTestStatus().findByBarCode(departmentNo,keywords);
						}
						if(flag==false){
							//根据测试编号查询项目
							FlowTest flowTest=DaoFactory.getInstance().getFlowTest().findByFidNo(keywords);
							if(flowTest !=null &&!"".equals(flowTest)){
								vfidTestNo=flowTest.getFidTestNo();
								vfidtestname=flowTest.getFidTestName();
								FlowTestStatus fts=new FlowTestStatus();
								fts.setFidTestNo(flowTest.getFid());
								if(departmentNo.equals("C1")){
									departmentStr="拆分室-XRF";
								}else if(departmentNo.equals("C2")){
									departmentStr="拆分室-剪样";
								}else if(departmentNo.equals("C3")){
									departmentStr="拆分室-称样";
								}else if(departmentNo.equals("Q1")){
									departmentStr="有机前处理-预处理";
								}else if(departmentNo.equals("Q2")){
									departmentStr="有机前处理-化验";
								}else if(departmentNo.equals("WQ1")){
									departmentStr="无机前处理-预处理";
								}else if(departmentNo.equals("WQ2")){
									departmentStr="无机前处理-化验";
								}else if(departmentNo.equals("Y1")){
									departmentStr="有机仪器室-上机";
								}else if(departmentNo.equals("Y2")){
									departmentStr="有机仪器室-数据分析";
								}else if(departmentNo.equals("Y3")){
									departmentStr="有机仪器室-审核";
								}else if(departmentNo.equals("WY1")){
									departmentStr="无机仪器室-上机";
								}else if(departmentNo.equals("WY2")){
									departmentStr="无机仪器室-数据分析";
								}else if(departmentNo.equals("WY3")){
									departmentStr="无机仪器室-审核";
								}else if(departmentNo.equals("B1")){
									departmentStr="报告组-模板编辑";
								}else if(departmentNo.equals("B2")){
									departmentStr="报告组-数据录入";
								}else if(departmentNo.equals("B3")){
									departmentStr="报告组-报告审核";
								}else if(departmentNo.equals("G1")){
									departmentStr="工程组-样品分板";
								}else if(departmentNo.equals("G2")){
									departmentStr="工程组-测试计划";
								}else if(departmentNo.equals("G3")){
									departmentStr="工程组-数据筛选";
								}
								fts.setDepartment(departmentStr);
								fts.setBarCode(departmentNo);
								fts.setTester(tester);
								fts.setVfidtestname(flowTest.getFidTestName());
								//获取系统时间
								SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								nowDate=sdf.format(new Date());
								fts.setBarCodeTime(nowDate);
								boolean resultFlag=DaoFactory.getInstance().getFlowTestStatus().saveFlowTestStatus(fts);
								session.setAttribute("flowTestStatus",DaoFactory.getInstance().getFlowTestStatus().findByBarCodeFlowNo(flowTest.getFid(),departmentNo));
								count=1+"";
								if(resultFlag==false){
									vfidtestname="";
									vfidTestNo="";
									departmentStr="";
									nowDate="";
									count="";
									err = "该工序已经有人打了条形码";
								}
							}
						}else{
							err = "拆样的XRF、剪样不管有多少项目都只能打一次条码";
						}
			   		}
				}else{
					err = "错误：无效报告号！";
				}
			}
		}else if(keywords.indexOf("ZS")>-1) { 
				//截取科室、操作人员WY1ZS09010
				departmentNo=keywords.substring(0, keywords.indexOf("ZS"));
				tester=keywords.substring(keywords.indexOf("ZS"),keywords.length());
				session.setAttribute("tester",tester);
				session.setAttribute("departmentNo",departmentNo);
				//session.setMaxInactiveInterval(15);
				kw = "成功读取员工编号，请在15秒内读取完该工序的流转单，否则要重新读取员工编号!";
				sound = false;
		} else {
				err = "请先读取员工编号!";
		}
	}
	FlowTestStatus flowTestStatus = (FlowTestStatus)session.getAttribute("flowTestStatus");
	if(flowTestStatus!=null){
		
	}
	if(flowTestStatus== null) {
		flowTestStatus = new FlowTestStatus();
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
			<tr>
				<td align=left valign=middle width=50%>
					<div>
						<font size="5"><strong><u><%=kw %></u>
						</strong>
						</font>
					</div>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action="flow_test_barcode.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td align=left valign=middle width=50%>
						输入栏：
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="提交"/>
					</td>
					
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						操作人员：
					</td>
					<td width="20%">
						<input name="rid" type="text" size="60" style="background-color: #F2F2F2" readonly="readonly" value="<%=tester==null?"":tester%>" />
					</td>
					<td width="15%">
						测试项目：
					</td>
					<td >
						<input  type="text" size="60" style="background-color: #F2F2F2" readonly="readonly" value="<%=vfidtestname==null?"":vfidtestname%>" />
					</td>
				</tr>
				<tr>
					<td width="17%">
						测试项目编号：
					</td>
					<td width="20%"> 
						<input size="60" style="background-color: #F2F2F2" readonly="readonly" value="<%=vfidTestNo==null?"":vfidTestNo%>" />
					</td>
					<td width="15%">
						测试科室：
					</td>
					<td>
						<input size="60" style="background-color: #F2F2F2" readonly="readonly" value="<%=departmentStr==null?"":departmentStr%>" />
					</td>
				</tr>

				<tr>
					<td  width="17%">
						完成时间：
					</td>
					<td width="20%">
						<input type="text" size="60" style="background-color: #F2F2F2" readonly="readonly" value="<%=nowDate%>" />
					</td>
					<td  width="15%">
						完成次数：
					</td>
					<td>
						<input type="text" size="60" style="background-color:#F2F2F2" readonly="readonly" value="<%=count%>">
					</td>
				</tr>
				<tr>
					
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				
			</table>
			<br>
			<br>
			<br>
		</form>
	</body>
</html>
