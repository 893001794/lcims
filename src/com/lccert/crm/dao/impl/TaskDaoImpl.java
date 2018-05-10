package com.lccert.crm.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.dao.TaskDao;
import com.lccert.oa.db.ImsDB;

public class TaskDaoImpl implements TaskDao {
	/***
	 * ��ҳ��ѯ������Ϣ
	 * @param pageNo ��ǰΪ�ڼ�ҳ
	 * @param pageSize ÿҳ��ʾ��������¼
	 * @return
	 */
	public List getTaskInfor() {
		String sql ="";
		List temp =new ArrayList();
		temp.add("id");
		temp.add("name");
		temp.add("vcontent");
		temp.add("period");
		temp.add("epriority");
		temp.add("estatus");
		temp.add("dcreatetime");
		temp.add("dfinishtime");
		temp.add("vapplicant");
		sql ="select * from t_task order by dcreatetime desc";
		return new ImsDB().getInfor(temp,sql);
	}

	/**
	 * ����id��ȡ��Ʒ����
	 * @param id
	 * @return
	 */
	public List getTaskById(int id) {
		String sql ="";
		List temp =new ArrayList();
		temp.add("id");
		temp.add("name");
		temp.add("vcontent");
		temp.add("period");
		temp.add("epriority");
		temp.add("estatus");
		temp.add("dcreatetime");
		temp.add("dfinishtime");
		sql ="select * from t_task where id="+id;
		return new ImsDB().getInfor(temp,sql);
	}
	/**
	 * ���������Ϣ
	 * @param id
	 * @return
	 */
	public int addTask(List list) {
		String sql ="insert into  t_task(name,vcontent,period,epriority,vapplicant,estatus,dcreatetime) values(?,?,?,?,?,?,now()) ";
		return new ImsDB().getCount(sql,list);
	}
	
	/**
	 *����������Ϣ
	 * @param status
	 * @param list
	 * @return
	 */
	public int updTask(String status,List list) {
		String sql ="";
		if(status.equals("y")){
			 sql ="update   t_task set name=?,vcontent=?,period=?,epriority=?,estatus=?,dfinishtime=now() where id =? ";
		}else{
			sql ="update   t_task set name=?,vcontent=?,period=?,epriority=?,estatus=?, where id =? ";
		}
		return new ImsDB().getCount(sql,list);
	}
}
