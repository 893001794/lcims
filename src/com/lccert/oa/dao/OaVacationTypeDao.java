package com.lccert.oa.dao;

import java.util.List;

/***
 * oa系统假期申请
 * @author tangzp
 *
 */
public interface OaVacationTypeDao {
	//获取所有假期类型的信息
	public List getOaVacationInfor(int month,int year,String beginUser,String status);
	//根据关键字去查询用户的Id
	public int getUserIdByKey(String keyWord);
	//获取顶级部门
	public List getDept();
	//根据顶级的id获取他的子类
	public List getIdByParentID(int parentId);
	//根据部门id获取人员
	public List getNameBydeptId(int deptId);
	//获取sql servser 2000 中的monselect 存储过程
	public List getSqlInfor(String userName ,String date);
	public int addAttend(List temp);
}
