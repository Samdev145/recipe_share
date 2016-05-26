$('document').ready(function(ready){
	
	$('.new_step_button').click(function(){
			var new_step = $(this).closest('.new_step_fields').clone(true);
			new_step.find('input').val('');
			$(new_step).appendTo('.step_fields');
			$('.remove_step_button').show();
	});

	$('.remove_step_button').click(function(){
			var step_count = $('.remove_step_button').length;
			if (step_count > 1) {
				$(this).closest('.new_step_fields').remove();
			}
	});

});