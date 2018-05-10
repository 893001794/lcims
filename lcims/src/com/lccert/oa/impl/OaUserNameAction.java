package com.lccert.oa.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.DaoFactory;
/***
 *按部门获取oa的用户
 * @author tangzp
 *
 */
public class OaUserNameAction extends HttpServlet {
	/**
	 * Constructor of the object.
	 */
	public OaUserNameAction() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		response.setContentType("text/html; charset=GBK");//解决乱码		
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
        //request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
	    PrintWriter outData = response.getWriter();
	    int parentId = Integer.parseInt(request.getParameter("parentId"));  //获取传过来的值
		String xmlString = getSelectValue(parentId); //调用查询验证的方法
		outData.write(xmlString); //将xmlString 传输到Jsp页面
		outData.flush();  //清空
		outData.close();//关闭
		
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
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
	
	
	public String getSelectValue(int parentId) {
//		 String xml_start = "<select name=\"servid\" style=\"width: 300px\">";
//	     String xml_end = "</select>";
		 String xml_start = "<provinces>";
	     String xml_end = "</provinces>";
	     String xml = "";
	     String last_xml="";
		List row=DaoFactory.getInstance().getOaVacationTypeDao().getIdByParentID(parentId);
		if(row.size()>0){
			for(int i=0;i<row.size();i++){
				List column =(List)row.get(i);
				int deptId=Integer.parseInt(column.get(0).toString());
				List row1=DaoFactory.getInstance().getOaVacationTypeDao().getNameBydeptId(deptId);
				for(int j=0;j<row1.size();j++){
					List column1 =(List)row1.get(j);
//					System.out.println(column1.get(0));
					xml += "<province id=\"" + column1.get(1)+ "\" name=\"" +column1.get(2) + "\"></province>";
//					xml +="<option value=\"" + column1.get(0)+ "\">"+column1.get(2)+ "</option>";
				}
			}
			
//		last_xml = xml_start + xml + xml_end;
//			last_xml=xml;
		}else{
			List row1=DaoFactory.getInstance().getOaVacationTypeDao().getNameBydeptId(parentId);
			for(int j=0;j<row1.size();j++){
				List column1 =(List)row1.get(j);
//				System.out.println(column1.get(0));
				xml += "<province id=\"" + column1.get(1)+ "\" name=\"" +column1.get(2) + "\"></province>";
				//xml +="<option value=\"" + column1.get(0)+ "\">"+column1.get(2)+ "</option>";
			}
			
		}
		last_xml = xml_start + xml + xml_end;
//		System.out.println(last_xml);
		return last_xml;
	}
}
