package com.lccert.www;

import java.io.BufferedReader;   
import java.io.IOException;   
import java.io.InputStream;   
import java.io.InputStreamReader;   
import java.net.HttpURLConnection;   
import java.net.URL;   
import java.nio.charset.Charset;   
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;   
import java.util.Vector;   

import com.lccert.crm.chemistry.util.DB;
    
/**  
 * HTTP请求对象  
 *   
 * @author Eason
 */  
public class HttpRequest {   
    private String defaultContentEncoding;   
    
    public HttpRequest() {   
        this.defaultContentEncoding = Charset.defaultCharset().name();   
    }   
    
    /**  
     * 发送GET请求  
     *   
     * @param urlString  
     *            URL地址  
     * @return 响应对象  
     * @throws IOException  
     */  
    public HttpResponse sendGet(String urlString) throws IOException {   
        return this.send(urlString, "POST", null, null);   
    }   
    
    /**  
     * 发送GET请求  
     *   
     * @param urlString  
     *            URL地址  
     * @param params  
     *            参数集合  
     * @return 响应对象  
     * @throws IOException  
     */  
    public HttpResponse sendGet(String urlString, Map<String, String> params)   
            throws IOException {   
        return this.send(urlString, "POST", params, null);   
    }   
    
    /**  
     * 发送GET请求  
     *   
     * @param urlString  
     *            URL地址  
     * @param params  
     *            参数集合  
     * @param propertys  
     *            请求属性  
     * @return 响应对象  
     * @throws IOException  
     */  
    public HttpResponse sendGet(String urlString, Map<String, String> params,   
            Map<String, String> propertys) throws IOException {   
        return this.send(urlString, "POST", params, propertys);   
    }   
    
    /**  
     * 发送POST请求  
     *   
     * @param urlString  
     *            URL地址  
     * @return 响应对象  
     * @throws IOException  
     */  
    public HttpResponse sendPost(String urlString) throws IOException {   
        return this.send(urlString, "POST", null, null);   
    }   
    
    /**  
     * 发送POST请求  
     *   
     * @param urlString  
     *            URL地址  
     * @param params  
     *            参数集合  
     * @return 响应对象  
     * @throws IOException  
     */  
    public HttpResponse sendPost(String urlString, Map<String, String> params)   
            throws IOException {   
        return this.send(urlString, "POST", params, null);   
    }   
    
    /**  
     * 发送POST请求  
     *   
     * @param urlString  
     *            URL地址  
     * @param params  
     *            参数集合  
     * @param propertys  
     *            请求属性  
     * @return 响应对象  
     * @throws IOException  
     */  
    public HttpResponse sendPost(String urlString, Map<String, String> params,   
            Map<String, String> propertys) throws IOException {   
        return this.send(urlString, "POST", params, propertys);   
    }   
    
    /**  
     * 发送HTTP请求  
     *   
     * @param urlString  
     * @return 响映对象  
     * @throws IOException  
     */  
	private HttpResponse send(String str, String method,   
            Map<String, String> parameters, Map<String, String> propertys){   
        HttpURLConnection urlConnection = null;
        HttpResponse resp = null;
        String urlString = "";
    
        if (method.equalsIgnoreCase("POST") && parameters != null) {   
            StringBuffer param = new StringBuffer();   
            int i = 0;   
            for (String key : parameters.keySet()) {   
                if (i == 0)   
                    param.append("?");   
                else  
                    param.append("&");   
                param.append(key).append("=").append(parameters.get(key));   
                i++;   
            }   
            str += param;   
        }   
        str = str.replaceAll(" ", "%20");
//        try {
        		urlString = str;
        		System.out.println(urlString+"网站上的信息路径");
        		updatelocaldata(urlString);
//		        URL url = new URL(urlString);   
//		        urlConnection = (HttpURLConnection) url.openConnection();   
//		        urlConnection.setRequestMethod(method);   
//		        urlConnection.setDoOutput(true);   
//		        urlConnection.setDoInput(true);   
//		        urlConnection.setUseCaches(false);   
//		        if (propertys != null)   
//		            for (String key : propertys.keySet()) {   
//		                urlConnection.addRequestProperty(key, propertys.get(key));   
//		            }   
//		    
//		        if (method.equalsIgnoreCase("POST") && parameters != null) {   
//		            StringBuffer param = new StringBuffer();   
//		            for (String key : parameters.keySet()) {   
//		                param.append("&");   
//		                param.append(key).append("=").append(parameters.get(key));   
//		            }   
//		            urlConnection.getOutputStream().write(param.toString().getBytes());   
//		            urlConnection.getOutputStream().flush();   
//		            urlConnection.getOutputStream().close();   
//		        }   
//		        resp = this.makeContent(urlString, urlConnection);
//		        if(!"ok".equals(resp.getContent())) {
//		        	System.out.println("远程数据更新失败!");
//		        }
//        } catch (IOException e) {
//        	System.out.println("网络出现故障！");
//        	
//        }
        return resp;
    }   
    
