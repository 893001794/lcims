package com.lccert.crm.chemistry.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/***
 * ������������ת�����Ĵ�д����
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


  if(value.trim()=="")   //����Ϊ��ʱ����"��"
   return "��";
  Float bg=null;
  try{
   bg = new Float(value);
  }catch (NumberFormatException ne){ ////���ݷǷ�ʱ��ʾ�������ؿմ�
   String strErr = "����"+value+"�Ƿ���";
   return strErr;
  }
  strCheck = value+".";
  //System.out.println(strCheck);
  strArr = split(strCheck,".");
  //System.out.println(strArr[0]);
  strCheck = strArr[0];
  //System.out.println("again:"+strCheck);
  if(strCheck.length()>12)   //���ݴ��ڵ���һ����ʱ��ʾ�޷�����
  {
   String strErr = "����"+value+"�����޷�����";
   return strErr;
  }
  try
  {
   i = 0;
   strBig = "";
   //intFen = (int)bg.floatValue()*100;          //ת��Ϊ�Է�Ϊ��λ����ֵ
   //strFen = String.valueOf(intFen);
   //strArr = split(strFen,".");
   int len = value.indexOf(".");
   strFen = value.substring(0,len)+value.substring(len+1);
   intFen = strFen.length();      //��ȡ����
   strArr = new String[20];
   for(int j=0;j<intFen;j++){
    strArr[j] = strFen.substring(j,j+1);
   }
   //strArr = split(strFen,""); //��������ֵ�ֽ⵽������
   while(intFen!=0)   //�ֽⲢת��
   {
    i = i+1;
    switch(i)              //ѡ��λ
    {
     case 1:strDW = "��";break;
     case 2:strDW = "��";break;
     case 3:strDW = "Ԫ";break;
     case 4:strDW = "ʰ";break;
     case 5:strDW = "��";break;
     case 6:strDW = "Ǫ";break;
     case 7:strDW = "��";break;
     case 8:strDW = "ʰ";break;
     case 9:strDW = "��";break;
     case 10:strDW = "Ǫ";break;
     case 11:strDW = "��";break;
     case 12:strDW = "ʰ";break;
     case 13:strDW = "��";break;
     case 14:strDW = "Ǫ";break;
    }
    switch (Integer.parseInt(strArr[intFen-1]))              //ѡ������
    {
     case 1:
      strNum = "Ҽ";
      break;
     case 2:
      strNum = "��";
      break;
     case 3:
      strNum = "��";
      break;
     case 4:
      strNum = "��";
      break;
     case 5:
      strNum = "��";
      break;
     case 6:
      strNum = "½";
      break;
     case 7:
      strNum = "��";
     break;
     case 8:
      strNum = "��";
      break;
     case 9:
      strNum = "��";
      break;
     case 0:
      strNum = "��";
      break;
     default:
      break;
    }

    //�����������
    for(int j=0;j<strBig.length();j++){
     strNow[j] = strBig.substring(j,j+1);
    }
    //strNow = split(strBig,"");
    //��Ϊ��ʱ�����
    if((i==1)&&(strArr[intFen-1]=="0"))
     strBig = "��";
    //��Ϊ��ʱ�����
    else if((i==2)&&(strArr[intFen-1]=="0"))
    {    //�Ƿ�ͬʱΪ��ʱ�����
     if(strBig!="��")
      strBig = "��"+strBig;
    }
    //ԪΪ������
    else if((i==3)&&(strArr[intFen-1]=="0"))
     strBig = "Ԫ"+strBig;
    //ʰ��Ǫ��һλΪ������ǰһλ��Ԫ���ϣ���Ϊ������ʱ����
    else if((i<7)&&(i>3)&&(strArr[intFen-1]=="0")&&(strNow[0]!="��")&&(strNow[0]!="Ԫ"))
     strBig = "��"+strBig;
    //ʰ��Ǫ��һλΪ������ǰһλ��Ԫ���ϣ�ҲΪ������ʱ���
    else if((i<7)&&(i>3)&&(strArr[intFen-1]=="0")&&(strNow[0]=="��"))
    {} 
    //ʰ��Ǫ��һλΪ������ǰһλ��Ԫ��Ϊ������ʱ���
    else if((i<7)&&(i>3)&&(strArr[intFen-1]=="0")&&(strNow[0]=="Ԫ"))
     {}
    //����Ϊ��ʱ���벹������
    else if((i==7)&&(strArr[intFen-1]=="0"))
     strBig ="��"+strBig;
    //ʰ��Ǫ����һλΪ������ǰһλ�������ϣ���Ϊ������ʱ����
    else if((i<11)&&(i>7)&&(strArr[intFen-1]=="0")&&(strNow[0]!="��")&&(strNow[0]!="��"))
     strBig = "��"+strBig;
    //ʰ��Ǫ����һλΪ������ǰһλ�������ϣ�ҲΪ������ʱ���
    else if((i<11)&&(i>7)&&(strArr[intFen-1]=="0")&&(strNow[0]=="��"))
    {}
    //ʰ��Ǫ����һλΪ������ǰһλΪ��λ��Ϊ������ʱ���
    else if((i<11)&&(i>7)&&(strArr[intFen-1]=="0")&&(strNow[0]=="��"))
    {}
    //��λΪ���Ҵ���Ǫλ��ʮ������ʱ������Ǫ�䲹��
    else if((i<11)&&(i>8)&&(strArr[intFen-1]!="0")&&(strNow[0]=="��")&&(strNow[2]=="Ǫ"))
     strBig = strNum+strDW+"����"+strBig.substring(1,strBig.length());
    //����������λ
    else if(i==11)
    {
     //��λΪ������ȫΪ�����Ǫλʱ��ȥ����Ϊ��
     if((strArr[intFen-1]=="0")&&(strNow[0]=="��")&&(strNow[2]=="Ǫ"))
      strBig ="��"+"��"+strBig.substring(1,strBig.length());
     //��λΪ������ȫΪ�㲻����Ǫλʱ��ȥ����
     else if((strArr[intFen-1]=="0")&&(strNow[0]=="��")&&(strNow[2]!="Ǫ"))
      strBig ="��"+strBig.substring(1,strBig.length());
     //��λ��Ϊ������ȫΪ�����Ǫλʱ��ȥ����Ϊ��
     else if((strNow[0]=="��")&&(strNow[2]=="Ǫ"))
      strBig = strNum+strDW+"��"+strBig.substring(1,strBig.length());
     //��λ��Ϊ������ȫΪ�㲻����Ǫλʱ��ȥ���� 
     else if((strNow[0]=="��")&&(strNow[2]!="Ǫ"))
      strBig = strNum+strDW+strBig.substring(1,strBig.length()); 
     //�����������
     else
      strBig = strNum+strDW+strBig;
    }
    //ʰ�ڣ�Ǫ����һλΪ������ǰһλ�������ϣ���Ϊ������ʱ����
    else if((i<15)&&(i>11)&&(strArr[intFen-1]=="0")&&(strNow[0]!="��")&&(strNow[0]!="��"))
     strBig = "��"+strBig;
    //ʰ�ڣ�Ǫ����һλΪ������ǰһλ�������ϣ�ҲΪ������ʱ���
    else if((i<15)&&(i>11)&&(strArr[intFen-1]=="0")&&(strNow[0]=="��"))
    {}
    //ʰ�ڣ�Ǫ����һλΪ������ǰһλΪ��λ��Ϊ������ʱ���
    else if((i<15)&&(i>11)&&(strArr[intFen-1]=="0")&&(strNow[0]=="��"))
     {}
    //��λΪ���Ҳ�����Ǫ��λ��ʮ������ʱȥ���ϴ�д�����
    else if((i<15)&&(i>11)&&(strArr[intFen-1]!="0")&&(strNow[0]=="��")&&(strNow[1]=="��")&&(strNow[3]!="Ǫ"))
     strBig = strNum+strDW+strBig.substring(1,strBig.length());
    //��λΪ���Ҵ���Ǫ��λ��ʮ������ʱ������Ǫ��䲹��
    else if((i<15)&&(i>11)&&(strArr[intFen-1]!="0")&&(strNow[0]=="��")&&(strNow[1]=="��")&&(strNow[3]=="Ǫ"))
     strBig = strNum+strDW+"����"+strBig.substring(2,strBig.length());
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
   return "ת������";      //��ʧ���򷵻�ԭֵ

  } 
 }
 
 
  /** 
   * װ�����ֽڽ�ȡӢ���ַ�
   * @param str  //Ҫ��ȡ���ַ���
   * @return
   */
 public List<String> getValue(String str){
	 List<String> result=new ArrayList();
	 int size =60; //ÿ����������ֽ���
	 int startLeng =0;  //��ʼλ��   
	 int endLeng=0;    //����λ��
	 int len=str.getBytes().length; //�ַ������ֽ�����
	 String reg2="^[A-Za-z0-9]";  //������ʽ�ж�
	 char[] a=str.toCharArray();  //���ַ���ת���ֽ�
	  Pattern pattern = Pattern.compile(reg2); //ƥ���ַ�
	  //S���Ƿ���Ӣ������
	  String s_str=String.valueOf(a[a.length-1]);//���ֽ�ת���ַ���
	  Matcher m = pattern.matcher(s_str);
	 
	 while(endLeng<len){  //�Ƚ�����С���ֽ����ݾ�ѭ��
		 endLeng=size+startLeng; //�������+��ʼ��=������
		 endLeng = endLeng>len?len:endLeng; //��endLeng(�������λ)����len(�ַ����ֽ�����)ʱ����len��ֵ��endLeng����ͽ�endLeng��ֵ��endLeng
		 boolean flag =true;
		 flag=endLeng==len?true:false; //�������ַ������ֽ����Ͳ��ý�ȡ�ֽ�
		 String s= subStringByByte(str, startLeng, endLeng); //���ֽ�����ȡ���ַ���  
		 if(!m.find()){
			 startLeng=endLeng;  
			 result.add(s);
		  }else
		 {
			  startLeng=getResult(s,result,reg2,flag);//��ȡÿ�����һ�ε��ֽ���}
		 }
		 }
	 
	return result;
	 
 }
