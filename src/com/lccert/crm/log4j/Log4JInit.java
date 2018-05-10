package com.lccert.crm.log4j;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*; 
import javax.servlet.http.*; 
import org.apache.log4j.*;

/**
 * log4j实例化工具类（项目中基本上都没有应用log4j）
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
       // 从Servlet参数读取log4j的配置文件 
        if (file != null) { 
         PropertyConfigurator.configure(prefix + file); 
       
       }
   }
}