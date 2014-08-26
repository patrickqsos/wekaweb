package com.wekaweb.testing;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class JsonSimpleExample {
    public static void main(String[] args) throws FileNotFoundException, IOException, ParseException {

    	JSONParser parser = new JSONParser();
	

		Object obj = parser.parse(new FileReader("c:\\vcap.json"));

		JSONObject jsonObject = (JSONObject) obj;
		
		
		
		    // Getting Array of Contacts
			JSONArray array = (JSONArray) jsonObject.get("mysql-5.1"); 
			
			Iterator<JSONObject> iterator = array.iterator();
			while (iterator.hasNext()) {
				JSONObject o = iterator.next();
				
				JSONObject credentials = (JSONObject) o.get("credentials");
				
				String hostname =  (String) credentials.get("hostname");
				String username =  (String) credentials.get("username");
				String password =  (String) credentials.get("password");
				String name =  (String) credentials.get("name");
				
				/*
				System.out.println(hostname);
				System.out.println(username);
				System.out.println(password);
				System.out.println(name);
				*/	
			}
	
    }

}