package com.lccert.oa.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.impl.ChemProjectDaoImplMySql;
import com.lccert.oa.dao.VOLClientDao;
import com.lccert.oa.db.ConnSqlServserDB;
import com.lccert.oa.db.ImsDB;

public class VOLClientDaoImpl implements VOLClientDao {
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
	public PageModel getVOLInfor(int pageNo, int pageSize,String followstate,String step,String condition1, String condition2, String start,String end, String tracking, String client, String custom,String content,String ctsName) {
		String str ="";
		if(step !=null && !"".equals(step)){
			if(step.equals("潜在")){
			str+=" and step ='"+step+"' and followstate ='线索跟踪'";
			}else{
			str+=" and step ='"+step+"'";
			}
			if(ctsName !=null && !"".equals(ctsName)){
				str+=" and nowman='"+ctsName+"'";
			}
		}
		if(followstate !=null && !"".equals(followstate)){
			str+=" and followstate ='"+followstate+"'";
			if(ctsName !=null && !"".equals(ctsName)){
				str+=" and nowman='"+ctsName+"'";
			}
		}
		else if(condition1 !=null && !"".equals(condition1)&&!"按条件查询".endsWith(condition1)){
			if(condition1.equals("今天要回访")){
				str+=" and backdate=convert(varchar(10),getdate(),120)";
			}
			if(condition1.equals("近5天要回访")){
				str+=" and backdate=dateadd(day ,+5,getdate())";
			}
			if(condition1.equals("已过回访日期")){
				str+=" and backdate<convert(varchar(10),getdate(),120)";
			}
			if(condition1.equals("近5天已联系")){
				str+=" and lastdate>=dateadd(day ,-5,getdate())";
			}
			if(ctsName !=null && !"".equals(ctsName)){
				str+=" and nowman='"+ctsName+"'";
			}
			
		}
			else{
			if(condition2 !=null && !"".equals(condition2)){
				if(condition2.equals("回访日期")){
					str+=" and backdate>='"+start+"' and backdate <= '"+end+"'";
				}
				if(condition2.equals("最近联系日期")){
					str+=" and  lastdate>='"+start+"' and lastdate <= '"+end+"'";
				}
				if(condition2.equals("创建日期")){
					str+=" and devpdate>='"+start+"' and devpdate <= '"+end+"'";
				}
				if(condition2.equals("收集日期")){
					str+=" and collectdate>='"+start+"' and collectdate <= '"+end+"'";
				}
			}
			if(tracking !=null && !"".equals(tracking)){
				str+=" and followstep='"+tracking+"'";
			}
			if(ctsName !=null && !"".equals(ctsName)){
				str+=" and nowman='"+ctsName+"'";
			}
			
			if(client !=null && !"".equals(client)){
				str+=" and nameshort like '%"+client+"%'";
			}
			if(custom !=null && !"".equals(custom) && content !=null && !"".equals(content)){
				if(custom.equals("地区")){
					str+=" and city like '%"+content+"%'";
				}
				if(custom.equals("地址")){
					str+=" and address like '%"+content+"%'";
				}
				if(custom.equals("电话")){
					str+=" and tel  like '%"+content+"%'";
				}
				if(custom.equals("传真")){
					str+=" and fax like '%"+content+"%'";
				}
			}
		}
		 List list =new ArrayList(); //list装载要输出的字段名
		  list.add("custID");
		  list.add("namefull");
		  list.add("tel");
		  list.add("nameshort");
		  list.add("keyman");
		  list.add("lastdate");
		  list.add("backdate");
		  list.add("followstep");
		  list.add("city");
		  list.add("calling");
		  list.add("nowman");
		  list.add("step");
		  list.add("total_Item");
		  list.add("total_Page");
		  List temp =new ArrayList(); //temp装载的是sql server2000存储过程(up_Pager)的参数
		  temp.add("customer"); //表名
		  temp.add("custID");  //按该列来进行分页
		  temp.add("0");       //排序,0-顺序,1-倒序
		  temp.add("custID,namefull,tel,nameshort,keyman,CONVERT(VARCHAR(10),lastdate,120) as lastdate,CONVERT(VARCHAR(10),backdate,120)as backdate ,followstep,city,calling,nowman,step"); //要查询出的字段列表,*表示全部字段
		  temp.add(pageSize);  //每页记录数
		  temp.add(pageNo);   //指定当前是第几页
		  temp.add("1=1"+str);  //查询条件
		  PageModel pm = new PageModel();
		  List countList =new ConnSqlServserDB().getInfor1(temp,list,"");
		  List rows =(List)countList.get(0);
		  int totalRecords =Integer.parseInt(countList.get(1).toString());
		  pm = new PageModel();
		  pm.setPageNo(pageNo);
		  pm.setPageSize(pageSize);
		  pm.setList(rows);
		  pm.setTotalRecords(totalRecords);
		return pm; 
	}
	
	/***
	 * 查询联系资料
	 * @param custId  联系客户Id
	 * @return
	 */
	public List getContact(int custId,String status) {
		List temp =new ArrayList();
		temp.add("contactID");
		temp.add("contactdate");
		temp.add("add1");
		temp.add("contactman");
		temp.add("saywords");
		temp.add("sales");
		temp.add("nameshort");
		String sql ="";
		if(status.equals("cust")){
			sql="select * from contact where custID ="+custId+" order by contactID desc";
		}else{
			sql="select * from contact where contactID ="+custId+" order by contactID desc";
		}
		//List rows =new ConnSqlServserDB().getInfor(temp, sql);
		return new ConnSqlServserDB().getInfor(temp, sql);
	}
	
	/***
	 * 查询客户资料
	 * @param custId  联系客户Id
	 * @return
	 */
	public List getCustomer(int custId) {
		List temp =new ArrayList();
		temp.add("nameshort");
		temp.add("keyman");
		temp.add("tel");
		temp.add("fax");
		temp.add("email");
		temp.add("add1");
		temp.add("nowman");
		String sql ="select nameshort,keyman,tel,fax,email,add1,nowman from customer where custID ="+custId+"";
//		System.out.println(sql);
		return new ConnSqlServserDB().getInfor(temp, sql);
	}
	/***
	 * 添加联系记录
	 * @return
	 */
	public int addContact(List temp) {
		String sql ="insert into contact(custID,nameshort,contactman,contactdate,saywords,sales,xsdb,add1,contactID) values(?,?,?,?,?,?,?,?,?)";
		return  new ConnSqlServserDB().getCount(sql, temp);
	}

	public List getContactId() {
		List temp =new ArrayList();
		temp.add("contactID");
		String sql="select top 10 contactID from contact order by contactID desc";
		return new ConnSqlServserDB().getInfor(temp, sql);
	}
	
	/***
	 * 删除联系记录
	 * @param contactId
	 * @return
	 */
	public int delContact(int contactId) {
		List temp =new ArrayList();
		temp.add(contactId);
		String sql ="delete from contact where contactID=?";
		return  new ConnSqlServserDB().getCount(sql, temp);
	}
	/***
	 * 修改联系记录
	 * @param contactId
	 * @return
	 */
	public int updContact(List temp) {
		String sql ="update contact set custID=?,nameshort=?,contactman=?,contactdate=?,saywords=?,sales=?,xsdb=?,add1=?,contactID=?";
		return  new ConnSqlServserDB().getCount(sql,temp);
	}

}
