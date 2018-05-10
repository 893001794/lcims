<%@page import="com.lccert.crm.vo.Fincome"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	String vpid = request.getParameter("vpid");
	String client = request.getParameter("client");
	String startDpaytime = request.getParameter("startDpaytime");
	String endDayTiem = request.getParameter("endDayTiem");
	String startCreatetime = request.getParameter("startCreatetime");
	String endCreatetime = request.getParameter("endCreatetime");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	Fincome fincome =new Fincome();
	PageModel pm = null;
	fincome.setPageNo(pageNo);
	fincome.setPageSize(pageSize);
	fincome.setVpid(vpid);
	fincome.setClient(client);
	fincome.setStartDpaytime(startDpaytime);
	fincome.setEndDayTiem(endDayTiem);
	fincome.setStartCreatetime(startCreatetime);
	fincome.setEndCreatetime(endCreatetime);
	pm = DaoFactory.getInstance().getFincome().searchFincomes(fincome);
	if (pm == null) {
		pm = new PageModel();
	}
	session.setAttribute("fincome",fincome);
%>

<html>
	<head>
		<title>���������</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<link rel="stylesheet" href="../css/css1.css" type="text/css" media="screen">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<script type="text/javascript">
			function exportToExcel() {
				if(confirm("ȷ������?")) {
					window.self.location = "../finComeExport";
				}
			}
		</script>
	</head>
	<body  topmargin=0>
		<form name="form1" id ="form1" method="post" action="fincome_manage.jsp?type=1">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				align="center" class=TableBorder>
				<tr height="22" valign="middle" align="center">
					<th height="25">
						���۵���
					</th>
					<th>
						�ͻ�����
					</th>
					<th>
						�տ�����
					</th>
					<th>
						¼������
					</th>
					<th>
						&nbsp;
					</th>
				</tr>
				<tr height="22" valign="middle" align="center"
					style="background-color: #F3F781">
					<td>
						<input name=vpid type="text" id="vpid" size="18" maxlength="50" value="">
					</td>
					<td>
						<input name=client type="text" id="client" size="20" maxlength="100" value="">
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
					<td>
						<input type="text" id ="startDpaytime"  name ="startDpaytime" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'startDpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">��
						<input type="text" id ="endDayTiem"  name ="endDayTiem" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'endDayTiem'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
					</td>
					<td>
					
						<input type="text" id ="startCreatetime"  name ="startCreatetime" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'startCreatetime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">��
						<input type="text" id ="endCreatetime"  name ="endCreatetime" size="15" value="">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'endCreatetime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
					</td>
					<td>
						<input type="submit" name="Submit" value="��ѯ">&nbsp;
						<input name="export" value="������Excel" type="button" onClick="exportToExcel();" />
					</td>
				</tr>
			</table>
		</form>
	<table width="130%" border="0" cellpadding="0" cellspacing="1" 
		align="center" >
		<tr height="22" valign="middle" align="center">
			<th height="25" colspan="27">
				�����嵥�������
			</th>
		</tr>
		<tr >
			<td ><input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()"></td>
			<td height="25" class=forumrow>
				<div align="center" >
					ID
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px ;">
					����
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 70px">
					�տ�����
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 150px">
					�ͻ�����
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 20px">
					���
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 15px">
					�·�
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					���۵���
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px">
					��������
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px">
					������Ա
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px">
					��ѧ
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					��ȫ
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width:60px">
					������
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					EMC��Ӫ
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width:60px">
					EMC����
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					��ͻ���
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					������
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center"  style="width: 60px">
					����
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 60px">
					���ݹ�˾
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 60px">
					С��
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					�˺�����
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					Ʊ������
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 80px">
					Ʊ�ݺ���
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 100px ;">
					��ע
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 60px">
					ʡ��
				</div>
			</td>
			<td class=forumrow align="center">
				<div align="center" style="width: 50px ;">
					����
				</div>
			</td>
			
		</tr>

		<%
			List<Fincome> list = pm.getList();
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					fincome = list.get(i);
		%>
		<tr >
			<td height="25">
					<input type="checkbox" name="selectFlag" class="checkbox1"
						value="<%=fincome.getId()%>">
				</td>
			<td height="25" align="center">
					<%=i%>
			</td>
			
			<td align="center">
					 <a href="editfincome.jsp?id=<%=fincome.getId()%>" style="color: blue">�޸�</a>
			</td>
			<td height="25" align="center">
					<%=fincome.getDpaytime()==null?"&nbsp;":fincome.getDpaytime()%></font>
			</td>
			<td align="center">
					<%=fincome.getClient() ==null?"&nbsp;":fincome.getClient()%>
			</td >
			<td align="center">
				<%=fincome.getVpyear() ==null?"&nbsp;":fincome.getVpyear()%>
			</td>
			<td align="center">
					<%=fincome.getVpmonth()==null?"&nbsp;":fincome.getVpmonth()%>
			</td>
			<td align="center">
					<%=fincome.getVpid()==null?"&nbsp;":fincome.getVpid()%>
			</td>
			<td align="center"> 
					<%=fincome.getDept()==" "?"&nbsp;":fincome.getDept()%>
			</td>
			<td align="center">
					<%=fincome.getSales()==null?"&nbsp;":fincome.getSales()%>
			</td>
			<td align="center">
					<%= fincome.getChem()!=null && fincome.getChem()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getChem()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getSafe()!=null && fincome.getSafe()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getSafe()):"&nbsp;"%>
			</td align="center">
			<td align="center">
					<%= fincome.getOp()!=null && fincome.getOp()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getOp()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getEmc()!=null && fincome.getEmc()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getEmc()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getDr()!=null && fincome.getDr()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getDr()):"&nbsp;"%>
			</td>
			<td>
				<div align="center">
					<%= fincome.getVip()!=null && fincome.getVip()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getVip()):"&nbsp;"%>
				</div>
			</td>
			<td align="center">
					<%= fincome.getEq()!=null && fincome.getEq()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getEq()):"&nbsp;&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getFinance()!=null && fincome.getFinance()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getFinance()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getGz()!=null && fincome.getGz()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getGz()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getTotal()!=null && fincome.getTotal()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getTotal()):"&nbsp;"%>
			</td>
			<td align="center">
					<%= fincome.getAccount()==null?"&nbsp;":fincome.getAccount()%>
			</td>
			<td align="center">
					<%= fincome.getEinvtype()==null?"&nbsp;": fincome.getEinvtype()%>
			</td>
			<td align="center">
					<%=fincome.getEinvno()==null?"&nbsp;":fincome.getEinvno()%>
			</td>
			<td align="center">
					<%=fincome.getRemarks()==null?"&nbsp;":fincome.getRemarks()%>
			</td>
			
			<td align="center">
					<%= fincome.getProvince()==null?"&nbsp;":fincome.getProvince()%>
			</td>
			<td align="center">
					<%=fincome.getCity()==null?"&nbsp;":fincome.getCity()%>
			</td>
			
		</tr>
		<%
		}
		}
		%>
		<tr style="background-color: #E0F8E0">
			<td height="25" colspan="27" align="left">
				<div align="center">
					��¼��������<%=pm.getTotalRecords()%>
					��ǰҳ/��ҳ��:<%=pm.getPageNo()%>/<%=pm.getTotalPages()%>
					<a
						href="fincome_manage.jsp?pageNo=1&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">��ҳ</a>
					<a
						href="fincome_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">��һҳ</a>
					<a
						href="fincome_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">��һҳ</a>
					<a
						href="fincome_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&vpid=<%=vpid%>&client=<%=client%>&startDpaytime=<%=startDpaytime%>&endDayTiem=<%=endDayTiem%>&startCreatetime=<%=startCreatetime%>&endCreatetime=<%=endCreatetime%>"
						class="red">ĩҳ</a>
				</div>
			</td>
		</tr>
	</table>
</body>