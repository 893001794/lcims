package com.lccert.crm.chemistry.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/***
 * 将阿拉伯数据转成中文大写工具
 * @author tangzp
 *
 */
public class ChangeToBig 
{ 
 public static boolean isEmpty(String string) {
  return ((string == null) || (string.length() == 0));
 }

 public static String[] split(String str, String delimiter) {
  ArrayList array = new ArrayList();
  int index = 0;
  int begin = 0, end;
  String[] result = new String[0];

  if (isEmpty(str)) {
   /* modified by xmsong, 2002-12-10 */
   //   return new String[0];
   return result;
  }

  while (true) {
   index = str.indexOf(delimiter, begin);

   if (index == begin) {
    if (index >= 0) {
     array.add("");
    }
    begin += delimiter.length();
   } else if (index > begin) {
    end = index;

    array.add(str.substring(begin, end));

    begin = index + delimiter.length();
   } else {
    if ((begin >= 0) && (begin < str.length())) {
     array.add(str.substring(begin));
    }

    break;
   }
  }

  if (str.endsWith(delimiter)) {
   array.add("");
  }
  if (array.size() > 0) {
   result = new String[array.size()];

   array.toArray(result);
  }

  return result;
 }

 public static String changeToBig(String value)
 {
  int intFen,i;
  String strCheck,strFen,strDW="",strNum="",strBig;
  String[] strArr=new String[20];
  String[] strNow=new String[20];


  if(value.trim()=="")   //数据为空时返回"零"
   return "零";
  Float bg=null;
  try{
   bg = new Float(value);
  }catch (NumberFormatException ne){ ////数据非法时提示，并返回空串
   String strErr = "数据"+value+"非法！";
   return strErr;
  }
  strCheck = value+".";
  //System.out.println(strCheck);
  strArr = split(strCheck,".");
  //System.out.println(strArr[0]);
  strCheck = strArr[0];
  //System.out.println("again:"+strCheck);
  if(strCheck.length()>12)   //数据大于等于一万亿时提示无法处理
  {
   String strErr = "数据"+value+"过大，无法处理！";
   return strErr;
  }
  try
  {
   i = 0;
   strBig = "";
   //intFen = (int)bg.floatValue()*100;          //转换为以分为单位的数值
   //strFen = String.valueOf(intFen);
   //strArr = split(strFen,".");
   int len = value.indexOf(".");
   strFen = value.substring(0,len)+value.substring(len+1);
   intFen = strFen.length();      //获取长度
   strArr = new String[20];
   for(int j=0;j<intFen;j++){
    strArr[j] = strFen.substring(j,j+1);
   }
   //strArr = split(strFen,""); //将各个数值分解到数组内
   while(intFen!=0)   //分解并转换
   {
    i = i+1;
    switch(i)              //选择单位
    {
     case 1:strDW = "分";break;
     case 2:strDW = "角";break;
     case 3:strDW = "元";break;
     case 4:strDW = "拾";break;
     case 5:strDW = "佰";break;
     case 6:strDW = "仟";break;
     case 7:strDW = "万";break;
     case 8:strDW = "拾";break;
     case 9:strDW = "佰";break;
     case 10:strDW = "仟";break;
     case 11:strDW = "亿";break;
     case 12:strDW = "拾";break;
     case 13:strDW = "佰";break;
     case 14:strDW = "仟";break;
    }
    switch (Integer.parseInt(strArr[intFen-1]))              //选择数字
    {
     case 1:
      strNum = "壹";
      break;
     case 2:
      strNum = "贰";
      break;
     case 3:
      strNum = "叁";
      break;
     case 4:
      strNum = "肆";
      break;
     case 5:
      strNum = "伍";
      break;
     case 6:
      strNum = "陆";
      break;
     case 7:
      strNum = "柒";
     break;
     case 8:
      strNum = "捌";
      break;
     case 9:
      strNum = "玖";
      break;
     case 0:
      strNum = "零";
      break;
     default:
      break;
    }

    //处理特殊情况
    for(int j=0;j<strBig.length();j++){
     strNow[j] = strBig.substring(j,j+1);
    }
    //strNow = split(strBig,"");
    //分为零时的情况
    if((i==1)&&(strArr[intFen-1]=="0"))
     strBig = "整";
    //角为零时的情况
    else if((i==2)&&(strArr[intFen-1]=="0"))
    {    //角分同时为零时的情况
     if(strBig!="整")
      strBig = "零"+strBig;
    }
    //元为零的情况
    else if((i==3)&&(strArr[intFen-1]=="0"))
     strBig = "元"+strBig;
    //拾－仟中一位为零且其前一位（元以上）不为零的情况时补零
    else if((i<7)&&(i>3)&&(strArr[intFen-1]=="0")&&(strNow[0]!="零")&&(strNow[0]!="元"))
     strBig = "零"+strBig;
    //拾－仟中一位为零且其前一位（元以上）也为零的情况时跨过
    else if((i<7)&&(i>3)&&(strArr[intFen-1]=="0")&&(strNow[0]=="零"))
    {} 
    //拾－仟中一位为零且其前一位是元且为零的情况时跨过
    else if((i<7)&&(i>3)&&(strArr[intFen-1]=="0")&&(strNow[0]=="元"))
     {}
    //当万为零时必须补上万字
    else if((i==7)&&(strArr[intFen-1]=="0"))
     strBig ="万"+strBig;
    //拾万－仟万中一位为零且其前一位（万以上）不为零的情况时补零
    else if((i<11)&&(i>7)&&(strArr[intFen-1]=="0")&&(strNow[0]!="零")&&(strNow[0]!="万"))
     strBig = "零"+strBig;
    //拾万－仟万中一位为零且其前一位（万以上）也为零的情况时跨过
    else if((i<11)&&(i>7)&&(strArr[intFen-1]=="0")&&(strNow[0]=="万"))
    {}
    //拾万－仟万中一位为零且其前一位为万位且为零的情况时跨过
    else if((i<11)&&(i>7)&&(strArr[intFen-1]=="0")&&(strNow[0]=="零"))
    {}
    //万位为零且存在仟位和十万以上时，在万仟间补零
    else if((i<11)&&(i>8)&&(strArr[intFen-1]!="0")&&(strNow[0]=="万")&&(strNow[2]=="仟"))
     strBig = strNum+strDW+"万零"+strBig.substring(1,strBig.length());
    //单独处理亿位
    else if(i==11)
    {
     //亿位为零且万全为零存在仟位时，去掉万补为零
     if((strArr[intFen-1]=="0")&&(strNow[0]=="万")&&(strNow[2]=="仟"))
      strBig ="亿"+"零"+strBig.substring(1,strBig.length());
     //亿位为零且万全为零不存在仟位时，去掉万
     else if((strArr[intFen-1]=="0")&&(strNow[0]=="万")&&(strNow[2]!="仟"))
      strBig ="亿"+strBig.substring(1,strBig.length());
     //亿位不为零且万全为零存在仟位时，去掉万补为零
     else if((strNow[0]=="万")&&(strNow[2]=="仟"))
      strBig = strNum+strDW+"零"+strBig.substring(1,strBig.length());
     //亿位不为零且万全为零不存在仟位时，去掉万 
     else if((strNow[0]=="万")&&(strNow[2]!="仟"))
      strBig = strNum+strDW+strBig.substring(1,strBig.length()); 
     //其他正常情况
     else
      strBig = strNum+strDW+strBig;
    }
    //拾亿－仟亿中一位为零且其前一位（亿以上）不为零的情况时补零
    else if((i<15)&&(i>11)&&(strArr[intFen-1]=="0")&&(strNow[0]!="零")&&(strNow[0]!="亿"))
     strBig = "零"+strBig;
    //拾亿－仟亿中一位为零且其前一位（亿以上）也为零的情况时跨过
    else if((i<15)&&(i>11)&&(strArr[intFen-1]=="0")&&(strNow[0]=="亿"))
    {}
    //拾亿－仟亿中一位为零且其前一位为亿位且为零的情况时跨过
    else if((i<15)&&(i>11)&&(strArr[intFen-1]=="0")&&(strNow[0]=="零"))
     {}
    //亿位为零且不存在仟万位和十亿以上时去掉上次写入的零
    else if((i<15)&&(i>11)&&(strArr[intFen-1]!="0")&&(strNow[0]=="零")&&(strNow[1]=="亿")&&(strNow[3]!="仟"))
     strBig = strNum+strDW+strBig.substring(1,strBig.length());
    //亿位为零且存在仟万位和十亿以上时，在亿仟万间补零
    else if((i<15)&&(i>11)&&(strArr[intFen-1]!="0")&&(strNow[0]=="零")&&(strNow[1]=="亿")&&(strNow[3]=="仟"))
     strBig = strNum+strDW+"亿零"+strBig.substring(2,strBig.length());
    else
     strBig = strNum+strDW+strBig;
    strFen = strFen.substring(0,intFen-1);
    intFen = strFen.length();
    for(int j=0;j<intFen;j++){
     strArr[j] = strFen.substring(j,j+1);
    }

    //strArr = split(strFen,"");
   }
   return strBig;
  }catch(Exception e){
   e.printStackTrace();
   return "转换错误";      //若失败则返回原值

  } 
 }
 
 
  /** 
   * 装载用字节截取英文字符
   * @param str  //要截取的字符串
   * @return
   */
 public List<String> getValue(String str){
	 List<String> result=new ArrayList();
	 int size =60; //每行最大容量字节数
	 int startLeng =0;  //开始位置   
	 int endLeng=0;    //结束位置
	 int len=str.getBytes().length; //字符串的字节数量
	 String reg2="^[A-Za-z0-9]";  //正则表达式判定
	 char[] a=str.toCharArray();  //将字符串转换字节
	  Pattern pattern = Pattern.compile(reg2); //匹配字符
	  //S中是否是英文数字
	  String s_str=String.valueOf(a[a.length-1]);//将字节转换字符串
	  Matcher m = pattern.matcher(s_str);
	 
	 while(endLeng<len){  //等结束数小于字节数据就循环
		 endLeng=size+startLeng; //最大容量+开始数=结束数
		 endLeng = endLeng>len?len:endLeng; //当endLeng(最后索引位)大于len(字符串字节数量)时，将len赋值给endLeng否则就将endLeng赋值给endLeng
		 boolean flag =true;
		 flag=endLeng==len?true:false; //当结束字符等于字节数就不用截取字节
		 String s= subStringByByte(str, startLeng, endLeng); //按字节数获取子字符串  
		 if(!m.find()){
			 startLeng=endLeng;  
			 result.add(s);
		  }else
		 {
			  startLeng=getResult(s,result,reg2,flag);//获取每次最后一次的字节数}
		 }
		 }
	 
	return result;
	 
 }
// /** 
//  * 装载用字节截取中文字符
//  * @param str  //要截取的字符串
//  * @return
//  */
//public List<String> getValueC(String str){
//	 List<String> result=new ArrayList();
//	 int size =60; //每行最大容量字节数
//	 int startLeng =0;  //开始位置   
//	 int endLeng=0;    //结束位置
//	 int len=str.getBytes().length; //字符串的字节数量
//	 while(endLeng<len){  //等结束数小于字节数据就循环
//		 endLeng=size+startLeng; //最大容量+开始数=结束数
//		 endLeng = endLeng>len?len:endLeng; //当endLeng(最后索引位)大于len(字符串字节数量)时，将len赋值给endLeng否则就将endLeng赋值给endLeng
//		 String s= subStringByByte(str, startLeng, endLeng); //按字节数获取子字符串  
//		 startLeng=endLeng;
//		 result.add(s);
//	 }
//	return result;
//	 
//}
 /**
  *不分割单词字符串
  * @param str //字符串
  * @param result //装截取后的字符串
  * @param reg2 //匹配条件
  * @param flag //是否要截取字符串
  * @return
  */
 public  int getResult(String str,List<String> result,String reg2,boolean flag){
	 	int index=0;
	  //正则判断一下
	  char[] a=str.toCharArray();  //将字符串转换字节
	  Pattern pattern = Pattern.compile(reg2); //匹配字符
	  //S中是否是英文数字
	  String s_str=String.valueOf(a[a.length-1]);//将字节转换字符串
	  Matcher m = pattern.matcher(s_str);
	  if(m.matches()){
		  for(int i=a.length-1;i>=0;i--){
			 String bool_str=String.valueOf(a[i]); //字节转换字符串
			  m= pattern.matcher(bool_str); //
			  if(!m.matches()){
				  index=i;  //如果匹配就获取字节的位置
				  break;
			  }
		  }
		  if(flag ==true){
			  result.add(str);
		  }else{
			 result.add(str.substring(0,index+1));
		  }
		  
	  }
	 return index+1;
 }
 
 
 public static void main(String[] args) {
	 String str="  US EPA 3050B→总铅; US EPA 3052→总铅; US EPA 3050B→总镉; US EPA 3052→总镉; US EPA 3050B→Pb、Cd、Hg、Cr、Cu、Ni、Fe、Ba、Mn、Zn、Sb、As; US EPA 3052→Pb、Cd、Hg、Cr、Cu、Ni、Fe、Ba、Mn、Zn、Sb、As; ";
	 //System.out.println(str.toCharArray().length);
	//System.out.println(subStringByByte(str,0,50));
	 List<String> result =new ChangeToBig().getValue(str);
	 for(String value:result){
		 System.out.println(value);
	 }
}

