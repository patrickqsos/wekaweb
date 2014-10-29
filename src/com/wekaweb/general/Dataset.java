package com.wekaweb.general;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.MethodDescriptor;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.zip.GZIPInputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JLabel;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import weka.associations.Associator;
import weka.associations.AssociatorEvaluation;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.BayesNet;
import weka.clusterers.ClusterEvaluation;
import weka.clusterers.Clusterer;
import weka.core.Attribute;
import weka.core.AttributeStats;
import weka.core.Capabilities;
import weka.core.Capabilities.Capability;
import weka.core.CapabilitiesHandler;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.MultiInstanceCapabilitiesHandler;
import weka.core.Utils;
import weka.core.converters.ArffSaver;
import weka.core.converters.C45Loader;
import weka.core.converters.C45Saver;
import weka.core.converters.CSVLoader;
import weka.core.converters.CSVSaver;
import weka.core.converters.ConverterUtils.DataSource;
import weka.core.converters.DatabaseLoader;
import weka.core.converters.DatabaseSaver;
import weka.core.converters.JSONLoader;
import weka.core.converters.JSONSaver;
import weka.core.converters.LibSVMLoader;
import weka.core.converters.LibSVMSaver;
import weka.core.converters.MatlabLoader;
import weka.core.converters.SVMLightLoader;
import weka.core.converters.SVMLightSaver;
import weka.core.converters.SerializedInstancesLoader;
import weka.core.converters.SerializedInstancesSaver;
import weka.core.converters.XRFFLoader;
import weka.core.converters.XRFFSaver;
import weka.core.json.JSONInstances;
import weka.core.json.JSONNode;
import weka.datagenerators.classifiers.classification.Agrawal;
import weka.datagenerators.classifiers.classification.LED24;
import weka.datagenerators.classifiers.classification.RDG1;
import weka.datagenerators.classifiers.classification.RandomRBF;
import weka.datagenerators.classifiers.regression.Expression;
import weka.datagenerators.classifiers.regression.MexicanHat;
import weka.datagenerators.clusterers.BIRCHCluster;
import weka.datagenerators.clusterers.SubspaceCluster;
import weka.gui.PropertySheetPanel;
import weka.gui.explorer.DataGeneratorPanel;

import com.wekaweb.beans.DatabaseBean;
import com.wekaweb.beans.UsuarioBean;
import com.wekaweb.beans.UsuarioTablaBean;
import com.wekaweb.helpers.ConnectDB;
import com.wekaweb.helpers.VcapHelper;

/**
 * Servlet implementation class Dataset
 */
