package com.lccert.www;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.lccert.crm.client.ClientAction;
import com.lccert.crm.client.ClientForm;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.ProjectAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;

/**
 * ʵʱ������վ���ݹ�����
 * 
 * @author Eason 
 *
 */
public class UpdateWebSite implements Runnable {
	private int id;
	private String type;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void run() {
		updateData();		
	}
	
	/**
	 * �������ݵ���վ
	 */
	private synchronized void updateData() {
		Map<String,String> map = makeString();
		
		try {   
            HttpRequest request = new HttpRequest();  
            request.setDefaultContentEncoding("GBK");
            request.sendGet("http://www.lccert.com/updatewebsite.asp",map);
            //request.sendGet("http://192.168.0.10/update.asp",map);   
        } catch (Exception e) {   
            System.out.println("�Բ����������!");   
        }
	}

	/**
	 * ��ʼ������
	 * @return
	 */
	private Map<String,String> makeString() {
		Map<String,String> map = new HashMap<String, String>();
		if("client".equals(this.type)) {
			ClientForm clf = ClientAction.getInstance().getClientById(id);
			map.put("action", "client");
			map.put("id", clf.getId() + "");
			map.put("userid", clf.getClientid());
			map.put("password", clf.getPassword());
			map.put("name", clf.getName());
		} else if("quotation".equals(this.type)) {
			Quotation qt = QuotationAction.getInstance().getQuotationById(id);
			ClientForm cf = ClientAction.getInstance().getClientByName(qt.getClient());
			map.put("action", "quotation");
			map.put("id", id + "");
			map.put("pid", qt.getPid());
			map.put("status", qt.getStatus());
			map.put("createtime", new SimpleDateFormat("yyyy-MM-dd%20HH:mm:ss").format(new Date()));
			map.put("clientid", cf.getId() + "");
		} else if("project".equals(this.type)) {
			Project p = ProjectAction.getInstance().getProjectById(id);
			Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
			map.put("action", "project");
			map.put("id", p.getId() + "");
			map.put("quoid", qt.getId() + "");
			map.put("rid", p.getRid());
			map.put("testcontent", p.getTestcontent()==null?"":p.getTestcontent());
			if(!("��ѧ����".equals(p.getPtype())||p.getPtype().indexOf("��ױƷ")>-1||p.getPtype().indexOf("����")>-1))  {
				PhyProject pp = (PhyProject)p.getObj();
				map.put("samplename", pp.getSamplename()==null?"":pp.getSamplename());
			} else {
				ChemProject cp = (ChemProject)p.getObj();
				map.put("samplename", cp.getSamplename()==null?"":cp.getSamplename());
			}
		} else if("detail".equals(this.type)) {
			Project p = ProjectAction.getInstance().getProjectById(id);
			map.put("projectid", p.getId() + "");
			map.put("action", "detail");
			map.put("time", new SimpleDateFormat("yyyy-MM-dd%20HH:mm:ss").format(new Date()));
			if(!("��ѧ����".equals(p.getPtype())||p.getPtype().indexOf("��ױƷ")>-1||p.getPtype().indexOf("����")>-1))  {
				PhyProject pp = (PhyProject)p.getObj();
				map.put("statusid", pp.getIstatus() + "");
			} else {
				ChemProject cp = (ChemProject)p.getObj();
				map.put("statusid", cp.getIstatus() + "");
			}
		}
		return map;
	}
	
	
}
