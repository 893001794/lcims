package com.lccert.crm.dao;

import java.util.Date;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.Depot;

/**
 *添加仓库信息
 * @author tangzp
 *
 */
public interface DepotDao {
	public int addDepot(Depot depot,String company) ;
	String makeDid(String company,String field);
	public Depot searchDepot(int id);
	//获取所有的仓库表并且分页的功能
	public PageModel searchAllDepot(int pageNo, int pageSize);
	//更改仓库资料
	public int updateDepot(Depot depot);
	//删除仓库资料
	public int delDeport(int id );
}
