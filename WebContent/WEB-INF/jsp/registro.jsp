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

    <title>Registrarse - WWA</title>
	<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
  	<link href="css/bootstrap/jumbotron.css" rel="stylesheet">
	<script src="js/jquery-1.9.1.js"></script>
	
	<script type="text/javascript">
	
	
	$(document).ready(function() {
		$('#msgReg').hide();
		
		$('#formReg').submit(function(){
			event.preventDefault();
			var nombre = $('#inputNombre').val();
			var apellido = $('#inputApellido').val();
			var email = $('#inputEmail').val();
			var password = $('#inputPassword').val();
			var confirmPassword = $('#confirmPassword').val();
			
		    
		    $.ajax({
		    	type: 'post',
           		url: 'Registro',
           		data: {
           			action: 'altaUsuario',
           			nombre: nombre,
           			apellido: apellido,
           			email: email,
           			password: password,
           			confirmPassword: confirmPassword,
           		},
		    	
		        success: function(data) {
		        	$('#msgReg').removeClass( "alert-danger" ).addClass( "alert-success" );
		        	$('#message').text(data);
			        $('#msgReg').show();
		            $('#formReg').trigger("reset");
		           
		        },
		        error: function(data) {
		        	$('#msgReg').removeClass( "alert-success" ).addClass( "alert-danger" );
		        	$('#message').text(data.responseText);
		        	$('#msgReg').show();
		        },
		        
		    });
		});


	});
		
		
		
	</script>
   
     
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
          <a class="navbar-brand" href="<%=request.getContextPath()%>" style="display: inline-block;">Weka Web Application</a>
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
    		<h1 class="text-center" >Registro de usuarios</h1>
    	</div> 
    	<div class="row">
    		<div class="col-sm-8 col-sm-offset-2">
	    		<div class="alert alert-dismissible" role="alert" id="msgReg">
					  <button id="btnClose" type="button" class="close" onclick="$('.alert').hide()"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>
				</div>
					
    			<form id="formReg" role="form" data-toggle="validator" class="form-horizontal" >
    				<fieldset>
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="inputNombre">Nombre</label>
    						</div>
    						<div class="col-sm-8">
    							<input class="form-control" id="inputNombre" name="inputNombre" type="text" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div>
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="inputApellido" >Apellido</label>
    						</div>
    						<div class="col-sm-8">
    							<input class="form-control" id="inputApellido" name="inputApellido" type="text" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div>
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="inputEmail">Email</label>
    						</div>
    						<div class="col-sm-8">
    							<input value="dadelos-38@hotmail.com" class="form-control" id="inputEmail" name="inputEmail" type="email" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div>
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="inputPassword" >Password</label>
    						</div>
    						<div class="col-sm-8">
    							<input class="form-control" id="inputPassword" name="inputPassword" data-minlength="6" data-minlength-error="Su password debe contener un minimo de 6 caracteres" type="password" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div> 
    					<div class="form-group">
    						<div class="col-sm-4">
    							<label for="confirmPassword">Confirmar password</label>
    						</div>
    						<div class="col-sm-8">
    							<input class="form-control" id="confirmPassword" name="confirmPassword" data-match="#inputPassword" data-match-error="Los passwords no coinciden" type="password" required>
    							<div class="help-block with-errors"></div>
    						</div>
    					</div> 
    					<div class="form-group">
    						<div class="col-sm-12">
    							<input class="btn btn-lg btn-block btn-success" id="btnReg" name="submit" type="submit" value="Registrarse">
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
    <script src="js/validator.min.js"></script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
  </body>
</html>