/**
 * 
 */
		
function getTreeAlgoritmos() {
   		var tree = [
    	            {
    	            text: "Classifiers", 
    	            selectable: false,
    	            nodes: [
    	            	{
    	            	  subCategoria: "true",	
    	               	  text: "Bayes",
    	               	  selectable: false,
      	                  nodes: [
    	                    {
    	                      text: "BayesNet",
    	                      className: "weka.classifiers.bayes.BayesNet",
    	                    	//className: "weka.clusterers.Cobweb",
    	                    },
    	  				    {
      	                      text: "NaiveBayes",
      	                      className: "weka.classifiers.bayes.NaiveBayes",
      	                    },
      	  					{
      	                      text: "NaiveBayesMultinomial",
      	                      className: "weka.classifiers.bayes.NaiveBayesMultinomial",
      	                    },
      	  					{
      	                      text: "NaiveBayesMultinomialText",
      	                      className: "weka.classifiers.bayes.NaiveBayesMultinomialText",
      	                    },
      	  					{
      	                      text: "NaiveBayesMultinomialUpdateable",
      	                      className: "weka.classifiers.bayes.NaiveBayesMultinomialUpdateable",
      	                    },
      	  					{
      	                      text: "NaiveBayesUpdateable",
      	                      className: "weka.classifiers.bayes.NaiveBayesUpdateable",
      	                    },
    	                  ]
    	                },
    	                {
    	                	subCategoria: "true",	
      	               	  	text: "Functions",
    	                	selectable: false,
    	      	            nodes: [
        	      	        	{
        	      	            	text: "GaussianProcesses",
        	      	                className: "weka.classifiers.functions.GaussianProcesses",
        	      	            },
        	      	          	{
        	      	            	text: "LinearRegression",
        	      	                className: "weka.classifiers.functions.LinearRegression",
        	      	            },
        	      	          	{
        	      	            	text: "Logistic",
        	      	                className: "weka.classifiers.functions.Logistic",
        	      	            },
        	      	          	{
        	      	            	text: "MultilayerPerceptron",
        	      	                className: "weka.classifiers.functions.MultilayerPerceptron",
        	      	            },
        	      	          	{
        	      	            	text: "SGD",
        	      	                className: "weka.classifiers.functions.SGD",
        	      	            },
        	      	          	{
        	      	            	text: "SGDText",
        	      	                className: "weka.classifiers.functions.SGDText",
        	      	            },
        	      	          	{
        	      	            	text: "SimpleLinearRegression",
        	      	                className: "weka.classifiers.functions.SimpleLinearRegression",
        	      	            },
        	      	          	{
        	      	            	text: "SimpleLogistic",
        	      	                className: "weka.classifiers.functions.SimpleLogistic",
        	      	            },
        	      	          	{
        	      	            	text: "SMO",
        	      	                className: "weka.classifiers.functions.SMO",
        	      	            },
        	      	          	{
        	      	            	text: "SMOreg",
        	      	                className: "weka.classifiers.functions.SMOreg",
        	      	            },
        	      	          	{
        	      	            	text: "VotedPerceptron",
        	      	                className: "weka.classifiers.functions.VotedPerceptron",
        	      	            },
        	      	        ]
    	      	        },
    	      	      	{
    	      	       	  subCategoria: "true",	
      	               	  text: "Lazy",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                      text: "IBk",
	      	                      className: "weka.classifiers.lazy.IBk",
	      	                    },
	      	                    {
		      	                  text: "KStar",
		      	                  className: "weka.classifiers.lazy.KStar",
		      	                },
		      	                {
			      	              text: "LWL",
			      	              className: "weka.classifiers.lazy.LWL",
			      	            },
      	                  	  ]
      	                },
      	              	{
      	               	  subCategoria: "true",	
      	               	  text: "Meta",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                    	text: "AdaBoostM1",
	      	                    	className: "weka.classifiers.meta.AdaBoostM1",
	      	                    },
	      	                    {
	      	                    	text: "AdditiveRegression",
	      	                    	className: "weka.classifiers.meta.AdditiveRegression",
	      	                    },
	      	                  	{
	      	                    	text: "AttributeSelectedClassifier",
	      	                    	className: "weka.classifiers.meta.AttributeSelectedClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "Bagging",
	      	                    	className: "weka.classifiers.meta.Bagging",
	      	                    },
	      	                  	{
	      	                    	text: "ClassificationViaRegression",
	      	                    	className: "weka.classifiers.meta.ClassificationViaRegression",
	      	                    },
	      	                  	{
	      	                    	text: "CostSensitiveClassifier",
	      	                    	className: "weka.classifiers.meta.CostSensitiveClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "CVParameterSelection",
	      	                    	className: "weka.classifiers.meta.CVParameterSelection",
	      	                    },
	      	                  	{
	      	                    	text: "FilteredClassifier",
	      	                    	className: "weka.classifiers.meta.FilteredClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "LogitBoost",
	      	                    	className: "weka.classifiers.meta.LogitBoost",
	      	                    },
	      	                  	{
	      	                    	text: "MultiClassClassifier",
	      	                    	className: "weka.classifiers.meta.MultiClassClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "MultiClassClassifierUpdateable",
	      	                    	className: "weka.classifiers.meta.MultiClassClassifierUpdateable",
	      	                    },
	      	                  	{
	      	                    	text: "MultiScheme",
	      	                    	className: "weka.classifiers.meta.MultiScheme",
	      	                    },
	      	                  	{
	      	                    	text: "RandomCommittee",
	      	                    	className: "weka.classifiers.meta.RandomCommittee",
	      	                    },
	      	                  	{
	      	                    	text: "RandomizableFilteredClassifier",
	      	                    	className: "weka.classifiers.meta.RandomizableFilteredClassifier",
	      	                    },
	      	                  	{
	      	                    	text: "RandomSubSpace",
	      	                    	className: "weka.classifiers.meta.RandomSubSpace",
	      	                    },
	      	                  	{
	      	                    	text: "RegressionByDiscretization",
	      	                    	className: "weka.classifiers.meta.RegressionByDiscretization",
	      	                    },
	      	                  	{
	      	                    	text: "Stacking",
	      	                    	className: "weka.classifiers.meta.Stacking",
	      	                    },
	      	                  	{
	      	                    	text: "Vote",
	      	                    	className: "weka.classifiers.meta.Vote",
	      	                    },
	      	                  ]
      	                },
      	              	{
      	               	  subCategoria: "true",	
      	               	  text: "Misc",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                    	text: "InputMappedClassifier",
	      	                    	className: "weka.classifiers.misc.InputMappedClassifier",
	      	                    },
	      	                    {
		      	                    text: "InputMappedClassifier",
									className: "weka.classifiers.misc.InputMappedClassifier",
		      	                },
	      	                  ]
      	                },
      	              	{
      	               	  subCategoria: "true",	
      	               	  text: "Rules",
      	               	  selectable: false,
        	                  nodes: [
	      	                  	{
	      	                    	text: "DecisionTable",
	      	                    	className: "weka.classifiers.rules.DecisionTable",
	      	                    },
	      	                  	{
	      	                    	text: "JRip",
	      	                    	className: "weka.classifiers.rules.JRip",
	      	                    },
	      	                  	{
	      	                    	text: "M5Rules",
	      	                    	className: "weka.classifiers.rules.M5Rules",
	      	                    },
	      	                  	{
	      	                    	text: "OneR",
	      	                    	className: "weka.classifiers.rules.OneR",
	      	                    },
	      	                  	{
	      	                    	text: "PART",
	      	                    	className: "weka.classifiers.rules.PART",
	      	                    },
	      	                  	{
	      	                    	text: "ZeroR",
	      	                    	className: "weka.classifiers.rules.ZeroR",
	      	                    },
	      	                  ]
      	                },
      	             	{
      	                  subCategoria: "true",	
      	               	  text: "Trees",
      	               	  selectable: false,
        	                  nodes: [
	      	                    {
	      	                    	text: "DecisionStump",
	      	                    	className: "weka.classifiers.trees.DecisionStump",
	      	                    },
	      	                  	{
	      	                    	text: "HoeffdingTree",
	      	                    	className: "weka.classifiers.trees.HoeffdingTree",
	      	                    },
	      	                  	{
	      	                    	text: "J48",
	      	                    	className: "weka.classifiers.trees.J48",
	      	                    },
	      	                  	{
	      	                    	text: "LMT",
	      	                    	className: "weka.classifiers.trees.LMT",
	      	                    },
	      	                  	{
	      	                    	text: "M5P",
	      	                    	className: "weka.classifiers.trees.M5P",
	      	                    },
	      	                  	{
	      	                    	text: "RandomForest",
	      	                    	className: "weka.classifiers.trees.RandomForest",
	      	                    },
	      	                  	{
	      	                    	text: "REPTree",
	      	                    	className: "weka.classifiers.trees.REPTree",
	      	                    },
	      	                  ]
      	                },
    	              ]
    	            }
    	          ];
	    return tree;
	}
    
	
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
		
		$('#treeAlgoritmos').treeview({data: getTreeAlgoritmos(),levels:1,showTags: true});
		
		//$('#treeAtributos').treeview({data: getTreeAtributos(),levels:2,showTags: true});
		
		$('#treeDatasets').treeview({data: getTreeDatasets(),levels:2,showTags: true});
		
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
			//console.log(node.text);
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
		    
			var algoritmos = [];
			var tree = getTreeAlgoritmos();
			var div = $('#treeAlgoritmos');
			var aux = $("#treeAlgoritmos").data("plugin_treeview");
			$.each(aux.nodes, function addNodes(id, node) {
				if(node.className != undefined)
					algoritmos.push(node.className);
			});

			var dataset = node.dataset;
		    $('#inputDataset').val(dataset);
		    $.ajax({
           		type: 'post',
           		url: 'Dataset',
           		//dataType: 'JSON',
           		data: {
           			action: 'getCapAttr',
           			dataset: dataset,
           			algoritmos: algoritmos,
           			tree: JSON.stringify(tree),
           		},
           		beforeSend: function(){
           			//vaciamos el div que contiene el resumen del dataset
           	 		//$('#pnlInfoDataset').empty();
           	 		//$('#pnlData').empty();
       				//$('#pnlInfoDataset').append("<img src='images/loading2.gif' class='img-responsive center-block'/>");
           			
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
    				$('#treeAlgoritmos').treeview({data: data.treeAlgoritmos,levels:2,showTags: true});
	    			
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
	           			$('#msgGenerated').removeClass( "alert-success" ).addClass( "alert-danger" );
						$('#messageGen').text(data.responseText);
						$('#msgGenerated').show();
						$('#btnStart').button('reset');
						$('#btnRemove').button('reset');
						
					}
	           	});
			}
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
	           			action: 'clasificacion',
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
