package com.lccert.crm.dao;

import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.vo.PhyStandard;


/**
 * ������ĿDAO�ӿ�
 * @author Eason
 *
 */
public interface PhyProjectDao {
	/**
	 * ������Ŀ�ŵ�
	 * 
	 * @param p
	 * @return
	 */
	public boolean addPhyProject(Project p);
	
	/**
	 * �������а�����Ŀ�б�
	 * 
	 * @param sql
	 * @return List<Project>
	 */
	public List<Project> getAllPhyProject(String sql);
	
	/**
	 * ȡ��һ��������Ŀ
	 * @param sql
	 * @return
	 */
	public Project getPhyProject(String sql);
	
	/**
	 * �������а�����Ŀ(��ҳģʽ)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel getAllPhyProjects(int pageNo, int pageSize, String sql);
	
	/**
	 * ȡ��������Ŀ
	 * @param sid
	 * @return
	 */
	public boolean cancelPhyProject(Project p);
	
	/**
	 * �޸İ�����Ŀ
	 * @param p
	 * @return
	 */
	public boolean modifyPhyProject(Project p);
	
	/**
	 * ������Ŀ״̬
	 * @param sid
	 * @param status
	 * @return
	 */
	public boolean updateStatus(Project p);
	
	
	/**
	 * ���������Ŀ����ϸ��
	 */
	public PageModel searchMyPhyProject(int pageNo,int pageSize,String sql);
	
	/**
	 * ������ݺ��·ݺ���Ŀ���ƻ�ȡ���������ܽ��
	 */
	public float[] getPhyProjectInfor(String sql,List list);
	
	/**
	 * ���ݱ��۵���ѯ�������Ŀ����
	 */
	
	public List getPhyProjectStatus(String sql);
	
	//������Ŀ���ƺ����+�·ݣ���ȡ������Ŀ��״̬
	public List getPhyStatus(String sql);
	
	//��ѯ�������Ŀ״̬
	public Map<String,String> getPhyStatusType(String sql);
	
	public boolean upPhyStart(String type, String rid, String vsid, String fid,int status);
	
	
	/**
	 * ��̬��ajax��ʽ��ȡ�ò��Ա�׼�б�
	 * @param key
	 * @return
	 */
	public List<PhyStandard> getStandardByAjax(String key);
	/**
	 * ����������ѯ������Ϣ
	 * @param sql
	 * @return
	 */
	public PhyProject findByConditions(String sql);
	
	
}
