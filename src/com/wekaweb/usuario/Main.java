package com.wekaweb.usuario;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
/*
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
*/
import org.json.simple.parser.ParseException;

import weka.core.Instances;
import weka.core.converters.DatabaseLoader;
import weka.core.converters.DatabaseSaver;
import weka.core.converters.JSONSaver;
import weka.core.json.JSONInstances;
import weka.core.json.JSONNode;

import com.wekaweb.beans.DatabaseBean;
import com.wekaweb.beans.UsuarioBean;
import com.wekaweb.beans.UsuarioTablaBean;
import com.wekaweb.helpers.ConnectDB;
import com.wekaweb.helpers.VcapHelper;

/**
 * Servlet implementation class Main
 */
@WebServlet("/Main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Main() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
    	
		if (request.getParameterMap().containsKey("action")) {
    		String opcion = request.getParameter("action");
    		UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
    		
    		//System.out.println(usuario.getId());
    		
    		switch (opcion) {
    		case "index":
    			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuario.jsp"); 
				dispatcher.forward(request,response);
				break;
			case "importar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/importar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			case "exportar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/exportar.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;	
				
			case "generar":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/generar.jsp"); 
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
				ConnectDB connPrep = new ConnectDB ();
				ResultSet rsConsultaPrep = null;
				ArrayList<UsuarioTablaBean> datasPrep = new ArrayList<UsuarioTablaBean>();
				ArrayList<Map<String, String>> datasetsPrep = new ArrayList<Map<String, String>>();
				try{
                    String cadena= "select * from usuario_tabla where id_usuario='"+usuario.getId()+"'";
                    rsConsultaPrep = connPrep.getData(cadena);
                    while (rsConsultaPrep.next()){
                    	Map<String, String> dataset = new HashMap<String, String>();
                    	
                    	UsuarioTablaBean data = new UsuarioTablaBean();
                    	//esta parte es la nueva
                    	data.setIdUsuario(rsConsultaPrep.getString("id_usuario"));
                    	data.setNombre(rsConsultaPrep.getString("nombre"));
                    	data.setTabla(rsConsultaPrep.getString("tabla"));
                    	data.setRelation(rsConsultaPrep.getString("relation"));
                    	data.setDescripcion(rsConsultaPrep.getString("descripcion"));
                    	
                    	//probando
                    	//System.out.println(data.toString());
                    	
                    	dataset.put("id_usuario", rsConsultaPrep.getString("id_usuario"));
                    	dataset.put("nombre", rsConsultaPrep.getString("nombre"));
                    	dataset.put("tabla", rsConsultaPrep.getString("tabla"));
                    	dataset.put("descripcion", rsConsultaPrep.getString("descripcion"));
                    	datasetsPrep.add(dataset);
                    	
                    	datasPrep.add(data);
                    	//new
                    	
                    }
                }catch(Exception e){
                	e.printStackTrace();
                }finally{
                	connPrep.closeConnection();	
                }
                request.setAttribute("datasetsu", datasPrep);
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/usuarioPreparacion.jsp"); 
    			dispatcher.forward(request,response);
				break;
				
			case "clasificacion":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/clasificacion.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			case "clustering":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/clustering.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;	
				
			case "asociacion":
				if(loadDatasets(request,response)){
					  dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/asociacion.jsp"); 
					  dispatcher.forward(request,response);
				}
				else
					response.sendRedirect(request.getContextPath()+"/Login");
				break;
				
			default:
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/errorUsuario.jsp"); 
    			dispatcher.forward(request,response);
				break;
			}
    	}
		else{
			//dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuario.jsp"); 
			dispatcher.forward(request,response); 
		}
			//response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
    	
		if (ServletFileUpload.isMultipartContent(request)) {
    		PrintWriter out = response.getWriter();
    		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    		String[] form = new String[2];
    		int i=0;
    		
    		UsuarioTablaBean tempData = new UsuarioTablaBean();
    		String nombreTabla = null; //nombre que se le asigna a la tabla correspondiente al dataset
    		
        	BufferedReader br = null;
    		try {
            	
                List<FileItem> items = uploadHandler.parseRequest(request);
                for (FileItem item : items) {
                    if (!item.isFormField()) {
                    	tempData.setNombre(item.getName());
                 		nombreTabla = item.getName().replaceAll("[^\\w]","_");
                    	br = new BufferedReader(new InputStreamReader(item.getInputStream()));
                    }
                    else{
                    	form[i] = item.getString();
                    	i++;
                    }
                }
                ConnectDB conn = new ConnectDB ();
                int  rsConsulta = 0;
                try{
                	tempData.setIdUsuario(form[1]);
                	tempData.setTabla(nombreTabla+"_"+form[1]);
                	tempData.setDescripcion(form[0]);
                	          	
                	Instances data = new Instances(br);
                	tempData.setRelation(data.relationName());
                	tempData.setClassIndex(data.classIndex());
                	
              	  
                	//conexion a bd
                	DatabaseBean credentials = VcapHelper.parseVcap();
                    DatabaseSaver save = new DatabaseSaver();
                    save.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
                    save.setUser(credentials.getUsername());
                    save.setPassword(credentials.getPassword());
                    save.setInstances(data);
                    save.setRelationForTableName(false);
                    save.setTableName(tempData.getTabla());
                    save.connectToDatabase();
                    save.writeBatch();
                    
                    String cadena= "insert into usuario_tabla values('"+tempData.getIdUsuario()+"','"+tempData.getNombre()+"','"+tempData.getTabla()+"','"+tempData.getRelation()+"','"+tempData.getClassIndex()+"','"+tempData.getDescripcion()+"' )";
                    
                    //System.out.println(cadena);
                    rsConsulta = conn.InsertaDatos(cadena);
                    if (rsConsulta == -1 ){
                    	out.println("Hubo un problema con la carga del dataset. Vuelve a intentarlo");
                    	//dispatcher = request.getRequestDispatcher("/error.jsp"); 
            			//dispatcher.forward(request,response);
        			}
                    else{
                    	out.println("El dataset se cargo exitosamente");
                    	//dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
            			//dispatcher.forward(request,response);
        			}
                }catch(Exception e){
                	e.printStackTrace();
                }finally{
                	out.flush();
                	br.close();
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
		else{
			String tipoRequest = request.getParameter("tipoRequest");
			if (tipoRequest.equals("cargaDataset")) {
				UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
				ConnectDB connPrep = new ConnectDB ();
				ResultSet rsConsultaPrep = null;
				String dataset = request.getParameter("dataset");

				  DatabaseLoader dbl = null;
				try {
					dbl = new DatabaseLoader();
				} catch (Exception e) {
					
					e.printStackTrace();
				}
				  DatabaseBean credentials = null;
				try {
					credentials = VcapHelper.parseVcap();
				} catch (ParseException e) {
					
					e.printStackTrace();
				}
                  
				//recupera las instancias del dataset 
				dbl.setUser(credentials.getUsername());
				dbl.setPassword(credentials.getPassword());
				dbl.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
                dbl.setQuery("select * from "+dataset);
				dbl.connectToDatabase();
				Instances data = dbl.getDataSet();
				  
				//recupera info del dataset
				String cadena= "select * from usuario_tabla where id_usuario='"+usuario.getId()+"' and tabla='"+dataset+"'";
                rsConsultaPrep = connPrep.getData(cadena);
                try {
					while (rsConsultaPrep.next()){
						data.setRelationName(rsConsultaPrep.getString("relation"));
						data.setClassIndex(rsConsultaPrep.getInt("classindex"));
					}
				} catch (SQLException e1) {
					
					e1.printStackTrace();
				}
                
				  
				  //populate dataset to json file using the tempfilepopulator
				  
				  /**
				   * http://weka.wikispaces.com/Save+Instances+to+an+ARFF+File
				   * crea arrf file to download
				   */
				  
				  JSONNode n = new JSONNode();
			      JSONSaver js = new JSONSaver();  
			      JSONInstances j = new JSONInstances();
			      			      
			      n = j.toJSON(data);
			      
			      StringBuffer buffer = new StringBuffer();
			      n.toString(buffer);
			    			      
			      JSONObject a = new JSONObject();
			      JSONParser b = new JSONParser();
			      
			      try {
					a = (JSONObject) b.parse(buffer.toString());
			      } catch (ParseException e) {
					e.printStackTrace();
			      }
				  //response.setContentType("application/json");
				  PrintWriter out = response.getWriter();
				  //System.out.println("JSON: " + a.toString());
				  out.println(a);
				  out.flush();
			}
		    	
			else{
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
				dispatcher.forward(request,response); 	
			}
		}
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

