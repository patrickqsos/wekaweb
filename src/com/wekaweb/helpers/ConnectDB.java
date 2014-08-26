package com.wekaweb.helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.json.simple.parser.ParseException;
import com.wekaweb.beans.DatabaseBean;

public class ConnectDB {
  Statement statement;
  Connection conexion = null;
  
  public ConnectDB(){
	  
	  DatabaseBean credentials = null;
	  try {
		credentials = VcapHelper.parseVcap();
	  } catch (ParseException e1) {
		e1.printStackTrace();
	  }
		
	  
	  String sourceURLCLOUD = "jdbc:mysql://"+credentials.getHostname()+"/"+credentials.getName();
	  
	  try{
		  Class.forName("com.mysql.jdbc.Driver").newInstance();
		  //conexion = DriverManager.getConnection(sourceURL,userLocal,passwordLocal);
		  conexion = DriverManager.getConnection(sourceURLCLOUD,credentials.getUsername(),credentials.getPassword());
		  
		  statement = conexion.createStatement ();
	  } 
	  catch (InstantiationException | IllegalAccessException | ClassNotFoundException | SQLException e){
		  e.printStackTrace();
	  }
  }
  
  public void closeConnection () {
    if(conexion!=null)
    try {
      statement.close();
      conexion.close();
      conexion=null;
    } catch (SQLException ex) {
        System.out.println("\nSQLException-------------\n");
        System.out.println("SQLState: "+ ex.getSQLState());
        System.out.println("Message : "+ ex.getMessage());
    }
  }
  public ResultSet getData(String Consulta)
  {
    ResultSet rs = null;
    try
    {
//      System.out.println(Consulta);
    	rs = statement.executeQuery(Consulta);
    } catch (SQLException ex) {
        System.out.println("\nSQLException-------------\n");
        System.out.println("SQLState: "+ ex.getSQLState());
        System.out.println("Message : "+ ex.getMessage());
    }
    return rs;
  }

  public int InsertaDatos(String Consulta)
  {
    int NroReg=-1;
    try
    {
        NroReg=statement.executeUpdate(Consulta);
    }
    catch (SQLException ex)
    {   System.out.println("\nSQLException-------------\n");
        System.out.println("SQLState: "+ ex.getSQLState());
        System.out.println("Message : "+ ex.getMessage());
    }
    return NroReg;
  }

  public String ValRegistro(String Consulta,String Campo)
  {
    String Cadena=null;
    try
    {
      ResultSet rs=statement.executeQuery(Consulta);
      if (rs.next())
        Cadena=rs.getString(Campo);
      rs.close();
    } catch (SQLException ex) {
        System.out.println("\nSQLException-------------\n");
        System.out.println("SQLState: "+ ex.getSQLState());
        System.out.println("Message : "+ ex.getMessage());
    }
    return Cadena;
  }

  public  boolean Existe(String Consulta)
  {
    boolean existe=false;
    try
    {
      ResultSet rs=statement.executeQuery(Consulta);
      if (rs.next())
        existe=true;
      else
        existe=false;
      rs.close();
    } catch (SQLException ex) {
        System.out.println("\nSQLException-------------\n");
        System.out.println("SQLState: "+ ex.getSQLState());
        System.out.println("Message : "+ ex.getMessage());
    }
    return existe;
  }
  
  
  
}