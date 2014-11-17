package com.wekaweb.helpers;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.Reader;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.AsyncContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.model.Verifier;
import org.scribe.oauth.OAuthService;

import com.wekaweb.beans.UsuarioBean;

/**
 * Servlet implementation class OAuth2CallbackServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/oauth2callback" })
public class OAuth2CallbackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static String resourceURL = null;   
    private String oauthType = null;
    private UsuarioBean userLogged;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OAuth2CallbackServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sess = request.getSession(); 
		oauthType = (String) sess.getAttribute("oauth2Type");
		System.out.println("oauth2Type: "+oauthType);
		
		switch (oauthType) {
		case "google":
			resourceURL = "https://www.googleapis.com/oauth2/v2/userinfo";
			break;
		case "facebook":
			resourceURL = "https://graph.facebook.com/me";
			break;
		case "twitter":
			resourceURL = "https://api.twitter.com/1.1/account/verify_credentials.json";
			break;

			
		default:
			break;
		}
		//Check if the user have rejected 
	      String error = request.getParameter("error"); 
	      if ((null != error) && ("access_denied".equals(error.trim()))) { 
	         //HttpSession sess = request.getSession(); 
	         sess.invalidate(); 
	         response.sendRedirect(request.getContextPath()); 
	         return; 
	      }
	      //OK the user have consented so lets find out about the user 
	      /*
	      request.setAttribute("org.apache.catalina.ASYNC_SUPPORTED", true);
	      AsyncContext ctx = request.startAsync(); 
	      ctx.start(new GetUserInfo(request, response, ctx)); 
	      */
	      try {
			getInfo(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	      
	      response.sendRedirect(request.getContextPath()+"/Main");	         
	}

	protected void getInfo(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException{
		HttpSession sess = req.getSession(); 
	      OAuthService service = (OAuthService)sess.getAttribute("oauth2Service");
	      //Get the all important authorization code 
	      String code = req.getParameter("code");
	      Token token = null;
	      if(code == null){
	    	  code = req.getParameter("oauth_verifier");
	    	  Token requestToken = (Token) sess.getAttribute("requestToken");
	    	  token = service.getAccessToken(requestToken, new Verifier(code)); 
		       
	      }
	      else{
	    	  token = service.getAccessToken(null, new Verifier(code)); 
		  }
	      //Construct the access token 
	      //Save the token for the duration of the session 
	      sess.setAttribute("token", token);
	      //Perform a proxy login 
	      
	      //Now do something with it - get the user's G+ profile 
	      OAuthRequest oReq = new OAuthRequest(Verb.GET,resourceURL); 
	      //OAuthRequest oReq = new OAuthRequest(Verb.GET,"https://graph.facebook.com/me"); 
	      
	      service.signRequest(token, oReq); 
	      Response oResp = oReq.send(); 

	      //Read the result 
	      JSONParser parser = new JSONParser();
	      JSONObject profile = null;
			try {
				profile = (JSONObject) parser.parse(oResp.getBody());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	      
	      
	      //Save the user details somewhere or associate it with 
	      System.out.println(profile.toString());
	      System.out.println(profile.get("name"));
	      System.out.println(profile.get("email"));
	      
	      userLogged = new UsuarioBean();
	      switch (oauthType) {
			case "google":
				userLogged.setIdSocial(profile.get("id").toString());
				userLogged.setNombre(profile.get("given_name").toString());
				userLogged.setApellido(profile.get("family_name").toString());
				userLogged.setEmail(profile.get("email").toString());
				userLogged.setActivo(true);
				userLogged.setTipo("usuario");
				break;
			case "facebook":
				userLogged.setIdSocial(profile.get("id").toString());
				userLogged.setNombre(profile.get("first_name").toString());
				userLogged.setApellido(profile.get("last_name").toString());
				if(profile.get("email") != null) userLogged.setEmail(profile.get("email").toString());
				userLogged.setActivo(true);
				userLogged.setTipo("usuario");
				break;
			case "twitter":
				userLogged.setIdSocial(profile.get("id").toString());
				userLogged.setNombre(profile.get("name").toString());
				//userLogged.setApellido(profile.get("family_name").toString());
				if(profile.get("email") != null) userLogged.setEmail(profile.get("email").toString());
				userLogged.setActivo(true);
				userLogged.setTipo("usuario");
				break;
	      }
	      
	      ConnectDB con = new ConnectDB ();
          
	      String mycad = "select * from usuario where idSocial='"+profile.get("id")+"'";
          
	      if(!con.exists(mycad)){
	    	  int rsConsulta = 0;
	          String cadena= "insert into usuario values(null,'"+userLogged.getIdSocial()+"','"+userLogged.getNombre()+"','"+userLogged.getApellido()+"','"+userLogged.getEmail()+"','"+userLogged.getPassword()+"','"+userLogged.getToken()+"','1','usuario')";
	          System.out.println(cadena);
	               rsConsulta = con.InsertaDatos(cadena);
	          
	          if (rsConsulta == -1 ){
	          	resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	      		resp.getWriter().println("Los datos estan incompletos o equivocados. Vuelve a intentarlo");
	      		resp.getWriter().flush();
	          	//dispatcher = request.getRequestDispatcher("/error.jsp"); 
	  			//dispatcher.forward(request,response);
	          }
	      }
	      
	      ResultSet rs = con.getData(mycad);
          if (rs.next()){
          	userLogged.setId(rs.getString("id"));
          }
          
	      sess.setAttribute("name", userLogged.getNombre());
          sess.setAttribute("usuario", userLogged);
          sess.setMaxInactiveInterval(30*60);
          
          con.closeConnection();
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	public class GetUserInfo implements Runnable { 
		   private HttpServletRequest req; 
		   private HttpServletResponse resp; 
		   private AsyncContext asyncCtx; 
		   public GetUserInfo(HttpServletRequest req, HttpServletResponse resp, AsyncContext asyncCtx) { 
		      this.req = req; 
		      this.resp = resp; 
		      this.asyncCtx = asyncCtx; 
		   }
		   @Override 
		   public void run() {  
		      HttpSession sess = req.getSession(); 
		      OAuthService service = (OAuthService)sess.getAttribute("oauth2Service");
		      //Get the all important authorization code 
		      String code = req.getParameter("code");
		      Token token = null;
		      if(code == null){
		    	  code = req.getParameter("oauth_verifier");
		    	  Token requestToken = (Token) sess.getAttribute("requestToken");
		    	  token = service.getAccessToken(requestToken, new Verifier(code)); 
			       
		      }
		      else{
		    	  token = service.getAccessToken(null, new Verifier(code)); 
			  }
		      //Construct the access token 
		      //Save the token for the duration of the session 
		      sess.setAttribute("token", token);
		      //Perform a proxy login 
		      try { 
		         req.login("fred", "fredfred"); 
		      } catch (ServletException e) { 
		         //Handle error - should not happen 
		      }
		      //Now do something with it - get the user's G+ profile 
		      
		      OAuthRequest oReq = new OAuthRequest(Verb.GET,resourceURL); 
		      //OAuthRequest oReq = new OAuthRequest(Verb.GET,"https://graph.facebook.com/me"); 
		      
		      service.signRequest(token, oReq); 
		      Response oResp = oReq.send(); 

		      //Read the result 
		      JSONParser parser = new JSONParser();
		      JSONObject profile = null;
				try {
					profile = (JSONObject) parser.parse(oResp.getBody());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		      
		      
		      //Save the user details somewhere or associate it with 
		      sess.setAttribute("name", profile.get("name")); 
		      sess.setAttribute("email", profile.get("email")); 
		      
		      System.out.println(profile.toString());
		      
		      
		      System.out.println(profile.get("name"));
		      System.out.println(profile.get("email"));
		      asyncCtx.complete(); 
		   } 
		}
}
