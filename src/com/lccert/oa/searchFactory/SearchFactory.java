package com.lccert.oa.searchFactory;

import com.lccert.crm.dao.ProjectDao;
import com.lccert.crm.dao.impl.ProjectDaoImplMySql;
import com.lccert.oa.dao.CustomerDao;
import com.lccert.oa.dao.UserInforDao;
import com.lccert.oa.dao.VOLClientDao;
import com.lccert.oa.impl.CustomerDaoImpl;
import com.lccert.oa.impl.UserInforDaoImpl;
import com.lccert.oa.impl.VOLClientDaoImpl;
/***
 * 工厂模式类
 * @author tangzp
 *
 */
public class SearchFactory {
	public static UserInforDao getUserInfor(){
		return new UserInforDaoImpl();
	}
	public static CustomerDao getCustomer(){
		return new CustomerDaoImpl();
	}
	public static ProjectDao getInstance(){
		return new ProjectDaoImplMySql();
	}
	public static VOLClientDao getVOLClient(){
		return new VOLClientDaoImpl();
	}
}
