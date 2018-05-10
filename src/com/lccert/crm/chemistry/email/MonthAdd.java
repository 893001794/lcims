package com.lccert.crm.chemistry.email;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MonthAdd {
	//���һ����ʱ��
	public Date getDate(Date date,int month){
		//Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse("2011-11-30 05:31:35");
		Calendar c = Calendar.getInstance();   
	    c.setTime(date);  
	     c.add(Calendar.MONTH,month);
	     return c.getTime();
	}
	
public static void main(String[] args) {
	try {
		Date date = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("2011-12-15 17:41:40");
//		Date date3 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("2012-01-16 00:00");
//		Date date1 =new MonthAdd().getDate(date, 1);
//		Date date2 =new MonthAdd().getDate(date, 2);
		System.out.println("��ȡ�������һ������:"+new MonthAdd().getNextMonthEnd(date));   
		System.out.println("��ȡ�������һ������:"+new MonthAdd().getNextMonthFirst(date,2));   
	} catch (ParseException e) {
//		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

	
}

//����¸������һ�������   
public Date getNextMonthEnd(Date date){   
    String str = "";   
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");       
   Calendar lastDate = Calendar.getInstance(); 
   lastDate.setTime(date);  
  lastDate.add(Calendar.MONTH,1);//��һ����   
  lastDate.set(Calendar.DATE, 1);//����������Ϊ���µ�һ��    
  lastDate.roll(Calendar.DATE, -1);//���ڻع�һ�죬Ҳ���Ǳ������һ��    
  
//   str=sdf.format(lastDate.getTime());   //����һ��String����
   return lastDate.getTime();     
}   

//����¸��µ�һ�������   
public Date getNextMonthFirst(Date date,int month){   
    String str = "";   
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");       
   Calendar lastDate = Calendar.getInstance();   
   lastDate.setTime(date);  
  lastDate.add(Calendar.MONTH,month);//��һ����   
  lastDate.set(Calendar.DATE, 1);//����������Ϊ���µ�һ��    
//   str=sdf.format(lastDate.getTime());//����һ��String����   
   return lastDate.getTime();     
}

}
