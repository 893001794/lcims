package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;

public interface PhyQuoteManageDao {
	/***
	 * ��ѯ���е��ӵ������۹�����Ϣ
	 * @param pageNo �ڼ�ҳ
	 * @param pageSize ÿһҳ��ʾ��¼��
	 * @param sql
	 * @return
	 */
	public PageModel getAllPhyQuote(int pageNo, int pageSize,String status);
	
	/***
	 * ��ѯ���з���ʵ����
	 * @return
	 */
	public List getAllLab();
	
	/***
	 * ��ѯ���в�Ʒ���
	 * @return
	 */
	public List getAllCategory();
	
	/***
	 * ��Ӷ���������Ϣ
	 * @param stratus
	 * @return
	 */
	public int addQuoteManage(String stratus,List list);
	/***
	 * �޸Ķ���������Ϣ
	 * @param stratus
	 * @return
	 */
	public int upQuoteManage(String status,List list,int id);
	/***
	 * ����id��ѯ���е��ӵ������۵�������Ϣ
	 * @param id
	 * @param status ����״̬
	 * @return
	 */
	public List getPhyInfor(int id,String status);
	/***
	 * ɾ�����ӵ����ı�����Ϣ
	 * @param id
	 * @param status ����״̬
	 * @return
	 */
	public int delectQuoteManage(String status,int id);
}
