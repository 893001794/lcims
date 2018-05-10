package com.lccert.crm.dao;

import java.util.Date;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.vo.Depot;

/**
 *��Ӳֿ���Ϣ
 * @author tangzp
 *
 */
public interface DepotDao {
	public int addDepot(Depot depot,String company) ;
	String makeDid(String company,String field);
	public Depot searchDepot(int id);
	//��ȡ���еĲֿ���ҷ�ҳ�Ĺ���
	public PageModel searchAllDepot(int pageNo, int pageSize);
	//���Ĳֿ�����
	public int updateDepot(Depot depot);
	//ɾ���ֿ�����
	public int delDeport(int id );
}
