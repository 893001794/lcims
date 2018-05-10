package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.TestChildParent;
import com.lccert.crm.vo.TestParents;
import com.lccert.crm.vo.TestPlan;
import com.lccert.crm.vo.TopLevel;

/**
 * 
 * @author Administrator
 *t_chem_test_parent������Ŀ;
 *t_chem_test_child����Ҫ��;
 *t_chem_test_plan���Է���
 *����dao
 */

public interface ChemTestDao {
/**
 * ��ѯ������Ŀ����������
 * 
 */
	public List findChemTestParent();
	
	/**
	 * ��ѯ����Ҫ�����������
	 * 
	 */
	public List findChemTestChild();
	/**
	 * ��Ӷ���
	 */
	public boolean addTopLevel(String levelName,String chemteststatus);
		
	/**
	 * ���һ������
	 */
	public boolean addParent(TestParents tp);
	/**
	 * ��Ӷ�������
	 */
	public boolean addChild(TestChildParent tp);
	/**
	 * �����������
	 */
	public boolean addPlan(TestPlan tp);
	
	/**
	 *����������ѯ����Ҫ�����������
	 * 
	 */
	public List findChemTestChild(String type);
		
		
		/**
		 *����������ѯ������Ŀ����������
		 * 
		 */
	public List findChemTestParent(String type);
			/**
			 *����������ѯ���Է�������������
			 * 
			 */
	public List findChemTestPlan(String type);
				
	/**
	 * ��ѯ���Է���
	 */			
	public List findChemTestPlan();
	
	public List findTopLevel();
	
	/*
	 * ����Id����ѯֵ
	 */
	public TestParents getParentsById(int id);
	
	
	public TestChildParent findChildById(int id);
	
	
	public boolean upPlan(TestPlan tp);
	
	public boolean upChild(TestChildParent tp);
	public boolean upParent(TestParents tp);
	
	public String isCNAS(int id);
	
	}
