package com.lccert.crm.project;



import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;



import sun.misc.BASE64Encoder;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.kis.Item;
import com.lccert.crm.kis.ItemAction;




/**
 * 动态更改报告模板word文档
 * @author Eason
 *
 */
public class PhpXloadTree extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		processRequest(req,resp);
	}
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println("<tree>");
            List list = ItemAction.getInstance().getPhpItemNumber();
           	Item item;
           for (int i = 0; i < list.size(); i++) {
        	   item = (Item) list.get(i);
        	   out.println("<tree text='" + item.getName()+"|"+item.getItemNumber() + "'>");
                //out.println("<tree text='" + item.getName() + "'>");
                if(!item.equals(null)){
                    List alist = ItemAction.getInstance().getPhp2ItemNumber(item.getItemNumber());
                    for(int j = 0; j < alist.size(); j ++){
                    	Item item2 = (Item)alist.get(j);
                    	out.println("<tree text='" + item2.getName()+"|"+item2.getItemNumber()  + "' />");
//                        out.println("<tree text='"+ item2.getName() + "'>");
                    }
                }
                out.print("</tree>");
            }
            out.println("</tree>");
        } finally { 
            out.close();
        }
	}
	
	
}
