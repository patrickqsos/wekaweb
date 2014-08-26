<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	
<script language="javascript" type="text/javascript">
$(function() {
	$( "#accordion" ).accordion({
		heightStyle: "content",
		//collapsible: true
		activate: function(event, ui) {
			var dataset = ui.newHeader.text();	
        	//alert(ui.newHeader.text());  // For instance.
			$.post("DatasetAdmin", {
                dataset: dataset,
                //instances : instances,
              },function(data){ 
                   alert(data);
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

$(function() {
	$( "#tabs" ).tabs();
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
        <ul>
            <li><a href="indexAdmin.jsp" >Home</a></li>
            <li><a href="<%=request.getContextPath()%>/DatasetAdmin?opcion=Cargar">Cargar </a></li>
            <li><a href="<%=request.getContextPath()%>/DatasetAdmin?opcion=Editar" class="current">Editar </a></li>
            <li><a href="<%=request.getContextPath()%>/DatasetAdmin?opcion=Eliminar">Eliminar </a></li>
            <li><a href="<%=request.getContextPath()%>/Logout">Datos usuario   Logout</a></li>
            
            
        </ul>    	
    </div> <!-- end of templatemo_menu -->     

	<div id="accordion">
		<c:forEach var="columnName" items="${datasets}">
					<h3>
						<c:out value="${columnName}"></c:out>
					</h3>
					
				</c:forEach>
	</div>
		
   
     
    
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