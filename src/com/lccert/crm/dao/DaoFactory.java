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
 * Dao������
 * ר������������Ӧ��dao��
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
	 * ������ĿDAO
	 * @return
	 */
	public ProjectDao getProjectDao() {
		return new ProjectDaoImplMySql();
	}
	
	

	/**
	 * ������ѧ��ĿDAO
	 * @return
	 */
	public ChemProjectDao getChemProjectDao() {
		return new ChemProjectDaoImplMySql();
	}
	
	
	
	/**
	 * ����������ĿDAO
	 * @return
	 */
	public PhyProjectDao getPhyProjectDao() {
		return new PhyProjectDaoImplMySql();
	}
	
	
	
	/**
	 *��Ʒ�Ǽ�
	 * @return
	 */
	public ArticleDao getArticleDao() {
		return new ArticleDaoImpl();
	}
	
	/**
	 *Ʒ��
	 * @return
	 */
	public CategoryDao getCategoryDao() {
		return new CategoryDaoImpl();
	}
	
	/**
	 * ����DeptDao
	 */
	
	public DeptDao getDeptDao() {
		return new DeptDaoImpl();
	}
	
	/**
	 * �ֿ�Depot
	 */
	
	public DepotDao getDepotDao() {
		return new DepotDaoImpl();
	}
   /**
    * oa��������
    */
	
	public OaVacationTypeDao getOaVacationTypeDao(){
		return new OaVacationTypeDaoImpl();
	}
	
/**
 * ��Ʒ��Ϣ
 */
	public SampleDao getSimpleDao(){
		return new SampleDaoImpl();
	}
	
	/***
	 * ��ȡ����ʵ�������
	 */
	public QuoteDao getQuoteDao(){
		return new QuoteDaoImple();
	}
	/***
	 * ���ӵ������۹�������Ϣ
	 */
	public PhyQuoteManageDao getPhyQuoteManageDao(){
		return new PhyQuoteManageDaoImple();
	}
	/***
	 * �����Ϣ
	 */
	public InventoryDao getInventoryDao(){
		return new InventoryDaoImpl();
	}
	
	/***
	 * ������Ϣ
	 */
	public TaskDao getTaskDao(){
		return new TaskDaoImpl();
	}
	
	/***
	 * �վ���Ϣ
	 */
	public ReceiptDao getReceipt(){
		return new ReceiptDaoImpl();
	}
	/**
	 * ��Ŀ�տ�
	 */
	public FinanceDao getProjectPrice(){
		return new FinanceDaoImpl();
	}
	/***
	 * ����
	 */
	
	public CashierDao getCashier(){
		return new CashierDaoImpl();
	}
	/**
	 * �����
	 * @return
	 */
	public FincomeDao getFincome(){
		return new FincomeDaoImpl();
	}
	
	/**
	 * ֧����
	 * @return
	 */
	public FpayDao getFpay(){
		return new FpayDaoImpl();
	}
	/**
	 * ��Ŀ
	 * @return
	 */
	public SubjectDao getSubject(){
		return new SubjectDaoImpl();
	}
	/**
	 * ʵ������ת��
	 * @return
	 */
	public FlowTestDao getFlowTest(){
		return new FlowTestDaoImpl();
	}
	
	public FlowTestStatusDao getFlowTestStatus(){
		return new FlowTestStatusDaoImpl();
	}
}
