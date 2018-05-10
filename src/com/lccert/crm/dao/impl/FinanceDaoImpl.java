package com.lccert.crm.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.dao.FinanceDao;
import com.lccert.oa.db.ImsDB;

public class FinanceDaoImpl implements FinanceDao{

	public List projectInfor(String term,int status) {
		List temp=new ArrayList();
		temp.add("createtime");
		temp.add("pid");
		temp.add("client");
		temp.add("sales");
		temp.add("collection");
		temp.add("totalPrice");
		String sql  =null;
		if(status==1){
			sql ="select p.vpid as pid,q.vclient as client,q.Vsales as sales,(q.Fpreadvance+q.Fsepay+q.Fbalance) as collection ,q.Ftotalprice as totalPrice,q.Dcreatetime as  createtime from t_project as p,t_quotation as q  where q.vpid =p.vpid and q.vclient like '%"+term+"%'  group by p.vpid order by q.Dcreatetime desc";
		}else{
			sql ="select p.vpid as pid,q.vclient as client,q.Vsales as sales,(q.Fpreadvance+q.Fsepay+q.Fbalance) as collection ,q.Ftotalprice as totalPrice,q.Dcreatetime as  createtime from t_project as p,t_quotation as q  where q.vpid =p.vpid and q.vpid like '%"+term+"%'  group by p.vpid order by q.Dcreatetime desc";
		}
		return new ImsDB().getInfor(temp, sql);
	}
	public float getProjectPrice(String pid, String type) {
		String sql ="select  coalesce(sum(p.Fprice ) ,0) as price from t_project as p where p.vpid ='"+pid+"' and p.eptype='"+type+"'";
		List temp =new ArrayList();
		temp.add("price");
		List rows =new ImsDB().getInfor(temp, sql);
		List colums=(List)rows.get(0);
		float projectPrice=Float.parseFloat(colums.get(0).toString());
		return projectPrice;
	}
	public List cashier(String pid,String ptype) {
		try {
			List temp=new ArrayList();
			temp.add("fassist");
			temp.add("presubcost");
			temp.add("Fpreagcost");
			String sql ="select   coalesce(sum(fassist),0)  as fassist, coalesce(sum(presubcost) ,0) as presubcost,  coalesce(sum(Fpreagcost ),0) as Fpreagcost      from v_cashier where vpid ='"+pid+"' and ptype='"+ptype+"' ";
			return new ImsDB().getInfor(temp, sql);
		} catch (Exception e) {
			return null;
		}
	}

}
