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
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.Config;
import com.lccert.crm.chemistry.util.DrawName;
import com.lccert.crm.chemistry.util.SendEmail;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.client.ClientForm;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.dao.impl.ProjectChemImpl;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.flow.FlowAction;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.ProjectAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;


/**
 * 动态更改报告模板word文档
 * @author Eason
 *
 */
public class pdfEmail extends HttpServlet{
	String fs = System.getProperties().getProperty("file.separator");
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String rid ="";
		String type="";
		//弹出文件路径
		String filePathResult="";
		boolean flag =true;
//		//获取tomcat上面的地址
		String path = req.getSession().getServletContext().getRealPath("/");
		//word保存的路径
		String outfilename = path + "export" + fs;
//		//获取页面上面传过来的值
		String ridStr = req.getParameter("ridStr");
		//获取客户名称
		String clientName =req.getParameter("client");
		//获取客户邮箱地址，可能会有多个
		String mailStr =req.getParameter("mail");
		//获取联系人
		String surname =req.getParameter("surname");
		//发件人
		String activeUser =req.getParameter("activeUser");
		if(activeUser !=null){
			activeUser =new String (activeUser.getBytes("ISO8859-1"),"GBK");
		}
		//发件人的邮箱
		UserForm userForm=UserAction.getInstance().getUserByName(activeUser);
		String senderMail =userForm.getEmail();
		//根据客户名查询客户资料
		if(clientName !=null){
			clientName =new String (clientName.getBytes("ISO8859-1"),"GBK");
		}
		if(surname !=null){
			surname =new String (surname.getBytes("ISO8859-1"),"GBK");
		}
		if(ridStr !=null){
			ridStr=new String(ridStr.getBytes("ISO8859-1"),"GBK");
		}
		//将客户邮箱作为数组
		String [] mailArray =mailStr.split(";");
		ClientForm client = ClientAction.getInstance().getClientByName(clientName);
		String saleEmail="";
		//用来装邮件附件的文件数组
		List fileList=new ArrayList();
		//得到一个数组
		String [] ridL =ridStr.split(",");
		String lastRid="";
		for(int i =0;i<ridL.length;i++){
			String ridType=ridL[i];
			rid=ridType.substring(0,ridType.indexOf("-"));
			lastRid=rid;
			type=ridType.substring(ridType.indexOf("-")+1,ridType.length());
			//查找文件
			List resultList =findFile(rid,"pdf",req);
			if(resultList.size()>0){
				for(int j=0;j<resultList.size();j++){
					filePathResult=resultList.get(j).toString();
					fileList.add(resultList.get(j));
				}
			}else{
				resp.setContentType("text/html; charset=GBK");
				resp.getWriter().println("<script>");
				resp.getWriter().println("alert(\"没有找到PDF文档\")");
				resp.getWriter().println("window.history.back();"); 
				resp.getWriter().println("window.close();"); 
				resp.getWriter().println("</script>");
				break;
			}
			//根据报告号添加发放时间
			ProjectAction.getInstance().updateGrantTime(rid);
		}
		//根据报告好查询报价单
		String pid =ProjectChemImpl.getInstance().getPidByRid(lastRid);
		Quotation q=QuotationAction.getInstance().getEngByRid(pid);
		
		UserForm user=UserAction.getInstance().getUserByName(q.getSales());
		//收件人的数组
		List toList =new ArrayList();
	 	//相关的销售
		toList.add(user.getEmail());
		toList.add("maimq@lccert.com");
	 	//获取每个邮箱
		if(mailArray.length>0){
			for(int i=0;i<mailArray.length;i++){
				//将客户邮箱添加到收件人数组中
				toList.add(mailArray[i]);
				System.out.println(mailArray[i]);
			}
		}
		//登陆人或发件人
		toList.add(senderMail);
	 	//邮件标题
	 	String head ="请查收电子档检测报告";
	 	//邮件内容
	 	StringBuffer content = new StringBuffer(surname+"：<br><br>");
	 	 content.append("&nbsp;&nbsp;您好！<br><br>");
	 	 content.append("&nbsp;&nbsp;请查阅附件关于贵司的电子档检测报告。<br><br>");
	 	 content.append("&nbsp;&nbsp;如果您对报告或测试服务有任何疑问，欢迎您随时与我们联系。谢谢您对我司的支持！<br><br>");
	 	 content.append("祝好！<br><br><br>");
	 	 content.append("Best Regards,<br>");
	 	 content.append(userForm.getName()+"<br>");
	 	 content.append("Helen<br>");
	 	 content.append("客服专员<br>");
	 	 content.append("Customer Service Representative<br>");
	 	 content.append("客户服务部<br>");
	 	 content.append("Customer Service Department<br>");
	 	 content.append("-------------------------------------------------------------------------------------------------------<br>");
	 	 content.append("立创检测技术服务有限公司<br>");
	 	 content.append("LCTECH Testing Services Co., Ltd<br><br>");
	 	 content.append("地址: 广东中山小榄广源路科技创业中心立创检测大厦 (邮政编码：528415)<br>");
	 	 content.append("ADD: LCTECH Plaza, Science Technology and Enterprise Development Center,<br>");
	 	 content.append("&nbsp;&nbsp;Guangyuan Rd., Xiaolan, Zhongshan, Guangdong, 528415, P. R. China<br>");
	 	 content.append("TEL: +86 (760) 2283 3366 x 209, +86 (760) 2283 3593<br>");
	 	 content.append("TEL: "+userForm.getTel()+"<br>");
	 	
