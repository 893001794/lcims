package com.lccert.crm.project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.quotation.Quotation;
import com.temp.QuotationInput;

/**
 * 项目公共管理工具类
 * 
 * @author Eason
 * 
 */
public class ProjectAction {
	
	private static ProjectAction instance = new ProjectAction();

	private ProjectAction() {}

	public static ProjectAction getInstance() {
		return instance;
	}
	
	/**
	 * 添加新项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public synchronized boolean addStatement(Project p) {
			return DaoFactory.getInstance().getProjectDao().addStatement(p);
	}
	
	/**
	 * 添加免费新项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public synchronized boolean addFreeStatement(Project p) {
			return DaoFactory.getInstance().getProjectDao().addFreeStatement(p);
	}
	
	public synchronized String getprojectStatus(String pid) {
		return DaoFactory.getInstance().getProjectDao().getprojectStatus(pid);
}
	
	
	/**
	 * 添加旧项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public synchronized boolean addTempProject(Project p) {
		if(!("化学测试".equals(p.getPtype())||p.getPtype().indexOf("化妆品")>-1||p.getPtype().indexOf("环境")>-1))  {
			return DaoFactory.getInstance().getProjectDao().addStatement(p);
		} else {
			return QuotationInput.getInstance().addProject(p);
		}
	}
	
	
	/**
	 * 修改内部对账单
	 * @param cp
	 * @return
	 */
	public synchronized boolean modifyStatement(Project p) {
			return DaoFactory.getInstance().getProjectDao().modifyStatement(p);
	}
	
	/**
	 * 删除项目
	 * @param sid
	 */
	public void delProjectBySid(String sid) {
		Project p = getProjectBySid(sid);
		String sql = "delete from t_project where vsid = '" + sid + "'";
		DaoFactory.getInstance().getProjectDao().delProject(sql,p);
	}
	
	/**
	 * 根据id查找项目
	 * @param id
	 * @return
	 */
	public Project getProjectById(int id) {
		String sql = "select * from t_project where id = " + id;
		return DaoFactory.getInstance().getProjectDao().getProject(sql);
	}
	
	/**
	 * 根据rid查找项目
	 * @param id
	 * @return
	 */
	public Flow getFlowByRid(String  rid) {
		String sql = "select * from t_chem_flow where vrid = '" + rid+"'";
		return DaoFactory.getInstance().getProjectDao().getFlowByRid(sql);
	}
	
	
	/**
	 * 根据sid查找项目
	 * @param sid
	 * @return
	 */
	public Project getProjectBySid(String sid) {
		String sql = "select * from t_project where vsid = '" + sid + "'";
		return DaoFactory.getInstance().getProjectDao().getProject(sql);
	}
	
	/**
	 * 根据pid查找项目列表
	 * @param pid
	 * @return
	 */
	public List<Project> getAllProjectByPid(String pid) {
		String sql = "select * from t_project where vpid = '" + pid + "' ORDER BY vsid  ";
		System.out.println(sql);
//		return null;
		return DaoFactory.getInstance().getProjectDao().getAllProjects(sql);
	}
	
	/**
	 * 导出所有分项目 
	 * @param pid
	 * @param start
	 * @param end
	 * @param status
	 * @return
	 */
	public List<Project> getExportProjects(String pid, String start, String end, String status) {
		StringBuffer strbuf = new StringBuffer();
		if (!"".equals(pid) && pid != null) {
			strbuf.append(" and vpid like %'" + pid + "'%");
		}
		if (!"".equals(start) && start != null) {
			strbuf.append(" and dbuildtime > '" + start + "'");
		}
		if (!"".equals(end) && end != null) {
			strbuf.append(" and dbuildtime < '" + end + "'");
		}
		if ("yes".equals(status)) {
			strbuf.append(" and eprojectend = 'y'");
		} else if ("no".equals(status)) {
			strbuf.append(" and eprojectend = 'n'");
		}
		
		String sql = "select * from t_project where 1=1" + strbuf.toString() + " order by substring(vrid,9,12)";
		return DaoFactory.getInstance().getProjectDao().getAllProjects(sql);
	}
	
	/**
	 * 取得已完成项目
	 * @param pageNo
	 * @param pageSize
	 * @param sales
	 * @param paystatus
	 * @param status
	 * @return
	 */
	public PageModel searchProjects(int pageNo,int pageSize,String sales,String paystatus,String status,String client) {
		StringBuffer str = new StringBuffer();
		if(sales != null && !"".equals(sales)) {
			str.append(" and a.vsales like '%" + sales + "%'");
		}
		if(paystatus != null && !"".equals(paystatus)) {
			str.append(" and a.epaystatus = '" + paystatus + "'");
		}
		if(status != null && !"".equals(status)) {
			str.append(" and c.istatus = " + status);
		}
		//条件加上客户
		if(client != null && !"".equals(client)) {
			str.append(" and a.vclient like '%" + client + "%'");
		}
		String sql = "select * from t_quotation a,t_project b,t_chem_project c where b.vsid = c.vsid and a.vpid = b.vpid and a.vpid = c.vpid and date_sub(curdate(),interval 14 day)<=date(a.dcreatetime)" + str.toString();
		return DaoFactory.getInstance().getProjectDao().searchProjects(pageNo,pageSize,sql);
	}
	
