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
 * 化学项目管理类
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
	 * 根据报价单pid查找不同状态的化学项目
	 * @param pid 报价单
	 * @param status 状态
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
	 * 在大条形码时时选择哪种方式
	 */
	
	public Project getPlan (String str,String rid ){
		if(str.equals("化学测试")||str.equals("化妆品")||str.equals("环境")){
			return  ChemProjectAction.getInstance().searchChemProjectByRid(rid);
			}else{
			return ChemProjectAction.getInstance().searchPhyProjectByRid(rid);
			}
	}
	/**
	 * 在大条形码时时选择哪种方式
	 */
	
	public boolean  updateTime (String type, String rid, String vsid, String fid, int status,String str){
		String tableName="";
		if(str.equals("化学测试")||str.equals("化妆品")||str.equals("环境")){
			tableName="t_chem_project";
		}else{
			tableName="t_phy_project";
		}
		return BarCodeAction.getInstance().updateTime(type,rid,vsid,fid,status,tableName);
	
	}
	
	/**
	 * 添加化学项目
	 * 
	 * @param p
	 * @return
	 */
	public synchronized boolean addChemProject(Project p) {
		return DaoFactory.getInstance().getChemProjectDao().addChemProject(p);
	}
	
	/**
	 * 修改化学项目
	 * 
	 * @param p
	 * @return
	 */
	public synchronized boolean modifyChemProject(Project p) {
		return DaoFactory.getInstance().getChemProjectDao().modifyChemProject(p);
	}
	
	/**
	 * 查找化学项目
	 * @param pageNo
	 * @param pageSize
	 * @return PageModel 分页模型
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
				//项目完成，但是还没有填数的数据
				str.append(" and b.Isfinish='y' and b.dnucopletintime is null");
			}else if(status.equals("yconfirm")){
				//项目完成，并且已经填数，并且还没有审核的数据
				str.append(" and b.Isfinish='y' and b.dnucopletintime is  not null and b.drpconfirmtime is null ");
			}else{
			str.append(" and b.istatus = " + status);
			}
		}
		if(str.length()==0){
			str.append(" and  b.dcreatetime>=DATE_SUB(CURDATE(), INTERVAL 1 MONTH)");
		}
		/**
		 * 控制查询50条记录
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
	 * 取消化学项目
	 * @param sid
	 * @return
	 */
	public synchronized boolean cancelChemProject(String sid) {
		Project p = getChemProjectBySid(sid, ""); 
		return DaoFactory.getInstance().getChemProjectDao().cancelChemProject(p);
	}
	
	/**
	 * 根据sid查找项目
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
	 * 根据rid查找项目
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
	 * 根据报告号rid搜索化学项目
	 * @param rid
	 * @return
	 */
	public Project searchChemProjectByRid(String rid) {
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and a.vrid like '%" + rid + "%' order by b.dcreatetime desc";
		return DaoFactory.getInstance().getChemProjectDao().getChemProject(sql);
	}
	
	/**
	 * 初检完成
	 * @param sid
	 * @return
	 */
	public synchronized boolean checkingfinish(String sid) {
		return DaoFactory.getInstance().getChemProjectDao().checkingfinish(sid);
	}
	
	/**
	 * 发送项目初检完成
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
		
		String head = "[项目初检完成项目] 报价单:" + p.getPid() + "/报告:" + p.getRid() + "项目初检完成";
		String content = "[项目初检完成项目]<br>" + "报价单:" + p.getPid()
				+ "<br>报告号:" + p.getRid() + "<br>请注意，该项目初检已经完成，请跟进。"
				+ "<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系系统管理员。" +
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

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
	 * 发送项目预警信息（化学部）的项目预警
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
		UserAction.getInstance().findUserByName(to, "夏念民[Hadi]");
//		UserAction.getInstance().findUserByName(to, "杨敏[Amy]");
		to.add("luozh@lccert.com");
		//to.add("service@lccert.com");
		//to.add("huangyh@lccert.com");
//		to.add("tangzp@lccert.com");
		String warning = cp.getWarning();
		String head = "[项目预警信息] 报价单:" + p.getPid() + "/报告:" + p.getRid()
				+ " == " + warning;
		String content = "[项目预警信息发布]<br>" + "报价单:" + p.getPid()
				+ "<br>客户:" + qt.getClient() + "<br>报告号:" + p.getRid() + "<br>项目信息:" + warning
				+ "<br>发件人："+userName+"<br>报告应出时间："+cp.getRptime()+"<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系立创检测客服专员:" + servname + "（Email:" + to.get(0) + "）" +
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

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
	 * 发送项目预警信息安规部的项目预警
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
//		UserAction.getInstance().findUserByName(to, "夏念民[Hadi]");
//		UserAction.getInstance().findUserByName(to, "杨敏[Amy]");
		to.add("tangzp@lccert.com");
		//to.add("service@lccert.com");
		//to.add("huangyh@lccert.com");
		//to.add("zhaijj@lccert.com");
		String warning =new ChemProjectDaoImplMySql().getWarning(p.getSid());
		String head = "[项目预警信息] 报价单:" + p.getPid() + "/报告:" + p.getRid()
				+ " == " + warning;
		String content = "[项目预警信息发布]<br>" + "报价单:" + p.getPid()
				+ "<br>客户:" + qt.getClient() + "<br>报告号:" + p.getRid() + "<br>项目信息:" + warning
				+ "<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系立创检测客服专员:" + servname + "（Email:" + to.get(0) + "）。" +
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

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
	 * 发送项目预警信息
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
		String head = "[项目预警信息] 报价单:" + p.getPid() + "/报告:" + p.getRid()
				+ " == " + warning;
		String content = "[项目预警信息发布]<br>" + "报价单:" + p.getPid()
				+ "<br>客户:" + qt.getClient() + "<br>报告号:" + p.getRid() + "<br>项目信息:" + warning
				+ "<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系立创检测客服专员:" + servname + "（Email:" + to.get(0) + "）。" +
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

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
	 * 提醒项目工程师
	 * @param rid
	 */
	public synchronized void sendEmail(String sid,String engineer) {
		List<String> to = new ArrayList<String>();
		Project p = getChemProjectBySid(sid,"");
		UserAction.getInstance().findUserByName(to, engineer);
//		to.add("amyyang@lccert.com");
	//	to.add("randywu@lccert.com");
		//to.add("zhaijj@lccert.com");
		
		String head = "[待测试项目] 报价单:" + p.getPid() + "/报告:" + p.getRid() + "进入初检阶段";
		String content = "[待测试项目]<br>" + "报价单:" + p.getPid()
				+ "<br>报告号:" + p.getRid() + "<br>请注意，该项目现进入检测阶段，请跟进。"
				+ "<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系系统管理员。" +
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());

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
	 * 实验室编辑项目
	 * @param cp
	 * @return
	 */
	public synchronized boolean Labmodify(Project p,String oldwarning) {
		return DaoFactory.getInstance().getChemProjectDao().Labmodify(p, oldwarning);
	}
	
	/**
	 * 搜索不同时间段的迟单
	 * @return
	 */
	/**
	 * 搜索不同时间段的迟单
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
	 * 获取综合信息（综合包括迟单率，报告编号正确率统计）
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
	 * 搜索严重的迟单量
	 * @param start
	 * @param end
	 * @param type
	 * @return
	 */
	public List<Project> getSeverityLateProject(String start) {
		String sql="";
		//System.out.println(start);
		if("".equals(start)){
			sql= "select * from t_project a,t_chem_project b where a.vsid = b.vsid  and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null))  and date(b.drptime)=date(now())  and b.vstart!='暂停'  order by b.drptime desc";
		}else{
			sql= "select * from t_project a,t_chem_project b where a.vsid = b.vsid  and  ((time_to_sec(timediff(b.dendtime,b.drptime)) >7200  and b.dendtime is not null and b.dendtime > b.drptime )  or  (time_to_sec( timediff(now(),b.drptime)) >7200 and b.dendtime is null))  and date(b.drptime)<=date(now()) and date(b.drptime)>='"+start+"'  and b.vstart!='暂停' order by b.drptime desc";
		}
		return DaoFactory.getInstance().getChemProjectDao().getlateListDTime(sql,start);
	}
	
	//提前两小时的预警
	public List<ChemProject> getSedWarning() {
		String sql="";
		sql= "select * from t_chem_project where   date_add(now(), interval 2 hour)<=drptime and drptime <= date_add(now(), interval ' 2:05:00' day_second)  and  (( istatus != 10  )  and  (istatus !=9))";
		return DaoFactory.getInstance().getChemProjectDao().getSedWarning(sql);
	}
	
	
	/**
	 * 搜索离应出报告单前半小时报告没有完成的
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
	 * 搜索实验室状态项目
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
		//条件加上客户
		if(pName != null && !"".equals(pName)) {
			str.append(" and c.vprojectcontent like '%" + pName + "%'");
		}
		if(status != null && !"".equals(status)) {
			if(status .equals("测试完成")){
			
			str.append(" and b.dendtime is not null");
			}if(status .equals("测试中")){
				
			str.append(" and b.dendtime is  null");
			}
		}
//		if(start !=null && "".equals(start)){
//			System.out.println("时间------------------------："+start);
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
	 * 当天接单统计
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
	 * 得到预警和外包项目
	 * 
	 * @return
	 */
	public List<Project> getWarnAndOut() {
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and b.isfinish='n' and (b.eiswarn = 'y' or a.isout = 'y') order by a.vlevel desc";
		return DaoFactory.getInstance().getChemProjectDao().getAllChemProject(sql);
	}
	
	/**
	 * 更新重测reset时间
	 * @param rid
	 * @return
	 */
	public boolean reTest(String rid) {
		return DaoFactory.getInstance().getChemProjectDao().reTest(rid);
	}
	
	
	/**
	 * 获取rid
	 */
	public String getProjectRid(String sid ){
		return DaoFactory.getInstance().getProjectDao().getprojectRid(sid);
	}
	/**
	 * 项目状态变更Email内容
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
//		System.out.println(sales+"销售的人员名称");
//		UserAction.getInstance().findUserByName(to, "王保华[Lion]");
//		UserAction.getInstance().findUserByName(to, "夏念民[Hadi]");
//		UserAction.getInstance().findUserByName(to, "杨敏[Amy]");
//		UserAction.getInstance().findUserByName(to, "吴加才[Randy]");
		UserAction.getInstance().findUserByName(to, "唐周平");
//		to.add("tangzp@lccert.com");
		String head = "[项目状态更新信息] 报价单号:/报告号:" ;
		String content = "[项目状态信息更新发布]<br>" + "报价单号:";
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
		if(sales.equals("甘敏凤[Min]")|| sales.equals(" 夏念民[Hadi]")){
			UserAction.getInstance().findUserByName(to, "吴丽萍");
			UserAction.getInstance().findUserByName(to, "柯惠玲[Muco]");
		}
//		System.out.println(sales+"销售的人员名称");
//		UserAction.getInstance().findUserByName(to, "王保华[Lion]");
//		UserAction.getInstance().findUserByName(to, "夏念民[Hadi]");
//		UserAction.getInstance().findUserByName(to, "杨敏[Amy]");
//		UserAction.getInstance().findUserByName(to, "吴加才[Randy]");
//		UserAction.getInstance().findUserByName(to, "唐周平");
//		to.add("tangzp@lccert.com");
		String head = "[项目状态更新信息] 报价单号:" + p.getPid() + "/报告号:" + p.getRid()
				+ " 项目状态更新：" + status;
		String content = "[项目状态信息更新发布]<br>" + "报价单号:" + p.getPid()
				+ "<br>客户:" + qt.getClient() + "<br>报告号:" + p.getRid() + "<br>项目状态:" + status
				+ "<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。" +
						"<br>如有疑问，请联系立创检测客服专员" + servname+
								"<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	/**
	 * 发送实验室测试迟单项目
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
//			UserAction.getInstance().findUserByName(to, "杨敏[Amy]");
			to.add("luozh@lccert.com");
			to.add("hadixia@lccert.com");
			to.add("yanguo@lccert.com");
			to.add("weihua@lccert.com");
			to.add("service@lccert.com");
//			to.add("zhaijj@lccert.com");
//			to.add("tangzp@lccert.com");
			String head = "[实验室测试迟单项目]" + "报价单号:" + p.getPid() + "/报告号:" + p.getRid()
				+ " 报告应出时间：" + cp.getRptime();
			StringBuffer content = new StringBuffer("[实验室测试迟单项目]<br>");
			content.append("报价单号:" + p.getPid());
			content.append("<br>报告号:" + p.getRid());
			content.append("<br>客户名称:" + QuotationAction.getInstance().getQuotationByPid(p.getPid()).getClient());
			content.append("<br>应出报告时间:" + cp.getRptime());
			content.append("<br>测试完成时间:" + date);
			content.append("<br>---------------------------------------<br>");
			content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
			content.append("<br>如有疑问，请联系系统管理员。");
			content.append("<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
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
	 * 根据项目号取得所有预警信息
	 * @param sid
	 * @return
	 */
	public List<Warnning> getAllWarningBySid(String sid) {
		return DaoFactory.getInstance().getChemProjectDao().getAllWarningBySid(sid);
	}
	/**
	 * 添加报告图片
	 * @param img
	 * @return
	 */
	public boolean addImg(ReportImg img) {
		return DaoFactory.getInstance().getChemProjectDao().addImg(img);
	}
	/**
	 * 根据sid取得报告图片
	 * @param img
	 * @return
	 */
	public List<ReportImg> getImgs(String sid) {
		String sql = "select * from t_reportimg where sid = '" + sid + "' order by id desc";
		return DaoFactory.getInstance().getChemProjectDao().getImg(sql);
	}
	/**
	 * 根据pid（报价单来查询样品的类型）
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
 * 根据参数来更改t_chem_project 的表
 * @param status:参数
 * @param user：等到ims当前的用户名称
 * @param rid ：报告号
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
	 * 查找报告发出但是未付款的信息
	 * @param pageNo
	 * @param pageSize
	 * @param status 是否需要分页
	 * @return PageModel 分页模型
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
		//条件：系统时间>报告发出时间+15天的数据信息
		if(status ==null || "".equals(status)){
			str.append(" and date_add(cp.dsendtime,interval 15 day) <now() ");
		}
		String sql = "select cp.vpid as '报价单号',cp.vrid as '报告号',q.vsales as '销售人员',q.epaystatus as '是否付款',cp.dsendtime as '报告发放时间', q.vclient as '客户名称',cp.ismethod as '发放形式' ,date_add(cp.dsendtime,interval 15 day) as '最迟汇款时间',q.dcreatetime as '创建时间'  from t_chem_project as cp,t_quotation as q  where cp.ismethod is not null and (q.Fpreadvance+q.Fsepay+q.Fbalance)<q.Ftotalprice and YEAR(cp.dsendtime)=YEAR(NOW())  and   q.vpid =cp.vpid" + str.toString() + " order by cp.dsendtime desc";
//		System.out.println(sql+"-------------------");
		return DaoFactory.getInstance().getChemProjectDao().searchIssueRPNoPay(pageNo, pageSize, sql,status);
	}
	
	
	
}