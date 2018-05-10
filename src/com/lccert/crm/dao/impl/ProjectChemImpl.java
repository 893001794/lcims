package com.lccert.crm.dao.impl;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.ProjectChemServlet;
import com.lccert.crm.kis.OrderAction;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.system.ForumAction;
import com.lccert.crm.vo.ProjectChem;
import com.lccert.www.UpdateWebSite;
/***
 * 项目测试的实现类
 * @author tangzp
 *
 */
public class ProjectChemImpl implements ProjectChemServlet {
	
	private static ProjectChemImpl instance = null;

	private ProjectChemImpl() {

	}

	
	
//添加工程检测表
	public boolean addProjectChem(ProjectChem project) {
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		int key = 0;
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "insert into  t_project_chem_test(vpid,vrid,vprojectcontent,dcompletetime,estimate" +
					",itestcount,dcreatetime,vprojectleader,vprojectissuer,vitem,vsid,rpclient,vsamplename,vwarning) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, project.getPid());
			pstmt.setString(2, project.getRid().trim());
			pstmt.setString(3, project.getProjectcontent());
			pstmt.setTimestamp(4, new Timestamp(project.getCompletetime().getTime()));
			pstmt.setInt(5, project.getEstimate());
			pstmt.setInt(6, project.getItestcount());
			pstmt.setTimestamp(7,new Timestamp(project.getCreatetime().getTime()));
			pstmt.setString(8, project.getProjectleader());
			pstmt.setString(9, project.getProjectissuer());
			pstmt.setString(10, project.getItem());
			pstmt.setString(11, project.getSid());
			pstmt.setString(12, project.getRpclient());
			pstmt.setString(13, project.getSamplename());
			pstmt.setString(14, project.getWarning());

			pstmt.executeUpdate();
			
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}

	public boolean upProjectChem(ProjectChem project) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		int key = 0;
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "update  t_project_chem_test set vprojectleader=?,vprojectissuer=?,itestcount=?,vwarning=? where vrid =?";
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, project.getProjectleader());
			pstmt.setString(2, project.getProjectissuer());
			pstmt.setInt(3, project.getItestcount());
			pstmt.setString(4, project.getWarning());
			pstmt.setString(5, project.getRid());
			pstmt.executeUpdate();
			
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
	
	public boolean upProjectTime(Project p) {
		ChemProject cp =(ChemProject)p.getObj();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		int key = 0;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "update  t_project_chem_test set dcompletetime=? where vrid =?";
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setTimestamp(1, cp.getRptime()==null?null:new Timestamp(cp.getRptime().getTime()));
			pstmt.setString(2,p.getRid());
			
			pstmt.executeUpdate();
			
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
	
	
	
	
//删除工程检测表
	public boolean delProjectChem(String rid) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		int key = 0;
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "delete from  t_project_chem_test where vrid =?";
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, rid);
			pstmt.executeUpdate();
			
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
	
	
	
	public synchronized static ProjectChemImpl getInstance() {
		if (instance == null) {
			instance = new ProjectChemImpl();
		}
		return instance;
	}

	//查询工程化学检测的所有记录
	
	public PageModel searchProjectManarge(int pageNo, int pageSize, String pid,
			String rid, String orderStatus,String status) {
		
		//dcompletetime-------Projectleader--------projectName--------finish-----NFinish
		String sql="";
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and vpid = '" + pid + "'");
		}
		if(rid != null && !"".equals(rid)) {
			str.append(" and vrid like '%" + rid + "%'");
		}
		 
		if(orderStatus != null && !"".equals(orderStatus)){
			if(orderStatus.equals("dcompletetime")){
				str.append(" order by dcompletetime desc");
			}
			if(orderStatus.equals("Projectleader")){
				str.append(" order by vprojectleader asc");
			}
			if(orderStatus.equals("projectName")){
				str.append(" order by vprojectcontent asc");
			}
			if(orderStatus.equals("ridOrder")){
				str.append(" order by vrid desc");
			}
			
		}
		if(status.equals("product")){
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='成品'" + str.toString();
		}if(status.equals("food")){
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='食品'" + str.toString();
		}
		return getAllProjectManarge(pageNo, pageSize, sql);
	}
	
	
