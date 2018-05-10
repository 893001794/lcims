package com.lccert.crm.downreport;



import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;


import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import sun.misc.BASE64Encoder;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.Config;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.client.ClientForm;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.flow.FlowAction;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;


/**
 * 动态更改报告模板word文档
 * @author Eason
 *
 */
public class DownLoad extends HttpServlet{
	String fs = System.getProperties().getProperty("file.separator");
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
//		//获取tomcat上面的地址
		String path = req.getSession().getServletContext().getRealPath("/");
		//word保存的路径
		String outfilename = path + "export" + fs;
//		//获取页面上面传过来的值
		String rid = req.getParameter("rid");
		//报告类型
		String filetype = req.getParameter("filetype");
		
		   String fileName = rid+"*."+filetype; 
		 //    在此目录中找文件
		   
		   
//        String baseDIR = "D:"+fs+"report"+fs+"fishreport"; 
        
//		   String baseDIR = fs+"oa"+fs+"22 化学报告"+fs+"已完成的报告存档"+fs; 
		   String baseDIR = fs+"oa"+fs+"opt"+fs+"chemrep"+fs; 
		   String OUT2TUV="";
		   String comp =rid.substring(2,3);
//		   System.out.println(rid.substring(9,10));
//		   if(Integer.parseInt(rid.substring(9,10))!=9){
//			   System.out.println("jinlia");
//		   }
				if(Integer.parseInt(rid.substring(8,9))==8&&Integer.parseInt(rid.substring(9,10))!=9){
					baseDIR=baseDIR+"8000"+fs;
					if (comp.equals("D")){
						baseDIR=baseDIR+"80DC"+fs;
					}
					if (comp.equals("G")){
						baseDIR=baseDIR+"80GC"+fs;
					}else{
						baseDIR=baseDIR+"80ZC"+fs;
					}
				}else if(Integer.parseInt(rid.substring(8,9))==9){
					baseDIR=baseDIR+"9000"+fs;
					if (comp.equals("D")){
						baseDIR=baseDIR+"90DC"+fs;
					}else if (comp.equals("G")){
						baseDIR=baseDIR+"90GC"+fs;
					}else{
						baseDIR=baseDIR+"90ZC"+fs;
					}
				}else if (comp.equals("G")){
					baseDIR=baseDIR+"LCGC"+fs;
				}else if (comp.equals("D")){
					baseDIR=baseDIR+"LCDC"+fs;
					
				}else if(req.getParameter("draft")!=null){
					baseDIR=baseDIR+req.getParameter("draft")+fs;
				}
				
				else {
					baseDIR=baseDIR+"LCZC"+fs;
				}
				baseDIR=baseDIR+rid.substring(4, 8)+fs;
	        List<File> resultList = new ArrayList<File>();
	        FileSearcher.findFiles(baseDIR, fileName, resultList,filetype,2); 
	    
	        if (resultList.size() == 0) {
	            System.out.println("No File Fount.");
	        }else {
	            for (int i = 0; i < resultList.size(); i++) {
            	//跳转页面
                resp.setContentType("bin;charset=GBK"); //arg1是HttpServletResponse对象
                String a=resultList.get(i).toString();
                String downFileName=a.substring(a.lastIndexOf(fs)+1,a.length());
                resp.setHeader("Content-Disposition", "filename="+downFileName);
                //    找扩展名为txt的文件
                InputStream is = new FileInputStream(resultList.get(i).toString());
                byte[] b = new byte[4096];
                int len;
                while ((len = is.read(b)) > 0)
                {
                	resp.getOutputStream().write(b, 0, len);
                }
                is.close(); 
                resp.getOutputStream().close();
                }
        }
	

      
		

	}
	
	
	

}
