package com.lccert.crm.chemistry.email;

import java.util.List;
import java.util.TimerTask;

import com.lccert.oa.db.OaDB;

public class OaAttendTask extends TimerTask {

	@Override
	public void run() {
		// TODO Auto-generated method stub
		addAttend();
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
			new OaDB().addAttend(temp);
		}
	}
	

}
