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
<script type="text/javascript">
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
        <ul>
            <li><a href="indexAdmin.jsp" >Home</a></li>
            <li><a href="<%=request.getContextPath()%>/DatasetAdmin?opcion=Cargar" class="current">Cargar </a></li>
            <li><a href="<%=request.getContextPath()%>/DatasetAdmin?opcion=Editar">Editar </a></li>
            <li><a href="<%=request.getContextPath()%>/DatasetAdmin?opcion=Eliminar">Eliminar </a></li>
            <li><a href="<%=request.getContextPath()%>/Logout">Datos usuario   Logout</a></li>
            
            
        </ul>    	
    </div> <!-- end of templatemo_menu -->     

        
    <div id="templatemo_middle">
    
    	 
		<div id="mid_title">Cargar dataset</div>
           
         <!-- 
        <form action="DatasetAdmin" enctype="multipart/form-data"  method="post">
			
			
			<input type="file" id="btnSubida" name ="btnSubida"/> 
			              	
			<input type="submit" name="submit" value="Cargar Dataset"/> 
		</form>
    	 --> 
    	 
    	<a id="btn-choose-image" class="active btng" onclick="togglePhotoPost(true)" style="display: inline-block;">Subir nuevo dataset</a>
			
			
    	<div id="upload-form" style="display:none">
          <form action="DatasetAdmin" method="post" enctype="multipart/form-data">
            <input id="input-file" class="inactive file btng" type="file" name="photo" onchange="onFileSelected()" />
            <textarea name="descripcion" placeholder="Escribir una descripcion"></textarea>
            <input id="btn-post" class="inactive btng" type="submit" value="Subir" disabled="disabled" />
            <a class="cancel" onclick="togglePhotoPost(false)">Cancelar</a>
          </form>
        </div>
        
    <div class="cleaner"></div>
        
	</div> <!-- end of middle -->
    
    
    
    
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