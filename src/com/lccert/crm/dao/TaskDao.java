package com.lccert.crm.dao;

import java.util.List;

public interface TaskDao {
	/***
	 * 分页查询任务信息
	 * @param pageNo 当前为第几页
	 * @param pageSize 每页显示多少条记录
	 * @return
	 */
	public List getTaskInfor();
	/**
	 * 根据id获取任务内容
	 * @param id
	 * @return
	 */
	public List getTaskById (int id);
	/**
	 * 添加任务信息
	 * @param status
	 * @param list
	 * @return
	 */
	public int addTask(List list);
	/**
	 *更改任务信息
	 * @param list
	 * @return
	 */
	public int updTask(String status,List list);

}
