jQuery.noConflict();

jQuery(document).ready(function(){

  jQuery("#show_filter").change(function(){
    window.location.href = "?show="+this.value;
  })

	// NOTES
	jQuery('.edit').editable('/lesite_projects/in_place_edit');
				
	// DEADLINE		
	jQuery("a.edit_deadline").click(function(){
		jQuery(this).next(".deadline_editor").show();
		jQuery(this).hide();
		jQuery(this).next(".deadline_editor").find('input').focus();
		return false;
	}) 
	
	jQuery(".close_deadline_editor").click(function(){
		jQuery(this).closest(".deadline_editor").hide();
		jQuery(this).closest(".deadline").find("a.edit_deadline").show();
		if( jQuery(this).hasClass("submit_new_deadline") ) {
			var val = jQuery(this).parent(".deadline_editor").find("input.deadline").val();
			var the_data = "id="+jQuery(this).attr('id')+"&value="+val;
			el = jQuery(this);
			jQuery.ajax({ 
				url: "/lesite_projects/in_place_edit", 
				type: "POST", 
				dataType: "text",
				data: the_data, 
				success: function(val) {
					el.closest(".deadline").find(".edit_deadline").html(val);
				}
				
			})
	  }
		
	})
				
})
