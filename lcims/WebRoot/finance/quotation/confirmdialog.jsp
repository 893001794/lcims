<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ include file="../../comman.jsp"  %>
	<%@ page errorPage="../error.jsp" %>
<%
	String command = request.getParameter("command");
	String keywords = request.getParameter("keywords");
	List temp =null;
	 Quotation qt =null;
	if(command == null || "".equals(command)) {
		 temp=new ArrayList();
		 qt =new Quotation(); 
	}else{
	//System.out.println(pid+"--------报价单长度：---------"+pid.length());
		if(keywords.equals("FCC")){
			 qt = (Quotation) session.getAttribute("qt");
			 keywords =qt.getPid();
			if(QuotationAction.getInstance().getQuotationByPid(qt.getPid()).getEconfrim().equals("未收到")){
				if(QuotationAction.getInstance().confirmQuotation(qt.getPid(),user.getName())) {
				}else{
				out.println("<script language='javascript'>alert('确认不成功，请返回重新确认！');window.close();</script>");
				}
			} else {
				out.println("<script language='javascript'>alert('此单已收到！');window.close();</script>");
				
			}
		}
		//System.out.println("keywords:"+keywords);
			temp = SearchFactory.getInstance().getQuotation(keywords);
			qt = QuotationAction.getInstance().getQuotationByPid(keywords);
			//System.out.println(temp.size()+"----"+qt);
			if (qt != null && temp.size()>0) {
				session.setAttribute("temp",temp);
				session.setAttribute("qt", qt);
			//	session.setMaxInactiveInterval(10);
			} else {
				//err = "无效流转单号!";
				out.println("<script language='javascript'>alert('报价单无效，请返回重新确认！');window.close();</script>");
			}
		
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
    }
  </script>
	</head>

	<body class="body1"> 
		<form name=form1  method=post action="confirmdialog.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr align="center">
					<td align=left valign=middle  align="center">
						输入条形码栏：
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="提交"/>
					</td>
					
				</tr>
			</table>


			<hr width="97%" align="center" size=0>
			
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getPid()==null?"":qt.getPid()%>" size="40" />
						</td>

						<td width="17%">
							分公司：						</td>
						<td width="33%">

							<input type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany()==null?"":qt.getCompany() %>" size="40" />
					  </td>

					</tr>
					<tr>
						
						<td>
							销售人员：
						</td>
						<td>
							<input name="rid" type="text" style="background-color: #F2F2F2"
								size="40" readonly="readonly" value="<%=qt.getSales()==null?"":qt.getSales()%>" />
						</td>
					
						<td>
							立项时间：
						</td>
						<td>
							<input type="text" style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCreatetime()) %>" />
						</td>
					</tr>
					<tr>
						
						<td>
							客户名称：
						</td>
						<td>
							<input style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getClient()==null?"":qt.getClient() %>" />
						</td>
						<td width="100">
								客户要求时间：
							</td>
							<td width="17%">
								<input style="background-color: #F2F2F2" size="40"
									readonly="readonly" value="<%=qt.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime()) %>" />
						  </td>
						
					</tr>
					<tr>
						<td>
							项目名称：
						</td>
						<td>
							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getProjectcontent()==null?"":qt.getProjectcontent()%>" />
						</td>
						<td><font color="red">状态：</font></td>
						<td><input type="text" size="40" style="color: red"
								readonly="readonly" value="<%=qt.getEconfrim()==null?"":qt.getEconfrim()%>" /></td>
					</tr>
				</table>
			</div>
			<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<%
						for(int j=0;j<temp.size();j++){
						Quotation qu =(Quotation)temp.get(j);
						String oldPid =qu.getOldPid();
						if(oldPid !=null && ! "".equals(oldPid)){
							String str="";
							String str1="";
							//统计应收金额
						float totalpay =qt.getInvcount();
						String quotype =qu.getQuotype();
						if(quotype.equals("flu") ){
						str="冲红";
						str1="-";
						totalpay=totalpay-qu.getInvcount();
						}
						if(quotype.equals("add") ){
						str="补充重测";
						totalpay=totalpay+qu.getInvcount();
						}if(quotype.equals("mod") ){
						str="修改报告";
						totalpay=totalpay+qu.getInvcount();
						}
						%>	
			 <tr>
				 	
						<td>关联<%=str %>报价单</td>
						<td>
						 <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=oldPid %>"/>
						 </td>
						<td>应收金额</td>
						<td><input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=totalpay==0?"0":new DecimalFormat("##,###,###,###.00").format(totalpay) %>"/></td>
						
					
				 </tr>	
				  <tr>
				 	
						<td><%=str %>金额</td>
						<td><input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=str1%><%=qu.getInvcount()==0?"0":new DecimalFormat("##,###,###,###.00").format(qu.getInvcount()) %>"/></td>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
					
				 </tr>	
				 <%
						}
						
						}
						 %>		
				<tr>
					<td width="17%">
						报价金额：					</td>
					<td width="33%">
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getTotalprice()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>"/>				  
				  </td>
				  <td width="17%">
						已收金额：					</td>
					<td width="33%">
					<%
						float totalpay = qt.getPreadvance() + qt.getSepay() + qt.getBalance();
					 %>
				  <input name="payprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=totalpay==0?"0":new DecimalFormat("##,###,###,###.00").format(totalpay) %>"/>				  
				  </td>
				 </tr>
				
				 <tr>
					<td width="17%">
						预估分包费：					
					</td>
					<td width="33%">
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getPresubcost()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getPresubcost()) %>"/>				  
				  </td>
				  <td width="17%">
						预估机构费：					</td>
					<td width="33%">
				  <input name="payprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getPreagcost()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getPreagcost()) %>"/>				  
				  </td>
				</tr>
				
				<tr>
					<td>开票总金额：					</td>
					<td>
						<input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvcount()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getInvcount()) %>"/>
					</td>
					<td width="17%">
						项目收款方式：					</td>
					<td width="33%">
				  		<input name="paytime" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getAdvancetype()==null?"":qt.getAdvancetype() %>"/>				  
				  	</td>
					
				</tr>
				<tr>
					<td width="17%">
						票据编号：					
					</td>
					<td width="33%">
					  <input name="invcode" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvcode()==null?"":qt.getInvcode() %>"/>
				  	</td>
				  <td>
						开发票方式：
					</td>
					<td>
						<input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvtype()==null?"":qt.getInvtype() %>"/>
					</td>
				</tr>
				<tr>
					<td width="17%">
						开票题头：					</td>
					<td width="33%">
					  <input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvhead()==null?"":qt.getInvhead() %>"/>
				  </td>
					<td width="17%">
						备注：					</td>
					<td width="33%">
					  <input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getTag()==null?"":qt.getTag() %>"/>
				  </td>
				</tr>
			</table>
			
				</div>
		</form>
	</body>
</html>