    /**  
     * 得到响应对象  
     *   
     * @param urlConnection  
     * @return 响应对象  
     * @throws IOException  
     */  
    private HttpResponse makeContent(String urlString,   
            HttpURLConnection urlConnection) throws IOException {   
        HttpResponse httpResponser = new HttpResponse();   
        try {   
            InputStream in = urlConnection.getInputStream();   
            BufferedReader bufferedReader = new BufferedReader(   
                    new InputStreamReader(in));   
            httpResponser.contentCollection = new Vector<String>();   
            StringBuffer temp = new StringBuffer();   
            String line = bufferedReader.readLine();   
            String str = "";
            while (line != null) {   
                httpResponser.contentCollection.add(line);   
                str = line;
                //temp.append(line).append("\r\n");   
                line = bufferedReader.readLine();   
            }   
            temp.append(str);
            bufferedReader.close();   
    
            String ecod = urlConnection.getContentEncoding();   
            if (ecod == null)   
                ecod = this.defaultContentEncoding;   
    
            httpResponser.urlString = urlString;   
    
            httpResponser.defaultPort = urlConnection.getURL().getDefaultPort();   
            httpResponser.file = urlConnection.getURL().getFile();   
            httpResponser.host = urlConnection.getURL().getHost();   
            httpResponser.path = urlConnection.getURL().getPath();   
            httpResponser.port = urlConnection.getURL().getPort();   
            httpResponser.protocol = urlConnection.getURL().getProtocol();   
            httpResponser.query = urlConnection.getURL().getQuery();   
            httpResponser.ref = urlConnection.getURL().getRef();   
            httpResponser.userInfo = urlConnection.getURL().getUserInfo();   
    
            httpResponser.content = new String(temp.toString().getBytes(), ecod);   
            httpResponser.contentEncoding = ecod;   
            httpResponser.code = urlConnection.getResponseCode();   
            httpResponser.message = urlConnection.getResponseMessage();   
            httpResponser.contentType = urlConnection.getContentType();   
            httpResponser.method = urlConnection.getRequestMethod();   
            httpResponser.connectTimeout = urlConnection.getConnectTimeout();   
            httpResponser.readTimeout = urlConnection.getReadTimeout();   
    
            return httpResponser;   
        } catch (IOException e) {   
            throw e;   
        } finally {   
            if (urlConnection != null)   
                urlConnection.disconnect();   
        }   
    }   
    
    /**  
     * 默认的响应字符集  
     */  
    public String getDefaultContentEncoding() {   
        return this.defaultContentEncoding;   
    }   
    
    /**  
     * 设置默认的响应字符集  
     */  
    public void setDefaultContentEncoding(String defaultContentEncoding) {   
        this.defaultContentEncoding = defaultContentEncoding;   
    }   
    
    /**
     * 更新本地数据库
     * @param urlString
     */
    private void updatelocaldata(String urlString) {
		System.out.println("update local data :urlString=" + urlString);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "insert into t_webdata (vurl) values (?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, urlString);

			pstmt.executeUpdate();
			
			conn.commit();
			auto = true;
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
} 