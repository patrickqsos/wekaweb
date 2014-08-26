<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Weka Web</title>
<meta name="keywords" content="free css templates, light gray, clean, simple, professional, CSS, HTML" />
<meta name="description" content="Light Gray - Free CSS Template from templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">

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
            <li><a href="indexUsuarioRegistrado.jsp" class="current">Home</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Cargar">Cargar </a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Preparar">Preparar datos</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Clustering">Clustering</a></li>
            <li><a href="<%=request.getContextPath()%>/UsuarioRegistrado?opcion=Asociacion">Asociacion</a></li>
            <li><a href="<%=request.getContextPath()%>/Logout"><jsp:getProperty property="email" name="usuarior"/> Logout</a></li>
        </ul>    	
    </div> <!-- end of templatemo_menu -->
        
    <div id="templatemo_middle">
    
    	<a href="http://www.templatemo.com/page/1" target="_parent"><img src="images/templatemo_icon.png" alt="Free Template" /></a>
        
		<div id="mid_title">Bienvenido(a): <jsp:getProperty property="nombre" name="usuarior"/> <jsp:getProperty property="apellido" name="usuarior"/> </div>
            
        <p>Aca podra realizar los procesos relacionados a la mineria de datos,almacenar sus propios datasets,editarlos,preprocesarlos,entrenarlos,extraer conocimiento</p>
    
    <div id="learn_more"><a href="#"></a></div>
        
    <div class="cleaner"></div>
        
	</div> <!-- end of middle -->
    
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