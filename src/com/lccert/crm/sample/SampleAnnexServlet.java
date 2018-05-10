package com.lccert.crm.sample;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.Config;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;

/**
 * 补样/换样附件下载工具类
 * @author Eason
 *
 */
public class SampleAnnexServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setCharacterEncoding("GBK");
		resp.setContentType("application/x-download;text/html;charset=GBK");
		String sid = req.getParameter("sid");
		if(sid == null || "".equals(sid)) {
			resp.getWriter().println("附件不存在");
			return;
		}
		Project p = ChemProjectAction.getInstance().getChemProjectBySid(sid, "");
		ChemProject cp = (ChemProject)p.getObj();
		if(p == null || cp.getFilepath() == null || "".equals(cp.getFilepath())) {
			resp.getWriter().println("附件不存在");
		} else {
			String head = new Config()._PATH;
			OutputStream out = resp.getOutputStream();
			String fs = System.getProperties().getProperty("file.separator");
			String path = head + fs + cp.getFilepath();
			File file = new File(path);
			InputStream in = new FileInputStream(file);
			resp.reset();
			resp.addHeader("Content-Disposition", "attachment; filename=\"fujian.doc\"");  
			byte[] b = new byte[1024]; 
			int len;
			try { 
				while ((len = in.read(b)) > 0) {
					out.write(b, 0, len);
				}
				resp.getOutputStream().flush();
				in.close();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
