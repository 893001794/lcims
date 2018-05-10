<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>报价单管理</title>
		<link rel="stylesheet" href="../../css/drp.css">

		<script language="javascript">
		
		function goBack() {
		window.self.location="project_manage.jsp";
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("addappform").value += temp;
			document.getElementById("addappform").value += "\n";
		}
		function addInorganic(temp0) {
			document.getElementById("inorganic").value += temp;
			document.getElementById("inorganic").value += "\n";
		}
		function addInorganicDetail(temp1) {
			document.getElementById("inorganicdetail").value += temp1;
			document.getElementById("inorganicdetail").value += "\n";
		}
		function addOrganic(temp2) {
			document.getElementById("organic").value += temp2;
			document.getElementById("organic").value += "\n";
		}
		function addOrganicDetail(temp3) {
			document.getElementById("organicdetail").value += temp3;
			document.getElementById("organicdetail").value += "\n";
		}
		function addfood(temp4) {
			document.getElementById("food").value += temp4;
			document.getElementById("food").value += "\n";
		}
	</script>

	</head>

	<body class="body1">
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
					<b>&gt;&gt;财务管理&gt;&gt;分项目报价</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
<%--
		<form name=search method=post action=addflow.jsp>

			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<font color="red">请输入完整报价单号：</font>
						<input type=text name=pid size="25" value=>

						<input type=submit name=Submit value=搜索>
					</td>
				</tr>
			</table>
		</form>
	--%>	
		<hr width="97%" align="center" size=0>
		<form name="form1">
			<table cellpadding="5" cellspacing="0" style="margin-left: 10em">
				<tr>
					<td>
						报价单编号：
					</td>
					<td>
						<input name="pid" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="lc0001" />
					</td>

					<td>
						分公司：
					</td>
					<td>
						
						<input type="text"  style="background-color: #F2F2F2"
							readonly="readonly" value="中山" />
					</td>

				</tr>
				<tr>
				<td>
						项目报告编号：
					</td>
					<td>
						<input style="background-color: #F2F2F2"
							readonly="readonly" value="lce09090920" />
					</td>
					<td>
						应完成时间：
					</td>
					<td>
						<input style="background-color: #F2F2F2"
							readonly="readonly" value="2009-12-09 15:30" />
					</td>

				</tr>
				<tr>
					<td>
						项目等级：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="普通" />
					</td>
					<td>
						销售人员：
					</td>
					<td>
						<input name="rid" type="text" style="background-color: #F2F2F2"
							readonly="readonly" value="sales" />
					</td>
				</tr>
				<tr>
					<td>
						客服人员：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="eason" />
					</td>
					<td>
						项目类型：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="化学检测" />
					</td>
				</tr>
				<tr>
					<td>
						立项人员：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="eason" />
					</td>
					<td>
						立项时间：
					</td>
					<td>
						<input type="text" style="background-color: #F2F2F2"
							readonly="readonly"
							value="2009-12-06 10:23" />
					</td>
				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">
			
				<tr>
					<td>
						客户名称：
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="中山市立创检测有限公司" />
					</td>

				</tr>

				<tr>
					<td>
						测试内容：
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="ROHS" />
					</td>

				</tr>
			</table>
			<table cellpadding="5" cellspacing="5" style="margin-left: 10em">



				<tr>
					<td>
						分项目金额：
					</td>
					<td>
						<input name="totalprice" type="text" />
					</td>
					<td>
						分包费预计：
					</td>
					<td>
						<input name="paytime" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						内部分包费预计：
					</td>
					<td>
						<input name="preadvance" type="text" />
					</td>
					<td>
						机构费用预计：
					</td>
					<td>
						<input name="repaytime" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						其他费用预计：
					</td>
					<td>
						<input name="repaytime" type="text" />
					</td>
					<td>
						开发票方式：
					</td>
					<td>
						<select>
							<option>请选择</option>
							<option>不开</option>
							<option>全额</option>
							<option>不含机构费用</option>
							
						</select>
					</td>
				</tr>
				<tr>
					<td>
						发票标题：
					</td>
					<td>
						<input name="preadvance" type="text" />
					</td>
					<td>
						发票内容：
					</td>
					<td>
						<input name="repaytime" type="text" />
					</td>
				</tr>
				
			</table>

			


			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit" id="btnAdd"
					value="添加">
				&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onclick="goBack()" />
			</div>
		</form>
	</body>
</html>
