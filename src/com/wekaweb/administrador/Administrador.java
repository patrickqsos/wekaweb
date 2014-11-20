package com.wekaweb.administrador;

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
 * Servlet implementation class Administrador
 */
@WebServlet("/admin")
public class Administrador extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Administrador() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	RequestDispatcher dispatcher = null;
    	
    	
    	System.out.println("Entro al administrador...");
    	dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/indexAdmin.jsp"); 
		dispatcher.forward(request,response); 	
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
    			
    			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/indexAdmin.jsp"); 
				dispatcher.forward(request,response);
				break;
			case "importar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/importar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			case "exportar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/exportar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;	
				
			case "generar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/generar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				
				break;
				
			case "editar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/editarDataset.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
			
			case "preprocess":
				if(loadDatasets(request,response)){
					String filePath = getServletConfig().getServletContext().getRealPath("WEB-INF") + "/scripts/filters.json";
	                JSONArray filterTree = new JSONArray();
					try {
						filterTree = (JSONArray)  new JSONParser().parse(new FileReader(filePath));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					 request.getSession().setAttribute("filterTree", filterTree);
					//System.out.println(filterTree.toString());
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/preprocess.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				
				break;
				
			default:
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/errorAdmin.jsp"); 
    			dispatcher.forward(request,response);
				break;
			}
    	}
		else{
			//dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/indexAdmin.jsp"); 
			dispatcher.forward(request,response); 
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//processRequest(request, response);
	}
	
	protected boolean loadDatasets(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException  {
		boolean flag = true;
		UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
		ConnectDB conn = new ConnectDB ();
		ResultSet rsConsulta = null;
		ArrayList<UsuarioTablaBean> datasets = new ArrayList<UsuarioTablaBean>();
		try{
            String cadena= "select * from usuario_tabla where id_usuario='"+usuario.getId()+"'";
            rsConsulta = conn.getData(cadena);
            while (rsConsulta.next()){
            	UsuarioTablaBean dataset = new UsuarioTablaBean();
            	dataset.setIdUsuario(usuario.getId());
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
