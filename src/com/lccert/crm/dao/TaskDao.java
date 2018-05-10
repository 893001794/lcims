package com.lccert.crm.dao;

import java.util.List;

public interface TaskDao {
	/***
	 * ��ҳ��ѯ������Ϣ
	 * @param pageNo ��ǰΪ�ڼ�ҳ
	 * @param pageSize ÿҳ��ʾ��������¼
	 * @return
	 */
	public List getTaskInfor();
	/**
	 * ����id��ȡ��������
	 * @param id
	 * @return
	 */
	public List getTaskById (int id);
	/**
	 * ���������Ϣ
	 * @param status
	 * @param list
	 * @return
	 */
	public int addTask(List list);
	/**
	 *����������Ϣ
	 * @param list
	 * @return
	 */
	public int updTask(String status,List list);

}
