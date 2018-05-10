package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.InventoryDao;
import com.lccert.crm.project.Project;
import com.lccert.crm.vo.Inventory;
import com.lccert.crm.vo.ProjectChem;
import com.lccert.oa.db.ImsDB;
/***
 * 库存信息实现类
 * 
 * @author Administrator
 *
 */
public class InventoryDaoImpl implements InventoryDao {
	/***
	 * 分页查询库存信息
	 * @param pageNo 当前为第几页
	 * @param pageSize 每页显示多少条记录
	 * @return
	 */
	public List getInventory(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Inventory> list = new ArrayList<Inventory>();
		Inventory i=null;
		String sql ="";
		if(name !=null){
			 sql ="select * from t_product as p where name like '%"+name+"%'";
		}else{
			 sql ="select * from t_product as p";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
//			System.out.println(sql+"***---");
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				//根据产品id获取库存
				List row1 =(List)getInventory(rs.getInt("p.id"),"中山","入库");
				List row2 =(List)getInventory(rs.getInt("p.id"),"中山","出库");
				List row3 =(List)getInventory(rs.getInt("p.id"),"东莞","入库");
				List row4 =(List)getInventory(rs.getInt("p.id"),"东莞","出库");
				List column1 =new ArrayList();
				if(row1.size()>0){
					column1=(List)row1.get(0);
				}
				List column2=new ArrayList();
				if(row2.size()>0){
					column2=(List)row2.get(0);
				}
				List column3=new ArrayList();
				if(row3.size()>0){
					column3=(List)row3.get(0);
				}
				List column4=new ArrayList();
				if(row4.size()>0){
					column4=(List)row4.get(0);
				}
				i =new Inventory();
				i.setPid(rs.getInt("p.id"));
				i.setName(rs.getString("p.name"));
				i.setStandardNo(rs.getString("p.vstandardNo"));
				//获取类型的名称
				List rowList =getCategory(rs.getInt("p.groupId"));
				List temp =(List)rowList.get(0);
				i.setCategory(temp.get(0).toString());
			//	i.setArea(row1.get(4).toString());
				i.setUnit(rs.getString("p.vunit"));
				i.setPrice(rs.getFloat("p.fprice"));
				i.setWarning(rs.getInt("warningCount"));
				try {
				if(column1.size()>0){
				if(column1.get(1)!=null){
				i.setInventoryNumber(Integer.parseInt(column1.get(1).toString()));
				}
				if(column1.get(1)!=null){
				i.setHistoryprice(Float.parseFloat(column1.get(3).toString()));
				}
				}
				if(column2.size()>0){
					if(column2.get(1) !=null){
					i.setTOTAL(Integer.parseInt(column2.get(1).toString()));
					}
					if(column2.get(2)!=null){
					i.setLastTime(new SimpleDateFormat("yyyy-MM-dd HH:ss").parse(column2.get(2).toString()));
					}
				}
				if(column3.size()>0){
					if(column3.get(1)!=null){
					i.setInventoryNumber1(Integer.parseInt(column3.get(1).toString()));
					}
					if(column3.get(1)!=null){
					i.setHistoryprice1(Float.parseFloat(column3.get(3).toString()));
					}
				}
				if(column4.size()>0){
					if(column4.get(1)!=null){
					i.setTOTAL1(Integer.parseInt(column4.get(1).toString()));
					}
					if(column4.get(2)!=null){
					i.setLastTime1(new SimpleDateFormat("yyyy-MM-dd HH:ss").parse(column4.get(2).toString()));
					}
				}
				} catch (ParseException e) {
					e.printStackTrace();
				}
				list.add(i);
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	/***
	 * 根据父类的id获取子类的类别
	 * @return
	 */
	public List getCategoryByParent(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List row=getCategory(Integer.parseInt(id));
		List temp=(List)row.get(0);
		List list = new ArrayList ();
		String sql ="";
			sql = "select  * from t_category where item_number is not null and parentid =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, temp.get(1).toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				List column=new ArrayList();
				column.add(rs.getInt("id"));
				column.add(rs.getString("vname"));
				list.add(column);
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	
	/**
	 * 获取大类的产品名称
	 * @return
	 */
	public Map<String, String> getCategory() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select  * from t_category where item_number is not null and parentid ='00'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int  id = rs.getInt("id");
				String name = rs.getString("vname");
				map.put(id+"", name);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	public List getProduct() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List list = new ArrayList ();
		String sql ="select * from t_product";
//		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				List column =new ArrayList();
				column.add(rs.getInt("id"));
				column.add(rs.getString("name"));
				column.add(rs.getString("vstandardNo"));
				//获取父类名称
				List preateRow=getCategory(rs.getInt("genera"));
				List preateColumn =(List)preateRow.get(0);
				column.add(preateColumn.get(0).toString());
				//获取子类名称
				List childRow =getCategory(rs.getInt("groupId"));
				List childColumn =(List)childRow.get(0);
				column.add(childColumn.get(0).toString());
				column.add(rs.getString("vunit"));
				column.add(rs.getFloat("fprice"));
				list.add(column);
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	/***
	 * 根据id获取类别名
	 * @param id
	 * @return
	 */
	public List getCategory(int id) {
//		System.out.println(id+"---");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List row =new ArrayList();
		String sql ="select  * from t_category where id =? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List columns =new ArrayList();
				columns.add(rs.getString("vname"));
				columns.add(rs.getString("item_number"));
				row.add(columns);
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return row;
	}

	public int addInventory(String status,List list) {
		String sql ="";
		if(status.equals("product")){
			sql ="insert into  t_product(name,vstandardNo,genera,groupId,vunit,fprice,vclient,warningCount,assets) values(?,?,?,?,?,?,?,?,?) ";
		}
		if(status.equals("inventory")){
			sql ="insert into  t_inventory(productid,varea,inventoryNumber,vstatus,fhistoryprice,vclient,vremark,dstoring) values(?,?,?,?,?,?,?,now()) ";
		}
		return new ImsDB().getCount(sql,list);
	}
	
	public List getCategory(String itemNumber,String status) {
		String sql ="";
		List temp =new ArrayList();
		if(status.equals("product")){
			temp.add("id");
			sql ="select * from t_category where item_number='"+itemNumber+"'";
		}
		
		return new ImsDB().getInfor(temp, sql);
	}
	public List getIsProduct(String product,String standard,String status) {
		String sql ="";
		List temp =new ArrayList();
		if(status.equals("product")){
			temp.add("id");
			sql ="select * from t_product where name='"+product+"' and vstandardNo='"+standard+"'";
		}
		return new ImsDB().getInfor(temp,sql);
	}
	
	/**
	 * 根据id获取产品名称
	 * @param id
	 * @return
	 */
	public List getProduct(int id) {
		String sql ="";
		List temp =new ArrayList();
		temp.add("name");
		temp.add("fprice");
		temp.add("vclient");
		temp.add("genera");
		temp.add("groupId");
		temp.add("vunit");
		temp.add("vstandardNo");
		temp.add("warningCount");
		temp.add("assets");
		sql ="select * from t_product where id="+id;
		return new ImsDB().getInfor(temp,sql);
	}
	/**
	 * 
	 * @param productId 产品id
	 * @param area  区域
	 * @param status 状态
	 * @return
	 */
	public List getInventory(int productId, String area, String status) {
		String sql ="";
		List temp =new ArrayList();
		temp.add("id");
		temp.add("a");
		temp.add("dstoring");
		temp.add("fhistoryprice");
		temp.add("varea");
		sql ="select id,inventoryNumber as a,fhistoryprice,dstoring,varea from t_inventory where productid ="+productId+" and varea ='"+area+"' and vstatus='"+status+"'";
//		System.out.println(sql+"----");
		return new ImsDB().getInfor(temp,sql);
	}
	/***
	 * 统计库存信息
	 * @param year  年度统计
	 * @param month 月度统计
	 * @param quarter 季度统计
	 * @param status 出库或入库
	 * @return
	 */
	public List getInventory(String year, String month, String quarter,String area,String status) {
		List temp= new ArrayList();
		temp.add("id");
		temp.add("productid");
		temp.add("varea");
		temp.add("inventoryNumber");
		temp.add("fhistoryprice");
		temp.add("vclient");
		temp.add("vstatus");
		temp.add("vremark");
		temp.add("dstoring");
		StringBuffer str =new StringBuffer();
		if(!year.equals("") && year !=null){
			str.append(" and "+year+"=year(dstoring)");
		}
		if(!month.equals("") && month !=null){
			str.append(" and "+month+"=month(dstoring)");
		}
		if(!quarter.equals("") && quarter !=null){
			str.append(" and "+quarter+"=quarter(dstoring)");
		}
		if(!area.equals("") && area !=null){
			str.append(" and varea='"+area+"'");
		}
		if(!status.equals("") && status !=null){
			str.append(" and vstatus='"+status+"'");
		}
		String sql ="select * from t_inventory where 1=1 "+str;
//		System.out.println(sql);/
		 return new ImsDB().getInfor(temp,sql);
	}
	
	/**
	 *更改库存信息
	 * @param status
	 * @param list
	 * @return
	 */
	public int updInventory(String status, List list) {
		String sql ="";
		if(status.equals("product")){
			sql ="update  t_product set name=?,vstandardNo=?,genera=?,groupId=?,vunit=?,fprice=?,vclient=?,warningCount=?,assets=? where id=?";
		}
		if(status.equals("inventory")){
			sql ="update   t_inventory set productid=?,varea=?,inventoryNumber=?,vstatus=?,fhistoryprice=?,vclient=?,vremark=? where id =? ";
		}
		return new ImsDB().getCount(sql,list);
	}
	/**
	 *删除库存信息
	 * @param status
	 * @param list
	 * @return
	 */
	public int delInventory(String status, List list) {
		String sql ="";
		if(status.equals("product")){
			sql ="delete from  t_product  where id=?";
		}
		if(status.equals("inventory")){
			sql ="delete from   t_inventory where id=?";
		}
		return new ImsDB().getCount(sql,list);
	}
	/***
	 * 根据id获取库存信息
	 * @param id
	 * @return
	 */
	public List getInventory(int id) {
		String sql ="";
		List temp =new ArrayList();
		temp.add("productid");
		temp.add("varea");
		temp.add("inventoryNumber");
		temp.add("fhistoryprice");
		temp.add("vclient");
		temp.add("vstatus");
		temp.add("vremark");
		sql ="select * from t_inventory where id="+id;
		return new ImsDB().getInfor(temp,sql);
	}
	
}
