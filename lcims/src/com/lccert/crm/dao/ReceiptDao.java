package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.Receipt;

public interface ReceiptDao {
	//增加收款记录
	public int insertReceipt(List temp);
	//修改订单的信息
	public int  updateQuotation(List temp,String bank );
	//查找收据信息
	public List getInfor(String recepit);

}
