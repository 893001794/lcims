package com.lccert.crm.dao;

import java.util.List;

public interface QuoteDao {
	/**
	 * ��ѯ����ʵ����
	 */
	public List getServiceLab();
	
	/***
	 * ��ѯ��Ʒ����
	 */
	public List getProduct(String name);
	
	/***
	 * ��ѯ�����ֵ
	 */
	
	public List getServiceitem(int id,String serviceLab);
	
	/***
	 * ��ѯ�������Ϣ
	 * @param id ����id����ѯ
	 * @return
	 */
	public List getServiceInfor(int id );
	
	/***
	 * ����id��ѯ��׼��
	 * @param id
	 * @return
	 */
	public String getCodeById(int id);
}
