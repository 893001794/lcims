package com.lccert.crm.project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.lccert.crm.chemistry.email.Email;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.SendMail;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.user.UserAction;

/**
 * ��Ŀ״̬��������
 * @author Eason
 *
 */
public class ProjectTimeAction {
	private static ProjectTimeAction instance = null;

	private ProjectTimeAction() {

	}

	public synchronized static ProjectTimeAction getInstance() {
		if (instance == null) {
			instance = new ProjectTimeAction();
		}
		return instance;
	}
	
	/**
	 * �õ��������Ŀ״̬
	 * @param rid
	 * @return
	 */
	public List<DynamicProjectTime> getProjectTime(String rid) {
		String sql = "select * from t_project_time where vrid = ? order by dtime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DynamicProjectTime dpt = null;
		List<DynamicProjectTime> list = new ArrayList<DynamicProjectTime>();

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dpt = new DynamicProjectTime();
				dpt.setId(rs.getInt("id"));
				dpt.setRid(rs.getString("vrid"));
				dpt.setSid(rs.getString("vsid"));
				dpt.setUser(rs.getString("vuser"));
				dpt.setEvent(rs.getString("vevent"));
				dpt.setTime(rs.getTimestamp("dtime"));
				list.add(dpt);
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
	
	
	public ChemLabTime getEndTime(String rid) {
		String sql = "select *  from t_chem_project_time where vrid =? order by dtime desc limit 1";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChemLabTime clt = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				clt = new ChemLabTime();
				clt.setStatus(rs.getString("vstatus"));
				clt.setTime(rs.getTimestamp("dtime"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return clt;
	}
	
	
	/**
	 * �����Ŀ��̬
	 * @param dpt
	 * @return
	 */
	public synchronized boolean addProjectTime(DynamicProjectTime dpt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_project_time(vrid,vuser,vevent,dtime) values(?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, dpt.getRid());
			pstmt.setString(2, dpt.getUser());
			pstmt.setString(3, dpt.getEvent());

			pstmt.executeUpdate();
			
			if(dpt.getFilepath() != null && !"".equals(dpt.getFilepath())) {
				sql = "update t_chem_project set vfilepath = ? where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, dpt.getFilepath());
				pstmt.setString(2, dpt.getSid());
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

	
	
	/**
	 * �����Ŀ��̬
	 * @param dpt
	 * @return
	 */
	public synchronized boolean addPTime(Flow f) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_chem_project_time(vfid,vrid,vsid,vstatus,dtime) values(?,?,?,'����������',now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, f.getFid());
			pstmt.setString(2, f.getRid());
			pstmt.setString(3, f.getSid());
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
		return isok;
	}
	
	
	
	/**
	 * ���Ͳ���/����Email֪ͨ
	 * @param sid
	 * @param url
	 */
	public synchronized void sendAnnexEmail(String sid , String url) {
		List<String> to = new ArrayList<String>();
		Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid, "");
		Quotation qt = new Quotation();
		ChemProject cp = (ChemProject)p.getObj();
		qt = QuotationAction.getInstance().getQuotationByPid(
					p.getPid());
		String servname = cp.getServname();
		String engineer = cp.getEngineer();
		String sales = qt.getSales();
		UserAction.getInstance().findUserByName(to, servname);
		UserAction.getInstance().findUserByName(to, engineer);
		UserAction.getInstance().findUserByName(to, sales);
		UserAction.getInstance().findUserByName(to, "����ƽ");
		UserAction.getInstance().findUserByName(to, "������[Hadi]");
//		UserAction.getInstance().findUserByName(to, "����[Amy]");
		UserAction.getInstance().findUserByName(to, "��Ӳ�[Randy]");
		to.add("luozh@lccert.com");
		to.add("service@lccert.com");
//		to.add("tangzp@lccert.com");
		String str = "";
		if(cp.getFilepath() != null && !"".equals(cp.getFilepath())) {
			str = "��ظ��������ص�ַΪ��" + url;
		}
		
		String head = "[��Ŀ����/����֪ͨ] ���۵�:" + p.getPid() + "/����:" + p.getRid();
		String content = "[��Ŀ����/����֪ͨ����]<br>" + "���۵�:" + p.getPid()
				+ "<br>�ͻ�:" + qt.getClient() + "<br>�����:" + p.getRid() + "<br>Ŀǰ����Ŀ��Ҫ����/������<br>"
				+ str
				+ "<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵ�������ͷ�רԱ:" + servname + "��Email:" + to.get(0) + "����" +
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

//		SendMail.getInstance().send(to, head, content);
		
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}

}
