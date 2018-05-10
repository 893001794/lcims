package com.lccert.crm.dao;

import java.util.List;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.Fincome;


/**
 * 收入dao
 * @author LC
 *
 */
public interface FincomeDao {
	//添加收入表
	public int addFincome(Fincome fincome) ;
	 //根据报价单号查询收入申请单
	public Fincome getFincomeByVpid(String vpid);
	//修改入账
	public int updateFincome(Fincome fincome);
	 //根据id查询收入申请单
	public Fincome getFincomeById(Integer id);
	//分页查询所有
	public PageModel searchFincomes(Fincome fincome);
	//查询所有不分页
	public List<Fincome> searchFincomeList(Fincome fpay);
}
