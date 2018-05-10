package com.lccert.crm.quotation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.DelRepeatStr;
import com.lccert.crm.kis.ItemAction;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.vo.EdmQuoitem;
import com.lccert.oa.db.ImsDB;
/***
 * 密码验证的servlet类
 * @author tangzp
 *
 */
public class EmdPrice extends HttpServlet {
	/**
	 * Constructor of the object.
	 */
	public EmdPrice() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        response.setContentType("text/xml; charset=GBK");		
	    PrintWriter outData = response.getWriter();
	    String empida = request.getParameter("empida");  //获取传过来的值
	    String userid = request.getParameter("userid");  //获取传过来的值
	    String pid = request.getParameter("pid");  //获取传过来的值
	    String projectleader = request.getParameter("projectleader");  //获取传过来的值
	    String xmlString="" ;
	    if(userid ==null&&projectleader==null){
	    	xmlString = getEmdPrice(empida); //调用查询验证的方法
	    }else if (projectleader !=null){
	    	xmlString=getSampling(projectleader);
	    }else{
	    	xmlString=adddPCInfor(empida,userid,pid);
	    }
		outData.write(xmlString); //将xmlString 传输到Jsp页面
		outData.flush();  //清空
		outData.close();//关闭
		
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doGet(request,response);


	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	
	public String getEmdPrice(String str1) {
		  int id =0;
		  float totalprice=0f;
		 Set set=new DelRepeatStr().delRepeatStr(str1);
			Iterator  it=set.iterator();
			 while(it.hasNext()){
				 String str=it.next().toString();
				 if(str !=null && !"".equals(str)){
					 id=Integer.parseInt(str);
				 }
				List list =ItemAction.getInstance().getPrice(id);
				totalprice+=Float.parseFloat(list.get(0).toString());
			 }
		String xml = "<?xml version='1.0' encoding='GBK' ?>";
		xml = xml+"<agent suc='true' name='"+totalprice+"'/>";
		return xml;
	}
	public String getSampling(String str1) {
		System.out.println(str1);
		String str=str1.substring(str1.indexOf("(")+1,str1.indexOf(")"));
		String []userIdStr=str.split(",");
		String userName="";
		int userId =0;
		if(userIdStr.length>0){
			for(int i=0;i<userIdStr.length;i++){
				userId=Integer.parseInt(userIdStr[i]);
				userName+=UserAction.getInstance().getNameById(userId)+"、";
			}
		}
		String xml = "<?xml version='1.0' encoding='GBK' ?>";
		xml = xml+"<agent suc='true' name='"+userName+"'/>";
		return xml;
	}
	
	public String adddPCInfor(String pt,String userid,String pid) {
		int testId=0;
		String[] projectTests=pt.split(",");
		//String[] userids=userid.split(",");
		boolean flag=false;
		for(int i=0;i<projectTests.length;i++){
			testId=Integer.parseInt(projectTests[i].toString());
			//查询二级分类的类型
			List list =ItemAction.getInstance().getPrice(testId);
			String type=list.get(1).toString();
			EdmQuoitem qi=new EdmQuoitem();
			qi.setPid(pid);
			qi.setUserid(userid);
			qi.setProjectid(testId);
			qi.setType(type);
			flag=EdmQuotationAction.getInstance().addQuotation(qi);
		}
		String xml = "<?xml version='1.0' encoding='GBK' ?>";
		xml = xml+"<agent suc='"+flag+"'/>";
		return xml;
	}
}
