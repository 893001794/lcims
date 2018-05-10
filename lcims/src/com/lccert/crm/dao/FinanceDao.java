package com.lccert.crm.dao;

import java.util.List;

public interface FinanceDao {
	//统计项目
	public List projectInfor(String pid,int status);
	//查询
	public List cashier(String pid,String ptype);
	//统计项目总金额
	public float getProjectPrice(String pid ,String type);

}
