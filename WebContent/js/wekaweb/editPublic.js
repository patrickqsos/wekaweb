/**
 * 
 */
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
										/*
										"copy",
										
						            	{
						            		"sExtends":    "saveData",
						                	"sButtonText": "Guardar",
						                	"target":      "#"
						            	},
						            	*/
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
	               		
	               		/*
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
	               		
	               		*/
	               		
           				newForm += '<form role="form">';
	               		
	               		newForm += '<div class="alert alert-dismissible alert-danger hidden" role="alert" id="msgEditDataset">'+
						'<button id="btnClose" type="button" class="close" onclick="$(\'.alert\').addClass(\'hidden\')"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span id="message">message</span>'+
						'</div>';
						
	               		
	               		for(var j=0;j<json.dataset.header.attributes.length; j++){
	               			newForm += '<div class="form-group">';
	               			
	               			newForm += '<label for="inputAttr'+j+'">'+json.dataset.header.attributes[j].name+'</label>';
	           				
	               			switch(json.dataset.header.attributes[j].type){
	               			
	               			case 'nominal': 
	               				newForm += '<select id="inputAttr'+j+'" class="form-control input-sm" disabled>';
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
						'<button type="button" class="btn btn-success btn-sm btnAdd disabled">'+
						  '<span class="glyphicon glyphicon-plus"></span> Agregar'+
						'</button>'+
						'<button type="button" class="btn btn-primary btn-sm btnUpdate disabled">'+
						  '<span class="glyphicon glyphicon-refresh"></span> Actualizar'+
						'</button>'+
						'<button type="button" class="btn btn-danger btn-sm btnDelete disabled">'+
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
		