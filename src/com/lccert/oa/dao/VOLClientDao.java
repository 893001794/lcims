package com.lccert.oa.dao;

import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;

/***
 * 成交客户跟进Dao
 * @author Administrator
 *
 */
public interface VOLClientDao {
	/***
	 *获取成交客户的信息
	 * @param condition1  查询条件1
	 * @param condition2  查询条件2
	 * @param start  开始时间
	 * @param end    结束时间
	 * @param tracking  跟踪进度
	 * @param client  客户
	 * @param custom 自定查询项
	 * @param content 自定查询项内容
	 * @return
	 */
	public PageModel getVOLInfor(int pageNo, int pageSize,String followstate,String step,String condition1,String condition2,String start ,String end ,String tracking,String client,String custom,String content,String ctsName);
	/***
	 * 查询联系资料
	 * @param custId  联系客户Id
	 * @return
	 */
	public List getContact(int custId,String status);
	/***
	 * 查询客户资料
	 * @param custId  联系客户Id
	 * @return
	 */
	public List getCustomer(int custId);
	/***
	 * 添加联系记录
	 * @return
	 */
	public int addContact(List temp);
	/***
	 * 获取联系表中最后一个字段id
	 * @return
	 */
	public List getContactId();
	/***
	 * 删除联系记录
	 * @param contactId
	 * @return
	 */
	public int delContact(int contactId);
	/***
	 * 修改联系记录
	 * @param contactId
	 * @return
	 */
	public int updContact(List temp);
}
