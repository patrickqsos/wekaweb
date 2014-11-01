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