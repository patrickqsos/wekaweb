<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Weka Web</title>
<meta name="keywords" content="free css templates, light gray, clean, simple, professional, CSS, HTML" />
<meta name="description" content="Light Gray - Free CSS Template from templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" charset="utf-8" src="js/datatable/jquery.js"></script>
<script type="text/javascript" charset="utf-8" src="js/datatable/jquery.dataTables.js"></script>
<link href="css/datatable/demo_table_jui.css" rel="stylesheet"/>



<link href="css/themes/base/jquery-ui.css" rel="stylesheet"/>
<!-- <link href="css/themes/overcast/jquery-ui-1.10.3.custom.css" rel="stylesheet"/> -->
<script src="js/jquery-ui-1.10.3.custom.js"></script>

<script type="text/javascript" charset="utf-8" src="js/jspdf/jspdf.js"></script>
<script type="text/javascript" charset="utf-8" src="js/jspdf/jspdfhtml.js"></script>
<script type="text/javascript" charset="utf-8" src="js/jspdf/blob.js"></script>
<script type="text/javascript" charset="utf-8" src="js/jspdf/filesaver.js"></script>


<script type="text/javascript">

$(document).ready(function() {
	
	$( "#selectable" ).selectable({
		stop: function() {
			$( ".ui-selected", this ).each(function() {
				var index = $( "#selectable li" ).index( this );
				$('#algoritmo').attr('value',index+1);
               	
			});
		}
	});
	
	$("#comenzar")
		.button()
		.click(function( event ) {
			var dataset = $('#dataset').val();
			var algoritmo = $('#algoritmo').val();
			
			$.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'clustering',
                    dataset:dataset,
                    algoritmo:algoritmo,    
           		},
           	 	beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		$('#resultset').empty();
           			$('#resultset').append("<img src='images/loading2.gif'/>");
           	   },
           		success: function(data){
           			$('#resultset').empty();
           			$('#resultset').append("<pre>"+data+"</pre>");
           		},
           		error: function(){
           			$('#resultset').html('Error en la ejecucion del algoritmo...');
           		}
           	});
     		
			
		});

	$('#impr').button().click(function(){
		var ventimp=window.open(' ','popimpr');
        ventimp.document.write($("#resultset").html());
        ventimp.document.close();
        ventimp.print();
        ventimp.close();
	});
	
	$('#pdf').button().click(function(){
		var doc = new jsPDF();
		var specialElementHandlers = {
		    '#editor': function (element, renderer) {
		        return true;
		    }
		};

		    doc.fromHTML($('#resultset').html(), 15, 15, {
		        
		            'elementHandlers': specialElementHandlers
		    });
		    doc.save('sample-file.pdf');
		
	});
	
} );


$(function() {
	
	var icons = {
			header: "ui-icon-circle-arrow-e",
			activeHeader: "ui-icon-circle-arrow-s"
	};
	
	$( "#accordion" ).accordion({
		icons: icons,
		heightStyle: "content",
		//collapsible: true,
		activate: function () {
               	var dataset = $('.ui-accordion-header-active').attr('id');
               	$('#dataset').attr('value',dataset);
               	
               	/*
               	$.ajax({
               		type: 'post',
               		url: 'UsuarioRegistrado',
               		data: {
               			tipoRequest: 'cargaDataset',
                        dataset:dataset,
               		},
               	 	beforeSend: function(){
               			//vaciamos el div que contiene el resumen del dataset
               	 		$('#resultset').empty();
               			$('#resultset').append("<img src='images/loading2.gif'/>");
               			
               			
						
                   },
               		success: function(data){
               			$('#resultset').empty();
               			var json = $.parseJSON(data);
               
               			//llenamos el div de resumen del dataset
               			$('#resultset').append("<div id='resumen'>" +
               					"<fieldset>" +
               					"<legend>Current relation</legend>" +
               					"<strong>Relation: "+ json.header.relation +"</strong>"+
               					"</br>"+
               					"Instances: "+json.data.length+
               					"</br>"+
               					"Attributes: "+json.header.attributes.length+
               					"</br>"+
               					"Sum of weights: 1000"+	
               					"</fieldset>"+
               					"</div>");
               			
               			//creamos las tabs para los atributos
               				
               			for (var int = 0; int < json.header.attributes.length; int++) {
							var ul = tabs.find( "ul" );
							$( "<li><a href='#"+json.header.attributes[int].name+"'>"+json.header.attributes[int].name+"</a></li>" ).appendTo( ul );
							$( "<div id='"+json.header.attributes[int].name+"'><p>Type:"+json.header.attributes[int].type+"</br> Class:"+json.header.attributes[int].class+"</br> Weight: "+json.header.attributes[int].weight+"</p></div>" ).appendTo( tabs );
							tabs.tabs( "refresh" )
	               		}
               			
               			//Creamos la tabla html para mostrar las instancias
               			var newTable = '<thead><tr>'; //start building a new table contents
               			for (var int = 0; int < json.header.attributes.length; int++) {
               				newTable += "<th>" + json.header.attributes[int].name + "</th>";
                   		}
               			newTable += "</tr></thead>";                  
							
               			for (var int = 0; int < json.data.length; int++) {
               			 	newTable += "<tr>";
               				for (var j = 0; j< json.data[int].values.length; j++) {
                   				newTable += "<td>" + json.data[int].values[j] + "</td>";
                   			}
               			 	newTable += "</tr>";
               			}
               			//newTable += '<tbody>';
               			
               			  		 	$('#table').html(newTable);
                 	},
               		error: function(){
               			$('#resultset').html('Error en la carga del dataset...');
               		}
               	});
         		
               	
               	*/ 
                
               	
        }
		
	});
});