//查询工程化学检测的所有记录
	
	public List searchProjectManarge(String year,String month,String sale,String pid,String rid,String isfinish,String status) {
		//dcompletetime-------Projectleader--------projectName--------finish-----NFinish
//		System.out.println(status+"-----------");
		String sql="";
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and vpid = '" + pid + "'");
		}
		if(rid != null && !"".equals(rid)) {
			str.append(" and vrid like '%" + rid + "%'");
		}
		if(year !=null && !"".equals(year)){
			str.append(" and year(dcreatetime)="+year+"");
		}
		if(month !=null && !"".equals(month)){
			str.append(" and month(dcreatetime)="+month+"");
		}
		if(sale !=null && !"".equals(sale)){
			str.append(" and vprojectleader like '%"+sale+"%'");
		}
		
		if(isfinish !=null && !"".equals(isfinish)){
			str.append(" and isfinish ='"+isfinish+"'");
		}
		if(status.equals("product")){
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='成品'" + str.toString();
		}if(status.equals("food")){
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='食品'" + str.toString();
		}
//		System.out.println(sql+"------");
		return getAllProjectManarge(sql);
	}
	
	
	public PageModel searchOutProject(int pageNo, int pageSize, String subname,String status,String tuvtype) {
		
		//dcompletetime-------Projectleader--------projectName--------finish-----NFinish
		StringBuffer str = new StringBuffer();
		if(subname != null && !"".equals(subname)) {
			str.append(" and p.Vsubname like '%" +subname+ "%'");
		}
		if(status != null && !"".equals(status) && !"all".equals(status)) {
			str.append(" and cp.Isfinish='"+status+"' ");
		}
		
		if(tuvtype.equals("tuv")){
			str.append(" and p.etype='机构合作'  ");
			
		}
		if(tuvtype.equals("pout")){
			str.append(" and p.etype !='机构合作'and p.isout ='y' ");
		}
		
		String sql = "select distinct(cp.vrid),p.id as '项目id',p.vpid as '报价单编号',p.vsid as '项目编号', p.vrid as '项目报告号',p.Vtestcontent as '项目内容',p.dortime as '应回数据时间',p.dbqtime as '请款时间',p.foeprice as '实际外包金额'," +
				"p.dostime as '发出分包登记',q.Vsales as '负责销售',cp.Vsamplename as '样品名称' ,p.Vsubname as '外包分机构名称',p.Vagname as '机构名称'," +
				"p.doetime as '实际回数据时间',q.Vclient as '客户名称',p.vtuvno as 'TUV编号',p.Fsubcost2 as '实际外部分包费B',p.fpresubcost as '外包机构费A' from t_project as p,t_quotation as q,t_chem_project as cp  where " +
				"  p.vpid =q.vpid and cp.vrid =p.vrid  " + str.toString()+"order by p.dbuildtime desc";
		//System.out.println(sql+"--------------------");
		return getAllOutProject(pageNo, pageSize,sql);
	}
	
	//判断一个字符串是否含有英文字母的方法
	public int countstring(String zifuc)
	 {

		//String zifuc="300HD";
	  int i=0,countLow=0,countUp=0,countNo=0;
	  while(i!=zifuc.length())
	  {
	   if(zifuc.charAt(i)>='a'&&zifuc.charAt(i)<='z')
	    countLow++;
	   else if(zifuc.charAt(i)>='A'&&zifuc.charAt(i)<='Z')
	    countUp++;
	   else countNo++;
	   i++;
	  }
	 // System.out.println("大写英文字母个数为: "+countUp+"\n小写英文字母个数为: "+countLow+"\n非英文字母个数为:   "+countNo);
	  return countUp;
	 }

	//将查出来的数据进行分页
	public PageModel getAllProjectManarge(int pageNo, int pageSize, String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<ProjectChem> list = new ArrayList<ProjectChem>();
		ProjectChem p=null;
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p =new ProjectChem();
				p.setId(rs.getInt("id"));
				p.setPid(rs.getString("vpid"));
				p.setRid(rs.getString("vrid"));
				p.setObject(ProjectChemImpl.getInstance().getProjectStatus(p.getRid()));
//				p.setObject1(ProjectChemImpl.getInstance().getStatus(p.getRid()));
				p.setSid(rs.getString("vsid"));
				p.setProjectcontent(rs.getString("vprojectcontent"));
				p.setCompletetime(rs.getTimestamp("dcompletetime"));
				p.setEstimate(rs.getInt("estimate"));
				p.setItestcount(rs.getInt("itestcount"));
				p.setCreatetime(rs.getTimestamp("dcreatetime"));
				p.setProjectleader(rs.getString("vprojectleader"));
				p.setProjectissuer(rs.getString("vprojectissuer"));
				p.setRpclient(rs.getString("rpclient"));
				p.setSamplename(rs.getString("vsamplename"));
				list.add(p);
			}
			int totalRecords =new ChemProjectDaoImplMySql().getTotalRecords(conn,sql);
			pm = new PageModel();
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

	
	//将查出来的数据进行分页
	public List getAllProjectManarge(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<ProjectChem> list = new ArrayList<ProjectChem>();
		ProjectChem p=null;
//		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn,sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p =new ProjectChem();
				p.setId(rs.getInt("id"));
				p.setPid(rs.getString("vpid"));
				p.setRid(rs.getString("vrid"));
				p.setObject(ProjectChemImpl.getInstance().getProjectStatus(p.getRid()));
				p.setSid(rs.getString("vsid"));
				p.setProjectcontent(rs.getString("vprojectcontent"));
				p.setCompletetime(rs.getTimestamp("dcompletetime"));
				p.setEstimate(rs.getInt("estimate"));
				p.setItestcount(rs.getInt("itestcount"));
				p.setCreatetime(rs.getTimestamp("dcreatetime"));
				p.setProjectleader(rs.getString("vprojectleader"));
				p.setProjectissuer(rs.getString("vprojectissuer"));
				p.setRpclient(rs.getString("rpclient"));
				p.setSamplename(rs.getString("vsamplename"));
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

	
	//将查出来的数据进行分页
	public PageModel getAllOutProject(int pageNo, int pageSize, String sql) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Project> list = new ArrayList<Project>();
		Project p=null;
		 //p.id as '', p.vrid as '',p.Vtestcontent as '',p.dortime as '',p.dbqtime as '',p.Fprice as ''," +
			//"p.dostime as '',q.Vsales as '',cp.Vsamplename as '' ,p.Vsubname as '',p.Vagname as ''," +
			//"p.doetime as ''
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p =new Project();
				p.setId(rs.getInt("项目id"));
				p.setPid(rs.getString("报价单编号"));
				p.setSid(rs.getString("项目编号"));
				p.setRid(rs.getString("项目报告号"));
				p.setTestcontent(rs.getString("项目内容"));
				p.setOrtime(rs.getTimestamp("应回数据时间"));
				p.setBqtime(rs.getTimestamp("请款时间"));
				p.setPrice(rs.getFloat("实际外包金额"));
				p.setOstime(rs.getTimestamp("发出分包登记"));
				p.setSales(rs.getString("负责销售"));
				p.setSamplename(rs.getString("样品名称"));
				p.setSubname(rs.getString("外包分机构名称"));
				p.setAgname(rs.getString("机构名称"));
				p.setOetime(rs.getTimestamp("实际回数据时间"));
				p.setClient(rs.getString("客户名称"));
				p.setSubcost2(rs.getFloat("实际外部分包费B"));
				p.setPresubcost(rs.getString("外包机构费A"));
				p.setTuvno(rs.getString("TUV编号"));
				list.add(p);
			}
			int totalRecords =new ChemProjectDaoImplMySql().getTotalRecords(conn,sql);
			pm = new PageModel();
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
	
	
//根据pid到下拉列表的值
	public List  getProjectUser(String pid){
		
		String sql ="select vprojectleader,vprojectissuer,itestcount,vwarning from t_project_chem_test  where 1=1 and vpid =? order by dcreatetime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("vprojectleader"));
				list.add(rs.getString("vprojectissuer"));
				list.add(rs.getInt("itestcount"));
				list.add(rs.getString("vwarning"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;
	}
	
	
	/**
	 * 根据报告号查询化妆品号
	 * @param rid
	 * @return
	 */
	public String  getFilingno(String rid){
		
		String sql ="select filingno from t_chem_project  where 1=1 and vrid =? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String filingno="";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				filingno=rs.getString("filingno");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return filingno ;
	}
	
	
	/**
	 * 获取项目的状态
	 * 2010-9-14
	 * @param pid
	 * @return
	 */
	public  String   getProjectStatus(String rid){
		rid=rid.trim();
		String sql ="select vstatus from t_chem_project_time where vrid =? order by dtime desc limit 1";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	    String status = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				status=rs.getString("vstatus");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return status ;
	}
	
	/**
	 * 获取项目的状态为报告审核完成
	 * 2010-9-30
	 * @param rid
	 * @return
	 */
	//
	
//	public  String   getStatus(String rid){
//		rid=rid.trim();
//		String sql =null;
//		if(isfish.equals("y")){
//			sql ="select vstatus from t_chem_project_time where vrid =? and vstatus ='报告审核完成'";
//		}else{
//			sql ="select vstatus from t_chem_project_time where vrid =? and vstatus !='报告审核完成'";
//		}
//			Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String status = null;
//		try {
//			conn = DB.getConn();
//			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setString(1, rid);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				status=rs.getString("vstatus");
//			}
//		}catch(SQLException e) {
//			e.printStackTrace();
//		}finally {
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
//		}
//		
//		return status ;
//	}
	
	/***'
	 * 根据rid来查询到vpid
	 * @param rid
	 * @return
	 */
	public  String   getPidByRid(String rid){
		rid=rid.trim();
		String sql ="select vpid from t_chem_project where vrid =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String status = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				status=rs.getString("vpid");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return status ;
	}
	

//根据sid查询项目的状态
	public String   getProjectStart(String sid){
		String sql ="select vstart from t_chem_project where vsid =?";
		//System.out.println(sid+"-----");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String start=null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				start=rs.getString("vstart");
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return start ;
	}
	
	
	//根据报告编号查询报告是否完成
	public String   getEndTimeByRid (String rid){
		String sql ="select dendtime from t_chem_project where vrid =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String start=null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				start=rs.getString("dendtime");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return start ;
	}
//根据sid查询项目的状态
	public String   getProjectRid(int id){
		
		String sql ="select vrid  from t_project_chem_test where id =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String start=null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				start=rs.getString("vrid");
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return start ;
	}
	
	

	/**
	 * 添加样品信息
	 * 
	 * @param p
	 * @return
	 */
	public boolean isOutProject(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "";
		
			sql = "update t_project set dostime=?,dortime=?,dbqtime=?,doetime=?,vtuvno=?,vtuvpshort=?,flcrealprice=?,foeprice=? where vsid = ?";
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setTimestamp(1,p.getOstime()==null?null:new Timestamp(p.getOstime().getTime()));
			pstmt.setTimestamp(2,p.getOrtime()==null?null:new Timestamp(p.getOrtime().getTime()));
			pstmt.setTimestamp(3,p.getBqtime()==null?null:new Timestamp(p.getBqtime().getTime()));
			pstmt.setTimestamp(4,p.getOetime()==null?null:new Timestamp(p.getOetime().getTime()));
			pstmt.setString(5, p.getTuvno());
			pstmt.setString(6, p.getTuvpshort());
			pstmt.setFloat(7,p.getLcrealprice());
			pstmt.setFloat(8, p.getOeprice());
			pstmt.setString(9, p.getSid());

			pstmt.executeUpdate();
			//判断是否是TUV的报告
			String str=p.getRid().substring(8, 9);
			if(p.getOetime() != null && !"".equals(p.getOetime()) && Integer.parseInt(str)==8){
				sql = "update t_chem_project set estatus = '结案',dendtime=?,istatus = 9,isfinish = 'y' where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setTimestamp(1,p.getOetime()==null?null:new Timestamp(p.getOetime().getTime()));
				pstmt.setString(2, p.getSid());
				pstmt.executeUpdate();
			}

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
		return isok;
	}
	

}
