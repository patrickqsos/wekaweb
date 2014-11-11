/**
 * 
 */
		
	function countCheckbox(){
		var c=0;
		$("input:checkbox[name=attr]:checked").each(function(){
			c++;
		})
		if(c != 0)
		    $('#btnRemove').prop('disabled', false);
		else
		    $('#btnRemove').prop('disabled', true);
		
		return c;
		
	}
	$(document).ready(function() {
		
		$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	    });
			
		$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
			$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	    });
			
		$('#msgBox').hide();
		$('#msgGenerated').hide();
		
		$('#treeFilters').treeview({data: getTreeFilters(),levels:1,showTags: true});
		
		$('#treeDatasets').treeview({data: getTreeDatasets(),levels:2,showTags: true});
		
		$('#treeFilters').on('nodeSelected', function(event, node) {
		    
			var filter = node.className;
		    $('#inputFilter').val(filter);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'getFullInfoAlgoritmo',
           			algoritmo: filter,
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		$('#pnlInfoAlgoritmo').empty();
           	 		$('#pnlInfoAlgoritmo').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           	    },
           	 	success: function(data){
           	 		$('#pnlInfoAlgoritmo').empty();
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
		
		$('#treeAtributos').on('nodeSelected', function(event, node) {
			$.ajax({
           		type: 'post',
           		url: 'Dataset',
           		data: {
           			action: 'getInfoAttr',
           			attribute: node.text
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resultado del algoritmo
           	 		$('#pnlResult').empty();
           	 		$('#pnlResult').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           	 	},
           	 	success: function(json){
           	 		$('#pnlInfoAttribute').empty();
           	 		$('#tmplInfoAttribute').tmpl(json.statsCount).appendTo('#pnlInfoAttribute');
           	 		
           	 		//se llena la tabla que contienes a las instancias
           			var newTable = ' <table class="table table-condensed table-hover tableDT"><thead><tr>'; //start building a new table contents
           			for (var int = 0; int < json.statsTable.headerNames.length; int++) {
           				newTable += "<th>" + json.statsTable.headerNames[int] + "</th>";
               		}
           			newTable += "</tr></thead><tbody>";                  
					
           			switch (json.statsTable.type){
           			case 'nominal':
           				for (var int = 0; int < json.statsTable.values.length; int++) {
               			 	newTable += "<tr>";
               				for (var j = 0; j< json.statsTable.values[int].length; j++) {
                   				newTable += "<td>" + json.statsTable.values[int][j] + "</td>";
                   			}
               			 	newTable += "</tr>";
               			}
           				break;
           			case 'numeric':
           				
           				for (var key in json.statsTable.values) {
         					if (json.statsTable.values.hasOwnProperty(key)) {
           						newTable += "<tr>";
                 				newTable += "<td>"+key+"</td>";
                 				newTable += "<td>" + json.statsTable.values[key] + "</td>";
                     			newTable += "</tr>";
           				    }
         				}
           				break
           			default:
           				break;
           			}
           			
           			newTable += '</tbody></table>';
           			$('#pnlInfoAttribute').append(newTable);
           		},
           		error: function(data){
           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
					$('#messageGen').text(data.responseText);
					$('#msgGenerated').show();
					//$('#btnStart').button('reset');
				}
           	});
		});
		
		$('#treeDatasets').on('nodeSelected', function(event, node) {
		    
			var tree = getTreeFilters();
			var div = $('#treeFilters');
			
			var dataset = node.dataset;
		    $('#inputDataset').val(dataset);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		//dataType: 'JSON',
           		data: {
           			action: 'getCapAttr',
           			dataset: dataset,
           			tree: tree,
               	},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		$('#checkboxesAttr').empty();
           	    },
           	 	success: function(data){
           	 	 	for(var i=0;i<data.treeAttr.length;i++){
           	 			$('#checkboxesAttr').append();
           	 			var checkbox = '<div class="list-group-item cont">'+
        					'<input type="checkbox" name="attr" data-nodeid="'+i+'" value="'+data.treeAttr[i].text+'">'+
        				'</div>';
           	 			$('#checkboxesAttr').append(checkbox);
       	 			}
           	 		$('#treeAtributos').treeview({data: data.treeAttr,levels:1,showTags: true,selectedBackColor:"#80899B"});
    				$('#treeFilters').treeview({data: data.treeFilters,levels:2,showTags: true});
	    			
    				$('#btnImprimir').prop('disabled', true);
					$('#btnImportar').prop('disabled', true);
					$('#btnExportar').prop('disabled', true);
					
					$("input:checkbox[name=attr]").change(function(){
						countCheckbox();
					});
				
           	 	},
           		error: function(){
           			btn.button('reset');
		     	}
           	});
		    
		});
		
		
		$("input:checkbox[name=attr]").change(function(){
			alert('cheked');
		});
		
		$('#btnAll').click(function(){
			$("input:checkbox[name=attr]").each(function(){
				$(this).prop('checked','checked');
			});
			countCheckbox();
		});
		
		$('#btnNone').click(function(){
			$("input:checkbox[name=attr]").each(function(){
				$(this).prop('checked','');
			});
			countCheckbox();
		});
		
		$('#btnInvert').click(function(){
			$("input:checkbox[name=attr]").each(function(){
				($(this).prop('checked') ? $(this).prop('checked','') : $(this).prop('checked','checked') );
			});
			countCheckbox();
		});
		
		$('#btnPattern').click(function(){
			var attrToRemove = [];
			var checksToRemove = [];
			
			$('#treeAtributos > ul > li').each(function(){
				attrToRemove.push($(this).data("nodeid"));
			});
			
			$("input:checkbox[name=attr]:checked").each(function(){
				checksToRemove.push($(this).data("nodeid"))
				//attrToRemove.push($(this).val());
			});
			
			console.log(attrToRemove);
			console.log(checksToRemove);
			
		});
		
		$('#btnRemove').click(function(){
			
			$(this).button('loading');
			
			var countAttr = $('#treeAtributos > ul').find('li').length;
			var countCheck = countCheckbox();
			
			if(countAttr == countCheck){
				$('#message').text("No se puede eliminar todos los atributos");
				$('#msgBox').show();
				$('#btnRemove').button('reset');
			}
			else{
				
				var attrRemove = [];
				var attrToRemove = [];
				var checksToRemove = [];
				
				$('#treeAtributos > ul > li').each(function(){
					attrToRemove.push($(this).data("nodeid"));
				});
				
				$("input:checkbox[name=attr]:checked").each(function(){
					checksToRemove.push($(this).data("nodeid"))
					attrRemove.push($(this).val());
				})
				
				$.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		data: {
	           			action: 'deleteAttr',
	           			attrRemove: attrRemove,
	           		},
	           		beforeSend: function(){
	           			//vaciamos el div que contiene el resultado del algoritmo
	           	 		$('#pnlResult').empty();
	           	 		$('#pnlResult').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
	           	 	},
	           	 	success: function(data){
		           	 	$("input:checkbox[name=attr]:checked").each(function(){
		    				$(this).closest('.cont').remove();
		    			});
		           	 	
			            for(var i=0;i<checksToRemove.length;i++){
			           	 	$('#treeAtributos > ul > li').each(function(){
				 				$(this).data("nodeid") == checksToRemove[i] ? $(this).remove() : '';
				 			});
		           	 	}
	           	 		
			            $('#msgBox').removeClass( "alert-danger" ).addClass( "alert-success" );
						$('#message').text('El atributo fue removido');
						$('#msgBox').show();
						
						$('#btnRemove').prop('disabled', true);
						
			            $('#pnlResult').empty();
	       	        	$('#pnlResult').html("<pre>"+data+"</pre>");
			        	
			        	$('#btnImprimir').prop('disabled', false);
						$('#btnImportar').prop('disabled', false);
						$('#btnExportar').prop('disabled', false);
						
						$('#btnRemove').button('reset');
						
	           	 	},
	           		error: function(data){
	           			$('#msgBox').removeClass( "alert-success" ).addClass( "alert-danger" );
						$('#message').text(data.responseText);
						$('#msgBox').show();
						$('#btnRemove').button('reset');
					}
	           	});
			}
		});
		
		$('#btnApply').click(function () {
			var dataset = $('#inputDataset').val();
			var filter = $('#inputFilter').val();
			
			$(this).button('loading');
			
			if(filter == '' || dataset == '' ){
				$('#message').text("Selecciona un dataset y un filtro");
				$('#msgBox').show();
				$('#btnApply').button('reset');
			}
			
			else{
				$.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		//dataType: 'JSON',
	           		data: {
	           			action: 'filter',
	           			dataset: dataset,
	           			filter: filter,
	           		//	tree: JSON.stringify(tree),
	           		},
	           		beforeSend: function(){
	           			//vaciamos el div que contiene el resultado del algoritmo
	           	 		$('#pnlResult').empty();
	           	 		$('#pnlResult').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
	           	 	},
	           	 	success: function(data){
	           	 	 	$('#msgGenerated').removeClass( "alert-danger" ).addClass( "alert-success" );
						$('#messageGen').text(data);
						$('#msgGenerated').show();
						$('#btnApply').button('reset');
					},
	           		error: function(data){
	           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
						$('#messageGen').text(data.responseText);
						$('#msgGenerated').show();
						$('#btnApply').button('reset');
					}
	           	});
			}
		});	
		
		$('#btnImprimir').click(function(){
			window.print();  
		});
		
	});
