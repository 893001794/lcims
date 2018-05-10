<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.io.File"%>

<%
String fs = System.getProperties().getProperty("file.separator");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="reset.css" rel="stylesheet" type="text/css" />
    	<script type="text/javascript">
    		function a (obj){
    			alert(obj);
    		}
    	</script>
        </head>
        <body>
        	<form action="../fileCopy" method="post" >
        		<table>
        		<%
        		//opt/bak/verify/temp.doc 
        		File file=new File(fs+"oa"+fs+"opt"+fs+"bak"+fs+"verify");
				File[] files = file.listFiles(); 
					if (files == null) {
					return ;
					 }
				   for (int i = 0; i < files.length;i++){ 
				   		//if(i%8==0){
        		 %>
		   			<tr>
		   			<%
		   			 if (files[i].isDirectory()) { 
						 }else { 
						 String fileName=files[i].getAbsolutePath();
						//  if(fileName.substring(fileName.lastIndexOf(".")+1,fileName.length()).equals("pdf")){
						  %>
		   				<td>
		   					<a href="../lookFile?filePath=<%=fileName%>"><%=fileName.substring(fileName.lastIndexOf(fs)+1,fileName.length())%></a>
		   				</td>
		   			<%
		   				//	}
		   				}
		   			 %>
		   			</tr>
		   			<%
		   				}
		   			// }
		   			 %>
		   		</table>
        	</form>
        </body>
        </html>