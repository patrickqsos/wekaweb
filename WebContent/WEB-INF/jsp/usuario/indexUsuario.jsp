<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html">
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
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
            <p>Un dataset es un conjunto de elementos de datos más o menos equivalente a una hoja de cálculo de dos dimensiones o una tabla de base de datos. En WEKA, es implementado por la clase weka.core.Instances. Un dataset es una colección de instancias, cada uno de la clase weka.core.Instance. Cada Instancia consta de un número de atributos, cualquiera de los cuales puede ser nominal (uno de una lista predefinida de valores), numérico (un número real o entero) o una cadena (una larga lista arbitraria de caracteres, encerrada en "comillas dobles"). Otros tipos son fecha y relacional</p>
            <hr>

            <h2 id="cntImportar">Importar</h2>
            <p>Nullam hendrerit justo non leo aliquet imperdiet. Etiam in sagittis lectus. Suspendisse ultrices placerat accumsan. Mauris quis dapibus orci. In dapibus velit blandit pharetra tincidunt. Quisque non sapien nec lacus condimentum facilisis ut iaculis enim. Sed viverra interdum bibendum. Donec ac sollicitudin dolor. Sed fringilla vitae lacus at rutrum. Phasellus congue vestibulum ligula sed consequat.</p>
            <hr>

            <h2 id="cntExportar">Exportar</h2>
            <p>Integer pulvinar leo id risus pellentesque vestibulum. Sed diam libero, sodales eget sapien vel, porttitor bibendum enim. Donec sed nibh vitae lorem porttitor blandit in nec ante. Pellentesque vitae metus ipsum. Phasellus sed nunc ac sem malesuada condimentum. Etiam in aliquam lectus. Nam vel sapien diam. Donec pharetra id arcu eget blandit. Proin imperdiet mattis augue in porttitor. Quisque tempus enim id lobortis feugiat. Suspendisse tincidunt risus quis dolor fringilla blandit. Ut sed sapien at purus lacinia porttitor. Nullam iaculis, felis a pretium ornare, dolor nisl semper tortor, vel sagittis lacus est consequat eros. Sed id pretium nisl. Curabitur dolor nisl, laoreet vitae aliquam id, tincidunt sit amet mauris.</p>
            <hr>

            <h2 id="cntGenerar">Generar</h2>
            <p>Integer pulvinar leo id risus pellentesque vestibulum. Sed diam libero, sodales eget sapien vel, porttitor bibendum enim. Donec sed nibh vitae lorem porttitor blandit in nec ante. Pellentesque vitae metus ipsum. Phasellus sed nunc ac sem malesuada condimentum. Etiam in aliquam lectus. Nam vel sapien diam. Donec pharetra id arcu eget blandit. Proin imperdiet mattis augue in porttitor. Quisque tempus enim id lobortis feugiat. Suspendisse tincidunt risus quis dolor fringilla blandit. Ut sed sapien at purus lacinia porttitor. Nullam iaculis, felis a pretium ornare, dolor nisl semper tortor, vel sagittis lacus est consequat eros. Sed id pretium nisl. Curabitur dolor nisl, laoreet vitae aliquam id, tincidunt sit amet mauris.</p>
            <hr>

            <h2 id="cntPreparar">Preparar</h2>
            <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
            <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
	        <hr>

            <h2 id="cntClasificacion">Clasificacion</h2>
            <p>Sed vitae lobortis diam, id molestie magna. Aliquam consequat ipsum quis est dictum ultrices. Aenean nibh velit, fringilla in diam id, blandit hendrerit lacus. Donec vehicula rutrum tellus eget fermentum. Pellentesque ac erat et arcu ornare tincidunt. Aliquam erat volutpat. Vivamus lobortis urna quis gravida semper. In condimentum, est a faucibus luctus, mi dolor cursus mi, id vehicula arcu risus a nibh. Pellentesque blandit sapien lacus, vel vehicula nunc feugiat sit amet.</p>

	        <h2 id="cntClustering">Clustering</h2>
            <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
            <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
            <hr>

            <h2 id="cntAsociacion">Asociacion</h2>
            <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
            <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
         
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