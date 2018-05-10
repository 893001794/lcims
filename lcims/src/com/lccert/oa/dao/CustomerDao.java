package com.lccert.oa.dao;

import java.util.List;
/***
 * 客户dao
 * @author tangzp
 *
 */
public interface CustomerDao {
	/**
	 * 获取客户简称和销售名称
	 * @return
	 */
	List<?> userList(int status,String keywords);

}