	 	 content.append("-------------------------------------------------------------------------------------------------------");
	 	//调用发邮件的方法
	 	try {
	 		if(fileList.size()>0){
	 			new SendEmail().WithAttachmentsEmail(senderMail,toList, head, content.toString(), fileList);
	 		}
		} catch (Exception e) {
			flag =false;
		}
		if(flag == true&&fileList.size()>0){
			//提示并返回值同时关闭当前窗口,只适用于用window.open打开的窗口
			resp.setContentType("text/html; charset=GBK"); 
			resp.getWriter().println("<script>"); 
			resp.getWriter().println("alert('发送成功');"); 
			//resp.getWriter().println("alert("+filePathResult+");"); 
			resp.getWriter().println("window.history.back();"); 
			resp.getWriter().println("window.close();"); 
			resp.getWriter().println("</script>"); 
			// Java中关于弹出对话框的问题2006-08-06 23:02
//			 PrintWriter out = response.getWriter(); 
//			 out.write( "<script language=\"javascript\">" ); 
//			 out.write( "alert(\"" + msg + "\");" ); 
//			 out.write( "location.href=\"" + url + "\";" ); 
//			 out.write( "</script>" ); 

			} else{
			resp.setContentType("text/html; charset=GBK"); 
			resp.getWriter().println("<script>"); 
			resp.getWriter().println("alert('发送失败 ');"); 
			resp.getWriter().println("window.history.back();"); 
			resp.getWriter().println("window.close();"); 
			resp.getWriter().println("</script>"); 
			}
	}
	
	public List findFile(String rid,String filetype,HttpServletRequest req){
//		 String baseDIR=fs+fs+"file"+fs+"22 化学报告"+fs;
//		 String baseDIR ="d:"+fs;
//		String baseDIR = "D:"+fs+"oa"+fs+"opt"+fs+"chemrep"+fs;
		 String baseDIR =fs+"oa"+fs+"opt"+fs+"chemrep"+fs;
		 String fileName =rid+"*."+filetype; 
		 String comp =rid.substring(2,3);
			if(Integer.parseInt(rid.substring(8,9))==8){
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
				}
				if (comp.equals("G")){
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
			}else if(Integer.parseInt(rid.substring(8,9))==3){
				baseDIR=baseDIR+"3000"+fs;
			}else if(Integer.parseInt(rid.substring(8,9))==6){
				baseDIR=baseDIR+"6000"+fs;
			}else if(Integer.parseInt(rid.substring(8,9))==5){
				//根据报告查询化妆品号
				String filingno=ProjectChemImpl.getInstance().getFilingno(rid);	
				System.out.println(filingno+"*****00********");
				baseDIR=baseDIR+"GDGF"+fs+new SimpleDateFormat("yyyy").format(new Date())+fs;
				fileName=filingno+"*."+filetype; 
			}
			else {
				baseDIR=baseDIR+"LCZC"+fs;
			}
		if(Integer.parseInt(rid.substring(8,9))!=5){
			baseDIR=baseDIR+rid.substring(4,8)+fs;
		}
	     List<File> resultList = new ArrayList<File>();
	     FileSearcher.findFiles(baseDIR, fileName, resultList,filetype,0); 
	     String filePath="";
 		 for(int i=0;i<resultList.size();i++){
 			filePath=resultList.get(i).toString();
 		 }
	     if (resultList.size() == 0) {
//	    	 resultList.add(baseDIR);
	         System.out.println("No File Fount.");
	     }
	     return resultList;
	}
	
	
	

}
