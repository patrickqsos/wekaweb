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

    <title>Exportar dataset</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap/font-awesome.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/bootstrap/bootstrap-combobox.css" rel="stylesheet">
    <link href="css/bootstrap/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery.tmpl.min.js"></script>
	
	<style type="text/css">
    	/* CSS Method for adding Font Awesome Chevron Icons */
		 .accordion-toggle:after {
		    /* symbol for "opening" panels */
		    font-family:'FontAwesome';
		    content:"\f077";
		    float: right;
		    color: inherit;
		}
		.panel-heading.collapsed .accordion-toggle:after {
		    /* symbol for "collapsed" panels */
		    content:"\f078";
		}
    </style>
    
    <script type="text/javascript">
    
    $(document).ready(function() {
			$('#msgExport').hide();
			
			$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	        });
			
			$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
				$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	        });
			
			$(".panel-heading").on('click', function() {
				var dataset = $(this).attr("data-target");
				dataset = dataset.replace('#','');
				$('#dataset').val(dataset);
				//var inputArchivo = $(this).text();
				$('#inputArchivo').val($('> .panel-title', this).text());
				$.ajax({
               		type: 'post',
               		url: 'Dataset',
               		data: {
               			action: 'getInfoDataset',
               			typeInfo: 'dataExport',
                        dataset:dataset,
               		},
               	 	beforeSend: function(){
               			//vaciamos el div que contiene el resumen del dataset
               	 		$('#pnlInfo').empty();
               			$('#pnlInfo').append("<img src='images/loading2.gif'/>");
               	    },
               		success: function(data){
               			$('#pnlInfo').empty(); 
               			$('#tmplPnlInfo').tmpl(data).appendTo('#pnlInfo');
               		},
               		error: function(){
               			$('#pnlInfo').html('Error en la carga del dataset...');
               		}
               	}); 	
			});
			
			$('.typeFile').on('click', function() {
				var flag = true;
				var messageError = '';
				var context =$('#context').val();
				$('#btnExportar').button('loading');
				//alert("exportando..."+$(this).attr('id'));
				var nombreArchivo = $('#inputArchivo').val();
				var dataset = $('#dataset').val();
				var extension = $(this).attr('id');
				
				if(dataset == ''){
					messageError+='Primero debe seleccionar un dataset'+'\n';
					flag = false;
		      	}
				
				if(nombreArchivo == ''){
					messageError+='El nombre del archivo no pueda estar vacio'+'\n';
		        	flag = false;
		      	}
				
				if(flag){
					$.ajax({
		           		type: 'post',
		           		url: 'Dataset',
		           		data: {
		           			action: 'export',
		           			typeExport: 'normal',
		           			typeInfo: 'dataExport',
		           			nombreArchivo: nombreArchivo,
		           			dataset: dataset,
		           			extension: extension,
		           		},
		           	 	success: function(response, status, request){
		           	 		var disp = request.getResponseHeader('Content-Disposition');
				        	
				        	if (disp && disp.search('attachment') != -1) {
				                var form = $('<form method="POST" action="'+context+'/Dataset">');
				                    form.append($('<input type="hidden" name="action" value="export">'));
				                    form.append($('<input type="hidden" name="typeExport" value="normal">'));
				                    form.append($('<input type="hidden" name="nombreArchivo" value="'+nombreArchivo+'">'));
				                    form.append($('<input type="hidden" name="extension" value="'+extension+'">'));
				            //        form.append($('<input type="hidden" name="dataset" value="'+dataset+'">'));
				                $('body').append(form);
				                form.submit();
				            }
				        	$('#btnExportar').button('reset');
						},
		           		error: function(){
		           			alert("error");
		           			$('#btnExportar').button('reset');
			       		}
		           	});
				}
				else{
					$('#msgExport').removeClass( "alert-success" ).addClass( "alert-danger" );
					$('#message').text(messageError);
		        	$('#msgExport').show();
		        	$('#btnExportar').button('reset');
			    }
			  });
		});
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
  			<h1>Exportar datasets</h1>
		</div>
	  	
	  	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li><a href="#">Datasets</a></li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=exportar">Exportar</a></li>
	  	</ol>
	  	
	  	<input id="context" type="hidden" value="<%=request.getContextPath()%>">
	  	
	  	<h3>Tus datasets:</h3>
        		
        		
    	<div class="row">
    		<div class="col-md-4">
        		<div class="panel-group" id="datasetList">
					<c:choose>
					      <c:when test="${empty datasetsu}">
					      	<div class="alert alert-warning" role="alert">Parece que no tienes ningun dataset. Prueba cargando algunos!</div>
					      </c:when>
					      <c:otherwise>
					      		<c:forEach var="data" items="${datasetsu}">
									<div class="panel panel-default">
									    <div class="panel-heading collapsed" data-toggle="collapse" data-parent="#datasetList" data-target="#<c:out value="${data.tabla}"></c:out>">
									      <h4 class="panel-title accordion-toggle"><c:out value="${data.nombre}"></c:out></h4>
									    </div>
									    <div id="<c:out value="${data.tabla}"></c:out>" class="panel-collapse collapse">
									      <div class="panel-body">
									      	<ul class="list-group">
											  <li class="list-group-item"><strong>Descripcion: </strong><c:out value=" ${data.descripcion}"></c:out></li>
											  <li class="list-group-item"><strong>Origen: </strong><c:out value="${data.origen}"></c:out></li>
											</ul>
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
				  </div>
			  </div>
			  
			  <div class="panel panel-primary">
				  <div class="panel-heading">
				    <h3 class="panel-title">Exportar como:</h3>
				  </div>
				  <div class="panel-body">
						<div class="alert alert-dismissible alert-danger" role="alert" id="msgExport">
							<button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>
						</div>
			
				  	    <div class="input-group">
					      <span class="input-group-addon "><span class="glyphicon glyphicon-file"></span></span>
						  <input type="text" id="inputArchivo" class="form-control" placeholder="Nombre del archivo">
					      <input type="hidden" id="dataset" >
					      <div class="input-group-btn">
					        <button type="button" id="btnExportar" data-loading-text="Exportando..." class="btn btn-success dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-download"></span> Exportar como <span class="caret"></span></button>
					        <ul class="dropdown-menu dropdown-menu-right" role="menu">
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
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
				  </div>
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