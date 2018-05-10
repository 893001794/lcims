package com.lccert.crm.report;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import com.lccert.crm.project.ProjectAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;

/**
 * 动态更改报告模板word文档
 * @author Eason
 *
 */
public class ReportExport extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String fs = System.getProperties().getProperty("file.separator");
		String sid = req.getParameter("sid");
		String reportid = req.getParameter("reportid");
		String exp = new SimpleDateFormat("mmss").format(new Date());
		String path = req.getSession().getServletContext().getRealPath("/");
		String infilename = path + fs + "reportmoduel" + fs + reportid + ".xml";
		String outfilename = path + "export" + fs + reportid + "-" + exp + ".doc";
		modXmlFile(sid,infilename,outfilename);
		resp.sendRedirect("export" + fs + reportid + "-" + exp + ".doc");
	}
	
	/**
	 * 创建变量Map
	 * @param sid
	 * @return
	 */
	private Map<String, String> createMap(String sid) {
		Map<String, String> map = new HashMap<String, String>();
		Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
		ChemProject cp = (ChemProject)p.getObj();
		ClientForm client = ClientAction.getInstance().getClientByName(cp.getRpclient());
		Flow flow = FlowAction.getInstance().getFlowBySid(p.getSid()).get(0);
		String rid = p.getRid();
		String date = new SimpleDateFormat("yyyy年MM月dd日").format(cp.getRptime());
		String rpclient = cp.getRpclient();
		String address = client.getAddr();
		String pdtime = new SimpleDateFormat("yyyy年MM月dd日").format(flow.getPdtime());
		String testcircle = pdtime + " 至 " + date;
		String samplename = cp.getSamplename();
		String samplecount = cp.getSamplecount();
		String sampledesc = cp.getSampledesc();
		
		map.put("$rid$", rid);
		map.put("$date$", date);
		map.put("$rpclient$", rpclient);
		map.put("$address$", address);
		map.put("$pdtime$", pdtime);
		map.put("$testcircle$", testcircle);
		map.put("$samplename$", samplename);
		map.put("$samplecount$", samplecount);
		map.put("$sampledesc$", sampledesc);
		
		return map;
	}
	
	

	/**
	 * 解释xml文档，并修改其内容
	 * @param map
	 * @param filename
	 */
	public synchronized void modXmlFile(String sid,String filename ,String outfilename){
		Document document = null;
		//利用dom4j解释xml文件
	       try{
	    	   Map<String, String> map = createMap(sid);
	           SAXReader saxReader = new SAXReader(); 
	           document = saxReader.read(new FileInputStream(new File(filename)));
	           
	           //替换内容
	           List list = document.selectNodes("//w:t" ); 
	           Iterator iter = list.iterator();
	           while(iter.hasNext()){
	        	   Element element = (Element)iter.next();
	        	   String str = element.getText();
	        	   //将变量设成你需要更换的内容，这里把变量统一设成$xxx$格式
	        	   
	        	   
	        	   if(str != null && "$rid$".equals(str.trim())) {//替换rid
	        		   System.out.println(element.getText());
	        		   String text = str.replace("$rid$", map.get("$rid$"));
	        		   element.setText(text);
	        	   } else if(str != null && "*$rid$*".equals(str.trim())) {//替换rid
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("*$rid$*", "*" + map.get("$rid$") + "*");
	        		   element.setText(text);
	        	   } else if(str != null && "$date$".equals(str.trim())) {//替换date
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$date$", map.get("$date$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$rpclient$".equals(str.trim())) {//替换rpclient
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$rpclient$", map.get("$rpclient$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$address$".equals(str.trim())) {//替换address
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$address$", map.get("$address$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$pdtime$".equals(str.trim())) {//替换pdtime
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$pdtime$", map.get("$pdtime$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$testcircle$".equals(str.trim())) {//替换testcircle
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$testcircle$", map.get("$testcircle$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$samplename$".equals(str.trim())) {//替换samplename
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$samplename$", map.get("$samplename$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$samplecount$".equals(str.trim())) {//替换samplecount
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$samplecount$", map.get("$samplecount$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$sampledesc$".equals(str.trim())) {//替换sampledesc
	        		   //System.out.println(element.getText());
	        		   String text = str.replace("$sampledesc$", map.get("$sampledesc$"));
	        		   element.setText(text);
	        	   } else if(str != null && "$samplephoto$".equals(str.trim())) {//替换samplephoto
	        		   Element bindata = null;
	        		   Element wordDocument = null;
	        		   String photo = "";
	        		   Element shape = null;
	        		   Element imgdata = null;
	        		   Element pict = null;
	        		   
	        		   	//在此目录中找文件(昨天我注视掉的)
//	        	        String baseDIR = new Config().IMG_PATH;
	        		  
	        	        //找扩展名为txt的文件
	        	        String fileName = map.get("$rid$") + "*.JPG";
//	        		    String fileName = map.get("$rid$") + ".jpg";
	        	        List<File> resultList = new ArrayList<File>();
	        	        //获取并且得到绝对路径
//	        	        String baseDIR=getPubPath(sid);
	        	        //String baseDIR=getPubPath("d:\\file");
	        	        
//	        	        System.out.println("访问公共文件夹的绝对路径："+baseDIR);
//	        	        System.out.println("访问公共文件夹的绝对路径fileName："+fileName);
//	        	        FileSearcher.findFiles(baseDIR, fileName, resultList);
//	        	        if (resultList.size() == 0) {
//	        	            System.out.println("No File Fount.");
//	        	        } else {
//	        	        	
//	        	            for (int i = 0; i < resultList.size(); i++) {
	        	            	//File file = resultList.get(i);
	        	            	File file =new File("D:\\file\\LCZC10010242.JPG");
	        	            	System.out.println(file+":file");
	        	            	 System.out.println(file.getPath());//显示查找结果。 
		        	                
	        	            	 
//	        	            	    element.setName("w:pict");
//		     	        		    element.setText("");
//		     	        		    bindata = element.addElement("w:binData");
//		     	        		    bindata.addAttribute("w:name","wordml://" +"03000005.png");
		        	            	photo = getPhotoData(file);
		        	            	StringBuffer s=new StringBuffer();
		        	            	//将下面的代码添加到xml，下面的只是字符串。
		        	     		    s.append("<w:pict>");
		        	     		    s.append("<w:binData w:name=\"wordml://03000001.png\">");
		        	     		    s.append(photo);
		        	     		    s.append("</w:binData>");
		        	     		    s.append("<v:shape style=\"width:306pt;height:230pt\">");
		        	     		    s.append("<v:imagedata src=\"wordml://03000001.png\" o:title=\"cathy\"/></v:shape>");
		        	     		    s.append("</w:pict>");    
		        	     		    element.setText(s.toString());
		        	     		    System.out.println(s);
//		     	        		    shape = bindata.addElement("v:shape");
//		     	        		    shape.addAttribute("style", "width:306pt;height:230pt");
//		     	        		    imgdata = shape.addElement("v:imagedata");
//		     	        		    imgdata.addAttribute("src", "wordml://" + file.getName());
		     	        		    //imgdata.addAttribute("o:title", "clip_image001");
	     	        		    
	        	            }
	        	        }
//	        	   }
//	           }
	           
	           exportXmlFile(document, outfilename);
	           
	       }catch(Exception ex){
	           ex.printStackTrace();
	       }
	}
	
	 private byte getByte(String s){
	    	//在保证s长度和字符符合条件下
	    	        byte []b=s.getBytes();
	    	        byte B=0;
	    	        for(int i=b.length;i>1;i--){
	    	            if(b[i-1]==49)
	    	                B+=(byte)Math.pow(2,b.length-i);
	    	        }
	    	        if(b[0]==49)
	    	            B=(byte)((int)B*(-1));
	    	        return B;
	    	    }
	/**
	 * 导出到word文件
	 * @param doc
	 * @param expfile
	 */
	public void exportXmlFile(Document doc,String outfilename){
		//把所有的图片内容含有\n字符的去掉，不知道什么原因，
        //不去掉就显示不出图片来
//        List list1 = doc.selectNodes("//w:binData" ); 
//        Iterator iter1 = list1.iterator();
//        while(iter1.hasNext()){
//     	   Element element = (Element)iter1.next();
//     	   String str = element.getText();
//     	   str = str.replaceAll("\n", "");
//     	   element.setText(str);
//     	   System.out.println( element.getText()+"--------------------------");
//        }
		//利用dom4j输出document到文件上
        try{
     	   XMLWriter writer = null;
            /** 格式化输出 */
            //OutputFormat format = OutputFormat.createPrettyPrint();
     	   //OutputFormat format = OutputFormat.createCompactFormat();
     	   //OutputFormat format = new OutputFormat();
     	   //格式化各标签之间的间隔符，这里将其设置为空
     	   OutputFormat format  = new OutputFormat("");
     	   //格式化换行符，这里将其设成空
     	   format.setLineSeparator("");
     	   
            /** 指定XML编码，一定要设成UTF-8，否则如果有中文，就会导致文件打不开 */
            format.setEncoding("UTF-8");
            writer= new XMLWriter(new FileOutputStream(new File(outfilename)),format);
            writer.write(doc);
            System.out.println("$samplephoto$"+"------------------------------------------");
            writer.flush();
            writer.close();  
          
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	/**
	 * 取得报告图片信息
	 * @param imgFile
	 * @return
	 */
	private String getPhotoData(File imgFile) {
		//System.out.println(imgFile+"------------------");
//		String imgFile = "d:\\file\\LCZC10010242.JPG";//待处理的图片
        InputStream in = null;
        byte[] data = null;
        //读取图片字节数组
        try 
        {
            in = new FileInputStream(imgFile);        
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } 
        catch (IOException e) 
        {
            e.printStackTrace();
        }finally{
        	 try {
				in.close();
			} catch (IOException e) {
				
			}
        }
        //对字节数组Base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);//返回Base64编码过的字节数组字符串
       
	}
	
	private String getPhoto(File file) {
		  String str=""; 
		  FileReader fileReader = null;
			 StringBuffer fileStr =null;
			 BufferedReader br=null;
		     try {
		    fileReader = new FileReader(file); 
			  fileStr = new StringBuffer(); 
			  br = new BufferedReader(fileReader); 
		   if(file.exists()){ 
		
				
				 
				 while((str=br.readLine())!=null){ 
				 fileStr.append(str).append("\n"); 
				 str+=fileStr.toString();
				 }
			}
		     }catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try {
					br.close();
					fileReader.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}   
			return str;
		   }
	
	


	
	//获取公共文件夹的绝对路径
	public String getPubPath(String sid){
		 Project p = ProjectAction.getInstance().getProjectBySid(sid);
		   String third = "";
		   //判断取的是8000/9000/LCDC/LCZC/LCGC的文件夹
			if ("机构合作".equals(p.getType())) {
				third = "8000";
			} else if ("y".equals(p.getIsout())) {
				third = "9000";
			} else if ("自测".equals(p.getType())) {
				Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				String company = qt.getCompany();
				if ("中山".equals(company)) {
					third = "LCZC";
				} else if ("广州".equals(company)) {
					third = "LCGC";
				} else if ("东莞".equals(company)) {
					third = "LCDC";
				}
			}
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");//设置日期格式 2010-08-01
			String date =sdf.format(new Date());
			String year=date.substring(0, 4);//获取年份
			String month=date.substring(5, 7);//获取月份
//			String head = new Config()._PATH;
			//得到间隔符的方法（共享系统默认的" \ "值）
			String fs = System.getProperties().getProperty("file.separator");
			String filepath =fs+fs+"file"+ fs+"13 报告照片" + fs + year + fs + month + fs + third;
		return filepath;
	}
}
