package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.SalesOrderItem;

public interface SalesOrderItemDao {
	
	//��ѯ���������ж��ٸ�����
	public int childs(String parentName);
	//�ܵ���ͼ
	public List findAllOrderItem();
	

}
