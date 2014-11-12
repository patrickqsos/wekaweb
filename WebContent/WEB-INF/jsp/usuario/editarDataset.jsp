<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="images/favicon.ico">

    <title>Editar dataset</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap/font-awesome.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/bootstrap/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <!-- DataTables CSS -->
    <link href="css/bootstrap/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap/dataTables.tableTools.min.css" rel="stylesheet">
    
    
    <script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery.tmpl.min.js"></script>
	<script src="js/jquery.dataTables.js"></script>
    <script src="js/dataTables.bootstrap.js"></script>
	<script src="js/dataTables.tableTools.js"></script>
	<script src="js/validator.min.js"></script>
    <script src="js/wekaweb/editDataset.js"></script>
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
  			<h1 class="hidden-print">Editar datasets</h1>
		</div>
	  	
	  	<ol class="breadcrumb hidden-print">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li><a href="#">Preparar Datos</a></li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=editar">Editar dataset</a></li>
	  	</ol>
	  	
	  	<input id="context" type="hidden" value="<%=request.getContextPath()%>">
	  	
	  	<h3 class="hidden-print">Tus datasets:</h3>
        		
        		
    	<div class="row">
    		<div class="col-md-4 hidden-print">
        		<div class="panel-group" id="datasetList">
					<c:choose>
					      <c:when test="${empty datasetsu}">
					      	<div class="alert alert-warning" role="alert">Parece que no tienes ningun dataset. Prueba cargando algunos!</div>
					      </c:when>
					      <c:otherwise>
					      		<c:forEach var="data" items="${datasetsu}">
									<div class="panel panel-default">
									    <div class="panel-heading collapsed" data-toggle="collapse" data-parent="#datasetList" data-target="#<c:out value="${data.tabla}"></c:out>">
									      <h4 class="panel-title accordion-toggle" >
									        <c:out value="${data.nombre}"></c:out>
									      </h4>
									    </div>
									    <div id="<c:out value="${data.tabla}"></c:out>" class="panel-collapse collapse">
									      <div class="panel-body">
									      </div>
									    </div>
									</div>
								</c:forEach>
					      </c:otherwise>
					</c:choose>
				</div>
				
				
			</div>
	        
	        <div class="col-md-8">
	          
	          	<script id="tmplPnlInfo" type="text/x-jquery-tmpl">
    				<strong>Relation: </strong>${'${'}nombre}</br>
				  	<strong>Instances: </strong>${'${'}instancias}</br>
				  	<strong>Attributes: </strong>${'${'}atributos}</br>
				  	<strong>Sum of weights: </strong>${'${'}sum}</br>
					<hr>
					<strong>Descripcion: </strong>${'${'}descripcion}</br>
					<strong>Origen: </strong>${'${'}origen}</br>
				</script>
						
	     	    <div class="panel panel-primary">
					<div class="panel-heading">
				    	<h3 class="panel-title">Dataset info:</h3>
				  	</div>
				  	<div id="pnlInfo" class="panel-body" style="margin-top: 2px;margin-bottom: 2px;">
				  		<strong>Relation: </strong>Nombre de la relacion asignada al dataset</br>
				  		<strong>Instances: </strong>Numero de instancias del dataset</br>
				  		<strong>Attributes: </strong>Numero de atributos del dataset</br>
				  		<strong>Sum of weights: </strong>Suma de pesos de los atributos</br>
				  		<hr>
				  		<strong>Descripcion: </strong>Descripcion del dataset</br>
				  		<strong>Origen: </strong>Origen del dataset</br>
				  	</div>
			    </div>
			  
			  	<div class="panel panel-primary hidden-print">
					<div class="panel-heading">
				    	<h3 class="panel-title">Instancias:</h3>
				  	</div>
				  
					<div class="panel-body">
						     <div id="pnlInstances" class="table-responsive">
                                <table class="table table-striped table-condensed table-hover" id="dataInstances"></table>
                            </div><!-- /.table-responsive -->
                    </div><!-- /.panel-body -->
             	</div>
             	
             	<input type="hidden" id="stateData" value="0">
             	
             	<div class="panel panel-primary visible-print-block">
					<div class="panel-heading">
				    	<h3 class="panel-title">Instancias:</h3>
				  	</div>
				  
					<div class="panel-body">
						     <div id="pnlInstancesPrint" class="table-responsive">
                             </div><!-- /.table-responsive -->
                    </div><!-- /.panel-body -->
             	</div>
				  
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
    <script src="js/bootstrap/bootstrap.min.js"></script>
     <script src="js/fileinput.min.js" type="text/javascript"></script> 
  </body>
</html>