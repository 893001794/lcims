package com.lccert.oa.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.lccert.oa.dao.AttendDao;
import com.lccert.oa.db.OaDB;

public class AttendDaoImpl implements AttendDao {

	public int getType(String dateStr) {
		System.out.println(dateStr);
		 int type =0;
         //将时间变为毫秒数然后在进行比较
			try {
				Date m_endTime = new  SimpleDateFormat( "HH:mm:ss").parse(dateStr);
				//转化为毫秒数后的值
				long a=m_endTime.getTime();
				//第一个要比较的数据转化为毫秒数后
				Date m_b = new  SimpleDateFormat( "HH:mm:ss").parse("11:00:00");
				long b =m_b.getTime();
				//第二个要比较的数据转化为毫秒数后
				Date m_c = new  SimpleDateFormat( "HH:mm:ss").parse("11:00:01");
				long c =m_c.getTime();
				//第三个要比较的数据转化为毫秒数后
				Date m_d = new  SimpleDateFormat( "HH:mm:ss").parse("12:30:00");
				long d =m_d.getTime();
				
				//第二个要比较的数据转化为毫秒数后
				Date m_f = new  SimpleDateFormat( "HH:mm:ss").parse("12:30:01");
				long f =m_f.getTime();
				//第三个要比较的数据转化为毫秒数后
				Date m_g = new  SimpleDateFormat( "HH:mm:ss").parse("14:00:00");
				long g =m_g.getTime();
				
				//第二个要比较的数据转化为毫秒数后
				Date m_h = new  SimpleDateFormat( "HH:mm:ss").parse("14:00:01");
				long h =m_h.getTime();
				//第三个要比较的数据转化为毫秒数后
				Date m_j = new  SimpleDateFormat( "HH:mm:ss").parse("23:59:00");
				long j =m_j.getTime();
				if(a<=b){
					type =1;
				}
				if(c<=a && a<=d){
					type =2;
				}
				if(f<=a && a<=g){
					type = 3;
				}
				if(h<=a && a<=j){
					type =4;
				}

			} catch (Exception e) {
			}   
	return type;
	}
	//查询192.168.0.3 att2008正的name、checktime
	public void addAttend(){
		List list =new OaDB().callResult();
		for(int i=0;i<list.size();i++){
			List temp =(List)list.get(i);
//			System.out.println(temp.get(0));
//			System.out.println(temp.get(1));
//			System.out.println(temp.get(2));
			//添加到td_oa数据库attend
//			String sql ="insert into attend(name,checktime,type) values(?,?,?)";
//			new OaDB().getCount(sql,temp);
			new OaDB().addAttend(temp);
		}
	}
	public static void main(String[] args) {
		new AttendDaoImpl().addAttend();
		
	}
}
