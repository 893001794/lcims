package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.Receipt;

public interface ReceiptDao {
	//�����տ��¼
	public int insertReceipt(List temp);
	//�޸Ķ�������Ϣ
	public int  updateQuotation(List temp,String bank );
	//�����վ���Ϣ
	public List getInfor(String recepit);

}
