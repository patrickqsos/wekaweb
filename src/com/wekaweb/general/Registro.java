package com.wekaweb.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import weka.core.Instances;
import weka.core.converters.DatabaseLoader;
import weka.core.converters.JSONSaver;
import weka.core.json.JSONInstances;
import weka.core.json.JSONNode;

import com.wekaweb.beans.DatabaseBean;
import com.wekaweb.beans.UsuarioBean;
import com.wekaweb.helpers.ConnectDB;
import com.wekaweb.helpers.VcapHelper;

/**
 * Servlet implementation class Registro
 */
@WebServlet("/Registro")
public class Registro extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public static  String token = "";
	 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		
		
		if (request.getParameterMap().containsKey("action")) {
    		String action = request.getParameter("action");
    		String email = request.getParameter("email");
    		String token = request.getParameter("token");
    		
    		UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuarior");
    		switch (action) {
    		case "activate":
    			ConnectDB con = new ConnectDB ();
    			ConnectDB conUpd = new ConnectDB ();
    			
            	ResultSet rs = null;
            	int rsUpdate = 0;
            	try{
	                String cadena = "select * from usuario where email='"+email+"'";
	                 rs = con.getData(cadena);
	                if (rs.next() ){
	                	if(token.equals(rs.getString("token")) ){
	                		System.out.println("email & token correctos");
		                	
	                		String cadenaUpd = "update usuario set activo='1' where email='"+email+"' and token='"+token+"'";
	                		rsUpdate = conUpd.InsertaDatos(cadenaUpd);
                            
                            if (rsUpdate == -1 ){
                            	System.out.println("error en activacion en BD");
    	                		dispatcher = request.getRequestDispatcher("/error.jsp"); 
    	        				dispatcher.forward(request,response);
                			}
                            else{
                            	UsuarioBean usuarioDB = new UsuarioBean();
    		                	
    		                	usuarioDB.setId(rs.getString("id"));
    		                	usuarioDB.setNombre(rs.getString("nombre"));
    		                	usuarioDB.setApellido(rs.getString("apellido"));
    		                	usuarioDB.setEmail(rs.getString("email"));
    		                	usuarioDB.setPassword(rs.getString("password"));
    		                	usuarioDB.setTipo(rs.getString("tipo"));
    		                	
    		                	HttpSession session = request.getSession();
    	                        session.setAttribute("usuarior", usuarioDB);
    	                        session.setAttribute("msgActivate", "Tu cuenta ha sido activada, ahora puedes hacer uso de todas las funciones ofrecidas por Weka Web Application");
    	                        //setting session to expiry in 30 mins
    	                        session.setMaxInactiveInterval(30*60);
    	                        Cookie userEmail = new Cookie("user", email);
    	                        userEmail.setMaxAge(30*60);
    	                        response.addCookie(userEmail);
    		                	
    	                		response.sendRedirect(request.getContextPath()+"/Main");
                            }
	                		
	                        
	                	}
	                	else{
	                		System.out.println("token corrupto");
	                		dispatcher = request.getRequestDispatcher("/error.jsp"); 
	        				dispatcher.forward(request,response);
	                	}
	                }
	                else{
	                	System.out.println("email no encontrado");
	                	dispatcher = request.getRequestDispatcher("/error.jsp"); 
        				dispatcher.forward(request,response);
		                	
		            }
            	}
            	catch(Exception e){
            		e.printStackTrace();
	                //return (mapping.findForward("failure"));
	            }
	            finally{
	            	con.closeConnection();	
	            }
	                
    			
    			
				break;
			default:
				dispatcher = request.getRequestDispatcher("/WEB-INF/error.jsp"); 
				dispatcher.forward(request,response); 
				break;
    		}
		}
		else{
			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/registro.jsp"); 
			dispatcher.forward(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
    	
		
			String action = request.getParameter("action");
			
			switch (action) {
			case "altaUsuario":
				boolean validate = true;
				PrintWriter out = response.getWriter();
        		
    			String nombre = request.getParameter("nombre");
    			String apellido = request.getParameter("apellido");
    			String email = request.getParameter("email");
            	String password = request.getParameter("password");
            	String confirmPassword = request.getParameter("confirmPassword");
            
            	//se valida que el email no este registrado
            	ConnectDB con = new ConnectDB ();
            	ResultSet rs = null;
				String cad = "select COUNT(*) as total from usuario where email='"+email+"'";
                rs = con.getData(cad);
                try {
                	while (rs.next()) {
                        if( rs.getInt("total") > 0 ) {
                        	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    		out.println("El email ingresado ya esta registrado");
                        	out.flush();
                        } else {
                        	//se valida que los campos no esten vacios
                        	if(nombre.isEmpty() || apellido.isEmpty() || email.isEmpty() || password.isEmpty())
                        		validate = false;
                        	
                        	//se valida que los passwords coincidan
                        	if(password.compareTo(confirmPassword) != 0)
                        		validate = false;
                        	
                        	if(validate){
                        		//se genera un token de validacion
                            	token = getCadenaAlfanumAleatoria(20);
                            	
                        		int rsConsulta = 0;
                                String cadena= "insert into usuario values(null,'"+nombre+"','"+apellido+"','"+email+"','"+password+"','"+token+"','0','usuario')";
                                
                                System.out.println(cadena);
                                rsConsulta = con.InsertaDatos(cadena);
                                
                                if (rsConsulta == -1 ){
                                	out.println("Los datos estan incompletos o equivocados. Vuelve a intentarlo");
                                	out.flush();
                                	//dispatcher = request.getRequestDispatcher("/error.jsp"); 
                        			//dispatcher.forward(request,response);
                    			}
                                else{
                                	//out.println("Verifica tu correo");
                                	//dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
                        			//dispatcher.forward(request,response);
                                	try{
                                 	   // Propiedades de la conexión
                                 	   Properties props = new Properties();
                                 	   props.setProperty("mail.smtp.host", "smtp.gmail.com");
                                 	   props.setProperty("mail.smtp.starttls.enable", "true");
                                 	   props.setProperty("mail.smtp.port", "587");
                                 	   props.setProperty("mail.smtp.user", "patrickqsos@gmail.com");
                                 	   props.setProperty("mail.smtp.auth", "true");
                                 	 
                                 	   // Preparamos la sesion
                                 	   Session session = Session.getDefaultInstance(props);
                                 	   // Construimos el mensaje
                                 	   MimeMessage message = new MimeMessage(session);
                                 	   //la persona k tiene k verificar
                                 	   message.setFrom(new InternetAddress("patrickqsos@gmail.com"));
                                 	   message.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
                                 	   message.addHeader("Disposition-Notification-To","gcorreacaja@hotmail.com");
                                 	   message.setSubject("Correo de verificacion, porfavor no responder");
                                 	   message.setText(
                                 			   "Este es un correo de verificacion \n" +
                                 	           "Gracias por registrarse \n" +
                                 	           "Porfavor haga click en el siguiente enlace\n" +
                                 	           "para seguir con la verificacion de sus datos \n" +
                                 	           
                     						   "<a href=\"http://localhost:8080"+request.getContextPath()+"/Registro?action=activate&email="+email+"&token="+token+"\">Enlace</a>  ",

                                 	        
                     							//"<a href=\"http://localhost:8080/PruebadeConectados/ActivacionCuenta?usuario=%22+usuario+%22&aleatorio=%22+aleatoria+%22%5C%22\">Enlace</a>  ",
                                 	           "ISO-8859-1",
                                 	           "html");
                                 	   // Lo enviamos.
                                 	   Transport t = session.getTransport("smtp");
                                 	   t.connect("patrickqsos@gmail.com", "delta3.YO");
                                 	   t.sendMessage(message, message.getAllRecipients());
                                 	   // Cierre.
                                 	   t.close();
                                 	   
                                 	  out.println("El registro fue exitoso pero primero debe activar su cuenta. Porfavor revice su email");
                                 	  
                                  	
                                 	}
                                 	catch (Exception e){
                                 		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                                 	   String i = e.getMessage();
                                 	   out.println("Hubo un problema al enviar el correo de validacion. Por favor vuelva a intentarlo");
                                 	}
                                	finally{
                                		out.flush();
                                	}
                                	
                    			}
                        	}
                        	else{
                        		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        		out.println("Los datos estan incompletos o equivocados. Vuelve a intentarlo");
                            	out.flush();
                           }
                        }
                    }
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
                finally{
                	con.closeConnection();
                }
                
                
            	
            	
            	
            	
				break;

			case "activate":
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
				dispatcher.forward(request,response); 
				break;
				
			default:
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuario.jsp"); 
				dispatcher.forward(request,response); 
				break;
			}
		
	}
	
	public  String getCadenaAlfanumAleatoria (int longitud){
		String cadenaAleatoria="";
		long milis = new java.util.GregorianCalendar().getTimeInMillis();
		Random r = new Random(milis);
		int i = 0;
		while ( i < longitud){
			char c = (char)r.nextInt(255);
			//System.out.println("char:"+c);
			if ( (c >= '0' && c <=9) || (c >='A' && c <='Z') ){
				cadenaAleatoria += c;
				i ++;
			}
		}
		  
		return cadenaAleatoria;
	}

}
