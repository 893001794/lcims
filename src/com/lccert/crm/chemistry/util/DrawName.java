package com.lccert.crm.chemistry.util;

import java.util.HashSet;

public class DrawName {
		String surname;
		//���յ�����
	    static String[] surnameMuster = {"ŷ��","̫ʷ","��ľ","�Ϲ�","˾��","����","����","�Ϲ�","��ٹ","����",
	    	"�ĺ�","���","ξ��","����","����","�̨","�ʸ�","����","���","��ұ","̫��","����","����","Ľ��",
	    	"����","����","����","����","˾ͽ","����","˾��","����","�ӳ�","����","˾��","����","����","���","����",
	    	"����","���","����","�׸�","����","�ذ�","�й�","��ԯ","���","�θ�","����","����","����","����","����",
	    	"΢��","����","����","����","����","����","����","����","��ɽ","����","����","����","����","����","����",
	    	"����","����","���","����","����","����","�ٳ�","����","��ɣ","��ī","����","��ʦ","����"};
	    //�ж����������������Ǹ��ջ��ǵ���
	 public String getSurname(String name){
		  name = name.trim();
          boolean flag = true;
         for(int j=0;j<surnameMuster.length;j++)
         {
        	 //��ȡ������ǰ2���ַ������յ�������жԱȣ�����Աȳɹ����Ǹ��գ�������ǵ���
             if(surnameMuster[j].equals(name.substring(0,2)))
             { 
            	 //����
            	 surname=name.substring(0,2);
                 flag = false;
                 break;
             }
         }
         if(flag)
         {
        	 //����
        	 surname=name.substring(0,1);
         }
		 return surname;
	 }
	 
	  public static void main(String[] args) {
			String sex =new DrawName().getSurname("������");
			System.out.println(sex);
		}
}
