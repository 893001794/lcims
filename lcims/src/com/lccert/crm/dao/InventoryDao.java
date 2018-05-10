package com.lccert.crm.dao;

import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.PageModel;

/***
 * 库存信息
 * 
 * @author Administrator
 *
 */
public interface InventoryDao {
	/***
	 * 分页查询库存信息
	 * @param pageNo 当前为第几页
	 * @param pageSize 每页显示多少条记录
	 * @return
	 */
	public List getInventory(String name);
	/***
	 * 根据父类的id获取子类的类别
	 * @return
	 */
	public List getCategoryByParent(String itemNumber);
	
	/**
	 * 获取大类的产品名称
	 * @return
	 */
	public Map<String,String> getCategory();
	
	/***
	 * 分页查询产品信息
	 * @param pageNo 当前为第几页
	 * @param pageSize 每页显示多少条记录
	 * @return
	 */
	public List getProduct();
	/***
	 * 根据id获取类别名
	 * @param id
	 * @return
	 */
	public List getCategory(int id);
	/***
	 * 根据id获取库存信息
	 * @param id
	 * @return
	 */
	public List getInventory(int id);
	/***
	 * 根据级别编号获取类别名
	 * @param id
	 * @return
	 */
	public List getCategory(String itemNumber,String status);
	/**
	 * 添加库存信息
	 * @param status
	 * @param list
	 * @return
	 */
	public int addInventory(String status,List list);
	/**
	 *更改库存信息
	 * @param status
	 * @param list
	 * @return
	 */
	public int updInventory(String status,List list);
	/**
	 *删除库存信息
	 * @param status
	 * @param list
	 * @return
	 */
	public int delInventory(String status,List list);
	/**
	 * 判断该产品是否存在
	 * @param product 产品名称
	 * @param generaId 类别id
	 * @param groupId  小类id
	 * @param status  状态
	 * @return
	 */
	public List getIsProduct(String product,String standard,String status);
	/**
	 * 根据id获取产品名称
	 * @param id
	 * @return
	 */
	public List getProduct (int id);
	/**
	 * 
	 * @param productId 产品id
	 * @param area  区域
	 * @param status 状态
	 * @return
	 */
	public List getInventory(int productId,String area,String status);
	/***
	 * 统计库存信息
	 * @param year  年度统计
	 * @param area  区域
	 * @param month 月度统计
	 * @param quarter 季度统计
	 * @param status 出库或入库
	 * @return
	 */
	public List getInventory(String year,String month,String quarter,String area,String status);
}
