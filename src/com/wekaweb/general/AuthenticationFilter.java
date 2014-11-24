package com.wekaweb.general;
 
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wekaweb.beans.UsuarioBean;
 
@WebFilter("/AuthenticationFilter")
public class AuthenticationFilter implements Filter {
 
    private ServletContext context;
    private ArrayList<String> urlList;
    private ArrayList<String> blist;
    
    public void init(FilterConfig fConfig) throws ServletException {
        this.context = fConfig.getServletContext();
        this.context.log("AuthenticationFilter initialized"); 
        
       
        String urls = fConfig.getInitParameter("avoid-urls");
        
        //System.out.println(urls);
        urlList = new ArrayList<String>();
        blist = new ArrayList<String>();
        
        urlList.add(urls);
        urlList.add("/index.jsp");
        //blist.add("/indexc.jsp");
        
        
		/*
        StringTokenizer token = new StringTokenizer(urls, ",");
 
        urlList = new ArrayList<String>();
 
        while (token.hasMoreTokens()) {
            urlList.add(token.nextToken());
 
        }
        System.out.println(urlList.size());
        */
    }
     
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
 
    	/*
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
         
        String uri = req.getRequestURI();
        //this.context.log("Requested Resource::"+uri);
         
        System.out.println("Requested Resource::"+uri);
        
        HttpSession session = req.getSession(false);
        if(session == null  && !(uri.endsWith("html") || uri.endsWith("Login") || uri.matches(".*(css|jpg|png|gif|js)")) ){
        	System.out.println("entro al auth...");
            
        	this.context.log("Unauthorized access request :(");
            res.sendRedirect(req.getContextPath()+"/Login");
        }else{
            // pass the request along the filter chain
            chain.doFilter(request, response);
        }
         
         */
    	
    	
    	HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String url = req.getServletPath();
        //System.out.println("Requested Resource::"+url);
        boolean allowedRequest = false;
      
        if(urlList.contains(url) || url.endsWith("Login") || url.matches(".*(css|jpg|png|gif|js)")) {
            allowedRequest = true;
            //System.out.println("Paso...");
            chain.doFilter(request, response);
        }
        else{
        	HttpSession session = req.getSession(false);
        	if (session == null) {
            	System.out.println("Redireccionando al login...");
                res.sendRedirect(req.getContextPath()+"/Login");
            }
        	else{
        		chain.doFilter(request, response);
        	}
        }
          
        /*
        if (!allowedRequest) {
            HttpSession session = req.getSession(false);
            //System.out.println(session.toString());
            
            //UsuarioBean usuario = (UsuarioBean) session.getAttribute("usuarior");
            //System.out.println(usuario.toString());
            session.invalidate();
            if (session == null) {
            	System.out.println("redireccionando");
                res.sendRedirect(req.getContextPath()+"/Login");
            }
        }
        
        */
        //System.out.println("me cago en tu auth");
        //chain.doFilter(request, response);
    	
         
    }
 
     
 
    public void destroy() {
        //close any resources here
    }
 
}