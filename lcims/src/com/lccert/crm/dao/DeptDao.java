package com.lccert.crm.dao;

import java.util.Map;

/**
 * 部门dao
 * @author tangzp
 *
 */
public interface DeptDao {
	 //查询所有部门的名称
	public Map<String,String> getAllDept();
	//根据部门id查询部门名称
	public String getNameById(int id);


}
