<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
  	<meta name="google-site-verification" content="akCee8NeY_PCcDY6WbJrC2XVxeTG_NGyj32Tc8GyYdA" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Weka Web Application">
    <meta name="author" content="Patricio Quispe Sosa">
    <link rel="icon" href="images/favicon.ico">

    <title>WWA - Weka Web Application</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/jumbotron.css" rel="stylesheet">
	<link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
   </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <img src='images/cloud3.png' class='img-responsive' style="float: left; width: 50px; display: inline-block;padding-right: 5px;"/>
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

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Bienvenido</h1>
        <p>El presente proyecto académico es una interface para el uso de la herramienta Weka, en un entorno Cloud Computing basado en el modelo SaaS.</p>
        <p><a class="btn btn-primary btn-lg" role="button">Learn more &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
       
      <div class="row">
        <div class="col-md-4">
          <h2>Mineria de datos</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">Mas info &raquo;</a></p>
       	</div>
       	<div class="col-md-4">
          <h2>Weka</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn btn-default" href="#" role="button">Mas info &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Cloud Computing</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">Mas info &raquo;</a></p>
        </div>
      </div>
	
      <hr>

      
    </div> <!-- /container -->
<!-- 
	<div class="footer">
      <div class="container">
        <p class="navbar-text pull-left">Copyright © 2014 <a href="#">Patricio Quispe Sosa</a></p>
      	<p class="navbar-text pull-right"><a href="http://aws.amazon.com/what-is-cloud-computing"><img src="http://awsmedia.s3.amazonaws.com/AWS_Logo_PoweredBy_127px.png" alt="Powered by AWS Cloud Computing"></a></p>
     </div>
    </div>
-->
  
	<div class="navbar navbar-default navbar-fixed-bottom">
    <div class="container">
      <p class="navbar-text pull-left">Copyright © 2014 <a href="#">Patricio Quispe Sosa</a></p>
      <p class="navbar-text pull-right"><a href="http://aws.amazon.com/what-is-cloud-computing"><img src="http://awsmedia.s3.amazonaws.com/AWS_Logo_PoweredBy_127px.png" alt="Powered by AWS Cloud Computing"></a></p>
         
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