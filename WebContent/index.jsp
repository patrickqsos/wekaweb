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

    <title>Weka Web Application</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/jumbotron.css" rel="stylesheet">
	<link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
	<script src="js/jquery-1.9.1.js"></script>
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
        <p><a class="btn btn-primary btn-lg" role="button" href="#ctnMore">Ver mas &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
       
      <div class="row" id="ctnMore">
        <div class="col-md-4">
          <h2>Mineria de datos</h2>
          <p>Es el proceso de detectar la información procesable de los conjuntos grandes de datos. Utiliza el análisis matemático para deducir los patrones y tendencias que existen en los datos. Normalmente, estos patrones no se pueden detectar mediante la exploración tradicional de los datos porque las relaciones son demasiado complejas o porque hay demasiado datos. Estos patrones y tendencias se pueden recopilar y definir como un modelo de minería de datos.</p>
          <!--  <p><a class="btn btn-default" href="#" role="button">Mas info &raquo;</a></p> -->
       	</div>
       	<div class="col-md-4">
          <h2>Weka</h2>
          <p>Corresponde a las siglas en inglés de Waikato Environment for Knowledge Analysis. Es una herramienta de software desarrollada en Java por la Universidad de Waikato (Nueva Zelanda). Esta herramienta contiene principalmente algoritmos de Machine Learning usados en el proceso de la minería de datos. Weka incluye herramientas para el pre procesamiento de los datos (filtros), clasificación (árboles, tablas), clustering, reglas de asociación y adicionalmente, diversas formas de visualización de los datos, tanto en el inicio del proceso de carga de datos, como después de haber aplicado un algoritmo. </p>
          <!--  <p><a class="btn btn-default" href="#" role="button">Mas info &raquo;</a></p> -->
       	</div>
        <div class="col-md-4">
          <h2>Cloud Computing</h2>
          <p>El cloud computing consiste en la posibilidad de ofrecer servicios a través de Internet, es una tecnología nueva que busca tener todos nuestros archivos e información en Internet y sin depender de poseer la capacidad suficiente para almacenar información. Explica las nuevas posibilidades de forma de negocio actual, ofreciendo servicios a través de Internet, conocidos como e-business (negocios por Internet).</p>
          <!--  <p><a class="btn btn-default" href="#" role="button">Mas info &raquo;</a></p> -->
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
      <p class="navbar-text pull-left">Copyright © 2014 <a href="">Patricio Quispe Sosa</a></p>
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