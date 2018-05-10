package com.lccert.crm.dao;
/**
 * ��ת�����Դ���dao
 */
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.FlowTest;

public interface FlowTestDao {
	/**
	 * ������ת���š�������Ŀ��ҳ��ѯ
	 * @param fidNo ��ת����
	 * @param fidTestName ��ת�����Դ���
	 * @return
	 */
	public PageModel findAllInPage(String fidNo,String fidTestName,int pageNo, int pageSize);
	/**
	 * ������ת���š�������Ŀ��ѯ�б� 
	 * @param fidNo ��ת����
	 * @param fidTestName ��ת�����Դ���
	 * @return
	 */
	public List findAll(String fidNo,String fidTestName);
	/**
	 * ���ݲ��Դ���Ŀ��ȡ
	 * @param fidNo
	 * @return
	 */
	public FlowTest findByFidNo(String fidNo);
//	/**
//	 * �����ת�����Դ���
//	 * @param flowTest
//	 */
//	public void saveFlowTest(FlowTest flowTest);
	/**
	 * �޸���ת�����Դ���
	 * @param flowTest
	 */
	public void updateFlowTest(FlowTest flowTest);
	/**
	 *  ɾ����ת�����Դ���
	 *  @param id 
	 */
	public void deleteFlowTest(Integer id);

}
