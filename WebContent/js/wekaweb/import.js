/**
 * 
 */

$(document).ready(function() {
			$('#uploadResult').hide();
			$('#uploadResultUrl').hide();
			
			$('#datasetList > .panel').on('show.bs.collapse', function (e) {
				$(this).removeClass( "panel-default" ).addClass( "panel-primary" );
	        });
			
			$('#datasetList > .panel').on('hide.bs.collapse', function (e) {
				$(this).removeClass( "panel-primary" ).addClass( "panel-default" );
	        });
				
			$('#form').submit(function(){
				event.preventDefault();
			
				var formData = new FormData();
			    formData.append('file', $('#uploadFile')[0].files[0]);
			    formData.append("descripcion", $('#descripcion').val());
			    formData.append("idUsuario", $('#idUsuario').val());
			    
			    var context = $("#context").val();
			    context += "/Dataset"; 
			    $("#files").append($("#fileUploadProgressTemplate").tmpl());
			    $("#fileUploadError").addClass("hide");
			    
			    $.ajax({
			        url: context,
			        type: 'POST',
			        xhr: function() {
			            var xhr = $.ajaxSettings.xhr();
			            if (xhr.upload) {
			                xhr.upload.addEventListener('progress', function(evt) {
			                    var percent = (evt.loaded / evt.total) * 100;
			                    $("#files").find(".progress-bar").width(percent + "%");
			                }, false);
			            }
			            return xhr;
			        },
			        success: function(data) {
			        	$('#uploadResult').removeClass( "alert-danger" ).addClass( "alert-success" );
			        	$('#message').text("El dataset se importo exitosamente");
				        $('#uploadResult').show();
			            $("#files").children().last().remove();
			            //$("#files").append($("#fileUploadItemTemplate").tmpl(data));
			            $("#uploadFile").closest("form").trigger("reset");
			            $('#datasetList .alert-warning').hide();
			        	$('#tmplDataset').tmpl(data).appendTo('#datasetList');
			        	//$('.collapse').collapse();
			        },
			        error: function(data) {
			        	$('#uploadResult').removeClass( "alert-success" ).addClass( "alert-danger" );
			        	$('#message').text(data.responseText);
			        	$('#uploadResult').show();
			            $("#files").children().last().remove();
			            $("#uploadFile").closest("form").trigger("reset");
			        },
			        data: formData,
			        cache: false,
			        contentType: false,
			        processData: false
			    }, 'json');
			});

			$("#inputUrl").blur(function(){
			    var url = $("#inputUrl").val();
			    var aux = url.split("/");
			    $("#nombreUrl").val(aux[aux.length - 1]);
			  });
			
			$('#importUrl').click(function () {
			    var btn = $(this)
			    btn.button('loading')
			    var nombre = $('#nombreUrl').val();
			    var descripcion = $('#descripcionUrl').val();
			    var url = $('#inputUrl').val();
			    var idUsuario = $('#idUsuario').val();
			    $.ajax({
	           		type: 'post',
	           		url: 'Dataset',
	           		data: {
	           			action: 'uploadUrl',
	           			nombre: nombre,
	           			descripcion: descripcion,
	           			url: url,
	           			idUsuario: idUsuario,
	           		},
	           	 	success: function(data){
	           			$('#uploadResultUrl').removeClass( "alert-danger" ).addClass( "alert-success" );
			        	$('#messageUrl').text("El dataset se importo exitosamente");
				        $('#uploadResultUrl').show();
			        	btn.button('reset');
			        	$('#nombreUrl').val('');
			        	$('#descripcionUrl').val('');
			        	$('#inputUrl').val('');
			        	$('#datasetList .alert-warning').hide();
			        	$('#tmplDataset').tmpl(data).appendTo('#datasetList');
	           		},
	           		error: function(){
	           			$('#uploadResultUrl').removeClass( "alert-success" ).addClass( "alert-danger" );
			        	$('#messageUrl').text("Hubo un problema con la carga del dataset. Vuelve a intentarlo" );
			        	$('#uploadResultUrl').show();
			        	btn.button('reset');
			   		}
	           	});
			  });

		});