<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Interfaz web para la herramienta Weka">
    <meta name="author" content="Patricio Quispe Sosa">
    <link rel="icon" href="images/favicon.ico">

    <title>Generar dataset</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/bootstrap/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <script src="js/jquery.tmpl.min.js"></script>
	<script src="js/bootstrap-treeview.js"></script>
    <script src="js/wekaweb/generate.js"></script>
  </head>

  <body>

	<jsp:useBean id="usuario" class="com.wekaweb.beans.UsuarioBean" scope="session" />
    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top navbar-inverse " role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <img src='images/cloud3.png' class='img-responsive' style="float: left; width: 50px; display: inline-block;padding-right: 5px;"/>
          <a class="navbar-brand" href="<%=request.getContextPath()%>/Main?action=index">Weka Web Application</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <!--  
            <li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
            -->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle active" data-toggle="dropdown">Datasets<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="<%=request.getContextPath()%>/Main?action=importar">Importar</a></li>
                <li><a href="<%=request.getContextPath()%>/Main?action=exportar">Exportar</a></li>
                <li><a href="<%=request.getContextPath()%>/Main?action=generar">Generar</a></li>
             </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle active" data-toggle="dropdown">Preparar datos<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="<%=request.getContextPath()%>/Main?action=editar">Editar dataset</a></li>
                <li><a href="<%=request.getContextPath()%>/Main?action=preprocess">Filtros - atributos</a></li>
             </ul>
            </li>
            <li><a href="<%=request.getContextPath()%>/Main?action=clasificacion">Clasificacion</a></li>
            <li><a href="<%=request.getContextPath()%>/Main?action=clustering">Clustering</a></li>
            <li><a href="<%=request.getContextPath()%>/Main?action=asociacion">Asociacion</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <form class="navbar-form navbar-right" role="form" method="post" action="Logout">
            	<button type="button" class="btn btn-link">Perfil</button>
            	<input type="submit" class="btn btn-danger" name="submit" value="Cerrar sesion" />
          	</form>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

	<div class="container">
	
		<div class="page-header">
  			<h1>Generador de datasets</h1>
		</div>
	  	
	  	<ol class="breadcrumb hidden-print">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li>Datasets</li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=generar">Generar</a></li>
	  	</ol>
	  	
	  	<input id="context" type="hidden" value="<%=request.getContextPath()%>">
	  	
    	<div class="row">
        	<h3>Seleccionar algoritmo:</h3>
        		
        	<div class="col-md-4 hidden-print">
        		<div class="alert alert-dismissible alert-danger" role="alert" id="msgAlgoritmo">
					<button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>
				</div>
			
        		<div id="tree"></div>
        		  
        		<input id="inputAlgoritmo" type="hidden">  
        		<div class="form-group">
 		       		<button id="btnGenerar" type="button" class="btn btn-success btn-block">Generar</button>
				</div>
				<div class="form-group">
 				  	<div class="btn-group btn-group-justified">
					  <div class="btn-group">
					    <button id="btnImprimir" type="button" class="btn btn-default" disabled="disabled"><span class="glyphicon glyphicon-print"></span> Imprimir</button>
					  </div>
					  <div class="btn-group">
					    <button id="btnImportar" data-loading-text="Importando..." type="button" class="btn btn-default" disabled="disabled"><span class="glyphicon glyphicon-upload"></span> Importar</button>
					  </div>
					  <div class="btn-group">
					    <button id="btnExportar" data-loading-text="Exportando..."  type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" disabled="disabled"><span class="glyphicon glyphicon-download"></span> Exportar  <span class="caret"></span></button>
					    <ul class="dropdown-menu" role="menu">
					      	  <li><a class="typeFile" id="arff" href="#">Arff data files (*.arff)</a></li>
					          <li><a class="typeFile" id="arff.gz" href="#">Arff data files (*.arff.gz)</a></li>
					          <li><a class="typeFile" id="names" href="#">C4.5 file format (*.names)</a></li>
					          <li><a class="typeFile" id="csv" href="#">CSV file (*.csv)</a></li>
					          <li><a class="typeFile" id="json" href="#">JSON data files (*.json)</a></li>
					          <li><a class="typeFile" id="json.gz" href="#">JSON data files (*.json.gz)</a></li>
					          <li><a class="typeFile" id="libsvm" href="#">libsvm data files (*.libsvm)</a></li>
					          <li><a class="typeFile" id="dat" href="#">svm light data files (*.dat)</a></li>
					          <li><a class="typeFile" id="bsi" href="#">Binary serialized instances (*.bsi)</a></li>
					          <li><a class="typeFile" id="xrff" href="#">XRFF data files (*.xrff)</a></li>
					          <li><a class="typeFile" id="xrff.gz" href="#">XRFF data files (*.xrff.gz)</a></li>
					    </ul>
					  </div>
					</div>
				</div>
				<div class="form-group">
 					<div class="alert alert-dismissible alert-danger" role="alert" id="msgGenerated">
						<button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="messageGen">message</span>
					</div>
				</div>
			</div>
	        
	        <div id="print" class="col-md-8">
	        
	          <script id="tmplPnlInfoDataset" type="text/x-jquery-tmpl">
    				<dl>
				  		<dt>Nombre:</dt><dd>${'${'}nombreAlgoritmo}</dd>
				  		<dt>Synopsis:</dt><dd>${'${'}globalInfo}</dd>
				  	</dl>
			  </script>
			  
			  <script id="tmplPnlData" type="text/x-jquery-tmpl">
					<input id="nombreDataset" type="hidden" value="${'${'}nombreDataset}">
	  				<input id="descDataset" type="hidden" value="${'${'}descripcion}">
	  	
					<strong>Nombre: </strong>${'${'}nombreDataset}</br>
					<strong>Relation: </strong>${'${'}nombre}</br>
				  	<strong>Instances: </strong>${'${'}instancias}</br>
					<strong>Attributes: </strong>${'${'}atributos}</br>
				  	<strong>Sum of weights: </strong>10000</br>
					<div id="pnlDataOutput">
						<pre><samp>${'${'}output}</samp></pre>
					</div>
			  </script>
			  
	       	  <div class="panel panel-primary">
				  <div class="panel-heading">Info del algoritmo: </div>
				  <div id="pnlInfoDataset" class="panel-body">
				  	<dl>
				  		<dt>Nombre:</dt><dd>Nombre completo del algoritmo seleccionado</dd>
				  		<dt>Synopsis:</dt><dd>Synopsis del algoritmo seleccionado</dd>
				  	</dl>	
				  </div>
			  </div>
			  
	          <div class="panel panel-primary">
				  <div class="panel-heading">Dataset generado:</div>
				  <div id="pnlData" class="panel-body">
				  	  	<strong>Nombre: </strong> Nombre del dataset generado (datase_algoritmo_usuario)</br>
					  	<strong>Relation: </strong> Relaciond el dataset generado</br>
					  	<strong>Attributes: </strong> Numero de atributos del datasets generado</br>
					  	<strong>Instances: </strong> Numeor de instancais dle dataset generado</br>
				  </div>
			  </div>
			
	        </div>
	  </div>
    </div> <!-- /container -->
    
    
    
	<div class="footer">
      <div class="container">
        <p>Copyright � 2014 <a href="#">Patricio Quispe Sosa</a></p>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   </body>
</html>