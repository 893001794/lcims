package com.lccert.crm.dao;

import java.util.Map;

/**
 * ����dao
 * @author tangzp
 *
 */
public interface DeptDao {
	 //��ѯ���в��ŵ�����
	public Map<String,String> getAllDept();
	//���ݲ���id��ѯ��������
	public String getNameById(int id);


}
