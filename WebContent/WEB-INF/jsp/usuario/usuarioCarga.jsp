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

<link href="css/themes/base/jquery-ui.css" rel="stylesheet"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>
	
<script type="text/javascript">
$(function() {
	$( "#accordion" ).accordion({
		heightStyle: "content",
		//collapsible: true,
		activate: function(event, ui) {
			var dataset = ui.newHeader.text();	
        	//alert(ui.newHeader.text());  // For instance.
			$.post("DatasetAdmin", {
                dataset: dataset,
                //instances : instances,
              },function(data){ 
                   //alert(data);
            	  //
            	  /*$(this).closest("tr").remove();
            	  $('#result').append("<pre>"+data+"</pre>");
            	  //location.reload();
            	  //$("#"+id).remove();
            	  */
    			});
    	}
	});
});



function togglePhotoPost(expanded) {
	  onFileSelected();
	  if (expanded) {
	    document.getElementById("btn-choose-image").style.display="none";
	    document.getElementById("upload-form").style.display="block";
	  } else {
	    document.getElementById("btn-choose-image").style.display="inline-block";
	    document.getElementById("upload-form").style.display="none";
	  }
}
	
function onFileSelected() {
	  filename = document.getElementById("input-file").value;
	  if (filename == null || filename == "") {
	    document.getElementById("btn-post").setAttribute("class", "inactive btn");
	    document.getElementById("btn-post").disabled = true;
	  } else {
	    document.getElementById("btn-post").setAttribute("class", "active btn");
	    document.getElementById("btn-post").disabled = false;
	  }
}
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
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Cargar" class="current">Cargar </a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Preparar">Preparar datos</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Clustering">Clustering</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Asociacion">Asociacion</a></li>
            <li><a href="<%=request.getContextPath()%>/Logout"><jsp:getProperty property="email" name="usuarior"/> Logout</a></li>
        </ul>    	
    </div> <!-- end of templatemo_menu -->    

        
	<div id="templatemo_main"> 
		<div class="col_w300 float_l">
        	<h2>Tus datasets</h2>
        	<div id="accordion">
				<c:forEach var="data" items="${datasetsu}">
							<h3>
								<c:out value="${data.nombre}"></c:out>
							</h3>
							<div>
								<c:out value="${data.descripcion}"></c:out>
							</div>
						</c:forEach>
			</div>
     
        </div>
           
    	<div class="col_w620 float_r">
    	
			<h2>Cargar dataset</h2>
	           
	    	<a id="btn-choose-image" class="active btng" onclick="togglePhotoPost(true)" style="display: inline-block;">Subir nuevo dataset</a>
			
			<div id="upload-form" style="display:none">
	          <form action="UsuarioRegistrado" method="post" enctype="multipart/form-data">
	            <input id="input-file" class="inactive file btng" type="file" name="photo" onchange="onFileSelected()" />
	            <textarea name="descripcion" placeholder="Escribir una descripcion"></textarea>
	            <input type="hidden" id="idUsuario" name="idUsuario" value="<jsp:getProperty property="id" name="usuarior"/>" >
	            <input id="btn-post" class="inactive btng" type="submit" value="Subir" disabled="disabled" />
	            <a class="cancel" onclick="togglePhotoPost(false)">Cancelar</a>
	          </form>
	        </div>
	    </div>
        
    <div class="cleaner"></div>
        
	</div> <!-- end of main -->
    
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