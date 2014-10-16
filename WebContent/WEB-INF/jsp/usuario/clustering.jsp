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

    <title>Clustering de datos</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap/font-awesome.css" rel="stylesheet">
	
    <!-- Custom styles for this template -->
    <link href="css/bootstrap/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/bootstrap/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <script src="js/jquery.tmpl.min.js"></script>
	<script src="js/bootstrap-treeview.js"></script>
    
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
   	 function getTree() {
    	var tree = [
    	            {
    	            text: "Clusterers", 
    	            selectable: false,
    	            nodes: [
    	            	{
    	            		text: "Canopy",
    	            		className: "weka.classifiers.rules.M5Rules",
    	            	    
    	            	},
    	            	{
    	            		text: "Cobweb",
    	            		className: "weka.clusterers.Cobweb",
    	            	},
    	            	{
    	            		text: "EM",
    	            		className: "weka.clusterers.EM",
    	            	},
    	            	{
    	            		text: "FarthestFirst",
    	            		className: "weka.clusterers.FarthestFirst",
    	            	},
    	            	{
    	            		text: "FilteredClusterer",
    	            		className: "weka.clusterers.FilteredClusterer"
    	            	},
    	            	{
    	            		text: "HierarchicalClusterer",
    	            		className: "weka.clusterers.HierarchicalClusterer"
    	            	},
    	            	{
    	            		text: "MakeDensityBasedClusterer",
    	            		className: "weka.clusterers.MakeDensityBasedClusterer"
    	            	},
    	            	{
    	            		text: "SimpleKMeans",
    	            		className: "weka.clusterers.SimpleKMeans"
    	            	}
    	            ]
    	            
    	            }
    	          ];
	    return tree;
	}
    
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
	 	
	$(document).ready(function() {
		//$('#btnImprimir').disabled();
		
		//$('.collapse').collapse();
		
		$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	        });
			
		$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
			$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	    });
			
		$('#msgAlgoritmo').hide();
		$('#msgGenerated').hide();
		
		$('#treeAlgoritmos').treeview({data: getTree(),levels:2,showTags: true});
		
		$('#treeDatasets').treeview({data: getTreeDatasets(),levels:1,showTags: true});
		
		$('#treeAlgoritmos').on('nodeSelected', function(event, node) {
		    
			var algoritmo = node.className;
		    $('#inputAlgoritmo').val(algoritmo);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'getFullInfoAlgoritmo',
           			algoritmo: algoritmo,
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		$('#pnlInfoAlgoritmo').empty();
           	 		//$('#pnlData').empty();
       				$('#pnlInfoAlgoritmo').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           	    },
           	 	success: function(data){
           	 		$('#pnlInfoAlgoritmo').empty();
           	 		//$('#pnlData').empty();
       	        	//$('#tmplPnlInfoDataset').tmpl(data).appendTo('#pnlInfoDataset');
		        	//$('#tmplPnlData').tmpl(data).appendTo('#pnlData');
		        	//$('#pnlDataOutput').hide();
		        	$('#pnlInfoAlgoritmo').html(data);
		        
		        	
		        	
		        	$('#btnImprimir').prop('disabled', true);
					$('#btnImportar').prop('disabled', true);
					$('#btnExportar').prop('disabled', true);
					
           	 	},
           		error: function(){
           			btn.button('reset');
		     	}
           	});
		});
		
		$('#treeDatasets').on('nodeSelected', function(event, node) {
		    
			var algoritmos = [];
			var tree = getTree();
			var div = $('#treeAlgoritmos');
			var aux = $("#treeAlgoritmos").data("plugin_treeview");
			//console.log(aux);
			$.each(aux.nodes, function addNodes(id, node) {
				if(node.className != undefined)
					algoritmos.push(node.className);
			});

			
			//console.log(aux.nodes);
			console.log(algoritmos);
		    var dataset = node.dataset;
		    $('#inputDataset').val(dataset);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		//dataType: 'JSON',
           		data: {
           			action: 'getCapabilities',
           			dataset: dataset,
           			algoritmos: algoritmos,
           			tree: JSON.stringify(tree),
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		//$('#pnlInfoDataset').empty();
           	 		//$('#pnlData').empty();
       				//$('#pnlInfoDataset').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           	    },
           	 	success: function(data){
           	 	 	
           	 		$('#treeAlgoritmos').treeview({data: data,levels:2,showTags: true});
	    		
           	 		//$('#pnlInfoDataset').empty();
           	 		//$('#pnlResult').empty();
       	        	//$('#pnlDataOutput').html(data);
		        	
		        	$('#btnImprimir').prop('disabled', true);
					$('#btnImportar').prop('disabled', true);
					$('#btnExportar').prop('disabled', true);
					
           	 	},
           		error: function(){
           			btn.button('reset');
		     	}
           	});
		    
		});
		
		$('#btnStart').click(function () {
			var dataset = $('#inputDataset').val();
			var algoritmo = $('#inputAlgoritmo').val();
			
			$(this).button('loading');
			
			if(algoritmo == '' || dataset == '' ){
				$('#message').text("Selecciona un dataset y un algoritmo");
				$('#msgAlgoritmo').show();
				$('#btnStart').button('reset');
				
			}
			
			else{
				//alert($('#inputAlgoritmo').val() + ' '+$('#inputDataset').val())
				$.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		//dataType: 'JSON',
	           		data: {
	           			action: 'clustering',
	           			dataset: dataset,
	           			algoritmo: algoritmo,
	           		//	tree: JSON.stringify(tree),
	           		},
	           		beforeSend: function(){
	           			//vaciamos el div que contiene el resultado del algoritmo
	           	 		$('#pnlResult').empty();
	           	 		$('#pnlResult').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
	           	 	},
	           	 	success: function(data){
	           	 	 	
	           	 		$('#pnlResult').empty();
	       	        	$('#pnlResult').html("<pre>"+data+"</pre>");
			        	
			        	$('#btnImprimir').prop('disabled', false);
						$('#btnImportar').prop('disabled', false);
						$('#btnExportar').prop('disabled', false);
						
						$('#btnStart').button('reset');
						
	           	 	},
	           		error: function(data){
	           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
						$('#messageGen').text(data.responseText);
						$('#msgGenerated').show();
						$('#btnStart').button('reset');
						
			     	}
	           	});
			}
		});	
		
		$('#btnImprimir').click(function(){
			window.print();  
		});
		
		$('#btnImportar').click(function(){
			var nombreDataset = $('#nombreDataset').val();
			var descDataset = $('#descDataset').val();
			$(this).button('loading');
			
			$.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'importGenerated',
           			nombreDataset: nombreDataset,
           			descDataset: descDataset,
           		},
           		beforeSend: function(){
           		},
           	 	success: function(data){
           	 		$('#msgGenerated').removeClass( "alert-danger" ).addClass( "alert-success" );
					$('#messageGen').text(data);
					$('#msgGenerated').show();
					$(this).button('reset');
					
				},
           		error: function(data){
           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
					$('#messageGen').text(data.responseText);
					$('#msgGenerated').show();
					$(this).button('reset');
					
           	 	}
           	});
		});
		
		$('.typeFile').on('click', function() {
			var flag = true;
			var messageError = '';
			var context =$('#context').val();
			$('#btnExportar').button('loading');
			var nombreArchivo = $('#nombreDataset').val();
			var extension = $(this).attr('id');
			
			
			if(flag){
				$.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		data: {
	           			action: 'export',
	           			typeExport: "generated",
	           			nombreArchivo: nombreArchivo,
	           			extension: extension,
	           		},
	           	 	success: function(response, status, request){
	           	 		var disp = request.getResponseHeader('Content-Disposition');
			        	
			        	if (disp && disp.search('attachment') != -1) {
			                var form = $('<form method="POST" action="'+context+'/Dataset">');
			                    form.append($('<input type="hidden" name="action" value="export">'));
			                    form.append($('<input type="hidden" name="typeExport" value="generated">'));
			                    form.append($('<input type="hidden" name="nombreArchivo" value="'+nombreArchivo+'">'));
			                    form.append($('<input type="hidden" name="extension" value="'+extension+'">'));
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
  			<h1>Clustering</h1>
		</div>
	  	
	  	<ol class="breadcrumb hidden-print">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li>Datasets</li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=clustering">Clustering</a></li>
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
				
				<h3>Seleccionar algoritmo:</h3>
        		<div id="treeAlgoritmos"></div>
        		  
        		<input id="inputDataset" type="hidden">  
        		<input id="inputAlgoritmo" type="hidden">  
        		
        		<div class="form-group">
 		       		<button id="btnStart" data-loading-text="Trabajando..." type="button" class="btn btn-success btn-block">Start</button>
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
	          <div class="panel panel-primary hidden-print">
				  <div class="panel-heading">Info del algoritmo: </div>
				  <div id="pnlInfoAlgoritmo" class="panel-body"></div>
			  </div>
			  <div class="panel panel-primary">
				  <div class="panel-heading">Resultado:</div>
				  <div id="pnlResult" class="panel-body"></div>
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
   </body>
</html>