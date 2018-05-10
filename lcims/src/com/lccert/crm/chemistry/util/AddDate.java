package com.lccert.crm.chemistry.util;

import java.util.Date;


public class AddDate {
	/** 
	* 添加日期 
	* @param d 现日期 
	* @param day 添加的天数 
	* @return 添加后的日期 
	* @throws ParseException 
	*/ 
	public static Date addDate(Date d,long day) { 
	long time = d.getTime(); 
	day = day*24*60*60*1000; 
	time+=day; 
	return new Date(time); 
	} 
}
