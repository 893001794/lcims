package com.lccert.crm.chemistry.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;

/**
 * 读取配置文件工具类
 * @author Eason
 *
 */
public class Config {
	public String _PATH;
	public String IMG_PATH;

	public Config() {
		// 加载配置文件文件
		try {
			Properties pp = new Properties();
			pp.load(getClass().getResourceAsStream("config.properties"));
			_PATH = pp.getProperty("path");
			IMG_PATH = pp.getProperty("imgpath");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public String getImage(String sid){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");//设置日期格式 
		// new Date()为获取当前计算机系统时间 
		String date =sdf.format(new Date());
		String year=date.substring(0, 4);
		String mon=date.substring(5, 7);
		String image="";
		String file ="\\file\13 报告照片"+"\\"+year+"\\"+mon+"\\";
		Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid,"");
		if(p.getSubname()!=null || p.getSubname2()!=null){
			if(p.getSubname().indexOf("TUV")==0){
				file +=8000;
			}else{
				file +=9000;
			}
			
		}else{
			file +=p.getRid().subSequence(0, 4);
		}
		file +="\\"+p.getRid();
		
		return file;
	}

}
