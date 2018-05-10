package com.temp;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.email.MonthAdd;

public class T {
//	
	public static void main(String[] args) {
//		String  str="LCZC10029001F-003";
//		if(str.indexOf("-")>-1){
//			System.out.print(str.substring(0,str.indexOf("-")));
//		}
		String str="WY1ZS09010";	
		if(str.indexOf("ZS")>0){
			System.out.println(str.substring(0, str.indexOf("ZS")));
			System.out.println(str.substring(str.indexOf("ZS"),str.length()));
		}
	}
	
	
	/**
	 * ��ȡĳ��ĳ�µ����һ��
	 * @param year
	 * @param month
	 * @return
	 */
	public static String getLastDayOfMonth(int year,int month)     {         
		Calendar cal = Calendar.getInstance();         //�������         
		cal.set(Calendar.YEAR,year);         //�����·�         
		cal.set(Calendar.MONTH, month-1);         //��ȡĳ���������       
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);         //�����������·ݵ��������       
		cal.set(Calendar.DAY_OF_MONTH, lastDay);         //��ʽ������         
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");         
		String lastDayOfMonth = sdf.format(cal.getTime());                   
		return lastDayOfMonth;     
	}
	   

	
	
	

/***
 * 
 * @param amStart ������Կ�ʼʱ��
 * @param pmStart ������Կ�ʼʱ��
 * @param amEnd   ������Խ���ʱ��
 * @param pmEnd   ������Խ���ʱ��
 * @return
 */
	public String getHourMin(String amStart,String pmStart,String amEnd,String pmEnd){
		 SimpleDateFormat df = new SimpleDateFormat("HH:mm");
		 if(amStart ==null || "".equals(amStart)){
			 amStart="00:00";
		 }
		 if(pmStart ==null || "".equals(pmStart)){
			 pmStart="00:00";
		 }
		 if(amEnd ==null || "".equals(amEnd)){
			 amEnd="00:00";
		 }
		 if(pmEnd ==null || "".equals(pmEnd)){
			 pmEnd="00:00";
		 }
		 String minStr="";
		 String timeStr="";
		 try{
			Date amStartD = df.parse(amStart);
			Date pmStartD=  df.parse(pmStart);
			Date amEndD = df.parse(amEnd);
			Date pmEndD=  df.parse(pmEnd);
			long start=amEndD.getTime()-amStartD.getTime();
			long end=pmEndD.getTime()-pmStartD.getTime();
			long l=end+start;
			long day=l/(24*60*60*1000);
			long hour=(l/(60*60*1000)-day*24);
			long min=((l/(60*1000))-day*24*60-hour*60);
			if(min>30){
				hour+=1;
			}else if (min==0){
				minStr="";
			}else{
				minStr=".5";
			}
			timeStr=hour+minStr;
			System.out.println(timeStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return timeStr;
	}
	// ����������ӡ�������  
	 public static Date operationDateOfDay(Date date) {   
		 Calendar c = Calendar.getInstance();   
	       c.setTime(date);  
	        c.add(Calendar.MONTH,1);
	        return c.getTime();   

	    }   

	     
}