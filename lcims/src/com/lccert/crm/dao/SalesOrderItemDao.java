package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.SalesOrderItem;

public interface SalesOrderItemDao {
	
	//查询分类下面有多少个子类
	public int childs(String parentName);
	//总的试图
	public List findAllOrderItem();
	

}
