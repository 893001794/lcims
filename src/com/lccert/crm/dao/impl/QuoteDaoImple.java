package com.lccert.crm.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.dao.QuoteDao;
import com.lccert.oa.db.ImsDB;

public class QuoteDaoImple implements QuoteDao {
	
	List temp =new ArrayList();
/***
 * ��ѯ����ʵ����
 */
	public List getServiceLab() {
		temp.add("id");
		temp.add("nameCH");
		String sql ="select * from t_phy_servicelab";
		return new ImsDB().getInfor(temp,sql);
	}

	/***
	 * ��ѯ��Ʒ����
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
	 * ��ѯ�����ֵ
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
	 * ��ѯ�������Ϣ
	 * @param id ����id����ѯ
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
	 * ����id��ѯ��׼��
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
