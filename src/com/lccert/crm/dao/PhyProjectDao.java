package com.lccert.crm.dao;

import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.vo.PhyStandard;


/**
 * 安规项目DAO接口
 * @author Eason
 *
 */
public interface PhyProjectDao {
	/**
	 * 安规项目排单
	 * 
	 * @param p
	 * @return
	 */
	public boolean addPhyProject(Project p);
	
	/**
	 * 查找所有安规项目列表
	 * 
	 * @param sql
	 * @return List<Project>
	 */
	public List<Project> getAllPhyProject(String sql);
	
	/**
	 * 取得一个安规项目
	 * @param sql
	 * @return
	 */
	public Project getPhyProject(String sql);
	
	/**
	 * 查找所有安规项目(分页模式)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel getAllPhyProjects(int pageNo, int pageSize, String sql);
	
	/**
	 * 取消安规项目
	 * @param sid
	 * @return
	 */
	public boolean cancelPhyProject(Project p);
	
	/**
	 * 修改安规项目
	 * @param p
	 * @return
	 */
	public boolean modifyPhyProject(Project p);
	
	/**
	 * 更新项目状态
	 * @param sid
	 * @param status
	 * @return
	 */
	public boolean updateStatus(Project p);
	
	
	/**
	 * 安规跟踪项目的明细表
	 */
	public PageModel searchMyPhyProject(int pageNo,int pageSize,String sql);
	
	/**
	 * 根据年份和月份和项目名称获取机构金额和总金额
	 */
	public float[] getPhyProjectInfor(String sql,List list);
	
	/**
	 * 根据报价单查询安规的项目内容
	 */
	
	public List getPhyProjectStatus(String sql);
	
	//根据项目名称和年份+月份，获取安规项目的状态
	public List getPhyStatus(String sql);
	
	//查询安规的项目状态
	public Map<String,String> getPhyStatusType(String sql);
	
	public boolean upPhyStart(String type, String rid, String vsid, String fid,int status);
	
	
	/**
	 * 动态（ajax方式）取得测试标准列表
	 * @param key
	 * @return
	 */
	public List<PhyStandard> getStandardByAjax(String key);
	/**
	 * 根据条件查询安规信息
	 * @param sql
	 * @return
	 */
	public PhyProject findByConditions(String sql);
	
	
}
