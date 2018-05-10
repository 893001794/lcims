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
 * 项目状态管理工具类
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
	 * 得到报告的项目状态
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
	 * 添加项目动态
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
	 * 添加项目动态
	 * @param dpt
	 * @return
	 */
	public synchronized boolean addPTime(Flow f) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_chem_project_time(vfid,vrid,vsid,vstatus,dtime) values(?,?,?,'报告审核完成',now())";
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
	 * 发送补样/换样Email通知
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
		UserAction.getInstance().findUserByName(to, "唐周平");
		UserAction.getInstance().findUserByName(to, "夏念民[Hadi]");
//		UserAction.getInstance().findUserByName(to, "杨敏[Amy]");
		UserAction.getInstance().findUserByName(to, "吴加才[Randy]");
		to.add("luozh@lccert.com");
		to.add("service@lccert.com");
//		to.add("tangzp@lccert.com");
		String str = "";
		if(cp.getFilepath() != null && !"".equals(cp.getFilepath())) {
			str = "相关附件，下载地址为：" + url;
		}
		
		String head = "[项目补样/换样通知] 报价单:" + p.getPid() + "/报告:" + p.getRid();
		String content = "[项目补样/换样通知发布]<br>" + "报价单:" + p.getPid()
				+ "<br>客户:" + qt.getClient() + "<br>报告号:" + p.getRid() + "<br>目前该项目需要补样/换样。<br>"
				+ str
				+ "<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系立创检测客服专员:" + servname + "（Email:" + to.get(0) + "）。" +
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

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
