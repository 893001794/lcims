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
public class LookFile extends HttpServlet{
	String fs = System.getProperties().getProperty("file.separator");
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
//		//获取页面上面传过来的值
		String filePath = req.getParameter("filePath");
            	//跳转页面
                resp.setContentType("bin;charset=GBK"); //arg1是HttpServletResponse对象
                String baseDIR=filePath.substring(0,filePath.lastIndexOf(fs));
                String fileName=filePath.substring(filePath.lastIndexOf(fs)+1,filePath.lastIndexOf("-")+2)+"*"+filePath.substring(filePath.lastIndexOf("."),filePath.length());
                String filetyp=filePath.substring(filePath.lastIndexOf(".")+1,filePath.length());
                List<File> resultList = new ArrayList<File>();
    	        FileSearcher.findFiles(baseDIR, fileName, resultList,filetyp,2); 
    	    
    	        if (resultList.size() == 0) {
    	            System.out.println("No File Fount.");
    	        }else {
    	            for (int i = 0; i < resultList.size(); i++) {
                	//跳转页面
    	            resp.reset();    
                    resp.setContentType("bin;charset=GBK"); //arg1是HttpServletResponse对象
                    String a=resultList.get(i).toString();
                    String downFileName=a.substring(a.lastIndexOf(fs)+1,a.length());
//                    System.out.println(a+"---------------"+downFileName);
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
