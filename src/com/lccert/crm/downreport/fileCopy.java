package com.lccert.crm.downreport;




import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;


import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;


import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.FileCopyCode;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.project.ChemProjectAction;

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


/**
 * 动态更改报告模板word文档
 * @author Eason
 *
 */
public class fileCopy extends HttpServlet{
	String fs = System.getProperties().getProperty("file.separator");
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
//		//		//获取页面上面传过来的值
		 String rid = req.getParameter("rid");
		 String obj = req.getParameter("worktype");
		 String CNAS =""; //声明一个变量
		 String docPath="";
		 String pdfPath="";
		 String comp =rid.substring(2,3);
		 String rptype = ChemProjectAction.getInstance().getEtypeByRid(rid);
		 String type="";
		 List list =isCNAS(rid);
		 for(int i=0;i<list.size();i++){
				Flow flow =(Flow)list.get(i);
				if(flow.getCnastatus().equals("n")){  //判断是否带CNAS章
				CNAS="";
				}else{
				CNAS="_CNAS";
				}
		}
		 List typeList =new ArrayList ();
		if(rptype.equals("中文报告") ){
				type ="C";
				typeList.add(type);
		}
		else if(rptype.equals("英文报告") ){
				type ="E";
				typeList.add(type);
		}if(rptype.equals("双语报告")){
				typeList.add("C");
				typeList.add("E");
		}
		boolean flag =false;
		//获取某个报告的PDF文件
			try{
				for(int i =0;i<typeList.size();i++){
					if(CNAS !=null ||!"".equals(CNAS)){
					docPath=rid+"-"+typeList.get(i)+"(CNAS)"+".doc";
					}else{
						docPath=rid+"-"+typeList.get(i)+CNAS+".doc";
					}
					pdfPath=rid+"-"+typeList.get(i)+CNAS+".pdf";
					String cmds ="mv /opt/bak/verify/"+docPath+" /opt/bak/print"; 
					Process pro = Runtime.getRuntime().exec(cmds); 
					String cmds1 ="mv /opt/bak/verify/"+pdfPath+" /opt/bak/verify/FINISH";
					Process pro1 = Runtime.getRuntime().exec(cmds1); 
//					String oldPath="E:/";
//					String newPath="D:/";
//					new FileCopyCode().copyFile(oldPath+docPath, newPath+docPath);
//					new FileCopyCode().copyFile(oldPath+pdfPath, newPath+pdfPath);
				}
				flag =true;
			}catch (Exception ex){
				flag =false;
			}
			if(flag ==true){
				//resp.sendRedirect(req.getHeader((""),"?worktype="+obj+"&rid="+rid));
				resp.sendRedirect(req.getHeader("Referer")+"?worktype="+obj+"&rid="+rid);
			}
        }
	
	//根据报告号来查询是否要加CNAS章
	public List  isCNAS(String rid){
		String sql = "select vcnastatus  from t_chem_flow where vrid=? and vcnastatus is not null";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		Flow flow ;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	System.out.println(sql+"---"+rid);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flow =new Flow();
				flow.setCnastatus(rs.getString("vcnastatus"));
				list.add(flow);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	

}
