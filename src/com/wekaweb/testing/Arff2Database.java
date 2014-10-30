package com.wekaweb.testing;

import weka.core.Capabilities;
import weka.filters.unsupervised.attribute.Standardize;

/**
 * A simple API example of transferring an ARFF file into a MySQL table.
 * It loads the data into the database "weka_test" on the MySQL server
 * running on the same machine. Instead of using the relation name of the
 * database as the table name, "mytable" is used instead. The
 * DatabaseUtils.props file must be configured accordingly.
 *
 * Usage: Arff2Database input.arff
 *
 * @author FracPete (fracpete at waikato dot ac dot nz)
 */
public class Arff2Database {

  /**
   * loads a dataset into a MySQL database
   *
   * @param args    the commandline arguments
   */
  public static void main(String[] args) throws Exception {
	  
	  Capabilities cap = new Standardize().getCapabilities();
	  
	  System.out.println(cap.toString());
      
	  
	 /* 
	  
	  BufferedReader br = new BufferedReader(new FileReader("/Users/Patrick/weather.arff"));
	  //File file = new File("E:\\Environment\\weather.json");
	  
      Instances data = new Instances(br);
	  
	  
		data.setClassIndex(data.numAttributes() - 1);
	
	    DatabaseSaver save = new DatabaseSaver();
	    
	    save.setUrl("jdbc:mysql://localhost:3306/wekaweb");
	    save.setUser("root");
	    save.setPassword("");
	    save.setInstances(data);
	    save.setRelationForTableName(false);
	    save.setTableName("weather_public");
	    save.connectToDatabase();
	    save.writeBatch();
	    
      
      
      
      JSONNode n = new JSONNode();
      JSONSaver js = new JSONSaver();  
      JSONInstances j = new JSONInstances();
      
      
      n = j.toJSON(data);
      
      StringBuffer buffer = new StringBuffer();
      n.toString(buffer);
    
      
      JSONObject a = new JSONObject();
      JSONParser b = new JSONParser();
      
      a= (JSONObject) b.parse(buffer.toString());
      
      System.out.println("JSON : " + a.toString());
      
      
      System.out.println(data.classIndex());
      data.setClassIndex(data.numAttributes()-1);
      System.out.println(data.classIndex());
      
      Capabilities test = Capabilities.forInstances(data);
		//response.getWriter().print("Algoritmo: "+algoritmo.get("className"));
		Iterator<Capability> my = test.capabilities();
		while(my.hasNext()){
			Capability myc = my.next();
			System.out.println(myc.name());
		}
		
		
      BayesNet bay = new BayesNet();
      bay.buildClassifier(data);
      
      Evaluation eval = new Evaluation(data);
      eval.evaluateModel(bay, data);
      
      
      System.out.println(eval.toSummaryString());
      */
      
     
  }
}