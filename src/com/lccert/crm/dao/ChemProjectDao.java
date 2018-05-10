package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.project.ChemLabTime;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.Warnning;
import com.lccert.crm.report.ReportImg;

/**
 * 化学项目DAO接口
 * @author Eason
 *
 */
public interface ChemProjectDao {
	/**
	 * 化学项目排单
	 * 
	 * @param p
	 * @return
	 */
	public boolean addChemProject(Project p);
	
	/**
	 * 修改化学项目
	 * @param p
	 * @return
	 */
	public boolean modifyChemProject(Project p);
	
	/**
	 * 取得化学项目
	 * @param sql
	 * @return
	 */
	public Project getChemProject(String sql);
	/**
	 * 取得化学项目
	 * @param sql
	 * @return
	 */
	public Project getChemProject1(String sql);
	
	/**
	 * 查找所有化学项目列表
	 * 
	 * @param sql
	 * @return List<Project>
	 */
	public List<Project> getAllChemProject(String sql);
	public List<Project> getlateListDTime(String sql,String start);
	/***]
	 * 提前两小时的预警
	 * @param sql
	 * @return
	 */
	public List<ChemProject> getSedWarning(String sql);
	/**
	 * 获取综合信息（综合包括迟单率，报告编号正确率统计）
	 */
	public List getSynthesis(String sql);
	
	/**
	 * 查找所有化学项目(分页模式)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel getAllChemProjects(int pageNo, int pageSize, String sql);
	
	/**
	 * 取消化学项目
	 * @param Project
	 * @return boolean
	 */
	public boolean cancelChemProject(Project p);
	
	/**
	 * 初检完成
	 * @param sid
	 * @return
	 */
	public boolean checkingfinish(String sid);
	
	/**
	 * 更新重测reset时间
	 * @param rid
	 * @return
	 */
	public boolean reTest(String rid);
	
	/**
	 * 根据项目号取得所有预警信息
	 * @param sid
	 * @return
	 */
	public List<Warnning> getAllWarningBySid(String sid);
	
	/**
	 * 实验室编辑项目
	 * @param p
	 * @param oldwarning
	 * @return
	 */
	public boolean Labmodify(Project p,String oldwarning);
	
	/**
	 * 添加报告图片
	 * @param img
	 * @return
	 */
	public boolean addImg(ReportImg img);

	/**
	 * 取得报告图片
	 * @param sql
	 * @return
	 */
	public List<ReportImg> getImg(String sql);
	
	/***
	 * 根据pid来查询开按时间和报告时间
	 * 
	 */
	
	public List getDcreateTime(String pid);
	
	/***
	 * 根据销售或客服人员来查看它的项目状态
	 * @param pageNo  第几页
	 * @param pageSize  每页显示多少条记录
	 * @param userName  销售或客服的名称
	 * @param dept      部门
	 * @return
	 */
	public PageModel getChemProject(int pageNo, int pageSize,String userName,String dept,int status,String type);
	
	
	
	/**
	 * 查找报告发出但是未付款的信息
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @param status 是否需要分页
	 * @return
	 */
	public PageModel searchIssueRPNoPay(int pageNo, int pageSize, String sql,String status);
	
	
	/**
	 * 获取项目状态时间（t_chem_project_time）
	 * @param sid
	 * @return
	 */
	public List<ChemLabTime> getChemLabTime(String sid);
	/**
	 * 更改状态
	 * @param Project
	 * @return boolean
	 */
	public boolean upStatus(String status,String sid);
	
	public String getEtypeByRid(String sql);
}
