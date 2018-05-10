package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.project.ChemLabTime;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.Warnning;
import com.lccert.crm.report.ReportImg;

/**
 * ��ѧ��ĿDAO�ӿ�
 * @author Eason
 *
 */
public interface ChemProjectDao {
	/**
	 * ��ѧ��Ŀ�ŵ�
	 * 
	 * @param p
	 * @return
	 */
	public boolean addChemProject(Project p);
	
	/**
	 * �޸Ļ�ѧ��Ŀ
	 * @param p
	 * @return
	 */
	public boolean modifyChemProject(Project p);
	
	/**
	 * ȡ�û�ѧ��Ŀ
	 * @param sql
	 * @return
	 */
	public Project getChemProject(String sql);
	/**
	 * ȡ�û�ѧ��Ŀ
	 * @param sql
	 * @return
	 */
	public Project getChemProject1(String sql);
	
	/**
	 * �������л�ѧ��Ŀ�б�
	 * 
	 * @param sql
	 * @return List<Project>
	 */
	public List<Project> getAllChemProject(String sql);
	public List<Project> getlateListDTime(String sql,String start);
	/***]
	 * ��ǰ��Сʱ��Ԥ��
	 * @param sql
	 * @return
	 */
	public List<ChemProject> getSedWarning(String sql);
	/**
	 * ��ȡ�ۺ���Ϣ���ۺϰ����ٵ��ʣ���������ȷ��ͳ�ƣ�
	 */
	public List getSynthesis(String sql);
	
	/**
	 * �������л�ѧ��Ŀ(��ҳģʽ)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel getAllChemProjects(int pageNo, int pageSize, String sql);
	
	/**
	 * ȡ����ѧ��Ŀ
	 * @param Project
	 * @return boolean
	 */
	public boolean cancelChemProject(Project p);
	
	/**
	 * �������
	 * @param sid
	 * @return
	 */
	public boolean checkingfinish(String sid);
	
	/**
	 * �����ز�resetʱ��
	 * @param rid
	 * @return
	 */
	public boolean reTest(String rid);
	
	/**
	 * ������Ŀ��ȡ������Ԥ����Ϣ
	 * @param sid
	 * @return
	 */
	public List<Warnning> getAllWarningBySid(String sid);
	
	/**
	 * ʵ���ұ༭��Ŀ
	 * @param p
	 * @param oldwarning
	 * @return
	 */
	public boolean Labmodify(Project p,String oldwarning);
	
	/**
	 * ��ӱ���ͼƬ
	 * @param img
	 * @return
	 */
	public boolean addImg(ReportImg img);

	/**
	 * ȡ�ñ���ͼƬ
	 * @param sql
	 * @return
	 */
	public List<ReportImg> getImg(String sql);
	
	/***
	 * ����pid����ѯ����ʱ��ͱ���ʱ��
	 * 
	 */
	
	public List getDcreateTime(String pid);
	
	/***
	 * �������ۻ�ͷ���Ա���鿴������Ŀ״̬
	 * @param pageNo  �ڼ�ҳ
	 * @param pageSize  ÿҳ��ʾ��������¼
	 * @param userName  ���ۻ�ͷ�������
	 * @param dept      ����
	 * @return
	 */
	public PageModel getChemProject(int pageNo, int pageSize,String userName,String dept,int status,String type);
	
	
	
	/**
	 * ���ұ��淢������δ�������Ϣ
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @param status �Ƿ���Ҫ��ҳ
	 * @return
	 */
	public PageModel searchIssueRPNoPay(int pageNo, int pageSize, String sql,String status);
	
	
	/**
	 * ��ȡ��Ŀ״̬ʱ�䣨t_chem_project_time��
	 * @param sid
	 * @return
	 */
	public List<ChemLabTime> getChemLabTime(String sid);
	/**
	 * ����״̬
	 * @param Project
	 * @return boolean
	 */
	public boolean upStatus(String status,String sid);
	
	public String getEtypeByRid(String sql);
}
