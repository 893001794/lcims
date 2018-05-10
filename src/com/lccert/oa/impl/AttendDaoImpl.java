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
         //��ʱ���Ϊ������Ȼ���ڽ��бȽ�
			try {
				Date m_endTime = new  SimpleDateFormat( "HH:mm:ss").parse(dateStr);
				//ת��Ϊ���������ֵ
				long a=m_endTime.getTime();
				//��һ��Ҫ�Ƚϵ�����ת��Ϊ��������
				Date m_b = new  SimpleDateFormat( "HH:mm:ss").parse("11:00:00");
				long b =m_b.getTime();
				//�ڶ���Ҫ�Ƚϵ�����ת��Ϊ��������
				Date m_c = new  SimpleDateFormat( "HH:mm:ss").parse("11:00:01");
				long c =m_c.getTime();
				//������Ҫ�Ƚϵ�����ת��Ϊ��������
				Date m_d = new  SimpleDateFormat( "HH:mm:ss").parse("12:30:00");
				long d =m_d.getTime();
				
				//�ڶ���Ҫ�Ƚϵ�����ת��Ϊ��������
				Date m_f = new  SimpleDateFormat( "HH:mm:ss").parse("12:30:01");
				long f =m_f.getTime();
				//������Ҫ�Ƚϵ�����ת��Ϊ��������
				Date m_g = new  SimpleDateFormat( "HH:mm:ss").parse("14:00:00");
				long g =m_g.getTime();
				
				//�ڶ���Ҫ�Ƚϵ�����ת��Ϊ��������
				Date m_h = new  SimpleDateFormat( "HH:mm:ss").parse("14:00:01");
				long h =m_h.getTime();
				//������Ҫ�Ƚϵ�����ת��Ϊ��������
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
	//��ѯ192.168.0.3 att2008����name��checktime
	public void addAttend(){
		List list =new OaDB().callResult();
		for(int i=0;i<list.size();i++){
			List temp =(List)list.get(i);
//			System.out.println(temp.get(0));
//			System.out.println(temp.get(1));
//			System.out.println(temp.get(2));
			//��ӵ�td_oa���ݿ�attend
//			String sql ="insert into attend(name,checktime,type) values(?,?,?)";
//			new OaDB().getCount(sql,temp);
			new OaDB().addAttend(temp);
		}
	}
	public static void main(String[] args) {
		new AttendDaoImpl().addAttend();
		
	}
}
