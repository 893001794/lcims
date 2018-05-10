package com.lccert.crm.dao;
/**
 * ��ת�����Դ���״̬dao
 */
import java.util.List;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.FlowTestStatus;
public interface FlowTestStatusDao {
	/**
	 * ��������ҳ��ѯ
	 * @param flowTestStatus
	 * @return
	 */
	public PageModel findAllInPage(FlowTestStatus flowTestStatus,int pageNo, int pageSize);
	/**
	 *��ѯ ������Ŀ״̬�б� 
	 * @param fidNo ��ת����
	 * @param fidTestName ��ת�����Դ���
	 * @return
	 */
	public List findAll(FlowTestStatus flowTestStatus);
	/**
	 *���ݱ������ת����Ų�ѯ
	 * @param barCode ����
	 * @param flowNo ��ת����
	 * @return
	 */
	public FlowTestStatus findByBarCodeFlowNo(String	barCode,String flowNo );
	/**
	 * �����ת�����Դ���״̬
	 * @param flowTest
	 */
	public boolean saveFlowTestStatus(FlowTestStatus flowTestStatus);
	/**
	 * �޸���ת�����Դ���
	 * @param flowTest
	 */
	public void updateFlowTestStatus(FlowTestStatus flowTestStatus);
	/**
	 * ��ת�����Դ����Ų�ѯ������Ŀ����
	 * @param fidtestno ��ת�����Դ�����
	 */
	public void deleteById(Integer id);
	/**
	 * ���ݲ��Դ���Ų�ѯ������Ŀ
	 * @param fidtestno
	 * @return
	 */
	public FlowTestStatus findByFlowTestNo(String fidtestno);
	/**
	 * ����ǲ����ҵ�XRF������Ͳ����ж��ٸ���Ŀ��ֻ�Ǵ�һ��
	 * @param BarCode
	 * @param fidtestno
	 * @return
	 */
	public Boolean findByBarCode(String barCode,String fidtestno);

}
