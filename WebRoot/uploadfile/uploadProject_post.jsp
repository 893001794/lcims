
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@page import="com.lccert.crm.system.Forum"%>
<jsp:useBean id="up" scope="page"
	class="com.jspsmart.upload.SmartUpload" />

<%
	request.setCharacterEncoding("GBK");
	String fs = System.getProperties().getProperty("file.separator");
	//String path = new Config().ANNEX_PATH; //存放上传附件的文件夹


	//--- 上传模块 ---
	String TimeStamp = java.lang.String.valueOf((new Date()).getTime());
	String Msg = null;
	
	up.initialize(pageContext);
	up.upload();

    String icode = up.getRequest().getParameter("icode");
			String path=fs+"opt"+fs+"attachmot";
			//String path=fs+fs+"file"+fs+"10 资讯部"+fs+"attachmot";
			//System.out.println(path+":path");
	java.io.File savedir = new java.io.File(path);
	//System.out.println(savedir+":savedir");
	// 如果目录不存在就创建
	if (!savedir.exists()) {
		savedir.mkdirs();
	}
	
	for(int i=0;i<up.getFiles().getCount();i++) {
		com.jspsmart.upload.File file = up.getFiles().getFile(i);
		if(!("pdf".equals(file.getFileExt())||"PDF".equals(file.getFileExt()))){
		out.println("<script type='text/javascript'>");
		out.println("alert('上传失败,只能上传pdf文档');");
		out.println("window.self.location='uploadfile.jsp';");
		out.println("</script>");
		}else if(!file.isMissing()) {
			//保存附件到文件服务器
			String filepath = path + fs +icode+"."+file.getFileExt();
			System.out.println(filepath);
			Forum f=new Forum();
			f.setId(new Integer(icode));
			f.setImagepath(filepath);
			out.println("<script type='text/javascript'>");
			boolean flag=ForumAction.getInstance().modImagePath(f);
			if(flag ==true){
			file.saveAs(filepath);
			System.out.println("上传成功的");
			out.println("alert('上传附件成功');");
			out.println("window.self.location='../note/system_notes.jsp';");
			}else{
			out.println("alert('上传失败');");
			out.println("window.self.location='uploadfile.jsp';");
			}
						
			//保存附件路径到数据库
			
			
			out.println("</script>");
		}
	}
	
%>
<body bgcolor="eeeeee">
</body>