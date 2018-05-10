package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.PhyQuoteManageDao;
import com.lccert.crm.flow.FlowAction;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.oa.db.ImsDB;

public class PhyQuoteManageDaoImple implements PhyQuoteManageDao{
	/***
	 * 查询所有电子电器报价管理信息
	 * @param pageNo 第几页
	 * @param pageSize 每一页显示记录数
	 * @param sql
	 * @return
	 */
	public PageModel getAllPhyQuote(int pageNo, int pageSize,String status) {
		String sql ="";
		List temp =new ArrayList();
		if(status.equals("pc")){
			temp.add("id");
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("description");
			temp.add("salesinformation");
			sql ="select * from t_phy_productcategory";
		}
		if(status.equals("pp")){
			temp.add("id");
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("description");
			temp.add("salesinformation");
			temp.add("name");
			sql ="select pp.id as id,pp.nameCH as nameCH,pp.nameEN as nameEN,pp.description as description,pp.salesinformation as salesinformation,pc.nameCH as name from t_phy_product as pp ,t_phy_productcategory as pc where pp.productcategory_id =pc.id";
		}
		if(status.equals("ps")){
			temp.add("id");
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("code");
			temp.add("name");
			temp.add("availability");
			temp.add("suspendDate");
			sql ="select ps.id as id,ps.nameCH as nameCH,ps.nameEN as nameEN,ps.code as code,sl.nameCH as name," +
					"ps.availability as availability,ps.suspendDate as suspendDate,ps.standard_id as standard_id," +
					"ps.keywords as keywords,ps.lastupdate as lastupdate,ps.link as link from t_phy_standard as ps," +
					"t_phy_servicelab as sl where ps.servicelab_id=sl.id";
		}
		
		if(status.equals("psi")){
			temp.add("id");
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("name");
			temp.add("servicemarket");
			temp.add("standard_id");
			temp.add("restrictitem");
			temp.add("price");
			temp.add("circle");
			temp.add("sampledemand");
			sql ="select psi.id as id, psi.nameCH as nameCH,psi.nameEN as nameEN,sl.nameCH as name ,psi.servicemarket as servicemarket ," +
					"psi.standard_id as standard_id,psi.restrictitem as restrictitem,psi.price as price ,psi.circle as circle ," +
					"psi.sampledemand as sampledemand from t_phy_serviceitem as psi ,t_phy_servicelab as sl where psi.servicelab_id=sl.id";
		}
		PageModel pm = new PageModel();
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		int totalRecords = new ChemProjectDaoImplMySql().getTotalRecords(new ImsDB().getConnection(),sql);
		pm = new PageModel();
		pm.setPageNo(pageNo);
		pm.setPageSize(pageSize);
		pm.setList(new ImsDB().getInfor(temp, str));
		pm.setTotalRecords(totalRecords);
		return pm;
	}
	/***
	 * 查询所有实验室
	 */
	public List getAllLab() {
		String sql ="select * from t_phy_servicelab";
		List temp =new ArrayList();
		temp.add("id");
		temp.add("nameCH");
		return new ImsDB().getInfor(temp,sql);
	}
	
	/***
	 * 添加二部报价信息
	 * @param stratus
	 * @return
	 */
	public int addQuoteManage(String status,List list) {
		String sql ="";
		List temp =new ArrayList();
		if(status.equals("pc")){
			sql ="insert into  t_phy_productcategory(nameCH,nameEN,description,salesinformation) values(?,?,?,?) ";
		}
		if(status.equals("pp")){
			sql ="insert into  t_phy_product(nameCH,nameEN,description,salesinformation,productcategory_id,serviceitem_id) values(?,?,?,?,?,?) ";
		}
		if(status.equals("ps")){
			sql ="insert into  t_phy_standard(nameCH,nameEN,code,servicelab_id,availability,standard_id,suspendDate,keywords,lastupdate,link) values(?,?,?,?,?,?,?,?,now(),?) ";
		}
		
		if(status.equals("psi")){
			sql ="insert into  t_phy_serviceitem(nameCH,nameEN,servicelab_id,servicemarket,standard_id,restrictitem,price,circle,sampledemand) values(?,?,?,?,?,?,?,?,?) ";
		}
		return new ImsDB().getCount(sql,list);
	}
	
