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
import java.util.TimerTask;
import java.util.Vector;

import com.lccert.crm.chemistry.util.DB;

/**
 * 更新数据到网站
 * @author Eason
 *
 */
public class Updata extends TimerTask {
	
	private String defaultContentEncoding;

	@Override
	public void run() {
		this.defaultContentEncoding = Charset.defaultCharset().name(); 
		updateData();
		System.out.println("网站更新结束");
	}
	
	/**
	 * 更新网站信息
	 */
	private void updateData() {
		System.out.println("网站更新开始");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from t_webdata order by id";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String urlString = rs.getString("vurl");
				int id = rs.getInt("id");
				if(send(urlString)) {
					remove(id);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * 网站数据更新成功后，根据id删除本地数据库信息
	 * @param id
	 */
	private void remove(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from t_webdata where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}


	/**  
     * 发送HTTP请求  
     * @param urlString  
     * @return 发送是否成功  
     */  
	private boolean send(String urlString){   
        HttpURLConnection urlConnection = null;
        HttpResponse resp = null;
        boolean isok = false;
        try {
		        URL url = new URL(urlString);   
		        urlConnection = (HttpURLConnection) url.openConnection();   
		    
		        urlConnection.setRequestMethod("GET");   
		        urlConnection.setDoOutput(true);   
		        urlConnection.setDoInput(true);   
		        urlConnection.setUseCaches(false);   
		    
		        resp = this.makeContent(urlString, urlConnection);
		        
		        if("ok".equals(resp.getContent())) {
		        	isok = true;
		        }
        } catch (IOException e) {
        }
        return isok;
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
	
} 
