package com.lccert.crm.dao;

import java.util.List;

public interface QuoteDao {
	/**
	 * 查询服务实验室
	 */
	public List getServiceLab();
	
	/***
	 * 查询产品名称
	 */
	public List getProduct(String name);
	
	/***
	 * 查询服务表值
	 */
	
	public List getServiceitem(int id,String serviceLab);
	
	/***
	 * 查询服务表信息
	 * @param id 根据id来查询
	 * @return
	 */
	public List getServiceInfor(int id );
	
	/***
	 * 根据id查询标准号
	 * @param id
	 * @return
	 */
	public String getCodeById(int id);
}
