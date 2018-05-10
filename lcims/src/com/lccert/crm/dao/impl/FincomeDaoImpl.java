package com.lccert.crm.dao.impl;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.FincomeDao;
import com.lccert.crm.vo.Fincome;
import com.lccert.crm.vo.Fpay;

public class FincomeDaoImpl implements FincomeDao {
	private  final String TABLE="t_fincome"; 
	private  final String FIELD="dpaytime,client,vpyear,vpmonth,vpid,dept,sales,chem,safe,op,emc,dr,vip,eq,finance,gz,total,account,einvtype,province,city,einvno,remarks,createtime";
	public int addFincome(Fincome fincome) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int key =0;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into "+TABLE+" ("+FIELD+") values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,fincome.getDpaytime());
			pstmt.setString(2,fincome.getClient());
			pstmt.setString(3,fincome.getVpyear());
			pstmt.setString(4,fincome.getVpmonth());
			pstmt.setString(5,fincome.getVpid());
			pstmt.setString(6,fincome.getDept());
			pstmt.setString(7,fincome.getSales());
			pstmt.setDouble(8,fincome.getChem());
			pstmt.setDouble(9,fincome.getSafe());
			pstmt.setDouble(10,fincome.getOp()==null?0.0:fincome.getOp());
			pstmt.setDouble(11,fincome.getEmc()==null?0.0:fincome.getEmc());
			pstmt.setDouble(12,fincome.getDr()==null?0.0:fincome.getDr());
			pstmt.setDouble(13,fincome.getVip()==null?0.0:fincome.getVip());
			pstmt.setDouble(14,fincome.getEq()==null?0.0:fincome.getEq());
			pstmt.setDouble(15,fincome.getFinance()==null?0.0:fincome.getFinance());
			pstmt.setDouble(16,fincome.getGz()==null?0.0:fincome.getGz());
			pstmt.setDouble(17,fincome.getTotal()==null?0.0:fincome.getTotal());
			pstmt.setString(18,fincome.getAccount());
			pstmt.setString(19,fincome.getEinvtype());
			pstmt.setString(20,fincome.getProvince());
			pstmt.setString(21,fincome.getCity());
			pstmt.setString(22,fincome.getEinvno());
			pstmt.setString(23,fincome.getRemarks());
			pstmt.setString(24,new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();  //getGeneratedKeys自动获取主键的方法
			rs.next();
			key= rs.getInt(1);
			conn.commit();
			isok = true;
		} catch (SQLException e) {
			isok = false;
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return key;
	}
	
	/**
	 * 根据报价单号查询收入申请单
	 * @param id
	 * @return
	 */
	public Fincome getFincomeByVpid(String vpid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Fincome fincome = new Fincome();
		String sql = "select * from "+TABLE+" where vpid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, vpid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				fincome.setId(rs.getInt("id"));
				fincome.setDpaytime(rs.getString("dpaytime"));
				fincome.setClient(rs.getString("client"));
				fincome.setVpyear(rs.getString("vpyear"));
				fincome.setVpmonth(rs.getString("vpmonth"));
				fincome.setVpid(rs.getString("vpid"));
				fincome.setDept(rs.getString("dept"));
				fincome.setSales(rs.getString("sales"));
				fincome.setChem(rs.getDouble("chem"));
				fincome.setSafe(rs.getDouble("safe"));
				fincome.setOp(rs.getDouble("op"));
				fincome.setEmc(rs.getDouble("emc"));
				fincome.setDr(rs.getDouble("dr"));
				fincome.setVip(rs.getDouble("vip"));
				fincome.setEq(rs.getDouble("eq"));
				fincome.setFinance(rs.getDouble("finance"));
				fincome.setGz(rs.getDouble("gz"));
				fincome.setTotal(rs.getDouble("total"));
				fincome.setAccount(rs.getString("account"));
				fincome.setEinvtype(rs.getString("einvtype"));
				fincome.setProvince(rs.getString("province"));
				fincome.setCity(rs.getString("city"));
				fincome.setEinvno(rs.getString("einvno"));
				fincome.setRemarks(rs.getString("remarks"));
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
//		System.out.println("dpaytime："+fincome.getDpaytime()+"----,client："+fincome.getClient()+"----,vpyear："+fincome.getVpyear()+"----,vpmonth："+fincome.getVpmonth()+"----,vpid："+fincome.getVpid()+"----,dept："+fincome.getDept()+"----,sales："+fincome.getSales()+"----,chem："+fincome.getChem()+"----,safe："+fincome.getSafe()+"----,op："+fincome.getOp()+"----,emc："+fincome.getEmc()+"----,dr："+fincome.getDr()+"----,vip："+fincome.getVip()+"----,eq："+fincome.getEq()+"----,finance："+fincome.getFinance()+"----,gz："+fincome.getGz()+"----,total："+fincome.getTotal()+"----,account："+fincome.getAccount()+"----,einvtype："+fincome.getEinvtype()+"----,province："+fincome.getProvince()+"----,city："+fincome.getCity()+"----,einvno："+fincome.getEinvno()+"----,remarks："+fincome.getRemarks());
		return fincome;
	}

	public int updateFincome(Fincome fincome) {
		//System.out.println("dpaytime："+fincome.getDpaytime()+"----,client："+fincome.getClient()+"----,vpyear："+fincome.getVpyear()+"----,vpmonth："+fincome.getVpmonth()+"----,vpid："+fincome.getVpid()+"----,dept："+fincome.getDept()+"----,sales："+fincome.getSales()+"----,chem："+fincome.getChem()+"----,safe："+fincome.getSafe()+"----,op："+fincome.getOp()+"----,emc："+fincome.getEmc()+"----,dr："+fincome.getDr()+"----,vip："+fincome.getVip()+"----,eq："+fincome.getEq()+"----,finance："+fincome.getFinance()+"----,gz："+fincome.getGz()+"----,total："+fincome.getTotal()+"----,account："+fincome.getAccount()+"----,einvtype："+fincome.getEinvtype()+"----,province："+fincome.getProvince()+"----,city："+fincome.getCity()+"----,einvno："+fincome.getEinvno()+"----,remarks："+fincome.getRemarks());
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int key =0;
		String sql = "update "+TABLE+"  set dpaytime=?,client=?,vpyear=?,vpmonth=?,vpid=?,dept=?,sales=?,chem=?,safe=?,op=?,emc=?,dr=?,vip=?,eq=?,finance=?,gz=?,total=?,account=?,einvtype=?,province=?,city=?,einvno=?,remarks=? where id=?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,fincome.getDpaytime());
			pstmt.setString(2,fincome.getClient());
			pstmt.setString(3,fincome.getVpyear());
			pstmt.setString(4,fincome.getVpmonth());
			pstmt.setString(5,fincome.getVpid());
			pstmt.setString(6,fincome.getDept());
			pstmt.setString(7,fincome.getSales());
			pstmt.setDouble(8,fincome.getChem());
			pstmt.setDouble(9,fincome.getSafe());
			pstmt.setDouble(10,fincome.getOp()==null?0.0:fincome.getOp());
			pstmt.setDouble(11,fincome.getEmc()==null?0.0:fincome.getEmc());
			pstmt.setDouble(12,fincome.getDr()==null?0.0:fincome.getDr());
			pstmt.setDouble(13,fincome.getVip()==null?0.0:fincome.getVip());
			pstmt.setDouble(14,fincome.getEq()==null?0.0:fincome.getEq());
			pstmt.setDouble(15,fincome.getFinance()==null?0.0:fincome.getFinance());
			pstmt.setDouble(16,fincome.getGz()==null?0.0:fincome.getGz());
			pstmt.setDouble(17,fincome.getTotal()==null?0.0:fincome.getTotal());
			pstmt.setString(18,fincome.getAccount());
			pstmt.setString(19,fincome.getEinvtype());
			pstmt.setString(20,fincome.getProvince());
			pstmt.setString(21,fincome.getCity());
			pstmt.setString(22,fincome.getEinvno());
			pstmt.setString(23,fincome.getRemarks());
			pstmt.setInt(24, fincome.getId());
			pstmt.executeUpdate();
			key=1;
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return key;
	}

		/**
		 * 根据报价单号查询收入申请单
		 * @param id
		 * @return
		 */
		public Fincome getFincomeById(Integer id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean auto = false;
			Fincome fincome = new Fincome();
			String sql = "select * from "+TABLE+" where id = ?";
			try {
				conn = DB.getConn();
				auto = conn.getAutoCommit();
				conn.setAutoCommit(false);
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					fincome.setId(rs.getInt("id"));
					fincome.setDpaytime(rs.getString("dpaytime"));
					fincome.setClient(rs.getString("client"));
					fincome.setVpyear(rs.getString("vpyear"));
					fincome.setVpmonth(rs.getString("vpmonth"));
					fincome.setVpid(rs.getString("vpid"));
					fincome.setDept(rs.getString("dept"));
					fincome.setSales(rs.getString("sales"));
					fincome.setChem(rs.getDouble("chem"));
					fincome.setSafe(rs.getDouble("safe"));
					fincome.setOp(rs.getDouble("op"));
					fincome.setEmc(rs.getDouble("emc"));
					fincome.setDr(rs.getDouble("dr"));
					fincome.setVip(rs.getDouble("vip"));
					fincome.setEq(rs.getDouble("eq"));
					fincome.setFinance(rs.getDouble("finance"));
					fincome.setGz(rs.getDouble("gz"));
					fincome.setTotal(rs.getDouble("total"));
					fincome.setAccount(rs.getString("account"));
					fincome.setEinvtype(rs.getString("einvtype"));
					fincome.setProvince(rs.getString("province"));
					fincome.setCity(rs.getString("city"));
					fincome.setEinvno(rs.getString("einvno"));
					fincome.setRemarks(rs.getString("remarks"));
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
//			System.out.println("dpaytime："+fincome.getDpaytime()+"----,client："+fincome.getClient()+"----,vpyear："+fincome.getVpyear()+"----,vpmonth："+fincome.getVpmonth()+"----,vpid："+fincome.getVpid()+"----,dept："+fincome.getDept()+"----,sales："+fincome.getSales()+"----,chem："+fincome.getChem()+"----,safe："+fincome.getSafe()+"----,op："+fincome.getOp()+"----,emc："+fincome.getEmc()+"----,dr："+fincome.getDr()+"----,vip："+fincome.getVip()+"----,eq："+fincome.getEq()+"----,finance："+fincome.getFinance()+"----,gz："+fincome.getGz()+"----,total："+fincome.getTotal()+"----,account："+fincome.getAccount()+"----,einvtype："+fincome.getEinvtype()+"----,province："+fincome.getProvince()+"----,city："+fincome.getCity()+"----,einvno："+fincome.getEinvno()+"----,remarks："+fincome.getRemarks());
			return fincome;
	}

		public PageModel searchFincomes(Fincome fincome) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				boolean auto = false;
				PageModel pm = new PageModel();
				List<Fincome> list = new ArrayList<Fincome>();
				StringBuffer str = new StringBuffer();
				String vpid=fincome.getVpid();
				String client=fincome.getClient();
				String startDpaytime=fincome.getStartDpaytime();
				String endDayTiem=fincome.getEndDayTiem();
				String startCreatetime=fincome.getStartCreatetime();
				String endCreatetime=fincome.getEndCreatetime();
				if(vpid !=null && !"".equals(vpid)){
					str.append(" and vpid = '"+vpid+"' ");
				}
				if(client !=null && !"".equals(client)){
					str.append(" and client like '%"+client+"%' ");
				}
				if(startDpaytime !=null && !"".equals(startDpaytime)){
					str.append(" and dpaytime >= '"+startDpaytime+"' ");
				}
				if(endDayTiem !=null && !"".equals(endDayTiem)){
					str.append(" and dpaytime <= '"+endDayTiem+"' ");
				}
				if(startCreatetime !=null && !"".equals(startCreatetime)){
					str.append(" and createtime >= '"+startCreatetime+"' ");
				}
				if(endCreatetime !=null && !"".equals(endCreatetime)){
					str.append(" and createtime <= '"+endCreatetime+"' ");
				}
				Integer pageSize=fincome.getPageSize();
				Integer pageNo=fincome.getPageNo();
				String sql=null;
				 sql = "select * from "+TABLE+" where 1=1 "+ str.toString()+" order by id desc limit "
					+ (fincome.getPageNo() - 1) * fincome.getPageSize() + ", " + fincome.getPageSize();
				 System.out.println(sql);
				try {
					conn = DB.getConn();
					auto = conn.getAutoCommit();
					conn.setAutoCommit(false);
					pstmt = DB.prepareStatement(conn, sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						fincome = new Fincome();
						fincome.setId(rs.getInt("id"));
						fincome.setDpaytime(rs.getString("dpaytime"));
						fincome.setClient(rs.getString("client"));
						fincome.setVpyear(rs.getString("vpyear"));
						fincome.setVpmonth(rs.getString("vpmonth"));
						fincome.setVpid(rs.getString("vpid"));
						fincome.setDept(rs.getString("dept"));
						fincome.setSales(rs.getString("sales"));
						fincome.setChem(rs.getDouble("chem"));
						fincome.setSafe(rs.getDouble("safe"));
						fincome.setOp(rs.getDouble("op"));
						fincome.setEmc(rs.getDouble("emc"));
						fincome.setDr(rs.getDouble("dr"));
						fincome.setVip(rs.getDouble("vip"));
						fincome.setEq(rs.getDouble("eq"));
						fincome.setFinance(rs.getDouble("finance"));
						fincome.setGz(rs.getDouble("gz"));
						fincome.setTotal(rs.getDouble("total"));
						fincome.setAccount(rs.getString("account"));
						fincome.setEinvtype(rs.getString("einvtype"));
						fincome.setProvince(rs.getString("province"));
						fincome.setCity(rs.getString("city"));
						fincome.setEinvno(rs.getString("einvno"));
						fincome.setRemarks(rs.getString("remarks"));
						list.add(fincome);
					}
					
					String tsql= "select count(*) from "+TABLE+" where 1=1" + str.toString();
					int totalRecords = getTotalRecords(conn,tsql);
					pm.setPageNo(pageNo);
					pm.setPageSize(pageSize);
					pm.setList(list);
					pm.setTotalRecords(totalRecords);
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
				return pm;
			}
		
		/**
		 * 取得所有的记录数
		 * 
		 * @param conn
		 *            connection
		 * @param createuser
		 * @return 所有的记录数
		 */
		private int getTotalRecords(Connection conn,String sql) {
			int totalRecords = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement(conn, sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalRecords = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs);
				DB.close(pstmt);
			}
			return totalRecords;
		}

		public List<Fincome> searchFincomeList(Fincome fincome) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean auto = false;
			List<Fincome> list = new ArrayList<Fincome>();
			StringBuffer str = new StringBuffer();
			String vpid=fincome.getVpid();
			String client=fincome.getClient();
			String startDpaytime=fincome.getStartDpaytime();
			String endDayTiem=fincome.getEndDayTiem();
			String startCreatetime=fincome.getStartCreatetime();
			String endCreatetime=fincome.getEndCreatetime();
			if(vpid !=null && !"".equals(vpid)){
				str.append(" and vpid = '"+vpid+"' ");
			}
			if(client !=null && !"".equals(client)){
				str.append(" and client like '%"+client+"%' ");
			}
			if(startDpaytime !=null && !"".equals(startDpaytime)){
				str.append(" and dpaytime >= '"+startDpaytime+"' ");
			}
			if(endDayTiem !=null && !"".equals(endDayTiem)){
				str.append(" and dpaytime <= '"+endDayTiem+"' ");
			}
			if(startCreatetime !=null && !"".equals(startCreatetime)){
				str.append(" and createtime <= '"+startCreatetime+"' ");
			}
			if(endCreatetime !=null && !"".equals(endCreatetime)){
				str.append(" and createtime <= '"+endCreatetime+"' ");
			}
			Integer pageSize=fincome.getPageSize();
			Integer pageNo=fincome.getPageNo();
			String sql=null;
			 sql = "select * from "+TABLE+" where 1=1 "+ str.toString()+" order by id desc ";
			try {
				conn = DB.getConn();
				auto = conn.getAutoCommit();
				conn.setAutoCommit(false);
				pstmt = DB.prepareStatement(conn, sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					fincome = new Fincome();
					fincome.setId(rs.getInt("id"));
					fincome.setDpaytime(rs.getString("dpaytime"));
					fincome.setClient(rs.getString("client"));
					fincome.setVpyear(rs.getString("vpyear"));
					fincome.setVpmonth(rs.getString("vpmonth"));
					fincome.setVpid(rs.getString("vpid"));
					fincome.setDept(rs.getString("dept"));
					fincome.setSales(rs.getString("sales"));
					fincome.setChem(rs.getDouble("chem"));
					fincome.setSafe(rs.getDouble("safe"));
					fincome.setOp(rs.getDouble("op"));
					fincome.setEmc(rs.getDouble("emc"));
					fincome.setDr(rs.getDouble("dr"));
					fincome.setVip(rs.getDouble("vip"));
					fincome.setEq(rs.getDouble("eq"));
					fincome.setFinance(rs.getDouble("finance"));
					fincome.setGz(rs.getDouble("gz"));
					fincome.setTotal(rs.getDouble("total"));
					fincome.setAccount(rs.getString("account"));
					fincome.setEinvtype(rs.getString("einvtype"));
					fincome.setProvince(rs.getString("province"));
					fincome.setCity(rs.getString("city"));
					fincome.setEinvno(rs.getString("einvno"));
					fincome.setRemarks(rs.getString("remarks"));
					list.add(fincome);
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
}
