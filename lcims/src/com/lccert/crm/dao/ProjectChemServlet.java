package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.impl.ProjectChemImpl;
import com.lccert.crm.vo.ProjectChem;

/**
 * 添加化学检测项目
 * @author lcc
 *
 */
public interface ProjectChemServlet {

	//添加工程化学检测
	public boolean addProjectChem(ProjectChem project);

	//查询工程化学检测的所有记录
	
	public PageModel searchProjectManarge(int pageNo, int pageSize, String pid,
			String rid,String orderStatus,String status); 
	
	//根据Pid得到工程的人员信息
	public List  getProjectUser(String pid);
	
	
}
