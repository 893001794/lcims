package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.Subject;

/**
 * 科目dao
 * @author LC
 *
 */
public interface SubjectDao {
	 //根据三级名称查询一级和二级名称
	public Subject getSubByFirstSubName(String firstName);
}
