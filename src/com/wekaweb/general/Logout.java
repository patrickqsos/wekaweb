package com.wekaweb.general;
 
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	response.setContentType("text/html");
        
    	/*
    	Cookie[] cookies = request.getCookies();
        if(cookies != null){
        for(Cookie cookie : cookies){
        	cookie.setMaxAge(0);
            response.addCookie(cookie);
            
        }
        }
        */
        //invalidate the session if exists
        HttpSession session = request.getSession();
        System.out.println("Deleting session ="+session.getAttribute("usuario"));
        if(session != null){
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath()+"/");
        
        //RequestDispatcher dispatcher = request.getRequestDispatcher("/Login"); 
		//dispatcher.forward(request,response); 
    }
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
 
}