@WebServlet("/Dataset")
public class Dataset extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dataset() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//String dataset = request.getParameter("dataset");
		String dataset ="clima_arrff_arff_gz_3";
		//UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
		ConnectDB connPrep = new ConnectDB ();
		ResultSet rsConsultaPrep = null;
		
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
		String cadena= "select * from usuario_tabla where id_usuario='3' and tabla='"+dataset+"'";
        rsConsultaPrep = connPrep.getData(cadena);
        try {
			while (rsConsultaPrep.next()){
				data.setRelationName(rsConsultaPrep.getString("relation"));
				data.setClassIndex(rsConsultaPrep.getInt("classindex"));
			}
		} catch (SQLException e1) {
			
			e1.printStackTrace();
		}
        
        //dataset creado
        
        
		//volcando dataset a archivo
        String filePath = getServletConfig().getServletContext().getRealPath("WEB-INF") + "/fileName.xrff";
        File file = new File(filePath);
	    
        
        XRFFSaver saver = new XRFFSaver();
        saver.setInstances(data);
        saver.setFile(file);
       // saver.setDestination(new File("./data/test.arff"));   // **not** necessary in 3.5.4 and later
        saver.writeBatch();
        
		//String filePath = getServletContext().getRealPath("") + File.separator + "data.xlsx";  
				 
		
		
		System.out.println(filePath);
		int BUFSIZE = 4096;
		    int length   = 0;
	        ServletOutputStream outStream = response.getOutputStream();
	        ServletContext context  = getServletConfig().getServletContext();
	        String mimetype = context.getMimeType(filePath);
	        
	        // sets response content type
	        if (mimetype == null) {
	            mimetype = "application/octet-stream";
	        }
	        response.setContentType(mimetype);
	        response.setContentLength((int)file.length());
	        String fileName = (new File(filePath)).getName();
	        
	        // sets HTTP header
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
	        
	        byte[] byteBuffer = new byte[BUFSIZE];
	        DataInputStream in = new DataInputStream(new FileInputStream(file));
	        
	        // reads the file's bytes and writes them to the response stream
	        while ((in != null) && ((length = in.read(byteBuffer)) != -1))
	        {
	            outStream.write(byteBuffer,0,length);
	        }
	        
	        in.close();
	        outStream.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//		PrintWriter printer = response.getWriter();
		if (ServletFileUpload.isMultipartContent(request)) {
    		PrintWriter out = response.getWriter();
    		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    		String[] form = new String[2];
    		int i=0;
    		
    		UsuarioTablaBean tmpData = new UsuarioTablaBean();
    		String nombreTabla = null; //nombre que se le asigna a la tabla correspondiente al dataset
    		
    		
    		Instances data = null;
    		try {
            	List<FileItem> items = uploadHandler.parseRequest(request);
                for (FileItem item : items) {
                    if (!item.isFormField()) {
                    	tmpData.setNombre(item.getName());
                    	nombreTabla = item.getName().replaceAll("[^\\w]","_");
                 		
                    	String[] type = item.getName().split("\\.");
                 		
                    	switch (type[type.length-1]) {
						case "gz":
							if(type[type.length-2].equals("arff")){
                         		//formato arff.gz;
                         		BufferedReader loader = null;
                         		try {
                         			System.out.println("reading gz file...");
                         			loader = new BufferedReader(new InputStreamReader(new 
                         			GZIPInputStream(item.getInputStream())));
                         		}catch (IOException e) {
                         			loader = new BufferedReader(new InputStreamReader(item.getInputStream()));
                         		}
                         		data = new Instances(loader);
                         		loader.close();
                         		
                         	}
							if(type[type.length-2].equals("json")){
								JSONLoader loader = new JSONLoader();
	                         	loader.setSource(item.getInputStream());
	                         	data = loader.getDataSet();
                         		
                         	}
                         	break;
							
						case "arff":
							DataSource loaderDS = new DataSource(item.getInputStream());
							data = loaderDS.getDataSet();
							break;
							
						case "names":
							C45Loader loaderC45 = new C45Loader();
							loaderC45.setSource(item.getInputStream());
							data = loaderC45.getDataSet();
							break;
						
						case "csv":
							CSVLoader loaderCSV = new CSVLoader();
							loaderCSV.setSource(item.getInputStream());
							data = loaderCSV.getDataSet();
							break;

						case "json":
							JSONLoader loader = new JSONLoader();
                         	loader.setSource(item.getInputStream());
                         	data = loader.getDataSet();
                         	break;
                         	
						case "libsvm":
							LibSVMLoader loaderLibSVM = new LibSVMLoader();
							loaderLibSVM.setSource(item.getInputStream());
							data = loaderLibSVM.getDataSet();
							break;
							
						case "m":
							MatlabLoader loaderMatlab = new MatlabLoader();
							loaderMatlab.setSource(item.getInputStream());
							data = loaderMatlab.getDataSet();
							break;
						
						case "dat":
							SVMLightLoader loaderSVM = new SVMLightLoader();
							loaderSVM.setSource(item.getInputStream());
							data = loaderSVM.getDataSet();
							break;
						
						case "bsi":
							SerializedInstancesLoader loaderBSI = new SerializedInstancesLoader();
							loaderBSI.setSource(item.getInputStream());
							data = loaderBSI.getDataSet();
							break;
						
						case "xrff":
							XRFFLoader loaderXRFF = new XRFFLoader();
							loaderXRFF.setSource(item.getInputStream());
							data = loaderXRFF.getDataSet();
							break;
						
						default:
							System.out.println("archivo no soportado");
							break;
						}
                    }
                    else{
                    	form[i] = item.getString();
                    	i++;
                    }
                }
            	tmpData.setIdUsuario(form[1]);
            	tmpData.setTabla(nombreTabla+"_"+form[1]);
            	tmpData.setDescripcion(form[0]);
            	tmpData.setRelation(data.relationName());
            	tmpData.setClassIndex(data.classIndex());
                tmpData.setOrigen("Cargado por el usuario");
                response.setContentType("application/json");
            	saveDataset(tmpData, data, out, "import");
            	            	
            } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            		out.println("Seleccione un archivo"+e.getMessage());
            }  finally {
            	out.flush();
            }
    	}
		
		else  {
			HttpSession session = request.getSession();
            
			String nombreTabla = null;
			
			String action = request.getParameter("action");
			UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuario");
			DatabaseLoader dbl = null;
			DatabaseBean credentials = null;
			
			switch (action) {
				case "getCapabilities":
					String datasetCap = request.getParameter("dataset");
					//String [] algoritmos = request.getParameterValues("algoritmos[]");
					String tree = request.getParameter("tree");
					
					ConnectDB conCap = new ConnectDB ();
					ResultSet rsCap = null;
					
					try {
						dbl = new DatabaseLoader();
						credentials = VcapHelper.parseVcap();
					} catch (Exception e) {
						e.printStackTrace();
					}
					//recupera las instancias del dataset 
					dbl.setUser(credentials.getUsername());
					dbl.setPassword(credentials.getPassword());
					dbl.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
	                dbl.setQuery("select * from "+datasetCap);
					dbl.connectToDatabase();
					Instances dataCap = dbl.getDataSet();
					  
					//recupera info del dataset
					String cadenaCap = "select * from usuario_tabla where id_usuario='"+usuario.getId()+"' and tabla='"+datasetCap+"'";
					rsCap = conCap.getData(cadenaCap);
	                try {
						while (rsCap.next()){
							dataCap.setRelationName(rsCap.getString("relation"));
							dataCap.setClassIndex(rsCap.getInt("classindex"));
							nombreTabla = rsCap.getString("tabla");
							//resultInfo.put("descripcion",rsInfo.getString("descripcion"));
							//resultInfo.put("origen",rsInfo.getString("origen"));
				    	}
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					
	                JSONParser parser = new JSONParser();
					try {
						JSONArray treeData = (JSONArray) parser.parse(tree);
						Iterator itData = treeData.iterator();
						
						Capabilities test = Capabilities.forInstances(dataCap);
						//response.getWriter().print("Algoritmo: "+algoritmo.get("className"));
						Iterator<Capability> my = test.capabilities();
						while(my.hasNext()){
							Capability myc = my.next();
							System.out.println(myc.name());
						}
						
						while(itData.hasNext()){
							try {
							
							JSONObject categoria = (JSONObject) itData.next();
							JSONArray nodes = (JSONArray) categoria.get("nodes");
							Iterator itNodes = nodes.iterator();
							while(itNodes.hasNext()){
								JSONObject algoritmo = (JSONObject) itNodes.next();
								
								if(algoritmo.containsKey("subCategoria")){
									JSONArray nodesAlg = (JSONArray) algoritmo.get("nodes");
									Iterator itNodesAlg = nodesAlg.iterator();
									while(itNodesAlg.hasNext()){
										JSONObject algoritmoSub = (JSONObject) itNodesAlg.next();
										System.out.println("\n\n Evaluating: "+algoritmoSub.get("className")+" --> ");
										Object fullAlgoritmo = Class.forName((String) algoritmoSub.get("className")).newInstance();
										BeanInfo bi = Introspector.getBeanInfo(fullAlgoritmo.getClass());
									      MethodDescriptor[] methods = bi.getMethodDescriptors();
									      for (MethodDescriptor method : methods) {
									        String name = method.getDisplayName();
									        Method meth = method.getMethod();
									        if (name.equals("getCapabilities")) {
									          if (meth.getReturnType().equals(Capabilities.class)) {
									            Object args[] = {};
									            Capabilities cap = Capabilities.forInstances(dataCap);
												Capabilities capab = (Capabilities) (meth.invoke(fullAlgoritmo, args));
												
												if(capab.supports(cap)){
												
												}
												else{
													algoritmoSub.put("disabled", true);
													algoritmoSub.put("selectable", false);
												}
												break;
									          }
									        }
									      }
									}
								}
								else{
									//System.out.print("evaluating: "+algoritmo.get("className"));
									
									Object fullAlgoritmo = Class.forName((String) algoritmo.get("className")).newInstance();
									BeanInfo bi = Introspector.getBeanInfo(fullAlgoritmo.getClass());
								      MethodDescriptor[] methods = bi.getMethodDescriptors();
								      for (MethodDescriptor method : methods) {
								        String name = method.getDisplayName();
								        Method meth = method.getMethod();
								        if (name.equals("getCapabilities")) {
								          if (meth.getReturnType().equals(Capabilities.class)) {
								            Object args[] = {};
								            Capabilities cap = Capabilities.forInstances(dataCap);
											Capabilities capab = (Capabilities) (meth.invoke(fullAlgoritmo, args));
											//response.getWriter().print("Algoritmo: "+algoritmo.get("className"));
											
											if(capab.supports(cap)){
												//System.out.println(" soporta");
											}
											else{
												algoritmo.put("disabled", true);
												algoritmo.put("selectable", false);
												//System.out.println(" no soporta");
											}
											break;
								          }
								        }
								      }
								}
							}
								
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
						 
						response.setContentType("application/json");
						response.getWriter().println(treeData);
						
					} catch (Exception e3) {
						e3.printStackTrace();
					}
					
					
	                break;
	               
				case "getCapAttr":
					String datasetCapAttr = request.getParameter("dataset");
					String treeFilters = request.getParameter("tree");
					
					ConnectDB conCapAttr = new ConnectDB ();
					ResultSet rsCapAttr = null;
					
					try {
						dbl = new DatabaseLoader();
						credentials = VcapHelper.parseVcap();
					} catch (Exception e) {
						e.printStackTrace();
					}
					//recupera las instancias del dataset 
					dbl.setUser(credentials.getUsername());
					dbl.setPassword(credentials.getPassword());
					dbl.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
	                dbl.setQuery("select * from "+datasetCapAttr);
					dbl.connectToDatabase();
					Instances dataCapAttr = dbl.getDataSet();
					  
					//recupera info del dataset
					String cadenaCapAttr = "select * from usuario_tabla where id_usuario='"+usuario.getId()+"' and tabla='"+datasetCapAttr+"'";
					rsCapAttr = conCapAttr.getData(cadenaCapAttr);
	                try {
						while (rsCapAttr.next()){
							dataCapAttr.setRelationName(rsCapAttr.getString("relation"));
							dataCapAttr.setClassIndex(rsCapAttr.getInt("classindex"));
							nombreTabla = rsCapAttr.getString("tabla");
							//resultInfo.put("descripcion",rsInfo.getString("descripcion"));
							//resultInfo.put("origen",rsInfo.getString("origen"));
				    	}
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					
	                JSONParser parserFilter = new JSONParser();
					try {
						JSONArray treeData = (JSONArray) parserFilter.parse(treeFilters);
						
						Iterator itData = treeData.iterator();
						
						while(itData.hasNext()){
							try {
							
							JSONObject categoria = (JSONObject) itData.next();
							
							//categoria.put("atributos", atributos);
							
							JSONArray nodes = (JSONArray) categoria.get("nodes");
							Iterator itNodes = nodes.iterator();
							while(itNodes.hasNext()){
								JSONObject algoritmo = (JSONObject) itNodes.next();
								
								if(algoritmo.containsKey("subCategoria")){
									JSONArray nodesAlg = (JSONArray) algoritmo.get("nodes");
									Iterator itNodesAlg = nodesAlg.iterator();
									while(itNodesAlg.hasNext()){
										JSONObject algoritmoSub = (JSONObject) itNodesAlg.next();
										//System.out.println("\n\n Evaluating: "+algoritmoSub.get("className")+" --> ");
										Object fullAlgoritmo = Class.forName((String) algoritmoSub.get("className")).newInstance();
										BeanInfo bi = Introspector.getBeanInfo(fullAlgoritmo.getClass());
									      MethodDescriptor[] methods = bi.getMethodDescriptors();
									      for (MethodDescriptor method : methods) {
									        String name = method.getDisplayName();
									        Method meth = method.getMethod();
									        if (name.equals("getCapabilities")) {
									          if (meth.getReturnType().equals(Capabilities.class)) {
									            Object args[] = {};
									            Capabilities cap = Capabilities.forInstances(dataCapAttr);
												Capabilities capab = (Capabilities) (meth.invoke(fullAlgoritmo, args));
												
												if(capab.supports(cap)){
												
												}
												else{
													algoritmoSub.put("disabled", true);
													algoritmoSub.put("selectable", false);
												}
												break;
									          }
									        }
									      }
									}
								}
								else{
									//System.out.print("evaluating: "+algoritmo.get("className"));
									
									Object fullAlgoritmo = Class.forName((String) algoritmo.get("className")).newInstance();
									BeanInfo bi = Introspector.getBeanInfo(fullAlgoritmo.getClass());
								      MethodDescriptor[] methods = bi.getMethodDescriptors();
								      for (MethodDescriptor method : methods) {
								        String name = method.getDisplayName();
								        Method meth = method.getMethod();
								        if (name.equals("getCapabilities")) {
								          if (meth.getReturnType().equals(Capabilities.class)) {
								            Object args[] = {};
								            Capabilities cap = Capabilities.forInstances(dataCapAttr);
											Capabilities capab = (Capabilities) (meth.invoke(fullAlgoritmo, args));
											//response.getWriter().print("Algoritmo: "+algoritmo.get("className"));
											
											if(capab.supports(cap)){
												//System.out.println(" soporta");
											}
											else{
												algoritmo.put("disabled", true);
												algoritmo.put("selectable", false);
												//System.out.println(" no soporta");
											}
											break;
								          }
								        }
								      }
								}
							}
								
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
						 
						//JSONObject treeAttr = new JSONObject();
						JSONArray atributos = new JSONArray();
						
						for(int k=0;k<dataCapAttr.numAttributes();k++){
							JSONObject attr = new JSONObject();
							attr.put("text",dataCapAttr.attribute(k).name());
							atributos.add(attr);
						}
						//treeData.add(treeAttr);
						
						JSONObject trees = new JSONObject();
						trees.put("treeAlgoritmos", treeData);
						trees.put("treeAttr", atributos);
						
						
						session.setAttribute("dataAttrFilter", dataCapAttr);
						session.setAttribute("nombreTabla", nombreTabla);
						response.setContentType("application/json");
						response.getWriter().println(trees);
						
					} catch (Exception e3) {
						e3.printStackTrace();
					}
					
					break;
					
				case "getInfoAttr":
					boolean m_allEqualWeights = true;
					String attribute = request.getParameter("attribute");
					Instances dataAttr = (Instances) session.getAttribute("dataAttrFilter");
					double w = dataAttr.instance(0).weight();
				    for (int i = 1; i < dataAttr.numInstances(); i++) {
				      if (dataAttr.instance(i).weight() != w) {
				        m_allEqualWeights = false;
				        break;
				      }
				    }
					
					Attribute attr = dataAttr.attribute(attribute);
					
					AttributeStats stats = dataAttr.attributeStats(dataAttr.attribute(attribute).index());
					
					String m_AttributeTypeLab;
					String m_MissingLab;
					String m_UniqueLab;
					String m_DistinctLab;
					
					switch (attr.type()) {
				    case Attribute.NOMINAL:
				      m_AttributeTypeLab = "Nominal";
				      break;
				    case Attribute.NUMERIC:
				      m_AttributeTypeLab = "Numeric";
				      break;
				    case Attribute.STRING:
				      m_AttributeTypeLab = "String";
				      break;
				    case Attribute.DATE:
				      m_AttributeTypeLab = "Date";
				      break;
				    case Attribute.RELATIONAL:
				      m_AttributeTypeLab = "Relational";
				      break;
				    default:
				      m_AttributeTypeLab = "Unknown";
				      break;
				    }
					
					long percent = Math.round(100.0 * stats.missingCount / stats.totalCount);
				    m_MissingLab = "" + stats.missingCount + " (" + percent + "%)";
				    percent = Math.round(100.0 * stats.uniqueCount / stats.totalCount);
				    m_UniqueLab = "" + stats.uniqueCount + " (" + percent + "%)";
				    m_DistinctLab = "" + stats.distinctCount;
				    
				    //JSONObject 
				    JSONObject infoAttr = new JSONObject();
				    
				    JSONObject statsAttr = new JSONObject();
					statsAttr.put("name", attribute);
					statsAttr.put("type", m_AttributeTypeLab);
					statsAttr.put("missing", m_MissingLab); 
					statsAttr.put("distinct", m_DistinctLab);
					statsAttr.put("unique", m_UniqueLab);

					//Object[] colNames;
					//Object[][] data
					JSONObject statsTable = new JSONObject();
					JSONArray values = new JSONArray();
					JSONArray headerNames = new JSONArray();
					
					if (stats.nominalCounts != null) {
						statsTable.put("type", "nominal");
						
						//JSONArray headerNames = new JSONArray();
						headerNames.add("No.");
						headerNames.add("Label");
						headerNames.add("Count");
						headerNames.add("Weight");
						statsTable.put("headerNames", headerNames);
						
						//Object[] colNames = { "No.", "Label", "Count", "Weight" };
					    //Object[][] data = new Object[stats.nominalCounts.length][4];
					    for (int i = 0; i < stats.nominalCounts.length; i++) {
					    	JSONArray row = new JSONArray();
					    	row.add(new Integer(i + 1));
					    	row.add(attr.value(i));
					    	row.add(new Integer(stats.nominalCounts[i]));
					    	row.add(new Double(Utils.doubleToString(stats.nominalWeights[i], 3)));
					    	/*  
					    	data[i][0] = new Integer(i + 1);
					        data[i][1] = attr.value(i);
					        data[i][2] = new Integer(stats.nominalCounts[i]);
					        data[i][3] = new Double(Utils.doubleToString(stats.nominalWeights[i], 3));
					        */
					    	values.add(row);
						}
					    
					    statsTable.put("values", values);
							  
					      //m_StatsTable.setModel(new DefaultTableModel(data, colNames));
					      //m_StatsTable.getColumnModel().getColumn(0).setMaxWidth(60);
					      //DefaultTableCellRenderer tempR = new DefaultTableCellRenderer();
					      //tempR.setHorizontalAlignment(JLabel.RIGHT);
					      //m_StatsTable.getColumnModel().getColumn(0).setCellRenderer(tempR);
					    } else if (stats.numericStats != null) {
					    	statsTable.put("type", "numeric");
							
					    	headerNames.add("Statistic");
							headerNames.add("Value");
							statsTable.put("headerNames", headerNames);
							
							JSONObject valuesNumeric = new JSONObject();
							valuesNumeric.put("Minimum", Utils.doubleToString(stats.numericStats.min, 3));
							valuesNumeric.put("Maximum", Utils.doubleToString(stats.numericStats.max, 3));
							valuesNumeric.put("Mean", Utils.doubleToString(stats.numericStats.mean, 3));
							valuesNumeric.put("StdDev", Utils.doubleToString(stats.numericStats.stdDev, 3));
							
							statsTable.put("values", valuesNumeric);
							
					      Object[] colNames = { "Statistic", "Value" };
					      Object[][] data = new Object[4][2];
					      data[0][0] = "Minimum";
					      data[0][1] = Utils.doubleToString(stats.numericStats.min, 3);
					      data[1][0] = "Maximum";
					      data[1][1] = Utils.doubleToString(stats.numericStats.max, 3);
					      data[2][0] = "Mean" + ((!m_allEqualWeights) ? " (weighted)" : "");
					      data[2][1] = Utils.doubleToString(stats.numericStats.mean, 3);
					      data[3][0] = "StdDev" + ((!m_allEqualWeights) ? " (weighted)" : "");
					      data[3][1] = Utils.doubleToString(stats.numericStats.stdDev, 3);
					      
					   	
					     // m_StatsTable.setModel(new DefaultTableModel(data, colNames));
					    } else {
					    	
					      //m_StatsTable.setModel(new DefaultTableModel());
					    }
					   // m_StatsTable.getColumnModel().setColumnMargin(4);
					    
					infoAttr.put("statsCount",statsAttr);
					infoAttr.put("statsTable",statsTable);
					
					response.setContentType("application/json");
					response.getWriter().println(infoAttr);
					//response.getWriter().println(infoAttr);
					break;
				case "getInfoDataset":
					PrintWriter outInfo = response.getWriter();
					JSONObject resultInfo = new JSONObject();
		        	
					ConnectDB conInfo = new ConnectDB ();
					ResultSet rsInfo = null;
					String dataset = request.getParameter("dataset");
					String typeInfo = request.getParameter("typeInfo");
					
					try {
						dbl = new DatabaseLoader();
						credentials = VcapHelper.parseVcap();
					} catch (Exception e) {
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
	                rsInfo = conInfo.getData(cadena);
	                try {
						while (rsInfo.next()){
							data.setRelationName(rsInfo.getString("relation"));
							data.setClassIndex(rsInfo.getInt("classindex"));
							nombreTabla = rsInfo.getString("tabla");
							resultInfo.put("descripcion",rsInfo.getString("descripcion"));
							resultInfo.put("origen",rsInfo.getString("origen"));
				    	}
					} catch (SQLException e1) {
						
						e1.printStackTrace();
					}
	                
	                resultInfo.put("nombre", data.relationName());
		        	resultInfo.put("instancias", data.numInstances());
		        	resultInfo.put("atributos", data.numAttributes());
		        	resultInfo.put("sum", data.sumOfWeights());
		        	resultInfo.put("classIndex", data.classIndex());
					
		        	if(typeInfo.equals("dataExport"))
		        		  session.setAttribute("dataExport", data);
		        	if(typeInfo.equals("dataEdit")){
		        		  session.setAttribute("dataEdit", data);
		        		  session.setAttribute("nombreTabla", nombreTabla);
		        		  JSONNode n = JSONInstances.toJSON(data);
					      StringBuffer buffer = new StringBuffer();
					      n.toString(buffer);
					      JSONParser b = new JSONParser();
					      try {
							JSONObject a = (JSONObject) b.parse(buffer.toString());
							resultInfo.put("dataset", a);
							//System.out.println(a.toString());
					      } catch (ParseException e) {
							e.printStackTrace();
					      }
			          }
		        		
					  response.setContentType("application/json");
					  outInfo.println(resultInfo);
					  outInfo.flush();
					break;
				case "updateClassIndex":
					
					String datase = (String) session.getAttribute("nombreTabla");
					String classIndex = request.getParameter("classIndex");
					
					ConnectDB con = new ConnectDB ();
			        int  rsConsulta = 0;
			        //conexion a bd
			        try{
			        	String cadn= "update  usuario_tabla set classindex='"+classIndex+"' where tabla ='"+datase+"'";
			        	System.out.println(cadn);
			        	rsConsulta = con.InsertaDatos(cadn);
			        	if(rsConsulta != -1){
			        		response.getWriter().println("updated");
			        	}
				    }
			        catch(Exception e){
			        }finally{
			        	con.closeConnection();	
			        }
			        
					break;
				case "uploadUrl":
					PrintWriter outUrl = response.getWriter();
					
					String url = request.getParameter("url");
					String nombre = request.getParameter("nombre");
					String descripcion = request.getParameter("descripcion");
					String idUsuario = request.getParameter("idUsuario");
					try {
						DataSource source = new DataSource(url);
						Instances dataUrl = source.getDataSet();
						UsuarioTablaBean tmpData = new UsuarioTablaBean();
			    		nombreTabla = nombre.replaceAll("[^\\w]","_"); //nombre que se le asigna a la tabla correspondiente al dataset
			    		tmpData.setNombre(nombre);
			    		tmpData.setIdUsuario(idUsuario);
		            	tmpData.setTabla(nombreTabla+"_"+idUsuario);
		            	tmpData.setDescripcion(descripcion);
		            	tmpData.setRelation(dataUrl.relationName());
		            	tmpData.setClassIndex(dataUrl.classIndex());
		                tmpData.setOrigen(url);
		                response.setContentType("application/json");
		                saveDataset(tmpData, dataUrl, outUrl, "importUrl");
			    		
					} catch (Exception e1) {
						//e1.printStackTrace();
						throw new RuntimeException(e1);
					}
					break;
					
				case "export":
					String typeExport = request.getParameter("typeExport");
					String nombreArchivo = request.getParameter("nombreArchivo");
					String extension = request.getParameter("extension");
					//String typeInfo = request.getParameter("typeInfo");
					
					Instances dataExport = null;
					
					if(typeExport.equals("normal")){
						dataExport = (Instances) session.getAttribute("dataExport");
					}
					if(typeExport.equals("generated")){
						dataExport = (Instances) session.getAttribute("dataGenerated");
					}
				   
	                //volcando dataset a archivo
	                String filePath = getServletConfig().getServletContext().getRealPath("WEB-INF") + "/tmp/"+nombreArchivo+"."+extension;
	                System.out.println("Path del archivo: "+filePath);
	                File file = new File(filePath);
	        	    
	                switch (extension) {
					case "arff":
						ArffSaver saverArff = new ArffSaver();
						saverArff.setInstances(dataExport);
						saverArff.setFile(file);
						saverArff.writeBatch();
		                break;
		                
					case "arff.gz":
						ArffSaver saverArffGz = new ArffSaver();
						saverArffGz.setInstances(dataExport);
						saverArffGz.setCompressOutput(true);
						saverArffGz.setFile(file);
						saverArffGz.writeBatch();
		                break;
		                
					case "names":
						C45Saver saverC45 = new C45Saver();
						//dataExport.se
						saverC45.setInstances(dataExport);
						saverC45.setFile(file);
						saverC45.writeBatch();
		                break;
		                
					case "csv":
						CSVSaver saverCSV = new CSVSaver();
						saverCSV.setInstances(dataExport);
						saverCSV.setFile(file);
						saverCSV.writeBatch();
		                break;
		                
					case "json":
						JSONSaver saverJSON = new JSONSaver();
						saverJSON.setInstances(dataExport);
						saverJSON.setFile(file);
						saverJSON.writeBatch();
		                break;
		                
					case "json.gz":
						JSONSaver saverJSONgz = new JSONSaver();
						saverJSONgz.setInstances(dataExport);
						saverJSONgz.setCompressOutput(true);
						saverJSONgz.setFile(file);
						saverJSONgz.writeBatch();
		                break;
		                
					case "libsvm":
						LibSVMSaver saverLIBSVM = new LibSVMSaver();
						saverLIBSVM.setInstances(dataExport);
						saverLIBSVM.setFile(file);
						saverLIBSVM.writeBatch();
		                break;
		                
					case "dat":
						SVMLightSaver saverSVMLight = new SVMLightSaver();
						saverSVMLight.setInstances(dataExport);
						saverSVMLight.setFile(file);
						saverSVMLight.writeBatch();
		                break;
		                
					case "bsi":
						SerializedInstancesSaver saverBSI = new SerializedInstancesSaver();
						saverBSI.setInstances(dataExport);
						saverBSI.setFile(file);
						saverBSI.writeBatch();
		                break;

					case "xrff":
						XRFFSaver saverXrff = new XRFFSaver();
						saverXrff.setInstances(dataExport);
						saverXrff.setFile(file);
						saverXrff.writeBatch();
		                break;
		                
					case "xrff.gz":
						XRFFSaver saverXrffGz = new XRFFSaver();
						saverXrffGz.setInstances(dataExport);
						saverXrffGz.setCompressOutput(true);
						saverXrffGz.setFile(file);
						saverXrffGz.writeBatch();
		                break;
		                
					default:
						break;
					}
	                
	                 int BUFSIZE = 4096;
	        		    int length   = 0;
	        	        ServletOutputStream outStream = response.getOutputStream();
	        	        ServletContext context  = getServletConfig().getServletContext();
	        	        String mimetype = context.getMimeType(filePath);
	        	        
	        	        // sets response content type
	        	        if (mimetype == null) {
	        	            mimetype = "application/octet-stream";
	        	        }
	        	        response.setContentType(mimetype);
	        	        response.setContentLength((int)file.length());
	        	        String fileName = (new File(filePath)).getName();
	        	        
	        	        // sets HTTP header
	        	        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
	        	        
	        	        byte[] byteBuffer = new byte[BUFSIZE];
	        	        DataInputStream in = new DataInputStream(new FileInputStream(file));
	        	        
	        	        // reads the file's bytes and writes them to the response stream
	        	        while ((in != null) && ((length = in.read(byteBuffer)) != -1)){
	        	            outStream.write(byteBuffer,0,length);
	        	        }
	        	        
	        	        in.close();
	        	        outStream.close();
	        	        file.delete();
	                
					break;
				case "getFullInfoAlgoritmo":
					String full = request.getParameter("algoritmo");
					Object fullAlgoritmo = null;
					try {
						fullAlgoritmo = Class.forName(full).newInstance();
					} catch (InstantiationException | IllegalAccessException
							| ClassNotFoundException e) {
						e.printStackTrace();
					}
			        
			        String fullInfo = getGlobalInfoTest(fullAlgoritmo, true);
			    	response.getWriter().println(fullInfo);
					
					break;
				case "getInfoAlgoritmo":
					
					UsuarioBean user = (UsuarioBean) session.getAttribute("usuario");
							
					PrintWriter outInfoAlgoritmo = response.getWriter();
		    		JSONObject infoAlgoritmo = new JSONObject();
		    		//Logger m_Log = new SysErrLog();
		    		Instances dataGenerated = null;
		    		DataGeneratorPanel customPanel = new DataGeneratorPanel();
		    		String algoritmo = request.getParameter("algoritmo");
		    		String nombreDataset = "dataset_"+algoritmo+"_"+user.getId();
		    		String descGenerated = "Dataset generado con el algoritmo "+algoritmo;
		    		//System.out.println("nombre del dataset: "+nombreDataset);
					
		    		switch (algoritmo) {
					
					case "Agrawal":
						//customPanel.setLog(m_Log);
				        customPanel.setGenerator(new weka.datagenerators.classifiers.classification.Agrawal());
				        Agrawal ag = new Agrawal();
						infoAlgoritmo.put("nombreAlgoritmo", ag.getClass().getName());
						infoAlgoritmo.put("globalInfo", ag.globalInfo());
						break;
						
					case "BayesNet":
						customPanel.setGenerator(new weka.datagenerators.classifiers.classification.BayesNet());
				        BayesNet bn = new BayesNet();
						infoAlgoritmo.put("nombreAlgoritmo", bn.getClass().getName());
						infoAlgoritmo.put("globalInfo", bn.globalInfo());
						break;
						
					case "LED24":
						customPanel.setGenerator(new weka.datagenerators.classifiers.classification.LED24());
				        LED24 led = new LED24();
						infoAlgoritmo.put("nombreAlgoritmo", led.getClass().getName());
						infoAlgoritmo.put("globalInfo", led.globalInfo());
						break;

					case "RandomRBF":
						customPanel.setGenerator(new weka.datagenerators.classifiers.classification.RandomRBF());
				        RandomRBF random = new RandomRBF();
						infoAlgoritmo.put("nombreAlgoritmo", random.getClass().getName());
						infoAlgoritmo.put("globalInfo", random.globalInfo());
						break;

					case "RDG1":
						customPanel.setGenerator(new weka.datagenerators.classifiers.classification.RDG1());
				        RDG1 rdg = new RDG1();
						infoAlgoritmo.put("nombreAlgoritmo", rdg.getClass().getName());
						infoAlgoritmo.put("globalInfo", rdg.globalInfo());
						break;

					case "Expression":
						customPanel.setGenerator(new weka.datagenerators.classifiers.regression.Expression());
				        Expression exp = new Expression();
						infoAlgoritmo.put("nombreAlgoritmo", exp.getClass().getName());
						infoAlgoritmo.put("globalInfo", exp.globalInfo());
						break;

					case "MexicanHat":
						customPanel.setGenerator(new weka.datagenerators.classifiers.regression.MexicanHat());
				        MexicanHat mex = new MexicanHat();
						infoAlgoritmo.put("nombreAlgoritmo", mex.getClass().getName());
						infoAlgoritmo.put("globalInfo", mex.globalInfo());
						break;

					case "BIRCHCluster":
						customPanel.setGenerator(new weka.datagenerators.clusterers.BIRCHCluster());
				        BIRCHCluster birch = new BIRCHCluster();
						infoAlgoritmo.put("nombreAlgoritmo", birch.getClass().getName());
						infoAlgoritmo.put("globalInfo", birch.globalInfo());
						break;

					case "SubspaceCluster":
						customPanel.setGenerator(new weka.datagenerators.clusterers.SubspaceCluster());
				        SubspaceCluster sub = new SubspaceCluster();
						infoAlgoritmo.put("nombreAlgoritmo", sub.getClass().getName());
						infoAlgoritmo.put("globalInfo", sub.globalInfo());
						break;
					
					default:
						break;
					}
					
					customPanel.execute();
			        dataGenerated = customPanel.getInstances();
			        
			        infoAlgoritmo.put("nombreDataset",nombreDataset);
			        infoAlgoritmo.put("relation",dataGenerated.relationName());
			        infoAlgoritmo.put("atributos",dataGenerated.numAttributes());
			        infoAlgoritmo.put("instancias",dataGenerated.numInstances());
					infoAlgoritmo.put("output", customPanel.getOutput());
					infoAlgoritmo.put("descripcion",descGenerated);
					
			        session.setAttribute("dataGenerated", dataGenerated);
			        response.setContentType("application/json");
					outInfoAlgoritmo.println(infoAlgoritmo);
					outInfoAlgoritmo.flush();
					//System.out.println(ag.globalInfo());
					
					break;
					
				case "deleteAttr":
					
					String [] attrRemove = request.getParameterValues("attrRemove[]");
					Instances dataAttrFilter = (Instances) session.getAttribute("dataAttrFilter");
					
					for(String atributo:attrRemove){
						
						dataAttrFilter.deleteAttributeAt(dataAttrFilter.attribute(atributo).index());
						/*
						System.out.println(atributo+ " " + dataAttrFilter.attribute(atributo).index());
						AttributeStats stats = dataAttrFilter.attributeStats(dataAttrFilter.attribute(atributo).index());
						System.out.println("missing "+stats.missingCount);
						System.out.println("distinct "+stats.distinctCount);
						System.out.println("unique "+stats.uniqueCount);
						*/
					}
					
					updateDataset(dataAttrFilter, response.getWriter(), (String) session.getAttribute("nombreTabla"));
					
					//response.getWriter().println(dataAttrFilter.numAttributes());
					break;   
				case "importGenerated":
					PrintWriter outImport = response.getWriter();
		    		
					Instances dataForImport = (Instances) session.getAttribute("dataGenerated");
					String nombreDatasetGen = request.getParameter("nombreDataset");
					String descDatasetGen = request.getParameter("descDataset");
					
					UsuarioTablaBean tmpData = new UsuarioTablaBean();
					tmpData.setIdUsuario(usuario.getId());
					tmpData.setNombre(nombreDatasetGen);
	            	tmpData.setTabla(nombreDatasetGen);
	            	tmpData.setDescripcion(descDatasetGen);
	            	tmpData.setRelation(dataForImport.relationName());
	            	tmpData.setClassIndex(dataForImport.classIndex());
	                tmpData.setOrigen("Dataset generado usando el generador de datasets");
	                saveDataset(tmpData, dataForImport, outImport, "importGenerated");
					//System.out.println("atributos: "+dataForImport.numAttributes());
					break;
				
				case "instance":
					PrintWriter printer = response.getWriter();
					
					Instances dataToUpdate = (Instances) session.getAttribute("dataEdit");
					int index;
					String type = request.getParameter("type");
					switch (type) {
					case "add":
						
						String [] instanceToAdd = request.getParameterValues("newInstance[]");
							
						double[] newInstance = new double[dataToUpdate.numAttributes()];
						
						//revisar el tipo de atributo antes de agregar al vector double
						for(int l=0;l<instanceToAdd.length ;l++){
							if(dataToUpdate.attribute(l).isNumeric()){
								if(instanceToAdd[l].isEmpty())
									newInstance[l] = 0;
								else
									newInstance[l] =  Double.parseDouble(instanceToAdd[l]);
							}
							if(dataToUpdate.attribute(l).isNominal())
								newInstance[l] =  dataToUpdate.attribute(l).indexOfValue(instanceToAdd[l]);
							if(dataToUpdate.attribute(l).isString())
								newInstance[l] =  dataToUpdate.attribute(l).addStringValue(instanceToAdd[l]);
							if(dataToUpdate.attribute(l).isDate())
								//newInstance[l] =  dataToUpdate.attribute(l).indexOfValue(instanceToAdd[l]);
								continue;
						}
						dataToUpdate.add(new DenseInstance(1.0, newInstance));
						printer.print("La nueva instancia se agrego exitosamente");
						
						break;

					case "update":
						String [] instanceToUpdate = request.getParameterValues("updateInstance[]");
						index = Integer.parseInt(request.getParameter("index"));
						for(int l=0;l<instanceToUpdate.length ;l++)
							dataToUpdate.get(index).setValue(l, instanceToUpdate[l]);
						printer.print("La instancia se actualizo exitosamente");
						break;
						
					case "delete":
						index = Integer.parseInt(request.getParameter("index"));
						//System.out.println("borrando el index: "+index);
						dataToUpdate.delete(index);
						//System.out.println(dataToUpdate.toString());
						printer.print("La instancia se elimino exitosamente");
						break;
						
					case "save":
						updateDataset(dataToUpdate, printer, (String) session.getAttribute("nombreTabla"));
						break;
					default:
						break;
					}
					
					
					
					//printer.print(dataToUpdate.toString());
					printer.flush();
					break;
				case "clustering":
					
					String datasetCluster = request.getParameter("dataset");
					String algoritmoCluster = request.getParameter("algoritmo");
	
					try {
						dbl = new DatabaseLoader();
						credentials = VcapHelper.parseVcap();
					} catch (Exception e) {
						e.printStackTrace();
					}
		              
					  dbl.setUser(credentials.getUsername());
					  dbl.setPassword(credentials.getPassword());
					  dbl.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
		              dbl.setQuery("select * from "+datasetCluster);
					  dbl.connectToDatabase();
					  Instances dataForCluster = dbl.getDataSet();
					  
					  ClusterEvaluation eval = new ClusterEvaluation();
					
					  try {
							Object fullAlgoritmoCluster = Class.forName(algoritmoCluster).newInstance();
							BeanInfo bi = Introspector.getBeanInfo(fullAlgoritmoCluster.getClass());
						      MethodDescriptor[] methods = bi.getMethodDescriptors();
						      for (MethodDescriptor method : methods) {
						        String name = method.getDisplayName();
						        Method meth = method.getMethod();
						        if (name.equals("buildClusterer")) {
						        	
						        	meth.invoke(fullAlgoritmoCluster, dataForCluster);
						        	eval.setClusterer((Clusterer) fullAlgoritmoCluster);
									eval.evaluateClusterer(dataForCluster);
									response.getWriter().println(eval.clusterResultsToString());
									
						           
						        }
						      }
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					  
					break;
	
				case "asociacion":
					String datasetAsoc = request.getParameter("dataset");
					String algoritmoAsoc = request.getParameter("algoritmo");
	
					try {
						dbl = new DatabaseLoader();
						credentials = VcapHelper.parseVcap();
					} catch (Exception e) {
						e.printStackTrace();
					}
		              
					  dbl.setUser(credentials.getUsername());
					  dbl.setPassword(credentials.getPassword());
					  dbl.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
		              dbl.setQuery("select * from "+datasetAsoc);
					  dbl.connectToDatabase();
					  Instances dataForAsoc = dbl.getDataSet();
					  
					  AssociatorEvaluation evalAsoc = new AssociatorEvaluation();
				      
					  try {
							Object fullAlgoritmoAsoc = Class.forName(algoritmoAsoc).newInstance();
							evalAsoc.evaluate((Associator) fullAlgoritmoAsoc,dataForAsoc);
							response.getWriter().println(evalAsoc.toSummaryString());
						} catch (Exception e2) {
							System.out.println(e2.getClass());
							response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				        	response.getWriter().println(e2.getMessage());
							e2.printStackTrace();
						}
					break;
					
				case "clasificacion":
					String datasetClas = request.getParameter("dataset");
					String algoritmoClas = request.getParameter("algoritmo");
	
					try {
						dbl = new DatabaseLoader();
						credentials = VcapHelper.parseVcap();
					} catch (Exception e) {
						e.printStackTrace();
					}
		              
					  dbl.setUser(credentials.getUsername());
					  dbl.setPassword(credentials.getPassword());
					  dbl.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
		              dbl.setQuery("select * from "+datasetClas);
					  dbl.connectToDatabase();
					  Instances dataForClas = dbl.getDataSet();
	
					  //dataForClas.setClassIndex(dataForClas.numAttributes()-1);
				    
					//recupera info del dataset
					ConnectDB conClas = new ConnectDB ();
					ResultSet rsClas = null;
						
					String cadenaClas = "select * from usuario_tabla where id_usuario='"+usuario.getId()+"' and tabla='"+datasetClas+"'";
		            rsClas = conClas.getData(cadenaClas);
		            try {
		            	while (rsClas.next()){
		            		dataForClas.setRelationName(rsClas.getString("relation"));
		            		dataForClas.setClassIndex(rsClas.getInt("classindex"));
						}
					}catch (SQLException e1) {
						e1.printStackTrace();
					}
		                
					    
					try {
						Evaluation evalClas = new Evaluation(dataForClas);
						Object fullAlgoritmoClas = Class.forName(algoritmoClas).newInstance();
						Classifier clas = (Classifier) fullAlgoritmoClas;
						clas.buildClassifier(dataForClas);
						evalClas.evaluateModel((Classifier) fullAlgoritmoClas,dataForClas);
						response.getWriter().println(evalClas.toSummaryString());
					}catch (Exception e2) {
						System.out.println(e2.getClass());
						response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				        response.getWriter().println(e2.getMessage());
						e2.printStackTrace();
					}
					break;
				default:
					break;
				}
			
		}
	}
	
	protected void loadDatasets(HttpServletRequest request){
		UsuarioBean usuario = (UsuarioBean) request.getSession().getAttribute("usuarior");
		
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
            	datasets.add(dataset);
            }
        }catch(Exception e){
        	e.printStackTrace();
        }finally{
        	conn.closeConnection();	
        }
        request.setAttribute("datasetsu", datasets);
		
	}
	
	@SuppressWarnings("unchecked")
	protected void saveDataset(UsuarioTablaBean tmpData, Instances data, PrintWriter out, String action) throws ServletException, IOException {
		
		ConnectDB con = new ConnectDB ();
        int  rsConsulta = 0;
        //conexion a bd
        try{
	    	DatabaseBean credentials = VcapHelper.parseVcap();
	        DatabaseSaver save = new DatabaseSaver();
	        save.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
	        save.setUser(credentials.getUsername());
	        save.setPassword(credentials.getPassword());
	        save.setInstances(data);
	        save.setRelationForTableName(false);
	        save.setTableName(tmpData.getTabla());
	        save.connectToDatabase();
	        save.writeBatch();
	        
	        String cadena= "insert into usuario_tabla values('"+tmpData.getIdUsuario()+"','"+tmpData.getNombre()+"','"+tmpData.getTabla()+"','"+tmpData.getRelation()+"','"+tmpData.getClassIndex()+"','"+tmpData.getDescripcion()+"','"+tmpData.getOrigen()+"' )";
	        
	        rsConsulta = con.InsertaDatos(cadena);
	        if (rsConsulta == -1 ){
	        	out.println("Hubo un problema en la importacion del dataset. Vuelve a intentarlo");
	       }
	        else{
	        	if(action.equals("importGenerated")){
	        		out.println("El dataset generado se importo exitosamente");
	        	}
	        	else{
	        		JSONObject dataResult = new JSONObject();
		        	dataResult.put("nombre", tmpData.getNombre());
		        	dataResult.put("tabla", tmpData.getTabla());
		        	dataResult.put("descripcion", tmpData.getDescripcion());
		        	dataResult.put("origen", tmpData.getOrigen());
		        	
		        	out.println(dataResult);
	        	}
	        	
	        	//dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuario/indexUsuarioRegistrado.jsp"); 
				//dispatcher.forward(request,response);
			}
        }catch(Exception e){
        	e.printStackTrace();
        	//response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        	out.println("error en la carga");
        }finally{
        	out.flush();
        	con.closeConnection();	
        }
	}
	
	protected void updateDataset(Instances data,PrintWriter out, String nombreTabla){
		ConnectDB con = new ConnectDB ();
        //int  rsConsulta = 0;
        System.out.println("instancias: "+data.numInstances());
        //conexion a bd
        try{
        	DatabaseBean credentials = VcapHelper.parseVcap();
	        DatabaseSaver save = new DatabaseSaver();
	        save.setUrl("jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName());
	        save.setUser(credentials.getUsername());
	        save.setPassword(credentials.getPassword());
	        save.setInstances(data);
	        save.setRelationForTableName(false);
	        save.setTableName(nombreTabla);
	        save.connectToDatabase();
	        save.setTruncate(true);
	        save.writeBatch();
	        //String cadena= "insert into usuario_tabla values('"+tmpData.getIdUsuario()+"','"+tmpData.getNombre()+"','"+tmpData.getTabla()+"','"+tmpData.getRelation()+"','"+tmpData.getClassIndex()+"','"+tmpData.getDescripcion()+"','"+tmpData.getOrigen()+"' )";
	        
	    	out.print("dataset actualizado");
	    }
        catch(Exception e){
        	out.print("hubo un error al actualizar el dataset");
        }finally{
        	out.flush();
        	con.closeConnection();	
        }
	}
	
	protected String getGlobalInfoTest(Object object, boolean addCapabilities){
		// set tool tip text from global info if supplied
	    String gi = null;
	    StringBuilder result = new StringBuilder();
	    try {
	      BeanInfo bi = Introspector.getBeanInfo(object.getClass());
	      MethodDescriptor[] methods = bi.getMethodDescriptors();
	      for (MethodDescriptor method : methods) {
	        String name = method.getDisplayName();
	        Method meth = method.getMethod();
	        if (name.equals("globalInfo")) {
	          if (meth.getReturnType().equals(String.class)) {
	            Object args[] = {};
	            String globalInfo = (String) (meth.invoke(object, args));
	            gi = globalInfo;
	            break;
	          }
	        }
	      }
	    } catch (Exception ex) {

	    }

	    // Max. number of characters per line (may overflow)
	    int lineWidth = 180;

	    result.append("<html>");

	    if (gi != null && gi.length() > 0) {

	      StringBuilder firstLine = new StringBuilder();
	      firstLine.append("<font color=blue>");
	      boolean addFirstBreaks = true;
	      int indexOfDot = gi.indexOf(".");
	      if (indexOfDot > 0) {
	        firstLine.append(gi.substring(0, gi.indexOf(".")));
	        if (gi.length() - indexOfDot < 3) {
	          addFirstBreaks = false;
	        }
	        gi = gi.substring(indexOfDot + 1, gi.length());
	      } else {
	        firstLine.append(gi);
	        gi = "";
	      }
	      firstLine.append("</font>");
	      if ((addFirstBreaks) && !(gi.startsWith("\n\n"))) {
	        if (!gi.startsWith("\n")) {
	          firstLine.append("<br>");
	        }
	        firstLine.append("<br>");
	      }
	      result.append(Utils.lineWrap(firstLine.toString(), lineWidth));

	      result.append(Utils.lineWrap(gi, lineWidth).replace("\n", "<br>"));
	      result.append("<br>");
	    }

	    if (addCapabilities) {
	      if (object instanceof CapabilitiesHandler) {
	        if (!result.toString().endsWith("<br><br>")) {
	          result.append("<br>");
	        }
	        String caps = PropertySheetPanel.addCapabilities(
	          "<font color=red>CAPABILITIES</font>",
	          ((CapabilitiesHandler) object).getCapabilities());
	        caps = Utils.lineWrap(caps, lineWidth).replace("\n", "<br>");
	        result.append(caps);
	      }

	      if (object instanceof MultiInstanceCapabilitiesHandler) {
	        result.append("<br>");
	        String caps = PropertySheetPanel.addCapabilities(
	          "<font color=red>MI CAPABILITIES</font>",
	          ((MultiInstanceCapabilitiesHandler) object)
	            .getMultiInstanceCapabilities());
	        caps = Utils.lineWrap(caps, lineWidth).replace("\n", "<br>");
	        result.append(caps);
	      }
	    }

	    result.append("</html>");

	    if (result.toString().equals("<html></html>")) {
	      return null;
	    }
	    return result.toString();
	}
}
