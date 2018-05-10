package com.lccert.crm.project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.barcode.BarCodeAction;
import com.lccert.crm.chemistry.email.Email;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.chemistry.util.SendMail;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.dao.impl.ChemProjectDaoImplMySql;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.report.ReportImg;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.vo.Synthesis;
import com.lccert.www.UpdateWebSite;

/**
 * ��ѧ��Ŀ������
 * 
 * @author Eason
 * 
 */
public class ChemProjectAction {
	private static ChemProjectAction instance = new ChemProjectAction();

	private ChemProjectAction() {}

	public static ChemProjectAction getInstance() {
		return instance;
	}
	
	
	/**
	 * ���ݱ��۵�pid���Ҳ�ͬ״̬�Ļ�ѧ��Ŀ
	 * @param pid ���۵�
	 * @param status ״̬
	 * @return List<Project>
	 */
	public List<Project> getChemProjectByPid(String pid, String status) {
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and a.vpid = '" + pid + "'");
		}
		if(status != null && !"".equals(status)) {
			str.append(" and b.estatus = '" + status + "'");
		}
		//String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid" + str.toString() + " order by a.dbuildtime";
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid" + str.toString() + " order by a.vrid";
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProject(sql);
	}
	
	
	/**
	 * �ڴ�������ʱʱѡ�����ַ�ʽ
	 */
	
	public Project getPlan (String str,String rid ){
		if(str.equals("��ѧ����")||str.equals("��ױƷ")||str.equals("����")){
			return  ChemProjectAction.getInstance().searchChemProjectByRid(rid);
			}else{
			return ChemProjectAction.getInstance().searchPhyProjectByRid(rid);
			}
	}
	/**
	 * �ڴ�������ʱʱѡ�����ַ�ʽ
	 */
	
	public boolean  updateTime (String type, String rid, String vsid, String fid, int status,String str){
		String tableName="";
		if(str.equals("��ѧ����")||str.equals("��ױƷ")||str.equals("����")){
			tableName="t_chem_project";
		}else{
			tableName="t_phy_project";
		}
		return BarCodeAction.getInstance().updateTime(type,rid,vsid,fid,status,tableName);
	
	}
	
	/**
	 * ��ӻ�ѧ��Ŀ
	 * 
	 * @param p
	 * @return
	 */
	public synchronized boolean addChemProject(Project p) {
		return DaoFactory.getInstance().getChemProjectDao().addChemProject(p);
	}
	
	/**
	 * �޸Ļ�ѧ��Ŀ
	 * 
	 * @param p
	 * @return
	 */
	public synchronized boolean modifyChemProject(Project p) {
		return DaoFactory.getInstance().getChemProjectDao().modifyChemProject(p);
	}
	
	/**
	 * ���һ�ѧ��Ŀ
	 * @param pageNo
	 * @param pageSize
	 * @return PageModel ��ҳģ��
	 */
	public PageModel searchChemProjects(int pageNo, int pageSize, String pid, String rid, String status,String eitem) {
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and a.vpid = '" + pid + "'");
		}
		if(rid != null && !"".equals(rid)) {
			str.append(" and a.vrid like '%" + rid + "%'");
		}
		if(eitem !=null && !"".equals(eitem)){
			str.append(" and b.eitem ='"+eitem+"'");
		}
		if(status != null && !"".equals(status)) {
			if(status.equals("ynucompletin")){
				//��Ŀ��ɣ����ǻ�û������������
				str.append(" and b.Isfinish='y' and b.dnucopletintime is null");
			}else if(status.equals("yconfirm")){
				//��Ŀ��ɣ������Ѿ����������һ�û����˵�����
				str.append(" and b.Isfinish='y' and b.dnucopletintime is  not null and b.drpconfirmtime is null ");
			}else{
			str.append(" and b.istatus = " + status);
			}
		}
		if(str.length()==0){
			str.append(" and  b.dcreatetime>=DATE_SUB(CURDATE(), INTERVAL 1 MONTH)");
		}
		/**
		 * ���Ʋ�ѯ50����¼
		 */
		String sqlStr="select a.id,a.vsid,a.vpid,a.vrid,a.eptype,a.vtestcontent,a.vbuildname,a.dbuildtime,a.fprice,a.fpresubcost,a.vsubname,a.fsubcost,a.vsubname2,a.fsubcost2," +
				"a.fpreagcost,a.vagname,a.fagcost,a.fotherscost,a.einvtype,a.fpreinvprice,a.finvprice,a.vlevel,a.etype,a.elab,a.isout,a.vnotes," +
				"a.vsubcostnotes,b.vcontact,b.drptime,b.rpclient,b.vcreatename,b.dcreatetime,b.dsendtime,b.vsenduser," +
				"b.erptype,b.vsamplename,b.vsamplecount,b.tsampledesc,b.vservname,b.estatus,b.eitem,b.ischecked,b.dnucopletintime," +
				"b.vnucopletinuser,b.drpconfirmtime,b.vrpconfirmuser,a.filingno as filingno from t_project a ,t_chem_project b " +
				"where a.vsid =b.vsid " + str.toString() + "    order by a.dbuildtime desc,a.vsid asc ";
