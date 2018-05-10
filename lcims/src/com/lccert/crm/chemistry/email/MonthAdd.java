package com.lccert.crm.chemistry.email;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MonthAdd {
	//相隔一个月时间
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
		System.out.println("获取下月最后一天日期:"+new MonthAdd().getNextMonthEnd(date));   
		System.out.println("获取下月最后一天日期:"+new MonthAdd().getNextMonthFirst(date,2));   
	} catch (ParseException e) {
//		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

	
}

//获得下个月最后一天的日期   
public Date getNextMonthEnd(Date date){   
    String str = "";   
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");       
   Calendar lastDate = Calendar.getInstance(); 
   lastDate.setTime(date);  
  lastDate.add(Calendar.MONTH,1);//加一个月   
  lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天    
  lastDate.roll(Calendar.DATE, -1);//日期回滚一天，也就是本月最后一天    
  
//   str=sdf.format(lastDate.getTime());   //返回一个String类型
   return lastDate.getTime();     
}   

//获得下个月第一天的日期   
public Date getNextMonthFirst(Date date,int month){   
    String str = "";   
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");       
   Calendar lastDate = Calendar.getInstance();   
   lastDate.setTime(date);  
  lastDate.add(Calendar.MONTH,month);//减一个月   
  lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天    
//   str=sdf.format(lastDate.getTime());//返回一个String类型   
   return lastDate.getTime();     
}

}
