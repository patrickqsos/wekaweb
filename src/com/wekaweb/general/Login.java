package com.wekaweb.general;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wekaweb.beans.UsuarioBean;
import com.wekaweb.helpers.ConnectDB;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//processRequest(request, response);
		RequestDispatcher dispatcher = null;
		dispatcher = request.getRequestDispatcher("/WEB-INF/jsp//login.jsp"); 
		dispatcher.forward(request,response); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//processRequest(request, response);
		RequestDispatcher dispatcher = null;
    	
		if (request.getParameterMap().containsKey("submit") ) {
    		
    		String boton = request.getParameter("submit");
    		if(boton.equals("Iniciar sesion")){
    			String emailLogin = request.getParameter("inputEmail");
            	String passwordLogin = request.getParameter("inputPassword");
            	
            	ConnectDB conn = new ConnectDB ();
                ResultSet rsConsulta = null;
                
                try{
	                String cadena = "select * from usuario where email='"+emailLogin+"'";
	                System.out.println(cadena);
	                rsConsulta = conn.getData(cadena);
	                if (rsConsulta.next() ){
	                	
	                	UsuarioBean usuarioDB = new UsuarioBean();
	                	
	                	usuarioDB.setId(rsConsulta.getString("id"));
	                	usuarioDB.setNombre(rsConsulta.getString("nombre"));
	                	usuarioDB.setApellido(rsConsulta.getString("apellido"));
	                	usuarioDB.setEmail(rsConsulta.getString("email"));
	                	usuarioDB.setPassword(rsConsulta.getString("password"));
	                	usuarioDB.setActivo(rsConsulta.getBoolean("activo"));
	                	usuarioDB.setTipo(rsConsulta.getString("tipo"));
	                	
	                	if(emailLogin.equals(usuarioDB.getEmail())&& passwordLogin.equals(usuarioDB.getPassword())){
	                		if(usuarioDB.getTipo().equals("root")){
		                		HttpSession session = request.getSession();
		                        session.setAttribute("usuario", usuarioDB);
		                        //setting session to expiry in 30 mins
		                        session.setMaxInactiveInterval(30*60);
		                        Cookie userEmail = new Cookie("user", emailLogin);
		                        userEmail.setMaxAge(30*60);
		                        response.addCookie(userEmail);
		                        //response.sendRedirect("LoginSuccess.jsp");
		                        
		                		dispatcher = request.getRequestDispatcher("/Administrador");
		                		dispatcher.forward(request,response); 
	                		}
	                		else{
	                			//se valida si es que la cuenta esta activa
	                			if(usuarioDB.isActivo()){
	                				HttpSession session = request.getSession();
			                        session.setAttribute("usuario", usuarioDB);
			                        //setting session to expiry in 30 mins
			                        session.setMaxInactiveInterval(30*60);
			                        Cookie userEmail = new Cookie("user", emailLogin);
			                        userEmail.setMaxAge(30*60);
			                        response.addCookie(userEmail);
			                        response.sendRedirect(request.getContextPath()+"/Main");
			         			}
	                			else{
	                				HttpSession session = request.getSession();
	    	                		session.setAttribute("msgLogin", "Para usar su cuenta primero debe activarla. Porfavor revice su email");
	    	                        response.sendRedirect(request.getContextPath()+"/Login");
	                			}
	                			
	                			
	                		}
	                	}
	                	else{
	                		System.out.println("password mal");
	                		HttpSession session = request.getSession();
	                		//session.removeAttribute("msglogin");
	                        session.setAttribute("msgLogin", "Password incorrecto");
	                        response.sendRedirect(request.getContextPath()+"/Login");
	                	}
	                }
	                else{
	                	HttpSession session = request.getSession();
	                	//session.removeAttribute("msglogin");
                        session.setAttribute("msgLogin", "Email no encontrado");
                        response.sendRedirect(request.getContextPath()+"/Login");
                    }
                }
      	
                catch(Exception e){
                	e.printStackTrace();
                	//return (mapping.findForward("failure"));
                }
                finally{
                	conn.closeConnection();	
                }
        	}
    		
    		if(boton.equals("Iniciar sesion como invitado")){
    			dispatcher = request.getRequestDispatcher("/Administrador"); 
            	dispatcher.forward(request,response); 	
    		}
    	}
    	else{
    		dispatcher = request.getRequestDispatcher("/indexc.jsp"); 
    		dispatcher.forward(request,response); 
    	}
	}

}
