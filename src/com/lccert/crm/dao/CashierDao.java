package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.quotation.Cashier;

/**
 * ����dao
 * @author LC
 *
 */
public interface CashierDao {
	//��ӳ��ɱ�
	public int addCashier(Cashier cashier);
	public List cashierInfor(String uiNo);
	public String cashierUI();

}
