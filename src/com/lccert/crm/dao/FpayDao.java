package com.lccert.crm.dao;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.Fpay;


/**
 * 支出doa
 */
public interface FpayDao {
	//添加支出表
	public int addFpay(Fpay fpay) ;
	//修改支出
	public int updateFpay(Fpay fpay);
	 //根据id查询支出申请单
	public Fpay getFpayById(Integer id);
	//分页查询所有
	public PageModel searchFpays(Fpay fpay);
	//查询所有不分页
	public List<Fpay> searchFpayList(Fpay fpay);
}
