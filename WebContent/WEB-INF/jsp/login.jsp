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

    <title>Iniciar sesion</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/bootstrap/jumbotron.css" rel="stylesheet">
	<link href="css/bootstrap/bootstrap-social.css" rel="stylesheet">
	<link href="css/bootstrap/font-awesome.css" rel="stylesheet">

	<script src="js/jquery-1.9.1.js"></script>
    <script src="js/wekaweb/login.js"></script>
    
    
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <img src='images/cloud3.png' class='img-responsive' style="float: left; width: 50px; display: inline-block;padding-right: 5px;"/>
          <a class="navbar-brand" href="<%=request.getContextPath()%>">Weka Web Application</a>
        </div>
        <div class="navbar-collapse collapse">
        	
        	<ul class="nav navbar-nav navbar-right">
        		<a class="btn btn-default navbar-btn" href="<%=request.getContextPath()%>/Registro">Registrarse</a>
				<a class="btn btn-success navbar-btn" href="<%=request.getContextPath()%>/Login">Iniciar sesion</a>
			</ul>
			
        </div><!--/.navbar-collapse -->
      </div>
    </div>

    
    <div class="container">
    	<div class="page-header">
    		<h1 class="text-center" >Iniciar sesion</h1>
    	</div> 
    	<div class="row">
    		<div class="col-sm-8 col-sm-offset-2">
    			
    			<c:choose>
			    	<c:when test="${empty msgLogin}">
			    	
					</c:when>
					<c:otherwise>
						<div class="alert alert-danger alert-dismissible" role="alert">
						  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
							<c:out value="${msgLogin}"></c:out>
						</div>
					</c:otherwise>
				</c:choose>
				
    			<form id="formLogin" role="form" data-toggle="validator" action="<%=request.getContextPath()%>/Login" class="form-horizontal"  method="post">
    				<fieldset>
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="inputEmail">Email</label>
    						</div>
    						<div class="col-sm-8">
    							<input class="form-control" id="inputEmail" name="inputEmail"  placeholder="alguien@ejemplo.com" type="email" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div>
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="inputPassword">Password</label>
    						</div>
    						<div class="col-sm-8">
    							<input class="form-control" id="inputPassword" name="inputPassword" placeholder="password" type="password" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div> 
    					<div class="form-group">
    						<div class="col-sm-12">
    							<input class="btn btn-lg btn-block btn-success" id="btnLogin" name="submit" type="submit" value="Iniciar sesion">
    							<p class="help-block famigo-help-block">¿No tienes una cuenta? <a href="<%=request.getContextPath()%>/Registro">Registrarse.</a></p>
    							<p class="help-block famigo-help-block">O inicia sesion con: <a id="fbLogin" href="<%=request.getContextPath()%>/Login?type=facebook" class="btn btn-social-icon btn-facebook"><i class="fa fa-facebook"></i></a>&nbsp;<a id="googleLogin" href="<%=request.getContextPath()%>/Login?type=google" class="btn btn-social-icon btn-google-plus"><i class="fa fa-google-plus"></i></a>&nbsp;<a href="<%=request.getContextPath()%>/Login?type=twitter" id="twitterLogin" class="btn btn-social-icon btn-twitter"><i class="fa fa-twitter"></i></a></p>
    							<!-- <p class="help-block famigo-help-block"><a href="/login/forgot/">Olvide mi password</a></p> -->
    						</div>
    					</div>
    				</fieldset>
    			</form>
    		</div>
    	</div>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> -->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/validator.min.js"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
  </body>
</html>