package com.lccert.crm.project;

import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;


/**
 * ������Ŀ������
 * 
 * @author Eason
 * 
 */
public class PhyProjectAction {
	
	private static PhyProjectAction instance = new PhyProjectAction();

	private PhyProjectAction() {}

	public static PhyProjectAction getInstance() {
		return instance;
	}
	
	
	
	/**
	 * ��Ӱ�����Ŀ
	 * 
	 * @param p
	 * @return
	 */
	public synchronized boolean addPhyProject(Project p) {
		return DaoFactory.getInstance().getPhyProjectDao().addPhyProject(p);
	}
	
	/**
	 * �޸İ�����Ŀ
	 * @param p
	 * @return
	 */
	public synchronized boolean modifyPhyProject(Project p) {
		return DaoFactory.getInstance().getPhyProjectDao().modifyPhyProject(p);
	}
	
	/**
	 * ������Ŀ���sidȡ�ð�����Ŀ
	 * @param sid
	 * @return
	 */
	public Project getProjectBySid(String sid) {
		String sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid and a.vsid = '" + sid + "'";
//		System.out.println(sid+"---sid");
		return DaoFactory.getInstance().getPhyProjectDao().getPhyProject(sql);
	}
	
	/**
	 * ���ݱ����ridȡ�ð�����Ŀ
	 * @param rid
	 * @return
	 */
	public Project getProjectByRid(String rid) {
		String sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid and a.vrid = '" + rid + "' order by b.dcreatetime desc";
		return DaoFactory.getInstance().getPhyProjectDao().getPhyProject(sql);
	}
	
