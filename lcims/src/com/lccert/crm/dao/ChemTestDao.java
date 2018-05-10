package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.TestChildParent;
import com.lccert.crm.vo.TestParents;
import com.lccert.crm.vo.TestPlan;
import com.lccert.crm.vo.TopLevel;

/**
 * 
 * @author Administrator
 *t_chem_test_parent测试项目;
 *t_chem_test_child测试要求;
 *t_chem_test_plan测试方法
 *集合dao
 */

public interface ChemTestDao {
/**
 * 查询测试项目的所以名称
 * 
 */
	public List findChemTestParent();
	
	/**
	 * 查询测试要求的所以名称
	 * 
	 */
	public List findChemTestChild();
	/**
	 * 添加顶级
	 */
	public boolean addTopLevel(String levelName,String chemteststatus);
		
	/**
	 * 添加一级分类
	 */
	public boolean addParent(TestParents tp);
	/**
	 * 添加二级分类
	 */
	public boolean addChild(TestChildParent tp);
	/**
	 * 添加三级分类
	 */
	public boolean addPlan(TestPlan tp);
	
	/**
	 *根据条件查询测试要求的所以名称
	 * 
	 */
	public List findChemTestChild(String type);
		
		
		/**
		 *根据条件查询测试项目的所以名称
		 * 
		 */
	public List findChemTestParent(String type);
			/**
			 *根据条件查询测试方法的所以名称
			 * 
			 */
	public List findChemTestPlan(String type);
				
	/**
	 * 查询测试方法
	 */			
	public List findChemTestPlan();
	
	public List findTopLevel();
	
	/*
	 * 根据Id来查询值
	 */
	public TestParents getParentsById(int id);
	
	
	public TestChildParent findChildById(int id);
	
	
	public boolean upPlan(TestPlan tp);
	
	public boolean upChild(TestChildParent tp);
	public boolean upParent(TestParents tp);
	
	public String isCNAS(int id);
	
	}
