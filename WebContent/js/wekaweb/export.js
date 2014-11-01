/**
 * 
 */

$(document).ready(function() {
			$('#msgExport').hide();
			
			$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	        });
			
			$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
				$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	        });
			
			$(".panel-heading").on('click', function() {
				var dataset = $(this).attr("data-target");
				dataset = dataset.replace('#','');
				$('#dataset').val(dataset);
				//var inputArchivo = $(this).text();
				$('#inputArchivo').val($('> .panel-title', this).text());
				$.ajax({
               		type: 'post',
               		url: 'Dataset',
               		data: {
               			action: 'getInfoDataset',
               			typeInfo: 'dataExport',
                        dataset:dataset,
               		},
               	 	beforeSend: function(){
               			//vaciamos el div que contiene el resumen del dataset
               	 		$('#pnlInfo').empty();
               			$('#pnlInfo').append("<img src='images/loading2.gif'/>");
               	    },
               		success: function(data){
               			$('#pnlInfo').empty(); 
               			$('#tmplPnlInfo').tmpl(data).appendTo('#pnlInfo');
               		},
               		error: function(){
               			$('#pnlInfo').html('Error en la carga del dataset...');
               		}
               	}); 	
			});
			
			$('.typeFile').on('click', function() {
				var flag = true;
				var messageError = '';
				var context =$('#context').val();
				$('#btnExportar').button('loading');
				//alert("exportando..."+$(this).attr('id'));
				var nombreArchivo = $('#inputArchivo').val();
				var dataset = $('#dataset').val();
				var extension = $(this).attr('id');
				
				if(dataset == ''){
					messageError+='Primero debe seleccionar un dataset'+'\n';
					flag = false;
		      	}
				
				if(nombreArchivo == ''){
					messageError+='El nombre del archivo no pueda estar vacio'+'\n';
		        	flag = false;
		      	}
				
				if(flag){
					$.ajax({
		           		type: 'post',
		           		url: 'Dataset',
		           		data: {
		           			action: 'export',
		           			typeExport: 'normal',
		           			typeInfo: 'dataExport',
		           			nombreArchivo: nombreArchivo,
		           			dataset: dataset,
		           			extension: extension,
		           		},
		           	 	success: function(response, status, request){
		           	 		var disp = request.getResponseHeader('Content-Disposition');
				        	
				        	if (disp && disp.search('attachment') != -1) {
				                var form = $('<form method="POST" action="'+context+'/Dataset">');
				                    form.append($('<input type="hidden" name="action" value="export">'));
				                    form.append($('<input type="hidden" name="typeExport" value="normal">'));
				                    form.append($('<input type="hidden" name="nombreArchivo" value="'+nombreArchivo+'">'));
				                    form.append($('<input type="hidden" name="extension" value="'+extension+'">'));
				            //        form.append($('<input type="hidden" name="dataset" value="'+dataset+'">'));
				                $('body').append(form);
				                form.submit();
				            }
				        	$('#btnExportar').button('reset');
						},
		           		error: function(){
		           			alert("error");
		           			$('#btnExportar').button('reset');
			       		}
		           	});
				}
				else{
					$('#msgExport').removeClass( "alert-success" ).addClass( "alert-danger" );
					$('#message').text(messageError);
		        	$('#msgExport').show();
		        	$('#btnExportar').button('reset');
			    }
			  });
		});