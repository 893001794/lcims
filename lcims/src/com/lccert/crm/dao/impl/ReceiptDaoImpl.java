package com.lccert.crm.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.dao.ReceiptDao;
import com.lccert.crm.quotation.Receipt;
import com.lccert.oa.db.ImsDB;

public class ReceiptDaoImpl implements ReceiptDao {
//增加收据
	public int insertReceipt(List temp) {
		String sql ="insert into t_receipt (receiptNo,vpid,vclient,vcontent,fpreadvance,vreceiptpeople,dcreatetime) values (?,?,?,?,?,?,now())";
		return new ImsDB().getCount(sql,temp);
	}

	//修改订单信息
	public int updateQuotation(List temp,String bank) {
		String sql ="";
		//System.out.println(bank);
		if(!bank.equals("") && !"借开".equals(bank)){//invprice,invtime
			sql="update t_quotation set vinvcode=?,finvprice=?,fpreadvance=?,vcreditcard=?,vpaynotes='收据',epaystatus='y',dinvtime=now(),dpaytime=now() where vpid = ?";
		}else{
			sql="update t_quotation set vinvcode=?,finvprice=?,dinvtime=now() where vpid = ?";
		}
		return new  ImsDB().getCount(sql,temp);
	}
//查找收据信息
	public List getInfor(String receiptNo) {
		//System.out.println(receiptNo);
		List temp =new ArrayList();
		temp.add("vclient");
		temp.add("vcontent");
		temp.add("fpreadvance");
		temp.add("vreceiptpeople");
		temp.add("dcreatetime");
	//	temp.add("receiptNo");
		String sql = "select vclient,vcontent,fpreadvance,vreceiptpeople,dcreatetime from t_receipt where receiptNo = ?";
		return new  ImsDB().getInforByObject(temp, sql,receiptNo);
	}


}
