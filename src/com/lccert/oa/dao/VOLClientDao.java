package com.lccert.oa.dao;

import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;

/***
 * �ɽ��ͻ�����Dao
 * @author Administrator
 *
 */
public interface VOLClientDao {
	/***
	 *��ȡ�ɽ��ͻ�����Ϣ
	 * @param condition1  ��ѯ����1
	 * @param condition2  ��ѯ����2
	 * @param start  ��ʼʱ��
	 * @param end    ����ʱ��
	 * @param tracking  ���ٽ���
	 * @param client  �ͻ�
	 * @param custom �Զ���ѯ��
	 * @param content �Զ���ѯ������
	 * @return
	 */
	public PageModel getVOLInfor(int pageNo, int pageSize,String followstate,String step,String condition1,String condition2,String start ,String end ,String tracking,String client,String custom,String content,String ctsName);
	/***
	 * ��ѯ��ϵ����
	 * @param custId  ��ϵ�ͻ�Id
	 * @return
	 */
	public List getContact(int custId,String status);
	/***
	 * ��ѯ�ͻ�����
	 * @param custId  ��ϵ�ͻ�Id
	 * @return
	 */
	public List getCustomer(int custId);
	/***
	 * �����ϵ��¼
	 * @return
	 */
	public int addContact(List temp);
	/***
	 * ��ȡ��ϵ�������һ���ֶ�id
	 * @return
	 */
	public List getContactId();
	/***
	 * ɾ����ϵ��¼
	 * @param contactId
	 * @return
	 */
	public int delContact(int contactId);
	/***
	 * �޸���ϵ��¼
	 * @param contactId
	 * @return
	 */
	public int updContact(List temp);
}
