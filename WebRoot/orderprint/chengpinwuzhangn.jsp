<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.kis.MoneyUtil"%>

<%
	request.setCharacterEncoding("UTF-8");
	String strid = request.getParameter("id");
	if (strid == null || "".equals(strid)) {
		response.sendRedirect("myorder.jsp");
		return;
	}
	int id = Integer.parseInt(strid);
	Order order = OrderAction.getInstance().getOrderById(id);
	
	String icode = "*"+order.getPid().substring(3,order.getPid().length())+"*";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>成品有章无标准价</title>
		<SCRIPT language=javascript>
var HKEY_Root,HKEY_Path,HKEY_Key; 
HKEY_Root="HKEY_CURRENT_USER"; 
HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"; 

//设置网页打印的页眉页脚和页边距
function PageSetup_Null() 
{ 
 try 
 { 
  var Wsh=new ActiveXObject("WScript.Shell"); 
  HKEY_Key="header"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="footer"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,""); 
  HKEY_Key="margin_bottom"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_left"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_right"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
  HKEY_Key="margin_top"; 
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0.3"); 
 } 
 catch(e){
    alert("不允许ActiveX控件");
 } 
} 

function printorder()
{
		PageSetup_Null();
		factory.execwb(6,6);
		window.close();
}

</script>
		<OBJECT id=factory height=0 width=0
			classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2></OBJECT>

		<style type="text/css">
.top {
	font-family: "黑体";
	font-size: 16px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	font-variant: normal;
	text-transform: capitalize;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}
.noPrint   { 
DISPLAY:   none 
}
.xl33
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:C39HrP24DmTt;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.topone {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: "宋体";
	font-size: 9pt;
	color: #000000;
	text-align: left;
	line-height: 16px;
}

.topline {
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #000000;
}

.weizi1 {
	font-family: "宋体";
	font-size: 12px;
	color: #000000;
	text-align: right;
}

.weizi2 {
	font-family: "宋体";
	font-size: 10px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	vertical-align: top;
	line-height: 10px;
}

.weizi3 {
	font-family: "宋体";
	font-size: 12px;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}

.weizi4 {
	font-family: "宋体";
	font-size: 12px;
	font-weight: bolder;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: top;
	line-height: 15px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}

.weizi5 {
	font-family: "宋体";
	font-size: 13px;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
	line-height: 20px;
}

.weizi6 {
	font-family: "宋体";
	font-size: 13px;
	font-weight: bolder;
	color: #000000;
	text-decoration: none;
	text-align: center;
	vertical-align: top;
	line-height: 20px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}

.weizi7 {
	font-family: "宋体";
	font-size: 10px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	vertical-align: middle;
	line-height: 10px;
}

.table {
	border-top-width: 1px;
	border-right-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-right-style: solid;
	border-left-style: solid;
	border-top-color: #000000;
	border-right-color: #000000;
	border-left-color: #000000;
}

.table_2 {
	text-align: center;
	font-size: 11px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #000000;
	border-bottom-color: #000000;
}

.table_3 {
	text-align: center;
	font-size: 10px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
}

.ren {
	text-decoration: none;
	font-family: "黑体";
	font-size: 15px;
	text-align: right;
}

.zi_1 {
	font-family: "宋体";
	font-size: 12px;
	color: #000000;
}

.zi_2 {
	font-family: "宋体";
	font-size: 11px;
	font-weight: bold;
	color: #000000;
	line-height: 30px;
}

.zi_3 {
	font-family: "宋体";
	font-size: 13px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	vertical-align: middle;
}

.zi_4 {
	font-family: "宋体";
	font-size: 13px;
	color: #000000;
	text-decoration: none;
	text-align: left;
	text-indent: 10px;
}

.ziti_1 {
	font-family: "宋体";
	font-size: 13px;
	font-weight: bold;
	color: #000000;
	line-height: 30px;
}

.ziti_2 {
	font-family: "宋体";
	font-size: 15px;
	font-weight: bold;
	color: #000000;
	line-height: 30px;
}

