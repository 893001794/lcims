package com.lccert.crm.dao;

import java.sql.Connection;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.project.Project;

/**
 * 所有项目DAO接口
 * @author Eason
 *
 */
public interface ProjectDao {
	/**
	 * 添加新项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public boolean addStatement(Project p);
	
	/**
	 * 添加免费新项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public boolean addFreeStatement(Project p);
	
	/**
	 * 修改内部对账单
	 * 
	 * @param p
	 * @return
	 */
	public boolean modifyStatement(Project p);
	
	/**
	 * 查找项目
	 * @param sql SQL语句
	 * @return
	 */
	public Project getProject(String sql);
	
	public Flow getFlowByRid(String sql);
	
	/**
	 * 查找所有项目
	 * 
	 * @param sql  sql语句
	 * @return List<Project> 项目列表
	 */
	public List<Project> getAllProjects(String sql);
	
	/**
	 * 查找所有项目(分页模式)
	 * @param pageNo
	 * @param pageSize
	 * @param sql
	 * @return PageModel 分页模型
	 */
	public PageModel getAllProjects(int pageNo, int pageSize, String sql);

	/**
	 * 删除项目
	 * @param sql
	 */
	public void delProject(String sql,Project p);

	/**
	 * 取得已完成项目
	 * @param pageNo
	 * @param pageSize
	 * @param sql
	 * @return
	 */
	public PageModel searchProjects(int pageNo, int pageSize, String sql);
	
	/**
	 * 获取rid
	 * @param sid
	 * @return
	 */
	public String getprojectRid(String sid);
	/**
	 * 获取安规或化学
	 * @param rid
	 * @return
	 */
	public String isChemOrPhy(String rid) ;
	
	/**
	 * 获取报价单类型（化学/安规） 
	 * @param pid
	 * @return
	 */
	public String getprojectStatus(String pid);
	
	/**
	 * 根据旧的报价单号查询新的报价单信息
	 * @param oldPid
	 * @return
	 */
	public List getQuotation(String oldPid) ;
	
	/***
	 * 获取总记录数的方法
	 * @param conn
	 * @param sql
	 * @return
	 */
	public  int getTotalRecords(Connection conn , String sql) ;
	

}
