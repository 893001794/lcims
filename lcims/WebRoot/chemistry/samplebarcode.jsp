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
	String kw = "����뱨��������";
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
				retest = "�ز�";
			}
		}
		
		if(chp != null) {
			chemp = (ChemProject)chp.getObj();
		}
		 keywords = request.getParameter("keywords").trim();
	
		
		if (keywords.length() == 10) { //&&���Ҹ���keywords�������ݿ�
			Flow flow = BarCodeAction.getInstance().getFlowByFid(keywords);
			keywords = keywords.substring(0,9);
			Project cp1 = ChemProjectAction.getInstance().searchChemProjectByRid(keywords);
		
			if (cp1 != null && flow != null) {
				session.setAttribute("flow",flow);
				session.setAttribute("project", cp1);
				session.setMaxInactiveInterval(10);
				kw = "�ɹ���ȡ��ת���ţ�����10���ڶ�ȡ��Ŀ״̬������!";
				sound = false;
			} else {
				err = "��Ч��ת����!";
			}
		} else if(flow0 != null && "n".equals(chemp.getIsfinish())) {
			 if ("X0".equals(keywords)) {//�Ʊ���ʼʱ��
					if("�޻���ת��".equals(flowtype)) {
						if (chp == null) {
							err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
						} else if(BarCodeAction.getInstance().getstatus(retest + "�޻��Ʊ���ʼʱ��",chemp.getList())){
							err = "����" + retest + "�޻��Ʊ���ʼʱ���ظ��Ǽ�!";
						} else {
							if(BarCodeAction.getInstance().updateTime(retest + "�޻��Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1,"")) {
							    BarCodeAction.getInstance().getUpdateStatus("�޻��Ʊ���ʼʱ��",chp.getSid());
								kw = retest + "�޻��Ʊ���ʼʱ��Ǽǳɹ���";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().searchChemProjectByRid(chp.getRid()));
							} else {
								err = "��ȡ���������¶�ȡ��";
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
					err = "������Ч����ţ�";
				} else if(chemp.getSendtime() != null){
					err = "����" + retest + "���淢��ʱ���ظ��Ǽ�!";
				} else {
					if(BarCodeAction.getInstance().updateTime("dsendtime",project.getRid(),project.getSid(),fid,4,"")) {
						kw = retest + "���淢��ʱ��Ǽǳɹ���";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().searchChemProjectByRid(project.getRid()));
					} else {
						err = "��ȡ���������¶�ȡ��";
					}
				}
			}
		} else {
			if(chp == null) {
				err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
			} else if("y".equals(chemp.getIsfinish())) {
				err = "���󣺱����Ѿ���ɻ���ȡ������������¼�룡";
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
		<title>��Ŀ���Ȳ�ѯ</title>
		<link rel="stylesheet" href="../css/drp.css">


<script type="text/javascript">
    window.onload=function(){//ҳ�����ʱ�ĺ���
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
							������¼��
						</h2> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action="samplebarcode.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td align=left valign=middle width=50%>
						��������
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="�ύ"/>
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
						��������룺
					</td>
					<td width="20%">
						<input name="rid" type="text" size="30"
							style="background-color: #F2F2F2" readonly="readonly" value="<%=keywords %>"/>
					</td>
					<td>
							�ͻ���
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
						������Ŀ��
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="" />
					</td>
				</tr>

				<tr>
					<td>
						��Ʒ���ƣ�
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="" />
					</td>
				</tr>
				<tr>
					<td>
						��ע��
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
						��Ŀ����ʱ�䣺
					</td>
					<td style="background: yellow;">
					
					</td>
				</tr>
				<tr>
					<td>
						�ŵ�ʱ�䣺
					</td>
					<td style="background: yellow;">
						
					</td>
				</tr>
				
		

				<tr>
					<td>
						�������ʱ�䣺
					</td>
					<td style="background: yellow;">
						
					</td>
				</tr>
				<tr>
					<td>
						���淢��ʱ�䣺
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
