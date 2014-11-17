<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html">
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Interfaz web para la herramienta Weka">
    <meta name="author" content="Patricio Quispe Sosa">
    <link rel="icon" href="images/favicon.ico">

    <title>Pagina de inicio</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/custom.css" rel="stylesheet">
    <link href="css/bootstrap/bootstrap-formhelpers.min.css" rel="stylesheet">
    
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/docs.min.js"></script>
	<script src="js/bootstrap-formhelpers.min.js"></script>
    
  </head>

  <body data-spy="scroll" data-target="#docs">
	<jsp:useBean id="usuario" class="com.wekaweb.beans.UsuarioBean" scope="session" />
        
    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-inverse " role="navigation">
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
          <c:choose>
	    	<c:when test="${empty name}">
	    		<ul class="nav navbar-nav navbar-right">
		            <form class="navbar-form navbar-right" role="form" method="post" action="Logout">
		            	<input type="submit" class="btn btn-danger" name="submit" value="Cerrar sesion" />
		          	</form>
		          </ul>
			</c:when>
			<c:otherwise>
				  <ul class="nav navbar-nav navbar-right">
			        <li class="dropdown">
			          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><c:out value="${name}"></c:out><span class="caret"></span></a>
			          <ul class="dropdown-menu" role="menu">
			          	<li><a href="#">Completar registro</a></li>	
			            <li><a  class="list-group-item list-group-item-danger" href="<%=request.getContextPath()%>/Logout">Logout</a></li>
			          </ul>
			        </li>
			        <!-- 
			        <li><div class="bfh-selectbox bfh-languages navbar-btn" data-language="es_ES" data-available="en_US,es_ES" data-flags="true" data-blank="false"></div></li>
					 -->
			      </ul>
			</c:otherwise>
		 </c:choose>
          <!--  
          <ul class="nav navbar-nav navbar-right">
            <form class="navbar-form navbar-right" role="form" method="post" action="Logout">
            	<button type="button" class="btn btn-link">Perfil</button>
            	<input type="submit" class="btn btn-danger" name="submit" value="Cerrar sesion" />
          	</form>
          </ul>
          
          <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><c:out value="${name}"></c:out><span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	          	<li><a href="#">Completar registro</a></li>	
	            <li><a  class="list-group-item list-group-item-danger" href="<%=request.getContextPath()%>/Logout">Logout</a></li>
	          </ul>
	        </li>
	         
	        <li><div class="bfh-selectbox bfh-languages navbar-btn" data-language="es_ES" data-available="en_US,es_ES" data-flags="true" data-blank="false"></div></li>
			 
	      </ul>
	     -->
        </div><!--/.nav-collapse -->
      </div>
    </div>
    
    <div class="container">
    
	    <c:choose>
	    	<c:when test="${empty msgActivate}">
	    	
			</c:when>
			<c:otherwise>
				<div class="alert alert-success alert-dismissible" role="alert">
				  	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<c:out value="${msgActivate}"></c:out>
				</div>
			</c:otherwise>
		</c:choose>
      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>Hola <jsp:getProperty property="nombre" name="usuario"/> !</h1>
        <!--  
        <c:choose>
	    	<c:when test="${empty name}">
	    	
			</c:when>
			<c:otherwise>
				<div class="alert alert-success alert-dismissible" role="alert">
				  	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<c:out value="${name}"></c:out>
				</div>
			</c:otherwise>
		</c:choose>
		-->
        <p>Esta es tu pagina de inicio donde encontraras toda la informacion sobre las funcionalidades que te ofrece Weka Web Application, haciendo clic en el siguiente boton podras encontrar mas informacion</p>
        <p>
          <a class="btn btn-lg btn-primary" href="#cntDatasets" role="button">Ver funcionalidades &raquo;</a>
        </p>
      </div>
	</div> <!-- /container -->
    
	<div class="container">
      <!-- Example row of columns -->
      <div id="af" class="row">
        <div  class="col-md-3" id="docs">
          <div class="bs-docs-sidebar hidden-print hidden-xs hidden-sm" role="complementary">
            <ul id="af" class="nav bs-docs-sidenav">
				<li>
				  <a href="#cntDatasets">Datasets</a>
				  <ul class="nav">
				    <li><a href="#cntImportar">Importar</a></li>
				    <li><a href="#cntExportar">Exportar</a></li>
				    <li><a href="#cntGenerar">Generar</a></li>
				  </ul>
				</li>
				<li><a href="#cntPreparar">Preparar datos</a></li>
				<li><a href="#cntClasificacion">Clasificacion</a></li>
				<li><a href="#cntClustering">Clustering</a></li>
				<li><a href="#cntAsociacion">Asociacion</a></li>
			</ul>
            <a class="back-to-top" href="#top">Volver arriba</a>
          </div>
        </div>

        <div class="col-md-9">
            <h2 id="cntDatasets">Datasets</h2>
            <p>Un dataset es un conjunto de elementos de datos más o menos equivalente a una hoja de cálculo de dos dimensiones o una tabla de base de datos. En WEKA, es implementado por la clase weka.core.Instances. Un dataset es una colección de instancias, cada uno de la clase weka.core.Instance. Cada Instancia consta de un número de atributos, cualquiera de los cuales puede ser nominal (uno de una lista predefinida de valores), numérico (un número real o entero) o una cadena (una larga lista arbitraria de caracteres, encerrada en "comillas dobles"). Otros tipos son fecha y relacional.Weka Web Application permite realizar tres tipos de operaciones con datasets las cuales se encuentrasn descritas abajo.</p>
            <hr>

            <h2 id="cntImportar">Importar</h2>
            <p>Esta opcion permite importar nuevos datasets para su pre procesado y para su evaluacion.Puedes importar datasets desde tu propio dispositivo o desde n .La mayoria de los formatos soportados por Weka son compatibles</p>
            <hr>

            <h2 id="cntExportar">Exportar</h2>
            <p>Esta opcion permite exportar tus datasets, ya sean los que hayas importado o los que hayas generado. La mayoria de los formatos por Weka son compatibles</p>
            <hr>

            <h2 id="cntGenerar">Generar</h2>
            <p>Esta opcion permite generar nuevos datasets, para esto se usa todos los algoritmos de generacion de datasets disponibles en Weka, los datasets generados contienen datos randomicos. Una vez generado el dataset puedes importarlo o exportarlo</p>
            <hr>

            <h2 id="cntPreparar">Preparar datos</h2>
            <p>Consiste en consolidar y limpiar los datos identificados en el paso anterior. Los datos pueden estar dispersos en la empresa y almacenados en formatos distintos; también pueden contener incoherencias como entradas que faltan o incorrectas. Por ejemplo, los datos pueden mostrar que un cliente adquirió un producto incluso antes que se ofreciera en el mercado o que el cliente compra regularmente en una tienda situada a 2.000 kilómetros de su casa.</p>
			<hr>
			
            <h2 id="cntClasificacion">Clasificacion</h2>
            <p>permite al usuario aplicar algoritmos de clasificación estadística y análisis de regresión (denominados todos clasificadores en Weka) a los conjuntos de datos resultantes, para estimar la exactitud del modelo predictivo resultante, y para visualizar predicciones erróneas, curvas ROC, etc., o el propio modelo (si este es susceptible de ser visualizado, como por ejemplo un árbol de decisión).</p>
            <hr>
            
	        <h2 id="cntClustering">Clustering</h2>
            <p>Da acceso a las técnicas de clustering o agrupamiento de Weka como por ejemplo el algoritmo K-means. Este es sólo una implementación del algoritmo expectación-maximización para aprender una mezcla de distribuciones normales.</p>
            <hr>

            <h2 id="cntAsociacion">Asociacion</h2>
            <p>Proporciona acceso a las reglas de asociación aprendidas que intentan identificar todas las interrelaciones importantes entre los atributos de los datos</p>
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
    <script src="js/bootstrap/bootstrap.min.js"></script>
  </body>
</html>