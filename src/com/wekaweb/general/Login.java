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

import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.FacebookApi;
import org.scribe.builder.api.TwitterApi;
import org.scribe.model.Token;
import org.scribe.oauth.OAuthService;

import com.wekaweb.beans.UsuarioBean;
import com.wekaweb.helpers.ConnectDB;
import com.wekaweb.helpers.Google2Api;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String CLIENT_ID_GOOGLE = "776354536058-3vtlu3hc556jfscgbtf4t9fgblejg7tj.apps.googleusercontent.com"; 
	private static final String CLIENT_SECRET_GOOGLE = "T5uDXLrdDkRuBSr2tVVBZ2L5";
	private static final String CLIENT_ID_FACEBOOK = "1518946931657676"; 
	private static final String CLIENT_SECRET_FACEBOOK = "15b8915c31b18432a8d61fb45c5528d9";
	private static final String CLIENT_ID_TWITTER= "nLplKU8lvnzgi13djmwoeAx9o"; 
	private static final String CLIENT_SECRET_TWITTER = "KpqsriCo8YN9RElokr9WqqI2vrYvMeeyjXiwiAn3H19dPWXLy1";
	
	private String urlCallback = "";
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
		
		if (request.getParameterMap().containsKey("type") ) {
			String debugContext = request.getSession().getServletContext().getInitParameter("debug");
			String url = request.getSession().getServletContext().getInitParameter("url");
			
			System.out.println("debug : "+debugContext);
			
			if(Boolean.parseBoolean(debugContext)){
				urlCallback = "http://localhost:8080/WekaWeb/oauth2callback";
			}
			else{
				urlCallback = url+"/oauth2callback";
			}
				
			String type = request.getParameter("type");
			HttpSession session = request.getSession(); 
			ServiceBuilder builder= new ServiceBuilder(); 
			OAuthService service = null;  
			switch (type) {
			case "facebook":
				//ServiceBuilder builder= new ServiceBuilder(); 
			      service = builder.provider(FacebookApi.class) 
			         .apiKey(CLIENT_ID_FACEBOOK) 
			         .apiSecret(CLIENT_SECRET_FACEBOOK) 
			         .callback(urlCallback) 
			         .debug() 
			         .build(); //Now build the call
			      session.setAttribute("oauth2Type", "facebook");
			      
			      session.setAttribute("oauth2Service", service);
			      response.sendRedirect(service.getAuthorizationUrl(null)); 
			
				break;
			case "google":
				  //ServiceBuilder builder= new ServiceBuilder(); 
			      service = builder.provider(Google2Api.class) 
			         .apiKey(CLIENT_ID_GOOGLE) 
			         .apiSecret(CLIENT_SECRET_GOOGLE) 
			         .callback(urlCallback) 
			         .scope("openid profile email " + 
			        	   "https://www.googleapis.com/auth/plus.login " + 
			               "https://www.googleapis.com/auth/plus.me")  
			         .debug() 
			         .build(); //Now build the call
			      session.setAttribute("oauth2Type", "google");
			      session.setAttribute("oauth2Service", service);
			      response.sendRedirect(service.getAuthorizationUrl(null)); 
			      break;
			case "twitter":
				  //ServiceBuilder builder= new ServiceBuilder(); 
			      service = builder.provider(TwitterApi.SSL.class) 
			         .apiKey(CLIENT_ID_TWITTER) 
			         .apiSecret(CLIENT_SECRET_TWITTER) 
			         .callback(urlCallback) 
			         .debug() 
			         .build(); //Now build the call
			      session.setAttribute("oauth2Type", "twitter");
			      session.setAttribute("oauth2Service", service);
			      Token requestToken = service.getRequestToken();
			      session.setAttribute("requestToken", requestToken);
			      
			      response.sendRedirect(service.getAuthorizationUrl(requestToken)); 
			      break;
			default:
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp//login.jsp"); 
				dispatcher.forward(request,response); 
				break;
			}
			    		
		}
		else{
			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp//login.jsp"); 
			dispatcher.forward(request,response); 
		}
		
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
    		
    		if (request.getParameterMap().containsKey("type") ) {
    			String type = request.getParameter("type");
    			System.out.println(type);
    			dispatcher = request.getRequestDispatcher("/Administrador"); 
            	dispatcher.forward(request,response); 	
    		        		
    		}
    		else{
    			dispatcher = request.getRequestDispatcher("/indexc.jsp"); 
        		dispatcher.forward(request,response); 
        	}
    	}
	}

}
