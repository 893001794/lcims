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
 * ÿ�������ܾ����͵�ͳ�Ʊ�������
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
			ip = addr.getHostAddress();//��ñ���IP
	} catch (UnknownHostException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//����ipΪ192.168.0.10������
	if(!ip.equals("10.11.1.222")){
		sedStatistics();
	}
	else{
		sedStatisticsD();
	}
		

	}
	
	private void sedStatisticsD(){
		List<String> to = new ArrayList<String>();
		//�ǵÿ�����
//		to.add("luozh@lccert.com");
//		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
//		to.add("tangzp@lccert.com");
//��ȡ���ܵĵ�һ��
		TimeTest tt =new TimeTest();
		String WStart=tt.getMondayOFWeek();
		//��ȡ���ܵ����һ��
		String WEnd=tt.getCurrentWeekday();
		//��ȡ���µĵ�һ��
		String MStart=tt.getFirstDayOfMonth();
		//��ȡ���µ����һ��
		String MEnd=tt.getDefaultDay();
		String str="";
		to.add("service@lccert.com");
		List list =QuotationAction.getInstance().Statistics5(); //��ȡͳ�Ʊ������Ϣ
//		to.add("kittyyu@lccert.com");
		String head = "[��("+WStart+"��"+WEnd+")/��("+MStart+"��"+MEnd+")��ͳ�Ʊ���]";
		StringBuffer content = new StringBuffer("��������ͳ����("+WStart+"��"+WEnd+")/��("+MStart+"��"+MEnd+"��������Ϣ��<br>");
		content.append("<style type='text/css'>");
		content.append("table {border-collapse: collapse;}");
		content.append("td {border: solid 1pt #0066CC;}");
		content.append("</style>");
		content.append("<table width=100% align=center>");
		content.append("<tr>");
		content.append("<td>");
		content.append("����");
		content.append("</td>");
		content.append("<td>");
		content.append("�ܶ�����");
		content.append("</td>");
		content.append("<td>");
		content.append("������ʷ��");
		content.append("</td>");
		content.append("<td>");
		content.append("���յ��¿�");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ������");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ������");
		content.append("</td>");
		content.append("<td>");
		content.append("�¶�����");
		content.append("</td>");
		content.append("<td>");
		content.append("������ʷ��(��ʵ)");
		content.append("</td>");
		content.append("<td>");
		content.append("���յ��¿�(��ʵ)");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ������");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ������");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʷǷ��");
		content.append("</td>");
		content.append("<td>");
		content.append("��ǩ��δ�տ�");
		content.append("</td>");
		content.append("</tr>");
		Statistics st=null;
		for(int i=0;i<list.size();i++){
			//��ݸ�ķ���������ʾ������
			if(i==4){
				str="����";
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
			content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
			content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
			content.append("<br><br>�������<br>����:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			new EmailConfigure().send(to, head, content.toString());
	}
	
	private void sedStatistics() {
		List<String> to = new ArrayList<String>();
		//�ǵÿ�����
//		to.add("luozh@lccert.com");
//		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
//		to.add("tangzp@lccert.com");
//��ȡ���ܵĵ�һ��
		TimeTest tt =new TimeTest();
		String WStart=tt.getMondayOFWeek();
		//��ȡ���ܵ����һ��
		String WEnd=tt.getCurrentWeekday();
		//��ȡ���µĵ�һ��
		String MStart=tt.getFirstDayOfMonth();
		//��ȡ���µ����һ��
		String MEnd=tt.getDefaultDay();
		String str="";
		to.add("service@lccert.com");
		List list =QuotationAction.getInstance().Statistics5(); //��ȡͳ�Ʊ������Ϣ
		to.add("kittyyu@lccert.com");
		String head = "[��("+WStart+"��"+WEnd+")/��("+MStart+"��"+MEnd+")��ͳ�Ʊ���]";
		StringBuffer content = new StringBuffer("��������ͳ����("+WStart+"��"+WEnd+")/��("+MStart+"��"+MEnd+"��������Ϣ��<br>");
		content.append("<style type='text/css'>");
		content.append("table {border-collapse: collapse;}");
		content.append("td {border: solid 1pt #0066CC;}");
		content.append("</style>");
		content.append("<table width=100% align=center>");
		content.append("<tr>");
		content.append("<td>");
		content.append("����");
		content.append("</td>");
		content.append("<td>");
		content.append("�ܶ�����");
		content.append("</td>");
		content.append("<td>");
		content.append("������ʷ��");
		content.append("</td>");
		content.append("<td>");
		content.append("���յ��¿�");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ������");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ������");
		content.append("</td>");
		content.append("<td>");
		content.append("�¶�����");
		content.append("</td>");
		content.append("<td>");
		content.append("���ն�����(��ʵ)");
		content.append("</td>");
		content.append("<td>");
		content.append("������ʷ��(��ʵ)");
		content.append("</td>");
		content.append("<td>");
		content.append("���յ��¿�(��ʵ)");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ�ְ���");
		content.append("</td>");
		content.append("<td>");
		content.append("��Ԥ������");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʵ������");
		content.append("</td>");
		content.append("<td>");
		content.append("��ʷǷ��");
		content.append("</td>");
		content.append("<td>");
		content.append("��ǩ��δ�տ�");
		content.append("</td>");
		content.append("</tr>");
		Statistics st=null;
		for(int i=0;i<list.size();i++){
			//System.out.println(i);
			//��ɽ�Ĳ���ʾ����ͳ��
			if(i<4){
				if(i==0){
					str="һ��";
				}if(i==1){
					str="����";
				}if(i==2){
					str="����";
				}if(i==3){
					str="��ݸ";
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
		content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
		content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
		content.append("<br><br>�������<br>����:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		new EmailConfigure().send(to, head, content.toString());
	}


}
