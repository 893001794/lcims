package com.lccert.oa.dao;

import java.util.List;
/***
 * 用户信息dao
 * @author tangzp
 *
 */
public interface UserInforDao {
	/**
	 * 获取所有人员信息
	 * @return
	 */
	List<?> getAllUserInfor(int groupid);
	/**
	 * 获取所有部门信息
	 * @return
	 */
	List<?> getAllGroupInfor();
	/***
	 * 获取add表中的某些字段
	 * @return
	 */
	public List<?> getAllAdd();

}
