<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("GBK");
	String itemNumber=request.getParameter("itemNumber");
	String status=request.getParameter("status");
	//��ȡ״̬
	String status1=request.getParameter("status1");
	String strStatus ="";
	if(status1 == null || status1.equals("1")){
	strStatus="�ܽ��";
	}if(status1!=null && status1.equals("2")){
	strStatus="δ�ս��";
	}if(status1!=null && status1.equals("3")){
	strStatus="ӯ�����";
	}
	String year=request.getParameter("year");
	String month=request.getParameter("month");
	String last=request.getParameter("last");
	int a=0;
	if(month!=null && !"".equals(month)){
	a=Integer.parseInt(month);
	if(a<10){
	month="0"+a;
	}
	}
	//String pidKey =pid+month;
	
	//System.out.println(month+":month");
	List list=null;
	if(status !=null && status.equals("onlyItem")){
	 list=QuotationAction.getInstance().getMonTotalInfor(itemNumber,year,month,last);	
	}else if(status !=null && status.equals("allItem")){
	list=QuotationAction.getInstance().getMonAllItemInfor(year,month,last);
	}
	
	if(list ==null){
	list =new ArrayList();
	}
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>��Ŀ����</title>
		<link rel="stylesheet" href="../../css/drp.css">
		
	</head>

	<body  >
	<br><br><br>
			<table width="100%" border="1" align="center">
				<tr>
					<td class="rd6">
						���۵���
					</td>
					<td class="rd6">
						��Ŀ����
					</td>
					<td class="rd6">
						��Ŀ����
					</td>
					<td class="rd6">
						��������
					</td>
					<td class="rd6">
						<%=strStatus %>
					</td>
				</tr>
				<%for(int i=0;i<list.size();i++){
				%>
				<tr>
				<%
				String quotype="";
				List temp =(List)list.get(i);
				if(temp.get(3).equals("add")){
				quotype="�����زⱨ�۵�";
				}
				if(temp.get(3).equals("new")){
				quotype="�±��۵�";
				}
				if(temp.get(3).equals("mod")){
				quotype="�޸ı��汨�۵�";
				}
				if(temp.get(3).equals("flu")){
				quotype="��챨�۵�";
				}
				%>
				
					<td><%=temp.get(0).toString() %></td>
					<td><%=temp.get(1).toString() %></td>
					<td><%=temp.get(2).toString() %></td>
					<td><%=quotype%></td>
					<%
						if(status1 == null || "".equals(status1)){
						%>
						<td align="right"><%=Math.round(Float.parseFloat(temp.get(4).toString()))%></td>
						<%
						}if(status1!=null && status1.equals("1")){
						%>
						<td align="right"><%=Math.round(Float.parseFloat(temp.get(4).toString()))%></td>
						
						<%
						}if(status1!=null && status1.equals("2")){
						%>
						<td align="right"><%=Math.round(Float.parseFloat(temp.get(5).toString()))%></td>
						<%
						}if(status1!=null && status1.equals("3")){
						
						%>
						<td align="right"><%=Math.round(Float.parseFloat(temp.get(6).toString()))%></td>
						<%
						}
					 %>
					
					
				</tr>
				<%
				} %>

				
			</table>
			<table width="100%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						
					</td>
					
				</tr>
			</table>

		</form>
		<div align="center">
							<input name="btnAdd" type="button" class="button1" id="btnAdd"
								value="�ر�" onClick="window.close();"
>
						</div>
	</body>
</html>
