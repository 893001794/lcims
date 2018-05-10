package com.lccert.crm.dao;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.Fpay;


/**
 * ֧��doa
 */
public interface FpayDao {
	//���֧����
	public int addFpay(Fpay fpay) ;
	//�޸�֧��
	public int updateFpay(Fpay fpay);
	 //����id��ѯ֧�����뵥
	public Fpay getFpayById(Integer id);
	//��ҳ��ѯ����
	public PageModel searchFpays(Fpay fpay);
	//��ѯ���в���ҳ
	public List<Fpay> searchFpayList(Fpay fpay);
}
