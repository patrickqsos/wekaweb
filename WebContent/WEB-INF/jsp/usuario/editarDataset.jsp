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
		
		tr.odd.selected {
		background-color: #abb9d3;
		}
		
		tr.even.selected {
		background-color: #abb9d3;
		}
		
		tr{
		cursor: pointer;
		}

    </style>
    
    <script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery.tmpl.min.js"></script>
	<script src="js/jquery.dataTables.js"></script>
    <script src="js/dataTables.bootstrap.js"></script>
	<script src="js/dataTables.tableTools.js"></script>
	<script src="js/validator.min.js"></script>
    
	
    <script type="text/javascript">
 
    //$.fn.dataTable.TableTools.defaults.aButtons = [ "copy", "csv", "xls" ];

    
    
    $.fn.dataTable.TableTools.buttons.saveData = $.extend(
    	    true,
    	    $.fn.dataTable.TableTools.buttonBase,
    	    {
    	        "sNewLine":    "<br>",
    	        "sButtonText": "Guardar",
    	        "target":      "",
    	        "fnClick": function() {
    	            //$(conf.target).html( this.fnGetTableData(conf) );
    	            $.ajax({
    	            	type: 'post',
    	            	url: 'Dataset',
    	            	data:{
    	            		action: 'instance',
    	            		type: 'save'
    	            	},
    	            	success: function(data){
    	            		alert(data);
    	            		$('#stateData').val('0');
			               	
    	            	},
    	            	error: function(data){
    	            		alert(data.responseText);
    	            	}
    	            })
    	        }
    	    }
    	);
    
   
	 
    window.onbeforeunload = confirmExit;
    function confirmExit()
    {
    	if($('#stateData').val() != 0)	
      		return "Parece que realizo cambios en el dataset y no presiono el boton \"Guardar\", sus cambios se perderan.  Esta seguro que quiere dejar la pagina?";
    	
    }
    
    $(document).ready(function() {
			
    	
    	
			$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
				$('> .panel-collapse > .panel-body',this).empty();
				$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
			});
			
			$('#datasetList > .panel').on('show.bs.collapse', function() {
				var dataset = $('> .panel-heading',this).attr("data-target");
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
				dataset = dataset.replace('#','');
				$('#dataset').val(dataset);
				$('#inputArchivo').val($('> .panel-title', this).text());
				$.ajax({
               		type: 'post',
               		url: 'Dataset',
               		data: {
               			action: 'getInfoDataset',
               			typeInfo: 'dataEdit',
                        dataset:dataset,
               		},
               	 	beforeSend: function(){
               			//vaciamos el div que contiene el resumen del dataset
               	 		$('#pnlInfo').empty();
               			$('#pnlInfo').append("<img src='images/loading2.gif' class='img-responsive center-block' alt='Responsive imag'/>");
               			$('#pnlInstances').append("<img src='images/ajax-loader.gif' class='img-responsive center-block' alt='Responsive imag'/>");
                   		
               	    },
               		success: function(json){
               			//se llena el panel Dataset Info
               			$('#pnlInfo').empty(); 
               			$('#tmplPnlInfo').tmpl(json).appendTo('#pnlInfo');
               			
               			//se llena la tabla que contienes a las instancias
               			var newTable = ' <table class="table table-condensed table-hover tableDT"><thead><tr>'; //start building a new table contents
               			for (var int = 0; int < json.dataset.header.attributes.length; int++) {
               				newTable += "<th>" + json.dataset.header.attributes[int].name + "</th>";
                   		}
               			newTable += "</tr></thead><tbody>";                  
							
               			for (var int = 0; int < json.dataset.data.length; int++) {
               			 	newTable += "<tr>";
               				for (var j = 0; j< json.dataset.data[int].values.length; j++) {
                   				newTable += "<td>" + json.dataset.data[int].values[j] + "</td>";
                   			}
               			 	newTable += "</tr>";
               			}
               			newTable += '</tbody></table>';
               			$('#pnlInstances').html(newTable);
               			
               			$('#pnlInstancesPrint').html(newTable);
               			$('#pnlInstancesPrint > table').removeClass('tableDT');
               			
               			
               			//se da formato a la tabla usando el plugin dataTable
               			table = $('.tableDT').DataTable( {
						        "language": {
						            "lengthMenu": "Mostrar _MENU_ instancias por pagina",
						            "zeroRecords": "Ninguna instancia encontrada",
						            "info": "Mostrando _START_ a _END_ de _TOTAL_ instancias",
						            "infoEmpty": "Mostrando 0 a 0 de 0 instancias",
						            "infoFiltered": "(filtradas de _MAX_ instancias)",
						            "search": "Buscar",
						            "paginate": {
						        		"first":    "Primero",
						        		"previous": "Anterior",
						        		"next":     "Siguiente",
						        		"last":     "Ultimo"
						        	}
						        },
						        "scrollX": true,
						        //dom: 'T<"clear">lfrtip'
						        dom: 'flT<"clear">tip',
						        tableTools: {
						            "sSwfPath": "js/swf/copy_csv_xls_pdf.swf",
						            "aButtons": [ 
										"copy",
										
						            	{
						            		"sExtends":    "saveData",
						                	"sButtonText": "Guardar",
						                	"target":      "#"
						            	},
						            	{
						                    "sExtends": "print",
						                    "sButtonText": "Imprimir",
						                    "fnClick": function( nButton, oConfig ) {
						                    	//this.fnPrint( true, oConfig );
						                    	window.print();
						                    }
						                },
									]
						        }
						      	//dom: '<"top"T>rt<"bottom"flp><"clear">'
						    });
               		
	               		
	               		//se arma el formulario de instancias
	               		var newForm = '';
	               		
	               		newForm += '<label for="classAttr">Atributo clase</label>';
           				
	               		newForm += '<select id="classAttr" class="form-control input-sm">';
	               		if(json.classIndex < 0){
	               			newForm += '<option value="-1" selected="selected">No class</option>';
		               	}
	               		else{
	               			newForm += '<option value="-1">No class</option>';
	               		}
	               		for(var j=0;j<json.dataset.header.attributes.length; j++){
	               			if(json.classIndex == j){
	               				newForm += '<option selected="selected" value="'+j+'">'+json.dataset.header.attributes[j].name+'</option>';
	               			}
	               			else{
	               				newForm += '<option value="'+j+'">'+json.dataset.header.attributes[j].name+'</option>';
		               		}
	               		}
	               		newForm += '</select>';	
           				newForm += '<hr>';
	               		
           				newForm += '<form role="form">';
	               		
	               		newForm += '<div class="alert alert-dismissible alert-danger hidden" role="alert" id="msgEditDataset">'+
						'<button id="btnClose" type="button" class="close" onclick="$(\'.alert\').addClass(\'hidden\')"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>'+
						'</div>';
						
	               		
	               		for(var j=0;j<json.dataset.header.attributes.length; j++){
	               			newForm += '<div class="form-group">';
	               			
	               			newForm += '<label for="inputAttr'+j+'">'+json.dataset.header.attributes[j].name+'</label>';
	           				
	               			switch(json.dataset.header.attributes[j].type){
	               			
	               			case 'nominal': 
	               				newForm += '<select id="inputAttr'+j+'" class="form-control input-sm">';
	               				for(var k=0;k<json.dataset.header.attributes[j].labels.length; k++){
	               					newForm += '<option value="'+json.dataset.header.attributes[j].labels[k]+'">'+json.dataset.header.attributes[j].labels[k]+'</option>';
	               				}
	                           	newForm += '</select>';	
	               				break;
	               			case 'numeric':
	               				newForm += '<input id="inputAttr'+j+'" class="form-control input-sm" type="number" >';
	               				break;
	               			case 'string':
	               				newForm += '<input id="inputAttr'+j+'" class="form-control input-sm" type="text" >';
	               				break;
	               			case 'date':
	               				alert('attribute date input not supported yet');
	               				break;
	               			}
	               			newForm += '</div>';
	               		}
	               		newForm += '</form>';
	               		
	               		//se agrega el bntTollbar
	               		newForm += '<div id="btnToolbar" class="btn-toolbar pull-right">'+
						'<button type="button" class="btn btn-success btn-sm btnAdd">'+
						  '<span class="glyphicon glyphicon-plus"></span> Agregar'+
						'</button>'+
						'<button type="button" class="btn btn-primary btn-sm btnUpdate">'+
						  '<span class="glyphicon glyphicon-refresh"></span> Actualizar'+
						'</button>'+
						'<button type="button" class="btn btn-danger btn-sm btnDelete">'+
						  '<span class="glyphicon glyphicon-trash"></span> Eliminar'+
						'</button>'+
						'</div>';
						
						//se agrega el formulario de adicion/edicion de instancias
	               		$('#datasetList > .panel-primary > .panel-collapse > .panel-body').html(newForm);
	               		
	               		$('.btnTest').on('click',function(){
	               			var test = table.data();
	               			console.log(test);
	               		})
	               		
	               		$('#classAttr').on('change', function () {
	               			//alert($(this).val());
	               			$.ajax({
			               		type: 'post',
			               		url: 'Dataset',
			               		data: {
			               			action: 'updateClassIndex',
			               			//dataset: 'delete',
			               			classIndex: $(this).val()
			               			//index: index,
			               		},
			               		success: function(data){
			               	    	alert(data);
			               		},
			               	    error: function(data){
			               	    	alert(data.responseText);
			               	    }
	               			})
	               		});
	               	    //se agrega el evento al boton eliminar 
	               		$('.btnDelete').on('click', function () {
	               			//var deleteInstance = table.row('.selected').data();
	               			var index  = table.row('.selected').index();
	               			
	               			$.ajax({
			               		type: 'post',
			               		url: 'Dataset',
			               		data: {
			               			action: 'instance',
			               			type: 'delete',
			               		//	deleteInstance: deleteInstance,
			               			index: index,
			               		},
			               	 	beforeSend: function(){
			               			//vaciamos el div que contiene el resumen del dataset
			               	 		//$('#pnlInfo').empty();
			               			//$('#pnlInfo').append("<img src='images/loading2.gif'/>");
			               	    },
			               	    success: function(data){
			               	    	$('#message').text(data);
			               	    	$('#msgEditDataset').removeClass( "alert-danger hidden" ).addClass( "alert-success" );
						        	table.row('.selected').remove().draw( false );
			               	    	$('#datasetList > .panel-primary > .panel-collapse > .panel-body > form').trigger("reset");
				                	$('#stateData').val('1');
			               	    },
			               	    error: function(data){
			               	    	$('#message').text(data.ResponseText);
			               	    	$('#msgEditDataset').removeClass( "alert-success hidden" ).addClass( "alert-danger" );
						   	    }
	               	     	});
	                	});
	               		
	               	    //se agrega el evento al boton Agregar
	               		$('.btnAdd').on( 'click', function () {
	               	        
	               	 		//creando array de inputs para el servidor
	               	 		var newInstance = [];
	               	 		$('#datasetList > .panel-primary > .panel-collapse > .panel-body form input, form select').each(
	               				    function(index){  
	               				        var input = $(this);
	               				        newInstance.push($(this).val());
	               				        //alert('Type: ' + input.attr('type') + ' Name: ' + input.attr('id') + ' Value: ' + input.val());
	               				    	//console.log($(this).val());
	               				    }
	               			);
	               	 		
	               			//agregando la nueva instancia al dataset en session
	               	        $.ajax({
			               		type: 'post',
			               		url: 'Dataset',
			               		data: {
			               			action: 'instance',
			               			type: 'add',
			               			newInstance: newInstance,
			                        //dataset:dataset,
			               		},
			               	 	beforeSend: function(){
			               			//vaciamos el div que contiene el resumen del dataset
			               	 		//$('#pnlInfo').empty();
			               			//$('#pnlInfo').append("<img src='images/loading2.gif'/>");
			               	    },
			               	    success: function(data){
			               	    	$('#message').text(data);
			               	    	$('#msgEditDataset').removeClass( "alert-danger hidden" ).addClass( "alert-success" );
						        	table.row.add(newInstance).draw();
						        	$('#stateData').val('1');
				               	},
			               	    error: function(data){
			               	 		$('#message').text(data.ResponseText);
		               	    		$('#msgEditDataset').removeClass( "alert-success hidden" ).addClass( "alert-danger" );
					   	    	}
	               	     	});
	               			
	               	    });
	               		
	               	    $('.btnUpdate').on('click',function(){
	               	    	var updateInstance = [];
	               	 		$('#datasetList > .panel-primary > .panel-collapse > .panel-body form input, form select').each(
	               				    function(index){  
	               				     	updateInstance.push($(this).val());
	               				    }
	               			);	
	               	 
	               	 		var index  = table.row('.selected').index();
	               			console.log("index: "+index);
	               			$.ajax({
			               		type: 'post',
			               		url: 'Dataset',
			               		data: {
			               			action: 'instance',
			               			type: 'update',
			               			updateInstance: updateInstance,
			               			index: index,
			               		},
			               	 	beforeSend: function(){
			               			//vaciamos el div que contiene el resumen del dataset
			               	 		//$('#pnlInfo').empty();
			               			//$('#pnlInfo').append("<img src='images/loading2.gif'/>");
			               	    },
			               	    success: function(data){
			               	    	$('#message').text(data);
			               	    	$('#msgEditDataset').removeClass( "alert-danger hidden" ).addClass( "alert-success" );
						        	table.row('.selected').data(updateInstance).draw( false );
						        	$('#stateData').val('1');
				               	},
			               	    error: function(data){
			               	 		$('#message').text(data.ResponseText);
		               	    		$('#msgEditDataset').removeClass( "alert-success hidden" ).addClass( "alert-danger" );
					   	    	}
	               	     	});
	               	    })
	               		
	                 	//se agrega el evento click a cualquier fila
	              		$('table').on( 'click', 'tr', function () {
	    				     if ( $(this).hasClass('selected') ) {
				                 $(this).removeClass('selected');
				             }
				             else {
				             	 var aux = 0;
				                 table.$('tr.selected').removeClass('selected');
				                 $(this).addClass('selected');
				                 var currentInstance = table.row('.selected').data();
				                  //se agregan los valores de la fila seleccionada al formulario creado en el panel de datasets
				                 $('#datasetList > .panel-primary > .panel-collapse > .panel-body form input, form select').each(
			               			function(index){  
			               				$(this).val(currentInstance[aux]);
			               				aux++;
			               			}
			               		 );
				                  
				                 var index  = table.row('.selected').index();
			               			
				                 console.log(index);
				             }
				         });
	               		
	               	},
               		error: function(){
               			$('#pnlInfo').html('Error en la carga del dataset...');
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