	/***
	 * 根据id查询所有电子电器报价的所有信息
	 * @param id
	 * @return
	 */
	public List getPhyInfor(int id,String status) {
		String sql ="";
		List temp =new ArrayList();
		if(status.equals("pc")){
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("description");
			temp.add("salesinformation");
			sql ="select * from t_phy_productcategory where id="+id+"";
		}
		if(status.equals("pp")){
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("description");
			temp.add("salesinformation");
			temp.add("productcategory_id");
			temp.add("serviceitem_id");
			sql ="select  * from t_phy_product  where id="+id+"";
		}
		if(status.equals("ps")){
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("code");
			temp.add("servicelab_id");
			temp.add("availability");
			temp.add("suspendDate");
			temp.add("standard_id");
			temp.add("keywords");
			temp.add("lastupdate");
			temp.add("link");
			sql ="select * from t_phy_standard where id="+id+"";
		}
		if(status.equals("psi")){
			temp.add("nameCH");
			temp.add("nameEN");
			temp.add("servicelab_id");
			temp.add("servicemarket");
			temp.add("standard_id");
			temp.add("restrictitem");
			temp.add("price");
			temp.add("circle");
			temp.add("sampledemand");
			sql ="select * from t_phy_serviceitem where  id="+id+"";
		}
		return new ImsDB().getInfor(temp, sql);
	}
	
	/***
	 * 修改二部报价信息
	 * @param stratus
	 * @return
	 */
	public int upQuoteManage(String status, List list,int id) {
		String sql ="";
		List temp =new ArrayList();
		if(status.equals("pc")){
			sql ="update t_phy_productcategory set nameCH=?,nameEN=?,description=?,salesinformation=? where id="+id+"";
		}
		if(status.equals("pp")){
			sql ="update t_phy_product set nameCH=?,nameEN=?,description=?,salesinformation=?,productcategory_id=?,serviceitem_id=? where id="+id+"";
		}
		if(status.equals("ps")){
			sql ="update t_phy_standard set nameCH=?,nameEN=?,code=?,servicelab_id=?,availability=?,standard_id=?,suspendDate=?,keywords=?,lastupdate=now(),link=? where id="+id+"";
		}
		
		if(status.equals("psi")){
			sql ="update t_phy_serviceitem set nameCH=?,nameEN=?,servicelab_id=?,servicemarket=?,standard_id=?,restrictitem=?,price=?,circle=?,sampledemand=? where id="+id+"";
		}
		return new ImsDB().getCount(sql,list);
	}
	/***
	 * 查询所有的产品类别
	 */
	public List getAllCategory() {
		String sql ="select * from t_phy_productcategory";
		List temp =new ArrayList();
		temp.add("id");
		temp.add("nameCH");
		return new ImsDB().getInfor(temp,sql);
	}
	/***
	 * 删除电子电器的报价信息
	 * @param id
	 * @param status 表名状态
	 * @return
	 */
	public int delectQuoteManage(String status, int id) {
		String sql ="";
		if(status.equals("pc")){
			sql ="delete from  t_phy_productcategory  where id="+id+"";
		}
		if(status.equals("pp")){
			sql ="delete from t_phy_product where id="+id+"";
		}
		if(status.equals("ps")){
			sql ="delete from t_phy_standard where id="+id+"";
		}
		
		if(status.equals("psi")){
			sql ="delete from t_phy_serviceitem where id="+id+"";
		}
		return new ImsDB().getCount(sql,new ArrayList());
	}
}
