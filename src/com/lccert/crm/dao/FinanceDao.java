package com.lccert.crm.dao;

import java.util.List;

public interface FinanceDao {
	//ͳ����Ŀ
	public List projectInfor(String pid,int status);
	//��ѯ
	public List cashier(String pid,String ptype);
	//ͳ����Ŀ�ܽ��
	public float getProjectPrice(String pid ,String type);

}
