package com.temp;

import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Random;

public class Test5 {
	
	public static String getFourToFive(Float score_type)
	 {
	  double bl=(Math.round(score_type/.01)*.01);
	  String st=String.valueOf(bl);
	  /**ע��,������.��Ϊ�ָ�����ʧЧ��,��֪��Ϊʲô,���Բ����滻�İ취*/
	  st=st.replace(".", "_");
	  String []st_arr=st.split("_");
	  String temp="";
	  if(st_arr[1].length()>2)
	  {
	   temp=st_arr[1].substring(0, 1);
	  }
	  else
	  if(st_arr[1].length()<1)
	  {
	   temp=st_arr[1]+"0";
	  }
	  else
	  {
	   temp=st_arr[1];
	  }
	  return st_arr[0]+"."+temp;
	 } 
	public static void main(String[] args) {
//		Float str=799.001f;
//		System.out.println(getFourToFive(str));
		
		
//			  double kk = -1925/60;
//			  int i = (int)Math.ceil(kk);
//			  System.out.println(kk);
//		 Date currentTime=new Date(new Date().getTime()+28800000);
//		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd 	HH:mm");
//		   System.out.println("Current Time is "+sdf.format(currentTime));
		
		
//		java.util.Calendar Cal=java.util.Calendar.getInstance();
//		Cal.setTime(new Date());
//		Cal.add(java.util.Calendar.HOUR_OF_DAY,2);
//		System.out.println("date:"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(Cal.getTime()));
System.out.println("------");
		System.out.println("LCZC13010372-E".substring(13, 14));
	}

}
