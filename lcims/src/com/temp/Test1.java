package com.temp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Test1 {
	public static void main(String[] args) {
//		   String   t1   =   "2010-07-03 16:41:05"; 
//		   long   l1   =   0; 
//	      
//
//	        SimpleDateFormat   sdf   =   new   SimpleDateFormat( "yyyy-MM-dd HH:mm:ss"); 
//	        
//	        try   { 
//	        l1   =   sdf.parse(t1).getTime(); 
//	        } 
//	        catch   (java.text.ParseException   pe)   { 
//	                pe.printStackTrace(); 
//	        } 
//	      String a=   t1.substring(t1.indexOf(":")-2, t1.indexOf(":"));
//	      String peuthi="";
//	      	if(new Integer(a)>12){
//	      	   peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 240*60)*1000));
//	      	}else{
//	         peuthi = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 210*60)*1000));
//	      	}
//	        
//	        
//	        
//	        String oneHour = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date((l1/1000- 60*60)*1000));
//	        System.out.println(peuthi);
//	        System.out.println(oneHour);
//	      String a="doc-E";
//	      System.out.println(a.substring(0, a.indexOf("-")));
		
		
//		Test1 a=new Test1();
//		
//			a.countstring();
//		String str="2000.0HD";
//		String a=str.substring(0, str.indexOf(".")+2);
//		System.out.println(a);
		
		
//			String str ="LCQ112110009-1&LCZC12110004,LCQ112110009-2&LCZC12110005,";
//			String[] s=str.split(",");
//			System.out.println(s[0].substring(0,s[0].indexOf("&")));
//			for(int i=0;i<s.length;i++){
//				System.out.println(s[i].substring(s[i].indexOf("&")+1,s[i].length()));
//			}
		
		 DecimalFormat df=new DecimalFormat("#.00"); 
		float str=156.258852545f;	
		System.out.println(df.format(156.258852545));
		
		
	}
	
	//判断一个字符串是否含有大小英文字母或小写英文母或数据的方法
	
	public void countstring()
	 {
//	  InputStreamReader reader=new InputStreamReader(System.in);
//	  BufferedReader input=new BufferedReader(reader);
//	  System.out.print("请输入字符串：");
//	  String zifuc=input.readLine();
		String zifuc="300.0HD";
	  int i=0,countLow=0,countUp=0,countNo=0;
	  while(i!=zifuc.length())
	  {
	   if(zifuc.charAt(i)>='a'&&zifuc.charAt(i)<='z')
	    countLow++;
	   else if(zifuc.charAt(i)>='A'&&zifuc.charAt(i)<='Z')
	    countUp++;
	   else countNo++;
	   i++;
	  }
	  System.out.println("大写英文字母个数为: "+countUp+"\n小写英文字母个数为: "+countLow+"\n非英文字母个数为:   "+countNo);
	 }


}
