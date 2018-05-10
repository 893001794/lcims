package com.lccert.crm.dao;


import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.impl.ArticleDaoImpl;
import com.lccert.crm.dao.impl.CashierDaoImpl;
import com.lccert.crm.dao.impl.CategoryDaoImpl;
import com.lccert.crm.dao.impl.ChemProjectDaoImplMySql;
import com.lccert.crm.dao.impl.DepotDaoImpl;
import com.lccert.crm.dao.impl.DeptDaoImpl;
import com.lccert.crm.dao.impl.FinanceDaoImpl;
import com.lccert.crm.dao.impl.FincomeDaoImpl;
import com.lccert.crm.dao.impl.FlowTestDaoImpl;
import com.lccert.crm.dao.impl.FlowTestStatusDaoImpl;
import com.lccert.crm.dao.impl.FpayDaoImpl;
import com.lccert.crm.dao.impl.InventoryDaoImpl;
import com.lccert.crm.dao.impl.PhyProjectDaoImplMySql;
import com.lccert.crm.dao.impl.PhyQuoteManageDaoImple;
import com.lccert.crm.dao.impl.ProjectDaoImplMySql;
import com.lccert.crm.dao.impl.QuoteDaoImple;
import com.lccert.crm.dao.impl.ReceiptDaoImpl;
import com.lccert.crm.dao.impl.SampleDaoImpl;
import com.lccert.crm.dao.impl.SubjectDaoImpl;
import com.lccert.crm.dao.impl.TaskDaoImpl;
import com.lccert.crm.quotation.Cashier;
import com.lccert.crm.vo.Subject;
import com.lccert.oa.dao.OaVacationTypeDao;
import com.lccert.oa.impl.OaVacationTypeDaoImpl;
import com.lccert.oa.vo.OaVacationType;

/**
 * Dao工厂类
 * 专门用于生产相应的dao类
 * @author tangzp
 *
 */
public class DaoFactory {
	
	private static DaoFactory instance = null;

	private DaoFactory() {}

	public synchronized static DaoFactory getInstance() {
		if (instance == null) {
			instance = new DaoFactory();
		}
		return instance;
	}
	
	/**
	 * 生产项目DAO
	 * @return
	 */
	public ProjectDao getProjectDao() {
		return new ProjectDaoImplMySql();
	}
	
	

	/**
	 * 生产化学项目DAO
	 * @return
	 */
	public ChemProjectDao getChemProjectDao() {
		return new ChemProjectDaoImplMySql();
	}
	
	
	
	/**
	 * 生产安规项目DAO
	 * @return
	 */
	public PhyProjectDao getPhyProjectDao() {
		return new PhyProjectDaoImplMySql();
	}
	
	
	
	/**
	 *物品登记
	 * @return
	 */
	public ArticleDao getArticleDao() {
		return new ArticleDaoImpl();
	}
	
	/**
	 *品牌
	 * @return
	 */
	public CategoryDao getCategoryDao() {
		return new CategoryDaoImpl();
	}
	
	/**
	 * 部门DeptDao
	 */
	
	public DeptDao getDeptDao() {
		return new DeptDaoImpl();
	}
	
	/**
	 * 仓库Depot
	 */
	
	public DepotDao getDepotDao() {
		return new DepotDaoImpl();
	}
   /**
    * oa假期申请
    */
	
	public OaVacationTypeDao getOaVacationTypeDao(){
		return new OaVacationTypeDaoImpl();
	}
	
/**
 * 样品信息
 */
	public SampleDao getSimpleDao(){
		return new SampleDaoImpl();
	}
	
	/***
	 * 获取服务实验的名称
	 */
	public QuoteDao getQuoteDao(){
		return new QuoteDaoImple();
	}
	/***
	 * 电子电器报价管理公共信息
	 */
	public PhyQuoteManageDao getPhyQuoteManageDao(){
		return new PhyQuoteManageDaoImple();
	}
	/***
	 * 库存信息
	 */
	public InventoryDao getInventoryDao(){
		return new InventoryDaoImpl();
	}
	
	/***
	 * 任务信息
	 */
	public TaskDao getTaskDao(){
		return new TaskDaoImpl();
	}
	
	/***
	 * 收据信息
	 */
	public ReceiptDao getReceipt(){
		return new ReceiptDaoImpl();
	}
	/**
	 * 项目收款
	 */
	public FinanceDao getProjectPrice(){
		return new FinanceDaoImpl();
	}
	/***
	 * 出纳
	 */
	
	public CashierDao getCashier(){
		return new CashierDaoImpl();
	}
	/**
	 * 收入表
	 * @return
	 */
	public FincomeDao getFincome(){
		return new FincomeDaoImpl();
	}
	
	/**
	 * 支出表
	 * @return
	 */
	public FpayDao getFpay(){
		return new FpayDaoImpl();
	}
	/**
	 * 科目
	 * @return
	 */
	public SubjectDao getSubject(){
		return new SubjectDaoImpl();
	}
	/**
	 * 实验室流转单
	 * @return
	 */
	public FlowTestDao getFlowTest(){
		return new FlowTestDaoImpl();
	}
	
	public FlowTestStatusDao getFlowTestStatus(){
		return new FlowTestStatusDaoImpl();
	}
}
