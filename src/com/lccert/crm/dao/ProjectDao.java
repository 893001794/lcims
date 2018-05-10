package com.lccert.crm.dao;

import java.sql.Connection;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.project.Project;

/**
 * ������ĿDAO�ӿ�
 * @author Eason
 *
 */
public interface ProjectDao {
	/**
	 * �������Ŀ
	 * @param pj
	 * @param cp
	 * @return
	 */
	public boolean addStatement(Project p);
	
	/**
	 * ����������Ŀ
	 * @param pj
	 * @param cp
	 * @return
	 */
	public boolean addFreeStatement(Project p);
	
	/**
	 * �޸��ڲ����˵�
	 * 
	 * @param p
	 * @return
	 */
	public boolean modifyStatement(Project p);
	
	/**
	 * ������Ŀ
	 * @param sql SQL���
	 * @return
	 */
	public Project getProject(String sql);
	
	public Flow getFlowByRid(String sql);
	
	/**
	 * ����������Ŀ
	 * 
	 * @param sql  sql���
	 * @return List<Project> ��Ŀ�б�
	 */
	public List<Project> getAllProjects(String sql);
	
	/**
	 * ����������Ŀ(��ҳģʽ)
	 * @param pageNo
	 * @param pageSize
	 * @param sql
	 * @return PageModel ��ҳģ��
	 */
	public PageModel getAllProjects(int pageNo, int pageSize, String sql);

	/**
	 * ɾ����Ŀ
	 * @param sql
	 */
	public void delProject(String sql,Project p);

	/**
	 * ȡ���������Ŀ
	 * @param pageNo
	 * @param pageSize
	 * @param sql
	 * @return
	 */
	public PageModel searchProjects(int pageNo, int pageSize, String sql);
	
	/**
	 * ��ȡrid
	 * @param sid
	 * @return
	 */
	public String getprojectRid(String sid);
	/**
	 * ��ȡ�����ѧ
	 * @param rid
	 * @return
	 */
	public String isChemOrPhy(String rid) ;
	
	/**
	 * ��ȡ���۵����ͣ���ѧ/���棩 
	 * @param pid
	 * @return
	 */
	public String getprojectStatus(String pid);
	
	/**
	 * ���ݾɵı��۵��Ų�ѯ�µı��۵���Ϣ
	 * @param oldPid
	 * @return
	 */
	public List getQuotation(String oldPid) ;
	
	/***
	 * ��ȡ�ܼ�¼���ķ���
	 * @param conn
	 * @param sql
	 * @return
	 */
	public  int getTotalRecords(Connection conn , String sql) ;
	

}
