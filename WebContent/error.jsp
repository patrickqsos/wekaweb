<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Pagina no encontrada - WWA</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

    
  </head>

  <body>

    <!-- Fixed navbar -->
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="<%=request.getContextPath()%>">Weka Web Application</a>
        </div>
        <div class="navbar-collapse collapse">
        	<ul class="nav navbar-nav navbar-right">
        		<a class="btn btn-default navbar-btn" href="<%=request.getContextPath()%>/Registro">Registrarse</a>
				<a class="btn btn-success navbar-btn" href="<%=request.getContextPath()%>/Login">Iniciar sesion</a>
			</ul>
	    </div><!--/.navbar-collapse -->
      </div>
    </div>
    
    <div class="container">
    	<div class="row">
		    <div class="span12">
		      <div class="jumbotron text-center">
		          <h1>Pagina no encontrada</h1>
		          <h1><small><font face="Tahoma" color="red">Error 404</font></small></h1>
		          <br />
		          <p>La pagina que solicitaste no fue encontrada,contacte al administrador o recargue la pagina. Use el boton <b>Atras</b> para volver a la pagina de donde vino</p>
		          <p><b>O puede presionar el siguiente boton:</b></p>
		          <a href="<%=request.getContextPath()%>" class="btn btn-large btn-info"><i class="icon-home icon-white"></i>Pagina de inicio</a>
		        </div>
		        <br />
		      
		           
		    </div>
		  </div>
	</div> <!-- /container -->
    
	
    
    <hr>
    
	<div class="footer">
      <div class="container">
        <p>Copyright © 2014 <a href="#">Patricio Quispe Sosa</a></p>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> -->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
  </body>
</html>