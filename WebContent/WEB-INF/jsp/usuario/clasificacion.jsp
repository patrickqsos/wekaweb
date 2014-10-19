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

    <title>Clasificacion de datos</title>

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
    	            text: "Classifiers", 
    	            selectable: false,
    	            nodes: [
    	            	{
    	            	  subCategoria: "true",	
    	               	  text: "Bayes",
    	               	  selectable: false,
      	                  nodes: [
    	                    {
    	                      text: "BayesNet",
    	                      className: "weka.classifiers.bayes.BayesNet",
    	                    	//className: "weka.clusterers.Cobweb",
    	                    },
    	  				    {
      	                      text: "NaiveBayes",
      	                      className: "weka.classifiers.bayes.NaiveBayes",
      	                    },
      	  					{
      	                      text: "NaiveBayesMultinomial",
      	                      className: "weka.classifiers.bayes.NaiveBayesMultinomial",
      	                    },
      	  					{
      	                      text: "NaiveBayesMultinomialText",
      	                      className: "weka.classifiers.bayes.NaiveBayesMultinomialText",
      	                    },
      	  					{
      	                      text: "NaiveBayesMultinomialUpdateable",
      	                      className: "weka.classifiers.bayes.NaiveBayesMultinomialUpdateable",
      	                    },
      	  					{
      	                      text: "NaiveBayesUpdateable",
      	                      className: "weka.classifiers.bayes.NaiveBayesUpdateable",
      	                    },
    	                  ]
    	                },
    	                {
    	                	subCategoria: "true",	
      	               	  	text: "Functions",
    	                	selectable: false,
    	      	            nodes: [
        	      	        	{
        	      	            	text: "GaussianProcesses",
        	      	                className: "weka.classifiers.functions.GaussianProcesses",
        	      	            },
        	      	          	{
        	      	            	text: "LinearRegression",
        	      	                className: "weka.classifiers.functions.LinearRegression",
        	      	            },
        	      	          	{
        	      	            	text: "Logistic",
        	      	                className: "weka.classifiers.functions.Logistic",
        	      	            },
        	      	          	{
        	      	            	text: "MultilayerPerceptron",
        	      	                className: "weka.classifiers.functions.MultilayerPerceptron",
        	      	            },
        	      	          	{
        	      	            	text: "SGD",
        	      	                className: "weka.classifiers.functions.SGD",
        	      	            },
        	      	          	{
        	      	            	text: "SGDText",
        	      	                className: "weka.classifiers.functions.SGDText",
        	      	            },
        	      	          	{
        	      	            	text: "SimpleLinearRegression",
        	      	                className: "weka.classifiers.functions.SimpleLinearRegression",
        	      	            },
        	      	          	{
        	      	            	text: "SimpleLogistic",
        	      	                className: "weka.classifiers.functions.SimpleLogistic",
        	      	            },
        	      	          	{
        	      	            	text: "SMO",
        	      	                className: "weka.classifiers.functions.SMO",
        	      	            },
        	      	          	{
        	      	            	text: "SMOreg",
        	      	                className: "weka.classifiers.functions.SMOreg",
        	      	            },
        	      	          	{
        	      	            	text: "VotedPerceptron",
        	      	                className: "weka.classifiers.functions.VotedPerceptron",
        	      	            },
        	      	        ]
    	      	        },
    	      	      	{
    	      	       	  subCategoria: "true",	
      	               	  text: "Lazy",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                      text: "IBk",
	      	                      className: "weka.classifiers.lazy.IBk",
	      	                    },
	      	                    {
		      	                  text: "KStar",
		      	                  className: "weka.classifiers.lazy.KStar",
		      	                },
		      	                {
			      	              text: "LWL",
			      	              className: "weka.classifiers.lazy.LWL",
			      	            },
      	                  	  ]
      	                },
      	              	{
      	               	  subCategoria: "true",	
      	               	  text: "Meta",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                    	text: "AdaBoostM1",
	      	                    	className: "weka.classifiers.meta.AdaBoostM1",
	      	                    },
	      	                    {
	      	                    	text: "AdditiveRegression",
	      	                    	className: "weka.classifiers.meta.AdditiveRegression",
	      	                    },
	      	                  	{
	      	                    	text: "AttributeSelectedClassifier",
	      	                    	className: "weka.classifiers.meta.AttributeSelectedClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "Bagging",
	      	                    	className: "weka.classifiers.meta.Bagging",
	      	                    },
	      	                  	{
	      	                    	text: "ClassificationViaRegression",
	      	                    	className: "weka.classifiers.meta.ClassificationViaRegression",
	      	                    },
	      	                  	{
	      	                    	text: "CostSensitiveClassifier",
	      	                    	className: "weka.classifiers.meta.CostSensitiveClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "CVParameterSelection",
	      	                    	className: "weka.classifiers.meta.CVParameterSelection",
	      	                    },
	      	                  	{
	      	                    	text: "FilteredClassifier",
	      	                    	className: "weka.classifiers.meta.FilteredClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "LogitBoost",
	      	                    	className: "weka.classifiers.meta.LogitBoost",
	      	                    },
	      	                  	{
	      	                    	text: "MultiClassClassifier",
	      	                    	className: "weka.classifiers.meta.MultiClassClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "MultiClassClassifierUpdateable",
	      	                    	className: "weka.classifiers.meta.MultiClassClassifierUpdateable",
	      	                    },
	      	                  	{
	      	                    	text: "MultiScheme",
	      	                    	className: "weka.classifiers.meta.MultiScheme",
	      	                    },
	      	                  	{
	      	                    	text: "RandomCommittee",
	      	                    	className: "weka.classifiers.meta.RandomCommittee",
	      	                    },
	      	                  	{
	      	                    	text: "RandomizableFilteredClassifier",
	      	                    	className: "weka.classifiers.meta.RandomizableFilteredClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "RandomSubSpace",
	      	                    	className: "weka.classifiers.meta.RandomSubSpace",
	      	                    },
	      	                  	{
	      	                    	text: "RegressionByDiscretization",
	      	                    	className: "weka.classifiers.meta.RegressionByDiscretization",
	      	                    },
	      	                  	{
	      	                    	text: "Stacking",
	      	                    	className: "weka.classifiers.meta.Stacking",
	      	                    },
	      	                  	{
	      	                    	text: "Vote",
	      	                    	className: "weka.classifiers.meta.Vote",
	      	                    },
	      	                  ]
      	                },
      	              	{
      	               	  subCategoria: "true",	
      	               	  text: "Misc",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                    	text: "InputMappedClassifier",
	      	                    	className: "weka.classifiers.misc.InputMappedClassifier",
	      	                    },
	      	                    {
		      	                    text: "InputMappedClassifier",
									className: "weka.classifiers.misc.InputMappedClassifier",
		      	                },
	      	                  ]
      	                },
      	              	{
      	               	  subCategoria: "true",	
      	               	  text: "Rules",
      	               	  selectable: false,
        	                  nodes: [
	      	                  	{
	      	                    	text: "DecisionTable",
	      	                    	className: "weka.classifiers.rules.DecisionTable",
	      	                    },
	      	                  	{
	      	                    	text: "JRip",
	      	                    	className: "weka.classifiers.rules.JRip",
	      	                    },
	      	                  	{
	      	                    	text: "M5Rules",
	      	                    	className: "weka.classifiers.rules.M5Rules",
	      	                    },
	      	                  	{
	      	                    	text: "OneR",
	      	                    	className: "weka.classifiers.rules.OneR",
	      	                    },
	      	                  	{
	      	                    	text: "PART",
	      	                    	className: "weka.classifiers.rules.PART",
	      	                    },
	      	                  	{
	      	                    	text: "ZeroR",
	      	                    	className: "weka.classifiers.rules.ZeroR",
	      	                    },
	      	                  ]
      	                },
      	             	{
      	                  subCategoria: "true",	
      	               	  text: "Trees",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                    	text: "DecisionStump",
	      	                    	className: "weka.classifiers.trees.DecisionStump",
	      	                    },
	      	                  	{
	      	                    	text: "HoeffdingTree",
	      	                    	className: "weka.classifiers.trees.HoeffdingTree",
	      	                    },
	      	                  	{
	      	                    	text: "J48",
	      	                    	className: "weka.classifiers.trees.J48",
	      	                    },
	      	                  	{
	      	                    	text: "LMT",
	      	                    	className: "weka.classifiers.trees.LMT",
	      	                    },
	      	                  	{
	      	                    	text: "M5P",
	      	                    	className: "weka.classifiers.trees.M5P",
	      	                    },
	      	                  	{
	      	                    	text: "RandomForest",
	      	                    	className: "weka.classifiers.trees.RandomForest",
	      	                    },
	      	                  	{
	      	                    	text: "REPTree",
	      	                    	className: "weka.classifiers.trees.REPTree",
	      	                    },
	      	                  ]
      	                },
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
	           			action: 'asociacion',
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
  			<h1>Clasificacion</h1>
		</div>
	  	
	  	<ol class="breadcrumb hidden-print">
			<li><a href="<%=request.getContextPath()%>/Main?action=index">Home</a></li>
			<li>Datasets</li>
			<li class="active"><a href="<%=request.getContextPath()%>/Main?action=clasificacion">Clasificacion</a></li>
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