.ziti3 {
	font-family: "宋体";
	font-size: 12px;
	color: #000000;
	text-align: left;
}

.dibu {
	font-size: 14px;
	font-weight: bolder;
	border-bottom-color: #000000;
	border-bottom-style: solid;
	border-bottom-width: thin;
}

.STYLE3 {
	font-size: 12px;
	font-weight: bold;
}

.STYLE7 {
	font-size: 14px;
	font-weight: bold;
}

.STYLE8 {
	text-decoration: none;
	font-family: "宋体";
	font-size: 15px;
	text-align: right;
	font-weight: bold;
}

.STYLE9 {
	font-family: "黑体"
}

.end {
	font-size: 9px;
	font-weight: bold;
	font-family: "黑体";
}

.sp {
	text-indent: 2em;
}

.suojin1:first-letter {
	margin-left: -4em;
}

.suojin1 {
	width: 330px;
	padding-left: 40px;
}

.suojin2:first-letter {
	margin-left: -1em;
}

.suojin2 {
	width: 330px;
	padding-left: 40px;
}

.suojin3:first-letter {
	margin-left: -3em;
}

.suojin3 {
	width: 330px;
	padding-left: 30px;
}

.suojin4:first-letter {
	margin-left: -3em;
}

.suojin4 {
	width: 300px;
	padding-left: 30px;
}
.noPrint   { 
DISPLAY:   none 
}
</style>
	</head>

	<body onload="printorder();">
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="26%" height="80" class="topone" style="vertical-align: bottom;">
					<img src="../images/orderhead.jpg" width="181" height="55" />
				</td>
				<td width="45%" class="top">
					<p>
						&nbsp;
					</p>
					<p>
						<font style="font-size: 21px"><strong>报价单</strong><strong
							style="font-family: Arial, Helvetica, sans-serif">(Quotation)</strong>
						</font>
					</p>
				</td>
				<td width="29%" align="right" class="topone"><%=order.getCompany().getFullname()%>
					<br />
					电话
					<span class="weizi1">：</span><%=order.getCompany().getTel()%>        
					<br />
					传真
					<span class="weizi1">：</span><%=order.getCompany().getFax()%>     
					<br />
					地址
					<span class="weizi1">：</span><%=order.getCompany().getAddress().substring(0, 12)%>
					<br />
					<%=order.getCompany().getAddress().substring(12,
							order.getCompany().getAddress().length())%>
					<br />
					网址
					<span class="weizi1">：</span><%=order.getCompany().getUrl()%>
				</td>
			</tr>
			<tr>
				<td height="5" colspan="3"></td>
			</tr>
		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0"
			style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #000000;">
			<tr>
				<td height="20" class="weizi1">
					报价日期：
				</td>
				<td height="20" class="ziti3"><%=order.getQuotime() == null ? ""
					: new SimpleDateFormat("yyyy-MM-dd").format(order
							.getQuotime())%></td>
				<td height="20" class="weizi1">
					报价单号：
				</td>
				<td height="20">
				<%
				 //判断该报价单是否为绿色通道
				 String greenchannel=order.getGreenchannel();
				 String str="";
				 if(greenchannel !=null & !"".equals(greenchannel)){
				 str="★";
				 }
				 %>
					<strong style="font-size: 13px; font-family: '黑体'"><%=order.getPid()%><%=str %></strong>
				</td>
			</tr>
			<%
			if(order.getOldPid()!=null && !"".equals(order.getOldPid())){
					%>
					<tr style="display: block;" id ="trpid">
					
					
					<td height="20" class="weizi1">原报价单：</td>
    				<td height="20" class="ziti3"><%=order.getOldPid() %></td>
					<td>&nbsp;</td>
					<td>&nbsp;&nbsp;</td>
					</tr>
					<%
					}
				String[] salesnames = order.getSales().getName().split("\\[");
				String sn = salesnames[0];
				StringBuffer salesname = new StringBuffer();
				salesname.append(sn);
				if ("男".equals(order.getSales().getSex())) {
					salesname.append("先生");
				} else {
					salesname.append("小姐");
				}
			%>
			<tr>
				<td height="20" class="weizi1">
					联系人：
				</td>
				<td height="20" class="ziti3"><%=order.getClient().getContact().getContact()%></td>
				<td height="20" class="weizi1">
					销售代表：
				</td>
				<td height="20" class="ziti3"><%=salesname.toString()%></td>
			</tr>
			<tr>
				<td height="20" class="weizi1">
					公司名称：
				</td>
				<td height="20">
					<strong style="font-size: 13px; font-family: '黑体'"><%=order.getClient().getName()%></strong>
				</td>
				<td height="20" class="weizi1">
					联系电话：
				</td>
				<td height="20" class="ziti3"><%=order.getSales().getTel()%>&nbsp;<%=order.getSales().getPhone() %></td>
			</tr>
			<tr>
				<td height="20" class="weizi1">
					公司地址：
				</td>
				<td height="20" class="ziti3"><%=order.getClient().getAddr()%></td>
				<td height="20" class="weizi1">
					电子邮箱：
				</td>
				<td height="20" class="ziti3"><%=order.getSales().getEmail()%></td>
			</tr>
			<tr>
				<td height="20" class="weizi1">
					联系电话：
				</td>
				<td height="20" class="ziti3"><%=order.getClient().getContact().getTel()%></td>
				<td height="20" class="weizi1">
					客服代表：
				</td>
				<%
					String[] ss = order.getService().getName().split("\\[");
					String s = ss[0];
					StringBuffer servname = new StringBuffer();
					if (s.length() > 3) {
						servname.append(s.substring(0, 2));
					} else {
						servname.append(s.substring(0, 1));
					}
					if ("男".equals(order.getService().getSex())) {
						servname.append("先生");
					} else {
						servname.append("小姐");
					}
				%>
				<td height="20" class="ziti3"><%=servname.toString()%></td>
			</tr>
			<tr>
				<td height="20" class="weizi1">
					传真号码：
				</td>
				<td height="20" class="ziti3"><%=order.getClient().getContact().getFax()%></td>
				<td height="20" class="weizi1">
					直线电话：
				</td>
				<td height="20" class="ziti3"><%=order.getService().getTel()%></td>
			</tr>
			<tr>
				<td width="11%" height="20" class="weizi1">
					电子邮箱：
				</td>
				<td width="43%" height="20" class="ziti3"><%=order.getClient().getContact().getEmail()
							.toLowerCase()%></td>
				<td width="12%" height="20" class="weizi1">
					电子邮箱：
				</td>
				<td width="34%" height="20" class="ziti3"><%=order.getService().getEmail()%></td>
			</tr>

		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="50" colspan="3" class="weizi7"
					style="font-size: 12px; line-height: 18px">
					感激贵司对立创公司的信任与支持，对贵司提供的样品及测试申请予以以下报价，请确认以下项目及费用，并在客户确认处签名回传。为了不延误测试的进程，请尽快安排款项的支付，并将付款底单传真至<%=order.getCompany().getFax()%>。
				</td>
			</tr>
		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0" bordercolor="#000000" class="table">
			<tr>
				<td width="7%" height="15" class="weizi3">
					序号
				</td>
				<td width="15%" height="15" class="weizi3">
					样品名称
				</td>
				<td width="30%" height="15" class="weizi3">
					测试项目
				</td>
				<td width="14%" height="15" class="weizi3">
					优惠价(元)
				</td>
				<td width="7%" height="15" class="weizi3">
					数量
				</td>
				<td width="12%" height="15" class="weizi3">
					小计(元)
				</td>
				<td width="15%" height="15" class="weizi5">
					备注
				</td>
			</tr>
			<tr>
				<td height="15" class="weizi4">
					Item
				</td>
				<td height="15" class="weizi4">
					Sample Name
				</td>
				<td height="15" class="weizi4">
					Test Item
				</td>
				<td height="15" class="weizi4">
					Pre.Price
				</td>
				<td height="15" class="weizi4">
					Qty
				</td>
				<td height="15" class="weizi4">
					Subtotal
				</td>
				<td height="15" class="weizi6">
					Remark
				</td>
			</tr>
			<%
				for (int i = 0; i < 10; i++) {
					if (order.getQuoitems().size() > i) {
						QuoItem quoitem = order.getQuoitems().get(i);
						String saleprice="";
						String countSaleprice="";
						if(order.getQuotype().equals("flu")){
						saleprice="-"+new DecimalFormat("###,###,###.00").format(quoitem.getSaleprice());
						countSaleprice="-"+new DecimalFormat("###,###,###.00").format(quoitem.getCount()* quoitem.getSaleprice());
						}else{
						saleprice=new DecimalFormat("###,###,###.00").format(quoitem.getSaleprice());
						countSaleprice=new DecimalFormat("###,###,###.00").format(quoitem.getCount()* quoitem.getSaleprice());
						}
						
			%>
			<tr>
				<td height="20" class="table_2"><%=i + 1%></td>
				<td height="20" class="table_2"><%=quoitem.getSamplename()%></td>
				<td height="20" class="table_2"><%=quoitem.getItem().getName()%></td>
				<td height="20" class="table_2"><%=saleprice%></td>
				<td height="20" class="table_2"><%=quoitem.getCount()%></td>
				<td height="20" class="table_2"><%=countSaleprice%></td>
				<td height="20" class="table_3"><%=quoitem.getRemark() == null ? "" : quoitem.getRemark()%>&nbsp;
				</td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td height="20" class="table_2">
					&nbsp;
				</td>
				<td height="20" class="table_2">
					&nbsp;
				</td>
				<td height="20" class="table_2">
					&nbsp;
				</td>
				<td height="20" class="table_2">
					&nbsp;
				</td>
				<td height="20" class="table_2">
					&nbsp;
				</td>
				<td height="20" class="table_2">
					&nbsp;
				</td>
				<td height="20" class="table_3">
					&nbsp;
				</td>
			</tr>
			<%
				}
				}
			%>
		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0"
			style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #000000;">
			<tr>
				<td width="72%" height="30">
				<%
				if(!order.getQuotype().equals("flu")){
				%>
				<div align="right">
						<span class="dibu">总计(Total)：人民币&nbsp;<%=MoneyUtil.toChinese(order.getTotalprice() + "")+ "整"%></span>
					</div>
				</td>
				<td width="28%">
					<div align="center">
						<span class="dibu">RMB:<%=new DecimalFormat("###,###,###.00").format(order.getTotalprice())%></span>
					</div>
				<%
				}else{
				%>
				<div align="right">
						<span class="dibu">&nbsp;&nbsp;</span>
					</div>
				</td>
				<td width="28%">
					<div align="center">
						<span class="dibu">-RMB:<%=new DecimalFormat("###,###,###.00").format(order.getTotalprice())%></span>
					</div>
				<%
				}
				 %>
					
				</td>
			</tr>
		</table>

		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr height="150">
				<td width="47%" height="150" class="weizi2">
					<br>

					<p>
						<span class="suojin1">说明：1.测试周期：&nbsp;<strong
							style="font-size: 14px; font-weight: bolder;"><%=order.getCircle()%></strong>&nbsp;个工作天，此周期自收齐样品、样品资料及相应款项之日起，至取得测试报告之日止，因样品资料不齐、样品整改、付款不及时等原因导致的拖延时间不计算在内</span>
						<br />
						<span class="suojin2">2.此报价有效期为一个月，一经确认不可撤消</span>
						<br />
						<span class="suojin2">3.样品需求：<%=order.getProduct()%></span>
						<br />
						<span class="suojin2">&nbsp;&nbsp;样品资料：<%=order.getProductsample()%></span>
						<br />
						<span class="suojin2">4.样品最长保留时间为报告签发后30天，如因特殊情况中途中止申请测试，申请方应结清已发生的所有测试费用</span>
						<br />
						<br />
						<span class="suojin3">备注：根据国际电工委员会IEC62331方法进行检测，并出具RoHS结论性报告；对产品所有单一均一不同物料进行XRF扫描(Cd,Pb,Hg,Br,Cr),对于下表中所列出的X及F部分进行化学确认测试，此部分的化学测试费用已经包含在上表的报价内</span>
						<br />
						<img src="../images/table.jpg" width="350" height="100" />
					</p>
				</td>
				<td width="10%">
					&nbsp;
				</td>
				<td width="43%" height="230" class="weizi2">
					<br>
					<p>
						<span class="suojin4">查询：报告进度、款项及发票情况请向我司客服部查询所有测试均依照测试通用条款进行,如需查阅,请向我司索取相关副本</span>
						<br />
						<br />
						<span class="suojin4">付款：请在款项支付后，将汇款底单传真给我司，并在底单上注明此报价单右上角的报价单号。以个人名义付款的请汇入我司快速付款通道并注明付款公司名称及需开票公司抬头,以便我司可把报告和发票及时寄出</span>
					</p>
					<strong class="ziti_2">汇款信息如下：</strong>
					<br />
					<strong class="ziti_1"> 名称：<%=order.getBank().getAccount()%></strong>
					<br />
					<strong class="ziti_1">账号：<%=order.getBank().getCreditcard()%></strong>
					<br />
					<strong class="ziti_1">银行：<%=order.getBank().getAddress()%></strong>
					<br /><br /><br />
					<strong style="font-size: 28px; font-family: 'C39HrP24DmTt'"><font class="noPrint">8</font><%=icode%></strong>
					
				</td>
			</tr>
		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0" class="topone">
			<tr>
				<td height="30" valign="bottom">
					<p>
						★特殊说明<%=order.getDetail()%></p>
				</td>
			</tr>
		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>

		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0">

			
			<tr style="text-align:left;">
				<td height="20" style="text-align: right;">
					&nbsp;
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					销售代表(Com.Traveller)
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					部门经理(Dep.Manager)
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					<p>
						客户确认(CustomerComfirm)
					</p>
				</td>
			</tr>
			<tr>
				<td height="20">
					&nbsp;
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					<p>
						销售确认(SalesComfirm)
					</p>
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					签名及印章(Sign&amp;Seal)
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					签名及公司印章(Sign&amp;Seal)
				</td>
			</tr>
			<tr>
				<td height="20">
					&nbsp;
				</td>
				<td height="20">
					&nbsp;
				</td>
				<td height="20">
					&nbsp;
				</td>
				<td height="20">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td height="20">
					&nbsp;
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					_______<%=sn%>_________
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					_______________________
				</td>
				<td height="20" class="zi_3" style="text-align: right;">
					_______________________
				</td>
			</tr>
			<tr>
				<td height="20">
					&nbsp;
				</td>
				<td height="20" class="zi_3" style="text-align: center;">
					日期(Date):
				</td>
				<td height="20" class="zi_3" style="text-align: center;">
					日期(Date):
				</td>
				<td height="20" class="zi_3" style="text-align: center;">
					日期(Date):
				</td>
				<tr>
			    <td height="30" class="zi_3" style="text-align: center;">&nbsp;</td>
			  </tr>
		
		</table>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0" class="topline">
			<tr>
				<td height="15" align="center"
					style="font-size: 11px; font-weight: bold;">
					Let Me Confirm . Let You Confide .&nbsp;&nbsp;&nbsp; 客观公正 . 科学严谨 . 准确高效 . 服务真诚
				</td>
			</tr>
			<tr>
		    <td height="15" align="center" style="font-size:11px; font-weight:bold;">响应我司环保政策，从2010年8月1号起，我司只打印正本报告一份，提供副本报告一份！
			 </td>
		  </tr>
		</table>
	</body>
</html>