// /** 
//  * װ�����ֽڽ�ȡ�����ַ�
//  * @param str  //Ҫ��ȡ���ַ���
//  * @return
//  */
//public List<String> getValueC(String str){
//	 List<String> result=new ArrayList();
//	 int size =60; //ÿ����������ֽ���
//	 int startLeng =0;  //��ʼλ��   
//	 int endLeng=0;    //����λ��
//	 int len=str.getBytes().length; //�ַ������ֽ�����
//	 while(endLeng<len){  //�Ƚ�����С���ֽ����ݾ�ѭ��
//		 endLeng=size+startLeng; //�������+��ʼ��=������
//		 endLeng = endLeng>len?len:endLeng; //��endLeng(�������λ)����len(�ַ����ֽ�����)ʱ����len��ֵ��endLeng����ͽ�endLeng��ֵ��endLeng
//		 String s= subStringByByte(str, startLeng, endLeng); //���ֽ�����ȡ���ַ���  
//		 startLeng=endLeng;
//		 result.add(s);
//	 }
//	return result;
//	 
//}
 /**
  *���ָ���ַ���
  * @param str //�ַ���
  * @param result //װ��ȡ����ַ���
  * @param reg2 //ƥ������
  * @param flag //�Ƿ�Ҫ��ȡ�ַ���
  * @return
  */
 public  int getResult(String str,List<String> result,String reg2,boolean flag){
	 	int index=0;
	  //�����ж�һ��
	  char[] a=str.toCharArray();  //���ַ���ת���ֽ�
	  Pattern pattern = Pattern.compile(reg2); //ƥ���ַ�
	  //S���Ƿ���Ӣ������
	  String s_str=String.valueOf(a[a.length-1]);//���ֽ�ת���ַ���
	  Matcher m = pattern.matcher(s_str);
	  if(m.matches()){
		  for(int i=a.length-1;i>=0;i--){
			 String bool_str=String.valueOf(a[i]); //�ֽ�ת���ַ���
			  m= pattern.matcher(bool_str); //
			  if(!m.matches()){
				  index=i;  //���ƥ��ͻ�ȡ�ֽڵ�λ��
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
	 String str="  US EPA 3050B����Ǧ; US EPA 3052����Ǧ; US EPA 3050B������; US EPA 3052������; US EPA 3050B��Pb��Cd��Hg��Cr��Cu��Ni��Fe��Ba��Mn��Zn��Sb��As; US EPA 3052��Pb��Cd��Hg��Cr��Cu��Ni��Fe��Ba��Mn��Zn��Sb��As; ";
	 //System.out.println(str.toCharArray().length);
	//System.out.println(subStringByByte(str,0,50));
	 List<String> result =new ChangeToBig().getValue(str);
	 for(String value:result){
		 System.out.println(value);
	 }
}

 /**      * ���ֽ�����ȡ���ַ���  
  *     * @param str ԭ�ַ���    
  *       * @param byteBeginIndex ��ʼλ��     
  *        * @param byteEndIndex ����λ��    
  *          * @return ���ַ���      */   
 public static String subStringByByte(String str, int byteBeginIndex, int byteEndIndex)     
 {         
	 String result = "";        
	 int charLength = 0;  //�ַ���ת��Ϊ�ֽ�����    
	 int tempIndex1 = 0;      //�ַ��Ŀ�ʼλ��      
	 int tempIndex2 = 0;        //�ַ��Ľ���λ��   
	 int charBeginIndex = -1;  //�ֽڵĿ�ʼλ��  
	 int charEndIndex = -1;    //�ֽڵĽ���λ��        
	 if(byteEndIndex > byteBeginIndex && byteBeginIndex >= 0){     //������λ�ô��ڿ�ʼλ�ò��ҿ�ʼλ�ô���0        
		 for(int i = 0; i < str.length(); i++) { //ѭ���ַ�����                
			 charLength = str.substring(i, i + 1).getBytes().length; //��ȡ�ֽ���              
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