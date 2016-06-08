$('document').ready(function(ready){

	$('body').on('click', '.comment_form_display a', function(event){
		event.preventDefault();
		var form = $(this).closest('.comment_form_display').find('.form_display');
		form.toggle();
	});

	$('body').on('click', '#new_comment .btn-success', function(event){
		$(this).closest('.form_display').hide(100, function(){
			$(this).find('#comment_content').val('');
		});
	});

});