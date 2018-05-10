package com.lccert.crm.dao;

import java.util.List;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.Fincome;


/**
 * ����dao
 * @author LC
 *
 */
public interface FincomeDao {
	//��������
	public int addFincome(Fincome fincome) ;
	 //���ݱ��۵��Ų�ѯ�������뵥
	public Fincome getFincomeByVpid(String vpid);
	//�޸�����
	public int updateFincome(Fincome fincome);
	 //����id��ѯ�������뵥
	public Fincome getFincomeById(Integer id);
	//��ҳ��ѯ����
	public PageModel searchFincomes(Fincome fincome);
	//��ѯ���в���ҳ
	public List<Fincome> searchFincomeList(Fincome fpay);
}
