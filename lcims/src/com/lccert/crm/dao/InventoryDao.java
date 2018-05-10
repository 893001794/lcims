package com.lccert.crm.dao;

import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.PageModel;

/***
 * �����Ϣ
 * 
 * @author Administrator
 *
 */
public interface InventoryDao {
	/***
	 * ��ҳ��ѯ�����Ϣ
	 * @param pageNo ��ǰΪ�ڼ�ҳ
	 * @param pageSize ÿҳ��ʾ��������¼
	 * @return
	 */
	public List getInventory(String name);
	/***
	 * ���ݸ����id��ȡ��������
	 * @return
	 */
	public List getCategoryByParent(String itemNumber);
	
	/**
	 * ��ȡ����Ĳ�Ʒ����
	 * @return
	 */
	public Map<String,String> getCategory();
	
	/***
	 * ��ҳ��ѯ��Ʒ��Ϣ
	 * @param pageNo ��ǰΪ�ڼ�ҳ
	 * @param pageSize ÿҳ��ʾ��������¼
	 * @return
	 */
	public List getProduct();
	/***
	 * ����id��ȡ�����
	 * @param id
	 * @return
	 */
	public List getCategory(int id);
	/***
	 * ����id��ȡ�����Ϣ
	 * @param id
	 * @return
	 */
	public List getInventory(int id);
	/***
	 * ���ݼ����Ż�ȡ�����
	 * @param id
	 * @return
	 */
	public List getCategory(String itemNumber,String status);
	/**
	 * ��ӿ����Ϣ
	 * @param status
	 * @param list
	 * @return
	 */
	public int addInventory(String status,List list);
	/**
	 *���Ŀ����Ϣ
	 * @param status
	 * @param list
	 * @return
	 */
	public int updInventory(String status,List list);
	/**
	 *ɾ�������Ϣ
	 * @param status
	 * @param list
	 * @return
	 */
	public int delInventory(String status,List list);
	/**
	 * �жϸò�Ʒ�Ƿ����
	 * @param product ��Ʒ����
	 * @param generaId ���id
	 * @param groupId  С��id
	 * @param status  ״̬
	 * @return
	 */
	public List getIsProduct(String product,String standard,String status);
	/**
	 * ����id��ȡ��Ʒ����
	 * @param id
	 * @return
	 */
	public List getProduct (int id);
	/**
	 * 
	 * @param productId ��Ʒid
	 * @param area  ����
	 * @param status ״̬
	 * @return
	 */
	public List getInventory(int productId,String area,String status);
	/***
	 * ͳ�ƿ����Ϣ
	 * @param year  ���ͳ��
	 * @param area  ����
	 * @param month �¶�ͳ��
	 * @param quarter ����ͳ��
	 * @param status ��������
	 * @return
	 */
	public List getInventory(String year,String month,String quarter,String area,String status);
}
