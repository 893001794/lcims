package com.lccert.crm.chemistry.email;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import org.apache.log4j.chainsaw.Main;
import com.lccert.crm.chemistry.util.TimeTest;
import com.lccert.crm.dao.impl.RecordDaoImpl;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.vo.Statistics;
import com.lccert.oa.db.ImsDB;

public class RecordEmail extends TimerTask{
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

	//����ipΪ&&!ip.equals("192.168.0.10")������
		if(!ip.equals("10.11.1.222")&&!ip.equals("192.168.0.10")){
			//���жϽ����Ƿ���������
			SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd"); 
			String datetime = tempDate.format(new java.util.Date()); 
			String year=datetime.substring(0,datetime.indexOf("-"));
			String month=datetime.substring(datetime.indexOf("-")+1, datetime.lastIndexOf("-"));
				if(month.substring(0, 1).equals("0")){
					month=month.substring(1, 2);
				}
				String date =datetime.substring(datetime.lastIndexOf("-")+1,datetime.length());
				if(date.substring(0, 1).equals("0")){
					date=date.substring(1, 2);
				}
				int a =Integer.parseInt(year);
				int b =Integer.parseInt(month);
				int c =Integer.parseInt(date);
				
				if(!new TaskManager().getXQ(a,b,c).equals("������")){
					EmailMail();
				}
		}
	}
	public static void main(String[] args) {
		new RecordEmail().run();
	}
	//����ɽ�ʼ�
	private void EmailMail() {
		//��ȡ��ɽ����
		List temp =new ArrayList();
		temp.add("email");
		String sql="select email  from t_user  where company ='��ɽ' and estatus ='��Ч' and dept like '%����%'  and id !=100 ";
		List rows=new ImsDB().getInfor(temp,sql);
		List CList =new ArrayList(); 
		for(int i=0;i<rows.size();i++){
			List column=(List)rows.get(i);
			//��ȡСʱ
			SimpleDateFormat sdf = new SimpleDateFormat("HH");
			//���ʼ���ʱ����
			int nowHor=Integer.parseInt(sdf.format(new Date()));
			//Johnֻ��ȡ17:30���ʼ�
			if(column.get(0).equals("john@lccert.com")){
				if(nowHor>17){
					CList.add(column.get(0));
				}else{
					
				}
			}else{
				CList.add(column.get(0));
			}
		}
//		CList.add("tangzp@lccert.com");
		CList.add("limj@lccert.com");
		//��ȡ��������
		String sqlG="select email  from t_user  where company ='����' and estatus ='��Ч' and dept like '%����%' ";
		rows=new ImsDB().getInfor(temp, sqlG);
		List GList =new ArrayList(); 
		for(int i=0;i<rows.size();i++){
			List column=(List)rows.get(i);
			GList.add(column.get(0));
		}
	//	GList.add("tangzp@lccert.com");
		//��ȡ��ݸ����
		String sqlD="select email  from t_user  where estatus ='��Ч' and dept = '���۲�(����)' ";
		rows=new ImsDB().getInfor(temp, sqlD);
		List DList =new ArrayList(); 
		for(int i=0;i<rows.size();i++){
			List column=(List)rows.get(i);
			//DList.add(column.get(0));
		}
		DList.add("tangzp@lccert.com");
		sedStatistics(CList,"C");
		//sedStatistics(GList,"G");
		//sedStatistics(DList,"D");
	}
	
	//���ʼ��Ĺ�������
	private void sedStatistics(List list,String area) {
				//�ǵÿ�����
//				to.add("luozh@lccert.com");
//				to.add("hadixia@lccert.com");
//				to.add("amyyang@lccert.com");
//				to.add("john@lccert.com");
//				to.add("clf@lccert.com");
		String str ="";
			if(area.equals("G")){
				str="����";
			}
			if(area.equals("D")){
				str="��ݸ";
			}
			if(area.equals("C")){
				str="��ɽ";
			}
				List folderL=new ArrayList();
				folderL.add("vecordname");
				List count =new ArrayList ();
				count.add("a");
				String date =null;
				List condition=new ArrayList();
				SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMdd");
				if(date ==null){
					date=sdf.format(new Date());
				}
				List RRows =new RecordDaoImpl().getFolder(area,date,folderL);
//				System.out.println(RRows.size());
				String head = "[LCIMS"+str+"�������۵绰��ͳ��]";
				StringBuffer content = new StringBuffer("�����������۵���ĵ绰��ͳ�ƣ�<br>");
				content.append("<style type='text/css'>");
				content.append("table {border-collapse: collapse;}");
				content.append("td {border: solid 1pt #0066CC;}");
				content.append("</style>");
				content.append("<table width=100% align=center>");
				content.append("<tr>");
				content.append("<td align='center'>");
				content.append("��Ա");
				content.append("</td>");
				if(RRows.size()>0){
					for(int i =0;i<RRows.size();i++){
						List column=(List)RRows.get(i);
						content.append("<td align='center'>");
						content.append(column.get(0));
						content.append("</td>");
					}
				content.append("</tr>");
				content.append("<tr>");
				content.append("<td align='center'>");
				content.append("�绰��");
				content.append("</td>");
				for(int i =0;i<RRows.size();i++){
					condition=(List)RRows.get(i);
					List rows1 =new RecordDaoImpl().getCountFiles("C",date,count,condition.get(0).toString());
					for(int j =0;j<rows1.size();j++){
						List column=(List)rows1.get(j);
						content.append("<td align='center'>");
						content.append(column.get(0));
						content.append("</td>");
					}
				}
				content.append("</tr>");
				}
				//����ͳ��
				if(area.equals("C")){
				 RRows =new RecordDaoImpl().getFolder("E",date,folderL);
					content.append("<tr>");
					content.append("<td align='center'>");
					content.append("��Ա");
					content.append("</td>");
					if(RRows.size()>0){
						for(int i =0;i<RRows.size();i++){
							List column=(List)RRows.get(i);
							content.append("<td align='center'>");
							content.append(column.get(0));
							content.append("</td>");
						}
					content.append("</tr>");
					content.append("<tr>");
					content.append("<td align='center'>");
					content.append("�绰��");
					content.append("</td>");
					for(int i =0;i<RRows.size();i++){
						condition=(List)RRows.get(i);
						List rows1 =new RecordDaoImpl().getCountFiles("E",date,count,condition.get(0).toString());
						for(int j =0;j<rows1.size();j++){
							List column=(List)rows1.get(j);
							content.append("<td align='center'>");
							content.append(column.get(0));
							content.append("</td>");
						}
					}
					content.append("</tr>");
					}
				}
				content.append("</table>");
				content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
				content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
				content.append("<br><br>�������<br>����:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				if(RRows.size()>0){
					try {
						new com.lccert.crm.chemistry.util.SendEmail().sendEmailPublic(list,head,content.toString());
						//new EmailConfigure().send(list, head, content.toString());
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
	
	

}
