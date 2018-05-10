<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.chemistry.util.FlowFinal"%>
<%@page import="com.lccert.crm.vo.FlowTest"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>
 <%@ page errorPage="../../error.jsp" %>
 <%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	System.out.println("pageNoStr:"+pageNoStr);
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	
	}
	System.out.println("pageNo:"+pageNo);
	String fidNo = request.getParameter("fidNo");
	String fidTestName = request.getParameter("fidTestName");
	if(fidNo ==null){
		fidNo="";
	}
	if(fidTestName ==null){
		fidTestName="";
	}
	PageModel pm = DaoFactory.getInstance().getFlowTest().findAllInPage(fidNo,fidTestName,pageNo,pageSize);
	if(pm==null){
		pm=new PageModel();
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>ʵ������ת���б�</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<script src="../../javascript/jquery.js"></script>
		<script type="text/javascript">
			function changCount(id){
				var count =$("#testCount"+id).val();
				jQuery.ajax({
					url:"/lcims/ajaxClass", //��ת��·��
					data:"method=changeFlowTestCount&id="+id+"&count="+count, //�����ֵ�����
					type:'POST',
					synch:true,//(Ĭ��: true) Ĭ�������£����������Ϊ�첽���������Ҫ����ͬ�������뽫��ѡ������Ϊ false��ע�⣬ͬ��������ס��������û�������������ȴ�������ɲſ���ִ�С�
					success: function(data){//����ɹ���ص���������������������������������������ݣ�����״̬//
						var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
					 	if(agent.attr('suc') == 'false'){ //�õ�����Ϊagent��xml��������sucԪ�أ������ж�sucԪ�ص�ֵ�Ƿ�Ϊtrue
						 	alert("�޸Ĳ��Ե�ʧ�ܣ������Ա��");
							return false;
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){ 
						alert("XMLHttpRequest:"+XMLHttpRequest);
						alert("textStatus:"+textStatus);
						alert("errorThrown:"+errorThrown);
					}
				})
			}
		</script>
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
						<img src="../../images/mark_arrow_02.gif" width="14" height="14">
						&nbsp;
						<b>��ѧ��Ŀ����&gt;&gt;ʵ������ת��&gt;&gt;��ת���б�</b>
					</td>
				</tr>
			</table>

			<hr width="100%" align="center" size=0>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=department_flow_manage.jsp?command=search>
							<font color="red">&nbsp;������ת���ţ�&nbsp;</font>
							<input type=text name=fidNo size="25" >
							<input type=submit name=Submit value=����>
						</form>
					</td>

				</tr>

				<tr>
					<td valign=middle width=50%>
						<form name=search method=post
							action=department_flow_manage.jsp?command=search>
							<font color="red">����Ŀ�������ƣ�</font>
							<input type=text name=fidTestName size="25"  >
							<input type=submit name=Submit value=����>
						</form>
					</td>

				</tr>

			</table>

			<hr width="97%" align="center" size=0>
			<form name="userform" id="userform">
		</div>
		<table width="95%" height="20" border="0" align="center"
			cellspacing="0" class="rd1" id="toolbar">
			<tr>
				<td width="30%" class="rd19">
					<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
				</td>


			</tr>
		</table>
		<table width="95%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="table1">
			<tr>
				<td class="rd6" width="5%">
					<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
				</td>
				<td class="rd6">
					��ת�����
				</td>
				<td class="rd6">
					��ת��������
				</td>
				<td class="rd6">
					��ת����������
				</td>
				<td class="rd6">
					���Ե���
				</td>
			</tr>

			<%
				List<FlowTest> list = pm.getList();
					if(list != null) {
						for(int i=0;i<list.size();i++) {
							FlowTest flowTest = list.get(i);
			%>
							<tr>
								<td class="rd8">
									<input type="checkbox" name="selectFlag" class="checkbox1"
										value="<%=flowTest.getFid()%>">
								</td>
								<td class="rd8">
									<%=flowTest.getFid() %>
								</td>
								<td class="rd8">
									<%=flowTest.getFidTestNo() %>
								</td>
								<td class="rd8">
									<%=flowTest.getFidTestName()%>
								</td>
								<td class="rd8">
									<input type="text" value="<%=flowTest.getCount()%>" id="testCount<%=flowTest.getId()%>">
									<input type="button" onclick="changCount('<%=flowTest.getId()%>');" value="�޸�">
								</td>
							</tr>
				<%
						}
					}
				 %>
			<tr style="background-color: #E0F8E0">
				<td height="25" colspan="12" align="left">
					<div align="center">
						��¼��������<%=pm.getTotalRecords()%>
						��ǰҳ/��ҳ��:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
						<a
							href="department_flow_manage.jsp?pageNo=1&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">��ҳ</a>
						<a
							href="department_flow_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">��һҳ</a>
						<a
							href="department_flow_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">��һҳ</a>
						<a
							href="department_flow_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&fidNo=<%=fidNo%>&fidTestName=<%=fidTestName%>"
							class="red">ĩҳ</a>
					</div>
				</td>
			</tr>
		</table>
	</body>
</html>
