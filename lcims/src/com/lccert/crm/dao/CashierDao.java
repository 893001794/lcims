package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.quotation.Cashier;

/**
 * 出纳dao
 * @author LC
 *
 */
public interface CashierDao {
	//添加出纳表
	public int addCashier(Cashier cashier);
	public List cashierInfor(String uiNo);
	public String cashierUI();

}
