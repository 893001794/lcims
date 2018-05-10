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
	 *��ȡ�ɽ��ͻ�����Ϣ
	 * @param condition1  ��ѯ����1
	 * @param condition2  ��ѯ����2
	 * @param start  ��ʼʱ��
	 * @param end    ����ʱ��
	 * @param tracking  ���ٽ���
	 * @param client  �ͻ�
	 * @param custom �Զ���ѯ��
	 * @param content �Զ���ѯ������
	 * @return
	 */
	public PageModel getVOLInfor(int pageNo, int pageSize,String followstate,String step,String condition1, String condition2, String start,String end, String tracking, String client, String custom,String content,String ctsName) {
		String str ="";
		if(step !=null && !"".equals(step)){
			if(step.equals("Ǳ��")){
			str+=" and step ='"+step+"' and followstate ='��������'";
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
		else if(condition1 !=null && !"".equals(condition1)&&!"��������ѯ".endsWith(condition1)){
			if(condition1.equals("����Ҫ�ط�")){
				str+=" and backdate=convert(varchar(10),getdate(),120)";
			}
			if(condition1.equals("��5��Ҫ�ط�")){
				str+=" and backdate=dateadd(day ,+5,getdate())";
			}
			if(condition1.equals("�ѹ��ط�����")){
				str+=" and backdate<convert(varchar(10),getdate(),120)";
			}
			if(condition1.equals("��5������ϵ")){
				str+=" and lastdate>=dateadd(day ,-5,getdate())";
			}
			if(ctsName !=null && !"".equals(ctsName)){
				str+=" and nowman='"+ctsName+"'";
			}
			
		}
			else{
			if(condition2 !=null && !"".equals(condition2)){
				if(condition2.equals("�ط�����")){
					str+=" and backdate>='"+start+"' and backdate <= '"+end+"'";
				}
				if(condition2.equals("�����ϵ����")){
					str+=" and  lastdate>='"+start+"' and lastdate <= '"+end+"'";
				}
				if(condition2.equals("��������")){
					str+=" and devpdate>='"+start+"' and devpdate <= '"+end+"'";
				}
				if(condition2.equals("�ռ�����")){
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
				if(custom.equals("����")){
					str+=" and city like '%"+content+"%'";
				}
				if(custom.equals("��ַ")){
					str+=" and address like '%"+content+"%'";
				}
				if(custom.equals("�绰")){
					str+=" and tel  like '%"+content+"%'";
				}
				if(custom.equals("����")){
					str+=" and fax like '%"+content+"%'";
				}
			}
		}
		 List list =new ArrayList(); //listװ��Ҫ������ֶ���
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
		  List temp =new ArrayList(); //tempװ�ص���sql server2000�洢����(up_Pager)�Ĳ���
		  temp.add("customer"); //����
		  temp.add("custID");  //�����������з�ҳ
		  temp.add("0");       //����,0-˳��,1-����
		  temp.add("custID,namefull,tel,nameshort,keyman,CONVERT(VARCHAR(10),lastdate,120) as lastdate,CONVERT(VARCHAR(10),backdate,120)as backdate ,followstep,city,calling,nowman,step"); //Ҫ��ѯ�����ֶ��б�,*��ʾȫ���ֶ�
		  temp.add(pageSize);  //ÿҳ��¼��
		  temp.add(pageNo);   //ָ����ǰ�ǵڼ�ҳ
		  temp.add("1=1"+str);  //��ѯ����
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
	 * ��ѯ��ϵ����
	 * @param custId  ��ϵ�ͻ�Id
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
	 * ��ѯ�ͻ�����
	 * @param custId  ��ϵ�ͻ�Id
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
	 * �����ϵ��¼
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
	 * ɾ����ϵ��¼
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
	 * �޸���ϵ��¼
	 * @param contactId
	 * @return
	 */
	public int updContact(List temp) {
		String sql ="update contact set custID=?,nameshort=?,contactman=?,contactdate=?,saywords=?,sales=?,xsdb=?,add1=?,contactID=?";
		return  new ConnSqlServserDB().getCount(sql,temp);
	}

}
