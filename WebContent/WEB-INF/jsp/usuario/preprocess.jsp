<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="images/favicon.ico">

    <title>Atributos - Filtros</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap/font-awesome.css" rel="stylesheet">
	<link href="css/custom.css" rel="stylesheet">
	
    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/bootstrap/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <script src="js/jquery.tmpl.min.js"></script>
	<script src="js/bootstrap-treeview.js"></script>
    <script src="js/wekaweb/preprocess.js"></script>
    
    <script type="text/javascript" >
    	function getTreeDatasets(){
	   		var tree = [{
	    	            text: "Datasets", 
	    	            selectable: false,
	    	            nodes: [
							<c:forEach var="data" items="${datasetsu}">
								{
									text: '${data.nombre}',
									dataset: '${data.tabla}'
								},
							</c:forEach>
	    	            ]
	    	           }];
		    return tree;
		}
    	
    	function getTreeAtributos(){
	   		var tree = [
	   		            	{
	    	            		text: "Atributo 1", 
		    	           	},
		    	           	{
			    	            text: "Atributo 2", 
			    	        },
			    	        {
			    	        	text: "Atributo 3"
			    	        },
			    	        {
			    	        	text: "Atributo 4"
			    	        },
			    	        {
			    	        	text: "Atributo 5"
			    	        }

	   			];
		    return tree;
		}
    </script>
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
          <a class="navbar-brand" href="<%=request.getContextPath()%>/Main?action=index">Weka Web Application</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
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
  			<h1>Atributos - Filtros</h1>
		</div>
	  	
	  	<ol class="breadcrumb hidden-print">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li>Datasets</li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=preprocess">Atributos - Filtros</a></li>
	  	</ol>
	  	
	  	<input id="context" type="hidden" value="<%=request.getContextPath()%>">
	  	
    	<div class="row">
        	<div class="col-md-4 hidden-print">
        		<h3>Seleccionar dataset:</h3>
			
        		<div class="alert alert-dismissible alert-danger" role="alert" id="msgAlgoritmo">
					<button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>
				</div>
				
				<div class="panel-group" id="datasetList">
					<c:choose>
					      <c:when test="${empty datasetsu}">
					      	<div class="alert alert-warning" role="alert">Parece que no tienes ningun dataset. Prueba cargando algunos!</div>
					      </c:when>
					      <c:otherwise>
					      		<div id="treeDatasets"></div>
					      </c:otherwise>
					</c:choose>
				</div>
				
				<h3>Atributos:</h3>
				
				<div class="form-group">
 				  	<div class="btn-group btn-group-justified">
					  <div class="btn-group">
					    <button id="btnAll" type="button" class="btn btn-default"><span class="glyphicon glyphicon-print"></span> All</button>
					  </div>
					  <div class="btn-group">
					    <button id="btnNone" type="button" class="btn btn-default"><span class="glyphicon glyphicon-upload"></span> None</button>
					  </div>
					  <div class="btn-group">
					    <button id="btnInvert" type="button" class="btn btn-default"><span class="glyphicon glyphicon-print"></span> Invert</button>
					  </div>
					  <div class="btn-group">
					    <button id="btnPattern" type="button" class="btn btn-default"><span class="glyphicon glyphicon-upload"></span> Pattern</button>
					  </div>
					</div>
				</div>
				
				<!--  
				<h3 class="text-center">Basic Example</h3>
	            	<ul class="list-group checked-list-box">
	                  <li class="list-group-item">Cras justo odio</li>
	                  <li class="list-group-item">Dapibus ac facilisis in</li>
	                  <li class="list-group-item">Morbi leo risus</li>
	                  <li class="list-group-item">Porta ac consectetur ac</li>
	                  <li class="list-group-item">Vestibulum at eros</li>
	                  <li class="list-group-item">Cras justo odio</li>
	                  <li class="list-group-item">Dapibus ac facilisis in</li>
	                  <li class="list-group-item">Morbi leo risus</li>
	                  <li class="list-group-item">Porta ac consectetur ac</li>
	                  <li class="list-group-item">Vestibulum at eros</li>
	                </ul>
	            <button class="btn btn-primary col-xs-12" id="get-checked-data">Get Checked Data</button>
	            
	            <div id="display-json"></div>
	            -->
	            
	            <div class="row">
	            	<div class="col-md-10 hidden-print leftrow">
	            	<div id="treeAtributos"></div>
        			
        			</div>
        			<div id="checkboxesAttr" class="col-md-2 hidden-print rightrow">
        				
        				
        			</div>
	            </div>
				
        		<div class="form-group">
 		       		<button id="btnRemove" type="button" class="btn btn-danger btn-block">Remove</button>
				</div>
				
				<h3>Filtros:</h3>
				
				<div id="treeAlgoritmos"></div>
        		  
        		<input id="inputDataset" type="hidden">  
        		<input id="inputAlgoritmo" type="hidden">  
        		
        		<div class="form-group">
 		       		<button id="btnApply" data-loading-text="Trabajando..." type="button" class="btn btn-success btn-block">Apply</button>
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
					    <button id="btnImprimir" type="button" class="btn btn-default" disabled="disabled"><span class="glyphicon glyphicon-print"></span> Imprimir</button>
					  </div>
					  <div class="btn-group">
					    <button id="btnImportar" data-loading-text="Importando..." type="button" class="btn btn-default" disabled="disabled"><span class="glyphicon glyphicon-upload"></span> Importar</button>
					  </div>
					  
					  <!--  
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
					  -->
					</div>
				</div>
				<div class="form-group">
 					<div class="alert alert-dismissible alert-danger" role="alert" id="msgGenerated">
						<button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="messageGen">message</span>
					</div>
				</div>
			</div>
	        
	        <div id="print" class="col-md-8">
	          <div class="panel panel-primary hidden-print">
				  <div class="panel-heading">Selected Attribute: </div>
				  <div id="pnlInfoAttribute" class="panel-body"></div>
			  </div>
			  <!--  
			  <div class="panel panel-primary">
				  <div class="panel-heading">Resultado:</div>
				  <div id="pnlResult" class="panel-body"></div>
			  </div>
			  -->
			</div>
	  </div>
    </div> <!-- /container -->
    
    
    
	<div class="footer">
      <div class="container">
        <p>Copyright © 2014 <a href="#">Patricio Quispe Sosa</a></p>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   </body>
</html>