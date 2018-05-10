<%@page import="javax.mail.Flags.Flag"%>
<%@page import="com.lccert.crm.quotation.Cashier"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.chemistry.email.MonthAdd"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.chemistry.util.AddDate"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%
	request.setCharacterEncoding("GBK");
	boolean flag1 =true;
	String pidStr = request.getParameter("pid").trim();
	if(pidStr.split(",").length<=0){
	out.println("添加失败，请返回重新输入！");
	out.println("<br><a href='javascript:window.history.back();'>返回</a>");
	return;
	}
	String [] pidLenght=pidStr.split(",");
	String pid1=pidLenght[0];
	String pageNo = request.getParameter("pageNo");
	String strtotalprice = request.getParameter("totalprice").trim();
	float totalprice = 0;
	if(!("".equals(strtotalprice) || strtotalprice == null)) {
		totalprice = Float.parseFloat(strtotalprice);
	}
	String strpaytime = request.getParameter("paytime").trim();
	Date paytime = null;
	if(!(strpaytime == null || "".equals(strpaytime))) {
		paytime = new SimpleDateFormat("yyy-MM-dd").parse(strpaytime);
	}
	String creditcard = request.getParameter("creditcard").trim();
	String paynotes = request.getParameter("paynotes").trim();
	System.out.println("99999:"+paynotes);
	//获取备注的内容
	String collRemarks=request.getParameter("collRemarks").trim();
	//票据方式
	String invtype=request.getParameter("invtype").trim();
	
	String strsepay = request.getParameter("sepay").trim();
	float sepay = 0;
	if(!("".equals(strsepay) || strsepay == null)) {
		sepay = Float.parseFloat(strsepay);
	}
	String sepayacount = request.getParameter("sepayacount").trim();
	String strsepaytime = request.getParameter("sepaytime").trim();
	Date sepaytime = null;
	if(!(strsepaytime == null || "".equals(strsepaytime))) {
		sepaytime = new SimpleDateFormat("yyy-MM-dd").parse(strsepaytime);
	}
	String sepaynotes = request.getParameter("sepaynotes").trim();
	String strprebalance = request.getParameter("prebalance").trim();
	float prebalance = 0;
	if(!("".equals(strprebalance) || strprebalance == null)) {
		prebalance = Float.parseFloat(strprebalance);
	}
	String strbalance = request.getParameter("balance").trim();
	float balance = 0;
	if(!("".equals(strbalance) || strbalance == null)) {
		balance = Float.parseFloat(strbalance);
	}
	String balanceacount = request.getParameter("balanceacount").trim();
	String strbalancetime = request.getParameter("balancetime").trim();
	Date balancetime = null;
	if(!(strbalancetime == null || "".equals(strbalancetime))) {
		balancetime = new SimpleDateFormat("yyy-MM-dd").parse(strbalancetime);
	}
	String balancenotes = request.getParameter("balancenotes").trim();
	String strrefund = request.getParameter("refund").trim();
	float refund = 0;
	if(!("".equals(strrefund) || strrefund == null)) {
		refund = Float.parseFloat(strrefund);
	}
	String refunddesc = request.getParameter("refunddesc").trim();
	String strprespefund = request.getParameter("prespefund").trim();
	float prespefund = 0;
	if(!("".equals(strprespefund) || strprespefund == null)) {
		prespefund = Float.parseFloat(strprespefund);
	}
	String client=request.getParameter("client");
	String strspefund = request.getParameter("spefund").trim();
	float spefund = 0;
	if(!("".equals(strspefund) || strspefund == null)) {
		spefund = Float.parseFloat(strspefund);
	}
	String spefundtype = request.getParameter("spefundtype").trim();
	String strspefundtime = request.getParameter("spefundtime").trim();
	Date spefundtime = null;
	if(!(strspefundtime == null || "".equals(strspefundtime))) {
		spefundtime = new SimpleDateFormat("yyy-MM-dd").parse(strspefundtime);
	}
	String spefunddesc = request.getParameter("spefunddesc").trim();
	String strinvprice = request.getParameter("invprice").trim();
	float invprice = 0;
	if(!("".equals(strinvprice) || strinvprice == null)) {
		invprice = Float.parseFloat(strinvprice);
	}
	String invcode = request.getParameter("invcode").trim();
	String badDebt=request.getParameter("badDebt").trim();
	String strinvtime = request.getParameter("invtime").trim();
	Date invtime = null;
	if(!(strinvtime == null || "".equals(strinvtime))) {
		invtime = new SimpleDateFormat("yyy-MM-dd").parse(strinvtime);
	}
	String stracount = request.getParameter("acount").trim();
	float acount = 0;
	if(!("".equals(stracount) || stracount == null)) {
		acount = Float.parseFloat(stracount);
	}
	String strtax = request.getParameter("tax").trim();
	
	float tax = 0;
	if(!("".equals(strtax) || strtax == null)) {
		tax = Float.parseFloat(strtax);
	}
	String pidStr1="";
	for(String value:pidStr.split(",")){
		pidStr1+=value+"/,";
		float preadvance = 0;
		//根据pid查询totalprice
		//System.out.println(value);
		Quotation q=QuotationAction.getInstance().getQuotationByPid(value);
		String strpreadvance = request.getParameter("preadvance").trim();
		//System.out.println(pidStr.split(",").length);
		if(pidStr.split(",").length>1){
			if(!("".equals(strpreadvance) || strpreadvance == null)) {
				preadvance =q.getTotalprice();
				
			}
			//System.out.println(preadvance);
		}else{
				preadvance = Float.parseFloat(strpreadvance);
		}
	float sum=0f;
	float advarceProfit=preadvance ; //预收款减去税金
	float sepayProfit=sepay ; //二次收款减去税金
	float balanceProfit=prebalance ; //尾次收款减去税金
	float sunProfit =0f;  //业绩统计
			if(preadvance!=0 && ("发票".equals(paynotes)||"专用发票".equals(paynotes)||"普通发票".equals(paynotes))){
				sum +=preadvance*0.08;
				advarceProfit=preadvance-preadvance*0.08f;
			}
			if(sepay!=0 && ("发票".equals(sepaynotes)||"专用发票".equals(sepaynotes)||"普通发票".equals(sepaynotes))){
				sum +=sepay*0.08;
				sepayProfit=sepay-sepay*0.08f;
			}
			if(prebalance!=0 &&("发票".equals(balancenotes)||"专用发票".equals(balancenotes)||"普通发票".equals(balancenotes))){
				sum +=prebalance*0.08;
				balanceProfit=prebalance-prebalance*0.08f;
			}
			tax=sum;
	String tag = request.getParameter("tag");
	
	String strothercost = request.getParameter("othercost").trim();
	float othercost = 0;
	if(!("".equals(strothercost) || strothercost == null)) {
		othercost = Float.parseFloat(strothercost);
	}
	String paystatus = "n";
	//-----------------------------2013-02-22---------------------
		if(totalprice != 0 && (preadvance + sepay + balance) >= totalprice) {
			paystatus = "y";
		}
		//***************************2011-09-29-------------------------------------------
		//判断是否已收完款
		
		float arrears=totalprice-(preadvance+sepay+balance);
		Date benchmark =null;
		//查询该客户是什么时候建立的
		ClientForm cf =ClientAction.getInstance().getClientByName(client);
		//欠款金额小于10
		if(arrears <10){
			if(cf.getDperformance() ==null){
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
				Date d1 =cf.getCreatetime();
				String date="2011-10-07";
				Date d2=df.parse(date);
				//判断该客户以前是否有做过单的
				int count =QuotationAction.getInstance().getClientByName(cf.getName());
				//如果该客户在2011-10-07之后,或者以前创建了可以单没有做过单的创建的就可以计算业绩
				System.out.println(d1);
				System.out.println(d2);
				System.out.println(count);
				if(d1.after(d2)||count==0){
					if(balancetime !=null && balance>0){
					benchmark=balancetime;
					}else  if(sepaytime !=null && sepay>0){
					benchmark=sepaytime;
					}else{
					benchmark=paytime;
					}
				}
			}
		}
		float advarceFactor=1.3f;  //预收款的系数
		float sepayFactor=1.3f;  //第二次收款的系数
		float balanceFactor=1.3f;  //尾次收款的系数
			if(cf.getDperformance() !=null){
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
				Date d1 =cf.getCreatetime();
				//String date="2011-10-07";
				//Date d2=df.parse(date);
				//如果该客户在2011-09-28之后创建的就可以计算业绩
				if(paytime !=null && preadvance>0){
					if(paytime.before(cf.getDperformance())){
						advarceFactor=1.3f;
					}
					if(paytime.after(cf.getDperformance())){
					advarceFactor=0.8f;
					}
				}
				if(sepaytime !=null && sepay>0){
					if(sepaytime.before(cf.getDperformance())){
							sepayFactor=1.3f;
				}
					if(sepaytime.after(cf.getDperformance())){
							sepayFactor=0.8f;
				}
			}
			if(balancetime !=null && balance>0){
					if(balancetime.before(cf.getDperformance())){
						balanceFactor=1.3f;
					}
					if(balancetime.after(cf.getDperformance())){
						balanceFactor=0.8f;
					}
				}
			}
			//System.out.println("第一次收款："+advarceFactor);
			//System.out.println("第二次收款："+sepayFactor);
			//System.out.println("第三次收款："+balanceFactor);
		sunProfit=advarceProfit*advarceFactor+sepayProfit*sepayFactor+balanceProfit*balanceFactor;
		//如果基准时间不为空的情况下就在客户第一次付清第一笔账款（1、2、3）次得时间+360=基准时间
		if(benchmark !=null){
			//在基准时间+365天
		benchmark =new AddDate().addDate(benchmark, 365L); 
			//更改时间
		boolean flag =ClientAction.getInstance().modifyBenchmark(client,benchmark);
		}
			//***************************2011-09-29-------------------------------------------
			//***************************2011-12-06-------------------------------------------
		float deductions=1f;//月结客户的计算追款抵扣系数
		float channel=1f;//月结客户的通道系数
		String pid =value;
		//Quotation q=QuotationAction.getInstance().getQuotationByPid(pid);
		//当此客户的付款方式等于"月结"的时候
		System.out.println("结束方式："+cf.getPay());
		if(cf.getPay() !=null && cf.getPay().equals("月结")){
		//获取报价单完成的时间
		Date finishDate=q.getFinish();
		//System.out.println(finishDate);
		if(finishDate !=null){
		   Date  oneMonth=new MonthAdd().getDate(finishDate,1);
		   Date  towMonth=new MonthAdd().getDate(finishDate,2);
		   Date  towMonth1= new MonthAdd().getNextMonthFirst(finishDate,2);
		   Date  threeMonth=new MonthAdd().getDate(finishDate,3);
		   Date  threeMonth1= new MonthAdd().getNextMonthFirst(finishDate,3);
		   Date  fourMonth=new MonthAdd().getDate(finishDate,4);
		   Date  fourMonth1= new MonthAdd().getNextMonthFirst(finishDate,4);
		   Date  fiveMonth=new MonthAdd().getDate(finishDate,5);
		   Date  fiveMonth1= new MonthAdd().getNextMonthFirst(finishDate,5);
		   Date  sixMonth=new MonthAdd().getDate(finishDate,6);
		   Date  sixMonth1= new MonthAdd().getNextMonthFirst(finishDate,6);
		  // Date  sevenMonth=new MonthAdd().getDate(finishDate,7);
		  // Date  eightMonth=new MonthAdd().getDate(finishDate,8);
		   //在报告出了1-2个月(不包括2个月)，还没有付清款
		   //System.out.println(oneMonth.getTime()+"----");
		  // System.out.println(paytime+"----");
		 //  System.out.println(towMonth.getTime()+"----");
		   if(oneMonth.getTime()<paytime.getTime()&&paytime.getTime()<towMonth.getTime()){
		   		deductions=0.8f;
		   }
		    //在报告出了2-3个月(不包括3个月)，还没有付清款
		   else if(towMonth.getTime()<paytime.getTime()&&paytime.getTime()<threeMonth.getTime()){
		   	deductions=0.7f;
		   }
		    //在报告出了3-4个月(不包括4个月)，还没有付清款
		   else if(threeMonth.getTime()<paytime.getTime()&&paytime.getTime()<fourMonth.getTime()){
		   	deductions=0.6f;
		   }
		    //在报告出了4-5个月(不包括5个月)，还没有付清款
		   else if(fourMonth.getTime()<paytime.getTime()&&paytime.getTime()<fiveMonth.getTime()){
		   	deductions=0.5f;
		   }
		    //在报告出了5-6个月(不包括6个月)，还没有付清款
		   else if(fiveMonth.getTime()<paytime.getTime()&&paytime.getTime()<sixMonth.getTime()){
		   	deductions=0.4f;
		   }
		   //else{
		  // deductions=1f;
		  // }
		}
		}
		//System.out.println("追单抵扣系数："+deductions);
		//System.out.println("是否为绿色通道："+q.getGreenchannel());
		//绿色通道中含有(特急或加急的系数)
		int orderId =OrderAction.getInstance().getOrderByPid(pid);
		Order order = OrderAction.getInstance().getOrderById(orderId);
		System.out.println(order);
		List<QuoItem> quoitems = order.getQuoitems();
		for(int i=0;i<quoitems.size();i++){
			QuoItem quoitem = quoitems.get(i);
			String itemName=quoitem.getItem().getItemNumber();
			//报价单中包含加急或特急
			//System.out.println(itemName);
			if(q.getGreenchannel()!=null&&!q.getGreenchannel().equals("")&&(itemName.equals("24.04.01")||itemName.equals("24.04.02"))){
				channel=0.5f;
			}
		}
			//System.out.println("绿色通道系数："+channel);
		//***************************2011-12-06-------------------------------------------
		Quotation qt = new Quotation();
		qt.setPid(pid);
		qt.setPreadvance(preadvance);
		qt.setPaytime(paytime);
		qt.setCreditcard(creditcard);
		qt.setPaynotes(paynotes);
		qt.setSepay(sepay);
		qt.setSepayacount(sepayacount);
		qt.setSepaytime(sepaytime);
		qt.setSepaynotes(sepaynotes);
		qt.setPrebalance(prebalance);
		qt.setBalance(balance);
		qt.setBalanceacount(balanceacount);
		qt.setBalancetime(balancetime);
		qt.setBalancenotes(balancenotes);
		qt.setRefund(refund);
		qt.setRefunddesc(refunddesc);
		qt.setPrespefund(prespefund);
		qt.setSpefund(spefund);
		qt.setSpefundtype(spefundtype);
		qt.setSpefundtime(spefundtime);
		qt.setSpefunddesc(spefunddesc);
		qt.setInvprice(invprice);
		qt.setInvcode(invcode);
		qt.setInvtime(invtime);
		qt.setAcount(acount);
		qt.setTax(tax);
		qt.setTag(tag);
		qt.setOthercost(othercost);
		//System.out.println("其他费用："+othercost);
		qt.setPaystatus(paystatus);
		qt.setCollRemarks(collRemarks);
		qt.setAdvarceFactor(advarceFactor);
		qt.setSepayFactor(sepayFactor);
		qt.setBalanceFactor(balanceFactor);
		qt.setDeductions(deductions);
		qt.setChannel(channel);
		qt.setInvtype(invtype);
		qt.setBadDebt(badDebt);
		
		//FinanceQuotationAction.getInstance().updateQuotation(qt);
		if(!FinanceQuotationAction.getInstance().updateQuotation(qt)) {
		//	out.println("添加成功");
			flag1=false;
		//	return;
		//} else {
			out.println("添加失败，请返回重新输入！");
			out.println("<br><a href='javascript:window.history.back();'>返回</a>");
			//return;
		}
		//subtotal+=totalprice;
  }
		if(flag1==true) {
			out.println("添加成功");
			response.sendRedirect("quotationlog.jsp?type=1&pid=" +pidStr1+"&pageNo="+pageNo);
		}
%>