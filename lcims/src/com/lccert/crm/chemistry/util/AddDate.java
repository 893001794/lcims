package com.lccert.crm.chemistry.util;

import java.util.Date;


public class AddDate {
	/** 
	* ������� 
	* @param d ������ 
	* @param day ��ӵ����� 
	* @return ��Ӻ������ 
	* @throws ParseException 
	*/ 
	public static Date addDate(Date d,long day) { 
	long time = d.getTime(); 
	day = day*24*60*60*1000; 
	time+=day; 
	return new Date(time); 
	} 
}