	/**
	 * 查询报告单
	 * 
	 * @param keywords
	 * @param type
	 * @return 报价单列表
	 */
	public List searchVrid(String keywords) {
		String sql = "select * from t_project where vrid like '%" + keywords+ "%'";
		Connection conn = null;
		boolean auto =false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		List list = new ArrayList();
		try {
			conn = DB.getConn();
			//如果连接处于自动提交模式，则所有其 SQL 语句都将被执行并作为单独的事务提交。否则，其 SQL 语句将被分组到由提交或回滚方法终止的事务中。默认情况下，新连接处于自动提交模式。
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String sales = rs.getString("vrid");
				list.add(sales);
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
	 * 登记实验室状态时间
	 * 
	 * @param type
	 * @param rid
	 * @return
	 */
	
	public boolean updateProject(String type,String vsid,String ProjectType){
	
		boolean auto = false;
		boolean isok = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		if ("dsendtime".equals(type)) {
			 sql = "update t_chem_project set " + type+ " = now(),ismethod='"+ProjectType+"',estatus = '结案',estatus = '发证',istatus = 10,isfinish = 'y' where vsid = ?";
		 }
		 //---------------------2011-04-16------------------------
		 //else if("masendtime".equals(type)){
			// sql = "update t_chem_project set " + type
			//	+ " = now(),ismethod='"+ProjectType+"',estatus = '结案',istatus = 9,isfinish = 'y' where vsid = ?";
		// }
		 //---------------------2011-04-16------------------------
		// System.out.println(sql);
		 try {
				conn = DB.getConn();
				auto = conn.getAutoCommit();
				conn.setAutoCommit(false);
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, vsid);
				pstmt.executeUpdate();
				sql ="select vpid from t_chem_project where vsid='"+vsid+"'";
				pstmt = DB.prepareStatement(conn, sql);
				rs = pstmt.executeQuery();
				String pid ="";
				while (rs.next()) {
					pid = rs.getString("vpid");
					
				}
				sql = "update t_quotation set eisfinish='y',vstatus = '项目完成' where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, pid);
				pstmt.executeUpdate();
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
				try {
					conn.setAutoCommit(auto);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
				DB.close(pstmt);
				DB.close(conn);
			}
		return false;
	}
	
	/**
	 * 登记发放报告的时间
	 * 
	 * @param type
	 * @param rid
	 * @return
	 */
	
	public boolean updateGrantTime(String rid){
		boolean auto = false;
		boolean isok = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update t_project set granttime = now() where vrid = ?";
		 //---------------------2011-04-16------------------------
		 //else if("masendtime".equals(type)){
			// sql = "update t_chem_project set " + type
			//	+ " = now(),ismethod='"+ProjectType+"',estatus = '结案',istatus = 9,isfinish = 'y' where vsid = ?";
		// }
		 //---------------------2011-04-16------------------------
		// System.out.println(sql);
		 try {
				conn = DB.getConn();
				auto = conn.getAutoCommit();
				conn.setAutoCommit(false);
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
				pstmt.executeUpdate();
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
				try {
					conn.setAutoCommit(auto);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
				DB.close(pstmt);
				DB.close(conn);
			}
		return false;
	}
	

	/**
	 * 查询当天的停留量
	 * 
	 * @param keywords
	 * @param type
	 * @return 报价单列表
	 */
	public int findToDate(String type) {
		String sql = "select count(*) as toDayCount from t_project as p where p.vsid in   (select distinct (p.vsid) as sid from t_project as p ,t_chem_flow as f  where p.Vstatus='" + type+ "' and f.vpid =p.vpid and (date(now())-date(f.dpdtime))<=5)";
		Connection conn = null;
		boolean auto =false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		int count =0;
		try {
			conn = DB.getConn();
			//如果连接处于自动提交模式，则所有其 SQL 语句都将被执行并作为单独的事务提交。否则，其 SQL 语句将被分组到由提交或回滚方法终止的事务中。默认情况下，新连接处于自动提交模式。
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt("toDayCount");
				
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
		return count;
	}
	/**
	 * 查询报告单
	 * 
	 * @param keywords
	 * @param type
	 * @return 报价单列表
	 */
	public List  findAllToDate(String type) {
		String sql = "select distinct (p.vsid),p.*  from t_project 	as p ,t_chem_flow as f  where p.Vstatus='" + type+ "'and f.vpid =p.vpid and (date(now())-date(f.dpdtime))<=5";
		Connection conn = null;
		boolean auto =false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		List list =new ArrayList ();
		try {
			conn = DB.getConn();
			//如果连接处于自动提交模式，则所有其 SQL 语句都将被执行并作为单独的事务提交。否则，其 SQL 语句将被分组到由提交或回滚方法终止的事务中。默认情况下，新连接处于自动提交模式。
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Project p =new Project();
				p.setRid(rs.getString("vrid"));
				p.setPtype(rs.getString("eptype"));
				p.setLab(rs.getString("elab"));
				p.setIsout(rs.getString("isout"));
				p.setTestcontent(rs.getString("vtestcontent"));
				p.setType(rs.getString("etype"));
				p.setLevel(rs.getString("vlevel"));
				list.add(p);
				
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
