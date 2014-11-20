package com.wekaweb.invitado;

import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.wekaweb.beans.UsuarioBean;
import com.wekaweb.beans.UsuarioTablaBean;
import com.wekaweb.helpers.ConnectDB;

/**
 * Servlet implementation class Invitado
 */
@WebServlet("/invitado")
public class Invitado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Invitado() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
    	
		//processRequest(request, response);
		if (request.getParameterMap().containsKey("action")) {
    		String opcion = request.getParameter("action");
    		UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
    		
    		//System.out.println(usuario.getId());
    		
    		switch (opcion) {
    		case "index":
    			//String debugContext = request.getSession().getServletContext().getInitParameter("debug");
    			//System.out.println("debug :"+debugContext);
    			
    			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/indexInvitado.jsp"); 
				dispatcher.forward(request,response);
				break;
			/*
    		case "importar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/importar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			case "exportar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/exportar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;	
				
			case "generar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/generar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				
				break;
			*/
				
			case "editar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/editarDataset.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
			
			case "clasificacion":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/clasificacion.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			case "clustering":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/clustering.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;	
				
			case "asociacion":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/asociacion.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			default:
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/errorAdmin.jsp"); 
    			dispatcher.forward(request,response);
				break;
			}
    	}
		else{
			//dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
			UsuarioBean usuarioDB = new UsuarioBean();
			usuarioDB.setId("1");
        	usuarioDB.setNombre("Invitado");
        	usuarioDB.setApellido("Invitado");
        	usuarioDB.setEmail("invitado@wekawebapp.com");
        	usuarioDB.setPassword("invitado");
        	usuarioDB.setActivo(true);
        	usuarioDB.setTipo("invitado");
        	request.getSession().setAttribute("usuario", usuarioDB);
			
        	dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/indexInvitado.jsp"); 
			dispatcher.forward(request,response); 
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
    	dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/invitado/indexInvitado.jsp"); 
		dispatcher.forward(request,response);
	}
	
	protected boolean loadDatasets(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException  {
		boolean flag = true;
		//UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
		ConnectDB conn = new ConnectDB ();
		ResultSet rsConsulta = null;
		ArrayList<UsuarioTablaBean> datasets = new ArrayList<UsuarioTablaBean>();
		try{
            String cadena= "select * from usuario_tabla where id_usuario='1'";
            rsConsulta = conn.getData(cadena);
            while (rsConsulta.next()){
            	UsuarioTablaBean dataset = new UsuarioTablaBean();
            	dataset.setIdUsuario("1");
            	dataset.setNombre(rsConsulta.getString("nombre"));
            	dataset.setTabla(rsConsulta.getString("tabla"));
            	dataset.setRelation(rsConsulta.getString("relation"));
            	dataset.setClassIndex(rsConsulta.getInt("classindex"));
            	dataset.setDescripcion(rsConsulta.getString("descripcion"));
            	dataset.setOrigen(rsConsulta.getString("origen"));
            	datasets.add(dataset);
            }
        }catch(Exception e){
        	//response.sendRedirect(request.getContextPath()+"/Login");
        	e.printStackTrace();
        	flag = false;
        }finally{
        	conn.closeConnection();	
        }
        request.setAttribute("datasetsu", datasets);
		
        return flag;
	}

}
