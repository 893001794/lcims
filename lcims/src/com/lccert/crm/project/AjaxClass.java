package com.lccert.crm.project;

import java.io.IOException;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.flow.FlowAction;
import com.lccert.crm.vo.FlowTest;
/***
 * ajax
 * @author tangzp
 *
 */
public class AjaxClass extends HttpServlet {
	
	private static final long serialVersionUID = 508034694578777041L;
	public AjaxClass() {
		// TODO Auto-generated constructor stub
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		String xmlString=""; //ajax返回值
        response.setContentType("text/xml; charset=GBK");		
	    PrintWriter outData = response.getWriter();
	    String method=request.getParameter("method");
	    if(method !=null && "batchProjectStatus".equals(method)){
	    	xmlString =batchProjectStatus(request);
	    }else if(method !=null && "changeFlowTestCount".equals(method)){
	    	xmlString =changeFlowTestCount(request);
	    }
	    
		outData.write(xmlString); //将xmlString 传输到Jsp页面message=''
		outData.flush();  //清空
		outData.close();//关闭
	}
	/**
	 * 实验室流转单修改测试点数
	 * @param request
	 * @return
	 */
	public String changeFlowTestCount(HttpServletRequest request){
		String xmlString=""; //ajax返回值
		String id=request.getParameter("id");
		String countStr=request.getParameter("count");
		int count=0;
		if(countStr!=null&&!countStr.equals("")){
			count=Integer.parseInt(countStr);
		}
		FlowTest flowTest=new FlowTest();
		flowTest.setId(Integer.parseInt(id));
		flowTest.setCount(count);
		try {
			DaoFactory.getInstance().getFlowTest().updateFlowTest(flowTest);
			xmlString = xmlString+"<agent suc='true' />";
		} catch (Exception e) {
			xmlString = xmlString+"<agent suc='false' />";
		}
		return xmlString;
	}
	/**
	 * 电子电器批量更改状态
	 * @param request
	 * @return
	 */
	public String batchProjectStatus(HttpServletRequest request){
		String xmlString=""; //ajax返回值
		String sidStr = request.getParameter("sidStr");  //获取传过来的项目编号
	    String startus = request.getParameter("startus");  //获取传过来的状态
	    if(startus !=null &&!"".equals(startus)){
	    	try {
				startus=new String(startus.getBytes("ISO-8859-1"),"UTF-8");
				String sid="";
				boolean flag=false;
				Integer isFlow=0;
				if(sidStr.indexOf(",")>-1){
					String[] sids=sidStr.split(",");
					for(int i=0;i<sids.length;i++){
						sid=sids[i];
						if(sid!=null&& !"".equals(sid)){
							List fidList =FlowAction.getInstance().getFlowBySid(sid);
							Flow flow=new Flow();
							if(fidList.size()>0){
								flow=(Flow)fidList.get(0);
								 //更改项目状态
								flag=PhyProjectAction.getInstance().upPhyStart(startus,flow.getRid(),sid,flow.getFid(),2);
								if(flag==false){
									isFlow=2;
								}
							}else{
								isFlow=1;
							}
						}
					}
				}
				if(isFlow==1){
					xmlString = xmlString+"<agent suc='false' />";
				}else if(isFlow==2){
					xmlString = xmlString+"<agent suc='false' />";
				}else{
					xmlString = xmlString+"<agent suc='true' />";
				}
				return xmlString;
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
		return null;
	}
	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);


	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	
	
}
