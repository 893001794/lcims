package com.lccert.crm.chemistry.email;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import com.lccert.crm.chemistry.lab.LabAction;
import com.lccert.crm.chemistry.util.TimeTest;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.vo.Statistics;
/***
 * 每周六给总经理发送的统计报表数据
 * @author LC
 *
 */
public class StatisticsTask extends TimerTask {
	private InetAddress addr;
	String ip=null;
	@Override
	public void run() {
		try{
			addr = InetAddress.getLocalHost();
			ip = addr.getHostAddress();//获得本机IP
	} catch (UnknownHostException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//电脑ip为192.168.0.10不发送
	if(!ip.equals("10.11.1.222")){
		sedStatistics();
	}
	else{
		sedStatisticsD();
	}
		

	}
	
	private void sedStatisticsD(){
		List<String> to = new ArrayList<String>();
		//记得开来他
//		to.add("luozh@lccert.com");
//		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
//		to.add("tangzp@lccert.com");
//获取本周的第一天
		TimeTest tt =new TimeTest();
		String WStart=tt.getMondayOFWeek();
		//获取本周的最后一天
		String WEnd=tt.getCurrentWeekday();
		//获取本月的第一天
		String MStart=tt.getFirstDayOfMonth();
		//获取本月的最后一天
		String MEnd=tt.getDefaultDay();
		String str="";
		to.add("service@lccert.com");
		List list =QuotationAction.getInstance().Statistics5(); //获取统计报表的信息
//		to.add("kittyyu@lccert.com");
		String head = "[周("+WStart+"至"+WEnd+")/月("+MStart+"至"+MEnd+")的统计报表]";
		StringBuffer content = new StringBuffer("下面表格是统计周("+WStart+"至"+WEnd+")/月("+MStart+"至"+MEnd+"的数据信息：<br>");
		content.append("<style type='text/css'>");
		content.append("table {border-collapse: collapse;}");
		content.append("td {border: solid 1pt #0066CC;}");
		content.append("</style>");
		content.append("<table width=100% align=center>");
		content.append("<tr>");
		content.append("<td>");
		content.append("部门");
		content.append("</td>");
		content.append("<td>");
		content.append("周订单额");
		content.append("</td>");
		content.append("<td>");
		content.append("周收历史款");
		content.append("</td>");
		content.append("<td>");
		content.append("周收当月款");
		content.append("</td>");
		content.append("<td>");
		content.append("周预分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("周实分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("周预机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("周实机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("月订单额");
		content.append("</td>");
		content.append("<td>");
		content.append("月收历史款(真实)");
		content.append("</td>");
		content.append("<td>");
		content.append("月收当月款(真实)");
		content.append("</td>");
		content.append("<td>");
		content.append("月预分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("月实分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("月预机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("月实机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("历史欠款");
		content.append("</td>");
		content.append("<td>");
		content.append("已签单未收款");
		content.append("</td>");
		content.append("</tr>");
		Statistics st=null;
		for(int i=0;i<list.size();i++){
			//东莞的服务器则显示环境部
			if(i==4){
				str="环境";
				st =(Statistics)list.get(i);
				 content.append("<tr>");
					content.append("<td>");
					content.append(str);
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWTotalpric());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWHPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWPresubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWSubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWPreagcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWAgcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMTotalpric());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMHPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMPresubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMSubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMPreagcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMAgcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMHistoryPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMConfirmNotPay());
					content.append("</td>");
					content.append("</tr>");
			}
		}
			content.append("</table>");
			content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
			content.append("<br>如有疑问，请联系系统管理员。");
			content.append("<br><br>立创检测<br>日期:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			new EmailConfigure().send(to, head, content.toString());
	}
	
	private void sedStatistics() {
		List<String> to = new ArrayList<String>();
		//记得开来他
//		to.add("luozh@lccert.com");
//		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
//		to.add("tangzp@lccert.com");
//获取本周的第一天
		TimeTest tt =new TimeTest();
		String WStart=tt.getMondayOFWeek();
		//获取本周的最后一天
		String WEnd=tt.getCurrentWeekday();
		//获取本月的第一天
		String MStart=tt.getFirstDayOfMonth();
		//获取本月的最后一天
		String MEnd=tt.getDefaultDay();
		String str="";
		to.add("service@lccert.com");
		List list =QuotationAction.getInstance().Statistics5(); //获取统计报表的信息
		to.add("kittyyu@lccert.com");
		String head = "[周("+WStart+"至"+WEnd+")/月("+MStart+"至"+MEnd+")的统计报表]";
		StringBuffer content = new StringBuffer("下面表格是统计周("+WStart+"至"+WEnd+")/月("+MStart+"至"+MEnd+"的数据信息：<br>");
		content.append("<style type='text/css'>");
		content.append("table {border-collapse: collapse;}");
		content.append("td {border: solid 1pt #0066CC;}");
		content.append("</style>");
		content.append("<table width=100% align=center>");
		content.append("<tr>");
		content.append("<td>");
		content.append("部门");
		content.append("</td>");
		content.append("<td>");
		content.append("周订单额");
		content.append("</td>");
		content.append("<td>");
		content.append("周收历史款");
		content.append("</td>");
		content.append("<td>");
		content.append("周收当月款");
		content.append("</td>");
		content.append("<td>");
		content.append("周预分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("周实分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("周预机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("周实机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("月订单额");
		content.append("</td>");
		content.append("<td>");
		content.append("月收订单额(真实)");
		content.append("</td>");
		content.append("<td>");
		content.append("月收历史款(真实)");
		content.append("</td>");
		content.append("<td>");
		content.append("月收当月款(真实)");
		content.append("</td>");
		content.append("<td>");
		content.append("月预分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("月实分包费");
		content.append("</td>");
		content.append("<td>");
		content.append("月预机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("月实机构费");
		content.append("</td>");
		content.append("<td>");
		content.append("历史欠款");
		content.append("</td>");
		content.append("<td>");
		content.append("已签单未收款");
		content.append("</td>");
		content.append("</tr>");
		Statistics st=null;
		for(int i=0;i<list.size();i++){
			//System.out.println(i);
			//中山的不显示环境统计
			if(i<4){
				if(i==0){
					str="一部";
				}if(i==1){
					str="二部";
				}if(i==2){
					str="广州";
				}if(i==3){
					str="东莞";
				}
					 st =(Statistics)list.get(i);
					 content.append("<tr>");
					content.append("<td>");
					content.append(str);
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWTotalpric());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWHPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWPresubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWSubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWPreagcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTWAgcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMTotalpric());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMSTotalpric());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMHPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMPresubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMSubcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMPreagcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMAgcost());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMHistoryPay());
					content.append("</td>");
					content.append("<td>");
					content.append(st.getTMConfirmNotPay());
					content.append("</td>");
					content.append("</tr>");
			}
		}
		content.append("</table>");
		content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
		content.append("<br>如有疑问，请联系系统管理员。");
		content.append("<br><br>立创检测<br>日期:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		new EmailConfigure().send(to, head, content.toString());
	}


}
