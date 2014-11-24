/**
 * 
 */

function getTree() {
    	var tree = [
    	            {
    	            text: "Associations", 
    	            selectable: false,
    	            nodes: [
    	            	{
    	            		text: "Aprior",
    	            		className: "weka.associations.Apriori",
    	            	}
    	            ]
    	            
    	            }
    	          ];
	    return tree;
	}
    
   	 	
	$(document).ready(function() {
		//$('#btnImprimir').disabled();
		
		//$('.collapse').collapse();
		
		$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	        });
			
		$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
			$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	    });
			
		$('#msgAlgoritmo').hide();
		$('#msgGenerated').hide();
		
		$('#treeAlgoritmos').treeview({data: getTree(),levels:2,showTags: true});
		
		$('#treeDatasets').treeview({data: getTreeDatasets(),levels:1,showTags: true});
		
		$('#treeAlgoritmos').on('nodeSelected', function(event, node) {
		    
			var algoritmo = node.className;
		    $('#inputAlgoritmo').val(algoritmo);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'getFullInfoAlgoritmo',
           			algoritmo: algoritmo,
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		$('#pnlInfoAlgoritmo').empty();
           	 		//$('#pnlData').empty();
       				$('#pnlInfoAlgoritmo').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           	    },
           	 	success: function(data){
           	 		$('#pnlInfoAlgoritmo').empty();
           	 		//$('#pnlData').empty();
       	        	//$('#tmplPnlInfoDataset').tmpl(data).appendTo('#pnlInfoDataset');
		        	//$('#tmplPnlData').tmpl(data).appendTo('#pnlData');
		        	//$('#pnlDataOutput').hide();
		        	$('#pnlInfoAlgoritmo').html(data);
		        
		        	
		        	
		        	$('#btnImprimir').prop('disabled', true);
					$('#btnImportar').prop('disabled', true);
					$('#btnExportar').prop('disabled', true);
					
           	 	},
           		error: function(){
           			btn.button('reset');
		     	}
           	});
		});
		
		$('#treeDatasets').on('nodeSelected', function(event, node) {
		    
			var algoritmos = [];
			var tree = getTree();
			var div = $('#treeAlgoritmos');
			var aux = $("#treeAlgoritmos").data("plugin_treeview");
			//console.log(aux);
			$.each(aux.nodes, function addNodes(id, node) {
				if(node.className != undefined)
					algoritmos.push(node.className);
			});

			
			//console.log(aux.nodes);
			console.log(algoritmos);
		    var dataset = node.dataset;
		    $('#inputDataset').val(dataset);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		//dataType: 'JSON',
           		data: {
           			action: 'getCapabilities',
           			dataset: dataset,
           			algoritmos: algoritmos,
           			tree: JSON.stringify(tree),
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		//$('#pnlInfoDataset').empty();
           	 		//$('#pnlData').empty();
       				//$('#pnlInfoDataset').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           	    },
           	 	success: function(data){
           	 	 	
           	 		$('#treeAlgoritmos').treeview({data: data,levels:2,showTags: true});
	    		
           	 		//$('#pnlInfoDataset').empty();
           	 		//$('#pnlResult').empty();
       	        	//$('#pnlDataOutput').html(data);
		        	
		        	$('#btnImprimir').prop('disabled', true);
					$('#btnImportar').prop('disabled', true);
					$('#btnExportar').prop('disabled', true);
					
           	 	},
           		error: function(){
           			btn.button('reset');
		     	}
           	});
		    
		});
		
		$('#btnStart').click(function () {
			var dataset = $('#inputDataset').val();
			var algoritmo = $('#inputAlgoritmo').val();
			
			$(this).button('loading');
			
			if(algoritmo == '' || dataset == '' ){
				$('#message').text("Selecciona un dataset y un algoritmo");
				$('#msgAlgoritmo').show();
				$('#btnStart').button('reset');
			}
			
			else{
				//alert($('#inputAlgoritmo').val() + ' '+$('#inputDataset').val())
				$.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		//dataType: 'JSON',
	           		data: {
	           			action: 'asociacion',
	           			dataset: dataset,
	           			algoritmo: algoritmo,
	           		//	tree: JSON.stringify(tree),
	           		},
	           		beforeSend: function(){
	           			//vaciamos el div que contiene el resultado del algoritmo
	           	 		$('#pnlResult').empty();
	           	 		$('#pnlResult').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
	           	 	},
	           	 	success: function(data){
	           	 	 	
	           	 		$('#pnlResult').empty();
	       	        	$('#pnlResult').html("<pre>"+data+"</pre>");
			        	
			        	$('#btnImprimir').prop('disabled', false);
						$('#btnImportar').prop('disabled', false);
						$('#btnExportar').prop('disabled', false);
						
						$('#btnStart').button('reset');
	           	 	},
	           		error: function(data){
	           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
						$('#messageGen').text(data.responseText);
						$('#msgGenerated').show();
						$('#btnStart').button('reset');
					}
	           	});
			}
		});	
		
		$('#btnImprimir').click(function(){
			window.print();  
		});
		
		$('#btnImportar').click(function(){
			var nombreDataset = $('#nombreDataset').val();
			var descDataset = $('#descDataset').val();
			$(this).button('loading');
			
			$.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'importGenerated',
           			nombreDataset: nombreDataset,
           			descDataset: descDataset,
           		},
           		beforeSend: function(){
           		},
           	 	success: function(data){
           	 		$('#msgGenerated').removeClass( "alert-danger" ).addClass( "alert-success" );
					$('#messageGen').text(data);
					$('#msgGenerated').show();
					$(this).button('reset');
					
				},
           		error: function(data){
           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
					$('#messageGen').text(data.responseText);
					$('#msgGenerated').show();
					$(this).button('reset');
					
           	 	}
           	});
		});
		
		$('.typeFile').on('click', function() {
			var flag = true;
			var messageError = '';
			var context =$('#context').val();
			$('#btnExportar').button('loading');
			var nombreArchivo = $('#nombreDataset').val();
			var extension = $(this).attr('id');
			
			
			if(flag){
				$.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		data: {
	           			action: 'export',
	           			typeExport: "generated",
	           			nombreArchivo: nombreArchivo,
	           			extension: extension,
	           		},
	           	 	success: function(response, status, request){
	           	 		var disp = request.getResponseHeader('Content-Disposition');
			        	
			        	if (disp && disp.search('attachment') != -1) {
			                var form = $('<form method="POST" action="'+context+'/Dataset">');
			                    form.append($('<input type="hidden" name="action" value="export">'));
			                    form.append($('<input type="hidden" name="typeExport" value="generated">'));
			                    form.append($('<input type="hidden" name="nombreArchivo" value="'+nombreArchivo+'">'));
			                    form.append($('<input type="hidden" name="extension" value="'+extension+'">'));
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