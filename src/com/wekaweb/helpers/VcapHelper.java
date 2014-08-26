package com.wekaweb.helpers;

import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.wekaweb.beans.DatabaseBean;

public class VcapHelper {

	public static JSONObject VCAP = null;
    public static JSONObject CREDENTIALS = null;
    
	public VcapHelper(){

	}
	
	
	/**
	 * 
	 * @return Credenciales de acceso la base de datos
	 * @throws ParseException
	 */
	public static DatabaseBean parseVcap() throws  ParseException {  
	  	
		DatabaseBean credentialsdb = new DatabaseBean();
		JSONParser parser = new JSONParser();  
	    
		//production mode
		/*
		String vcapEnv = System.getenv("VCAP_SERVICES");  
	    if (vcapEnv == null) {  
	        return null;  
	    }
	    
	    VCAP = (JSONObject) parser.parse(vcapEnv); 
	    */
		//end production mode
		
		//development mode
		
	    
	    try {
			//VCAP = (JSONObject) parser.parse(new FileReader("E://Environment/vcaplocal.json"));
	    	VCAP = (JSONObject) parser.parse(new FileReader("/Users/Patrick/Dev/vcaplocal.json"));
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	    //end development mode
	    
	    
	    JSONArray array = (JSONArray) VCAP.get("mysql-5.1"); 
		
		@SuppressWarnings("unchecked")
		Iterator<JSONObject> iterator = array.iterator();
		while (iterator.hasNext()) {
			JSONObject aux = iterator.next();
			CREDENTIALS = (JSONObject) aux.get("credentials");
			
			credentialsdb.setHostname((String) CREDENTIALS.get("hostname"));
			credentialsdb.setUsername((String) CREDENTIALS.get("username"));
			credentialsdb.setPassword((String) CREDENTIALS.get("password"));
			credentialsdb.setName((String) CREDENTIALS.get("name"));
		}
	    
	    return credentialsdb; 
	}
}
