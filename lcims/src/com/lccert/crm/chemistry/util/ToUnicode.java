package com.lccert.crm.chemistry.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class ToUnicode implements Filter {
	private String toUnicode = "ISO-8859-1";//这个和你web 里传过来的一致；


	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub request.setCharacterEncoding(this.toUnicode);
        response.setCharacterEncoding(this.toUnicode);

        chain.doFilter(request, response);



	}

	public void init(FilterConfig filterConfig) throws ServletException {
		 String unicode = filterConfig.getInitParameter("toUnicode");
	        
	        if (unicode != null && unicode.length() > 0) {
	            
	            this.toUnicode = unicode;
	        
	        }

	    }



	

}