</script>


</head>
<body>

<div id="templatemo_body_wrapper">
<div id="templatemo_wrapper">
	    
    <div id="templatemo_header">
          <div id="site_title"><h1><a href="http://www.templatemo.com">Free CSS Templates</a></h1></div>
    </div> <!-- end of templatemo header -->
    
	<div id="templatemo_menu">
		<jsp:useBean id="usuarior" class="com.wekaweb.beans.UsuarioBean" scope="session" />
        <ul>
            <li><a href="indexUsuarioRegistrado.jsp" >Home</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Cargar" >Cargar </a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Preparar" >Preparar datos</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Clustering" class="current">Clustering</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Asociacion">Asociacion</a></li>
            <li><a href="<%=request.getContextPath()%>/Logout"><jsp:getProperty property="email" name="usuarior"/> Logout</a></li>
        </ul>    	
    </div> <!-- end of templatemo_menu -->    
        
	<div id="templatemo_main"> 
		<div class="col_w300 float_l">
        	<h2>Seleccionar dataset:</h2>
        	<div id="accordion">
				<c:forEach var="data" items="${datasetsu}">
							<h3 id="<c:out value="${data.dataset}"></c:out>">
								<c:out value="${data.dataset}"></c:out>
							</h3>
							<div>
								<c:out value="${data.descripcion}"></c:out>
							</div>
						</c:forEach>
			</div>
			
  			<div class="cleaner"></div>
  			
  			<h2>Algoritmo: </h2>
			
				<ol id="selectable">
					<li class="ui-widget-content">Simple k means</li>
					<li class="ui-widget-content">Cobweb</li>
					<li class="ui-widget-content">EM</li>
					<li class="ui-widget-content">FilteredClusterer</li>
				</ol>
			
			<button id="comenzar">Comenzar</button>
			<button id="impr">Imprimir resultados</button>
			
        </div>
        
        <div class="col_w640 float_l">
        	
     			<div class="pane-header-title-bar">Resultados</div>
			<input type="text" id="dataset" value="" readonly="readonly">
					<input type="text" id="algoritmo" value="" readonly="readonly">
				
				<div id="resultset" class="ui-widget-content ui-corner-bottom ui-corner-top" style="margin-top: 2px;margin-bottom: 2px;">
						
				</div>
				
				<div id="editor"></div>
		 		
		 		
				<!-- Container to hold the Refresh warning message -->
				<div id="pane-reload-warning-dialog"></div>
        </div>
        
    <div class="cleaner"></div>
        
	</div> <!-- end of main -->
    
    <div id="templatemo_main"> 
    
	</div>
    
    


	<div class="cleaner"></div>
    
    
    <div id="templatemo_fp_services">
    
		<div class="fp_services_box">
            <div class="fps_title"><a href="#">Preparacion de datos</a></div>
            <p>La etapa mas importante de la mineria de datos.</p>
            <a href="#" class="sb_more">Mas</a>
     	</div>
        
        <div class="fp_services_box">
            <div class="fps_title"><a href="#">Entrenamiento</a></div>
            <p>Uso de algoritmos de mineria de datos.</p>
            <a href="#" class="sb_more">Mas</a>
        </div>
        
        <div class="fp_services_box l_box">
            <div class="fps_title"><a href="#">Evaluacion</a></div>
            <p>Como interpretar los resultados.</p>
            <a href="#" class="sb_more">Mas</a>
        </div>
    
    </div> <!-- end of templatemo fp services -->
    
    
    
	<div id="templatemo_main_bottom"></div>
	<div class="cleaner"></div>
</div> <!-- end of templatemo wrapper -->
</div> <!-- end of templatemo body wrapper -->

<div id="templatemo_footer_wrapper">

	<div id="templatemo_footer">
    	Copyright © 2013 <a href="#">Patricio Quispe Sosa</a> - 
        Designed by <a href="http://www.templatemo.com" target="_parent">Free CSS Templates</a>
        <div class="cleaner"></div>
	</div>
    
</div>



</body>
</html>