//		if(str.length()==0){
//			sqlStr+=" LIMIT 1,50";
//		}
		System.out.println("sqlStr:"+sqlStr);
//		String sql = "select   *   from   ("+sqlStr+")   as   t   order   by   t.vrid   desc";
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProjects(pageNo, pageSize, sqlStr);
	}
	
	/**
	 * ȡ����ѧ��Ŀ
	 * @param sid
	 * @return
	 */
	public synchronized boolean cancelChemProject(String sid) {
		Project p = getChemProjectBySid(sid, ""); 
		return DaoFactory.getInstance().getChemProjectDao().cancelChemProject(p);
	}
	
	/**
	 * ����sid������Ŀ
	 * @param sid
	 * @param status
	 * @return
	 */
	public Project getChemProjectBySid(String sid , String status) {
		StringBuffer str = new StringBuffer();
		if(sid != null && !"".equals(sid)) {
			
			str.append(" and a.vsid = '" + sid + "'");
		}
		if(status != null && !"".equals(status)) {
			str.append(" and b.estatus = '" + status + "'");
		}
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid" + str.toString();
		return DaoFactory.getInstance().getChemProjectDao().getChemProject(sql);
	}
	
	public Project getPhyProjectBySid(String sid) {
		StringBuffer str = new StringBuffer();
		if(sid != null && !"".equals(sid)) {
			
			str.append(" and a.vsid = '" + sid + "'");
		}
		String sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid" + str.toString();
		return DaoFactory.getInstance().getPhyProjectDao().getPhyProject(sql);
	}
	
	
	public Project searchPhyProjectByRid(String rid) {
		String sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid and a.vrid like '%" + rid + "%' order by b.dcreatetime desc";
		return DaoFactory.getInstance().getPhyProjectDao().getPhyProject(sql);
	}
	
	public Project getChemProjectBySid1(String sid , String status) {
		StringBuffer str = new StringBuffer();
		if(sid != null && !"".equals(sid)) {
			str.append(" and a.vsid = '" + sid + "'");
		}
		if(status != null && !"".equals(status)) {
			str.append(" and b.estatus = '" + status + "'");
		}
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid" + str.toString();
		
		return DaoFactory.getInstance().getChemProjectDao().getChemProject1(sql);
	}

	
	
	
	/**
	 * ����rid������Ŀ
	 * @param sid
	 * @param status
	 * @return
	 */
	public Project getChemProjectByRid(String rid , String status) {
		StringBuffer str = new StringBuffer();
		if(rid != null && !"".equals(rid)) {
			str.append(" and a.vrid = '" + rid + "'");
		}
		if(status != null && !"".equals(status)) {
			str.append(" and b.estatus = '" + status + "'");
		}
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid" + str;
		return DaoFactory.getInstance().getChemProjectDao().getChemProject(sql);
	}
	
	/**
	 * ���ݱ����rid������ѧ��Ŀ
	 * @param rid
	 * @return
	 */
	public Project searchChemProjectByRid(String rid) {
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and a.vrid like '%" + rid + "%' order by b.dcreatetime desc";
		return DaoFactory.getInstance().getChemProjectDao().getChemProject(sql);
	}
	
	/**
	 * �������
	 * @param sid
	 * @return
	 */
	public synchronized boolean checkingfinish(String sid) {
		return DaoFactory.getInstance().getChemProjectDao().checkingfinish(sid);
	}
	
	/**
	 * ������Ŀ�������
	 * @param rid
	 */
	public synchronized void sendCheckingfinish(String sid) {
		List<String> to = new ArrayList<String>();
		Project p = getChemProjectBySid(sid,"");
		//UserAction.getInstance().findUserByName(to, engineer);
//		to.add("amyyang@lccert.com");
//		to.add("zhaijj@lccert.com");
		to.add("janezhang@lccert.com");
		to.add("huangyh@lccert.com");
		to.add("service@lccert.com");
		
		String head = "[��Ŀ���������Ŀ] ���۵�:" + p.getPid() + "/����:" + p.getRid() + "��Ŀ�������";
		String content = "[��Ŀ���������Ŀ]<br>" + "���۵�:" + p.getPid()
				+ "<br>�����:" + p.getRid() + "<br>��ע�⣬����Ŀ�����Ѿ���ɣ��������"
				+ "<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵϵͳ����Ա��" +
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

		//SendMail.getInstance().send(to, head, content);
		
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
//	
	/**
	 * ������ĿԤ����Ϣ����ѧ��������ĿԤ��
	 * @param rid
	 */
	public synchronized void sendwarning(String sid,String userName) {
		List<String> to = new ArrayList<String>();
		Project p = getChemProjectBySid(sid,"");
		ChemProject cp = new ChemProject();
		Quotation qt = new Quotation();
		if(p != null) {
			cp = (ChemProject)p.getObj();
			qt = QuotationAction.getInstance().getQuotationByPid(
					p.getPid());
		}
		String servname = cp.getServname();
		String engineer = cp.getEngineer();
		String sales = qt.getSales();
		UserAction.getInstance().findUserByName(to, servname);
		UserAction.getInstance().findUserByName(to, engineer);
		UserAction.getInstance().findUserByName(to, sales);
		UserAction.getInstance().findUserByName(to, "������[Hadi]");
//		UserAction.getInstance().findUserByName(to, "����[Amy]");
		to.add("luozh@lccert.com");
		//to.add("service@lccert.com");
		//to.add("huangyh@lccert.com");
//		to.add("tangzp@lccert.com");
		String warning = cp.getWarning();
		String head = "[��ĿԤ����Ϣ] ���۵�:" + p.getPid() + "/����:" + p.getRid()
				+ " == " + warning;
		String content = "[��ĿԤ����Ϣ����]<br>" + "���۵�:" + p.getPid()
				+ "<br>�ͻ�:" + qt.getClient() + "<br>�����:" + p.getRid() + "<br>��Ŀ��Ϣ:" + warning
				+ "<br>�����ˣ�"+userName+"<br>����Ӧ��ʱ�䣺"+cp.getRptime()+"<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵ�������ͷ�רԱ:" + servname + "��Email:" + to.get(0) + "��" +
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

		//SendMail.getInstance().send(to, head, content);
		
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	/**
	 * ������ĿԤ����Ϣ���沿����ĿԤ��
	 * @param rid
	 */
	public synchronized void sendPhywarning(String sid) {
		List<String> to = new ArrayList<String>();
		Project p = getPhyProjectBySid(sid);
		PhyProject cp = new PhyProject();
		Quotation qt = new Quotation();
		if(p != null) {
			cp = (PhyProject)p.getObj();
			qt = QuotationAction.getInstance().getQuotationByPid(
					p.getPid());
		}
		String servname = cp.getServname();
		String engineer = cp.getEngineer();
		String sales = qt.getSales();
//		UserAction.getInstance().findUserByName(to, servname);
//		UserAction.getInstance().findUserByName(to, engineer);
//		UserAction.getInstance().findUserByName(to, sales);
//		UserAction.getInstance().findUserByName(to, "������[Hadi]");
//		UserAction.getInstance().findUserByName(to, "����[Amy]");
		to.add("tangzp@lccert.com");
		//to.add("service@lccert.com");
		//to.add("huangyh@lccert.com");
		//to.add("zhaijj@lccert.com");
		String warning =new ChemProjectDaoImplMySql().getWarning(p.getSid());
		String head = "[��ĿԤ����Ϣ] ���۵�:" + p.getPid() + "/����:" + p.getRid()
				+ " == " + warning;
		String content = "[��ĿԤ����Ϣ����]<br>" + "���۵�:" + p.getPid()
				+ "<br>�ͻ�:" + qt.getClient() + "<br>�����:" + p.getRid() + "<br>��Ŀ��Ϣ:" + warning
				+ "<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵ�������ͷ�רԱ:" + servname + "��Email:" + to.get(0) + "����" +
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

		//SendMail.getInstance().send(to, head, content);
		
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	/**
	 * ������ĿԤ����Ϣ
	 * @param rid
	 */
	public synchronized void sendProjectwarning(String sid,String warningInfo) {
		List<String> to = new ArrayList<String>();
		Project p = getChemProjectBySid(sid,"");
		ChemProject cp = new ChemProject();
		Quotation qt = new Quotation();
		if(p != null) {
			cp = (ChemProject)p.getObj();
			qt = QuotationAction.getInstance().getQuotationByPid(
					p.getPid());
		}
		String servname = cp.getServname();
		String engineer = cp.getEngineer();
		String sales = qt.getSales();
		UserAction.getInstance().findUserByName(to, sales);
		to.add("tangzp@lccert.com");
		to.add("service@lccert.com");
		to.add("huangyh@lccert.com");
		//to.add("zhaijj@lccert.com");
		String warning =warningInfo;
		String head = "[��ĿԤ����Ϣ] ���۵�:" + p.getPid() + "/����:" + p.getRid()
				+ " == " + warning;
		String content = "[��ĿԤ����Ϣ����]<br>" + "���۵�:" + p.getPid()
				+ "<br>�ͻ�:" + qt.getClient() + "<br>�����:" + p.getRid() + "<br>��Ŀ��Ϣ:" + warning
				+ "<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵ�������ͷ�רԱ:" + servname + "��Email:" + to.get(0) + "����" +
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

		//SendMail.getInstance().send(to, head, content);
		
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	
	/**
	 * ������Ŀ����ʦ
	 * @param rid
	 */
	public synchronized void sendEmail(String sid,String engineer) {
		List<String> to = new ArrayList<String>();
		Project p = getChemProjectBySid(sid,"");
		UserAction.getInstance().findUserByName(to, engineer);
//		to.add("amyyang@lccert.com");
	//	to.add("randywu@lccert.com");
		//to.add("zhaijj@lccert.com");
		
		String head = "[��������Ŀ] ���۵�:" + p.getPid() + "/����:" + p.getRid() + "�������׶�";
		String content = "[��������Ŀ]<br>" + "���۵�:" + p.getPid()
				+ "<br>�����:" + p.getRid() + "<br>��ע�⣬����Ŀ�ֽ�����׶Σ��������"
				+ "<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵϵͳ����Ա��" +
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

		//SendMail.getInstance().send(to, head, content);
		
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	/**
	 * ʵ���ұ༭��Ŀ
	 * @param cp
	 * @return
	 */
	public synchronized boolean Labmodify(Project p,String oldwarning) {
		return DaoFactory.getInstance().getChemProjectDao().Labmodify(p, oldwarning);
	}
	
	/**
	 * ������ͬʱ��εĳٵ�
	 * @return
	 */
	/**
	 * ������ͬʱ��εĳٵ�
	 * @return
	 */
	public List<Project> getLateProject(String start,String end,String type) {
		String str = "";
		if("search".equals(type)) {
			str = " and b.drptime > '" + start + "' and b.drptime < '" + end + "'";
		} else {
			Date date = new Date();
			str = " and b.drptime > '" + new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date) + "' and b.drptime < '" + new SimpleDateFormat("yyyy-MM-dd 23:59:59").format(date) + "'";
		}
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and b.dendtime is not null and b.dendtime > b.drptime" + str + " order by b.drptime desc";
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProject(sql);
	}
	
	
	/**
	 * ��ȡ�ۺ���Ϣ���ۺϰ����ٵ��ʣ���������ȷ��ͳ�ƣ�
	 * @return
	 */
	public List<Synthesis> getSynthesis(String start,String end,String type ,String year,String month ,String synStatus) {
//		String str = "";
		StringBuffer str =new StringBuffer();
		if("search".equals(type)) {
			if(start !=null && ! "".equals(start) && end !=null && ! "".equals(end)){
			str.append(" and drptime > '" + start + "' and drptime < '" + end + "'");
			}else{
				if(month !=null && !"".equals(month)){
					str.append(" and month(drptime) ='"+month+"'");
				}
				if(year !=null && !"".equals(year)){
					str.append(" and year(drptime) ='"+year+"'");
				}
			}
		} else {
			Date date = new Date();
			str.append(" and drptime > '" + new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date) + "' and drptime < '" + new SimpleDateFormat("yyyy-MM-dd 23:59:59").format(date) + "'");
		}
		String sql="";
		if(synStatus.equals("late")){
			sql = "select * from v_synthesis  where ((time_to_sec(timediff(dendtime,drptime)) >7200  and dendtime is not null and dendtime > drptime )  or  (time_to_sec( timediff(now(),drptime)) >7200 and dendtime is null))" + str + " order by drptime desc";
		}else{
			sql = "select * from v_synthesis b where  substring(b.vrid,4,1) regexp binary '[a-z]' " + str + " order by drptime desc";
		}
//		System.out.println(sql);
		return DaoFactory.getInstance().getChemProjectDao().getSynthesis(sql);
		
	}
	
	/**
	 * �������صĳٵ���
	 * @param start
	 * @param end
	 * @param type
	 * @return
	 */
	public List<Project> getSeverityLateProject(String start) {
		String sql="";
		//System.out.println(start);
		if("".equals(start)){
			sql= "select * from t_project a,t_chem_project b where a.vsid = b.vsid  and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null))  and date(b.drptime)=date(now())  and b.vstart!='��ͣ'  order by b.drptime desc";
		}else{
			sql= "select * from t_project a,t_chem_project b where a.vsid = b.vsid  and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null))  and date(b.drptime)<=date(now()) and date(b.drptime)>='"+start+"'  and b.vstart!='��ͣ' order by b.drptime desc";
		}
		return DaoFactory.getInstance().getChemProjectDao().getlateListDTime(sql,start);
	}
	
	//��ǰ��Сʱ��Ԥ��
	public List<ChemProject> getSedWarning() {
		String sql="";
		sql= "select * from t_chem_project where   date_add(now(), interval 2 hour)<=drptime and drptime <= date_add(now(), interval ' 2:05:00' day_second)  and  (( istatus != 10  )  and  (istatus !=9))";
		return DaoFactory.getInstance().getChemProjectDao().getSedWarning(sql);
	}
	
	
	/**
	 * ������Ӧ�����浥ǰ��Сʱ����û����ɵ�
	 * @return
	 */
	public List<Project> lateListDTime(String newDate) {
		//String sql = "select * from t_project a,t_chem_project b  where a.vsid = b.vsid and b.drptime >'"+newDate+"' time_to_sec( timediff(b.drptime,now())) >7200  and b.dendtime is  null order by b.drptime desc";
		//System.out.println(sql+"-------------------");
		String sql = "select * from t_project a,t_chem_project b  where a.vsid = b.vsid and now() <= b.drptime and  b.drptime<= date_add(now(), interval 2 hour )  and b.dendtime is  null order by b.drptime desc";
		return DaoFactory.getInstance().getChemProjectDao().getlateListDTime(sql,"");
	}
	
	public List<Project> lateListDTime1(String vpid){
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and  b.vpid='"+vpid+"' order by b.drptime desc";
		return DaoFactory.getInstance().getChemProjectDao().getlateListDTime(sql,"");
	}

	/**
	 * ����ʵ����״̬��Ŀ
	 * @param pageNo
	 * @param pageSize
	 * @param rid
	 * @return
	 */
	public PageModel searchLabProjects(int pageNo, int pageSize, String rid,String pName,String type,String status,String start) {
	
		String sql = "";
		StringBuffer str = new StringBuffer();
		if(rid != null && !"".equals(rid)) {
			str.append("  and a.vrid like '%" + rid + "%'");
		}
		if(type != null && !"".equals(type)) {
			str.append(" and b.eitem = '" + type + "'");
		}
		//�������Ͽͻ�
		if(pName != null && !"".equals(pName)) {
			str.append(" and c.vprojectcontent like '%" + pName + "%'");
		}
		if(status != null && !"".equals(status)) {
			if(status .equals("�������")){
			
			str.append(" and b.dendtime is not null");
			}if(status .equals("������")){
				
			str.append(" and b.dendtime is  null");
			}
		}
//		if(start !=null && "".equals(start)){
//			System.out.println("ʱ��------------------------��"+start);
//			str.append("and b.dcreatetime like '%" + start + "%'");
//		}
//		if("".equals(rid)&& "".equals(pName) && "".equals(type) && "".equals(status) && "".equals(start)) {
//			sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and b.isfinish = 'n' order by substring(a.vrid,9,12) desc";
//		} else {
			sql = "select * from t_project a,t_chem_project b,t_quotation c where a.vsid = b.vsid and a.vpid=c.vpid and date_sub(curdate(),interval 14 day)<=date( b.drptime )"+str.toString()+" order by substring(a.vrid,9,12) desc";
//		}
			
//			System.out.println(sql+"-----------");
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProjects(pageNo, pageSize, sql);
	}
	
	/**
	 * ����ӵ�ͳ��
	 * @return
	 */
	public List<Project> getTodayProject(String start,String end,String rptime,String type ,String status) {
		//System.out.println(start);
//		String str = "";
		StringBuffer str =new StringBuffer();
		if("search".equals(type)) {
			if(start !=null && !"".equals(start) &&  end !=null || !"".equals(end)){
				str.append(" and b.dcreatetime > '" + start + "' and b.dcreatetime < '" + end + "'");
			}
			if(rptime !=null && !"".equals(rptime)){
				str.append(" and date(b.drptime) = '" + rptime + "'");
			}
			if(status != null && !"".equals(status)) {
				str.append(" and b.Isfinish='"+status+"' and b.drptime<=now() and timestampdiff(month,b.dcreatetime, now())<2 ");
			}
			
		} else {
			Date date = new Date();
			str.append(" and b.dcreatetime > '" + new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date) + "' and b.dcreatetime < '" + new SimpleDateFormat("yyyy-MM-dd 23:59:59").format(date) + "'");
		}
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid " + str + " order by b.dcreatetime desc";
	  //System.out.println(sql+"------------------");
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProject(sql);
	}
	
	/**
	 * �õ�Ԥ���������Ŀ
	 * 
	 * @return
	 */
	public List<Project> getWarnAndOut() {
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and b.isfinish='n' and (b.eiswarn = 'y' or a.isout = 'y') order by a.vlevel desc";
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProject(sql);
	}
	
	/**
	 * �����ز�resetʱ��
	 * @param rid
	 * @return
	 */
	public boolean reTest(String rid) {
		return DaoFactory.getInstance().getChemProjectDao().reTest(rid);
	}
	
	
	/**
	 * ��ȡrid
	 */
	public String getProjectRid(String sid ){
		return DaoFactory.getInstance().getProjectDao().getprojectRid(sid);
	}
	/**
	 * ��Ŀ״̬���Email����
	 * @param sid
	 * @return
	 */
	
	
	public static void main(String[] args) {
		ChemProjectAction.getInstance().sendProjectStatus();
	}
	
	public synchronized void sendProjectStatus() {
		String servname="";
		String engineer="";
		String status="";
		
		Email email = new Email();
		List<String> to = new ArrayList<String>();
		
//		UserAction.getInstance().findUserByName(to, servname);
//		UserAction.getInstance().findUserByName(to, engineer);
//		UserAction.getInstance().findUserByName(to, sales);
//		System.out.println(sales+"���۵���Ա����");
//		UserAction.getInstance().findUserByName(to, "������[Lion]");
//		UserAction.getInstance().findUserByName(to, "������[Hadi]");
//		UserAction.getInstance().findUserByName(to, "����[Amy]");
//		UserAction.getInstance().findUserByName(to, "��Ӳ�[Randy]");
		UserAction.getInstance().findUserByName(to, "����ƽ");
//		to.add("tangzp@lccert.com");
		String head = "[��Ŀ״̬������Ϣ] ���۵���:/�����:" ;
		String content = "[��Ŀ״̬��Ϣ���·���]<br>" + "���۵���:";
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	
	
	public synchronized void sendProjectStatus(String sid) {
		String servname="";
		String engineer="";
		String status="";
		
		Email email = new Email();
		List<String> to = new ArrayList<String>();
		String rid =getProjectRid(sid);
		String str=rid.substring(3, 4);
		
		Project p=null;
		if(str.equals("C")||str.equals("D")){
		    p= getChemProjectBySid(sid,"");
		    ChemProject cp = (ChemProject)p.getObj();
		    servname = cp.getServname();
			engineer = cp.getEngineer();
			status=cp.getStatus();
		}else{
			p=getPhyProjectBySid(sid);
			PhyProject cp = (PhyProject)p.getObj();
			servname = cp.getServname();
			engineer = cp.getEngineer();
			status=cp.getStatus();
		}
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		String sales = qt.getSales();
//		UserAction.getInstance().findUserByName(to, servname);
//		UserAction.getInstance().findUserByName(to, engineer);
		UserAction.getInstance().findUserByName(to, sales);
		if(sales.equals("������[Min]")|| sales.equals(" ������[Hadi]")){
			UserAction.getInstance().findUserByName(to, "����Ƽ");
			UserAction.getInstance().findUserByName(to, "�»���[Muco]");
		}
//		System.out.println(sales+"���۵���Ա����");
//		UserAction.getInstance().findUserByName(to, "������[Lion]");
//		UserAction.getInstance().findUserByName(to, "������[Hadi]");
//		UserAction.getInstance().findUserByName(to, "����[Amy]");
//		UserAction.getInstance().findUserByName(to, "��Ӳ�[Randy]");
//		UserAction.getInstance().findUserByName(to, "����ƽ");
//		to.add("tangzp@lccert.com");
		String head = "[��Ŀ״̬������Ϣ] ���۵���:" + p.getPid() + "/�����:" + p.getRid()
				+ " ��Ŀ״̬���£�" + status;
		String content = "[��Ŀ״̬��Ϣ���·���]<br>" + "���۵���:" + p.getPid()
				+ "<br>�ͻ�:" + qt.getClient() + "<br>�����:" + p.getRid() + "<br>��Ŀ״̬:" + status
				+ "<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���" +
						"<br>�������ʣ�����ϵ�������ͷ�רԱ" + servname+
								"<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	/**
	 * ����ʵ���Ҳ��Գٵ���Ŀ
	 * @param sid
	 */
	public synchronized void sendLabLateProject(String sid,Date date) {
		Project p = getChemProjectBySid(sid,"");
		ChemProject cp = (ChemProject)p.getObj();
		Date rptime = cp.getRptime();
		rptime = new Date(((rptime.getTime()/1000)-60*60*1)*1000);
		if(date.after(rptime)) {
			Email email = new Email();
			List<String> to = new ArrayList<String>();
			Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
			String servname = cp.getServname();
			String engineer = cp.getEngineer();
			String sales = qt.getSales();
			UserAction.getInstance().findUserByName(to, servname);
			UserAction.getInstance().findUserByName(to, engineer);
			UserAction.getInstance().findUserByName(to, sales);
//			UserAction.getInstance().findUserByName(to, "����[Amy]");
			to.add("luozh@lccert.com");
			to.add("hadixia@lccert.com");
			to.add("yanguo@lccert.com");
			to.add("weihua@lccert.com");
			to.add("service@lccert.com");
//			to.add("zhaijj@lccert.com");
//			to.add("tangzp@lccert.com");
			String head = "[ʵ���Ҳ��Գٵ���Ŀ]" + "���۵���:" + p.getPid() + "/�����:" + p.getRid()
				+ " ����Ӧ��ʱ�䣺" + cp.getRptime();
			StringBuffer content = new StringBuffer("[ʵ���Ҳ��Գٵ���Ŀ]<br>");
			content.append("���۵���:" + p.getPid());
			content.append("<br>�����:" + p.getRid());
			content.append("<br>�ͻ�����:" + QuotationAction.getInstance().getQuotationByPid(p.getPid()).getClient());
			content.append("<br>Ӧ������ʱ��:" + cp.getRptime());
			content.append("<br>�������ʱ��:" + date);
			content.append("<br>---------------------------------------<br>");
			content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
			content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
			content.append("<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			email.setTo(to);
			email.setHead(head);
			email.setContent(content.toString());
			SendMail send = new SendMail();
			send.setEmail(email);
			Thread t = new Thread(send);
			t.start();
		}
	}
	/**
	 * ������Ŀ��ȡ������Ԥ����Ϣ
	 * @param sid
	 * @return
	 */
	public List<Warnning> getAllWarningBySid(String sid) {
		return DaoFactory.getInstance().getChemProjectDao().getAllWarningBySid(sid);
	}
	/**
	 * ��ӱ���ͼƬ
	 * @param img
	 * @return
	 */
	public boolean addImg(ReportImg img) {
		return DaoFactory.getInstance().getChemProjectDao().addImg(img);
	}
	/**
	 * ����sidȡ�ñ���ͼƬ
	 * @param img
	 * @return
	 */
	public List<ReportImg> getImgs(String sid) {
		String sql = "select * from t_reportimg where sid = '" + sid + "' order by id desc";
		return DaoFactory.getInstance().getChemProjectDao().getImg(sql);
	}
	/**
	 * ����pid�����۵�����ѯ��Ʒ�����ͣ�
	 * 
	 */
	public ChemProject getItem(String pid){
		String sql ="select eitem,dcreatetime,drptime,rpclient,vsamplename from t_chem_project where vpid =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChemProject cp =null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cp=new ChemProject();
				cp.setItem(rs.getString("eitem"));
				cp.setCreatetime(rs.getTimestamp("dcreatetime"));
				cp.setRptime(rs.getTimestamp("drptime"));
				cp.setRpclient(rs.getString("rpclient"));
				cp.setSamplename(rs.getString("vsamplename"));
			
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return cp;
	}
	public String getEtypeByRid(String rid ){
		String sql ="select * from t_chem_project where vrid ='"+rid+"'";
				return DaoFactory.getInstance().getChemProjectDao().getEtypeByRid(sql);
	}
/**
 * ���ݲ���������t_chem_project �ı�
 * @param status:����
 * @param user���ȵ�ims��ǰ���û�����
 * @param rid �������
 * @return
 */
	public boolean upChemProjectStatus(String status,String user ,String rid) {
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
			String sql ="";
			if(status.equals("ynucompletin")){
				sql = "update  t_chem_project set dnucopletintime=now(),vnucopletinuser=? where vrid =?";
			}else{
				sql = "update  t_chem_project set drpconfirmtime=now(),vrpconfirmuser=? where vrid =?";
			}
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1,user);
			pstmt.setString(2,rid);
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
	
	/**
	 * ���ұ��淢������δ�������Ϣ
	 * @param pageNo
	 * @param pageSize
	 * @param status �Ƿ���Ҫ��ҳ
	 * @return PageModel ��ҳģ��
	 * 
	 */
	public PageModel searchIssueRPNoPay(int pageNo, int pageSize, String pid, String rid,String status) {
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and cp.vpid = '" + pid + "'");
		}
		if(rid != null && !"".equals(rid)) {
			str.append(" and cp.vrid like '%" + rid + "%'");
		}
//		System.out.println(status);
		//������ϵͳʱ��>���淢��ʱ��+15���������Ϣ
		if(status ==null || "".equals(status)){
			str.append(" and date_add(cp.dsendtime,interval 15 day) <now() ");
		}
		String sql = "select cp.vpid as '���۵���',cp.vrid as '�����',q.vsales as '������Ա',q.epaystatus as '�Ƿ񸶿�',cp.dsendtime as '���淢��ʱ��', q.vclient as '�ͻ�����',cp.ismethod as '������ʽ' ,date_add(cp.dsendtime,interval 15 day) as '��ٻ��ʱ��',q.dcreatetime as '����ʱ��'  from t_chem_project as cp,t_quotation as q  where cp.ismethod is not null and (q.Fpreadvance+q.Fsepay+q.Fbalance)<q.Ftotalprice and YEAR(cp.dsendtime)=YEAR(NOW())  and   q.vpid =cp.vpid" + str.toString() + " order by cp.dsendtime desc";
//		System.out.println(sql+"-------------------");
		return DaoFactory.getInstance().getChemProjectDao().searchIssueRPNoPay(pageNo, pageSize, sql,status);
	}
	
	
	
}