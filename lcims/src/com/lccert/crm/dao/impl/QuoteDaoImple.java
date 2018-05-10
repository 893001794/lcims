package com.lccert.crm.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.dao.QuoteDao;
import com.lccert.oa.db.ImsDB;

public class QuoteDaoImple implements QuoteDao {
	
	List temp =new ArrayList();
/***
 * 查询服务实验室
 */
	public List getServiceLab() {
		temp.add("id");
		temp.add("nameCH");
		String sql ="select * from t_phy_servicelab";
		return new ImsDB().getInfor(temp,sql);
	}

	/***
	 * 查询产品名称
	 */
	public List getProduct(String name) {
		temp.add("pname");
		temp.add("name");
		temp.add("item");
		temp.add("photo");
		
		String sql ="select p.serviceitem_id as item,p.nameCH as pname,pc.nameCH as name,p.photo as photo from t_phy_product as p ,t_phy_productcategory as pc  where p.productcategory_id=pc.id and  p.nameCH like  '%"+name+"%'";
//		System.out.println(sql);
		return  new ImsDB().getInfor(temp,sql);
	}

	/***
	 * 查询服务表值
	 */
	public List getServiceitem(int id,String serviceLab) {
		StringBuffer str =new StringBuffer();
		if(serviceLab !=null && !"".equals(serviceLab)){
			int labId =Integer.parseInt(serviceLab.trim());
			str.append(" and  sl.id="+labId);
		}
		temp.add("id");
		temp.add("name");
		temp.add("sid");
		temp.add("market");
		String sql ="select si.id as id,si.nameCH as name,si.standard_id as sid,si.servicemarket as market from t_phy_serviceitem as si ,t_phy_servicelab as sl where si.servicelab_id=sl.id and  si.id ="+id+""+str;
		//System.out.println(sql);
		return new ImsDB().getInfor(temp,sql);
	}
	
	/***
	 * 查询服务表信息
	 * @param id 根据id来查询
	 * @return
	 */
	public List getServiceInfor(int id) {
		temp.add("name");
		temp.add("price");
		temp.add("code");
		temp.add("demand");
		temp.add("circle");
		String sql ="select si.nameCH as name,si.price as price,s.code as code,si.sampledemand as demand,si.circle as circle  from t_phy_serviceitem as si ,t_phy_standard as s where si.standard_id=s.id and  si.id ="+id+"";
		return new ImsDB().getInfor(temp,sql);
	}

	
	
	/***
	 * 根据id查询标准号
	 * @param id
	 * @return
	 */
	public String getCodeById(int id) {
		temp.add("code");
		String sql ="select code from t_phy_standard where id ="+id+"";
		List row  =new ImsDB().getInfor(temp,sql);
		List column =(List)row.get(0);
		return column.get(0).toString();
	}

}
