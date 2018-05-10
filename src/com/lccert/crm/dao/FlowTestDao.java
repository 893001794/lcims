package com.lccert.crm.dao;
/**
 * 流转单测试大项dao
 */
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.FlowTest;

public interface FlowTestDao {
	/**
	 * 根据流转单号、测试项目分页查询
	 * @param fidNo 流转单号
	 * @param fidTestName 流转单测试大项
	 * @return
	 */
	public PageModel findAllInPage(String fidNo,String fidTestName,int pageNo, int pageSize);
	/**
	 * 根据流转单号、测试项目查询列表 
	 * @param fidNo 流转单号
	 * @param fidTestName 流转单测试大项
	 * @return
	 */
	public List findAll(String fidNo,String fidTestName);
	/**
	 * 根据测试大项目获取
	 * @param fidNo
	 * @return
	 */
	public FlowTest findByFidNo(String fidNo);
//	/**
//	 * 添加流转单测试大项
//	 * @param flowTest
//	 */
//	public void saveFlowTest(FlowTest flowTest);
	/**
	 * 修改流转单测试大项
	 * @param flowTest
	 */
	public void updateFlowTest(FlowTest flowTest);
	/**
	 *  删除流转单测试大项
	 *  @param id 
	 */
	public void deleteFlowTest(Integer id);

}
