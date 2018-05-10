package com.lccert.crm.chemistry.lab;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;

/**
 * ��ѧʵ������Ŀ�����ࣨ����Service���Dao�㣩
 * 
 * @author Eason
 *
 */
public class LabAction {

	private static LabAction instance = new LabAction();

	private LabAction() {

	}

	public static LabAction getInstance() {
		return instance;
	}

	/**
	 * ȡ�óٵ�Ԥ����Ŀ
	 * 
	 * @return
	 */
	public List<Project> getWarnProject() {
		String sql = "select * from t_chem_project where estatus <> '��֤' and estatus <> '�᰸' and ? > drptime order by drptime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Project> list = new ArrayList<Project>();
		Project p = null;
		Date date = new Date();
		date.setTime(((date.getTime() / 1000) + 60 * 60 * 2) * 1000);
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setTimestamp(1, new Timestamp(date.getTime()));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p = new Project();
				ChemProject cp = new ChemProject();
				p.setRid(rs.getString("vrid"));
				p.setSid(rs.getString("vsid"));
				cp.setRptype(rs.getString("erptype"));
				cp.setRptime(rs.getTimestamp("drptime"));
				cp.setCreatename(rs.getString("vcreatename"));
				cp.setCreatetime(rs.getTimestamp("dcreatetime"));
				cp.setSamplename(rs.getString("vsamplename"));
				cp.setSamplecount(rs.getString("vsamplecount"));
				cp.setSampledesc(rs.getString("tsampledesc"));
				cp.setAppform(rs.getString("tappform"));
				cp.setServname(rs.getString("vservname"));
				cp.setWarning(getWarning(p.getSid()));
				cp.setStatus(rs.getString("estatus"));
				p.setObj(cp);
				getProject(p);

				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	
		
	/**
	 * ȡ�óٵ���
	 * @param start ��ʼʱ��
	 * @param end ����ʱ��
	 * @param type 
	 * @return
	 */
	/**
	 * ȡ�óٵ���
	 * @param start ��ʼʱ��
	 * @param end ����ʱ��
	 * @param type 
	 * @return
	 */
	public int[] getLatePercent(String start,String end,String type) {
		String str = "";
		if("search".equals(type)) {
			str = " and a.drptime > '" + start + "' and a.drptime < '" + end + "'";
		}
		String sql = "select count(a.id) from t_chem_project a,t_project b where a.vsid = b.vsid and a.dendtime > a.drptime and a.dendtime is not null" + str;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int child = 0;
		int parent = 1;
		int[] family = new int[2];
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				child = rs.getInt(1);
			}
			
			sql = "select count(a.id) from t_chem_project a where 1 = 1" + str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				parent = rs.getInt(1);
			}
			
			family[0] = child;
			family[1] = parent;
			
//System.out.println("child:" + child + "parent:" + parent + "percent:" + (child*100/parent));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return family;
	}
	
	
	/**
	 * ��ȡ�ۺ���Ϣ���ۺϰ����ٵ��ʣ���������ȷ��ͳ�ƣ�
	 * @param start ��ʼʱ��
	 * @param end ����ʱ��
	 * @param type 
	 * @return
	 */
	
	public int[] getSynPercent(String start,String end,String type,String year,String month,String synStatus ) {
//		String str = "";
		StringBuffer str =new StringBuffer();
		if("search".equals(type)) {
			if(start !=null && ! "".equals(start) && end !=null && ! "".equals(end)){
//			str = " and a.drptime > '" + start + "' and a.drptime < '" + end + "'";
				str.append(" and drptime > '" + start + "' and drptime < '" + end + "'");
			}else{
				if(month !=null && !"".equals(month)){
					str.append(" and month(drptime) ='"+month+"'");
				}
				if(year !=null && !"".equals(year)){
					str.append(" and year(drptime) ='"+year+"'");
				}
			}
		}
		String sql="";
		if(synStatus.equals("late")){
			 sql = "select count(*) from v_synthesis where ((time_to_sec(timediff(dendtime,drptime)) >7200  and dendtime is not null and dendtime > drptime )  or  (time_to_sec( timediff(now(),drptime)) >7200 and dendtime is null))" + str;
			 
		}else {
			 sql = "select count(*) from v_synthesis where  substring(vrid,4,1) regexp binary '[a-z]'" + str;
		}
//		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int child = 0;
		int parent = 1;
		int lateStat = 0;  //�ܵĳٵ�ͳ��
		int lateStatZ = 0;  //��ɽ�ٵ�ͳ��
		int lateStatD = 0; //��ݸ�ٵ�ͳ��
		int[] family = new int[5];
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				child = rs.getInt(1);
			}
