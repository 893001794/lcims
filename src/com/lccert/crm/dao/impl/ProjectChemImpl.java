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
 * ��Ŀ���Ե�ʵ����
 * @author tangzp
 *
 */
public class ProjectChemImpl implements ProjectChemServlet {
	
	private static ProjectChemImpl instance = null;

	private ProjectChemImpl() {

	}

	
	
//��ӹ��̼���
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
	
	
	
	
	
//ɾ�����̼���
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

	//��ѯ���̻�ѧ�������м�¼
	
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
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='��Ʒ'" + str.toString();
		}if(status.equals("food")){
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='ʳƷ'" + str.toString();
		}
		return getAllProjectManarge(pageNo, pageSize, sql);
	}
	
	
//��ѯ���̻�ѧ�������м�¼
	
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
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='��Ʒ'" + str.toString();
		}if(status.equals("food")){
			sql = "select * from t_project_chem_test  where 1=1 and vitem ='ʳƷ'" + str.toString();
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
			str.append(" and p.etype='��������'  ");
			
		}
		if(tuvtype.equals("pout")){
			str.append(" and p.etype !='��������'and p.isout ='y' ");
		}
		
		String sql = "select distinct(cp.vrid),p.id as '��Ŀid',p.vpid as '���۵����',p.vsid as '��Ŀ���', p.vrid as '��Ŀ�����',p.Vtestcontent as '��Ŀ����',p.dortime as 'Ӧ������ʱ��',p.dbqtime as '���ʱ��',p.foeprice as 'ʵ��������'," +
				"p.dostime as '�����ְ��Ǽ�',q.Vsales as '��������',cp.Vsamplename as '��Ʒ����' ,p.Vsubname as '����ֻ�������',p.Vagname as '��������'," +
				"p.doetime as 'ʵ�ʻ�����ʱ��',q.Vclient as '�ͻ�����',p.vtuvno as 'TUV���',p.Fsubcost2 as 'ʵ���ⲿ�ְ���B',p.fpresubcost as '���������A' from t_project as p,t_quotation as q,t_chem_project as cp  where " +
				"  p.vpid =q.vpid and cp.vrid =p.vrid  " + str.toString()+"order by p.dbuildtime desc";
		//System.out.println(sql+"--------------------");
		return getAllOutProject(pageNo, pageSize,sql);
	}
	
	//�ж�һ���ַ����Ƿ���Ӣ����ĸ�ķ���
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
	 // System.out.println("��дӢ����ĸ����Ϊ: "+countUp+"\nСдӢ����ĸ����Ϊ: "+countLow+"\n��Ӣ����ĸ����Ϊ:   "+countNo);
	  return countUp;
	 }

	//������������ݽ��з�ҳ
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

	
	//������������ݽ��з�ҳ
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

	
	//������������ݽ��з�ҳ
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
				p.setId(rs.getInt("��Ŀid"));
				p.setPid(rs.getString("���۵����"));
				p.setSid(rs.getString("��Ŀ���"));
				p.setRid(rs.getString("��Ŀ�����"));
				p.setTestcontent(rs.getString("��Ŀ����"));
				p.setOrtime(rs.getTimestamp("Ӧ������ʱ��"));
				p.setBqtime(rs.getTimestamp("���ʱ��"));
				p.setPrice(rs.getFloat("ʵ��������"));
				p.setOstime(rs.getTimestamp("�����ְ��Ǽ�"));
				p.setSales(rs.getString("��������"));
				p.setSamplename(rs.getString("��Ʒ����"));
				p.setSubname(rs.getString("����ֻ�������"));
				p.setAgname(rs.getString("��������"));
				p.setOetime(rs.getTimestamp("ʵ�ʻ�����ʱ��"));
				p.setClient(rs.getString("�ͻ�����"));
				p.setSubcost2(rs.getFloat("ʵ���ⲿ�ְ���B"));
				p.setPresubcost(rs.getString("���������A"));
				p.setTuvno(rs.getString("TUV���"));
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
	
	
//����pid�������б��ֵ
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
	 * ���ݱ���Ų�ѯ��ױƷ��
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
	 * ��ȡ��Ŀ��״̬
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
	 * ��ȡ��Ŀ��״̬Ϊ����������
	 * 2010-9-30
	 * @param rid
	 * @return
	 */
	//
	
//	public  String   getStatus(String rid){
//		rid=rid.trim();
//		String sql =null;
//		if(isfish.equals("y")){
//			sql ="select vstatus from t_chem_project_time where vrid =? and vstatus ='����������'";
//		}else{
//			sql ="select vstatus from t_chem_project_time where vrid =? and vstatus !='����������'";
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
	 * ����rid����ѯ��vpid
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
	

//����sid��ѯ��Ŀ��״̬
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
	
	
	//���ݱ����Ų�ѯ�����Ƿ����
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
//����sid��ѯ��Ŀ��״̬
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
	 * �����Ʒ��Ϣ
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
			//�ж��Ƿ���TUV�ı���
			String str=p.getRid().substring(8, 9);
			if(p.getOetime() != null && !"".equals(p.getOetime()) && Integer.parseInt(str)==8){
				sql = "update t_chem_project set estatus = '�᰸',dendtime=?,istatus = 9,isfinish = 'y' where vsid = ?";
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
