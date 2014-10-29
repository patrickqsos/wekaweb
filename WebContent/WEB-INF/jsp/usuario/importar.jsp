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
    <link rel="icon" href="images/favicon.ico">

    <title>Importar dataset</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap/font-awesome.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/bootstrap/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
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
    
	<script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery.tmpl.min.js"></script>
	
    <script type="text/javascript">
    	
		$(document).ready(function() {
			$('#uploadResult').hide();
			$('#uploadResultUrl').hide();
			
			$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	        });
			
			$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
				$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	        });
				
			$('#form').submit(function(){
				event.preventDefault();
			
				var formData = new FormData();
			    formData.append('file', $('#uploadFile')[0].files[0]);
			    formData.append("descripcion", $('#descripcion').val());
			    formData.append("idUsuario", $('#idUsuario').val());
			    
			    var context = $("#context").val();
			    context += "/Dataset"; 
			    $("#files").append($("#fileUploadProgressTemplate").tmpl());
			    $("#fileUploadError").addClass("hide");
			    
			    $.ajax({
			        url: context,
			        type: 'POST',
			        xhr: function() {
			            var xhr = $.ajaxSettings.xhr();
			            if (xhr.upload) {
			                xhr.upload.addEventListener('progress', function(evt) {
			                    var percent = (evt.loaded / evt.total) * 100;
			                    $("#files").find(".progress-bar").width(percent + "%");
			                }, false);
			            }
			            return xhr;
			        },
			        success: function(data) {
			        	$('#uploadResult').removeClass( "alert-danger" ).addClass( "alert-success" );
			        	$('#message').text("El dataset se importo exitosamente");
				        $('#uploadResult').show();
			            $("#files").children().last().remove();
			            //$("#files").append($("#fileUploadItemTemplate").tmpl(data));
			            $("#uploadFile").closest("form").trigger("reset");
			            $('#datasetList .alert-warning').hide();
			        	$('#tmplDataset').tmpl(data).appendTo('#datasetList');
			        	//$('.collapse').collapse();
			        },
			        error: function(data) {
			        	$('#uploadResult').removeClass( "alert-success" ).addClass( "alert-danger" );
			        	$('#message').text(data.responseText);
			        	$('#uploadResult').show();
			            $("#files").children().last().remove();
			            $("#uploadFile").closest("form").trigger("reset");
			        },
			        data: formData,
			        cache: false,
			        contentType: false,
			        processData: false
			    }, 'json');
			});

			$("#inputUrl").blur(function(){
			    var url = $("#inputUrl").val();
			    var aux = url.split("/");
			    $("#nombreUrl").val(aux[aux.length - 1]);
			  });
			
			$('#importUrl').click(function () {
			    var btn = $(this)
			    btn.button('loading')
			    var nombre = $('#nombreUrl').val();
			    var descripcion = $('#descripcionUrl').val();
			    var url = $('#inputUrl').val();
			    var idUsuario = $('#idUsuario').val();
			    $.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		data: {
	           			action: 'uploadUrl',
	           			nombre: nombre,
	           			descripcion: descripcion,
	           			url: url,
	           			idUsuario: idUsuario,
	           		},
	           	 	success: function(data){
	           			$('#uploadResultUrl').removeClass( "alert-danger" ).addClass( "alert-success" );
			        	$('#messageUrl').text("El dataset se importo exitosamente");
				        $('#uploadResultUrl').show();
			        	btn.button('reset');
			        	$('#nombreUrl').val('');
			        	$('#descripcionUrl').val('');
			        	$('#inputUrl').val('');
			        	$('#datasetList .alert-warning').hide();
			        	$('#tmplDataset').tmpl(data).appendTo('#datasetList');
	           		},
	           		error: function(){
	           			$('#uploadResultUrl').removeClass( "alert-success" ).addClass( "alert-danger" );
			        	$('#messageUrl').text("Hubo un problema con la carga del dataset. Vuelve a intentarlo" );
			        	$('#uploadResultUrl').show();
			        	btn.button('reset');
			   		}
	           	});
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
          <img src='images/cloud3.png' class='img-responsive' style="float: left; width: 50px; display: inline-block;padding-right: 5px;"/>
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
  			<h1>Importar datasets</h1>
		</div>
	  	
	  	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li>Datasets</li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=importar">Importar</a></li>
	  	</ol>
	  	
	  	<input id="context" type="hidden" value="<%=request.getContextPath()%>">
	  	
    	<div class="row">
    		<div class="col-md-4">
        		<h3>Tus datasets:</h3>
				<script id="tmplDataset" type="text/x-jquery-tmpl">
    					<div class="panel panel-success">
							<div class="panel-heading collapsed" data-toggle="collapse" data-parent="#accordion" data-target="#${'${'}tabla}">
								<h4 class="panel-title">
									${'${'}nombre}
								</h4>
							</div>
							<div id="${'${'}tabla}" class="panel-collapse collapse in">
								<div class="panel-body">
									<ul class="list-group">
										<li class="list-group-item"><strong>Descripcion: </strong>${'${'}descripcion}</li>
										<li class="list-group-item"><strong>Origen: </strong>${'${'}origen}</li>
									</ul>
								</div>
							</div>
						</div>
				</script>
				
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
	          <h3>Seleccionar dataset:</h3>
	          <div class="panel panel-primary">
				  <div class="panel-heading">Desde tu computadora</div>
				  <div class="panel-body">
				  	<div class="alert alert-dismissible" role="alert" id="uploadResult">
					  <button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>
					</div>
				  	
				  	<form id="form">
					  	<div class="form-group">
					    	<input id="uploadFile" type="file" class="file" data-show-preview="false">
					    </div>
					    <div class="form-group">	
					    	<label for="descripcion">Descripcion</label>
        			    	<textarea id="descripcion" name="descripcion" class="form-control" rows="3" placeholder="Descripcion del dataset"></textarea>
		            	</div>
		            	<input type="hidden" id="idUsuario" name="idUsuario" value="<jsp:getProperty property="id" name="usuario"/>" >
					    <hr>
				 	</form>
				 	
				 	<div class="list-group" id="files"></div>
					
					<script id="fileUploadProgressTemplate" type="text/x-jquery-tmpl">
    					<div class="list-group-item">
     					   <div class="progress progress-striped active">
   					         <div class="progress-bar progress-bar-info" style="width: 0%;"></div>
   					 	   </div>
   						</div>
					</script>
							
					<script id="fileUploadItemTemplate" type="text/x-jquery-tmpl">
    					<div class="list-group-item">
        					<button type="button" class="close">&times;</button>
        						<span class="glyphicon glyphicon-file"></span> File name (type, date, etc)
    					</div>
					</script>


				  </div>
			  </div>
				
			  <div class="panel panel-primary">
				  <div class="panel-heading">
				    <h3 class="panel-title">Desde una url</h3>
				  </div>
				  <div class="panel-body">
				  	<div class="alert alert-dismissible" role="alert" id="uploadResultUrl">
					  <button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="messageUrl">message</span>
					</div>
					
				   <div class="form-group">	
				   		<div class="form-group">
					    	<label for="nombreUrl">Nombre</label>
	        				<input type="text" class="form-control" id="nombreUrl" placeholder="Nombre del dataset" >	
					    </div>
					    <div class="form-group">
					    	<label for="descripcionUrl">Descripcion</label>
	        				<textarea id="descripcionUrl" name="descripcionUrl" class="form-control" rows="2" placeholder="Descripcion del dataset"></textarea>
			            </div>
					    <div class="input-group">
					      <span class="input-group-addon "><span class="glyphicon glyphicon-cloud"></span></span>
						  <input type="text" id="inputUrl" class="form-control" placeholder="http://">
					      <span class="input-group-btn">
					        <button type="button" id="importUrl" data-loading-text="Importando..." class="btn btn-success">Importar</button>
					      </span>
					    </div><!-- /input-group -->
				    </div>
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