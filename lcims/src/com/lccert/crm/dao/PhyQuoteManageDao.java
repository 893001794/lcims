package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;

public interface PhyQuoteManageDao {
	/***
	 * 查询所有电子电器报价管理信息
	 * @param pageNo 第几页
	 * @param pageSize 每一页显示记录数
	 * @param sql
	 * @return
	 */
	public PageModel getAllPhyQuote(int pageNo, int pageSize,String status);
	
	/***
	 * 查询所有服务实验室
	 * @return
	 */
	public List getAllLab();
	
	/***
	 * 查询所有产品类别
	 * @return
	 */
	public List getAllCategory();
	
	/***
	 * 添加二部报价信息
	 * @param stratus
	 * @return
	 */
	public int addQuoteManage(String stratus,List list);
	/***
	 * 修改二部报价信息
	 * @param stratus
	 * @return
	 */
	public int upQuoteManage(String status,List list,int id);
	/***
	 * 根据id查询所有电子电器报价的所有信息
	 * @param id
	 * @param status 表名状态
	 * @return
	 */
	public List getPhyInfor(int id,String status);
	/***
	 * 删除电子电器的报价信息
	 * @param id
	 * @param status 表名状态
	 * @return
	 */
	public int delectQuoteManage(String status,int id);
}
