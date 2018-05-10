package com.lccert.crm.log4j;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*; 
import javax.servlet.http.*; 
import org.apache.log4j.*;

/**
 * log4jʵ���������ࣨ��Ŀ�л����϶�û��Ӧ��log4j��
 * @author Eason 
 *
 */
public class Log4JInit extends HttpServlet {
	
   public void init() throws ServletException{
       String prefix = getServletContext().getRealPath("/"); 
       String test = getServletContext().getRealPath(""); 
       System.out.println(prefix); 
       System.out.println(test); 
      
       System.setProperty("webappHome", test);
       System.setProperty("date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
       String file = getServletConfig().getInitParameter("log4j-config-file"); 
       System.out.println(prefix+file); 
       // ��Servlet������ȡlog4j�������ļ� 
        if (file != null) { 
         PropertyConfigurator.configure(prefix + file); 
       
       }
   }
}