package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.impl.ProjectChemImpl;
import com.lccert.crm.vo.ProjectChem;

/**
 * ��ӻ�ѧ�����Ŀ
 * @author lcc
 *
 */
public interface ProjectChemServlet {

	//��ӹ��̻�ѧ���
	public boolean addProjectChem(ProjectChem project);

	//��ѯ���̻�ѧ�������м�¼
	
	public PageModel searchProjectManarge(int pageNo, int pageSize, String pid,
			String rid,String orderStatus,String status); 
	
	//����Pid�õ����̵���Ա��Ϣ
	public List  getProjectUser(String pid);
	
	
}
