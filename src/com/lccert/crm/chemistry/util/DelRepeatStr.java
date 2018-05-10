package com.lccert.crm.chemistry.util;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.lccert.crm.kis.ItemAction;

public class DelRepeatStr {
	 static int id =0;
	 static float totalprice=0f;
	public static void main(String[] args) {
		String str1="1201,1201,2201,2201,"; 
		Set set=new DelRepeatStr().delRepeatStr(str1);
		Iterator  it=set.iterator();
		 while(it.hasNext()){
			 String str=it.next().toString();
			 if(str !=null && !"".equals(str)){
				 id=Integer.parseInt(str);
			 }
			List list =ItemAction.getInstance().getPrice(id);
//			 System.out.println(Float.parseFloat(list.get(0).toString()));
			totalprice+=Float.parseFloat(list.get(0).toString());
		 }
		 System.out.println(totalprice);
	}
	
	public Set delRepeatStr(String str){
		String[] strs1=str.split(",");
		Set set=new HashSet();//��Ϊset���ϴ�Ų��ظ���Ԫ�أ�
		for(int i=0;i<strs1.length;i++){
			set.add(strs1[i]);//������������add����put
		}
		return set;
		
	}

}
