package com.lccert.crm.chemistry.util;

import java.util.HashSet;

public class DrawName {
		String surname;
		//复姓的数组
	    static String[] surnameMuster = {"欧阳","太史","端木","上官","司马","东方","独孤","南宫","万俟","闻人",
	    	"夏侯","诸葛","尉迟","公羊","赫连","澹台","皇甫","宗政","濮阳","公冶","太叔","申屠","公孙","慕容",
	    	"仲孙","钟离","长孙","宇文","司徒","鲜于","司空","闾丘","子车","亓官","司寇","巫马","公西","颛孙","壤驷",
	    	"公良","漆雕","乐正","宰父","谷梁","拓跋","夹谷","轩辕","令狐","段干","百里","呼延","东郭","南门","羊舌",
	    	"微生","公户","公玉","公仪","梁丘","公仲","公上","公门","公山","公坚","左丘","公伯","西门","公祖","第五",
	    	"公乘","贯丘","公皙","南荣","东里","东宫","仲长","子书","子桑","即墨","达奚","褚师","吴铭"};
	    //判定传进来的是姓名是复姓还是单姓
	 public String getSurname(String name){
		  name = name.trim();
          boolean flag = true;
         for(int j=0;j<surnameMuster.length;j++)
         {
        	 //获取姓名的前2个字符跟复姓的数组进行对比，如果对比成功就是复姓，否则就是单姓
             if(surnameMuster[j].equals(name.substring(0,2)))
             { 
            	 //复姓
            	 surname=name.substring(0,2);
                 flag = false;
                 break;
             }
         }
         if(flag)
         {
        	 //单姓
        	 surname=name.substring(0,1);
         }
		 return surname;
	 }
	 
	  public static void main(String[] args) {
			String sex =new DrawName().getSurname("苏松炎");
			System.out.println(sex);
		}
}