	/**
	 * ���ݱ��۵�pid���Ҳ�ͬ״̬�İ�����Ŀ
	 * @param pid
	 * @param status
	 * @return
	 */
	public List<Project> getPhyProjectByPid(String pid, String status) {
		StringBuffer str = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			str.append(" and a.vpid = '" + pid + "'");
		}
		if(status != null && !"".equals(status)) {
			str.append(" and b.estatus = '" + status + "'");
		}
		String sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid" + str.toString() + " and a.dbuildtime >='2011-01-01' order by a.dbuildtime desc";
		return DaoFactory.getInstance().getPhyProjectDao().getAllPhyProject(sql);
	}
	
	/**
	 * ���Ұ�����Ŀ
	 * @param pageNo
	 * @param pageSize
	 * @param keyword
	 * @param type
	 * @return PageModel ��ҳģ��
	 */
	public PageModel searchPhyProjects(int pageNo, int pageSize, String keyword, String type) {
		String sql = "";
		if("pid".equals(type)) {
			sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid and a.vpid='" + keyword + "' order by b.dcreatetime desc";
		} else if("rid".equals(type)) {
			sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid and a.vrid like '%" + keyword + "%' order by b.dcreatetime desc";
		} else {
			sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid order by b.dcreatetime desc";
		}
		return DaoFactory.getInstance().getPhyProjectDao().getAllPhyProjects(pageNo, pageSize, sql);
	}
	
	/**
	 * ȡ��������Ŀ
	 * @param sid
	 * @return
	 */
	public synchronized boolean cancelPhyProject(String sid) {
		Project p = getProjectBySid(sid);
		return DaoFactory.getInstance().getPhyProjectDao().cancelPhyProject(p);
	}
	
	/**
	 * ������Ŀ״̬
	 * @param sid
	 * @param status
	 * @return
	 */
	public synchronized boolean updateStatus(Project p) {
		return DaoFactory.getInstance().getPhyProjectDao().updateStatus(p);
	}
	
	public synchronized PageModel searchMyPhyProject(int pageNo,int pageSize,String sales,String pid, String rid,
			String parttype,String phystatus) {
		String sql="";
		StringBuffer sb =new StringBuffer();
		if(sales !=null && !"".equals(sales)){
			//��ȡ���û��Ĳ���
			UserForm user =UserAction.getInstance().getUserByName(sales);
			if(sales.indexOf("[")>-1){
				sales=sales.substring(0, sales.indexOf("["));
			}
			//��ȡ���ŵ�ǰ2���ַ�
			String dept=user.getDept().substring(0, 2);
			if(dept.equals("����")){
				sb.append(" and q.vsales like '"+sales+"%'");
			}else if(dept.equals("�ͷ�")){
				sb.append(" and phy.vservname like '"+sales+"%'");
		}else if(dept.equals("����")){
			sb.append(" and phy.vengineer like '"+sales+"%'");
			}
		}
		if(pid !=null && !"".equals(pid)){
			sb.append(" and p.vpid like '%" + pid+ "%'");
		}
		if(rid !=null && !"".equals(rid)){
			sb.append(" and p.vrid like '%" + rid+ "%'");
		}
		if(parttype !=null && !"".equals(parttype)){
			sb.append(" and phy.isfinish ='"+parttype+"'");
		}
		if(phystatus !=null && !"".equals(phystatus)){
			sb.append(" and phy.estatus ='"+phystatus+"'");
		}
		//System.out.println(sb+"���ж�����");
		sql="select distinct(phy.vrid) as '������',p.vpid as '���۵���' ,p.vlevel as '��Ŀ�ȼ�' ,p.vtestcontent as '��Ŀ����',phy.Dcreatetime as '�ŵ�ʱ��'," +
			"phy.Drptime as '����Ӧ��ʱ��',phy.vservname as '�ͷ���Ա' ,q.vsales as '������Ա',phy.vsamplename as '��Ʒ����',phy.vsamplemodel " +
			"as '��Ʒ�ͺ�',phy.vengineer as '��Ŀ������',phy.estatus as '��Ŀ״̬',phy.isfinish as '�Ƿ����' from t_phy_project " +
			"as phy ,t_project as p ,t_quotation as q where p.vrid =phy.vrid and p.dbuildtime>='2011-01-01' and p.vpid =q.vpid "+sb;
		//System.out.println(sql+"��sql���");
		return DaoFactory.getInstance().getPhyProjectDao().searchMyPhyProject(pageNo,pageSize, sql);
	}
	

	
	public float[] getPhyProjectInfor(String year ,String month,String itemNumber,List lsit){
		StringBuffer sb =new StringBuffer();
		if(year !=null && !"".equals(year)){
			sb.append(" and year(dcreatetime)="+year+"");
		}
		if(month !=null && !"".equals(month)){
			sb.append(" and month(dcreatetime)="+month+"");
		}
		if(itemNumber !=null && !"".equals(itemNumber)){
			sb.append(" and item_number like '"+itemNumber+".%'");
		}
		String sql ="select soi.id ,soi.vpid,soi.name,soi.item_number,(soi.count*soi.saleprice) as '��Ŀ�۸�',q.Equotype as type from v_sales_order_infor as soi ,t_quotation as q  where soi.vpid =q.vpid and q.vpid like 'LCQ2%' "+sb+"";
		return DaoFactory.getInstance().getPhyProjectDao().getPhyProjectInfor(sql,lsit);
		
	}
	
	public List getPhyStatus(String year ,String month,String itemNumber){
		StringBuffer sb =new StringBuffer();
		if(year !=null && !"".equals(year)){
			sb.append(" and year(dcreatetime)="+year+"");
		}
		if(month !=null && !"".equals(month)){
			sb.append(" and month(dcreatetime)="+month+"");
		}
		if(itemNumber !=null && !"".equals(itemNumber)){
			sb.append(" and item_number like '"+itemNumber+".%'");
		}
		String sql ="select soi.id ,soi.vpid,soi.name,soi.item_number,(soi.count*soi.saleprice) as '��Ŀ�۸�' from v_sales_order_infor as soi ,t_quotation as q  where soi.vpid =q.vpid and q.vpid like 'LCQ2%' "+sb+"";
		return DaoFactory.getInstance().getPhyProjectDao().getPhyStatus(sql);
		
	}
	
	/**
	 * ���ݱ��۵��Ż�ȡ��Ŀ��Ϣ
	 */
	
	public List getPhyProjectStatus(String pid){
		String sql ="select distinct(p.vrid),p.vpid,p.vsid ,p.eptype,p.vtestcontent,p.vbuildname,phy.estatus from t_project as p,t_phy_project as phy where  phy.vpid =p.vpid and  p.vpid='"+pid+"'";
		return DaoFactory.getInstance().getPhyProjectDao().getPhyProjectStatus(sql);
	}
	
	/**
	 * ���ݱ��۵��Ż�ȡ��Ŀ��Ϣ
	 */
	
	public Map<String, String>  getPhyStatusType(int classId){
		StringBuffer str =new StringBuffer();
		if(classId !=0){
			str.append(" and class ="+classId+"");
		}
		String sql ="select * from  t_phystatus where 1=1 "+str +" and estatus='y'";
		return DaoFactory.getInstance().getPhyProjectDao().getPhyStatusType(sql);
	}
	
	public boolean upPhyStart(String type, String rid, String vsid, String fid,int status){
		return DaoFactory.getInstance().getPhyProjectDao().upPhyStart(type, rid, vsid, fid, status);
	}
	
	
	public PhyProject findByConditions(PhyProject phyProject){
		StringBuffer str = new StringBuffer();
		String pid=phyProject.getPid();
		if(pid != null && !"".equals(pid)) {
			str.append(" and vpid = '" + pid + "'");
		}
		String sql = "select * from t_phy_project   where 1=1 "+str.toString();
		return DaoFactory.getInstance().getPhyProjectDao().findByConditions(sql);
	}
}