//			System.out.println(child);
			sql = "select count(*) from v_synthesis a where 1 = 1" + str;
			//System.out.println(sql);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				parent = rs.getInt(1);
			}
			sql = "select count(*) from t_chem_project  where drptime is not null " + str;
			//System.out.println(sql);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lateStat = rs.getInt(1);
			}
			sql = "select count(*) from t_chem_project  where drptime is not null and (vpid like 'LCQ1%' or vpid like 'LCQG%') " + str;
//			System.out.println(sql);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lateStatZ = rs.getInt(1);
			}
			sql = "select count(*) from t_chem_project  where drptime is not null and vpid like 'LCQD%' " + str;
//			System.out.println(sql);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lateStatD = rs.getInt(1);
			}
			//System.out.println(child+"-------------"+parent);
			family[0] = child;
			family[1] = parent;
			family[2] = lateStat;
			family[3] = lateStatZ;
			family[4] = lateStatD;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return family;
	}
	/**
	 * ȡ�óٵ���
	 * @param start ��ʼʱ��
	 * @param end ����ʱ��
	 * @param type 
	 * @return
	 */
	public int[] getSaverityLatePercent(String start) {
		String sql="";
		if("".equals(start)){
			sql= "select count(a.id) from t_project a,t_chem_project b where a.vsid = b.vsid and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null))and b.vstart!='��ͣ'  and date(b.drptime)=date(now())" ;
		}else{
			sql= "select count(a.id) from t_project a,t_chem_project b where a.vsid = b.vsid and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null)) and b.vstart!='��ͣ'  and date(b.drptime)<=date(now()) and b.vstart!='��ͣ'  and date(b.drptime)>='"+start+"'  order by b.drptime desc" ;
			
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int child = 0;
		int parent = 1;
		int child1= 3;
		int[] family = new int[2];
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn,sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				child = rs.getInt(1);
			}
//			if("".equals(start)){
//				sql = "select count(*) from t_project a,t_chem_project b where a.vsid = b.vsid and ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff('2012-04-17 21:30:00',b.drptime)) >7200 and b.dendtime is null))and b.vstart!='��ͣ' and date(b.drptime)=date('2012-04-17') order by b.drptime desc";
//			}else{
//				sql = "select count(*) from t_project a,t_chem_project b where a.vsid = b.vsid and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null))and b.vstart!='��ͣ' and date(b.drptime)<=date(now()) and date(b.drptime)>='"+start+"'   order by b.drptime desc";
//			}
//			pstmt = DB.prepareStatement(conn, sql);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				child1 = rs.getInt(1);
//			}
			//child =child1+child;
			if("".equals(start)){
				sql = "select count(a.id) from t_chem_project a where 1 = 1 and date(a.drptime)=date(now()) and a.vstart!='��ͣ' ";
				}else{
				sql="select count(a.id) from t_chem_project a where 1 = 1 and date(a.drptime)<=date(now()) and a.vstart!='��ͣ'  and date(a.drptime)>='"+start+"'";
				}
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				parent = rs.getInt(1);
			}
			
			family[0] = child;
			family[1] = parent;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return family;
	}
	/**
	 * ȡ����ĿԤ������
	 * @param sid
	 * @return
	 */
	private String getWarning(String sid) {
		String sql = "select * from t_chem_project_warn where vsid = ? order by dwarntime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String warning = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				warning = rs.getString("vwarning");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return warning;
	}

	/**
	 * ���ݱ�����sidȡ����Ŀ
	 * @param p ��Ŀ
	 */
	private void getProject(Project p) {
		String sql = "select * from t_project where vsid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				p.setPid(rs.getString("vpid"));
				p.setPtype(rs.getString("eptype"));
				
				p.setTestcontent(rs.getString("vtestcontent"));
				
				p.setPrice(rs.getFloat("fprice"));
				p.setInsubcost(rs.getFloat("finsubcost"));
				p.setPresubcost(rs.getString("fpresubcost"));
				p.setSubname(rs.getString("vsubname"));
				p.setPresubcost2(rs.getString("fpresubcost2"));
				p.setSubname2(rs.getString("vsubname2"));
				p.setPreagcost(rs.getFloat("fpreagcost"));
				p.setAgname(rs.getString("vagname"));
				p.setPreinvprice(rs.getFloat("fpreinvprice"));
				p.setInvtype(rs.getString("einvtype"));
				p.setInvhead(rs.getString("vinvhead"));
				p.setInvcontent(rs.getString("vinvcontent"));
				p.setBuildname(rs.getString("vbuildname"));
				p.setLevel(rs.getString("vlevel"));
				p.setBuildtime(rs.getTimestamp("dbuildtime"));
				p.setType(rs.getString("etype"));
				p.setLab(rs.getString("elab"));
				p.setIsout(rs.getString("isout"));
				p.setPrice(rs.getFloat("fprice"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}


	/**
	 * �õ�ʵ��������ͳ������
	 * 
	 * @return
	 */
	public SourceStatis getSourceStatics() {
		SourceStatis ss = new SourceStatis();
		getNotFinish(ss);
		getToday(ss);
		getNeedFinish(ss);
		return ss;
	}

	/**
	 * δ�����Ŀ����ͳ��
	 * 
	 * @param ss
	 */
	private void getNotFinish(SourceStatis ss) {
		String sql = "select count(distinct vsid) from t_chem_flow where status < 4 and status > 0 and vlevel = '��ͨ'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setCount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status < 4 and status > 0 and vlevel = '�Ӽ�'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setCount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status < 4 and status > 0 and vlevel = '�ؼ�'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setCount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setWu0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setWu1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setWu2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setYou0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setYou1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setYou2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setFood0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setFood1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status < 4 and status > 0 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setFood2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * ����ӵ�����ͳ��
	 * 
	 * @param ss
	 */
	private void getToday(SourceStatis ss) {
		Date date = new Date();
		String str = " and a.dpdtime like '%"
				+ new SimpleDateFormat("yyyy-MM-dd").format(date) + "%'";

		String sql = "select count(distinct a.vsid) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '��ͨ'" + str;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount0(rs.getInt(1));
			}

			sql = "select count(distinct a.vsid) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�Ӽ�'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount1(rs.getInt(1));
			}

			sql = "select count(distinct a.vsid) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�ؼ�'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '��ͨ' and a.eflowtype = '�޻���ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�Ӽ�' and a.eflowtype = '�޻���ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�ؼ�' and a.eflowtype = '�޻���ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '��ͨ' and a.eflowtype = '�л���ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�Ӽ�' and a.eflowtype = '�л���ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�ؼ�' and a.eflowtype = '�л���ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '��ͨ' and a.eflowtype = 'ʳƷ��ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�Ӽ�' and a.eflowtype = 'ʳƷ��ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a where a.status < 4 and a.status > 0 and a.vlevel = '�ؼ�' and a.eflowtype = 'ʳƷ��ת��'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * ����������ͳ��
	 * 
	 * @param ss
	 */
	private void getNeedFinish(SourceStatis ss) {
		String sql = "select count(distinct a.vsid) from t_chem_flow a,t_chem_project b "
				+ "where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.status = 4 and"
				+ " b.isfinish = 'n'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNcount0(rs.getInt(1));
			}

			sql = "select count(distinct a.vsid) from t_chem_flow a,t_chem_project b where" +
					" a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.status = 4 and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNcount1(rs.getInt(1));
			}

			sql = "select count(distinct a.vsid) from t_chem_flow a,t_chem_project b where" +
					" a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.status = 4 and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNcount2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid" +
					" and a.vlevel = '��ͨ' and a.eflowtype = '�޻���ת��' and a.status = 4 and" +
					" b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNwu0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid" +
					" = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = '�޻���ת��' and a.status" +
					" = 4 and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNwu1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = " +
					"b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = '�޻���ת��' and a.status = 4 " +
					"and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNwu2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid" +
					" = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = '�л���ת��' and a.status" +
					" = 4 and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNyou0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = " +
					"b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = '�л���ת��' and a.status = 4 " +
					"and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNyou1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = " +
					"b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = '�л���ת��' and a.status = 4 " +
					"and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNyou2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = " +
					"b.vsid and a.vlevel = '��ͨ' and a.eflowtype = 'ʳƷ��ת��' and a.status = 4 " +
					"and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNfood0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = " +
					"b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = 'ʳƷ��ת��' and a.status = 4 " +
					"and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNfood1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = " +
					"b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = 'ʳƷ��ת��' and a.status = 4 " +
					"and b.isfinish = 'n'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setNfood2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * �õ��޻�ʵ��������
	 * 
	 * @return
	 */
	public Wuji getWuji() {
		Wuji w = new Wuji();
		getPreWuji(w);
		getBeforeWuji(w);
		getIngWuji(w);
		return w;
	}

	/**
	 * �޻��Ʊ�״̬ͳ��
	 * 
	 * @param w
	 */
	private void getPreWuji(Wuji w) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setPcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setPcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setPcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setPwu0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setPwu1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setPwu2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * �޻�ǰ����״̬ͳ��
	 * 
	 * @param w
	 */
	private void getBeforeWuji(Wuji w) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setBcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setBcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setBcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setBwu0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setBwu1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setBwu2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * �޻��ϻ�״̬ͳ��
	 * 
	 * @param w
	 */
	private void getIngWuji(Wuji w) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setIcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setIcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setIcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '��ͨ' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setIwu0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '�Ӽ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setIwu1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '�ؼ�' and eflowtype = '�޻���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				w.setIwu2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * ����л�����
	 * 
	 * @return
	 */
	public Youji getYouji() {
		Youji y = new Youji();
		getPreYouji(y);
		getBeforeYouji(y);
		getIngYouji(y);
		return y;
	}

	/**
	 * �л��Ʊ�״̬ͳ��
	 * 
	 * @param w
	 */
	private void getPreYouji(Youji y) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setPcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setPcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setPcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setPyou0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setPyou1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setPyou2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * �л�ǰ����״̬ͳ��
	 * 
	 * @param w
	 */
	private void getBeforeYouji(Youji y) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setBcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setBcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setBcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setByou0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setByou1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setByou2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * �л��ϻ�״̬ͳ��
	 * 
	 * @param w
	 */
	private void getIngYouji(Youji y) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setIcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setIcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setIcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '��ͨ' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setIyou0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '�Ӽ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setIyou1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '�ؼ�' and eflowtype = '�л���ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				y.setIyou2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	
	/**
	 * ���ʳƷ������
	 * 
	 * @return
	 */
	public Shipin getShipin() {
		Shipin s = new Shipin();
		getPreShipin(s);
		getBeforeShipin(s);
		getIngShipin(s);
		return s;
	}

	/**
	 * ʳƷ���Ʊ�״̬ͳ��
	 * 
	 * @param w
	 */
	private void getPreShipin(Shipin s) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setPcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setPcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 1 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setPcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setPshi0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setPshi1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 1 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setPshi2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * ʳƷ��ǰ����״̬ͳ��
	 * 
	 * @param w
	 */
	private void getBeforeShipin(Shipin s) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setBcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setBcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 2 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setBcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setBshi0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setBshi1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 2 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setBshi2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * ʳƷ���ϻ�״̬ͳ��
	 * 
	 * @param w
	 */
	private void getIngShipin(Shipin s) {
		String sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setIcount0(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setIcount1(rs.getInt(1));
			}

			sql = "select count(distinct vsid) from t_chem_flow where status = 3 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setIcount2(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '��ͨ' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setIshi0(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '�Ӽ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setIshi1(rs.getInt(1));
			}

			sql = "select sum(itestcount) from t_chem_flow where status = 3 and vlevel = '�ؼ�' and eflowtype = 'ʳƷ��ת��'";
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				s.setIshi2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * ���������Ŀͳ��
	 * @param ss
	 */
	public void getTodayFinish(SourceStatis ss) {
		Date date = new Date();
		String str = " and b.dendtime like '%"
				+ new SimpleDateFormat("yyyy-MM-dd").format(date) + "%'";

		String sql = "select count(*) from t_project a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and b.isfinish = 'y'"
				+ str;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount0(rs.getInt(1));
			}

			sql = "select count(*) from t_project a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount1(rs.getInt(1));
			}

			sql = "select count(*) from t_project a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = '�޻���ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = '�޻���ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = '�޻���ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = '�л���ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = '�л���ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = '�л���ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = 'ʳƷ��ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = 'ʳƷ��ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = 'ʳƷ��ת��' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	
	/**
	 * δ����������Ŀͳ��
	 * @param ss
	 */
	public void getNotSend(SourceStatis ss) {
		String str = " and b.dsendtime is null";

		String sql = "select count(a.vsid) from t_chem_project b,t_project a where a.vsid = b.vsid and a.vlevel = '��ͨ' and b.isfinish = 'y'"
				+ str;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount0(rs.getInt(1));
			}

			sql = "select count(a.vsid) from t_chem_project b,t_project a where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount1(rs.getInt(1));
			}

			sql = "select count(a.vsid) from t_chem_project b,t_project a where a.vsid = b.vsid and a.vlevel = '�ؼ�' and b.isfinish = 'y'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTcount2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = '�޻���ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = '�޻���ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = '�޻���ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTwu2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = '�л���ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = '�л���ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = '�л���ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTyou2(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '��ͨ' and a.eflowtype = 'ʳƷ��ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood0(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�Ӽ�' and a.eflowtype = 'ʳƷ��ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood1(rs.getInt(1));
			}

			sql = "select sum(a.itestcount) from t_chem_flow a,t_chem_project b where a.vsid = b.vsid and a.vlevel = '�ؼ�' and a.eflowtype = 'ʳƷ��ת��' and b.estatus = '�᰸'"
					+ str;
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ss.setTfood2(rs.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
}
