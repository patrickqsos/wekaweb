/**
 * 
 */

function getTree() {
    	var tree = [
    	            {
    	            text: "Classifiers", 
    	            selectable: false,
    	            nodes: [
    	            	{
    	               	  text: "Classification",
    	               	  selectable: false,
      	                  nodes: [
    	                    {
    	                      text: "Agrawal",
    	                      id: "Agrawal",
    	                      //tags: ['available'],
    	  				    },
    	                    {
    	                      text: "BayesNet",
    	                      id: "BayesNet",
    	    	            },
    	                    {
      	                      text: "LED24",
      	                      id: "LED24",
      	    	            },
    	                    {
      	                      text: "RandomRBF",
      	                      id: "RandomRBF",
      	    	            },
    	                    {
      	                      text: "RDG1",
      	                      id: "RDG1",
      	    	            }
    	                  ]
    	                },
    	                {
    	                	text: "Regression",
    	                	selectable: false,
    	      	            nodes: [
        	      	        	{
        	      	            	text: "Expression",
        	      	                id: "Expression",
        	      	            },
        	      	            {
        	      	            	text: "MexicanHat",
        	      	                id: "MexicanHat",
        	      	    	    }
        	      	        ]
    	      	        }
    	              ]
    	            },
    	            {
    	              text: "Clusterers",
    	              selectable: false,
	      	          nodes:[
    	            	{
    	            		text: "BIRCHCluster" ,
    	            		id: "BIRCHCluster" 
    	            	},
    	            	{
    	            		text: "SubspaceCluster",
    	            		id: "SubspaceCluster"
    	            	}
    	              ]
    	            }
    	          ];
	    return tree;
	}
    
	 	
	$(document).ready(function() {
		//$('#btnImprimir').disabled();
		
		$('.collapse').collapse();
		$('#msgAlgoritmo').hide();
		$('#msgGenerated').hide();
		
		$('#tree').treeview({data: getTree(),levels:2,showTags: true});
		
		$('#tree').on('nodeSelected', function(event, node) {
		    //alert(node.id);
		    var algoritmo = node.id;
		    $('#inputAlgoritmo').val(algoritmo);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'getInfoAlgoritmo',
           			algoritmo: algoritmo,
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		$('#pnlInfoDataset').empty();
           	 		$('#pnlData').empty();
       				$('#pnlInfoDataset').append("<img src='images/loading2.gif'/>");
           	    },
           	 	success: function(data){
           	 	 	$('#pnlInfoDataset').empty();
           	 		$('#pnlData').empty();
       	        	$('#tmplPnlInfoDataset').tmpl(data).appendTo('#pnlInfoDataset');
		        	$('#tmplPnlData').tmpl(data).appendTo('#pnlData');
		        	$('#pnlDataOutput').hide();
		        	$('#btnImprimir').prop('disabled', true);
					$('#btnImportar').prop('disabled', true);
					$('#btnExportar').prop('disabled', true);
           	 	},
           		error: function(){
           			btn.button('reset');
		     	}
           	});
		});
			
		
		$('#btnGenerar').click(function () {
			if($('#inputAlgoritmo').val() == ''){
				$('#message').text("Selecciona un algoritmo");
				$('#msgAlgoritmo').show();
			}
			$('#pnlDataOutput').show(); 
			$('#btnImprimir').prop('disabled', false);
			$('#btnImportar').prop('disabled', false);
			$('#btnExportar').prop('disabled', false);
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
	