package com.lccert.crm.dao;

import java.util.Map;
/**
 * 品牌dao
 * @author tangzp
 *
 */
public interface CategoryDao {
	 //查询所品牌名称
	public Map<String,String> getAllCategory(int classId);


}
