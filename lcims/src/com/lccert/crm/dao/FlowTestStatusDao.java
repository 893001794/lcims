package com.lccert.crm.dao;
/**
 * 流转单测试大项状态dao
 */
import java.util.List;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.FlowTestStatus;
public interface FlowTestStatusDao {
	/**
	 * 按条件分页查询
	 * @param flowTestStatus
	 * @return
	 */
	public PageModel findAllInPage(FlowTestStatus flowTestStatus,int pageNo, int pageSize);
	/**
	 *查询 测试项目状态列表 
	 * @param fidNo 流转单号
	 * @param fidTestName 流转单测试大项
	 * @return
	 */
	public List findAll(FlowTestStatus flowTestStatus);
	/**
	 *根据编码和流转单编号查询
	 * @param barCode 编码
	 * @param flowNo 流转单号
	 * @return
	 */
	public FlowTestStatus findByBarCodeFlowNo(String	barCode,String flowNo );
	/**
	 * 添加流转单测试大项状态
	 * @param flowTest
	 */
	public boolean saveFlowTestStatus(FlowTestStatus flowTestStatus);
	/**
	 * 修改流转单测试大项
	 * @param flowTest
	 */
	public void updateFlowTestStatus(FlowTestStatus flowTestStatus);
	/**
	 * 流转单测试大项编号查询测试项目名称
	 * @param fidtestno 流转单测试大项编号
	 */
	public void deleteById(Integer id);
	/**
	 * 根据测试大项号查询测试项目
	 * @param fidtestno
	 * @return
	 */
	public FlowTestStatus findByFlowTestNo(String fidtestno);
	/**
	 * 如果是拆样室的XRF或剪样就不管有多少个项目都只是打一次
	 * @param BarCode
	 * @param fidtestno
	 * @return
	 */
	public Boolean findByBarCode(String barCode,String fidtestno);

}
