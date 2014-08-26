package com.wekaweb.administrador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/*
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
*/
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import weka.core.Instances;
import weka.core.converters.DatabaseSaver;

import com.wekaweb.beans.DatabaseBean;
import com.wekaweb.helpers.ConnectDB;
import com.wekaweb.helpers.VcapHelper;

/**
 * Servlet implementation class DatasetAdmin
 */
@WebServlet("/DatasetAdmin")
public class DatasetAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DatasetAdmin() {
        super();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	RequestDispatcher dispatcher = null;
    	
    	if (ServletFileUpload.isMultipartContent(request)) {
    		//System.out.println("Entro a la carga del archivo");
    		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    		String desc = null;
    		String nombreDataset = null; //nombre original del archivo que se carga
    		String nombreTabla = null; //nombre que se le asigna a la tabla correspondiente al dataset
        	try {
            	
                List<FileItem> items = uploadHandler.parseRequest(request);
                System.out.println(items.size());
                for (FileItem item : items) {
                    if (!item.isFormField()) {
                    	
                    	nombreDataset = item.getName();
                    	nombreTabla = item.getName().replaceAll("[^\\w]","_")+"_public";
                    	
                    	BufferedReader br = new BufferedReader(new InputStreamReader(item.getInputStream()));
                        
                        Instances data = new Instances(br);
                  	  	data.setClassIndex(data.numAttributes() - 1);
                  	  	DatabaseBean credentials = VcapHelper.parseVcap();
                        
                  	  	DatabaseSaver save = new DatabaseSaver();
                        save.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
                        save.setUser(credentials.getUsername());
                        save.setPassword(credentials.getPassword());
                        save.setInstances(data);
                        save.setRelationForTableName(false);
                        save.setTableName(nombreTabla);
                        save.connectToDatabase();
                        save.writeBatch();
                        
                        
                        
                    }
                    else{
                    	desc = item.getString();
                    }
                }
                ConnectDB conn = new ConnectDB ();
                int  rsConsulta = 0;
                try{
                    String cadena= "insert into usuario_tabla values('2','"+nombreDataset+"','"+nombreTabla+"','"+desc+"' )";
                    System.out.println(cadena);
                    rsConsulta = conn.InsertaDatos(cadena);
                    if (rsConsulta == -1 ){
                    	dispatcher = request.getRequestDispatcher("/error.jsp"); 
            			dispatcher.forward(request,response);
        			}
                    else{
                    	dispatcher = request.getRequestDispatcher("/indexAdmin.jsp"); 
            			dispatcher.forward(request,response);
        			}
                }catch(Exception e){
                	e.printStackTrace();
                }finally{
                	conn.closeConnection();	
                }
               
            } catch (FileUploadException e) {
                    throw new RuntimeException(e);
            } catch (Exception e) {
                    throw new RuntimeException(e);
            } finally {
                
                //insertamos la relacion tabla-usuario
                
            }
    	}
    	
    	/*
    	if (request.getParameterMap().containsKey("submit")) {
    		System.out.println("Entro a la carga submit...");
    		String boton = request.getParameter("submit");
    		if(boton.equals("Cargar Dataset")){
    			System.out.println("Entro a la carga...");
    		}
    	}
    	*/
    	
    	if (request.getParameterMap().containsKey("opcion")) {
    		String opcion = request.getParameter("opcion");
    		
    		switch (opcion) {
			case "Cargar":
				dispatcher = request.getRequestDispatcher("/adminCargarDataset.jsp"); 
    			dispatcher.forward(request,response);
				break;
			
			case "Editar":
				ConnectDB conn = new ConnectDB ();
				ResultSet rsConsulta = null;
				 ArrayList<String> Rows = new ArrayList<String>();
				try{
                    String cadena= "select nombre from usuario_tabla where id_usuario=2";
                    //System.out.println(cadena);
                    rsConsulta = conn.getData(cadena);
                    while (rsConsulta.next()){
                    	Rows.add(rsConsulta.getString("nombre"));
                    }
                    
                    System.out.println("Tamaño: "+Rows.size());
                }catch(Exception e){
                	e.printStackTrace();
                }finally{
                	conn.closeConnection();	
                }
                request.setAttribute("datasets", Rows);
				dispatcher = request.getRequestDispatcher("/adminEditarDataset.jsp"); 
    			dispatcher.forward(request,response);
				break;
			
			case "Eliminar":
				dispatcher = request.getRequestDispatcher("/adminEliminarDataset.jsp"); 
    			dispatcher.forward(request,response);
				break;

			default:
				dispatcher = request.getRequestDispatcher("/error.jsp"); 
    			dispatcher.forward(request,response);
				break;
			}
    	}
    	
    	if (request.getParameterMap().containsKey("dataset")) {
    		String id = request.getParameter("dataset");
    		
    		System.out.println("El dataset recibido es: "+id);
    		
    	}
    	 	
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
		
	}

}