 /**      * 按字节数获取子字符串  
  *     * @param str 原字符串    
  *       * @param byteBeginIndex 开始位置     
  *        * @param byteEndIndex 结束位置    
  *          * @return 子字符串      */   
 public static String subStringByByte(String str, int byteBeginIndex, int byteEndIndex)     
 {         
	 String result = "";        
	 int charLength = 0;  //字符串转换为字节总数    
	 int tempIndex1 = 0;      //字符的开始位置      
	 int tempIndex2 = 0;        //字符的结束位置   
	 int charBeginIndex = -1;  //字节的开始位置  
	 int charEndIndex = -1;    //字节的结束位置        
	 if(byteEndIndex > byteBeginIndex && byteBeginIndex >= 0){     //当结束位置大于开始位置并且开始位置大于0        
		 for(int i = 0; i < str.length(); i++) { //循环字符串数                
			 charLength = str.substring(i, i + 1).getBytes().length; //获取字节数              
			 tempIndex1 = tempIndex2;                 
			 tempIndex2 += charLength;                   
			 if(byteBeginIndex >= tempIndex1 && byteBeginIndex < tempIndex2){                     
				 charBeginIndex = i;                 
				 }
			 if(byteEndIndex >= tempIndex1 && byteEndIndex < tempIndex2){                     
				 charEndIndex = byteEndIndex == tempIndex1? i: i + 1;                     
				 break;                 
				 }             
			 }               
		 charEndIndex = charEndIndex == -1? (charBeginIndex == -1? 0: str.length()): charEndIndex;
		 charBeginIndex = charBeginIndex == -1? 0: charBeginIndex;             
		 result = str.substring(charBeginIndex, charEndIndex);        
 }        return result;     
 }


}