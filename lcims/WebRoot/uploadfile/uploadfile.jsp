
<%@ page contentType="text/html;charset=GBK" pageEncoding="GBK"%>
<%
	request.setCharacterEncoding("GBK");
	 String systemId = request.getParameter("id");

%>

<html>
	<head>
		<title>��Ʊ����ϵͳ</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="../../style" rel="stylesheet" type="text/css">
		<script language="javascript" src=../check.js></script>

	</head>

	<body>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr align="center">
				<td>
					<h1>
						��ѡ����Ҫ�ϴ��ĸ���
					</h1>
				</td>
			</tr>
		</table>
		<form action="uploadProject_post.jsp" method="post" enctype="multipart/form-data" name="form1">
			<input name="icode" id ="icode" type="hidden" value="<%=systemId %>"/>
		<table width="70%" border="0" cellpadding="3" cellspacing="1"
			bgcolor="999999" align="center">

			<tr bgcolor="f1f1f1">
				<td>
					��Ӹ�����
				</td>
				<td valign="middle">
					
						<input name="file_data" type="file" id="file_data">
						&nbsp;&nbsp;
						<input type="submit" name="Submit"  value="�ϴ�" style="height: 20px;width: 50px">
					
				</td>
			</tr>
		</table>
	</body>

</html>
